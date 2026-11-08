# Discussion — full draft v1.0

> 说明：本文件为可直接进入投稿稿的英文 Discussion。所有数字均来自本项目实跑结果。
> 引用占位符统一使用 `[ref]`，定稿前由通讯作者与第一作者共同补齐（建议优先补：BMP6/SMAD 与椎间盘、DAG1 糖基化与 ECM、desmosome 与纤维环力学、CLPS 与代谢、IGFBP3 生物学、FinnGen 与 UKB-PPP 方法学引用）。
> 文末附中文《审核要点》，列出需要海医生以临床身份确认或增补的 6 处。

---

## 4. Discussion

### 4.1 Principal findings

We screened 2,058 circulating proteins with cis-acting genetic instruments against three clinically defined intervertebral disc phenotypes and identified 11 Bonferroni-significant protein–outcome associations involving 10 proteins. Bayesian colocalization then retained five protein–outcome pairs with evidence of a shared causal variant — SCN4B, BMP6, DAG1 and DSG2 for lumbar disc herniation, and CLPS for cervical disc disorder — and eliminated the association with the smallest P value in the entire screen. Three observations constitute, in our view, the substance of this study.

First, **the cervical and lumbar protein signatures did not overlap at all**. Nine proteins reached significance for lumbar disc herniation; a single, different protein reached significance for cervical disc disorder; no protein was shared. Genetic and proteomic studies of disc degeneration have almost universally treated it as one disease, usually as a composite "intervertebral disc degeneration" phenotype assembled from mixed ICD codes. Our data suggest that its two commonest clinical presentations have distinguishable circulating proteomic architecture, and that pooling them averages away signal.

Second, **the BMP axis behaved as a pathway rather than as a list of hits**. BMP6, a pro-osteogenic ligand of the TGF-β superfamily, increased risk (OR 1.34 per 1-SD higher genetically predicted plasma level), while CHRDL1, a secreted chordin-family antagonist of BMP signalling, reduced it (OR 0.89). A ligand and its endogenous inhibitor moving in opposite directions on the same endpoint is a two-sided test that a single-protein design cannot perform, and it is the pattern expected if the effect is genuinely transduced through BMP signalling rather than through a single protein's incidental correlates.

Third, **the strongest signal in the dataset failed colocalization and we removed it**. IGFBP3 had the smallest P value in the lumbar endpoint (8.7×10⁻¹²) and showed the kind of severity gradient that authors like to interpret as dose–response (OR 1.13 in all lumbar herniation, 1.30 in surgically treated disease). Colocalization refused it: PP.H4 was 0.025 in the lumbar endpoint, PP.H3 reached 0.975, and the two association peaks lay 73 kb apart. We report this as a negative result, for reasons set out in section 4.6.

### 4.2 The BMP axis: a ligand and its antagonist point the same way

BMP6 signals through SMAD1/5/8 and is one of the principal drivers of chondrocyte hypertrophy and matrix mineralisation in the intervertebral disc and in articular cartilage [ref:bmp_smad_disc;ref:bmp_smad_cartilage]. In the nucleus pulposus, BMP signalling rises with degeneration and accompanies the calcification and hypertrophic cell phenotypes seen in aged and degenerated tissue [ref:bmp_disc_degen]; in the endplate, the same pathway is coupled to the remodelling that underlies Modic changes. A risk-increasing direction for genetically predicted circulating BMP6 is therefore consistent with an established biology, and it independently reproduces the BMP6 candidate identified by a recent multi-omic MR study of disc degeneration [ref:kan_multiomic]. Independent reproduction by a different instrument set and a different analytic chain is not trivial in this field, where most reported protein–disease pairs have never been examined twice.

The informative addition is CHRDL1. Chordin-like 1 is a secreted antagonist of the chordin family; by occupying BMP ligands it prevents type I receptor engagement and reduces SMAD1/5/8 activation [ref:chrdl1;ref:bmp_antagonist_review]. Genetically higher CHRDL1 was protective against lumbar disc herniation (OR 0.89, 95% CI 0.85–0.93), and the effect was graded across phenotypes (0.90 cervical, 0.89 all lumbar, 0.84 surgically treated). Ligand up → risk up; antagonist up → risk down. The internal coherence of this pair is, in our judgement, the strongest single piece of evidence in the study, precisely because the two proteins were not selected to be a pair.

