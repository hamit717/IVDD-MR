# Figure legends

> 图由 `scripts/step5_figures.R` 与 `scripts/step7_severity.R` 生成（300 dpi PNG，`results/figures/`）。
> 图注中的每一个数字都能在 `results/tables/` 里查到；**改图必须同步改这里**，图文不一致是最常见的返修理由。
> 投稿时按目标刊要求转成 TIFF/EPS，PNG 仅用于预印本与内部审阅。

---

## Figure 1

**Proteome-wide cis-Mendelian randomization of plasma proteins against three intervertebral disc phenotypes.**

Forest plot of the eleven protein–outcome associations that passed Bonferroni correction (P < 1.71 × 10⁻⁵) among 2,058 proteins with valid cis-pQTL instruments. Points show the Wald-ratio estimate of the log odds ratio per 1-SD genetically predicted increase in plasma protein level; horizontal bars are 95% confidence intervals. Colours denote the outcome: cervical disc disorder (17,993 cases; red), lumbar disc herniation (35,290 cases; blue) and surgically treated disc herniation (4,559 cases; green). Numeric OR (95% CI) values are given at the right. The dashed vertical line marks the null. Proteins reaching significance for more than one phenotype are labelled with the phenotype in parentheses. All estimates are derived from a single lead cis variant per protein; confidence intervals are therefore not adjusted for instrument selection.

---

## Figure 2

**Colocalization of plasma protein and disc disorder signals at five supported loci.**

For each protein–outcome pair, the left panel shows the cis-pQTL association (−log₁₀ *P*) and the right panel the corresponding outcome association (−log₁₀ *P*) across the ±1 Mb region surrounding the lead pQTL, plotted against chromosomal position (Mb, hg38). Each row is one pair: SCN4B (lumbar), CLPS (cervical), BMP6 (lumbar), DAG1 (lumbar) and DSG2 (lumbar), ordered as in Table 2. The horizontal dotted line marks genome-wide significance (P = 5 × 10⁻⁸). Posterior probabilities of a shared causal variant (PP.H4) and of two distinct causal variants (PP.H3) from `coloc.abf` at the default prior (p12 = 1 × 10⁻⁵) are annotated in the lower-left corner of each outcome panel. Variants were restricted to those present in both datasets after allele harmonisation (3,555–8,639 variants per pair); palindromic variants with allele frequency between 0.42 and 0.58 were removed.

---

## Figure 3

**Sensitivity of colocalization evidence to the prior probability of a shared causal variant.**

PP.H4 is plotted for each protein–outcome pair at three values of the `coloc.abf` prior p12 (1 × 10⁻⁶, 1 × 10⁻⁵, 1 × 10⁻⁴), connected within each pair. The dotted line at 0.8 marks the prespecified threshold for supportive evidence; the dashed line at 0.5 marks equipoisse between hypotheses. SCN4B and CLPS remain above 0.8 at all three priors; BMP6 exceeds 0.8 at the default and liberal priors; DAG1 and DSG2 reach the threshold only at p12 ≥ 1 × 10⁻⁵ and are therefore reported as moderate-confidence candidates. IGFBP3 remains below 0.2 at all priors, consistent with the two distinct causal variants indicated by its high PP.H3.

---

## Figure 4

**Cross-phenotype comparison of colocalization-supported proteins.**

Odds ratios (log scale) for cervical disc disorder (red), lumbar disc herniation (blue) and surgically treated disc herniation (green) per 1-SD genetically predicted protein level, shown for the five colocalization-supported proteins together with CHRDL1 (MR-level evidence only) and IGFBP3 (refuted by colocalization, shown for comparison). Horizontal bars are 95% confidence intervals. Because surgically treated cases are a subset of all lumbar disc herniation cases, the three estimates for a given protein are correlated and are compared descriptively rather than tested for between-group difference. DAG1 shows a monotonic decline in OR across increasing phenotypic severity (0.56 → 0.55 → 0.36); the confidence interval for the operated group (0.19–0.70) overlaps that of all lumbar herniation (0.43–0.71), so the gradient is a point-estimate trend and is interpreted as hypothesis-generating.

---

## Supplementary tables (for the legend list in the submission system)

| Item | Content |
|---|---|
| **Table S1** | Data sources: protein, UniProt ID, GWAS Catalog accession for the regional exposure statistics, FinnGen endpoint, case/control counts, and file checksums. |
| **Table S2** | Open Targets annotation of the ten Bonferroni-significant proteins: small-molecule and antibody tractability buckets, clinical-stage candidates, recorded safety liabilities, and associated diseases with association scores. |
| **Table S3** | Cross-endpoint effect estimates (OR, 95% CI, P) for all Bonferroni-significant proteins across the three FinnGen endpoints. |
