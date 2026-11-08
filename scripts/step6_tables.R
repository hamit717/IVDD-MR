#!/usr/bin/env Rscript
# ============================================================
# Step 6: 汇总发表级表格
#   Table1: MR 主结果
#   Table2: 共定位 + 敏感性 + Steiger + 成药性 主表
# ============================================================
.libPaths(c(path.expand("~/Rlibs"), .libPaths()))
suppressPackageStartupMessages(library(data.table))

proj <- "/Users/a1234/WorkBuddy/2026-11-07-22-16-25/IVDD-MR"
setwd(proj)
tdir <- "results/tables"; dir.create(tdir, showWarnings = FALSE)

mr   <- fread("results/mr/mr_screen_all.tsv")
cc   <- fread("results/coloc/coloc_results.tsv")
sens <- fread("results/coloc/coloc_sensitivity.tsv")
stg  <- fread("results/mr/steiger.tsv")
rev  <- if (file.exists("results/mr/reverse_mr.tsv")) fread("results/mr/reverse_mr.tsv") else NULL
tra  <- fread("results/tables/target_tractability.tsv")

ep_lab <- c(M13_CERVICDISC = "Cervical disc disorder",
            M13_LUMBAR_PROLAPSE = "Lumbar disc herniation",
            M13_EARLY_LUMBAR_PROLAPSE = "Surgically treated disc herniation")

# ---- Table 1: MR ----
t1 <- mr[bonf_sig == TRUE]
t1[, endpoint_label := ep_lab[endpoint]]
t1[, OR := exp(b)]
t1[, OR_CI := sprintf("%.2f (%.2f-%.2f)", exp(b), exp(b - 1.96 * se), exp(b + 1.96 * se))]
t1[, p_formatted := format.pval(p, digits = 2, eps = 1e-300)]
fwrite(t1[, .(Protein = assay_target, `UniProt ID` = uniprot, `cis gene` = cis_gene,
              Outcome = endpoint_label, `MR method` = method,
              `OR (95% CI)` = OR_CI, `P value` = p_formatted,
              `Bonferroni threshold` = "1.71e-5")],
       file.path(tdir, "Table1_MR_results.tsv"), sep = "\t")
cat("Table1: ", nrow(t1), "行\n")

# ---- Table 2: coloc 主表 ----
srange <- sens[, .(PP4_p12_1e_6 = `PP4_p12_1e-06`, PP4_p12_1e_5 = `PP4_p12_1e-05`,
                   PP4_p12_1e_4 = `PP4_p12_1e-04`),
               by = .(protein, endpoint)]
t2 <- merge(cc, srange, by.x = c("protein", "endpoint"), by.y = c("protein", "endpoint"), all.x = TRUE)
t2 <- merge(t2, stg[, .(protein, endpoint, r2_exposure, r2_outcome, correct_direction)],
            by = c("protein", "endpoint"), all.x = TRUE)
t2 <- merge(t2, tra[, .(symbol, tractability_SM, tractability_AB, n_clinical_candidates,
                        max_clinical_stage, n_safety_events)],
            by.x = "protein", by.y = "symbol", all.x = TRUE)
t2[, verdict := fcase(PP4 >= 0.9 & PP4_p12_1e_6 >= 0.8, "Strong (robust)",
                      PP4 >= 0.9, "Strong",
                      PP4 >= 0.8, "Moderate",
                      PP3 >= 0.8, "Distinct signals (H3)",
                      default = "Weak/insufficient")]
setorder(t2, -PP4)
fwrite(t2[, .(Protein = protein, Outcome = ep_lab[endpoint],
              `cis region` = sprintf("chr%d:%d", chrom, pos_hg38),
              N_SNP = n_snp,
              `PP.H4 (p12=1e-6)` = round(PP4_p12_1e_6, 3),
              `PP.H4 (p12=1e-5)` = round(PP4_p12_1e_5, 3),
              `PP.H4 (p12=1e-4)` = round(PP4_p12_1e_4, 3),
              PP.H3 = round(PP3, 3),
              `Steiger direction` = ifelse(correct_direction, "pQTL->IVDD", "IVDD->pQTL"),
              `Tractability (SM)` = tractability_SM,
              `Tractability (AB)` = tractability_AB,
              `Clinical candidates` = n_clinical_candidates,
              `Safety liabilities` = n_safety_events,
              Verdict = verdict)],
       file.path(tdir, "Table2_coloc_evidence.tsv"), sep = "\t")
cat("Table2: ", nrow(t2), "行\n")

# ---- 控制台预览 ----
cat("\n===== Table2 预览 =====\n")
print(t2[, .(protein, endpoint = ep_lab[endpoint],
             PP4 = round(PP4, 3), verdict)])
