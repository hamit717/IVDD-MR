#!/usr/bin/env Rscript
# =============================================================
# 选题B · Step 2 v3: MR 初筛 (手写实现, 零 GitHub 依赖)
# 依赖: data.table / readxl (已装, 用户库 ~/Rlibs)
# 输入: results/mr/instruments_cis_raw.tsv (Step1 产物, 2058蛋白/2060 cis SNP)
#       data/finngen/finngen_R12_M13_*.gz
# 说明: ST10 为每蛋白-位点 lead SNP, 绝大多数蛋白=单 SNP → Wald ratio;
#       多 SNP 蛋白用 IVW/Egger/加权中位数 (暂以位置剪枝, 正式版换 1000G LD clump)
# 运行: R_LIBS_USER=~/Rlibs Rscript scripts/step2_mr_screen.R
# =============================================================

suppressPackageStartupMessages({library(data.table)})
ROOT <- "/Users/a1234/WorkBuddy/2026-11-07-22-16-25/IVDD-MR"
setwd(ROOT)
P_BONF <- 0.05 / 2923   # ≈1.71e-5, 保守校正(按全平台蛋白数)

ENDPOINTS <- c(
  cervical  = "M13_CERVICDISC",
  lumbar    = "M13_LUMBAR_PROLAPSE",
  op_lumbar = "M13_EARLY_LUMBAR_PROLAPSE"
)

iv <- fread("results/mr/instruments_cis_raw.tsv")
# variant_id 形如 CHROM:POS_hg37:A0:A1:imp:v1 → 提取效应等位 A1 / 其他 A0
iv[, a0 := sub("^[^:]+:[^:]+:([^:]+):([^:]+):[^:]+:[^:]+$", "\\1", variant_id)]
iv[, a1 := sub("^[^:]+:[^:]+:([^:]+):([^:]+):[^:]+:[^:]+$", "\\2", variant_id)]
# 暂行剪枝: 同蛋白同染色体上相距<1Mb 的 SNP 只留 p 最小者 (正式版换真 LD clump)
iv <- iv[order(protein_id, chrom, -pval)]
iv[, keep := seq_len(.N) == 1, by = .(protein_id, chrom, pos_hg38 %/% 1000000)]
message("剪枝后工具变量: ", sum(iv$keep), " SNP / ",
        uniqueN(iv[keep == TRUE]$protein_id), " 蛋白")
iv <- iv[keep == TRUE]

# ---- 手写 MR 核心函数 ----
harmonise <- function(d) {  # d: rsID, a0,a1, beta_exp,se_exp, ref,alt,beta_out,se_out
  d[, flip := fcase(toupper(a1) == toupper(alt), FALSE,
                    toupper(a0) == toupper(alt), TRUE, default = NA)]
  d <- d[!is.na(flip)]
  d[, beta_out_h := ifelse(flip, -beta_out, beta_out)]
  # 回文歧义 (A/T 或 C/G) 且 EAF 接近 0.5 → 剔除
  d[, a1u := toupper(a1)][, a0u := toupper(a0)]
  d[, palin := ((a1u == "A" & a0u == "T") | (a1u == "T" & a0u == "A") |
                (a1u == "C" & a0u == "G") | (a1u == "G" & a0u == "C")) & a1freq > 0.42]
  d[palin == FALSE]
}
wald <- function(b, se) c(b = b, se = se, z = b / se, p = pnorm(-abs(b / se)) * 2)
ivw_fit <- function(bx, by, sey) {  # IVW: 无截断加权回归
  w <- 1 / sey^2
  b <- sum(w * bx * by) / sum(w * bx^2)
  se <- sqrt(1 / sum(w * bx^2))
  Q <- sum(w * (by - b * bx)^2)
  c(b = b, se = se, z = b / se,
    p = pnorm(-abs(b / se)) * 2, Q = Q,
    Q_p = pchisq(Q, df = length(bx) - 1, lower.tail = FALSE))
}
egger_fit <- function(bx, by, sey) {
  w <- 1 / sey^2
  fit <- lm(by ~ bx, weights = w)
  c(b = unname(coef(fit)[2]), se = unname(summary(fit)$coef[2, 2]),
    z = unname(summary(fit)$coef[2, 3]),
    p = unname(summary(fit)$coef[2, 4]),
    intercept = unname(coef(fit)[1]),
    intercept_p = unname(summary(fit)$coef[1, 4]))
}
wmedian_fit <- function(bx, by, sey) {
  w <- 1 / sey^2
  theta <- by / bx
  ord <- order(theta)
  theta <- theta[ord]; w2 <- w[ord]; bx_o <- bx[ord]; by_o <- by[ord]
  cumw <- cumsum(w2) - 0.5 * w2
  idx <- which(cumw >= sum(w2) / 2)[1]
  b <- theta[idx]
  # SE via bootstrap-free delta (近似): 用 weighted median 的解析SE
  se <- sqrt(1 / sum(w2[bx_o^2 * (sign(bx_o) == sign(b))])) * ifelse(bx_o[idx] < 0, -1, 1)
  se <- abs(1 / sqrt(sum(w2 * bx_o^2)) ) * ifelse(bx_o[idx] < 0, -1, 1) * sign(b) * abs(bx_o[idx]) / abs(bx_o[idx])
  # 简化: 用 ivw 同权重近似SE
  se <- sqrt(1 / sum(w2 * bx_o^2)) / abs(bx_o[idx])
  c(b = b, se = se, z = b / se, p = pnorm(-abs(b / se)) * 2)
}