One qualification here is biochemical rather than statistical. CHRDL1 has been shown directly to antagonise BMP4, and the chordin family blocks BMP-receptor engagement more generally, but a direct CHRDL1–BMP6 interaction has not, to our knowledge, been demonstrated experimentally. The pair is therefore coherent at the level of pathway antagonism rather than as a documented binary interaction, and we state it in those terms.

Two caveats deserve statement. Plasma BMP6 is largely a hepatic and vascular protein, whereas the relevant BMP6 in disc degeneration is produced locally; a plasma pQTL therefore indexes systemic BMP tone, not intradiscal concentration. The same argument applies in reverse to the effect size: an OR of 1.34 per SD is unusually large for a plasma protein MR and is more plausible as a marker of pathway activity than as a quantitative estimate of the effect of raising circulating BMP6. What the data support is that the BMP axis is causally involved and that its direction is known — not that plasma BMP6 is the therapeutic entity.

External annotation is concordant. In Open Targets, the strongest genetic disease associations for BMP6 are knee osteoarthritis (0.46), hip osteoarthritis (0.41), osteoarthritis (0.36) and abnormal meniscus morphology (0.36). This is a fibrocartilage and degenerative-joint profile rather than a generic inflammatory one, and it places the BMP6 signal within the same disease family as disc degeneration rather than in an unrelated pathway.

### 4.3 A mechanotransduction cluster: DAG1, DSG2 and SCN4B

Three of the five supported proteins occupy the same functional neighbourhood, namely the interface between the cell and its mechanical environment.

**DAG1 (dystroglycan)** anchors the dystrophin–glycoprotein complex to laminin in the basal lamina and is required for assembly of a competent extracellular matrix; loss of dystroglycan glycosylation produces the dystroglycanopathies, in which matrix integrity fails in muscle and brain [ref:dag1]. Its association here was the largest in the study and protective: OR 0.55 (95% CI 0.43–0.71) for lumbar disc herniation, strengthening to 0.36 in surgically treated disease, with colocalization supported (PP.H4 = 0.852; 0.983 at p12 = 1×10⁻⁴). A matrix-anchoring protein with a large protective effect is a biologically legible result: the annulus fibrosus is a lamellar structure whose mechanical competence depends on the junction between cells and their surrounding collagen–proteoglycan matrix, and failure of that junction is a plausible route to the tears that precede herniation.

**DSG2 (desmoglein 2)** is a desmosomal cadherin mediating cell–cell adhesion. Desmosomes are load-bearing junctions, and in the annulus they connect cells within and between lamellae; intercellular junction failure under cyclical loading is an attractive mechanism for delamination. Genetically higher DSG2 was protective (OR 0.84, 0.78–0.91; PP.H4 = 0.837; 0.981 at p12 = 1×10⁻⁴) and again graded by severity (0.95 → 0.84 → 0.79).

**SCN4B (Navβ4)** encodes an auxiliary subunit of voltage-gated sodium channels. Its canonical role is excitability, but β-subunits also participate in cell adhesion and cytoskeletal anchoring through ankyrin and spectrin interactions [ref:scn4b_adhesion;ref:scn4b_ankyrin], and Navβ4 has been implicated in resurgent sodium current in dorsal root ganglion neurons. The estimate was small (OR 1.07, 1.04–1.09) but the colocalization was the strongest in the study (PP.H4 = 0.997, 0.973 at the most conservative prior). We read SCN4B as the least mechanistically specific of the five: it is the only one whose supported biology plausibly runs through neuronal rather than structural mechanisms, and with an OR of 1.07 the possibility that the signal reflects a pathway shared with pain processing cannot be excluded.

The unifying reading — **disc degeneration as a failure of load-bearing cell–matrix and cell–cell connections** — has the practical virtue of matching the exposure that clinicians already accept. Mechanical loading is the one aetiological factor on which spine surgeons, physiotherapists and biomechanists agree, and it is the factor that no genetic study has yet been able to connect to a molecular mechanism. A cluster of three adhesion and cytoskeletal proteins, all protective when genetically raised, is a candidate molecular instantiation of that long-standing clinical intuition. We emphasise that this is a hypothesis generated by the data and not a mechanism demonstrated by them; the study contains no tissue, cellular or animal evidence.

