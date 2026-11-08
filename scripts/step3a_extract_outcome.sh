#!/usr/bin/env bash
# 从 FinnGen R12 三个 endpoint 中抽取 10 个显著蛋白 lead SNP ±1Mb 窗口
set -euo pipefail
cd "$(dirname "$0")/.."
OUT="results/coloc"; mkdir -p "$OUT"

# 染色体<TAB>起点<TAB>终点<TAB>蛋白
cat > /tmp/ivdd_windows.tsv <<'EOF'
6	6719826	8719826	BMP6
23	109535177	111535177	CHRDL1
6	34785450	36785450	CLPS
3	48435644	50435644	DAG1
18	30504458	32504458	DSG2
6	30358297	32358297	HLA-E
7	44921046	46921046	IGFBP3
2	26092384	28092384	KHK
3	48668079	50668079	MST1
11	117142548	119142548	SCN4B
EOF

for ep in M13_CERVICDISC M13_LUMBAR_PROLAPSE M13_EARLY_LUMBAR_PROLAPSE; do
  gz="data/finngen/finngen_R12_${ep}.gz"
  out="${OUT}/outcome_${ep}.tsv"
  echo "[$(date +%H:%M:%S)] 抽取 ${ep} ..."
  gzip -dc "$gz" | awk -F'\t' '
    BEGIN{
      while ((getline l < "/tmp/ivdd_windows.tsv") > 0) {
        split(l, f, "\t")
        n = ++cnt[f[1]]
        lo[f[1], n] = f[2]; hi[f[1], n] = f[3]; pr[f[1], n] = f[4]
      }
    }
    NR==1 {print "protein\t" substr($0,2); next}
    {
      c = $1; p = $2
      if (!(c in cnt)) next
      for (i = 1; i <= cnt[c]; i++)
        if (p >= lo[c, i] && p <= hi[c, i]) { print pr[c, i] "\t" $0; next }
    }
  ' > "$out"
  echo "[$(date +%H:%M:%S)] ${ep}: $(wc -l < "$out") 行 -> $out"
done
echo "全部完成"
