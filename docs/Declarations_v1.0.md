# Declarations

> 编辑入口文件。位于正文之后、参考文献之前（BMC/Springer Nature 标准顺序）。
> `[confirm]` = 我按惯例起草、需你确认的表述；`[TODO]` = 投稿前必须填实。

## Ethics approval and consent to participate

Not applicable. This study is a secondary analysis of publicly available, de-identified summary-level genetic association data. No individual-level data were accessed, and no new human participants or animals were involved. All original studies obtained ethics approval and informed consent from their participants, as described in the primary publications and data-source documentation (Supplementary Table S1).

## Consent for publication

Not applicable.

## Availability of data and materials

All data analysed in this study are publicly available; no new data were generated. The datasets and their exact accessions, versions and download locations are listed in Supplementary Table S1 and documented in the repository (`docs/DATA_SOURCES.md`):

- **Instruments** — lead cis-pQTL summary statistics from Sun et al., *Nature* 2023 (Supplementary Table 10), derived from the UK Biobank Pharma Proteomics Project.
- **Regional exposure summary statistics** — harmonised European-ancestry UKB-PPP Olink re-analysis by Loya et al., *Nature Genetics* 2025, accessed through the EBI GWAS Catalog (accessions listed per protein in Supplementary Table S1).
- **Outcomes** — FinnGen release 12 endpoint summary statistics for `M13_CERVICDISC`, `M13_LUMBAR_PROLAPSE` and `M13_EARLY_LUMBAR_PROLAPSE` (https://r12.finngen.fi/).
- **Target annotation** — Open Targets Platform, queried 2026-11-08 via the public GraphQL API.

Access to UK Biobank individual-level data is governed by the UK Biobank Access Management System; the present work used only summary statistics released by the primary studies and therefore required no additional application.

## Code availability

The complete analysis chain — instrument extraction, proteome-wide Wald-ratio MR, regional summary-statistic retrieval, colocalization, prior-sensitivity analysis, Steiger directionality, severity stratification, figure and table generation, and Open Targets annotation — is available at:

**https://github.com/hamit717/IVDD-MR**

A frozen release of the code corresponding exactly to the version used for this manuscript is archived at Zenodo (DOI 10.5281/zenodo.24098303). Scripts are written in R 4.4.1 (coloc 5.2.3, data.table 1.18.4, readxl 1.5.0) and Python ≥3.9 (standard library only); the full session record is provided as `env/session_info.txt`.

## Competing interests

The authors declare that they have no competing interests.

> **[confirm]** 本分析全部使用公开汇总数据，未接受任何企业资助、未持有相关专利、未担任相关企业顾问。如果四位作者中有任何人与脊柱器械/生物制药企业存在咨询、讲课、持股关系，请在此逐条列出——这类声明漏报被发现，后果远大于申报本身。

## Funding

The authors received no specific funding for this work.

> **[confirm]** 与 Acknowledgements 的 "None" 保持一致。

## Authors' contributions (CRediT)

| Author | Roles |
|---|---|
| **Jinwen Zhu** | Conceptualization; Data curation; Formal analysis; Methodology; Software; Visualization; Writing – original draft |
| **Jianbin Guan** | Data curation; Investigation; Validation; Writing – review & editing |
| **Sibo Wang** | Formal analysis; Methodology; Validation; Writing – review & editing |
| **Haimiti Abudouaini** | Conceptualization; Supervision; Resources; Project administration; Writing – review & editing |

All authors read and approved the final manuscript and agree to be accountable for all aspects of the work.

> **[confirm] 这张表是我按"谁干了什么最合理"倒推的分配，不是事实记录。** 期刊要求 CRediT 与实际贡献一致，被追问时要能说清。如果实际分工不同（比如两位作者共同一作、或某位只做了数据整理），现在改比返修时改省事得多。若需标注共同第一作者，请告知，我在标题页加 "These authors contributed equally"。

## Acknowledgements

None.

## Use of artificial intelligence

The authors used an AI-assisted analysis environment to develop and debug the analysis code and to draft and revise sections of the manuscript text. All analytical decisions, the interpretation of results, and the final content were reviewed, verified and approved by the authors, who take full responsibility for the content of this publication. No AI tool is listed as an author, and no AI tool was used to generate or alter any figure data.

> **[confirm] 这段话建议保留。** BMC / Springer Nature 自 2023 年起强制要求在手稿中披露生成式 AI 的使用（如未披露而被编辑发现，按学术不端处理）；同时他们的政策明确"AI 不能作为作者"。主动写清楚比被问出来好。披露位置就在 Declarations 末尾，不影响正文。
