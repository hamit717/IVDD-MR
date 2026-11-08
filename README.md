# Site-resolved plasma proteome-wide Mendelian randomization of intervertebral disc disorders

Analysis code and summary statistics for the manuscript:

> **Plasma proteome-wide Mendelian randomization identifies a BMP-axis pair (BMP6/CHRDL1) and a mechanotransduction cluster (DAG1, DSG2, SCN4B) for lumbar disc herniation, with a site-specific metabolic signal (CLPS) in cervical disc disorder**

This repository contains the complete, runnable analysis chain: instrument extraction from the UKB-PPP cis-pQTL summary table, proteome-wide Wald-ratio MR against three FinnGen R12 endpoints, Bayesian colocalization with prior-sensitivity analysis, Steiger directionality, severity stratification, and Open Targets tractability/safety annotation.

---

## Key results

| Protein | Outcome | OR (95% CI) per 1-SD | P | PP.H4 (coloc) | Verdict |
|---|---|---|---|---|---|
| SCN4B | Lumbar disc herniation | 1.07 (1.04–1.09) | 7.5×10⁻⁷ | **0.997** | Supported |
| BMP6 | Lumbar disc herniation | 1.34 (1.19–1.50) | 5.1×10⁻⁷ | **0.944** | Supported |
| DAG1 | Lumbar disc herniation | 0.55 (0.43–0.71) | 2.7×10⁻⁶ | 0.852 | Supported (moderate) |
| DSG2 | Lumbar disc herniation | 0.84 (0.78–0.91) | 1.2×10⁻⁵ | 0.837 | Supported (moderate) |
| CLPS | **Cervical** disc disorder | 0.91 (0.87–0.95) | 8.8×10⁻⁶ | **0.978** | Supported, site-specific |
| CHRDL1 | Lumbar disc herniation | 0.89 (0.85–0.93) | 4.0×10⁻⁷ | not testable (chrX) | MR-level only |
| IGFBP3 | Lumbar / surgical | 1.13 / 1.30 | 8.7×10⁻¹² / 5.6×10⁻⁸ | 0.025 / 0.135 | **Refuted by coloc** |
| HLA-E, KHK | Lumbar disc herniation | 1.19 / 1.10 | 1.6×10⁻⁷ / 3.1×10⁻⁶ | no public regional data | Not testable |
| MST1 | Lumbar disc herniation | 1.03 (1.02–1.05) | 1.0×10⁻⁵ | 0.023 (n=527) | Excluded |

2,058 proteins with cis instruments (F 45.4–37,472; median 939); 11 Bonferroni-significant associations (10 proteins); 5 colocalization-supported pairs.

---

## Repository structure

```
.
├── scripts/
│   ├── fetch_region.py            # tabix-index-driven regional download (HTTP range, no full-file downloads)
│   ├── step2_mr_screen.R          # cis instrument extraction + proteome-wide Wald-ratio MR, 3 endpoints
│   ├── step3a_extract_outcome.sh  # extract outcome regions (±1 Mb) around each lead pQTL
│   ├── step3_coloc.R              # coloc.abf per protein–outcome pair + allele harmonisation
│   ├── step4_sensitivity.R        # p12 prior sensitivity, Steiger directionality, cis-region reverse MR
│   ├── step5_figures.R            # Figure 1 (forest), Figure 2 (loci), Figure 3 (prior sensitivity)
│   ├── step6_tables.R             # Table 1, Table 2 (evidence grading with verdicts)
│   ├── step7_severity.R           # cross-endpoint severity stratification + Figure 4
│   └── opentargets_query.py       # tractability, drug candidates, safety liabilities, disease associations
├── data/
│   ├── pqtl/                      # instruments table, protein→GCST map (inputs are downloadable, see docs/DATA_SOURCES.md)
│   ├── finngen/                   # FinnGen R12 endpoint summary stats (not committed — 2.3 GB)
│   └── ld/                        # reserved for an external LD reference panel
├── results/
│   ├── mr/                        # mr_screen_all.tsv, instruments_cis_raw.tsv, steiger.tsv, reverse_mr.tsv
│   ├── coloc/                     # coloc_results.tsv, coloc_sensitivity.tsv, extracted outcome regions
│   ├── tables/                    # Table 1, Table 2, Table S2, Table S3
│   └── figures/                   # Fig1–Fig4 (300 dpi PNG)
├── docs/
│   ├── DATA_SOURCES.md            # exact endpoints, accessions, download URLs, checksums
│   ├── Manuscript_Methods_Results_v0.1.md
│   ├── Discussion_v1.0.md
│   └── ...
├── env/                           # session_info.txt (R 4.4.1, coloc 5.2.3), checksums_md5.txt
└── run_all.sh                     # end-to-end orchestration
```