### 4.4 Severity stratification: DAG1 carries the gradient IGFBP3 could not

Because the operated endpoint (FinnGen `M13_EARLY_LUMBAR_PROLAPSE`, official label "Early lumbar disc prolapse, operated"; 4,559 cases) is a subset of all lumbar prolapse and is anchored to an operation rather than to a diagnostic code, comparing estimates across endpoints provides a crude severity axis. Among colocalization-supported proteins, DAG1 showed a monotonic gradient (0.56 cervical, 0.55 all lumbar, 0.36 operated; nominal P = 2.6×10⁻³), with DSG2 (0.95 → 0.84 → 0.79) and CHRDL1 (0.90 → 0.89 → 0.84) moving in the same direction, while BMP6 (1.11 → 1.34 → 1.35) and HLA-E (1.14 → 1.19 → 1.27) strengthened as risk factors.

This is the pattern that made IGFBP3 appear compelling, and it is worth being explicit about why it is more credible here. The IGFBP3 gradient was the entire basis of its attractiveness; once colocalization showed two distinct causal variants in the region, the gradient lost its interpretation. For DAG1 the gradient is a secondary feature of a protein whose colocalization is already supported at the default prior, and the direction of the gradient (protection strengthening with severity) is the one predicted by the mechanotransduction hypothesis rather than merely compatible with it.

Three qualifications limit how far this can be pushed. The endpoints are nested rather than independent, so the comparison is descriptive and not a formal test of heterogeneity. The operated estimate is imprecise: OR 0.36 with a 95% CI of 0.19–0.70, which overlaps the all-lumbar estimate of 0.55 (0.43–0.71), so the gradient is a point-estimate trend rather than a demonstrated difference between groups. And a genetic instrument indexes lifelong exposure, so a "severity gradient" may reflect differences in case mix, anatomical distribution, or route of ascertainment (specialist diagnosis versus operation) rather than a true dose–response. The surgical endpoint is also small — at 4,559 cases only a protein with an effect as large as IGFBP3's would be expected to reach proteome-wide significance, which is why that column is sparse for every other protein. We therefore present the gradient as a hypothesis-generating pattern that a tissue study could test directly, not as evidence of a dose–response relationship.

### 4.5 Site specificity: CLPS and the cervical phenotype

CLPS (colipase), a pancreatic cofactor required for lipase activity in the intestinal lumen, was the only protein associated with cervical disc disorder (OR 0.91, 0.87–0.95) and colocalized strongly (PP.H4 = 0.978; 0.818–0.998 across priors). It was not associated with lumbar herniation (0.97, P = 0.062) nor with surgical disease (0.99, P = 0.74). We do not claim a direct local mechanism for a digestive enzyme in the cervical spine, and the finding is best stated as three linked observations.

First, the genetic architecture of the CLPS signal points toward metabolism rather than structure: in Open Targets its dominant associations are hypothyroidism and myxoedema (0.39), with weaker signals for hypertriglyceridaemia and hyperlipoproteinaemia. Second, cervical disc disease differs epidemiologically from lumbar disc herniation: it presents later and depends more on uncovertebral and foraminal anatomy [ref:cervical_epi], and in the clinical setting it appears more closely associated with systemic metabolic comorbidity — a contrast we could not find a study that tests directly. Third, the cervical endpoint is roughly half the size of the lumbar endpoint, so a single significant protein may partly reflect power: an OR of 0.91 would not have been detectable in the cervical analysis for most of the proteins that were significant in the lumbar analysis.

The testable hypothesis is therefore that the cervical phenotype is more tightly coupled to systemic metabolic state than the lumbar phenotype. This is consistent with the broader literature linking dyslipidaemia, thyroid status and diabetes to disc degeneration [ref:metabolic_disc], and it is falsifiable with data we do not have: paired metabolic phenotyping of cervical and lumbar surgical cohorts. An alternative reading, which we regard as equally defensible on current evidence, is that the 6p21.31 signal tags a neighbouring gene rather than CLPS itself — the interval is gene-dense and colocalization cannot distinguish the target gene from a tightly linked neighbour. We report CLPS because the colocalization is strong and because the site specificity is the paper's most distinctive observation, not because we believe colipase causes cervical spondylosis.

