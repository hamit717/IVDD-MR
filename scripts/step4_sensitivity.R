#!/usr/bin/env Rscript
# ============================================================
# Step 4: 稳健性与方向性检验
#   4a. 共定位先验敏感性 (p12 = 1e-6 / 1e-5 / 1e-4)
#   4b. Steiger 方向性检验 (cis-pQTL 对暴露的解释力 vs 对结局)
#   4c. cis 区域双向 MR (反向 Wald ratio)
# 输出: results/coloc/coloc_sensitivity.tsv, results/mr/steiger.tsv, results/mr/reverse_mr.tsv
# ============================================================
.libPaths(c(path.expand("~/Rlibs"), .libPaths()))
suppressPackageStartupMessages({ library(data.table); library(coloc) })

proj <- "/Users/a1234/WorkBuddy/2026-11-07-22-16-25/IVDD-MR"
setwd(proj)
WIN <- 1e6
outdir <- "results/coloc"
windir <- "data/pqtl/windows"
dir.create(windir, showWarnings = FALSE, recursive = TRUE)

ep_n <- c(M13_CERVICDISC = 17993, M13_LUMBAR_PROLAPSE = 35290,
          M13_EARLY_LUMBAR_PROLAPSE = 4559)
N_CTRL <- 353224

map  <- fread("data/pqtl/protein_gcst_map.tsv")
inst <- fread("results/mr/instruments_cis_raw.tsv")
mr   <- fread("results/mr/mr_screen_all.tsv")
sig  <- unique(mr[bonf_sig == TRUE, .(assay_target, cis_gene)])

# ---- 暴露窗口缓存 ----
get_exposure <- function(prot) {
  cache <- file.path(windir, paste0(prot, ".tsv"))
  iv <- inst[assay_target == prot]
  lead <- iv[which.max(Fstat)]
  chrom <- as.integer(lead$chrom); pos <- as.numeric(lead$pos_hg38)
  lo <- max(1, pos - WIN); hi <- pos + WIN
  if (!file.exists(cache) || file.size(cache) < 1000) {
    url <- map[assay_target == prot, url][1]
    message("  下载窗口 ", prot, " chr", chrom, ":", lo, "-", hi)
    system2("python3", c("scripts/fetch_region.py", shQuote(url),
                         chrom, lo, hi, cache), stdout = FALSE, stderr = FALSE)
  }
  raw <- fread(cache, sep = "\t", quote = "")
  rs <- raw$rsid
  if ("rs_id" %in% names(raw)) rs <- ifelse(is.na(rs) | rs == "", raw$rs_id, rs)
  d <- data.table(SNP = rs, ea_ex = raw$effect_allele, oa_ex = raw$other_allele,
                  beta_ex = raw$beta, se_ex = raw$standard_error,
                  eaf_ex = raw$effect_allele_frequency, p_ex = raw$p_value,
                  n_ex = raw$n, pos = raw$base_pair_location, chrom = chrom)
  d <- d[!is.na(SNP) & SNP != ""]
  d[!duplicated(SNP)]
}

get_outcome <- function(ep, prot) {
  f <- file.path(outdir, paste0("outcome_", ep, ".tsv"))
  if (!file.exists(f)) return(NULL)
  raw <- fread(f, sep = "\t", quote = "")
  raw <- raw[protein == prot]
  if (nrow(raw) < 10) return(NULL)
  setnames(raw, gsub("^#", "", names(raw)))
  d <- raw[rsids != "" & !is.na(rsids),
           .(SNP = sub(",.*$", "", rsids), ea_ou = alt, oa_ou = ref, beta_ou = beta,
             se_ou = sebeta, eaf_ou = af_alt, p_ou = pval)]
  d[!duplicated(SNP)]
}

harmonise_pair <- function(ex, ou) {
  d <- merge(ex, ou, by = "SNP", suffixes = c("_ex", "_ou"))
  if (!nrow(d)) return(d)
  same <- toupper(d$ea_ex) == toupper(d$ea_ou) & toupper(d$oa_ex) == toupper(d$oa_ou)
  swap <- toupper(d$ea_ex) == toupper(d$oa_ou) & toupper(d$oa_ex) == toupper(d$ea_ou)
  d <- d[same | swap]
  if (!nrow(d)) return(d)
  fl <- toupper(d$ea_ex) == toupper(d$oa_ou) & toupper(d$oa_ex) == toupper(d$ea_ou)
  d[fl, `:=`(beta_ou = -beta_ou, eaf_ou = 1 - eaf_ou, ea_ou = ea_ex, oa_ou = oa_ex)]
  palin <- (toupper(d$ea_ex) %in% c("A","T") & toupper(d$oa_ex) %in% c("A","T")) |
           (toupper(d$ea_ex) %in% c("C","G") & toupper(d$oa_ex) %in% c("C","G"))
  d <- d[!palin | (abs(d$eaf_ex - 0.5) < 0.08 & abs(d$eaf_ou - 0.5) < 0.08)]
  d[!is.na(beta_ex) & !is.na(beta_ou) & se_ex > 0 & se_ou > 0]
}

sens <- list(); steig <- list(); revmr <- list()