---

## Quick start

### Dependencies

R ≥ 4.4 with `data.table`, `readxl`, `coloc` (5.2.3); Python ≥ 3.9 (standard library only, plus `curl` on PATH). Full version record in `env/session_info.txt`.

```bash
Rscript -e 'install.packages(c("data.table","readxl","coloc"))'
```

### Inputs

Two downloads are required; both are public and free of registration (see `docs/DATA_SOURCES.md` for exact URLs and checksums):

1. **Instruments** — Sun et al. *Nature* 2023, Supplementary Table 10 (`sun2023_MOESM3.xlsx`, 34 MB) → `data/pqtl/`
2. **Outcomes** — FinnGen R12 endpoints `M13_CERVICDISC`, `M13_LUMBAR_PROLAPSE`, `M13_EARLY_LUMBAR_PROLAPSE` (~780 MB each) → `data/finngen/`

### Run

```bash
export R_LIBS_USER=~/Rlibs      # or your library path
bash run_all.sh
```

Individual steps can be run independently; each writes to `results/` and is idempotent except for the download steps.

---

## Methodological notes worth knowing before re-running

- **Regional extraction, not full downloads.** `fetch_region.py` parses a remote `.tbi` index and issues HTTP range requests for only the BGZF blocks covering a region. A ±1 Mb window costs 0.1–0.5 MB instead of 300 MB per protein. Implemented from scratch because `pysam` remote indexing was unreliable on the network used.
- **Column layouts differ between GWAS Catalog studies.** The harmonised files do not share a fixed column count (some carry an extra `rs_id` column). The header is read at runtime and columns are matched by name; do not hard-code indices.
- **Tabix index layout.** Within a `.tbi`, each reference sequence's bin list and linear index are stored **interleaved**, not as two separate blocks. Parsing them as two blocks silently corrupts downstream chunks.
- **Exposure data are the RAVA re-analysis (Loya et al., Nat Genet 2025)**, not the Sun 2023 original, because the latter's full summary statistics are only on Synapse (geo-restricted). Same cohort, higher-power re-analysis, harmonised to hg38 — a deliberate, documented substitution.
- **Some intermediate `.tsv` files are comma-separated** (`instruments_cis_raw.tsv`, `mr_screen_all.tsv`) as written by `data.table::fwrite` at the time; downstream scripts read them accordingly.
- **No external LD reference panel was used.** Each protein is instrumented by its lead cis variant only; there is no clumping step and no modelling of secondary cis signals. This is stated as a limitation in the manuscript.

---

## Data availability

All input data are public: UKB-PPP cis-pQTL summary statistics (Sun et al. 2023, Supplementary Table 10), GWAS Catalog harmonised summary statistics (accessions listed in `docs/DATA_SOURCES.md`), FinnGen release 12 endpoint summary statistics, and Open Targets Platform release queried 2026-11-08. No individual-level data were accessed.

## Citation

Manuscript in preparation. If you use this code, please cite the paper (details to be added on acceptance) and the primary data sources listed in `docs/DATA_SOURCES.md`.

## License

To be set by the authors (MIT for code and CC-BY-4.0 for figures are the conventional choices for this kind of repository).

## Contact

Corresponding author: *to be added*.
