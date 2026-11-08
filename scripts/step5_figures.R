#!/usr/bin/env Rscript
# ============================================================
# Step 5: 发表级图表
#   Fig1 森林图: 三表型显著蛋白 MR 效应
#   Fig2 共定位区域图: 暴露 pQTL vs 结局，5 对支持性证据
#   Fig3 p12 敏感性
# 输出: results/figures/*.png (300 dpi)
# ============================================================
.libPaths(c(path.expand("~/Rlibs"), .libPaths()))
suppressPackageStartupMessages({ library(data.table) })

proj <- "/Users/a1234/WorkBuddy/2026-11-07-22-16-25/IVDD-MR"
setwd(proj)
figdir <- "results/figures"; dir.create(figdir, showWarnings = FALSE)
WIN <- 1e6
ep_n <- c(M13_CERVICDISC = 17993, M13_LUMBAR_PROLAPSE = 35290,
          M13_EARLY_LUMBAR_PROLAPSE = 4559)
N_CTRL <- 353224
ep_lab <- c(M13_CERVICDISC = "Cervical disc disorder",
            M13_LUMBAR_PROLAPSE = "Lumbar disc herniation",
            M13_EARLY_LUMBAR_PROLAPSE = "Surgically treated\ndisc herniation")

mr  <- fread("results/mr/mr_screen_all.tsv")
map <- fread("data/pqtl/protein_gcst_map.tsv")
inst <- fread("results/mr/instruments_cis_raw.tsv")

# ---------------- Fig 1: 森林图 ----------------
d <- mr[bonf_sig == TRUE]
d[, endpoint := factor(endpoint, levels = names(ep_lab))]
setorder(d, endpoint, -b)
# 标签只用蛋白名（表型用颜色区分）；同一蛋白多表型时加后缀
d[, label := assay_target]
dup <- d[, .N, by = assay_target][N > 1, assay_target]
for (p0 in dup) {
  idx <- which(d$assay_target == p0)
  eps <- as.character(d$endpoint[idx])
  short <- c(M13_CERVICDISC = " (cervical)", M13_LUMBAR_PROLAPSE = " (lumbar)",
             M13_EARLY_LUMBAR_PROLAPSE = " (surgical)")[eps]
  d$label[idx] <- paste0(p0, short)
}
d[, yi := b]; d[, sei := se]

png(file.path(figdir, "Fig1_forest_MR.png"), width = 2600, height = 1700, res = 300)
par(mar = c(4.5, 7.5, 3, 8), family = "sans")
n <- nrow(d)
cols <- c("#C0392B", "#2471A3", "#1E8449")[as.integer(d$endpoint)]
xr <- max(d$b + 2.2 * d$se)
plot(NA, xlim = c(min(d$b - 2.2 * d$se) - 0.05, xr + 0.28),
     ylim = c(0.5, n + 1.2), yaxt = "n", xlab = "MR estimate (log OR) per SD increase in protein level",
     ylab = "", bty = "l", cex.lab = 1)
abline(v = 0, lty = 2, col = "grey50")
segments(d$b - 1.96 * d$se, n:1, d$b + 1.96 * d$se, n:1, col = cols, lwd = 1.8)
points(d$b, n:1, pch = 15, cex = 1.3, col = cols)
axis(2, at = n:1, labels = d$label, las = 1, cex.axis = 0.8, tick = FALSE)
for (i in seq_len(n)) {
  txt <- sprintf("%.2f (%.2f-%.2f)", exp(d$b[i]), exp(d$b[i] - 1.96 * d$se[i]), exp(d$b[i] + 1.96 * d$se[i]))
  mtext(txt, side = 4, at = n - i + 1, line = 0.5, las = 1, cex = 0.62)
}
mtext("OR (95% CI)", side = 4, line = 3.2, at = n + 0.8, las = 1, cex = 0.75)
legend("topleft", legend = c("Cervical disc disorder (n=17,993)",
                             "Lumbar disc herniation (n=35,290)",
                             "Surgically treated (n=4,559)"),
       col = c("#C0392B", "#2471A3", "#1E8449"), pch = 15, bty = "n", cex = 0.62)
dev.off()
cat("Fig1 完成\n")

# ---------------- Fig 2: 共定位区域图 ----------------
pairs <- list(
  list(prot = "SCN4B", ep = "M13_LUMBAR_PROLAPSE"),
  list(prot = "CLPS",  ep = "M13_CERVICDISC"),
  list(prot = "BMP6",  ep = "M13_LUMBAR_PROLAPSE"),
  list(prot = "DAG1",  ep = "M13_LUMBAR_PROLAPSE"),
  list(prot = "DSG2",  ep = "M13_LUMBAR_PROLAPSE")
)
cc <- fread("results/coloc/coloc_results.tsv")

harmonise_pair <- function(ex, ou) {
  d <- merge(ex, ou, by = "SNP")
  same <- toupper(d$ea_ex) == toupper(d$ea_ou) & toupper(d$oa_ex) == toupper(d$oa_ou)
  swap <- toupper(d$ea_ex) == toupper(d$oa_ou) & toupper(d$oa_ex) == toupper(d$ea_ou)
  d <- d[same | swap]
  fl <- toupper(d$ea_ex) == toupper(d$oa_ou) & toupper(d$oa_ex) == toupper(d$ea_ou)
  d[fl, `:=`(beta_ou = -beta_ou, eaf_ou = 1 - eaf_ou)]
  palin <- (toupper(d$ea_ex) %in% c("A","T") & toupper(d$oa_ex) %in% c("A","T")) |
           (toupper(d$ea_ex) %in% c("C","G") & toupper(d$oa_ex) %in% c("C","G"))
  d <- d[!palin | (abs(d$eaf_ex - 0.5) < 0.08 & abs(d$eaf_ou - 0.5) < 0.08)]
  d[!is.na(beta_ex) & !is.na(beta_ou)]
}

