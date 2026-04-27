---
quick_id: 260427-knk
mode: quick-full
description: Add Layer-2 maxclass validation check (FINDINGS P1-5)
date: 2026-04-27
status: ready
must_haves:
  truths:
    - "`_validate_maxclass_usage` in `src/maxpat/validation.py` emits `level='error'` (not `warning`) when a non-structural box has a maxclass that is neither `newobj` nor in `UI_MAXCLASSES`."
    - "The error message includes both the wrong pair (current maxclass) AND the correct pair (`maxclass='newobj'` with `text='<name> ...'`), so the bug class is unambiguous."
    - "Boxes with an embedded `patcher` key are skipped by the maxclass check (legitimate subpatcher containers like `gen~`, `poly~`, `rnbo~`, `codebox` in embedded mode)."
    - "`UI_MAXCLASSES` in `src/maxpat/maxclass_map.py` includes `playlist~`, `dict.view`, `dada.bounce`, `bach.roll` so existing real patches continue to pass."
    - "`tests/test_validation.py::TestMaxclassUsage` covers: (a) non-UI own-maxclass triggers error; (b) UI widgets (`button`, `dial`, `gain~`) pass; (c) structural maxclasses pass; (d) standard `newobj` passes; (e) embedded subpatcher container (`gen~` with `patcher` key) passes."
    - "All existing tests in `tests/test_validation.py` and `tests/test_integration_patches.py` continue to pass — no regressions."
  artifacts:
    - "src/maxpat/validation.py — `_validate_maxclass_usage` updated"
    - "src/maxpat/maxclass_map.py — `UI_MAXCLASSES` expanded"
    - "tests/test_validation.py — `TestMaxclassUsage` updated + new cases"
  key_links:
    - "src/maxpat/validation.py:257"
    - "src/maxpat/maxclass_map.py:12"
    - "tests/test_validation.py:973"
    - ".planning/quick/260427-hox-review-this-system-and-all-of-the-issues/260427-hox-FINDINGS.md (P1-5)"
---

# PLAN — Layer-2 maxclass-correctness check (P1-5)

## Goal

Promote `_validate_maxclass_usage` from a warning to an error and broaden UI_MAXCLASSES so real-world patches still pass. Catches the residual maxclass-confusion bug class (e.g. `maxclass: "cycle~"` instead of `newobj` + `text: "cycle~ ..."`) at validation time with a self-explaining error message.

## Context

- The check exists today at `src/maxpat/validation.py:257` (`_validate_maxclass_usage`). It currently emits `warning`. The docstring explicitly defers to warning level "since third-party patches may have custom maxclasses."
- FINDINGS P1-5 calls for elevation to a hard check. The right knob is to also expand UI_MAXCLASSES to cover legitimate non-newobj cases that the current set misses, plus skip embedded subpatcher containers via the `patcher` key.
- Audit of real `patches/*/generated/*.maxpat` and `tests/fixtures/`:
  - `patches/tape-wobble/...` uses `playlist~` (Max-bundled UI widget) and `live.scope~` (already in UI_MAXCLASSES).
  - `patches/intelligent-corpus-remixer/...` uses `dict.view` (Max-bundled UI widget), `dropfile`, `jsui`, `live.gain~` (last three already in UI_MAXCLASSES).
  - `patches/physics-composition/...` uses `dada.bounce` (dada package UI widget) and `bach.roll` (bach package UI widget).
  - `tests/fixtures/expected/gen_codebox.maxpat` uses `gen~` with embedded `patcher` key (legitimate subpatcher container).