### 4.6 IGFBP3: the value of a negative colocalization

IGFBP3 is the protein a purely MR-based analysis would have reported first, and probably as its headline. It had the smallest P value in the screen, it appeared in two endpoints, and its effect increased with severity — the triad that reviewers and readers have been trained to read as a strong causal signal. Colocalization dissolved it: PP.H4 = 0.025 (lumbar) and 0.135 (surgical), PP.H3 = 0.975 and 0.865, with the pQTL lead variant at chr7:45,915,430 and the outcome peak at chr7:45,994,425.

We report this prominently for two reasons. First, it is a concrete demonstration of a failure mode that is now common in this literature: a single cis variant in a gene-dense region, an MR estimate with a small P value, and a severity gradient that supplies a narrative, with no test of whether the two traits share a causal variant. The IGFBP3 locus contains IGFBP1 as well as IGFBP3, and the outcome peak sits closer to the neighbouring gene; linkage alone is sufficient to generate the entire apparent result. Second, IGFBP3 is biologically plausible — it binds IGF-1 and IGF-2 and regulates their availability, with strong genetic associations across skeletal and neoplastic phenotypes — and plausibility is exactly what allows linkage-driven false positives of this kind to survive review.

The methodological implication is not that MR is uninformative, but that MR without colocalization is. In our screen, three of eleven Bonferroni-significant associations did not survive the transition to colocalization or could not be tested for structural reasons, a ratio that should inform how the existing literature in this field is read.

### 4.7 Comparison with previous work

Three studies define the current landscape, and the contribution of this work is best stated as the intersection that none of them occupies.

The largest previous proteome-wide MR in disc degeneration screened 4,907 proteins against a composite IVDD phenotype and identified candidate proteins without site resolution [ref:pwmr_4907]. A recent multi-omic MR study combined MR, colocalization, SMR and PheWAS against pan-IVDD and reported BMP6 and DLK1 [ref:kan_multiomic]; methodologically it is more complete than ours in several respects, and its BMP6 finding we independently reproduce. A third study screened 91 circulating inflammatory proteins against cervical spondylosis and other spinal degenerative phenotypes using genetic correlation and MR, without colocalization [ref:cip_91]; it established that the cervical phenotype is analysable but left the protein panel and the causal inference thin.

What none of the three does is compare sites within one analytic framework using a full protein panel with colocalization. That comparison is what produces the two findings we regard as novel: complete non-overlap of cervical and lumbar signatures, and a severity-stratified mechanotransduction cluster. The price of occupying that intersection is that each individual component is not new, which is also why the window for this specific analysis is likely to be short.

### 4.8 Translational outlook, and an inconvenient asymmetry

None of the five supported targets has an approved drug or a clinical-stage candidate in Open Targets, which is the point of target-prioritisation work but also a warning about timelines. Two practical considerations shape how these proteins could be pursued.

The first is **direction**. Three of the five (DAG1, DSG2, CLPS) are protective, meaning that the therapeutic direction would be to increase protein function. Pharmacology has far fewer tools for gain-of-function than for inhibition: there are no general agonists for desmosomal cadherins, and restoring dystroglycan function means restoring glycosylation, which is an enzyme-level problem rather than a ligand-level one. BMP6, by contrast, is risk-increasing, and the BMP axis has an established modality landscape — BMP-2 biologics are in routine use in spine fusion, and BMP-pathway antagonists are an active area of drug development for other indications [ref:bmp2_clinical;ref:bmp_antagonist_review]. On directional grounds alone, BMP6 is the most tractable target in this set, and the one for which a disc-directed biologic is easiest to imagine.

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

## 审核要点（不进投稿稿，供海医生逐条确认）

