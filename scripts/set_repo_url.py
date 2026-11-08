#!/usr/bin/env python3
"""Backfill the GitHub repository URL into all places that need it, then re-assemble.

Usage:  python3 scripts/set_repo_url.py <github-username> [--doi 10.5281/zenodo.xxxxxxx]

Touches:
  docs/Manuscript_Methods_Results_v0.1.md  (Software paragraph)
  docs/Declarations_v1.0.md               (Code availability)
  docs/TitlePage_v1.0.md                  (nothing, kept for symmetry)
  README.md                               (badge line, if present)
"""
import re
import subprocess
import sys
import pathlib

if len(sys.argv) < 2:
    sys.exit("usage: python3 scripts/set_repo_url.py <github-username> [--doi <doi>]")

user = sys.argv[1].strip().lstrip("@")
doi = None
if "--doi" in sys.argv:
    doi = sys.argv[sys.argv.index("--doi") + 1]

root = pathlib.Path(__file__).resolve().parent.parent
url = f"https://github.com/{user}/IVDD-MR"

edits = {
    "docs/Manuscript_Methods_Results_v0.1.md": [
        (r"\*\*\[TODO: repository URL — https://github\.com/&lt;account&gt;/IVDD-MR\]\*\*",
         f"**{url}**"),
    ],
    "docs/Declarations_v1.0.md": [
        (r"\*\*https://github\.com/\[TODO-github-username\]/IVDD-MR\*\*", f"**{url}**"),
        (r"\*\*\[TODO: DOI — 建 release 后自动生成\]\*\*",
         f"**https://doi.org/{doi}**" if doi else "**[TODO: DOI — 建 release 后自动生成]**"),
    ],
    "README.md": [
        (r"<!-- repo-url -->", f"<!-- repo-url: {url} -->"),
    ],
}

changed = []
for rel, subs in edits.items():
    p = root / rel
    if not p.exists():
        continue
    t = p.read_text()
    orig = t
    for pat, rep in subs:
        t = re.sub(pat, rep, t)
    if t != orig:
        p.write_text(t)
        changed.append(rel)

for rel in changed:
    print(f"✓ updated {rel}")

if not changed:
    print("• nothing to change (URL already backfilled?)")

print(f"\nRepository: {url}")
subprocess.run([sys.executable, str(root / "scripts/assemble_manuscript.py")], check=True)
left = (root / "docs/Manuscript_v0.2.md").read_text().count("[TODO")
print(f"remaining [TODO] in assembled manuscript: {left}")
