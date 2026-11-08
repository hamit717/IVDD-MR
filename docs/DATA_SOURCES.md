# Data sources

Every input used in this project is public. Nothing here requires an application, a data-access agreement, or an individual-level data transfer. Exact accessions, URLs and checksums are given so the analysis can be rebuilt without guesswork.

Queried / downloaded: **2026-11-07 to 2026-11-08**.

---

## 1. Genetic instruments for plasma proteins (exposure)

**Sun BB, et al. Plasma proteomic associations with genetics and health in the UK Biobank. _Nature_ 2023;622:329–338.** PMID 37794186.

- File: Supplementary Table 10 (genome-wide significant pQTL, both cohorts)
- Direct URL: `https://static-content.springer.com/esm/art%3A10.1038%2Fs41586-023-06592-6/MediaObjects/41586_2023_6592_MOESM3_ESM.xlsx`
- Size: 34 MB (worksheet `ST10` contains the merged-cohort significant pQTL; header is on **row 5**, not row 1)
- MD5: `aeb2acdc5586034e91197658a10a7d70`
- Local path: `data/pqtl/sun2023_MOESM3.xlsx`

Extraction rule (implemented in `step2_mr_screen.R`): rows with `cis/trans == "cis"`, valid `rsID`, P < 5×10⁻⁸, F = (β/SE)² ≥ 10 → **2,058 proteins / 2,060 variants** (F 45.4–37,472, median 939).

> Note: `ST16` (independent signals + credible sets) is available in the same workbook and was not used, because the design is one lead cis variant per protein.

---

## 2. Regional summary statistics for colocalization (exposure side)

**Loya H, et al. A scalable variational inference approach for increased mixed-model association power. _Nature Genetics_ 2025.** PMID **39789286**. UK Biobank Olink plasma proteome re-analysed with RAVA, n = 47,745, European ancestry, harmonised to hg38.

Why this and not Sun 2023: the Sun 2023 full summary statistics are distributed through Synapse (`syn51364943`), which returns **HTTP 403 / `GEO_RESTRICTION`** for mainland-China IP addresses under the current NIH data-access policy. The RAVA re-analysis is the same cohort re-processed at higher power and is mirrored on EBI with tabix indexes, which is what makes regional extraction possible.

| Protein | GWAS Catalog accession | harmonised file |
|---|---|---|
| IGFBP3 | GCST90469529 | `.../GCST90469001-GCST90470000/GCST90469529/harmonised/GCST90469529.h.tsv.gz` |
| BMP6 | GCST90468454 | `.../GCST90468001-GCST90469000/GCST90468454/harmonised/GCST90468454.h.tsv.gz` |
| CHRDL1 | GCST90468750 | `.../GCST90468001-GCST90469000/GCST90468750/harmonised/GCST90468750.h.tsv.gz` |
| DAG1 | GCST90468943 | `.../GCST90468001-GCST90469000/GCST90468943/harmonised/GCST90468943.h.tsv.gz` |
| SCN4B | GCST90470551 | `.../GCST90470001-GCST90471000/GCST90470551/harmonised/GCST90470551.h.tsv.gz` |
| DSG2 | GCST90469042 | `.../GCST90469001-GCST90470000/GCST90469042/harmonised/GCST90469042.h.tsv.gz` |
| CLPS | GCST90468786 | `.../GCST90468001-GCST90469000/GCST90468786/harmonised/GCST90468786.h.tsv.gz` |
| MST1 | GCST90469952 | `.../GCST90469001-GCST90470000/GCST90469952/harmonised/GCST90469952.h.tsv.gz` |

Base URL: `https://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/`

**Not available and therefore excluded from colocalization:**

- **HLA-E, KHK** — no full regional summary statistics published on EBI; the KHK accession resolved to HTTP 404 at time of access.
- **CHRDL1** — accession exists (GCST90468750) and downloads, but the harmonised file contains **chromosomes 1–22 only**. The CHRDL1 lead pQTL `rs5942957` is at **chrX:110,535,177**, so the region cannot be extracted. This is a systematic gap in harmonised pQTL resources, not a study-specific choice, and it is reported as such in the manuscript.

