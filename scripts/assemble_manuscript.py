#!/usr/bin/env python3
"""Assemble docs/Manuscript_v0.2.md from the editable sources.

Editable sources (edit these, never the assembled file):
  docs/TitlePage_v1.0.md                    -> title, authors, affiliations, keywords
  docs/Manuscript_Methods_Results_v0.1.md   -> abstract, methods, results
  docs/Discussion_v1.0.md                   -> discussion (sections 4.1-4.10)
  docs/Declarations_v1.0.md                 -> ethics, data/code availability, funding, COI, CRediT, AI use
  docs/Figure_legends_v1.0.md               -> figure legends + supplementary table list

Lines starting with '>' in the title page / declarations / figure legends are Chinese
editorial notes and are stripped from the assembled manuscript.

Usage:  python3 scripts/assemble_manuscript.py
"""
import re
import pathlib
import sys

root = pathlib.Path(__file__).resolve().parent.parent
read = lambda p: (root / p).read_text()


def strip_notes(text: str, drop_first_heading: bool = True) -> str:
    """Remove blockquote editorial notes, horizontal rules and the file's own H1."""
    out = []
    for line in text.splitlines():
        s = line.strip()
        if s.startswith(">"):
            continue
        if s == "---":
            continue
        out.append(line)
    text = "\n".join(out)
    if drop_first_heading:
        text = re.sub(r"^\s*#\s.*?\n", "", text)          # drop first H1
    text = re.sub(r"\n{3,}", "\n\n", text)
    # demote remaining headings by nothing: source files use ## so they merge cleanly
    return text.strip().strip("-").strip()


mr = read("docs/Manuscript_Methods_Results_v0.1.md")
dis = read("docs/Discussion_v1.0.md")

front = strip_notes(read("docs/TitlePage_v1.0.md"))
decl = strip_notes(read("docs/Declarations_v1.0.md"))
legends = strip_notes(read("docs/Figure_legends_v1.0.md"))

abstract = "## Abstract" + mr.split("## Abstract")[1].split("---")[0]
methods = "## Methods" + mr.split("## Methods")[1].split("## Results")[0]
results = "## Results" + mr.split("## Results")[1]
results = results.split("## 工作区产物索引")[0].rstrip().rstrip("-").rstrip()

disc = "## Discussion" + dis.split("## 4. Discussion")[1]
disc = disc.split("## 审核要点")[0].rstrip().rstrip("-").rstrip()

# Demote the source headings (##) so they nest under the section H2.
demote = lambda s: re.sub(r"(?m)^##\s+", "### ", s)
legends = "## Figure legends\n\n" + demote(legends)
decl = "## Declarations\n\n" + demote(decl)

header = """# Manuscript v0.2 (assembled) — Title page / Abstract / Methods / Results / Discussion / Declarations / References / Legends

> 自动生成文件，请勿直接编辑。改动请改 `docs/` 下的 5 个编辑入口，然后运行
> `python3 scripts/assemble_manuscript.py` 重新组装（入口清单见脚本头部注释）。
> 投稿前清单见 `docs/TODO_before_submission.md`；正文占位符已清零。
> 参考文献：正文写方括号 ref:键名 占位，条目在 `docs/references.json`，组装时自动编号（Vancouver）。

"""

body = "\n\n---\n\n".join([
    header + front,
    abstract.strip(),
    methods.strip(),
    results.strip(),
    disc.strip(),
    decl,
])

# Number citations in order of first appearance and build the reference list.
sys.path.insert(0, str(root / "scripts"))
from build_references import renumber, reference_list  # noqa: E402

body, order, missing = renumber(body)
if missing:
    raise SystemExit(f"unknown reference keys: {sorted(missing)}")
unused = sorted(set(__import__("json").loads(
    (root / "docs/references.json").read_text())) - set(order))
if unused:
    print(f"  ! references defined but never cited: {unused}")

refs = "## References\n\n" + reference_list(order)

out = body + "\n\n---\n\n" + refs + "\n\n---\n\n" + legends + "\n"

dest = root / "docs/Manuscript_v0.2.md"
dest.write_text(out)

words = len(re.findall(r"[A-Za-z][A-Za-z'\-]+", out))
print(f"wrote {dest.relative_to(root)}")
print(f"  ~{words} English words | refs {len(order)} | [TODO] {out.count('[TODO')} "
      f"| [ref: {out.count('[ref:')} | [confirm] {out.count('[confirm')}")
