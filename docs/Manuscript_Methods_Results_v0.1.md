# Manuscript Draft v0.1 — Abstract, Methods & Results (English)

> 状态：v0.2，数字全部来自实际运行结果（2026-11-08）。
> 未清项以 **[TODO]** 标注（投稿前需清零，清单见 `TODO_before_submission.md`）。目标期刊：Arthritis Research & Therapy / The Spine Journal / Osteoarthritis and Cartilage。
> 标题、作者、单位已移到 `docs/TitlePage_v1.0.md`；本文件从 Abstract 开始，不再维护标题块（组装脚本已跳过本文件标题）。

---

## Abstract

**Background**: Intervertebral disc degeneration (IVDD) lacks disease-modifying drugs. Plasma proteomics linked to genetics can prioritize drug targets.
**Methods**: We performed proteome-wide Mendelian randomization (MR) of 2,058 circulating proteins (cis-pQTL instruments, all F-statistic >10) against three imaging-independent clinical endpoints in FinnGen release 12: cervical disc disorder (17,993 cases), lumbar disc prolapse (35,290 cases), and operated lumbar disc prolapse (4,559 cases). Bonferroni significance was defined at P < 1.71×10⁻⁵. Candidate proteins were interrogated with Bayesian colocalization (coloc.abf), prior-sensitivity analyses, and Steiger directionality, and annotated for tractability using Open Targets.
**Results**: Eleven protein–outcome associations passed Bonferroni correction (10 unique proteins). Colocalization supported a shared causal variant for five proteins: SCN4B (lumbar, PP.H4 = 0.997), CLPS (cervical, PP.H4 = 0.978), BMP6 (lumbar, PP.H4 = 0.944), DAG1 (lumbar, PP.H4 = 0.852) and DSG2 (lumbar, PP.H4 = 0.837). Notably, CLPS was the only protein associated with cervical disc disorder, and none overlapped with lumbar signals, indicating site-specific plasma protein signatures. Among supported proteins, DAG1 showed a monotonic severity gradient (OR 0.55 in all lumbar herniation vs 0.36 in surgically treated disease). The MR signal for IGFBP3, previously implicated by severity-graded associations, was attributed to distinct nearby signals (PP.H3 up to 0.97) rather than colocalization. No clinical-stage drug candidates exist for the supported targets.
**Conclusions**: Genetically supported plasma proteins prioritise two coherent target sets for lumbar disc herniation — a BMP-axis ligand/antagonist pair (BMP6, CHRDL1) and a mechanotransduction cluster (DAG1, DSG2, SCN4B) whose protection strengthens with surgical severity — and a metabolically oriented, site-specific signal for cervical disc disorder (CLPS) that does not overlap with the lumbar signature. The strongest MR signal in the dataset (IGFBP3) did not survive colocalization, indicating that MR-based target studies in this field require colocalization to be interpretable.

---

## Methods

### Study design overview
Three-stage design: (1) proteome-wide cis-MR screen against three clinical endpoints; (2) Bayesian colocalization with prior-sensitivity analysis for Bonferroni-significant proteins; (3) directionality testing and target tractability annotation.

### Exposure data: circulating protein quantitative trait loci
Genetic instruments for plasma protein levels were derived from UK Biobank Pharma Proteomics Project (UKB-PPP) Olink data. Lead cis-acting protein quantitative trait loci (pQTL) were extracted from the genome-wide significant association summary (Sun et al., Nature 2023, Supplementary Table 10; merged discovery and replication cohorts, n = 54,219), restricted to cis-acting variants as annotated in that table. Proteins with at least one genome-wide significant cis variant (P < 5×10⁻⁸) and F-statistic ≥ 10 were retained, yielding instruments for 2,058 unique proteins (2,060 protein–variant pairs; F-statistic 45.4–37,472, median 938.9). Each protein was instrumented by its single strongest cis variant.

For colocalization, full regional summary statistics for candidate proteins were obtained from the harmonised European-ancestry UK Biobank Olink re-analysis by Loya et al. (Nat Genet 2025; variational inference mixed model, n = 47,745; GWAS Catalog accessions in Supplementary Table S1). The re-analysis was used in preference to the original UKB-PPP release because harmonised hg38 summary statistics with public tabix indexes are available for it, which permits region-level retrieval; it covers the same cohort at higher power.

### Outcome data: FinnGen R12 disc disorder endpoints
Summary statistics for three musculoskeletal endpoints were downloaded from FinnGen release 12 (R12). Official phenotype labels and case counts were verified against the FinnGen endpoint API (accessed 2026-11-08):
- **M13_CERVICDISC** — "Cervical disc disorders": 17,993 cases / 353,224 controls;
- **M13_LUMBAR_PROLAPSE** — "Lumbar disc prolapse": 35,290 cases / 353,224 controls;
- **M13_EARLY_LUMBAR_PROLAPSE** — "Early lumbar disc prolapse, operated": 4,559 cases / 353,224 controls.

