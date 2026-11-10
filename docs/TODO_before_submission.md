# 投稿前待办清单

状态（2026-11-10）：正文占位符已清零（`[TODO]` 0 / `[confirm]` 0 / `[ref]` 0），6,433 词，14 条文献，图件已导出 300 dpi，投稿信已起草。仅剩 Zenodo 记录作者名待修 + 撞车复查。
以下按"必须做 / 应该做 / 可选"三档排列，全部清完后即可投稿。

---

## A. 必须完成（缺一项就会被编辑部退回）

### A1. 代码仓库上线并回填 URL —— 已完成（2026-11-09）
- [x] 仓库已上线：**https://github.com/hamit717/IVDD-MR**（公开，main = ff40637）
- [x] URL 已回填至 Methods Software 段与 Declarations Code availability
- [x] tag `v1.0.0` 已推送（Zenodo 归档用）
- [x] Release 已发布，Zenodo 已归档：**DOI 10.5281/zenodo.24098303**（concept 10.5281/zenodo.24098302），已回填 Declarations 与 README
- [ ] **Zenodo 记录作者名需修**：当前显示 "PyGuy2"（GitHub 显示名），改为四位作者 + 单位

### A2. 参考文献 —— 已完成（2026-11-08）
- [x] 12 处引用点全部配真实文献，共 **14 条**，编号按出现顺序（Vancouver）
- [x] 每条均按 PMID 从 PubMed / Europe PMC 取书目与 DOI，存放在 `docs/references.json`
- [x] 正文写 `[ref:键名]`，`assemble_manuscript.py` 自动编号并追加 References 节；改句子不会乱号
- [ ] **你终审两件事**：① 14 条文献是否都该引（尤其 4.7 与三篇对照研究）；② 4 处为配文献而改写的原句（清单见 `Discussion_v1.0.md` 审核要点第 7 条）
- [ ] 若你手上有 CHRDL1–BMP6 直接结合的证据，或"中文研究"的真实出处，给我，我改回并补引

| # | 文献 | 用在哪 |
|---|---|---|
| 1 | Chen 2022 *Cells* — 牵张力经 BMP-2/6→SMAD1/5/8 诱导人纤维环细胞成骨 | 4.2 BMP6 机制 |
| 2 | Wu 2024 *Cell Res* — TGF-β/BMP 在骨与软骨中的调控（软骨细胞肥大、基质矿化） | 4.2 BMP6 机制 |
| 3 | Zieba 2022 *Bone Res* — TGFβ/BMP 信号调控可挽救椎间盘退变（filamin B 模型） | 4.2 BMP 随退变升高 |
| 4 | Kan 2026 *J Orthop Surg Res* — 多组学 MR 优先定位 BMP6（含 DLK1，PP.H4 0.99） | 4.2、4.7 独立重复 |
| 5 | Sakuta 2001 *Science* — ventroptin/CHRDL1 为 BMP-4 拮抗剂 | 4.2 CHRDL1 |
| 6 | Brazil 2015 *Trends Cell Biol* — BMP 拮抗剂家族机制综述 | 4.2、4.8 |
| 7 | Walimbe 2026 *Lancet Neurol* — dystroglycanopathy 机制与治疗 | 4.3 DAG1 |
| 8 | Shimizu 2017 *JBC* — Navβ4 胞外域同源二聚体介导细胞黏附 | 4.3 SCN4B |
| 9 | Malhotra 2000 *JBC* — β 亚基招募 ankyrin 至细胞接触点 | 4.3 SCN4B |
| 10 | Badhiwala 2020 *Nat Rev Neurol* — 退变性颈髓病综述 | 4.5 颈椎流行病学 |
| 11 | Zhang 2026 *BMC Musculoskelet Disord* — 多域危险因素与 IVDD 的 MR 荟萃 | 4.5 代谢 |
| 12 | Ren 2025 *Eur Spine J* — 4,907 蛋白血浆蛋白组 MR（无部位细分、无共定位） | 4.7 对照 |
| 13 | Zheng 2024 *JOR Spine* — 91 种炎症蛋白与脊柱退变（含颈椎，无共定位） | 4.7 对照 |
| 14 | May 2019 *Curr Stem Cell Res Ther* — BMP 家族细胞因子在脊柱融合中的应用 | 4.8 转化 |

