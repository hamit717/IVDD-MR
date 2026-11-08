#!/usr/bin/env python3
"""查询 Open Targets 平台：靶点成药性、临床阶段药物、安全事件、基线表达
用法: python3 scripts/opentargets_query.py
输出: results/tables/target_tractability.tsv
"""
import json, subprocess, csv, os

PROXY = "http://127.0.0.1:7890"
API = "https://api.platform.opentargets.org/api/v4/graphql"
OUT = "results/tables/target_tractability.tsv"
PROTEINS = ["IGFBP3", "BMP6", "CHRDL1", "DAG1", "SCN4B", "DSG2", "CLPS", "MST1", "HLA-E", "KHK"]

SEARCH = 'query($q: String!){ search(queryString:$q, entityNames:["target"]){ hits { id name entity } } }'

TARGET = """
query($id: String!) {
  target(ensemblId: $id) {
    id approvedSymbol approvedName biotype functionDescriptions
    tractability { label modality value }
    safetyLiabilities { event }
    drugAndClinicalCandidates { count rows { maxClinicalStage drug { name } } }
    associatedDiseases(page: {index: 0, size: 8}) { count rows { disease { name } score } }
  }
}
"""

def gql(query, variables):
    payload = json.dumps({"query": query, "variables": variables})
    r = subprocess.run(["curl", "-s", "--max-time", "60", "-x", PROXY, API,
                        "-H", "Content-Type: application/json", "-d", payload],
                       capture_output=True, text=True)
    try:
        return json.loads(r.stdout)
    except Exception:
        return {}

def ensembl_for(sym):
    d = gql(SEARCH, {"q": sym})
    for h in d.get("data", {}).get("search", {}).get("hits", []):
        if h["name"].upper() == sym.upper() and h["entity"] == "target":
            return h["id"]
    return None

rows = []
for sym in PROTEINS:
    eid = ensembl_for(sym)
    if not eid:
        print(f"{sym:8s} 未找到 Ensembl ID"); continue
    d = gql(TARGET, {"id": eid})
    t = d.get("data", {}).get("target")
    if not t:
        print(f"{sym:8s} 查询失败 {str(d)[:80]}"); continue

    tract = t.get("tractability") or []
    mods = {}
    for x in tract:
        if x.get("value"):
            mods.setdefault(x.get("modality") or "?", []).append(x["label"])

    kd = t.get("drugAndClinicalCandidates") or {}
    drows = kd.get("rows") or []
    names = sorted({(x.get("drug") or {}).get("name", "") for x in drows if (x.get("drug") or {}).get("name")})
    stages = sorted({x.get("maxClinicalStage") for x in drows if x.get("maxClinicalStage")})

    safe = t.get("safetyLiabilities") or []

    rows.append({
        "symbol": sym, "ensembl": t["id"], "name": t.get("approvedName", ""),
        "tractability_SM": "; ".join(mods.get("SM", [])),
        "tractability_AB": "; ".join(mods.get("AB", [])),
        "tractability_other": "; ".join(sum((v for k, v in mods.items() if k not in ("SM", "AB")), [])),
        "n_clinical_candidates": kd.get("count", 0),
        "max_clinical_stage": ",".join(stages),
        "drug_names": "; ".join(names[:6]),
        "n_safety_events": len(safe),
        "safety_events": "; ".join(sorted({(x.get("event") or "") for x in safe})[:6]),
        "top_associated_diseases": "; ".join(
            f"{(r.get('disease') or {}).get('name','')}({r.get('score',0):.2f})"
            for r in ((t.get("associatedDiseases") or {}).get("rows") or [])[:8]),
        "n_associated_diseases": (t.get("associatedDiseases") or {}).get("count", 0),
        "function": ((t.get("functionDescriptions") or [""])[0])[:400],
    })
    print(f"{sym:8s} {eid} 临床候选={kd.get('count',0):>3} 最高阶段={','.join(stages) or '-':<12} 安全事件={len(safe):>2}")

os.makedirs("results/tables", exist_ok=True)
if rows:
    with open(OUT, "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0].keys()), delimiter="\t")
        w.writeheader(); w.writerows(rows)
    print(f"\n已保存 {OUT}  ({len(rows)} 个靶点)")
