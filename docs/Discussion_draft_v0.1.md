# Discussion 骨架 v0.1 — 供海医生改写

> 用法：黑体段落是我写的英文草稿（可直接用或改），`【海医生】`标记的地方需要你的临床判断。
> 所有数字与关联来自本项目实跑结果，不要改动数字。

---

## 4. Discussion

### 4.1 Principal findings

In a proteome-wide cis-Mendelian randomization screen of 2,058 circulating proteins against three clinically defined disc disorder endpoints, we identified 11 Bonferroni-significant protein–outcome associations and, after Bayesian colocalization, retained five proteins with genetic evidence of a shared causal variant: **SCN4B, BMP6, DAG1, DSG2 (lumbar disc herniation)** and **CLPS (cervical disc disorder)**. Three observations are, in our view, the substance of this paper:

1. **The cervical and lumbar protein signatures did not overlap at all.** Nine proteins were significant for lumbar disc herniation and one — a different one — for cervical disc disorder. Disc degeneration is conventionally treated as a single disease entity in genetic studies; our data argue that its two most common clinical presentations have distinguishable circulating proteomic architecture.
2. **The BMP axis was internally consistent.** BMP6, a pro-osteogenic/pro-fibrotic TGF-β family ligand, increased risk (OR 1.34), whereas CHRDL1, a secreted BMP antagonist, decreased it (OR 0.89). Opposite directions for ligand and antagonist of the same pathway is the pattern expected of a genuinely pathway-mediated effect rather than uncoordinated noise.
3. **One of our strongest MR signals failed colocalization and we removed it.** IGFBP3 showed the largest effect estimates in the screen (including an apparent severity gradient, OR 1.13 in all lumbar herniation rising to 1.30 in surgically treated disease), but the pQTL and the outcome peaks were 73 kb apart with PP.H3 up to 0.97. We report this as a negative colocalization result rather than a target.

### 4.2 The BMP axis: BMP6 versus CHRDL1

BMP6 lies in the TGF-β superfamily and drives SMAD1/5/8 signalling; in cartilage and nucleus pulposus it promotes matrix calcification and hypertrophic differentiation, both of which accompany disc degeneration. Our direction of effect (higher genetically predicted BMP6 → higher risk) is consistent with that biology, and independently recapitulates the BMP6 candidate reported by an earlier multi-omic MR study of disc degeneration (J Orthop Surg Res 2026). The addition here is the antagonist: CHRDL1 binds BMP4/BMP6 and prevents receptor engagement, and genetically higher CHRDL1 was protective (OR 0.89) in the same endpoint. **The ligand raises risk and its endogenous inhibitor lowers it — a two-sided, direction-consistent test that a single-protein MR design cannot provide.**

External support: in Open Targets, BMP6's strongest genetic disease associations are knee osteoarthritis (score 0.46), hip osteoarthritis (0.41), osteoarthritis (0.36) and abnormal meniscus morphology (0.36) — a fibrocartilage/degenerative-joint profile, not a generic inflammatory one.

【海医生】要补的三件事：
- 椎间盘内 BMP 信号与终板 Modic 改变、椎间盘钙化的临床对应关系（你门诊/手术中见到的影像表型）
- BMP 通路在骨科已有的临床干预经验（如 BMP-2 用于脊柱融合、以及 BMP 抑制剂在别的适应症的情况），这决定了"可干预性"的说服力
- BMP6 与 CHRDL1 在椎间盘细胞（NP 细胞 vs AF 细胞）表达的文献，若有 scRNA 数据可引一段

### 4.3 Cytoskeleton and desmosome: a mechanotransduction cluster

Three of the five supported proteins — SCN4B, DAG1, DSG2 — sit in the same functional neighbourhood: **the interface between the cell membrane and the mechanical environment.**

- **DAG1 (dystroglycan)** anchors the dystrophin–glycoprotein complex to laminin in the basal lamina; loss of dystroglycan glycosylation causes dystroglycanopathies with disrupted extracellular matrix assembly. Its effect here was the largest in the study and protective (OR 0.55, 95% CI 0.43–0.71).
- **DSG2 (desmoglein 2)** is a desmosomal cadherin mediating cell–cell adhesion; intercellular junctions in the annulus fibrosus are load-bearing structures.
- **SCN4B (Navβ4)** is a voltage-gated sodium channel auxiliary subunit; beyond excitability, β-subunits participate in cell adhesion and cytoskeletal anchoring (Navβ subunits interact with ankyrin/spectrin).

