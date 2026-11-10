# Manuscript v0.2 (assembled) — Title page / Abstract / Methods / Results / Discussion / Declarations / References / Legends

> 自动生成文件，请勿直接编辑。改动请改 `docs/` 下的 5 个编辑入口，然后运行
> `python3 scripts/assemble_manuscript.py` 重新组装（入口清单见脚本头部注释）。
> 剩余待办见 `docs/TODO_before_submission.md`；`[TODO]` 需在投稿前清零。
> 参考文献：正文写方括号 ref:键名 占位，条目在 `docs/references.json`，组装时自动编号（Vancouver）。

## Title

**Site-resolved plasma proteome-wide Mendelian randomization identifies a BMP-axis pair and a mechanotransduction cluster for lumbar disc herniation, with a distinct metabolic signal in cervical disc disorder**

**Running title:** Site-resolved proteome-wide MR of disc disorders

## Authors

Jinwen Zhu^1^, Jianbin Guan^1^, Sibo Wang^1^, Haimiti Abudouaini^1^,\*

**Affiliations**

^1^ Department of Spine Surgery, Honghui Hospital, Xi'an Jiaotong University, No. 555 East Youyi Road, Beilin District, Xi'an, Shaanxi Province 710054, China

\* **Correspondence:** Haimiti Abudouaini, MD, Department of Spine Surgery, Honghui Hospital, Xi'an Jiaotong University, No. 555 East Youyi Road, Beilin District, Xi'an, Shaanxi Province 710054, China. E-mail: hmtspine@163.com. Tel: +86 178 8208 5070

**E-mail addresses of all authors**

- Jinwen Zhu — jeven801208@163.com
- Jianbin Guan — Guanjianbin119@outlook.com
- Sibo Wang — wangsbspine1@163.com
- Haimiti Abudouaini — hmtspine@163.com

**ORCID iDs**

ORCID iDs are provided in the submission system for all authors who hold one; they are not reproduced on the title page.

## Manuscript metrics

| Item | Value |
|---|---|
| Abstract | 307 words (structured) |
| Main text (Introduction–Discussion) | ~4,700 words |
| Tables | 2 main (Table 1, Table 2) + 3 supplementary (S1–S3) |
| Figures | 4 main (Fig 1–4), 300 dpi |
| References | 14 |
| Keywords | intervertebral disc degeneration; lumbar disc herniation; cervical disc disorder; Mendelian randomization; colocalization; plasma proteomics; drug target prioritization |

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
All analyses used R 4.4.1 (2024-06-14) with coloc 5.2.3, data.table 1.18.4 and readxl 1.5.0. Regional summary-statistics extraction used custom Python tooling that reads remote tabix indexes and retrieves only the BGZF blocks spanning each region, rather than downloading full summary-statistic files. Analysis code, intermediate summary tables and figure-generating scripts are available at **https://github.com/hamit717/IVDD-MR**, with a frozen release archived at submission.

---

---

## Results

### Proteome-wide MR identifies 11 Bonferroni-significant protein–outcome associations
Of 2,058 proteins with valid cis instruments, 11 tests involving 10 unique proteins passed Bonferroni correction (P < 1.71×10⁻⁵; Figure 1, Table 1). For lumbar disc herniation (35,290 cases), nine proteins were significant: IGFBP3 (OR 1.13, 95% CI 1.09–1.18; P = 8.7×10⁻¹²), BMP6 (OR 1.34, 1.19–1.50), HLA-E (OR 1.19, 1.11–1.26), CHRDL1 (OR 0.89, 0.85–0.93), SCN4B (OR 1.07, 1.04–1.09), KHK (OR 1.10, 1.05–1.14), MST1 (OR 1.03, 1.02–1.05), DSG2 (OR 0.84, 0.78–0.91) and DAG1 (OR 0.55, 0.43–0.71). For surgically treated disc herniation, only IGFBP3 was significant (OR 1.30, 1.18–1.43). For cervical disc disorder, CLPS was the sole significant protein (OR 0.91, 0.87–0.95).

**Key observation**: the cervical and lumbar protein signatures were entirely non-overlapping.

### Colocalization supports five protein–outcome pairs and refutes IGFBP3
coloc.abf over the ±1 Mb regions supported a shared causal variant for five pairs (Figure 2, Table 2): SCN4B–lumbar (PP.H4 = 0.997), CLPS–cervical (PP.H4 = 0.978), BMP6–lumbar (PP.H4 = 0.944), DAG1–lumbar (PP.H4 = 0.852) and DSG2–lumbar (PP.H4 = 0.837).

