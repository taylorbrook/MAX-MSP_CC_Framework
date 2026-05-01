---
status: clean
phase: 31-layout-ux-builders
review_scope: gap-closure (31-06, 31-07)
reviewed_at: 2026-04-30T00:00:00Z
depth: standard
files_reviewed: 6
files_reviewed_list:
  - src/maxpat/patcher.py
  - src/maxpat/layout.py
  - tests/test_overlay_readout.py
  - tests/test_companion_role_layout.py
  - .claude/skills/max-patch-agent/SKILL.md
  - .claude/skills/max-ui-agent/SKILL.md
findings:
  blocking: 0
  major: 0
  minor: 2
  info: 3
  total: 5
---

# Phase 31 Gap Closure: Code Review Report

**Reviewed:** 2026-04-30
**Depth:** standard
**Scope:** Gap closure plans 31-06 (CR-01 — overlay-readout `format` kwarg) and 31-07 (WR-01 + WR-02 — overlay placement + single-parent guard)
**Status:** clean — no blocking or major issues found

> This review is **scoped to the gap-closure delta only**. The original
> wave 1-3 builder review (CR-01, WR-01..WR-05, IN-01..IN-04) lives in git
> history on commit `767a168`. Items intentionally left open by the gap
> closure (WR-03, WR-04, WR-05, IN-01..IN-04) are tracked there and are
> NOT re-evaluated here.

## Summary

Both gap-closure plans landed cleanly and the implementation matches the
specifications in `31-06-PLAN.md` and `31-07-PLAN.md`. All 41 targeted tests
pass (24 in `test_overlay_readout.py`, 17 in `test_companion_role_layout.py`).

The `format='%.Nf'` translation logic in `add_overlay_readout` is strict and
correct: the regex `^%\.(\d+)f$` rejects `%d`, `%.f`, `%.2g`, unit suffixes,
and literal-prefix templates. The `comment` type accepts any format string
informationally without writing to `extra_attrs`. The dead `format` key is
no longer written for any type.

The `_identify_companions` return shape change (`dict[str, Box]` →
`dict[str, tuple[Box, str]]`) is correctly propagated. Verified there are
no other callers besides `_place_companions` (in `apply_layout`) and the
test file — `apply_layout`'s consumer loop iterates dict keys only, so the
value-shape change is invisible there. Pass A's single-parent guard
(`if len(incoming.get(dst.id, [])) != 1: continue`) mirrors Pass B's
invariant and fires before the DB query (avoiding wasted work).

The overlay branch in `_place_companions` mirrors `add_overlay_readout`'s
recipe correctly: rect-copy via `list(...)` (Pitfall 1 mitigated),
`ignoreclick=1`, defensive `try/except ValueError` around `bring_to_front`.

The `Builder API` sections in both SKILL.md files are byte-identical
(`diff` returns empty; `test_builder_api_sections_byte_identical`
invariant preserved). The replacement bullet accurately describes the
post-fix behavior.

No security issues observed (pure in-memory builder code; no untrusted
input, shell, SQL, eval, or deserialization paths). Only minor/info items
noted below; none are goal-blocking and none warrant immediate follow-up.

## Minor Issues

### MN-01: Local `re` import + `re.compile` on every `add_overlay_readout` call

**File:** `src/maxpat/patcher.py:754-755`
**Issue:** The `import re as _re_overlay` and
`_PURE_PCT_NF = _re_overlay.compile(r"^%\.(\d+)f$")` execute on every
method invocation. Python's `re` module internally caches compiled patterns
(LRU of ~512 entries), so the runtime cost is negligible, but the per-call
import is non-idiomatic. The plan explicitly permitted module-level
hoisting "if the executor prefers"; the executor chose the local-import
variant for "no module-level pollution" reasons.
**Fix (optional):** Move the regex to module scope adjacent to the other
constants near the top of `patcher.py` (the file already imports `re` at
some point — verify before adding):
```python
import re
_OVERLAY_PURE_PCT_NF = re.compile(r"^%\.(\d+)f$")
```
Then drop the local `import re as _re_overlay` and `_PURE_PCT_NF = ...`
lines from the method body. Defer if the codebase convention is
"method-local imports for single-use regexes."

### MN-02: Defensive overlay branch silently swallows missing-rect TypeError

**File:** `src/maxpat/layout.py:747`
**Issue:** `comp_box.patching_rect = list(parent_box.patching_rect)` will
raise `TypeError` if `parent_box.patching_rect` is `None` or non-iterable.
The surrounding `try/except ValueError` (line 749-755) only catches
`bring_to_front`'s `ValueError`, not a malformed-rect `TypeError`, so a
layout pass would crash with an unhelpful traceback. In practice every
`Box` initializes `patching_rect` as a 4-element list, so this is
theoretical. Not goal-blocking.
**Fix (optional):** If you want layout to be uncrashable on malformed
rects, broaden the exception scope:
```python
try:
    comp_box.patching_rect = list(parent_box.patching_rect)
    comp_box.extra_attrs["ignoreclick"] = 1
    patcher.bring_to_front(comp_box)
except (ValueError, TypeError):
    pass
```
Alternative: assert the invariant at `Box.__init__` and let it crash
loudly elsewhere. Not goal-blocking either way.

