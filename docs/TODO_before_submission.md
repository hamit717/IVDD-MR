# 投稿前待办清单

状态：Discussion 已完稿（v1.0），Methods/Results 已回填，稿件已合并为 `Manuscript_v0.2.md`（约 4,600 词）。
以下按"必须做 / 应该做 / 可选"三档排列，全部清完后即可投稿。

---

## A. 必须完成（缺一项就会被编辑部退回）

### A1. 代码仓库上线并回填 URL
- [x] 稿件、声明、图注、LICENSE、README 已备齐（2026-11-08）
- [ ] **一步推上 GitHub**：在「终端」App 里运行
      `bash ~/WorkBuddy/2026-11-07-22-16-25/IVDD-MR/scripts/publish_to_github.sh`
      脚本会问用户名 + Personal Access Token，自动建仓库、推送、并打印回填命令
- [ ] 回填 URL：`python3 scripts/set_repo_url.py <用户名>`
- [ ] 打 release 拿 DOI：GitHub → Releases → New（tag `v1.0.0`），再用 Zenodo 授权，然后
      `python3 scripts/set_repo_url.py <用户名> --doi 10.5281/zenodo.xxxxxxx`

### A2. 参考文献（13 处正文 `[ref]`）
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

### A3. 投稿要件（已起草，待你确认/填空）
- [x] Author contributions（CRediT，4 人）→ `docs/Declarations_v1.0.md`
- [x] Funding / Competing interests / Acknowledgements → 同上
- [x] Data availability / Code availability → 同上
- [x] AI 使用声明（Springer Nature 强制项）→ 同上
- [x] Figure legends（4 张）→ `docs/Figure_legends_v1.0.md`
- [x] 标题页（标题、跑题、作者、单位、邮箱、关键词）→ `docs/TitlePage_v1.0.md`
- [x] LICENSE（MIT + 图表 CC BY 4.0）
- [ ] **4 个 ORCID**（通讯作者必填）
- [ ] 通讯电话（投稿系统必填，不进正文）
- [ ] 核对通讯邮箱 `hmtspine@163.com`（你原文写成 `163com`）
- [ ] 核对门牌地址（No. 555 East Youyi Road, Beilin District 是我补的）
- [ ] 确认 CRediT 分工与实际一致；是否标共同一作
- [ ] 确认 License 选择（默认 MIT，若想用 Apache-2.0 / GPL-3.0 现在改）

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
| 标题页（标题/作者/单位/邮箱/关键词） | `docs/TitlePage_v1.0.md` |
| Methods + Results 编辑入口 | `docs/Manuscript_Methods_Results_v0.1.md` |
| Discussion 编辑入口 + 审核要点 | `docs/Discussion_v1.0.md` |
| 声明（伦理/数据/代码/基金/COI/CRediT/AI） | `docs/Declarations_v1.0.md` |
| 图注（Fig 1–4 + 补充表清单） | `docs/Figure_legends_v1.0.md` |
| 数据来源与校验和 | `docs/DATA_SOURCES.md` |
| 表 S1（数据可得性） | `results/tables/TableS1_data_sources.tsv` |
| 表 S2（靶点注释） | `results/tables/TableS2_target_annotation.tsv` |
| 表 S3（跨端点） | `results/tables/TableS3_cross_endpoint.tsv` |

> 改了上面任一文件后，运行 `python3 scripts/assemble_manuscript.py` 更新合并稿。
> 不要手工复制粘贴，否则两份文件的数字会分叉——这是这类稿子最常见的低级错误。
> 标题页/声明/图注三个文件里的中文批注都写在 `>` 引用块中，组装时整段删除，不会混进英文稿。
