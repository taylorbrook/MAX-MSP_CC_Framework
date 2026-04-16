---
phase: 23-agent-package-intelligence
reviewed: 2026-04-14T00:00:00Z
depth: standard
files_reviewed: 14
files_reviewed_list:
  - .claude/max-objects/PACKAGES.md
  - .claude/max-objects/relationships.json
  - .claude/skills/max-dsp-agent/SKILL.md
  - .claude/skills/max-js-agent/SKILL.md
  - .claude/skills/max-patch-agent/SKILL.md
  - .claude/skills/max-rnbo-agent/SKILL.md
  - .claude/skills/max-ui-agent/SKILL.md
  - src/maxpat/layout.py
  - src/maxpat/patcher.py
  - src/maxpat/sizing.py
  - tests/test_agent_skills.py
  - tests/test_layout.py
  - tests/test_package_schema.py
  - tests/test_sizing.py
findings:
  critical: 0
  warning: 3
  info: 4
  total: 7
status: issues_found
---

# Phase 23: Code Review Report

**Reviewed:** 2026-04-14
**Depth:** standard
**Files Reviewed:** 14
**Status:** issues_found

## Summary

Phase 23 adds package intelligence: `PACKAGES.md` agent reference doc, `relationships.json` package pairs, `Package Intelligence` sections in all 5 specialist SKILL.md files, `sizing.py` bpatcher DB-driven sizing, and the `add_bpatcher(object_name=...)` enhancement in `patcher.py`. The tests cover schema, API, layout, and sizing.

The implementation is solid overall. Three warnings were found — two logic bugs and one silent failure path — plus four info-level items.

---

## Warnings

### WR-01: Dead branch in `_populate_comments_recursive` -- prefix always "signal"

**File:** `src/maxpat/patcher.py:1630`
**Issue:** The conditional chain for `prefix` in the inlet assistance comment generator always evaluates to `"signal"`:
```python
prefix = "signal" if inlet_box.name.endswith("~") else "signal" if downstream.name.endswith("~") else "data"
```
The first and second branches both return `"signal"`, so `"data"` is unreachable. The same pattern repeats on line 1649 for outlets. An inlet/outlet connected to a non-signal object (e.g., `metro`, `counter`, `pack`) will incorrectly get the `"signal"` prefix in its tooltip. This produces misleading assistance comments on control-rate subpatcher ports.

**Fix:**
```python
# Line 1630 (inlets):
prefix = "signal" if (inlet_box.name.endswith("~") or downstream.name.endswith("~")) else "data"

# Line 1649 (outlets):
prefix = "signal" if (outlet_box.name.endswith("~") or upstream.name.endswith("~")) else "data"
```

---

### WR-02: `add_bpatcher(object_name=...)` silently ignores `numinlets`/`numoutlets` when caller passes explicit values

**File:** `src/maxpat/patcher.py:1506-1512`
**Issue:** The DB I/O auto-set guard is `if self.db and numinlets == 1 and numoutlets == 1`, meaning it fires only when both parameters are at their default value of `1`. This works for the intended use case (auto-set from DB). However, if a caller legitimately passes `numinlets=1, numoutlets=1` for a package object that actually has 1 inlet and 1 outlet, the DB lookup overwrites their explicit intent with DB-derived counts. Worse, if a package object has `numinlets=0` in the DB (e.g., a terminal output module), the auto-set correctly fires because the caller's `1` triggers the guard -- but the result (setting to 0) may crash downstream connection attempts that assume at least 1 inlet.

The more significant issue: for non-package objects the test `numinlets == 1 and numoutlets == 1` is an unreliable heuristic for "caller used defaults." A boolean `auto_io` parameter would be cleaner.

**Fix:**
```python
# Add explicit parameter instead of heuristic
def add_bpatcher(
    self,
    filename: str | None = None,
    embedded: bool = False,
    args: list[str] | None = None,
    x: float = 0.0,
    y: float = 0.0,
    width: float | None = None,
    height: float | None = None,
    numinlets: int = 1,
    numoutlets: int = 1,
    object_name: str | None = None,
    auto_io: bool = True,   # <-- new flag
) -> Box | tuple[Box, Patcher]:
    ...
    if object_name and auto_io and self.db:
        obj_info = self.db.lookup(object_name)
        if obj_info:
            if "inlets" in obj_info:
                numinlets = len(obj_info["inlets"])
            if "outlets" in obj_info:
                numoutlets = len(obj_info["outlets"])
```
This is backward-compatible (existing callers get auto_io=True by default).

---

