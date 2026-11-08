# 投稿前待办清单

状态：Discussion 已完稿（v1.0），Methods/Results 已回填，稿件已合并为 `Manuscript_v0.2.md`（约 4,600 词）。
以下按"必须做 / 应该做 / 可选"三档排列，全部清完后即可投稿。

---

## A. 必须完成（缺一项就会被编辑部退回）

### A1. 代码仓库上线并回填 URL
- [ ] 在 GitHub 建仓库，推 `IVDD-MR/`（`.gitignore` 已排除大文件，推上去约 1–2 MB）
- [ ] 建议同时打 Zenodo release 拿 DOI（期刊现在普遍要求"frozen release"）
- [ ] 回填两处：`docs/Manuscript_Methods_Results_v0.1.md` 的 Software 段、`README.md` 的 Contact 段

### A2. 参考文献（9 处正文 `[ref]`）
| 位置 | 需要什么样的文献 |
|---|---|
| 4.2 段1 | BMP6 → SMAD1/5/8、软骨细胞肥大与基质矿化（椎间盘或软骨，1–2 篇） |
| 4.2 段1 | BMP 信号随椎间盘退变升高、与钙化/肥大表型相关（1 篇） |
| 4.2 段2 | CHRDL1 作为 BMP4/BMP6 拮抗剂的生化机制（1 篇） |
| 4.3 DAG1 | dystroglycan 糖基化与基底膜/ECM 组装、dystroglycanopathy（1 篇综述） |
| 4.3 SCN4B | Navβ 亚基的黏附/细胞骨架锚定功能（1 篇） |
| 4.5 | 颈椎病与系统代谢合并症的临床流行病学（1 篇） |
| 4.5 | 血脂/甲状腺/糖尿病与椎间盘退变的关联（1 篇） |
| 4.7 | 三篇对照研究（ESJ 2025 / JOSR 2026 / 中国组织工程研究 2025）——需核实卷期页码 |
| 4.8 | BMP 通路药物的临床进展（BMP-2 脊柱融合 + BMP 通路抑制剂，1–2 篇） |

> 知网/PubMed 检索式在开工包里；三条对照研究建议直接读原文核对方位，不要只按我此前的二手描述引用。

### A3. 投稿要件
- [ ] Author contributions（CRediT 格式）
- [ ] Funding / Competing interests（本分析全部使用公开汇总数据，无利益冲突需如实声明）
- [ ] Data availability 声明（GWAS Catalog accession + FinnGen R12 endpoint ID + 仓库 URL，草稿已在 `docs/DATA_SOURCES.md`，可直接改写）
- [ ] Figure legends（4 张图，我可以起草）
- [ ] 补充材料清单：Table S1（已生成）、S2（已生成）、S3（已生成）

### A4. 撞车复查
- [ ] 投稿前 3 天内跑一次 PubMed 检索（检索式见开工包），确认"部位细分 × 蛋白组 × 共定位"仍无人发表
- [ ] 若发现撞车：优先改成"以 DAG1 严重度梯度 + IGFBP3 阴性共定位"为卖点的版本，仍可成立

---

## B. 应该完成（明显提高过审率）

### B1. 海医生审核 6 处临床表述
见 `docs/Discussion_v1.0.md` 末尾《审核要点》。重点是 4.3 力学假说与 4.5 代谢假说——这两段决定审稿人是否认为"临床作者提供了生信团队提供不了的东西"。

### B2. 图 2 与图 4 的图注数字复核
图由脚本生成，但图注里的 PP.H4 与 OR 需逐个对 `results/tables/` 核一遍，避免图文不一致（这是最常见的返修原因）。

### B3. 敏感性分析补一项
- [ ] 用 p12 = 1×10⁻⁶/1×10⁻⁵/1×10⁻⁴ 之外的 **PP.H4 ≥ 0.75 阈值**做一次判定，看结论是否变化（审稿人常问"为何选 0.8"）。一行代码即可，我可以补跑。

### B4. 目标期刊定档
- 主投：**Arthritis Research & Therapy**（IF≈5.2，接受遗传学+临床转化，对 MR 研究有审稿经验）
- 备选：The Spine Journal / Osteoarthritis and Cartilage（IF≈5–6）
- 冲高：EBioMedicine（IF≈9–11，需补外部复制或功能验证，当前设计偏薄）
- 建议顺序：ART → OAC → TSJ

---

## C. 可选（有余力再做，能显著加分）

- [ ] **外部复制**：AGES-Reykjavik（Emilsson 2021）pQTL 在 EBI 无文件，可尝试邮件索取或改用 deCODE 官网；若拿到，五个靶点的复制能把文章上限推高一个档
- [ ] **椎间盘 scRNA 定位**：GSE165722 等公开数据集，验证 BMP6/CHRDL1/DAG1 在 NP/AF 细胞的表达——不需要新实验，纯公开数据，是回应"No functional validation"最省力的方式
- [ ] **组织验证**：手术标本 IHC（BMP6、CHRDL1、DAG1），按 Pfirrmann 分级分层——这是把文章从"遗传学关联"推到"临床病理"的关键，也是你作为外科医生的独占优势
- [ ] 预印本：medRxiv 占时间戳（投稿前挂，注意部分期刊对预印本政策不同，ART 允许）

---

## 当前文件对应关系

| 内容 | 文件 |
|---|---|
| 完整投稿稿（读这个） | `docs/Manuscript_v0.2.md` |
| Methods + Results 编辑入口 | `docs/Manuscript_Methods_Results_v0.1.md` |
| Discussion 编辑入口 + 审核要点 | `docs/Discussion_v1.0.md` |
| 数据来源与校验和 | `docs/DATA_SOURCES.md` |
| 表 S1（数据可得性） | `results/tables/TableS1_data_sources.tsv` |
| 表 S2（靶点注释） | `results/tables/TableS2_target_annotation.tsv` |
| 表 S3（跨端点） | `results/tables/TableS3_cross_endpoint.tsv` |

> 改了 Methods/Results 或 Discussion 后，重新运行 `python3 scripts/assemble_manuscript.py` 更新合并稿。
> 不要手工复制粘贴，否则两份文件的数字会分叉——这是这类稿子最常见的低级错误。