- DB-recorded `maxclass` values are NOT authoritative (CLAUDE.md is explicit: many entries like `cycle~` carry own-name maxclass in the DB, which is exactly the bug we're catching). The check stays driven by `UI_MAXCLASSES` + `patcher`-key escape, not by DB lookup.

## Tasks

### Task 1 — Expand `UI_MAXCLASSES` for legitimate non-newobj cases

**files:**
- `src/maxpat/maxclass_map.py`

**action:**
Add the following symbols to `UI_MAXCLASSES`:
- `"playlist~"` — Max-bundled clip-player UI widget.
- `"dict.view"` — Max-bundled dict viewer UI widget.
- `"dada.bounce"` — dada package physics-balls UI widget.
- `"bach.roll"` — bach package notation-roll UI widget.

Group them in a new `# Specialty / package UI widgets` section to keep the existing groupings tidy. Do not touch `resolve_maxclass` or `is_ui_object` (the new entries flow through automatically).

**verify:**
- `python3 -c "from src.maxpat.maxclass_map import UI_MAXCLASSES; print(all(n in UI_MAXCLASSES for n in ('playlist~','dict.view','dada.bounce','bach.roll')))"` prints `True`.
- `is_ui_object("playlist~") is True`.

**done:**
- All four names are members of `UI_MAXCLASSES`.

---

### Task 2 — Promote `_validate_maxclass_usage` to error + add subpatcher-container skip + improve message

**files:**
- `src/maxpat/validation.py`

**action:**
Modify `_validate_maxclass_usage` (currently lines 257–295):

1. **Skip subpatcher containers.** Right after the `_STRUCTURAL_MAXCLASSES` check, add:
   ```python
   # Subpatcher containers (gen~, poly~, rnbo~, codebox in embedded mode)
   # carry their own maxclass legitimately when an embedded `patcher` key
   # is present.
   if "patcher" in box:
       continue
   ```

2. **Promote level to `error`** in the trailing `ValidationResult(...)` call.

3. **Rewrite message** to show both the wrong pair and the correct pair:
   ```python
   results.append(ValidationResult(
       "objects", "error",
       f"Wrong maxclass: object '{name}' uses maxclass='{maxclass}' "
       f"but should use maxclass='newobj' with text='{name} ...' "
       f"(only UI widgets use their own name as maxclass; see "
       f"UI_MAXCLASSES in src/maxpat/maxclass_map.py)",
   ))
   ```

4. **Update the function docstring** to reflect the new behavior (error not warning, subpatcher-container skip).

**verify:**
- `pytest tests/test_validation.py::TestMaxclassUsage -x -q` passes after Task 3 updates.
- `pytest tests/test_integration_patches.py::test_validate_patch_no_errors -x -q` passes (no real patch newly fails).

**done:**
- The function emits `level='error'` for non-structural, non-newobj, non-UI maxclass without `patcher` key.
- Existing call from `validate_patch` at line 131 unchanged.

---

### Task 3 — Update + extend `tests/test_validation.py::TestMaxclassUsage`

**files:**
- `tests/test_validation.py`

**action:**
In the existing `TestMaxclassUsage` class (lines 973–1038):

1. **Rename + repurpose existing tests** to look for `level == "error"`:
   - `test_non_ui_object_wrong_maxclass_triggers_warning` → `test_non_ui_object_wrong_maxclass_triggers_error` — assert exactly one error result with `layer == "objects"` matching the new message format (contains `"Wrong maxclass"`, `"cycle~"`, `"newobj"`).
   - `test_ui_object_own_maxclass_no_warning` → `test_ui_object_own_maxclass_no_error` — assert no `error` results referencing maxclass.
   - `test_structural_maxclass_no_warning` → `test_structural_maxclass_no_error` — same flip.
   - `test_standard_newobj_no_warning` → `test_standard_newobj_no_error` — same flip.

2. **Add new tests** in the same class:

   - `test_ui_widgets_button_dial_gain_pass` — patch with three boxes (`button`, `dial`, `gain~`) each using its own name as maxclass → no error referencing maxclass.

   - `test_multiple_non_ui_own_maxclass_each_errors` — patch with three boxes (`cycle~`, `*~`, `pack`) each using its own name as maxclass → exactly three errors referencing maxclass.

   - `test_subpatcher_container_with_patcher_key_passes` — box with `maxclass='gen~'` AND `patcher: {boxes: [], lines: []}` key → no error referencing maxclass (legitimate embedded subpatcher container).

   - `test_error_message_includes_correct_pair` — single `cycle~` with own-name maxclass → resulting error message contains both `"maxclass='cycle~'"` and `"maxclass='newobj'"` and `"text='cycle~"` (proves the wrong-pair → correct-pair contract).

3. **Box helper:** if the existing `_make_box` helper at line 35 doesn't accept `patcher` key, pass it via the box dict literal — no helper change required.

**verify:**
- `pytest tests/test_validation.py::TestMaxclassUsage -v` shows all renamed + 4 new tests passing.

**done:**
- 4 renamed tests + 4 new tests all pass.

---

### Task 4 — Run full test suite for regression check

**files:**
- (no edits; verification only)

**action:**
- Run `pytest tests/ -x -q --ignore=tests/test_extraction.py 2>&1 | tail -40` (extraction tests can be slow / network-dependent; skip if so configured).
- If a real patch fails `test_validate_patch_no_errors`, treat it as a true bug surfaced by the new check — report in SUMMARY but do not silently widen UI_MAXCLASSES further; the four UI widgets added in Task 1 are the sanctioned set.

**verify:**
- Test summary reports zero failures.

**done:**
- Full suite green or only pre-existing unrelated failures (documented).

## Success criteria (traceable to must_haves)

- [ ] `_validate_maxclass_usage` emits `error` not `warning` (Task 2).
- [ ] Error message includes wrong-pair AND correct-pair info (Task 2 + verified by `test_error_message_includes_correct_pair`).
- [ ] Subpatcher-container skip via `patcher` key (Task 2 + verified by `test_subpatcher_container_with_patcher_key_passes`).
- [ ] UI_MAXCLASSES expanded by 4 (Task 1).
- [ ] Tests cover both directions per spec (Task 3, `test_ui_widgets_button_dial_gain_pass` + `test_multiple_non_ui_own_maxclass_each_errors`).
- [ ] No regressions (Task 4).

## Out of scope

- Re-scoring DB `maxclass` field correctness (a separate effort; CLAUDE.md already documents that the field is non-authoritative).
- Auto-fixing wrong maxclass in loaded patches.
- Cleaning up `.claude/worktrees/agent-*/` stale fixture copies — not part of the live tree.