For IGFBP3, despite the strongest MR signal and its severity-graded association, colocalization was decisively negative (PP.H4 = 0.025 lumbar; 0.135 surgical; PP.H3 = 0.87–0.97): the pQTL lead variant (chr7:45,915,430) and the outcome association peak (chr7:45,994,425) were 73 kb apart, consistent with two distinct causal variants. The IGFBP3 MR association is therefore most plausibly explained by linkage rather than a protein-mediated effect, and it was excluded from target prioritization. MST1 had insufficient overlapping variants (n = 527) for reliable colocalization and was also excluded. Three proteins could not be tested: HLA-E and KHK lack publicly available full regional summary statistics, and the CHRDL1 lead pQTL (rs5942957, chrX:110,535,177) lies on the X chromosome, which is absent from the harmonised exposure files used for regional analysis — a limitation shared with most pQTL resources. CHRDL1 is therefore reported at the MR level only, with its direction (OR 0.89, 0.85–0.93) interpreted in the context of BMP6.

### Sensitivity analyses
PP.H4 estimates were robust to the colocalization prior for SCN4B (0.973–0.9997) and CLPS (0.818–0.998) across p12 = 1×10⁻⁶ to 1×10⁻⁴, and supportive for BMP6 (0.627–0.994). DAG1 and DSG2 reached PP.H4 ≥ 0.83 only at more liberal priors (1×10⁻⁵ and 1×10⁻⁴) and are interpreted as moderate-confidence candidates (Figure 3). Lowering the decision threshold from 0.8 to 0.75 did not change the supported set at p12 = 1×10⁻⁵ or 1×10⁻⁴ (the same five pairs), whereas the most conservative prior retained only SCN4B and CLPS; IGFBP3 and MST1 remained below 0.75 at every prior tested (maximum 0.61; Supplementary Table S4).

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

## Discussion

### 4.1 Principal findings

We screened 2,058 circulating proteins with cis-acting genetic instruments against three clinically defined intervertebral disc phenotypes and identified 11 Bonferroni-significant protein–outcome associations involving 10 proteins. Bayesian colocalization then retained five protein–outcome pairs with evidence of a shared causal variant — SCN4B, BMP6, DAG1 and DSG2 for lumbar disc herniation, and CLPS for cervical disc disorder — and eliminated the association with the smallest P value in the entire screen. Three observations constitute, in our view, the substance of this study.

First, **the cervical and lumbar protein signatures did not overlap at all**. Nine proteins reached significance for lumbar disc herniation; a single, different protein reached significance for cervical disc disorder; no protein was shared. Genetic and proteomic studies of disc degeneration have almost universally treated it as one disease, usually as a composite "intervertebral disc degeneration" phenotype assembled from mixed ICD codes. Our data suggest that its two commonest clinical presentations have distinguishable circulating proteomic architecture, and that pooling them averages away signal.

Second, **the BMP axis behaved as a pathway rather than as a list of hits**. BMP6, a pro-osteogenic ligand of the TGF-β superfamily, increased risk (OR 1.34 per 1-SD higher genetically predicted plasma level), while CHRDL1, a secreted chordin-family antagonist of BMP signalling, reduced it (OR 0.89). A ligand and its endogenous inhibitor moving in opposite directions on the same endpoint is a two-sided test that a single-protein design cannot perform, and it is the pattern expected if the effect is genuinely transduced through BMP signalling rather than through a single protein's incidental correlates.

Third, **the strongest signal in the dataset failed colocalization and we removed it**. IGFBP3 had the smallest P value in the lumbar endpoint (8.7×10⁻¹²) and showed the kind of severity gradient that authors like to interpret as dose–response (OR 1.13 in all lumbar herniation, 1.30 in surgically treated disease). Colocalization refused it: PP.H4 was 0.025 in the lumbar endpoint, PP.H3 reached 0.975, and the two association peaks lay 73 kb apart. We report this as a negative result, for reasons set out in section 4.6.

### 4.2 The BMP axis: a ligand and its antagonist point the same way

BMP6 signals through SMAD1/5/8 and is one of the principal drivers of chondrocyte hypertrophy and matrix mineralisation in the intervertebral disc and in articular cartilage [1,2]. In the nucleus pulposus, BMP signalling rises with degeneration and accompanies the calcification and hypertrophic cell phenotypes seen in aged and degenerated tissue [3]; in the endplate, the same pathway is coupled to remodelling, the process that Modic changes are thought to reflect. A risk-increasing direction for genetically predicted circulating BMP6 is therefore consistent with an established biology, and it independently reproduces the BMP6 candidate identified by a recent multi-omic MR study of disc degeneration [4]. Independent reproduction by a different instrument set and a different analytic chain is not trivial in this field, where most reported protein–disease pairs have never been examined twice.

The informative addition is CHRDL1. Chordin-like 1 is a secreted antagonist of the chordin family; by occupying BMP ligands it prevents type I receptor engagement and reduces SMAD1/5/8 activation [5,6]. Genetically higher CHRDL1 was protective against lumbar disc herniation (OR 0.89, 95% CI 0.85–0.93), and the effect was graded across phenotypes (0.90 cervical, 0.89 all lumbar, 0.84 surgically treated). Ligand up → risk up; antagonist up → risk down. The internal coherence of this pair is, in our judgement, the strongest single piece of evidence in the study, precisely because the two proteins were not selected to be a pair.