for (i in seq_len(nrow(sig))) {
  prot <- sig$assay_target[i]; gene <- sig$cis_gene[i]
  if (!prot %in% map$assay_target) { message("[跳过] ", prot, " 无暴露数据"); next }
  message("\n[", prot, "]")
  ex <- tryCatch(get_exposure(prot), error = function(e) NULL)
  if (is.null(ex) || nrow(ex) < 100) { message("  暴露取数失败"); next }

  eps <- mr[bonf_sig == TRUE & assay_target == prot, unique(endpoint)]
  for (ep in eps) {
    ou <- get_outcome(ep, prot)
    if (is.null(ou)) { message("  跳过 ", ep, " 缺结局"); next }
    d <- harmonise_pair(ex, ou)
    if (nrow(d) < 10) { message("  跳过 ", ep, " 重叠", nrow(d)); next }

    nc <- ep_n[[ep]]; sfrac <- nc / (nc + N_CTRL)
    n_out <- nc + N_CTRL
    n_exp <- median(d$n_ex, na.rm = TRUE)
    if (is.na(n_exp)) n_exp <- 47745

    ds1 <- list(beta = d$beta_ex, varbeta = d$se_ex^2, snp = d$SNP, position = d$pos,
                type = "quant", sdY = 1, MAF = pmin(d$eaf_ex, 1 - d$eaf_ex), N = n_exp)
    ds2 <- list(beta = d$beta_ou, varbeta = d$se_ou^2, snp = d$SNP, type = "cc",
                s = sfrac, MAF = pmin(d$eaf_ou, 1 - d$eaf_ou), N = n_out)

    # ---------- 4a. p12 敏感性 ----------
    for (p12 in c(1e-6, 1e-5, 1e-4)) {
      r <- tryCatch(suppressMessages(coloc.abf(ds1, ds2, p12 = p12)),
                    error = function(e) NULL)
      if (is.null(r)) next
      pp <- as.list(r$summary)
      sens[[length(sens) + 1]] <- data.table(
        protein = prot, endpoint = ep, p12 = p12, n_snp = nrow(d),
        PP3 = pp$PP.H3.abf, PP4 = pp$PP.H4.abf)
    }

    # ---------- 4b. Steiger 方向性 ----------
    # r2 = 2*b^2*EAF*(1-EAF)；Fisher z 比较两个独立相关系数
    r2e <- 2 * d$beta_ex^2 * d$eaf_ex * (1 - d$eaf_ex)
    r2o <- 2 * d$beta_ou^2 * d$eaf_ou * (1 - d$eaf_ou)
    r2e[!is.na(r2e) & r2e > 1] <- 1
    r2o[!is.na(r2o) & r2o > 1] <- 1
    re <- sqrt(max(r2e, na.rm = TRUE)); ro <- sqrt(max(r2o, na.rm = TRUE))
    z1 <- atanh(min(re, 0.9999)); z2 <- atanh(min(ro, 0.9999))
    se_z <- sqrt(1 / (n_exp - 3) + 1 / (n_out - 3))
    zst <- (z1 - z2) / se_z
    steig[[length(steig) + 1]] <- data.table(
      protein = prot, endpoint = ep,
      r2_exposure = re^2, r2_outcome = ro^2,
      steiger_z = zst, steiger_p = 2 * pnorm(-abs(zst)),
      correct_direction = zst > 0, n_exp = n_exp, n_out = n_out)

    # ---------- 4c. cis 区域反向 MR ----------
    # 用结局在该区域的 GWS SNP 作为工具，Wald ratio 估计"结局→蛋白"
    gws <- d[p_ou < 5e-8 & p_ex < 0.05]
    if (nrow(gws) > 0) {
      g <- gws[which.min(p_ou)]
      b_rev <- g$beta_ex / g$beta_ou
      se_rev <- g$se_ex / abs(g$beta_ou)
      z_rev <- b_rev / se_rev
      revmr[[length(revmr) + 1]] <- data.table(
        protein = prot, endpoint = ep, snp = g$SNP,
        b_reverse = b_rev, se_reverse = se_rev,
        p_reverse = 2 * pnorm(-abs(z_rev)), n_gws = nrow(gws))
    }
  }
}

if (length(sens)) {
  s <- rbindlist(sens)
  w <- dcast(s, protein + endpoint + n_snp ~ paste0("PP4_p12_", p12), value.var = "PP4")
  fwrite(w, file.path(outdir, "coloc_sensitivity.tsv"), sep = "\t")
  cat("\n===== 4a 共定位 p12 敏感性 (PP.H4) =====\n"); print(w)
}
if (length(steig)) {
  st <- rbindlist(steig)
  fwrite(st, "results/mr/steiger.tsv", sep = "\t")
  cat("\n===== 4b Steiger 方向性 =====\n")
  print(st[, .(protein, endpoint, r2_exposure = round(r2_exposure, 4),
               r2_outcome = round(r2_outcome, 4),
               correct_direction, p = signif(steiger_p, 3))])
}
if (length(revmr)) {
  rv <- rbindlist(revmr)
  fwrite(rv, "results/mr/reverse_mr.tsv", sep = "\t")
  cat("\n===== 4c cis 区域反向 MR =====\n")
  print(rv[, .(protein, endpoint, snp, b_reverse = round(b_reverse, 3),
               p_reverse = signif(p_reverse, 3))])
}