## Info

### IN-01: `\d+` regex accepts unbounded N

**File:** `src/maxpat/patcher.py:755`
**Issue:** `^%\.(\d+)f$` matches any non-negative integer, including
`%.999999f`. `int(m.group(1))` accepts arbitrarily large; MAX's
`numdecimalplaces` would silently clamp/ignore an absurd value. Not a bug
per se — the kwarg is intended for `%.0f`-`%.6f`-ish range. The CR-01 fix
scope was correctness, not range validation.
**Suggestion (defer):** If you ever harden the kwarg, cap N at something
MAX-meaningful (e.g., 9 — the practical display limit). Pure polish; not
actionable now.

### IN-02: Pure-numeric comment format silently accepted but does nothing

**File:** `src/maxpat/patcher.py:756-768`
**Issue:** When `type='comment'` AND `format='%.2f'` (a perfectly valid
printf template), the kwarg is silently swallowed without warning. Test
`test_comment_with_pure_numeric_format_no_attr_written` asserts this is
the contract. From a caller's perspective, passing `format='%.2f'` to a
comment readout suggests the comment will format numbers — but it won't
(no native attribute). The plan deliberately accepted this behavior as
"informational only" per the CONTEXT.md D-03 reconciliation.
**Suggestion (defer):** A `warnings.warn(..., UserWarning)` for the
pure-numeric-comment case might catch caller mistakes ("I meant flonum").
Outside CR-01 scope; consider in a future polish pass alongside
WR-03/IN-01..IN-04.

### IN-03: Pass A still has a broad `try/except Exception` wrap

**File:** `src/maxpat/layout.py:652-655`
**Issue:** The plan's spec preserves the existing broad
`try/except Exception: role = None` around `db.get_signal_role`. This was
flagged as IN-04 in the original 31-REVIEW.md and intentionally NOT
addressed in this gap closure (out of scope per CLAUDE.md "don't add
features beyond what the task requires"). `get_signal_role` is documented
to return `None` on missing-data paths, so the broad except is masking
potential real bugs (KeyError, AttributeError) that should fail loudly.
**Status:** Tracked elsewhere (REVIEW.md IN-04 in commit `767a168`). No
action required for this gap closure.

## Positive Observations

1. **TDD discipline:** Both 31-06 and 31-07 followed RED→GREEN with
   explicit commits per phase (`43e969d` RED, `ed3d748` GREEN, `35bba35`
   docs for 31-06; `a7f9967` RED, `d68e465` GREEN for 31-07). Test
   coverage map kept up-to-date in `tests/test_overlay_readout.py` module
   docstring.

2. **Pitfall 1 (rect aliasing) mitigated in BOTH places:**
   `add_overlay_readout` line 741 uses `rect = list(target.patching_rect)`,
   and `_place_companions` overlay branch line 747 uses
   `list(parent_box.patching_rect)`. The
   `test_status_role_overlay_rect_not_aliased` test directly verifies the
   layout-side invariant.

3. **Single-parent guard placed BEFORE DB query** in Pass A (line 650 vs.
   role lookup at line 653) — avoids a wasted `db.get_signal_role` call
   when the guard fires. Plan called for this and the executor honored it.

4. **`placement` field guarded on Pass A:**
   `if companion_name and dst.name == companion_name and placement:`
   (line 661) — defends against a future role spec entry with
   `companion: 'X'` but `placement: None`. Won't slip through silently.

5. **Defensive fallback in `_place_companions`:** any unrecognized
   placement defaults to `"right"` (line 720-721 comment) rather than
   crashing — appropriate failure mode for a layout pass.

6. **Byte-identity invariant honored:** Both SKILL.md files updated with
   the exact same replacement bullet. The
   `test_builder_api_sections_byte_identical` invariant remained green
   throughout (verified manually via `diff` and via the test suite).

7. **Single-parent guard symmetry:** Pass A and Pass B now BOTH skip
   multi-parent companions. The `test_pass_a_skips_multi_parent_companion`
   test verifies the new symmetric behavior end-to-end (two `cycle~`
   sources → one `meter~` ⇒ unclaimed by either pass). Order-dependence
   eliminated.

---

_Reviewed: 2026-04-30_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
_Scope: gap-closure delta only (commits since 95a608910d4d). Original
wave 1-3 builder review remains in git history at the previous
31-REVIEW.md (commit 767a168)._