The third endpoint is defined by operation rather than by diagnosis alone and was used as the severity anchor: an ICD-coded diagnosis records contact with specialist care, whereas a recorded disc operation identifies disease severe enough to be treated surgically. Its official label carries an "early" qualifier that is not defined in the endpoint metadata; we therefore identify the endpoint by its official label and treat "operated" as its operative content (see Limitations).

### Mendelian randomization
Because UKB-PPP cis instruments each comprised a single lead variant per protein, causal estimates were obtained as Wald ratios. Effect alleles were aligned across exposure and outcome; palindromic variants with allele frequency >0.42 were removed. Bonferroni correction was applied over the full 2,923-protein panel (α = 0.05/2,923 = 1.71×10⁻⁵), which is more stringent than correction over the 2,058 proteins with valid instruments (2.43×10⁻⁵); the more conservative threshold is reported throughout.

### Colocalization
Bayesian colocalization (coloc.abf) was performed for each Bonferroni-significant protein–outcome pair using all harmonised variants within ±1 Mb of the lead pQTL (region overlap after allele alignment: 3,555–8,639 variants per pair). The default prior for a shared causal variant (p12) was 1×10⁻⁵; sensitivity analyses were run at 1×10⁻⁶ and 1×10⁻⁴. Colocalization was declared supportive when PP.H4 ≥ 0.8.

### Directionality and sensitivity analyses
Steiger directionality filtering compared variance explained in exposure versus outcome (r² = 2β²·EAF(1−EAF); Fisher z-test). Because the outcome is binary, variance explained on the observed scale was approximated using the case–control ratio, and because this approximation is crude for log-OR estimates the Steiger results are reported as directional support rather than as formal hypothesis tests. Because all instruments were single-variant cis signals, reverse MR was restricted to the cis region and is reported descriptively.

### Target annotation
Target tractability, clinical-stage drug candidates and safety liabilities were retrieved from the Open Targets Platform via its GraphQL API (queried 2026-11-08).

