#!/usr/bin/env Rscript
# ============================================================
# Step 7: 严重度分层与跨端点一致性
#   同一蛋白在 颈椎 / 腰椎全部 / 腰椎手术 三个端点上的效应比较
#   注：手术组病例是腰椎全体的子集，两组非独立，差异检验仅作描述性参考
# ============================================================
.libPaths(c(path.expand("~/Rlibs"), .libPaths()))
suppressPackageStartupMessages(library(data.table))

proj <- "/Users/a1234/WorkBuddy/2026-11-07-22-16-25/IVDD-MR"
setwd(proj)
figdir <- "results/figures"; tdir <- "results/tables"

mr <- fread("results/mr/mr_screen_all.tsv")
cc <- fread("results/coloc/coloc_results.tsv")

ep_lab <- c(M13_CERVICDISC = "Cervical disc\ndisorder",
            M13_LUMBAR_PROLAPSE = "Lumbar disc\nherniation (all)",
            M13_EARLY_LUMBAR_PROLAPSE = "Surgically treated\nlumbar herniation")

keep <- c("BMP6", "CHRDL1", "DAG1", "DSG2", "SCN4B", "CLPS", "HLA-E", "MST1", "KHK", "IGFBP3")
d <- mr[assay_target %in% keep & endpoint %in% names(ep_lab)]
d[, ep_label := ep_lab[endpoint]]
d[, OR := exp(b)]
d[, lo := exp(b - 1.96 * se)]
d[, hi := exp(b + 1.96 * se)]

# ---- 附表: 跨端点矩阵 ----
w <- dcast(d, assay_target ~ endpoint, value.var = "OR")
for (ep in names(ep_lab)) {
  pcol <- paste0("P_", ep)
  w <- merge(w, dcast(d[endpoint == ep], assay_target ~ ., value.var = "p"), by = "assay_target")
  setnames(w, ".", pcol)
}
setnames(w, c("M13_CERVICDISC", "M13_LUMBAR_PROLAPSE", "M13_EARLY_LUMBAR_PROLAPSE"),
         c("OR_cervical", "OR_lumbar_all", "OR_lumbar_surgical"), skip_absent = TRUE)
# 严重度梯度 = 手术组 logOR - 腰椎全体 logOR
lg <- dcast(d, assay_target ~ endpoint, value.var = "b")
lg[, severity_delta := M13_EARLY_LUMBAR_PROLAPSE - M13_LUMBAR_PROLAPSE]
w <- merge(w, lg[, .(assay_target, severity_delta)], by = "assay_target")
# 共定位状态
coloc_status <- unique(cc[, .(assay_target = protein, PP4_max = PP4)][order(-PP4_max), .SD[1], by = assay_target])
w <- merge(w, coloc_status, by = "assay_target", all.x = TRUE)
w[, coloc_support := fifelse(is.na(PP4_max), "not tested",
                      fifelse(PP4_max >= 0.8, "supported", "not supported"))]
setorder(w, -OR_lumbar_all)
fwrite(w, file.path(tdir, "TableS3_cross_endpoint.tsv"), sep = "\t")
cat("TableS3 已保存\n")
print(w[, .(assay_target, OR_cervical = round(OR_cervical, 2),
            OR_lumbar_all = round(OR_lumbar_all, 2),
            OR_lumbar_surgical = round(OR_lumbar_surgical, 2),
            severity_delta = round(severity_delta, 3), coloc_support)])

# ---- 图: 跨端点效应点图 ----
setorder(d, assay_target, endpoint)
prots <- w[order(-OR_lumbar_all), assay_target]
png(file.path(figdir, "Fig4_cross_endpoint.png"), width = 2200, height = 2000, res = 300)
par(mar = c(4, 8, 2.5, 5), family = "sans")
cols <- c("#C0392B", "#2471A3", "#1E8449")
xr <- range(c(d$lo, d$hi), na.rm = TRUE)
plot(NA, xlim = xr, ylim = c(0.4, length(prots) + 1.1), log = "x",
     yaxt = "n", xlab = "OR for disc disorder per SD increase in genetically predicted protein level",
     ylab = "", bty = "l", cex.lab = 0.8)
abline(v = 1, lty = 2, col = "grey50")
for (i in seq_along(prots)) {
  y0 <- length(prots) - i + 1
  sub <- d[assay_target == prots[i]]
  off <- c(M13_CERVICDISC = 0.22, M13_LUMBAR_PROLAPSE = 0, M13_EARLY_LUMBAR_PROLAPSE = -0.22)
  for (j in seq_len(nrow(sub))) {
    yy <- y0 + off[[sub$endpoint[j]]]
    segments(sub$lo[j], yy, sub$hi[j], yy, col = cols[match(sub$endpoint[j], names(ep_lab))], lwd = 1.6)
    points(sub$OR[j], yy, pch = 21, bg = cols[match(sub$endpoint[j], names(ep_lab))],
           col = "grey20", cex = 1.1)
  }
}
axis(2, at = rev(seq_along(prots)), labels = prots, las = 1, cex.axis = 0.8, tick = FALSE)
mtext("OR (95% CI)", side = 4, line = 0.5, at = length(prots) + 0.6, las = 1, cex = 0.7)
legend("bottomright", legend = gsub("\n", " ", ep_lab), pt.bg = cols, pch = 21,
       col = "grey20", bty = "n", cex = 0.62)
dev.off()
cat("Fig4 完成\n")