One qualification here is biochemical rather than statistical. CHRDL1 has been shown directly to antagonise BMP4, and the chordin family blocks BMP-receptor engagement more generally, but a direct CHRDL1–BMP6 interaction has not, to our knowledge, been demonstrated experimentally. The pair is therefore coherent at the level of pathway antagonism rather than as a documented binary interaction, and we state it in those terms.

Two caveats deserve statement. Plasma BMP6 is largely a hepatic and vascular protein, whereas the relevant BMP6 in disc degeneration is produced locally; a plasma pQTL therefore indexes systemic BMP tone, not intradiscal concentration. The same argument applies in reverse to the effect size: an OR of 1.34 per SD is unusually large for a plasma protein MR and is more plausible as a marker of pathway activity than as a quantitative estimate of the effect of raising circulating BMP6. What the data support is that the BMP axis is causally involved and that its direction is known — not that plasma BMP6 is the therapeutic entity.

External annotation is concordant. In Open Targets, the strongest genetic disease associations for BMP6 are knee osteoarthritis (0.46), hip osteoarthritis (0.41), osteoarthritis (0.36) and abnormal meniscus morphology (0.36). This is a fibrocartilage and degenerative-joint profile rather than a generic inflammatory one, and it places the BMP6 signal within the same disease family as disc degeneration rather than in an unrelated pathway.

### 4.3 A mechanotransduction cluster: DAG1, DSG2 and SCN4B

Three of the five supported proteins occupy the same functional neighbourhood, namely the interface between the cell and its mechanical environment.

**DAG1 (dystroglycan)** anchors the dystrophin–glycoprotein complex to laminin in the basal lamina and is required for assembly of a competent extracellular matrix; loss of dystroglycan glycosylation produces the dystroglycanopathies, in which matrix integrity fails in muscle and brain [7]. Its association here was the largest in the study and protective: OR 0.55 (95% CI 0.43–0.71) for lumbar disc herniation, strengthening to 0.36 in surgically treated disease, with colocalization supported (PP.H4 = 0.852; 0.983 at p12 = 1×10⁻⁴). A matrix-anchoring protein with a large protective effect is a biologically legible result: the annulus fibrosus is a lamellar structure whose mechanical competence depends on the junction between cells and their surrounding collagen–proteoglycan matrix, and failure of that junction is a plausible route to the tears that precede herniation.

**DSG2 (desmoglein 2)** is a desmosomal cadherin mediating cell–cell adhesion. Desmosomes are load-bearing junctions, and in the annulus they connect cells within and between lamellae; intercellular junction failure under cyclical loading is an attractive mechanism for delamination. Genetically higher DSG2 was protective (OR 0.84, 0.78–0.91; PP.H4 = 0.837; 0.981 at p12 = 1×10⁻⁴) and again graded by severity (0.95 → 0.84 → 0.79).

**SCN4B (Navβ4)** encodes an auxiliary subunit of voltage-gated sodium channels. Its canonical role is excitability, but β-subunits also participate in cell adhesion and cytoskeletal anchoring through ankyrin and spectrin interactions [8,9], and Navβ4 has been implicated in resurgent sodium current in dorsal root ganglion neurons. The estimate was small (OR 1.07, 1.04–1.09) but the colocalization was the strongest in the study (PP.H4 = 0.997, 0.973 at the most conservative prior). We read SCN4B as the least mechanistically specific of the five: it is the only one whose supported biology plausibly runs through neuronal rather than structural mechanisms, and with an OR of 1.07 the possibility that the signal reflects a pathway shared with pain processing cannot be excluded.

The unifying reading — **disc degeneration as a failure of load-bearing cell–matrix and cell–cell connections** — has the practical virtue of matching the exposure that clinicians already accept. Mechanical loading is the one aetiological factor on which spine surgeons, physiotherapists and biomechanists agree, and it is the factor that no genetic study has yet been able to connect to a molecular mechanism. A cluster of three adhesion and cytoskeletal proteins, all protective when genetically raised, is a candidate molecular instantiation of that long-standing clinical intuition. We emphasise that this is a hypothesis generated by the data and not a mechanism demonstrated by them; the study contains no tissue, cellular or animal evidence.

### 4.4 Severity stratification: DAG1 carries the gradient IGFBP3 could not

Because the operated endpoint (FinnGen `M13_EARLY_LUMBAR_PROLAPSE`, official label "Early lumbar disc prolapse, operated"; 4,559 cases) is a subset of all lumbar prolapse and is anchored to an operation rather than to a diagnostic code, comparing estimates across endpoints provides a crude severity axis. Among colocalization-supported proteins, DAG1 showed a monotonic gradient (0.56 cervical, 0.55 all lumbar, 0.36 operated; nominal P = 2.6×10⁻³), with DSG2 (0.95 → 0.84 → 0.79) and CHRDL1 (0.90 → 0.89 → 0.84) moving in the same direction, while BMP6 (1.11 → 1.34 → 1.35) and HLA-E (1.14 → 1.19 → 1.27) strengthened as risk factors.