png(file.path(figdir, "Fig2_coloc_loci.png"), width = 3000, height = 3000, res = 300)
par(mfrow = c(5, 2), mar = c(3.2, 3.6, 1.8, 0.8), oma = c(1.5, 1, 2, 1), family = "sans")
for (p in pairs) {
  ex_file <- file.path("data/pqtl/windows", paste0(p$prot, ".tsv"))
  ou_file <- file.path("results/coloc", paste0("outcome_", p$ep, ".tsv"))
  if (!file.exists(ex_file) || !file.exists(ou_file)) { plot.new(); next }
  exr <- fread(ex_file, sep = "\t", quote = "")
  rs <- exr$rsid; if ("rs_id" %in% names(exr)) rs <- ifelse(is.na(rs) | rs == "", exr$rs_id, rs)
  ex <- data.table(SNP = rs, ea_ex = exr$effect_allele, oa_ex = exr$other_allele,
                   beta_ex = exr$beta, se_ex = exr$standard_error,
                   eaf_ex = exr$effect_allele_frequency, p_ex = exr$p_value,
                   pos = exr$base_pair_location)[!is.na(SNP) & SNP != ""]
  our <- fread(ou_file, sep = "\t", quote = ""); our <- our[protein == p$prot]
  setnames(our, gsub("^#", "", names(our)))
  ou <- our[rsids != "" & !is.na(rsids),
            .(SNP = sub(",.*$", "", rsids), ea_ou = alt, oa_ou = ref,
              beta_ou = beta, se_ou = sebeta, eaf_ou = af_alt, p_ou = pval)][!duplicated(SNP)]
  dd <- harmonise_pair(ex, ou)
  if (nrow(dd) < 50) { plot.new(); next }
  pp4 <- cc[protein == p$prot & endpoint == p$ep, PP4]
  pp3 <- cc[protein == p$prot & endpoint == p$ep, PP3]
  pos_mb <- dd$pos / 1e6
  for (k in 1:2) {
    pv <- if (k == 1) dd$p_ex else dd$p_ou
    y <- -log10(pmax(pv, 1e-300))
    plot(pos_mb, y, pch = 20, cex = 0.45, col = if (k == 1) "#2E86C1" else "#C0392B",
         xlab = "", ylab = "", main = "", bty = "l", cex.axis = 0.7)
    if (k == 1) mtext(p$prot, side = 3, line = 0.4, cex = 0.72, font = 2)
    if (k == 1) mtext("pQTL", side = 3, line = 0.4, at = par("usr")[2], adj = 1, cex = 0.55)
    if (k == 2) mtext(ep_lab[[p$ep]], side = 3, line = 0.4, at = par("usr")[2], adj = 1, cex = 0.55)
    abline(h = -log10(5e-8), lty = 3, col = "grey40")
    if (k == 2) {
      mtext(sprintf("PP.H4=%.2f  PP.H3=%.2f", pp4, pp3), side = 3, line = 0.4,
            at = par("usr")[1], adj = 0, cex = 0.5)
    }
  }
}
mtext("Position on chromosome (Mb)", side = 1, outer = TRUE, line = 0, cex = 0.75)
mtext("-log10(P)", side = 2, outer = TRUE, line = 0, cex = 0.75)
dev.off()
cat("Fig2 完成\n")

# ---------------- Fig 3: p12 敏感性 ----------------
st <- fread("results/coloc/coloc_sensitivity.tsv")
if (file.exists("results/coloc/coloc_sensitivity.tsv")) {
  long <- melt(st, id.vars = c("protein", "endpoint", "n_snp"),
               variable.name = "p12", value.name = "PP4")
  long[, p12 := as.numeric(gsub("PP4_p12_", "", p12))]
  long[, lab := paste0(protein, " / ", ep_lab[endpoint])]
  long[, lab := gsub("\n", " ", lab)]
  labs <- unique(long[order(-PP4), lab])
  long[, lab := factor(lab, levels = rev(labs))]
  png(file.path(figdir, "Fig3_p12_sensitivity.png"), width = 2200, height = 1600, res = 300)
  par(mar = c(4, 12, 2.5, 3), family = "sans")
  plot(NA, xlim = c(min(long$PP4), 1.02), ylim = c(0.5, length(labs) + 0.5),
       yaxt = "n", xlab = "Posterior probability of shared causal variant (PP.H4)",
       ylab = "", bty = "l", cex.lab = 0.85)
  abline(v = c(0.5, 0.8), lty = c(3, 2), col = "grey55")
  cols <- c("#F5B041", "#2E86C1", "#1E8449")
  for (i in seq_along(labs)) {
    sub <- long[lab == labs[i]]
    sub <- sub[order(sub$p12)]
    lines(sub$PP4, rep(i, nrow(sub)), col = "grey75", lwd = 1)
    points(sub$PP4, rep(i, nrow(sub)), pch = 21, bg = cols, col = "grey20", cex = 1.1)
  }
  axis(2, at = seq_along(labs), labels = labs, las = 1, cex.axis = 0.65, tick = FALSE)
  legend("topright", inset = c(0, 0.01), legend = c("p12 = 1e-6", "p12 = 1e-5", "p12 = 1e-4"),
         pch = 21, pt.bg = cols, col = "grey20", bty = "n", cex = 0.7)
  dev.off()
  cat("Fig3 完成\n")
}