# ---- 逐端点处理 ----
run_endpoint <- function(ep_id) {
  gz <- file.path("data", "finngen", paste0("finngen_R12_", ep_id, ".gz"))
  ok <- file.exists(gz) && system(paste("gzip -t", shQuote(gz)),
                                  ignore.stdout = TRUE) == 0
  if (!ok) {  # 未下完/不完整则跳过
    message("  [跳过] ", ep_id, " (文件未就绪或不完整)")
    return(NULL)
  }
  message("  处理 ", ep_id, " ...")
  out <- fread(cmd = paste("gunzip -c", shQuote(gz)),
               select = c("rsids","ref","alt","beta","sebeta","pval"))
  setnames(out, c("rsids","beta","sebeta","pval"), c("rsID","beta_out","se_out","p_out"))
  m <- merge(iv, out[, .(rsID, ref, alt, beta_out, se_out, p_out)], by = "rsID")
  m <- harmonise(m)
  cat("    合并保留:", nrow(m), "SNP /", uniqueN(m$protein_id), "蛋白\n")

  res_list <- list()
  for (pid in unique(m$protein_id)) {
    d <- m[protein_id == pid]
    if (nrow(d) == 1) {
      # Wald ratio: b = beta_out/beta_exp, SE = se_out/|beta_exp|
      b <- d$beta_out_h / d$beta
      se <- d$se_out / abs(d$beta)
      res_list[[length(res_list) + 1]] <- data.table(
        protein_id = pid, assay_target = d$assay_target[1],
        uniprot = d$uniprot[1], cis_gene = d$cis_gene[1],
        endpoint = ep_id, n_snp = 1,
        b = d$beta_out_h / d$beta, se = se,
        p = pnorm(-abs((d$beta_out_h / d$beta) / se)) * 2,
        method = "Wald ratio", Q_p = NA_real_, egger_intercept_p = NA_real_)
    } else {
      fit <- ivw_fit(d$beta, d$beta_out_h, d$se_out)
      eg  <- tryCatch(egger_fit(d$beta, d$beta_out_h, d$se_out), error = function(e) NULL)
      res_list[[length(res_list) + 1]] <- data.table(
        protein_id = pid, assay_target = d$assay_target[1],
        uniprot = d$uniprot[1], cis_gene = d$cis_gene[1],
        endpoint = ep_id, n_snp = nrow(d),
        b = fit[["b"]], se = fit[["se"]], p = fit[["p"]],
        method = "IVW", Q_p = fit[["Q_p"]],
        egger_intercept_p = if (!is.null(eg)) eg[["intercept_p"]] else NA_real_)
    }
  }
  rbindlist(res_list)
}

message("[MR 初筛启动] ", date())
all_res <- lapply(ENDPOINTS, run_endpoint)
res <- rbindlist(all_res, fill = TRUE)
if (nrow(res) == 0) { message("无可用端点结果, 退出"); quit(save = "no") }

res[, or := exp(b)]
res[, bonf_sig := p < P_BONF]
setorder(res, endpoint, p)
fwrite(res, "results/mr/mr_screen_all.tsv")

cat("\n===== 初筛汇总 =====\n")
cat("Bonferroni 显著蛋白 (p <", P_BONF, "):\n")
print(res[bonf_sig == TRUE, .(endpoint, assay_target, cis_gene, n_snp, or, p, method)])
cat("\n各端点检验蛋白数:\n")
print(res[, .N, by = endpoint])
cat("\n显著结果明细已写入 results/mr/mr_screen_all.tsv\n")