This is the pattern that made IGFBP3 appear compelling, and it is worth being explicit about why it is more credible here. The IGFBP3 gradient was the entire basis of its attractiveness; once colocalization showed two distinct causal variants in the region, the gradient lost its interpretation. For DAG1 the gradient is a secondary feature of a protein whose colocalization is already supported at the default prior, and the direction of the gradient (protection strengthening with severity) is the one predicted by the mechanotransduction hypothesis rather than merely compatible with it.

Three qualifications limit how far this can be pushed. The endpoints are nested rather than independent, so the comparison is descriptive and not a formal test of heterogeneity. The operated estimate is imprecise: OR 0.36 with a 95% CI of 0.19–0.70, which overlaps the all-lumbar estimate of 0.55 (0.43–0.71), so the gradient is a point-estimate trend rather than a demonstrated difference between groups. And a genetic instrument indexes lifelong exposure, so a "severity gradient" may reflect differences in case mix, anatomical distribution, or route of ascertainment (specialist diagnosis versus operation) rather than a true dose–response. The surgical endpoint is also small — at 4,559 cases only a protein with an effect as large as IGFBP3's would be expected to reach proteome-wide significance, which is why that column is sparse for every other protein. We therefore present the gradient as a hypothesis-generating pattern that a tissue study could test directly, not as evidence of a dose–response relationship.

### 4.5 Site specificity: CLPS and the cervical phenotype

CLPS (colipase), a pancreatic cofactor required for lipase activity in the intestinal lumen, was the only protein associated with cervical disc disorder (OR 0.91, 0.87–0.95) and colocalized strongly (PP.H4 = 0.978; 0.818–0.998 across priors). It was not associated with lumbar herniation (0.97, P = 0.062) nor with surgical disease (0.99, P = 0.74). We do not claim a direct local mechanism for a digestive enzyme in the cervical spine, and the finding is best stated as three linked observations.

First, the genetic architecture of the CLPS signal points toward metabolism rather than structure: in Open Targets its dominant associations are hypothyroidism and myxoedema (0.39), with weaker signals for hypertriglyceridaemia and hyperlipoproteinaemia. Second, cervical disc disease differs epidemiologically from lumbar disc herniation: it presents later and depends more on uncovertebral and foraminal anatomy [10], and in the clinical setting it appears more closely associated with systemic metabolic comorbidity — a contrast we could not find a study that tests directly. Third, the cervical endpoint is roughly half the size of the lumbar endpoint, so a single significant protein may partly reflect power: an OR of 0.91 would not have been detectable in the cervical analysis for most of the proteins that were significant in the lumbar analysis.

The testable hypothesis is therefore that the cervical phenotype is more tightly coupled to systemic metabolic state than the lumbar phenotype. This is consistent with the broader literature linking dyslipidaemia, thyroid status and diabetes to disc degeneration [11], and it is falsifiable with data we do not have: paired metabolic phenotyping of cervical and lumbar surgical cohorts. An alternative reading, which we regard as equally defensible on current evidence, is that the 6p21.31 signal tags a neighbouring gene rather than CLPS itself — the interval is gene-dense and colocalization cannot distinguish the target gene from a tightly linked neighbour. We report CLPS because the colocalization is strong and because the site specificity is the paper's most distinctive observation, not because we believe colipase causes cervical spondylosis.

### 4.6 IGFBP3: the value of a negative colocalization

IGFBP3 is the protein a purely MR-based analysis would have reported first, and probably as its headline. It had the smallest P value in the screen, it appeared in two endpoints, and its effect increased with severity — the triad that reviewers and readers have been trained to read as a strong causal signal. Colocalization dissolved it: PP.H4 = 0.025 (lumbar) and 0.135 (surgical), PP.H3 = 0.975 and 0.865, with the pQTL lead variant at chr7:45,915,430 and the outcome peak at chr7:45,994,425.

We report this prominently for two reasons. First, it is a concrete demonstration of a failure mode that is now common in this literature: a single cis variant in a gene-dense region, an MR estimate with a small P value, and a severity gradient that supplies a narrative, with no test of whether the two traits share a causal variant. The IGFBP3 locus contains IGFBP1 as well as IGFBP3, and the outcome peak sits closer to the neighbouring gene; linkage alone is sufficient to generate the entire apparent result. Second, IGFBP3 is biologically plausible — it binds IGF-1 and IGF-2 and regulates their availability, with strong genetic associations across skeletal and neoplastic phenotypes — and plausibility is exactly what allows linkage-driven false positives of this kind to survive review.

The methodological implication is not that MR is uninformative, but that MR without colocalization is. In our screen, three of eleven Bonferroni-significant associations did not survive the transition to colocalization or could not be tested for structural reasons, a ratio that should inform how the existing literature in this field is read.