1. **4.2 的临床对应段**：我写了"BMP 信号与终板 Modic 改变、椎间盘钙化相关"这一句。请确认是否符合你的影像/病理观察，或改成更保守的表述（例如只保留椎间盘钙化，删掉 Modic）。
2. **4.3 的力学假说**：这是全文最"临床"的一段，也是审稿人最可能追问的一段。建议你补 1–2 句自己的观察（哪类病人先坏、撕裂常发生在哪一层、HIZ 的位置规律），但**不要写具体病例数**，除非你有可查的科室统计——否则属于不可核实的机构经验，审稿人会要求数据。
3. **4.5 的代谢假说**：请判断"颈椎病人群代谢合并症更突出"是否与你的门诊印象一致。若不一致，我在 4.5 末尾已给了替代解释（CLPS 是标志物而非效应分子），可直接删掉代谢段落，不影响整体。
4. **4.8 的给药途径判断**：椎间盘内注射/局部递送在 DAG1、DSG2、SCN4B 这类靶点上的可行性，你比我有发言权。如需加一句"椎间盘内注射已在临床用于其他适应症"之类的支撑，请给出你认可的表述，我不代你写机构经验。
5. **共同作者与利益冲突**：全文未涉及。投稿前需补 author contributions、funding、competing interests、data availability（GWAS Catalog accession + FinnGen R12 endpoint ID + 代码仓库 URL）。
6. **参考文献**：已完成。全篇 12 处引用点、14 条文献，全部经 PubMed / Europe PMC 按 PMID 核对，条目与 DOI 存在 `docs/references.json`。**请重点复核下面第 7 条的四处改动**——那些是为了让引文站得住脚而改了原句。
7. **为配文献而改动的四处表述（需你点头）**：
   - **4.2 的 CHRDL1 配体特异性**：原稿写"对 BMP4 和 BMP6 均有高亲和力"。公开文献只能直接支持 CHRDL1（ventroptin）拮抗 **BMP4**，未找到 CHRDL1 与 BMP6 直接结合的实验证据。已改为"chordin 家族的分泌型拮抗剂，占据 BMP 配体后阻断 I 型受体、降低 SMAD1/5/8 活化"，并在该段末加了一句明确说明：这一对是"通路层面的拮抗"而非"已证实的二元结合"。**这是全文核心论证之一，若你有 CHRDL1–BMP6 的直接文献，请给我，我改回去。**
   - **4.5 的"颈椎合并症更多"**：我找不到直接检验该对比的研究。已改为"临床观察上似与系统性代谢合并症关系更密切——但我们未检索到直接检验这一对比的研究"。保留你的临床判断，同时把证据边界写清楚，避免审稿人直接打"unsupported claim"。
   - **4.7 的第三篇对照研究**：原稿写"一项中文研究"，但按 91 种炎症蛋白 + 宫颈终点 + 无共定位检索，实际匹配的是 Zheng 等 2024 年 **JOR Spine**（英文）。已改按该文引用。原"中文研究"表述如另有出处，请提供，我并列引用。
   - **4.8 的"BMP 通路抑制剂已进入临床"**：改为"BMP 通路拮抗剂是活跃的研发方向"，因为未找到处于临床阶段的 BMP 抑制剂确证。BMP-2 用于脊柱融合仍照原表述引用。

---

## 数字自检表（写稿时逐条核对过）

| 陈述 | 数值 | 来源文件 |
|---|---|---|
| 蛋白数 / 工具变量数 | 2,058 / 2,060 | `results/mr/instruments_cis_raw.tsv` |
| F 统计量 | 45.4–37,472（中位 939） | 同上 |
| Bonferroni 阈值 | 1.71×10⁻⁵（0.05/2,923 测定蛋白，比按 2,058 校正的 2.43×10⁻⁵ 更严格） | `scripts/step2_mr_screen.R` |
| 显著关联 | 11 条 / 10 个蛋白 | `results/tables/Table1_MR_results.tsv` |
| 共定位支持 | 5 对（SCN4B 0.997、CLPS 0.978、BMP6 0.944、DAG1 0.852、DSG2 0.837） | `results/coloc/coloc_results.tsv` |
| IGFBP3 阴性 | H4 0.025/0.135；H3 0.975/0.865；峰间距 73 kb | 同上 |
| 严重度梯度 | DAG1 0.56/0.55/0.36；BMP6 1.11/1.34/1.35 | `results/tables/TableS3_cross_endpoint.tsv` |
| Steiger | 8/8 方向正确；SCN4B r² 0.109 vs 0.0008 | `results/mr/steiger.tsv` |
| 成药性/安全 | 5 靶点均无上市药或临床候选；SCN4B 19 条安全事件 | `results/tables/TableS2_target_annotation.tsv` |