### WR-03: `_generate_midpoints` companion detection has incorrect upward-flow guard

**File:** `src/maxpat/layout.py:907`
**Issue:** The companion pattern check is:
```python
same_y = src_box.patching_rect[1] == dst_box.patching_rect[1]
close_x = abs(src_box.patching_rect[0] - dst_box.patching_rect[0]) < 80
if same_y and close_x and vdist > 0:
```
`vdist = src_oy - dst_iy` where `src_oy` is the **bottom** of the source and `dst_iy` is the **top** of the destination. When two objects are at the same y (same_y), `vdist` = `src_box.patching_rect[1] + src_box.patching_rect[3] - src_box.patching_rect[1]` = source height (always > 0 for any visible box). So the `vdist > 0` guard is always true for same-y pairs and adds no discrimination. It was likely meant to exclude upward-going cables (negative vdist), but since same_y forces vdist positive, this is harmless but misleading dead logic.

The actual risk is that two unrelated objects that happen to share the same y value and are close horizontally (e.g., two disconnected boxes that the layout placed at the same row) will have their cable routed through `_route_companion_cable` instead of the normal routing path. For these objects the "tight U-shape" routing is semantically wrong.

**Fix:**
```python
# Guard should also check that the pair is actually a companion (dst is a companion type)
from src.maxpat.layout import _COMPANION_NAMES
is_companion_pair = (
    same_y and close_x
    and (dst_box.name in _COMPANION_NAMES or src_box.name in _COMPANION_NAMES)
)
if is_companion_pair:
    companion_lines.append(...)
```

---

## Info

### IN-01: `test_agent_skills.py` comment says "10 skill directories" but constant and test check 9

**File:** `tests/test_agent_skills.py:70`
**Issue:** The comment above the parametrize block reads `"Test: All 10 skill directories exist"` but `ALL_SKILL_DIRS` has 9 entries and `test_total_skill_count` asserts `>= 9`. Either the comment is stale (was 10, now 9) or an agent was dropped and the comment was not updated.
**Fix:** Update the comment to `"Test: All 9 skill directories exist"` on line 70.

---

### IN-02: `_load_bpatcher_dims` opens files without error handling; silent empty result on I/O error

**File:** `src/maxpat/sizing.py:33-56`
**Issue:** `_load_bpatcher_dims` is called at module import time. If a `packages/*/objects.json` file exists but is not valid JSON (e.g., mid-write corruption), `json.load` raises `json.JSONDecodeError` which propagates as an import-time exception and makes the entire `sizing` module unimportable. The `_load_width_overrides` function on line 17 has the same issue. Neither has a try/except guard.
**Fix:** Wrap the JSON loads with a bare `except Exception` at import time with a warning, matching the pattern common for optional data files:
```python
try:
    with open(json_path) as f:
        data = json.load(f)
except Exception:
    continue  # skip corrupt/unreadable file
```

---

### IN-03: `PACKAGES.md` Vizzie bridging objects listed with wrong prefix hint

**File:** `.claude/max-objects/PACKAGES.md:54`
**Issue:** The table entry reads `vz.audio2vizzie` and `vz.beapconvertr` in the Utility row, but the signal conventions section at line 31 says to use these to bridge audio/BEAP into Vizzie. The Vizzie signal conventions section (line 29) states "All data flows as Jitter matrices" but doesn't warn that `vz.audio2vizzie` specifically bridges signal types, which could confuse an agent generating a hybrid patch. This is a documentation gap, not a code bug.
**Fix:** Add a one-line note in the Vizzie signal conventions section: `vz.audio2vizzie converts MSP audio signals to Jitter matrices; output is still a matrix, not an audio signal.`

---

### IN-04: `max-rnbo-agent/SKILL.md` missing `allowed-tools` frontmatter entry for `Edit`

**File:** `.claude/skills/max-rnbo-agent/SKILL.md:8`
**Issue:** The RNBO SKILL.md `allowed-tools` list includes `Edit` but other SKILL.md files (max-patch-agent, max-dsp-agent, max-js-agent, max-ui-agent) do not list `Edit`. If `Edit` is intentionally available for all agents via their workflow context, this inconsistency is just cosmetic. If `allowed-tools` is enforced by the router, max-rnbo-agent has broader tool access than peers without documented reason.
**Fix:** Verify whether `Edit` is legitimately needed only for RNBO (given its surgical editing workflow documented in `Output Protocol (Edited Patches)`). If yes, add a comment explaining why. If no, add `Edit` to all specialist SKILL.md files or remove it from max-rnbo-agent.

---

_Reviewed: 2026-04-14_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