### 4.7 Comparison with previous work

Three studies define the current landscape, and the contribution of this work is best stated as the intersection that none of them occupies.

The largest previous proteome-wide MR in disc degeneration screened 4,907 proteins against a composite IVDD phenotype and identified candidate proteins without site resolution [12]. A recent multi-omic MR study combined MR, colocalization, SMR and PheWAS against pan-IVDD and reported BMP6 and DLK1 [4]; methodologically it is more complete than ours in several respects, and its BMP6 finding we independently reproduce. A third study screened 91 circulating inflammatory proteins against cervical spondylosis and other spinal degenerative phenotypes using genetic correlation and MR, without colocalization [13]; it established that the cervical phenotype is analysable but left the protein panel and the causal inference thin.

What none of the three does is compare sites within one analytic framework using a full protein panel with colocalization. That comparison is what produces the two findings we regard as novel: complete non-overlap of cervical and lumbar signatures, and a severity-stratified mechanotransduction cluster. The price of occupying that intersection is that each individual component is not new, which is also why the window for this specific analysis is likely to be short.

### 4.8 Translational outlook, and an inconvenient asymmetry

None of the five supported targets has an approved drug or a clinical-stage candidate in Open Targets, which is the point of target-prioritisation work but also a warning about timelines. Two practical considerations shape how these proteins could be pursued.

The first is **direction**. Three of the five (DAG1, DSG2, CLPS) are protective, meaning that the therapeutic direction would be to increase protein function. Pharmacology has far fewer tools for gain-of-function than for inhibition: there are no general agonists for desmosomal cadherins, and restoring dystroglycan function means restoring glycosylation, which is an enzyme-level problem rather than a ligand-level one. BMP6, by contrast, is risk-increasing, and the BMP axis has an established modality landscape — BMP-2 biologics are in routine use in spine fusion, and BMP-pathway antagonists are an active area of drug development for other indications [6,14]. On directional grounds alone, BMP6 is the most tractable target in this set, and the one for which a disc-directed biologic is easiest to imagine.

The second is **safety**, and it must be stated plainly rather than buried in a supplementary table. The mechanotransduction proteins are simultaneously the most biologically compelling and the most systemically risky: SCN4B carries 19 recorded safety liabilities with dominant associations to familial atrial fibrillation (0.63) and long-QT syndrome 10 (0.49); DSG2 is the gene for arrhythmogenic right ventricular cardiomyopathy (0.81) and dilated cardiomyopathy (0.71); DAG1 is the gene for limb-girdle muscular dystrophy type 2P (0.79) and dystroglycanopathy (0.74). A systemic modulator of any of these would carry cardiac, muscular or neurological risk that no disc indication could justify. This asymmetry — the targets with the best genetic evidence being the ones least suited to systemic modulation — is itself a finding worth reporting, because it argues that disc-targeted delivery (intradiscal injection, depot formulations, or locally restricted vectors) is not a convenience but a requirement for this class of target.

Two further translational notes. Plasma measurement of BMP6 or CHRDL1 is unlikely to serve as a diagnostic, given the effect sizes and the hepatic contribution to circulating pools; the plausible biomarker use is patient stratification for a BMP-directed trial rather than diagnosis. And the obvious next experiment is not a drug but a tissue study: protein-level measurement of BMP6, CHRDL1 and DAG1 in disc specimens stratified by Pfirrmann grade and by surgical versus non-surgical presentation, which would test the severity gradient directly in the compartment where the biology is supposed to happen.

### 4.9 Limitations

Several limitations constrain interpretation.

**Instrument structure.** Each protein was instrumented by a single cis lead variant, so pleiotropy-robust estimators (MR-Egger, weighted median) and heterogeneity testing were not applicable. Robustness rests on colocalization across three priors and on Steiger directionality rather than on estimators designed to detect horizontal pleiotropy. For a single cis variant, colocalization is the more informative test, but it cannot exclude pleiotropy acting through the same causal variant.

**Instrument selection.** Instruments were taken as the lead cis variant per protein from a published summary table, without formal LD clumping against an external reference panel and without modelling independent secondary cis signals. Proteins instrumented only by weak secondary signals would have been missed, and the 2,058 proteins analysed are those with a genome-wide significant cis variant, not the full 2,923-protein panel — a selection that favours well-powered proteins. Instrument strength varied widely (F 45–37,472 across all proteins); among the five supported targets DAG1 had the weakest instrument (F = 92), which is adequate by conventional criteria but is the reason its confidence interval is the widest in the set.

**No independent replication cohort.** We could not identify a public pQTL resource covering all five proteins that is independent of UK Biobank; the SCALLOP meta-analysis includes UKB and is therefore not independent. Replication is limited to the internal consistency of the BMP pair, cross-endpoint consistency, and concordance with one previously reported candidate (BMP6). This is the study's most important limitation.

