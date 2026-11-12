#!/usr/bin/env python3
"""261112-dci: prove the CLAUDE.md section moves are verbatim and lossless.

Run from the repo root:
    python3 .planning/quick/261112-dci-.../verbatim_check.py <key> [<key> ...]
Keys: multislider, m4l, bach, rnbo. Base sha comes from base-sha.txt beside
this script. Stdlib only.

Checks:
  A verbatim      every non-blank base body line is a full line, in order, in
                  the destination region
  B pointer       the CLAUDE.md region holds exactly one non-blank line naming
                  the destination path (backticked) and heading title (quoted)
  C unchanged     CLAUDE.md minus every selected region equals base minus same
  D no residue    no non-blank base body line remains anywhere in CLAUDE.md
  E anchors kept  every base RULE_ANCHORS entry is in current RULE_ANCHORS or
                  a current MOVED_DETAIL list; every base MOVED_DETAIL
                  (key, anchor) pair survives
"""

import ast
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
REPO = Path.cwd()

SHARED = ".claude/skills/references/shared-capabilities.md"
RNBO_SKILL = ".claude/skills/max-rnbo-agent/SKILL.md"

SECTIONS = {
    "multislider": ("#### Multislider as Labeled Parameter Bank", SHARED,
                    "#### Multislider as Labeled Parameter Bank"),
    "m4l": ("### Max for Live (M4L / .amxd)", SHARED, "## Max for Live Device Rules"),
    "bach": ("### bach (package)", SHARED, "## bach (package) Rules"),
    "rnbo": ("### RNBO (Export-Ready Patches)", RNBO_SKILL, "## RNBO Export Rules"),
}


def git_show(sha: str, path: str) -> str:
    return subprocess.run(
        ["git", "show", f"{sha}:{path}"], check=True, capture_output=True, text=True
    ).stdout


def level(line: str) -> int:
    return len(line) - len(line.lstrip("#"))


def claude_region(lines: list, heading: str):
    """(start, end) indices of the body after `heading` up to the next '#' line."""
    idx = [i for i, ln in enumerate(lines) if ln == heading]
    if len(idx) != 1:
        return None
    start = idx[0] + 1
    end = start
    while end < len(lines) and not lines[end].startswith("#"):
        end += 1
    return start, end


def dest_region(lines: list, heading: str):
    idx = [i for i, ln in enumerate(lines) if ln == heading]
    if len(idx) != 1:
        return None
    lvl = level(heading)
    start = idx[0] + 1
    end = start
    while end < len(lines):
        ln = lines[end]
        if ln.startswith("#") and level(ln) <= lvl:
            break
        end += 1
    return lines[start:end]


def strip_regions(lines: list, headings: list) -> list:
    out = list(lines)
    # remove from the bottom up so indices stay valid
    spans = []
    for h in headings:
        r = claude_region(out, h)
        if r is not None:
            spans.append(r)
    for s, e in sorted(spans, reverse=True):
        del out[s:e]
    return out


def parse_assign(src: str, name: str):
    tree = ast.parse(src)
    for node in tree.body:
        if isinstance(node, ast.Assign):
            for t in node.targets:
                if isinstance(t, ast.Name) and t.id == name:
                    return ast.literal_eval(node.value)
    raise KeyError(name)


def main(keys: list) -> int:
    bad_keys = [k for k in keys if k not in SECTIONS]
    if not keys or bad_keys:
        print(f"usage: verbatim_check.py <key>... (keys: {', '.join(SECTIONS)}); bad: {bad_keys}")
        return 2
    sha = (HERE / "base-sha.txt").read_text().strip()
    base = git_show(sha, "CLAUDE.md").split("\n")
    cur = (REPO / "CLAUDE.md").read_text(encoding="utf-8").split("\n")
    cur_set = set(cur)
    fails = []

    for key in keys:
        heading, dest, dest_heading = SECTIONS[key]
        br = claude_region(base, heading)
        if br is None:
            fails.append(f"{key}: base heading not found exactly once: {heading!r}")
            continue
        body = [ln for ln in base[br[0]:br[1]] if ln.strip()]

        # A verbatim
        dlines = (REPO / dest).read_text(encoding="utf-8").split("\n")
        region = dest_region(dlines, dest_heading)
        if region is None:
            fails.append(f"{key} A: destination heading {dest_heading!r} not found exactly once in {dest}")
        else:
            pos = 0
            for ln in body:
                try:
                    pos = region.index(ln, pos) + 1
                except ValueError:
                    fails.append(f"{key} A: line missing/out of order in {dest}: {ln[:90]!r}")

        # B pointer
        cr = claude_region(cur, heading)
        if cr is None:
            fails.append(f"{key} B: heading not found exactly once in CLAUDE.md: {heading!r}")
        else:
            nonblank = [ln for ln in cur[cr[0]:cr[1]] if ln.strip()]
            title = dest_heading.lstrip("#").strip()
            if len(nonblank) != 1:
                fails.append(f"{key} B: expected 1 pointer line, found {len(nonblank)}")
            else:
                p = nonblank[0]
                if f"`{dest}`" not in p:
                    fails.append(f"{key} B: pointer lacks `{dest}`")
                if f'"{title}"' not in p:
                    fails.append(f'{key} B: pointer lacks "{title}"')

        # D no residue
        for ln in body:
            if ln in cur_set:
                fails.append(f"{key} D: residue in CLAUDE.md: {ln[:90]!r}")

    # C nothing else changed
    headings = [SECTIONS[k][0] for k in keys if k in SECTIONS]
    b_rest = strip_regions(base, headings)
    c_rest = strip_regions(cur, headings)
    if b_rest != c_rest:
        import difflib
        diff = list(difflib.unified_diff(b_rest, c_rest, "base", "current", lineterm="", n=0))
        fails.append("C: CLAUDE.md changed outside the selected regions:\n  " + "\n  ".join(diff[:40]))

    # E anchors kept
    base_t = git_show(sha, "tests/test_claude_md.py")
    cur_t = (REPO / "tests/test_claude_md.py").read_text(encoding="utf-8")
    b_ra, c_ra = parse_assign(base_t, "RULE_ANCHORS"), parse_assign(cur_t, "RULE_ANCHORS")
    b_md, c_md = parse_assign(base_t, "MOVED_DETAIL"), parse_assign(cur_t, "MOVED_DETAIL")
    moved_all = {a for _p, lst in c_md.values() for a in lst}
    c_ra_set = set(c_ra)
    for a in b_ra:
        if a not in c_ra_set and a not in moved_all:
            fails.append(f"E: base RULE_ANCHORS entry dropped: {a!r}")
    for k, (_p, lst) in b_md.items():
        cur_list = c_md.get(k, (None, []))[1]
        for a in lst:
            if a not in cur_list:
                fails.append(f"E: base MOVED_DETAIL pair dropped: ({k!r}, {a!r})")

    if fails:
        for f in fails:
            print("FAIL", f)
        return 1
    print("OK", " ".join(keys))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
