#!/usr/bin/env Rscript
# ============================================================
# Step 3: 共定位分析 (coloc.abf)
# 暴露: UKB-PPP cis-pQTL（GWAS Catalog harmonised hg38），按索引只取窗口
# 结局: FinnGen R12（已抽取的窗口文件 results/coloc/outcome_<ep>.tsv）
# ============================================================
.libPaths(c(path.expand("~/Rlibs"), .libPaths()))
suppressPackageStartupMessages({ library(data.table); library(coloc) })

proj   <- "/Users/a1234/WorkBuddy/2026-11-07-22-16-25/IVDD-MR"
setwd(proj)
WIN <- 1e6; P12 <- 1e-5
outdir <- "results/coloc"

ep_n <- c(M13_CERVICDISC = 17993, M13_LUMBAR_PROLAPSE = 35290,
          M13_EARLY_LUMBAR_PROLAPSE = 4559)
N_CTRL <- 353224

map <- fread("data/pqtl/protein_gcst_map.tsv")   # assay_target, gcst, url

inst <- fread("results/mr/instruments_cis_raw.tsv")
mr   <- fread("results/mr/mr_screen_all.tsv")
sig  <- unique(mr[bonf_sig == TRUE, .(assay_target, cis_gene)])

harmonise_pair <- function(ex, ou) {
  d <- merge(ex, ou, by = "SNP", suffixes = c("_ex", "_ou"))
  same  <- toupper(d$ea_ex) == toupper(d$ea_ou) & toupper(d$oa_ex) == toupper(d$oa_ou)
  swap  <- toupper(d$ea_ex) == toupper(d$oa_ou) & toupper(d$oa_ex) == toupper(d$ea_ou)
  d <- d[same | swap]
  fl <- toupper(d$ea_ex) == toupper(d$oa_ou) & toupper(d$oa_ex) == toupper(d$ea_ou)
  d[fl, `:=`(beta_ou = -beta_ou, eaf_ou = 1 - eaf_ou, ea_ou = ea_ex, oa_ou = oa_ex)]
  # 回文位点：等位基因频率应接近 0.5，偏离过多者视为链方向歧义，剔除
  palin <- (toupper(d$ea_ex) %in% c("A","T") & toupper(d$oa_ex) %in% c("A","T")) |
           (toupper(d$ea_ex) %in% c("C","G") & toupper(d$oa_ex) %in% c("C","G"))
  d <- d[!palin | (abs(d$eaf_ex - 0.5) < 0.08 & abs(d$eaf_ou - 0.5) < 0.08)]
  d[!is.na(beta_ex) & !is.na(beta_ou) & se_ex > 0 & se_ou > 0]
}

results <- list()

for (i in seq_len(nrow(sig))) {
  prot <- sig$assay_target[i]; gene <- sig$cis_gene[i]
  iv <- inst[assay_target == prot]
  if (!nrow(iv) || !prot %in% map$assay_target) { message("[跳过] ", prot, " 缺工具变量或映射"); next }

  lead  <- iv[which.max(Fstat)]
  chrom <- as.integer(lead$chrom); pos <- as.numeric(lead$pos_hg38)
  lo <- max(1, pos - WIN); hi <- pos + WIN

  url <- map[assay_target == prot, url][1]
  tmp <- tempfile(fileext = ".tsv")
  message("\n[", prot, "] 取暴露窗口 chr", chrom, ":", lo, "-", hi)
  st <- system2("python3", c("scripts/fetch_region.py", shQuote(url),
                             chrom, lo, hi, tmp), stdout = FALSE, stderr = TRUE)
  if (!file.exists(tmp)) { message("  暴露取数失败: ", paste(st, collapse = " ")); next }

  ex_raw <- fread(tmp, sep = "\t", quote = "")
  rs <- ex_raw$rsid
  if ("rs_id" %in% names(ex_raw)) rs <- ifelse(is.na(rs) | rs == "", ex_raw$rs_id, rs)
  ex <- data.table(SNP = rs, ea_ex = ex_raw$effect_allele, oa_ex = ex_raw$other_allele,
                   beta_ex = ex_raw$beta, se_ex = ex_raw$standard_error,
                   eaf_ex = ex_raw$effect_allele_frequency, p_ex = ex_raw$p_value,
                   n_ex = ex_raw$n, pos = ex_raw$base_pair_location)
  ex <- ex[!is.na(SNP) & SNP != "", ]
  ex <- ex[!duplicated(SNP)]
  message("  暴露变异数: ", nrow(ex))

  eps <- mr[bonf_sig == TRUE & assay_target == prot, unique(endpoint)]
  for (ep in eps) {
    f <- file.path(outdir, paste0("outcome_", ep, ".tsv"))
    if (!file.exists(f)) { message("  [跳过] 缺 ", f); next }
    ou_raw <- fread(f, sep = "\t", quote = "")
    ou_raw <- ou_raw[protein == prot]
    if (nrow(ou_raw) < 10) { message("  [跳过] ", ep, " 窗口变异不足"); next }
    setnames(ou_raw, gsub("^#", "", names(ou_raw)))
    ou <- ou_raw[rsids != "" & !is.na(rsids),
                 .(SNP = sub(",.*$", "", rsids), ea_ou = alt, oa_ou = ref, beta_ou = beta,
                   se_ou = sebeta, eaf_ou = af_alt, p_ou = pval)]
    ou <- ou[!duplicated(SNP)]

    d <- harmonise_pair(ex, ou)
    if (nrow(d) < 10) { message("  [跳过] ", ep, " 重叠SNP=", nrow(d)); next }

    nc <- ep_n[[ep]]; s <- nc / (nc + N_CTRL)
    r <- tryCatch(coloc.abf(
      dataset1 = list(beta = d$beta_ex, varbeta = d$se_ex^2, snp = d$SNP,
                      position = d$pos, type = "quant", sdY = 1,
                      MAF = pmin(d$eaf_ex, 1 - d$eaf_ex), N = median(d$n_ex, na.rm = TRUE)),
      dataset2 = list(beta = d$beta_ou, varbeta = d$se_ou^2, snp = d$SNP,
                      type = "cc", s = s, MAF = pmin(d$eaf_ou, 1 - d$eaf_ou),
                      N = nc + N_CTRL),
      p12 = P12), error = function(e) { message("  coloc 失败: ", conditionMessage(e)); NULL })
    if (is.null(r)) next
    pp <- as.list(r$summary)
    top <- r$results$snp[which.max(r$results$SNP.PP.H4)]
    results[[length(results) + 1]] <- data.table(
      protein = prot, cis_gene = gene, endpoint = ep, chrom = chrom, pos_hg38 = pos,
      n_snp = nrow(d), PP0 = pp$PP.H0.abf, PP1 = pp$PP.H1.abf, PP2 = pp$PP.H2.abf,
      PP3 = pp$PP.H3.abf, PP4 = pp$PP.H4.abf, top_snp = top)
    message(sprintf("  [%s] PP.H4=%.3f  PP.H3=%.3f  n=%d", ep, pp$PP.H4.abf, pp$PP.H3.abf, nrow(d)))
  }
  unlink(tmp)
}

if (length(results)) {
  res <- rbindlist(results)
  fwrite(res, file.path(outdir, "coloc_results.tsv"), sep = "\t")
  cat("\n===== 共定位汇总 =====\n")
  print(res[order(-PP4), .(protein, endpoint, n_snp, PP3 = round(PP3, 3), PP4 = round(PP4, 3))])
} else message("无结果")