**Population and overlap.** Exposure (UKB-PPP, European ancestry) and outcome (FinnGen R12, Finnish) are both European but non-overlapping, which removes sample-overlap bias but limits generalisability and may reduce instrument coverage where Finnish allele frequencies differ. Association testing in a founder population with enriched variants is not equivalent to testing in a cosmopolitan cohort.

**Endpoint ascertainment.** FinnGen endpoints derive from specialist-care ICD coding, so mild, imaging-only or primary-care-managed degeneration is not captured. The operated endpoint is anchored to an operation and therefore identifies disease severe enough to be treated surgically, but its official label ("early lumbar disc prolapse, operated") includes an "early" qualifier whose definition is not documented in the endpoint metadata; the analyses therefore identify the endpoint by its official label and treat "operated" as its operative content. At 4,559 cases it is also underpowered for proteome-wide correction, so the cross-endpoint comparison is descriptive, and it mixes indication differences with severity differences.

**Colocalization priors.** DAG1 and DSG2 reached PP.H4 ≥ 0.8 only at p12 ≥ 1×10⁻⁵ and should be regarded as moderate-confidence; CLPS and SCN4B are robust across the full prior range. CHRDL1 could not be tested at all, because its lead variant lies on the X chromosome, which is absent from the harmonised exposure files — a limitation shared with most pQTL resources and one that systematically removes X-linked proteins from colocalization-based prioritisation. HLA-E and KHK lacked public regional summary statistics.

**No functional validation.** There is no single-cell localisation, no disc tissue protein measurement, and no experimental work. Every mechanistic statement in sections 4.2 to 4.5 is a hypothesis assembled from prior literature and directional consistency, not a mechanism demonstrated here.

### 4.10 Conclusion

Genetic evidence from 2,058 circulating proteins prioritises two coherent target sets for lumbar disc herniation — a BMP-axis pair in which the ligand raises and its endogenous antagonist lowers risk (BMP6, CHRDL1), and a mechanotransduction cluster of matrix and junctional proteins that are protective and whose protection strengthens with surgical severity (DAG1, DSG2, SCN4B) — while identifying a metabolically oriented, site-specific signal for cervical disc disorder (CLPS) that does not overlap with the lumbar signature. The same analysis shows that its own strongest signal, IGFBP3, does not survive colocalization, and that MR without colocalization would have produced a confidently wrong target. The immediate value of these results is to convert a common clinical intuition — that disc failure is a failure of load-bearing connections — into named, testable, and currently unoccupied molecular targets; their immediate caution is that the proteins with the best genetic support are also the ones least suitable for systemic modulation.

---

## Declarations

### Ethics approval and consent to participate

Not applicable. This study is a secondary analysis of publicly available, de-identified summary-level genetic association data. No individual-level data were accessed, and no new human participants or animals were involved. All original studies obtained ethics approval and informed consent from their participants, as described in the primary publications and data-source documentation (Supplementary Table S1).

### Consent for publication

Not applicable.

### Availability of data and materials

All data analysed in this study are publicly available; no new data were generated. The datasets and their exact accessions, versions and download locations are listed in Supplementary Table S1 and documented in the repository (`docs/DATA_SOURCES.md`):

