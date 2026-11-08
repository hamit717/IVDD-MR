#!/usr/bin/env python3
"""Turn [ref:key] placeholders into numbered Vancouver citations and build the reference list.

The bibliography lives in docs/references.json, keyed by short label. Each entry was
retrieved from Europe PMC by PMID (the pmid field is kept for verification).

Usage:  python3 scripts/build_references.py [--check]
        Called automatically by scripts/assemble_manuscript.py.
"""
import json
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
REFS = json.loads((ROOT / "docs/references.json").read_text())
PATTERN = re.compile(r"\[((?:ref:[a-z0-9_]+)(?:;ref:[a-z0-9_]+)*)\]")


def format_entry(e):
    loc = str(e["year"])
    if e.get("volume"):
        loc += ";" + e["volume"]
        if e.get("issue"):
            loc += f"({e['issue']})"
    if e.get("pages"):
        loc += ":" + e["pages"]
    tail = f" doi:{e['doi']}" if e.get("doi") else ""
    return f"{e['authors']}. {e['title']}. {e['journal']}. {loc}.{tail}"


def renumber(text):
    """Assign citation numbers in order of first appearance. Returns (text, order, missing)."""
    order = []
    missing = set()

    def repl(m):
        keys = [k.split(":", 1)[1] for k in m.group(1).split(";")]
        nums = []
        for k in keys:
            if k not in REFS:
                missing.add(k)
                continue
            if k not in order:
                order.append(k)
            nums.append(str(order.index(k) + 1))
        return "[" + ",".join(sorted(nums, key=int)) + "]" if nums else "[?]"

    return PATTERN.sub(repl, text), order, missing


def reference_list(order):
    lines = []
    for i, k in enumerate(order, 1):
        lines.append(f"{i}. {format_entry(REFS[k])}")
    return "\n".join(lines)


def main():
    text = (ROOT / "docs/Manuscript_v0.2.md").read_text()
    body = text.split("## References")[0]
    body, order, missing = renumber(body)
    if missing:
        sys.exit(f"unknown reference keys: {sorted(missing)}")
    print(f"placed {len(order)} references, {sum(1 for _ in PATTERN.finditer(body))} citation points")
    print()
    print(reference_list(order))
    if "--check" in sys.argv and order:
        unused = [k for k in REFS if k not in order]
        if unused:
            print(f"\nWARNING: defined but never cited: {unused}")
    elif "--check" in sys.argv:
        print("(assembled manuscript is already numbered; nothing to check)")


if __name__ == "__main__":
    main()
