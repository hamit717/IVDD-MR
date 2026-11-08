#!/usr/bin/env python3
"""Assemble docs/Manuscript_v0.2.md from the two editable sources.

Editable sources (edit these, never the assembled file):
  docs/Manuscript_Methods_Results_v0.1.md   -> title, abstract, methods, results
  docs/Discussion_v1.0.md                   -> discussion (sections 4.1-4.10)

Usage:  python3 scripts/assemble_manuscript.py
"""
import re
import pathlib

root = pathlib.Path(__file__).resolve().parent.parent
mr = (root / "docs/Manuscript_Methods_Results_v0.1.md").read_text()
dis = (root / "docs/Discussion_v1.0.md").read_text()

title_block = mr.split("## Abstract")[0]
abstract = "## Abstract" + mr.split("## Abstract")[1].split("---")[0]
methods = "## Methods" + mr.split("## Methods")[1].split("## Results")[0]
results = "## Results" + mr.split("## Results")[1]
results = results.split("## 工作区产物索引")[0].rstrip().rstrip("-").rstrip()

disc = "## Discussion" + dis.split("## 4. Discussion")[1]
disc = disc.split("## 审核要点")[0].rstrip().rstrip("-").rstrip()

header = """# Manuscript v0.2 (assembled) — Title / Abstract / Methods / Results / Discussion

> 自动生成文件，请勿直接编辑。改动请改 `Manuscript_Methods_Results_v0.1.md` 或 `Discussion_v1.0.md`，
> 然后运行 `python3 scripts/assemble_manuscript.py` 重新组装。
> 剩余待办见 `docs/TODO_before_submission.md`；`[ref]` 与 `[TODO]` 需在投稿前清零。

---

"""

out = "\n\n---\n\n".join([
    header + title_block.strip(),
    abstract.strip(),
    methods.strip(),
    results.strip(),
    disc.strip(),
]) + "\n"

dest = root / "docs/Manuscript_v0.2.md"
dest.write_text(out)

words = len(re.findall(r"[A-Za-z][A-Za-z'\-]+", out))
print(f"wrote {dest.relative_to(root)}")
print(f"  ~{words} English words | [TODO] {out.count('[TODO')} | [ref] {out.count('[ref]')}")
