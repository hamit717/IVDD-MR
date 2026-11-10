# Cover letter (draft v1.0)

> 目标期刊：**Arthritis Research & Therapy**（主投）
> 备选顺序：Osteoarthritis and Cartilage → The Spine Journal
> `[ ]` 处为投稿前必须替换的信息。英文正文可直接粘贴进投稿系统的 cover letter 框。

---

[Date]

The Editor-in-Chief
*Arthritis Research & Therapy*

Dear Editor,

We submit for your consideration the manuscript **"Site-resolved plasma proteome-wide Mendelian randomization identifies a BMP-axis pair and a mechanotransduction cluster for lumbar disc herniation, with a distinct metabolic signal in cervical disc disorder"** for publication as a Research Article.

**What the study does.** We screened 2,058 circulating proteins with cis-acting genetic instruments against three clinically defined intervertebral disc phenotypes in FinnGen release 12 — cervical disc disorder, lumbar disc prolapse, and surgically treated lumbar prolapse — and then applied Bayesian colocalization, prior- and threshold-sensitivity analyses, and Steiger directionality to every surviving association.

**What we think is new.** Three points, in order of how much we think they matter to your readership:

1. **Site resolution changes the answer.** Cervical and lumbar disc disease are almost always pooled into a single composite phenotype. When separated, their protein signatures do not overlap at all: nine proteins reached significance for lumbar disease, one different protein for cervical disease, none shared. Pooling, which is the field's default, averages away both signals.
2. **A ligand and its endogenous antagonist move in opposite directions.** BMP6 raises risk (OR 1.34) and CHRDL1, a secreted BMP antagonist, lowers it (OR 0.89) on the same endpoint. This is a two-sided test that single-protein designs cannot perform, and it is the pattern expected if the effect is transduced through BMP signalling rather than through incidental correlates.
3. **The strongest signal in the dataset fails colocalization, and we say so.** IGFBP3 had the smallest P value in the screen (8.7×10⁻¹²) and a textbook severity gradient. Colocalization showed two distinct causal variants 73 kb apart (PP.H3 = 0.975). A purely MR-based analysis would have reported it as the headline target. We report it as a negative result, because we think the field's current enthusiasm for proteome-wide MR needs exactly this kind of internal control.

**Why AR&T.** The paper sits at the junction your journal covers well: genetic causal inference applied to a degenerative musculoskeletal phenotype, with explicit attention to whether the prioritised proteins are druggable and safe. The two target sets we identify — a BMP-axis ligand/antagonist pair and a mechanotransduction cluster (DAG1, DSG2, SCN4B) — map onto cartilage and matrix biology rather than onto generic inflammation, and the safety annotation we report (arrhythmogenic and dystroglycanopathy liabilities for the mechanotransduction targets) is the kind of translational caveat that bears directly on whether these are viable targets at all.

**Rigour and transparency.** All analyses use publicly available summary statistics; no individual-level data were accessed. Analysis code, intermediate tables and figure-generating scripts are on GitHub (https://github.com/hamit717/IVDD-MR) with a frozen release archived at Zenodo (DOI 10.5281/zenodo.24098303). We report the colocalization result that removes our own strongest hit, the prior- and threshold-sensitivity analyses in full, and the DAG1 severity gradient as explicitly hypothesis-generating (its confidence intervals overlap across strata).

**Declarations.** The manuscript is original, is not under consideration elsewhere, and all authors have approved the submission. The authors declare no competing interests and no specific funding. All four authors contributed substantively and meet ICMJE authorship criteria. Generative AI was used for language editing and code drafting, disclosed in the Declarations section; all scientific content, interpretation and clinical judgement are the authors'.

We suggest the following as potential reviewers [ ] — or are happy to leave the choice to you, with the request that reviewers with a primary interest in proteome-wide MR and in disc biology both be represented.

Thank you for considering the manuscript.

Yours sincerely,

**Haimiti Abudouaini, MD** (corresponding author)
Department of Spine Surgery, Honghui Hospital, Xi'an Jiaotong University
No. 555 East Youyi Road, Beilin District, Xi'an, Shaanxi Province 710054, China
E-mail: hmtspine@163.com ｜ Tel: [ ]

On behalf of all authors: Jinwen Zhu, Jianbin Guan, Sibo Wang, Haimiti Abudouaini

---

## 投稿前要替换的 4 处

| 位置 | 填什么 |
|---|---|
| `[Date]` | 投稿日期 |
| 期刊名（两处） | 若改投 OAC / TSJ，需同步改信里的 "AR&T" 与 "your journal covers well" 一句 |
| 建议审稿人 `[ ]` | 可选；建议给 3 位（1 位 MR/统计、1 位椎间盘生物学、1 位脊柱外科），需无利益冲突且非同一机构 |
| `Tel: [ ]` | 通讯电话 |

## 写作说明（不进投稿系统）

- **第 3 点主动写"我们否掉了自己最强的信号"**，这是这封信最有力的地方。多数 MR 投稿会把 IGFBP3 写成卖点；主动揭短反而建立可信度，也让审稿人难以用"MR 不可靠"一句话打回。
- **没有写"首次"**。撞车风险仍在（Kan 2026 已报 BMP6），写 "first" 一旦被审稿人找到先例就是硬伤；改为"部位细分改变了答案"，这是可辩护的。
- **AI 使用主动披露**：BMC 系（ART 属 BMC）自 2023 年起强制要求，且明确 AI 不能署名。信里与 Declarations 保持一致。