The unifying reading — **disc degeneration as a failure of load-bearing cell–matrix and cell–cell connections** — is mechanistically attractive because mechanical loading is the one exposure every spine surgeon already believes in. It also explains why the effect sizes are modest for the channel/junction proteins and large for the matrix anchor. And it carries a severity signal: **DAG1's protective association strengthened monotonically from OR 0.55 in all lumbar herniation to 0.36 in surgically treated disease** — the same "gradient" pattern that made IGFBP3 look compelling, but here on a protein whose colocalization is supported (PP.H4 = 0.85, robust across priors). DSG2 (0.84 → 0.79) and CHRDL1 (0.89 → 0.84) moved in the same direction, while BMP6 and HLA-E strengthened as risk factors (1.34 → 1.35 and 1.19 → 1.27).

【海医生】这里是你最能加分的地方：
- 从生物力学角度论证 AF 层间连接、NP 细胞-基质锚定在退变中的作用（你的临床观察：哪类病人先坏、坏在哪一层）
- DSG2/DAG1 与"椎间盘撕裂型"腰痛的对应（MRI 上的 HIZ、纤维环高信号）
- 明确写出这是假说，不是本文证明的结论——审稿人会因此更信任你

### 4.4 Site specificity: why only CLPS for the cervical spine

CLPS (colipase), a pancreatic lipase cofactor, was the sole protein associated with cervical disc disorder (OR 0.91) and colocalized strongly (PP.H4 = 0.978; robust across priors 0.82–0.998). This is a priori surprising for a digestive enzyme, and we do not claim a direct local mechanism. Two observations make it worth reporting rather than dismissing:

1. Its Open Targets genetic associations are dominated by **hypothyroidism/myxedema (0.39)** and, at lower score, **hypertriglyceridaemia and hyperlipoproteinaemia** — i.e., a metabolic/lipid profile rather than a structural one.
2. Cervical disc disease has a distinctive epidemiology (symptom onset typically in the 40s–50s, strong association with foraminal anatomy and uncovertebral joint degeneration) that differs from lumbar disc herniation, which peaks in a younger working population.

A plausible, testable hypothesis is that the cervical phenotype is more strongly coupled to systemic metabolic state than the lumbar phenotype — consistent with the broader literature linking dyslipidaemia and thyroid status to disc degeneration. **We present this as hypothesis-generating, and flag that a single significant protein in the smaller cervical endpoint (17,993 cases) may also reflect limited power relative to the lumbar analysis (35,290 cases).**

【海医生】需要你判断：
- 临床上颈椎病人群的代谢合并症（甲状腺、血脂、糖尿病）是否真的比腰椎人群更突出？如果有门诊数据印象或科室统计，这一段会非常有说服力
- 如果不同意"代谢耦合"这个解释，可以改成"颈椎与腰椎的遗传结构不同，CLPS 可能是标志物而非效应分子"

### 4.5 IGFBP3: a cautionary result, and a methodological point

IGFBP3 is the protein a purely MR-based analysis would have put first. It had the smallest P value in the lumbar endpoint (8.7×10⁻¹²), it appeared in both lumbar and surgically treated endpoints, and the effect size increased with severity (1.13 → 1.30), which is exactly the pattern authors like to interpret as dose–response. Colocalization dissolved it: PP.H4 = 0.025 (lumbar) and 0.135 (surgical), with PP.H3 = 0.87–0.97 and a 73 kb gap between the two association peaks.

We think this deserves explicit reporting for two reasons. First, it is a concrete demonstration that in this field an MR signal plus a plausible severity gradient is insufficient evidence of a protein-mediated effect — the exact failure mode that has made purely MR-based target papers increasingly difficult to publish. Second, IGFBP3's biology (it binds IGF-1/IGF-2 and regulates their availability, with strong genetic associations across skeletal and neoplastic phenotypes) makes it a *plausible* candidate, which is precisely why linkage-driven false positives of this kind survive peer review.

### 4.6 Comparison with previous work