The accession → protein mapping was built from the GWAS Catalog study list:
`https://ftp.ebi.ac.uk/pub/databases/gwas/releases/latest/gwas-catalog-download-studies-v1.0.3.1.tsv` (MD5 `6a017554b44995ed42d3d44c43fde5a9`).

---

## 3. Outcomes (FinnGen release 12)

Base URL: `https://storage.googleapis.com/finngen-public-data-r12/summary_stats/release/`

| Endpoint | Official `phenostring` | Cases | Controls | File | MD5 |
|---|---|---|---|---|---|
| `M13_CERVICDISC` | Cervical disc disorders | 17,993 | 353,224 | `finngen_R12_M13_CERVICDISC.gz` (778 MB) | `91042cbe830d7ec0cae055e6d4c8003f` |
| `M13_LUMBAR_PROLAPSE` | Lumbar disc prolapse | 35,290 | 353,224 | `finngen_R12_M13_LUMBAR_PROLAPSE.gz` (781 MB) | `23f25059c41643943ad0c20e3ac84390` |
| `M13_EARLY_LUMBAR_PROLAPSE` | **Early lumbar disc prolapse, operated** | 4,559 | 353,224 | `finngen_R12_M13_EARLY_LUMBAR_PROLAPSE.gz` (774 MB) | `42205fc1836b42f01c59767cb0729879` |

Case counts and official phenotype labels verified against the FinnGen endpoint API on 2026-11-08:

```bash
curl "https://r12.finngen.fi/api/pheno/M13_EARLY_LUMBAR_PROLAPSE"
# -> {"phenocode":"M13_EARLY_LUMBAR_PROLAPSE","phenostring":"Early lumbar disc prolapse, operated",
#     "num_cases":4559,"num_controls":353224,...}
```

Full endpoint manifest (2,470 phenotypes, used for the initial screen): `https://storage.googleapis.com/finngen-public-data-r12/summary_stats/finngen_R12_manifest.tsv`

> The third endpoint is **defined by operation**, which is what makes it usable as a severity anchor: an ICD-coded diagnosis records contact with specialist care, whereas a disc operation records disease severe enough to be treated surgically. The "early" qualifier in the official label is not documented in the endpoint metadata; we therefore describe the endpoint by its official string and treat "operated" as the operative content, flagging the residual ambiguity in the manuscript's limitations.

Files are BGZF-compressed, tab-separated, and carry an `rsids` column alongside chromosome/position, which allows harmonisation by rsID. Verify integrity with `gzip -t` before running.

> Download caveat: direct connections to `storage.googleapis.com` were unstable from the network used (repeated stalls at ~50 KB/s with silent connection death). Downloads required `--retry-all-errors --speed-limit 10000 --speed-time 60` and were resume-capable. This is a network property, not a data property.

---

## 4. Target annotation

**Open Targets Platform**, GraphQL API `https://api.platform.opentargets.org/api/v4/graphql`, queried 2026-11-08.
Retrieved per target: `tractability` (small-molecule / antibody buckets), `drugAndClinicalCandidates`, `safetyLiabilities`, `associatedDiseases` (top 8 by score), `functionDescriptions`.
Output: `results/tables/TableS2_target_annotation.tsv`, produced by `scripts/opentargets_query.py`.

---

## 5. Software

| Component | Version |
|---|---|
| R | 4.4.1 (2024-06-14) |
| coloc | 5.2.3 |
| data.table | 1.18.4 |
| readxl | 1.5.0 |
| Python | 3.x, standard library only (custom tabix reader) |

Full `sessionInfo()` in `env/session_info.txt`; MD5 of all local inputs in `env/checksums_md5.txt`.

> Two tooling constraints shaped the implementation and are recorded here because they affect reproducibility: (i) GitHub was unreachable from the working environment, so `TwoSampleMR` could not be installed and all MR estimators (Wald ratio, and the IVW/Egger/weighted-median code paths for multi-variant instruments) were implemented directly against `data.table`; (ii) `pysam` remote tabix access timed out, so `scripts/fetch_region.py` was written to parse `.tbi` indexes manually.