### Software
All analyses used R 4.4.1 (2024-06-14) with coloc 5.2.3, data.table 1.18.4 and readxl 1.5.0. Regional summary-statistics extraction used custom Python tooling that reads remote tabix indexes and retrieves only the BGZF blocks spanning each region, rather than downloading full summary-statistic files. Analysis code, intermediate summary tables and figure-generating scripts are available at **[TODO: repository URL — https://github.com/&lt;account&gt;/IVDD-MR]**, with a frozen release archived at submission.

---

## Results

### Proteome-wide MR identifies 11 Bonferroni-significant protein–outcome associations
Of 2,058 proteins with valid cis instruments, 11 tests involving 10 unique proteins passed Bonferroni correction (P < 1.71×10⁻⁵; Figure 1, Table 1). For lumbar disc herniation (35,290 cases), nine proteins were significant: IGFBP3 (OR 1.13, 95% CI 1.09–1.18; P = 8.7×10⁻¹²), BMP6 (OR 1.34, 1.19–1.50), HLA-E (OR 1.19, 1.11–1.26), CHRDL1 (OR 0.89, 0.85–0.93), SCN4B (OR 1.07, 1.04–1.09), KHK (OR 1.10, 1.05–1.14), MST1 (OR 1.03, 1.02–1.05), DSG2 (OR 0.84, 0.78–0.91) and DAG1 (OR 0.55, 0.43–0.71). For surgically treated disc herniation, only IGFBP3 was significant (OR 1.30, 1.18–1.43). For cervical disc disorder, CLPS was the sole significant protein (OR 0.91, 0.87–0.95).

**Key observation**: the cervical and lumbar protein signatures were entirely non-overlapping.

### Colocalization supports five protein–outcome pairs and refutes IGFBP3
coloc.abf over the ±1 Mb regions supported a shared causal variant for five pairs (Figure 2, Table 2): SCN4B–lumbar (PP.H4 = 0.997), CLPS–cervical (PP.H4 = 0.978), BMP6–lumbar (PP.H4 = 0.944), DAG1–lumbar (PP.H4 = 0.852) and DSG2–lumbar (PP.H4 = 0.837).

For IGFBP3, despite the strongest MR signal and its severity-graded association, colocalization was decisively negative (PP.H4 = 0.025 lumbar; 0.135 surgical; PP.H3 = 0.87–0.97): the pQTL lead variant (chr7:45,915,430) and the outcome association peak (chr7:45,994,425) were 73 kb apart, consistent with two distinct causal variants. The IGFBP3 MR association is therefore most plausibly explained by linkage rather than a protein-mediated effect, and it was excluded from target prioritization. MST1 had insufficient overlapping variants (n = 527) for reliable colocalization and was also excluded. Three proteins could not be tested: HLA-E and KHK lack publicly available full regional summary statistics, and the CHRDL1 lead pQTL (rs5942957, chrX:110,535,177) lies on the X chromosome, which is absent from the harmonised exposure files used for regional analysis — a limitation shared with most pQTL resources. CHRDL1 is therefore reported at the MR level only, with its direction (OR 0.89, 0.85–0.93) interpreted in the context of BMP6.

### Sensitivity analyses
PP.H4 estimates were robust to the colocalization prior for SCN4B (0.973–0.9997) and CLPS (0.818–0.998) across p12 = 1×10⁻⁶ to 1×10⁻⁴, and supportive for BMP6 (0.627–0.994). DAG1 and DSG2 reached PP.H4 ≥ 0.83 only at more liberal priors (1×10⁻⁵ and 1×10⁻⁴) and are interpreted as moderate-confidence candidates (Figure 3).

Steiger directionality was consistent with protein → disease for all eight tested pairs (r²_exposure > r²_outcome in every case; e.g., SCN4B r² = 0.109 vs 0.0008). As set out in Methods, the binary-outcome variance approximation makes these results directional support rather than formal tests of causal direction.

### Cross-endpoint consistency and severity stratification
We compared effect estimates across the three endpoints (Figure 4, Supplementary Table S3; the surgical cases are a subset of all lumbar herniation, so group-level comparisons are descriptive rather than independent tests). Two patterns emerged among colocalization-supported proteins:

- **DAG1 showed a monotonic severity gradient**: OR 0.56 (cervical), 0.55 (all lumbar prolapse), 0.36 (operated; 95% CI 0.19–0.70; nominal P = 2.6×10⁻³) — the protective effect strengthened with operation-managed disease, although the operated confidence interval overlaps the all-lumbar estimate, so this is a point-estimate trend rather than a demonstrated between-group difference. A similar direction was seen for DSG2 (0.95 → 0.84 → 0.79) and CHRDL1 (0.90 → 0.89 → 0.84), while BMP6 (1.11 → 1.34 → 1.35) and HLA-E (1.14 → 1.19 → 1.27) strengthened in the opposite (risk-increasing) direction.
- **CLPS was cervical-specific**: OR 0.91 (cervical, Bonferroni-significant) versus 0.97 (all lumbar, P = 0.062) and 0.99 (surgical, P = 0.74).

This severity-stratified pattern among colocalization-supported proteins contrasts with IGFBP3, whose gradient (1.13 → 1.30) was not supported by colocalization; DAG1 provides the severity narrative that IGFBP3 could not carry. The operated endpoint is small (4,559 cases) and its estimates are correspondingly imprecise; the gradient should be read as hypothesis-generating (see Discussion).

### Target tractability, pleiotropy and safety profile
None of the five supported targets has an approved drug or a clinical-stage candidate in Open Targets. In Open Targets annotation, small-molecule tractability was limited: a high-quality binding pocket for DSG2, a medium-quality pocket for BMP6, crystallographic structures with bound ligand for DAG1 and SCN4B, and no small-molecule bucket for CLPS. Antibody tractability was predicted at high confidence for all five on the basis of localisation annotations (UniProt and GO cellular-component evidence), consistent with three being membrane proteins and two secreted.

Documented genetic disease associations for the supported targets were not confined to the spine, which is relevant to both mechanism and safety (Supplementary Table S2):
- **BMP6** — knee osteoarthritis (0.46), hip osteoarthritis (0.41), osteoarthritis (0.36), abnormal meniscus morphology (0.36), hernia (0.40): a fibrocartilage/degenerative-joint profile;
- **CHRDL1** — megalocornea (0.71; the known monogenic phenotype), spinal stenosis (0.20), hernia (0.22);
- **SCN4B** — familial atrial fibrillation (0.63), long QT syndrome 10 (0.49); 19 recorded safety liabilities;
- **DSG2** — arrhythmogenic right ventricular cardiomyopathy (0.81), dilated cardiomyopathy (0.62);
- **DAG1** — dystroglycanopathies (0.79, 0.74);
- **CLPS** — hypothyroidism/myxedema (0.39), with weaker lipid traits (hypertriglyceridaemia, hyperlipoproteinaemia).

These patterns constrain how such targets could be developed: the mechanotransduction proteins (SCN4B, DSG2, DAG1) carry cardiac, muscular and neurological liabilities that would require local or intermittent delivery, whereas the BMP axis offers an existing modality landscape (see Discussion).

---

## 工作区产物索引
- 图: `results/figures/Fig1_forest_MR.png`, `Fig2_coloc_loci.png`, `Fig3_p12_sensitivity.png`
- 表: `results/tables/Table1_MR_results.tsv`, `Table2_coloc_evidence.tsv`, `target_tractability.tsv`
- 分析: `results/mr/mr_screen_all.tsv`, `steiger.tsv`, `reverse_mr.tsv`; `results/coloc/coloc_results.tsv`, `coloc_sensitivity.tsv`
- 脚本: `scripts/step2_mr_screen.R` → `step3_coloc.R` → `step4_sensitivity.R` → `step5_figures.R` → `step6_tables.R` → `opentargets_query.py` → `fetch_region.py`