- **Instruments** — lead cis-pQTL summary statistics from Sun et al., *Nature* 2023 (Supplementary Table 10), derived from the UK Biobank Pharma Proteomics Project.
- **Regional exposure summary statistics** — harmonised European-ancestry UKB-PPP Olink re-analysis by Loya et al., *Nature Genetics* 2025, accessed through the EBI GWAS Catalog (accessions listed per protein in Supplementary Table S1).
- **Outcomes** — FinnGen release 12 endpoint summary statistics for `M13_CERVICDISC`, `M13_LUMBAR_PROLAPSE` and `M13_EARLY_LUMBAR_PROLAPSE` (https://r12.finngen.fi/).
- **Target annotation** — Open Targets Platform, queried 2026-11-08 via the public GraphQL API.

Access to UK Biobank individual-level data is governed by the UK Biobank Access Management System; the present work used only summary statistics released by the primary studies and therefore required no additional application.

### Code availability

The complete analysis chain — instrument extraction, proteome-wide Wald-ratio MR, regional summary-statistic retrieval, colocalization, prior-sensitivity analysis, Steiger directionality, severity stratification, figure and table generation, and Open Targets annotation — is available at:

**https://github.com/hamit717/IVDD-MR**

A frozen release of the code corresponding exactly to the version used for this manuscript is archived at Zenodo (DOI 10.5281/zenodo.24098303). Scripts are written in R 4.4.1 (coloc 5.2.3, data.table 1.18.4, readxl 1.5.0) and Python ≥3.9 (standard library only); the full session record is provided as `env/session_info.txt`.

### Competing interests

The authors declare that they have no competing interests.

### Funding

The authors received no specific funding for this work.

### Authors' contributions (CRediT)

| Author | Roles |
|---|---|
| **Jinwen Zhu** | Conceptualization; Data curation; Formal analysis; Methodology; Software; Visualization; Writing – original draft |
| **Jianbin Guan** | Data curation; Investigation; Validation; Writing – review & editing |
| **Sibo Wang** | Formal analysis; Methodology; Validation; Writing – review & editing |
| **Haimiti Abudouaini** | Conceptualization; Supervision; Resources; Project administration; Writing – review & editing |

All authors read and approved the final manuscript and agree to be accountable for all aspects of the work.

### Acknowledgements

None.

### Use of artificial intelligence

The authors used an AI-assisted analysis environment to develop and debug the analysis code and to draft and revise sections of the manuscript text. All analytical decisions, the interpretation of results, and the final content were reviewed, verified and approved by the authors, who take full responsibility for the content of this publication. No AI tool is listed as an author, and no AI tool was used to generate or alter any figure data.

---

## References

1. Chen CN, Chang HI, Yen CK, Liu WL, Huang KY. Mechanical Stretch Induced Osteogenesis on Human Annulus Fibrosus Cells through Upregulation of BMP-2/6 Heterodimer and Activation of P38 and SMAD1/5/8 Signaling Pathways. Cells. 2022;11(16):2600. doi:10.3390/cells11162600
2. Wu M, Wu S, Chen W, Li YP. The roles and regulatory mechanisms of TGF-β and BMP signaling in bone and cartilage development, homeostasis and disease. Cell Res. 2024;34(2):101-123. doi:10.1038/s41422-023-00918-9
3. Zieba J, Forlenza KN, Heard K, Martin JH, Bosakova M, Cohn DH, et al. Intervertebral disc degeneration is rescued by TGFβ/BMP signaling modulation in an ex vivo filamin B mouse model. Bone Res. 2022;10(1):37. doi:10.1038/s41413-022-00200-5
4. Kan S, Liu W, Li P, Zhou M, Yu H, Zheng Y, et al. Multi-omics Mendelian randomization prioritizes BMP6 as a candidate therapeutic target in intervertebral disc degeneration. J Orthop Surg Res. 2026;21(1):272. doi:10.1186/s13018-026-06762-y
5. Sakuta H, Suzuki R, Takahashi H, Kato A, Shintani T, Iemura Si, et al. Ventroptin: a BMP-4 antagonist expressed in a double-gradient pattern in the retina. Science. 2001;293(5527):111-115. doi:10.1126/science.1058379
6. Brazil DP, Church RH, Surae S, Godson C, Martin F. BMP signalling: agony and antagony in the family. Trends Cell Biol. 2015;25(5):249-264. doi:10.1016/j.tcb.2014.12.004
7. Walimbe AS, Muntoni F, Campbell KP. Clinical presentations and pathophysiological mechanisms of dystroglycanopathy: advancing therapeutic strategies. Lancet Neurol. 2026;25(7):689-700. doi:10.1016/s1474-4422(26)00191-2
8. Shimizu H, Tosaki A, Ohsawa N, Ishizuka-Katsura Y, Shoji S, Miyazaki H, et al. Parallel homodimer structures of the extracellular domains of the voltage-gated sodium channel β4 subunit explain its role in cell-cell adhesion. J Biol Chem. 2017;292(32):13428-13440. doi:10.1074/jbc.m117.786509
9. Malhotra JD, Kazen-Gillespie K, Hortsch M, Isom LL. Sodium channel beta subunits mediate homophilic cell adhesion and recruit ankyrin to points of cell-cell contact. J Biol Chem. 2000;275(15):11383-11388. doi:10.1074/jbc.275.15.11383
10. Badhiwala JH, Ahuja CS, Akbar MA, Witiw CD, Nassiri F, Furlan JC, et al. Degenerative cervical myelopathy - update and future directions. Nat Rev Neurol. 2020;16(2):108-124. doi:10.1038/s41582-019-0303-0
11. Zhang H, Tian J, Lu Y, Yu D, Wu H, Lu Y, et al. Causal links between multi-domain risk factors and intervertebral disc degeneration: a systematic review and meta-analysis of Mendelian randomization studies. BMC Musculoskelet Disord. 2026;27(1):668. doi:10.1186/s12891-026-10040-7
12. Ren BW, Liu YH, Wu JH, An BC, Liu QZ, Liu CY, et al. Causal effects of plasma proteome on intervertebral disc degeneration: a comprehensive mendelian randomization study. Eur Spine J. 2025;34(1):316-325. doi:10.1007/s00586-024-08551-9
13. Zheng Q, Lin R, Wang D, Zheng C, Xu W. Effects of circulating inflammatory proteins on spinal degenerative diseases: Evidence from genetic correlations and Mendelian randomization study. JOR Spine. 2024;7(2):e1346. doi:10.1002/jsp2.1346
14. May RD, Frauchiger DA, Albers CE, Tekari A, Benneker LM, Klenke FM, et al. Application of Cytokines of the Bone Morphogenetic Protein (BMP) Family in Spinal Fusion - Effects on the Bone, Intervertebral Disc and Mesenchymal Stromal Cells. Curr Stem Cell Res Ther. 2019;14(8):618-643. doi:10.2174/1574888x14666190628103528

---

## Figure legends

### Figure 1

**Proteome-wide cis-Mendelian randomization of plasma proteins against three intervertebral disc phenotypes.**

Forest plot of the eleven protein–outcome associations that passed Bonferroni correction (P < 1.71 × 10⁻⁵) among 2,058 proteins with valid cis-pQTL instruments. Points show the Wald-ratio estimate of the log odds ratio per 1-SD genetically predicted increase in plasma protein level; horizontal bars are 95% confidence intervals. Colours denote the outcome: cervical disc disorder (17,993 cases; red), lumbar disc herniation (35,290 cases; blue) and surgically treated disc herniation (4,559 cases; green). Numeric OR (95% CI) values are given at the right. The dashed vertical line marks the null. Proteins reaching significance for more than one phenotype are labelled with the phenotype in parentheses. All estimates are derived from a single lead cis variant per protein; confidence intervals are therefore not adjusted for instrument selection.

### Figure 2

**Colocalization of plasma protein and disc disorder signals at five supported loci.**

For each protein–outcome pair, the left panel shows the cis-pQTL association (−log₁₀ *P*) and the right panel the corresponding outcome association (−log₁₀ *P*) across the ±1 Mb region surrounding the lead pQTL, plotted against chromosomal position (Mb, hg38). Each row is one pair: SCN4B (lumbar), CLPS (cervical), BMP6 (lumbar), DAG1 (lumbar) and DSG2 (lumbar), ordered as in Table 2. The horizontal dotted line marks genome-wide significance (P = 5 × 10⁻⁸). Posterior probabilities of a shared causal variant (PP.H4) and of two distinct causal variants (PP.H3) from `coloc.abf` at the default prior (p12 = 1 × 10⁻⁵) are annotated in the lower-left corner of each outcome panel. Variants were restricted to those present in both datasets after allele harmonisation (3,555–8,639 variants per pair); palindromic variants with allele frequency between 0.42 and 0.58 were removed.

### Figure 3

**Sensitivity of colocalization evidence to the prior probability of a shared causal variant.**

PP.H4 is plotted for each protein–outcome pair at three values of the `coloc.abf` prior p12 (1 × 10⁻⁶, 1 × 10⁻⁵, 1 × 10⁻⁴), connected within each pair. The dotted line at 0.8 marks the prespecified threshold for supportive evidence; the dashed line at 0.5 marks equipoisse between hypotheses. SCN4B and CLPS remain above 0.8 at all three priors; BMP6 exceeds 0.8 at the default and liberal priors; DAG1 and DSG2 reach the threshold only at p12 ≥ 1 × 10⁻⁵ and are therefore reported as moderate-confidence candidates. IGFBP3 remains below 0.2 at all priors, consistent with the two distinct causal variants indicated by its high PP.H3.

### Figure 4

**Cross-phenotype comparison of colocalization-supported proteins.**

Odds ratios (log scale) for cervical disc disorder (red), lumbar disc herniation (blue) and surgically treated disc herniation (green) per 1-SD genetically predicted protein level, shown for the five colocalization-supported proteins together with CHRDL1 (MR-level evidence only) and IGFBP3 (refuted by colocalization, shown for comparison). Horizontal bars are 95% confidence intervals. Because surgically treated cases are a subset of all lumbar disc herniation cases, the three estimates for a given protein are correlated and are compared descriptively rather than tested for between-group difference. DAG1 shows a monotonic decline in OR across increasing phenotypic severity (0.56 → 0.55 → 0.36); the confidence interval for the operated group (0.19–0.70) overlaps that of all lumbar herniation (0.43–0.71), so the gradient is a point-estimate trend and is interpreted as hypothesis-generating.

### Supplementary tables (for the legend list in the submission system)

| Item | Content |
|---|---|
| **Table S1** | Data sources: protein, UniProt ID, GWAS Catalog accession for the regional exposure statistics, FinnGen endpoint, case/control counts, and file checksums. |
| **Table S2** | Open Targets annotation of the ten Bonferroni-significant proteins: small-molecule and antibody tractability buckets, clinical-stage candidates, recorded safety liabilities, and associated diseases with association scores. |
| **Table S3** | Cross-endpoint effect estimates (OR, 95% CI, P) for all Bonferroni-significant proteins across the three FinnGen endpoints. |
| **Table S4** | Threshold sensitivity: PP.H4 for every protein–outcome pair at p12 = 1 × 10⁻⁶, 1 × 10⁻⁵ and 1 × 10⁻⁴, with pass/fail at a PP.H4 ≥ 0.75 decision threshold. |