Three studies define the current landscape, and our contribution should be positioned against them explicitly:

| Prior work | What they did | What we add |
|---|---|---|
| Eur Spine J 2025 (4,907 proteins, pan-IVDD) | Largest proteome-wide MR in IVDD to date, single composite phenotype | Site-resolved endpoints (cervical vs lumbar vs surgically treated), which reveals non-overlapping signatures |
| J Orthop Surg Res 2026 (multi-omic MR + coloc, BMP6/DLK1) | Methodologically complete, pan-IVDD | Independent replication of BMP6 with a direction-consistent antagonist (CHRDL1); phenotypic severity stratification |
| Chin J Tissue Eng Res 2025 (91 inflammatory proteins → cervical IVDD) | First cervical-specific protein MR, small protein panel, no colocalization | Full 2,058-protein panel in the cervical endpoint with colocalization support for CLPS |

【海医生】投稿前请再查一次 PubMed 撞车（检索式在开工包里），确认这三个月内没有人发表"部位细分 + 蛋白组 + 共定位"的组合。

### 4.7 Clinical and translational implications

None of the five supported targets has an approved drug or a clinical-stage candidate in Open Targets, which is the point: these are unoccupied targets with human genetic support. Two are more attractive than the others on practical grounds — **BMP6** (existing modality experience in the BMP pathway, including BMP-binding biologics; a medium-quality small-molecule pocket) and **DAG1** (largest effect size in the study, antibody-tractable per membrane localisation).

The safety picture must be stated plainly rather than buried:

- **SCN4B**: 19 recorded safety liability events; its dominant genetic associations are familial atrial fibrillation (0.63) and long-QT syndrome 10 (0.49). A systemic SCN4B-modulating drug would carry cardiac conduction risk — local or intermittent delivery would be required.
- **DSG2**: arrhythmogenic right ventricular cardiomyopathy (0.81) and dilated cardiomyopathy — the same desmosomal biology that makes it interesting in the annulus makes it dangerous systemically.
- **DAG1**: dystroglycanopathies (0.79) imply muscle and brain liability.

This pattern — mechanotransduction proteins being simultaneously the most compelling disc targets and the most systemically risky — is itself a finding worth stating.

【海医生】可加一句你的临床判断：椎间盘局部给药（椎间盘内注射、靶向递送）在这几个靶点上的可行性，以及手术标本验证的设想。

### 4.8 Limitations

1. **Single-variant instruments.** Each protein was instrumented by one cis lead variant, so MR-Egger, heterogeneity tests and weighted median were not applicable; robustness rests on colocalization across three priors and Steiger directionality rather than on pleiotropy-robust estimators.
2. **No formal LD clumping with an external reference panel.** cis instruments were taken as the lead variant per protein from the published summary table; independent secondary cis signals were not modelled.
3. **Exposure and outcome in different populations but both European.** UKB-PPP (European ancestry) and FinnGen R12 (Finnish). Finnish enrichment of some variants may reduce instrument coverage; generalisability to non-European populations is untested.
4. **Endpoint ascertainment.** FinnGen endpoints are ICD-code based (specialist care), so mild or imaging-only degeneration is not captured; the surgical endpoint (4,559 cases) is objectively verified but underpowered for proteome-wide correction.
5. **No independent proteomic replication cohort.** A second pQTL dataset covering all five proteins with public summary statistics was not available; SCALLOP includes UK Biobank and is therefore not independent.
6. **No functional validation.** No scRNA-seq localisation, no disc tissue protein measurement, no animal work. All mechanistic statements in 4.2–4.4 are hypotheses.
7. **Colocalization priors.** DAG1 and DSG2 reached PP.H4 ≥ 0.8 only at p12 ≥ 1e-5, and should be regarded as moderate-confidence.

### 4.9 Conclusion

【海医生】一句话收尾，建议方向：
"Genetic evidence prioritises a BMP-axis pair (BMP6/CHRDL1) and a mechanotransduction cluster (DAG1, DSG2, SCN4B) as candidate drug targets for lumbar disc herniation, and identifies a metabolically oriented, site-specific signature for cervical disc disorder; it also shows that the most attractive MR signal in the dataset (IGFBP3) does not survive colocalization."
