#!/usr/bin/env bash
# End-to-end pipeline: proteome-wide cis-MR + colocalization for intervertebral disc disorders.
#
#   bash run_all.sh              # run everything that has inputs available
#   bash run_all.sh 2 3          # run selected steps only
#
# Requires: R (data.table, readxl, coloc), python3, curl. See README.md and docs/DATA_SOURCES.md.

set -euo pipefail
cd "$(dirname "$0")"

export R_LIBS_USER="${R_LIBS_USER:-$HOME/Rlibs}"
R="Rscript --vanilla"
STEPS=("$@")
want() { [ ${#STEPS[@]} -eq 0 ] && return 0; for s in "${STEPS[@]}"; do [ "$s" = "$1" ] && return 0; done; return 1; }
have() { [ -s "$1" ] || { echo "  [missing] $1"; return 1; }; }

echo "== 0. input checks ==============================================="
INSTR=data/pqtl/sun2023_MOESM3.xlsx
have "$INSTR" || { echo "STOP: download Supplementary Table 10 (see docs/DATA_SOURCES.md)"; exit 1; }
N_FG=$(ls data/finngen/finngen_R12_M13_*.gz 2>/dev/null | wc -l | tr -d ' ')
echo "  instruments: $INSTR"
echo "  FinnGen endpoint files present: $N_FG / 3"
for f in data/finngen/finngen_R12_M13_*.gz; do
  [ -f "$f" ] || continue
  gzip -t "$f" 2>/dev/null && echo "  ok  $(basename "$f")" || echo "  BAD $(basename "$f") — re-download before proceeding"
done

if want 2; then
  echo "== 2. instrument extraction + proteome-wide MR ===================="
  $R scripts/step2_mr_screen.R
fi

if want 3; then
  echo "== 3. regional extraction + colocalization ========================"
  have data/pqtl/protein_gcst_map.tsv || echo "  note: build protein_gcst_map.tsv first (see docs/DATA_SOURCES.md §2)"
  bash scripts/step3a_extract_outcome.sh
  # regional download of exposure windows (cached; skips files already present)
  $R scripts/step3_coloc.R
fi

if want 4; then
  echo "== 4. prior sensitivity, Steiger, reverse MR ======================"
  $R scripts/step4_sensitivity.R
fi

if want 5; then
  echo "== 5. figures ====================================================="
  $R scripts/step5_figures.R
fi

if want 6; then
  echo "== 6. tables ======================================================"
  $R scripts/step6_tables.R
fi

if want 7; then
  echo "== 7. severity stratification ====================================="
  $R scripts/step7_severity.R
fi

if want 8; then
  echo "== 8. target annotation (Open Targets) ============================"
  python3 scripts/opentargets_query.py
fi

echo "== done =========================================================="
echo "  results/mr          MR screen + instruments"
echo "  results/coloc       colocalization (main + sensitivity)"
echo "  results/tables      Table 1, Table 2, Table S2, Table S3"
echo "  results/figures     Fig 1-4"