### A3. 投稿要件（已起草，待你确认/填空）
- [x] Author contributions（CRediT，4 人）→ `docs/Declarations_v1.0.md`
- [x] Funding / Competing interests / Acknowledgements → 同上
- [x] Data availability / Code availability → 同上
- [x] AI 使用声明（Springer Nature 强制项）→ 同上
- [x] Figure legends（4 张）→ `docs/Figure_legends_v1.0.md`
- [x] 标题页（标题、跑题、作者、单位、邮箱、关键词）→ `docs/TitlePage_v1.0.md`
- [x] LICENSE（MIT + 图表 CC BY 4.0）
- [x] ORCID：不填（海医生决定；ART 系统可跳过，标题页已改中性说明）
- [x] 通讯电话：+86 178 8208 5070（已填入标题页与投稿信）
- [x] 通讯邮箱已按 `hmtspine@163.com` 定稿
- [x] 门牌地址已定稿（No. 555 East Youyi Road, Beilin District）
- [x] CRediT 分工已确认与实际一致；不标共同一作（2026-11-10）
- [x] License：MIT（代码）+ CC BY 4.0（图表），已上线

### A4. 撞车复查
- [ ] 投稿前 3 天内跑一次 PubMed 检索（检索式见开工包），确认"部位细分 × 蛋白组 × 共定位"仍无人发表
- [ ] 若发现撞车：优先改成"以 DAG1 严重度梯度 + IGFBP3 阴性共定位"为卖点的版本，仍可成立

---

## B. 应该完成（明显提高过审率）

### B1. 海医生审核 6 处临床表述 —— 已完成（2026-11-10）
- [x] ①4.2 终板表述按 B 方案软化（"Modic changes are thought to reflect"）
- [x] ②4.3 力学段不补临床观察，保持现状（现为"假说生成"措辞，审稿人无从要求病例数据）
- [x] ③4.5 代谢假说符合门诊印象，原表述保留
- [x] ④4.8 给药途径保持现状
- [x] ⑤作者顺序/无共一/CRediT/无 COI/无基金 —— 全部确认
- [x] ⑥四处为配文献改写的原句 —— 全部接受
- 裁决记录见 `docs/ReviewPoints_临床审阅表_v1.0.md` 首段

### B2. 图 2 与图 4 的图注数字复核
图由脚本生成，但图注里的 PP.H4 与 OR 需逐个对 `results/tables/` 核一遍，避免图文不一致（这是最常见的返修原因）。

### B3. 阈值敏感性 —— 已完成（2026-11-10）
- [x] 按 PP.H4 ≥ 0.75 重判：p12=1e-5 与 1e-4 下仍是同样 5 对；最严先验 1e-6 下仅 SCN4B、CLPS 通过；IGFBP3/MST1 在任何先验下都不通过（最高 0.61）
- [x] 结果表 `results/tables/TableS4_coloc_threshold_sensitivity.tsv`，结论句已写入 Results 敏感性段，图注补充表清单已加 S4

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
| 参考文献库（14 条，含 PMID/DOI） | `docs/references.json` |
| 数据来源与校验和 | `docs/DATA_SOURCES.md` |
| 表 S1（数据可得性） | `results/tables/TableS1_data_sources.tsv` |
| 表 S2（靶点注释） | `results/tables/TableS2_target_annotation.tsv` |
| 表 S3（跨端点） | `results/tables/TableS3_cross_endpoint.tsv` |

> 改了上面任一文件后，运行 `python3 scripts/assemble_manuscript.py` 更新合并稿。
> 不要手工复制粘贴，否则两份文件的数字会分叉——这是这类稿子最常见的低级错误。
> 标题页/声明/图注三个文件里的中文批注都写在 `>` 引用块中，组装时整段删除，不会混进英文稿。
