---
phase: quick
plan: 260826-kvk
subsystem: maxpat-aesthetics
status: complete
tags: [contrast, presentation-mode, wcag, critics, aesthetics]
requires: []
provides:
  - "WCAG contrast primitives (relative_luminance, contrast_ratio, best_text_color)"
  - "Dual-coordinate-space background resolution in ensure_text_contrast()"
  - "Three-encoding + documented-default panel color resolver"
  - "repair_text_contrast(patcher) opt-in helper"
  - "Effective-background contrast check in review_layout()"
affects:
  - src/maxpat/aesthetics.py
  - src/maxpat/defaults.py
  - src/maxpat/builders.py
  - src/maxpat/critics/layout_critic.py
  - src/maxpat/__init__.py
  - CLAUDE.md
tech-stack:
  added: []
  patterns:
    - "WCAG 2.1 relative luminance + contrast ratio replaces luminance>0.5 binary flip"
    - "Maximize-the-minimum contrast across candidate backgrounds when the surface is indeterminate"
    - "Plain-dict resolvers shared by the Box-object generator and the raw-dict critic"
    - "textcolor written to box._raw as well as extra_attrs to survive round-trip serialize"
key-files:
  created:
    - .planning/quick/260826-kvk-fix-presentation-mode-panel-text-color-c/260826-kvk-measure-affected.py
    - .planning/quick/260826-kvk-fix-presentation-mode-panel-text-color-c/260826-kvk-AFFECTED.txt
    - .planning/quick/260826-kvk-fix-presentation-mode-panel-text-color-c/260826-kvk-BASELINE.txt
  modified:
    - src/maxpat/aesthetics.py
    - src/maxpat/defaults.py
    - src/maxpat/builders.py
    - src/maxpat/critics/layout_critic.py
    - src/maxpat/__init__.py
    - tests/test_aesthetics.py
    - tests/test_critics.py
    - CLAUDE.md
decisions:
  - "D-1 presentation wins on conflict; patching-mode compromise surfaced as a critic note"
  - "D-2 a box's own bgcolor beats any panel or canvas underneath it"
  - "D-3 WCAG contrast ratio, 4.5:1 minimum; maximize-the-minimum when indeterminate"
  - "D-4 no bulk rewrite of existing patches; repair_text_contrast is opt-in"
  - "D-5 upgraded the existing critic function rather than adding a module"
  - "D-6 palette identity unchanged; step_marker_text retained but no longer written"
metrics:
  duration: ~35 min
  completed: 2026-08-26
actuals:
  tokens: 46000
  tasks: 3
  commits: 3
---

# Quick Task 260826-kvk: Presentation-Mode Text Contrast Summary

Text contrast is now resolved against the surface the reader actually sees — the box's own background, else the panel beneath it **in the coordinate space where the text is displayed** — scored by WCAG contrast ratio instead of a `luminance > 0.5` flip, with a standing critic guard so the class of bug cannot recur.

## What Changed

**The bug.** `ensure_text_contrast()` computed every comment's background from `patching_rect` only. On `gong-model.maxpat`, 30/30 light-text presentation comments sit inside a panel in *presentation* coordinates and 0/30 sit inside any panel in *patching* coordinates — the engine was measuring a surface the user never looks at, then MAX rendered near-white text over a light panel.

Four independent faults compounded it, all now fixed:

| Fault | Fix |
|---|---|
| Background resolved in patching space only | `ensure_text_contrast()` resolves per coordinate space; presentation wins on conflict (D-1) |
| `set_canvas_background()` never wrote patcher-level `bgcolor` | Now writes `bgcolor` alongside `editing_bgcolor`/`locked_bgcolor` (F-1) |
| `_get_panel_bgcolor()` returned `None` for flat `grad1`/`grad2` panels (37 of 58 in this repo) and for uncolored panels | `resolve_fill_color()` reads all three encodings; uncolored falls back to a documented `MAX_DEFAULT_PANEL_BG` flagged `assumed=True` |
| A box's own `bgcolor` was ignored, so `add_section_header` paired light text with its own light `header_bgcolor` | D-2: box-own background takes precedence in both spaces |

**The silent-failure trap.** `textcolor` is an `extra_attrs` write, and `Patcher.to_dict()` overlays only text/rects/IO/inner-patcher onto `_raw` for round-tripped boxes — generic `extra_attrs` are dropped (CLAUDE.md Rule #5). `_set_textcolor()` writes both destinations. A test asserts the color is present in JSON loaded back off disk, not merely in memory.

**Critic guard.** `_check_text_contrast()` (already wired into `review_layout` → `review_patch` → `/max-verify`) was upgraded in place per D-5. It imports the resolvers from `aesthetics.py`, so critic and generator share one implementation and cannot drift. Severity: `warning` when the background is known and short of 4.5:1, `note` when the background was assumed, `note` for the D-1 presentation/patching trade-off.

**Step marker.** `add_step_marker` hardcoded white on the amber chip — 2.23:1, half the WCAG minimum. It now derives its text color from the chip (5.57:1). `step_marker_text` stays in the palette for back-compat per D-6 but is no longer what gets written.

## Measured Blast Radius — Reported, NOT Fixed

Full output: `260826-kvk-AFFECTED.txt`. Regenerate with `python3 .planning/quick/260826-kvk-*/260826-kvk-measure-affected.py`.

**49 files scanned · 483 text boxes · 16 files carrying 83 sub-threshold text boxes · 0 flagged as assumed-background.**

| file | text boxes | failing | assumed |
|---|---|---|---|
| patches/amplitude-follower/generated/amplitude-follower.maxpat | 2 | 2 | 0 |
| patches/gen-eq/generated/gen-eq-test.maxpat | 1 | 1 | 0 |
| patches/gen-eq/generated/gen-eq.maxpat | 20 | 6 | 0 |
| patches/intelligent-corpus-remixer/generated/intelligent-corpus-remixer.maxpat | 8 | 1 | 0 |
| patches/kicksynth/generated/kicksynth.maxpat | 37 | 1 | 0 |
| patches/mixer/generated/mixer-strip.maxpat | 22 | 8 | 0 |
| patches/mixer/generated/mixer.maxpat | 2 | 1 | 0 |
| patches/physics-composition/generated/physics-composition.maxpat | 8 | 1 | 0 |
| patches/psycography/generated/main.maxpat | 10 | 1 | 0 |
| patches/reverse-delay/generated/reverse-delay.maxpat | 33 | 16 | 0 |
| patches/scala-synth/generated/scala-synth.maxpat | 41 | 9 | 0 |
| patches/stereo-feedback-delay/generated/stereo-feedback-delay.maxpat | 12 | 5 | 0 |
| patches/subtractive-synth/generated/subtractive-synth.maxpat | 20 | 4 | 0 |
| patches/tape-wobble/generated/tape-wobble.maxpat | 11 | 9 | 0 |
| patches/wormhole/generated/wormhole-test.maxpat | 1 | 1 | 0 |
| patches/wormhole/generated/wormhole.maxpat | 24 | 17 | 0 |

**These patches were deliberately left unmodified (D-4).** No `.maxpat` file was touched by this task — verified: `git diff --name-only HEAD~3 HEAD` contains zero `patches/` paths, and the five pre-existing uncommitted `.maxpat` modifications in the working tree remain unstaged and unaltered.

The opt-in repair path is per patch:

```python
from src.maxpat import read_patch, save_patch_roundtrip, Patcher
from src.maxpat.aesthetics import repair_text_contrast

p = Patcher.from_dict(read_patch(path))
changed = repair_text_contrast(p)     # returns count; idempotent
save_patch_roundtrip(p.to_dict(), path)
```

## Known Limitation: Contrast Is Not Recomputed on the Edit Path

`hooks.finalize_patch()` calls `apply_auto_styling(patcher)` — and hence `ensure_text_contrast()` — **only when `is_new=True`** (finding F-7). Editing an existing patch never re-runs contrast resolution, so a patch generated before this fix keeps its unreadable text colors until `repair_text_contrast()` is called explicitly.

This is deliberate, not an oversight. Auto-repairing on every edit would silently rewrite 83 text boxes across 16 patches the first time any of them is touched — exactly the regression risk D-4 exists to prevent. A test (`test_repair_is_not_wired_into_edit_path`) asserts `finalize_patch` does not reference `repair_text_contrast`, so the wiring cannot be added by accident.

## Pre-existing Tests Corrected (and Why)

Three tests asserted the buggy behavior. All were corrected by fixing the expected value to the readable one; none were deleted, and no unrelated assertion was loosened.

**1. `tests/test_aesthetics.py::TestEnsureTextContrast::test_section_header_on_dark_canvas`** (named in F-5)
Asserted a section header gets LIGHT text `[0.80, 0.80, 0.82, 1.0]`. But `add_section_header` sets the box's own `bgcolor` to the light `header_bgcolor` `[0.88, 0.90, 0.95, 1.0]` — so the test locked in light-on-light, the exact unreadable pairing reported. Now asserts dark text and that its ratio against the header's own bgcolor (9.91:1) clears the threshold.

**2. `tests/test_aesthetics.py::TestStepMarkers::test_marker_colors`**
Asserted the hardcoded white `step_marker_text` on the amber chip — 2.23:1, roughly half the WCAG AA minimum. Now asserts the derived color clears `MIN_CONTRAST_RATIO` against the chip.

**3. `tests/test_aesthetics.py::TestContrastText::test_midpoint_luminance`**
Asserted light text for a 0.5 gray background, encoding the removed `luminance <= 0.5` branch. Under WCAG that background sits at L=0.214, where dark text scores 3.13:1 and light text only 2.49:1 — the old assertion pinned the *less* readable option. Now asserts dark text plus the ratio comparison that justifies it.

`test_subsection_on_dark_canvas` was audited and left unchanged (subsections set no bgcolor, so light-on-dark is correct). `test_non_comment_boxes_untouched` was audited and left unchanged — the broadened box filter (comments plus any box already carrying a generator-set `textcolor`) does not subsume a plain `toggle`.

## Deviations from Plan

**1. [Rule 1 — Plan spec was unsatisfiable] Uncolored-panel test assertion narrowed to the achievable guarantee**
- **Found during:** Task 2
- **Issue:** Task 2's behavior spec required "a text color whose contrast ratio is at least `MIN_CONTRAST_RATIO` against BOTH the assumed default and the canvas." That is mathematically impossible: clearing 4.5:1 against the dark canvas (L=0.0907) requires text luminance ≥ 0.583, while clearing it against a light assumed panel (L=0.729) requires ≤ 0.123. No single color satisfies both.
- **Fix:** `test_uncolored_panel_falls_back_to_documented_default` asserts the intent that *is* achievable — the resolver returns a color (never `None`) flagged `assumed=True`; the chosen text clears 4.5:1 against the assumed panel fill (the surface MAX most likely paints); and it is the maximize-the-minimum choice across both plausible surfaces per D-3. The residual risk is surfaced rather than hidden: the critic downgrades such findings to a `note` naming the assumption.
- **Files modified:** tests/test_aesthetics.py
- **Commit:** bd2f2ed

**2. [Rule 3 — Blocking] `src/maxpat/builders.py` edited, though not listed in Task 2's `<files>`**
- **Found during:** Task 2
- **Issue:** Task 2's action requires `add_step_marker` to derive its text color from its own bgcolor, but that function lives in `builders.py`, which the task's file list omitted.
- **Fix:** Edited `builders.py`; staged explicitly by name, never via `git add .`.
- **Commit:** bd2f2ed

**3. [Informational] `MAX_DEFAULT_PANEL_BG` provenance strengthened with new measurement**
- Beyond F-3's finding that MAX documents no default, MAX's own 2973 shipped panel boxes were counted: 2889 carry a color and skew *dark* (1177 pure black, 607 near-black), 84 carry none. So majority-usage gives no inference for the uncolored case either. This is recorded in the constant's comment as the reason the value must stay non-load-bearing.

## Test Results

| | baseline | after |
|---|---|---|
| passed | 2123 | 2148 (+25) |
| failed | 6 | 6 (identical set) |
| xfailed | 4 | 4 |

`diff` of the sorted `FAILED` lists is empty — **no net regressions**. The 6 failures are the documented pre-existing debt recorded in `260826-kvk-BASELINE.txt` (4 `test_review_patch_no_blockers`, 1 byte-identity round-trip, 1 signal-role anchor); none are contrast-related. New contrast findings are `warning`/`note` severity, so they cannot affect the blocker-gated integration test.

Targeted suites: `tests/test_aesthetics.py tests/test_critics.py tests/test_claude_md.py` → 194 passed (baseline 169).

## Commits

| Task | Commit | Scope |
|---|---|---|
| 1 (tracer) | `5139d13` | WCAG primitives, dual-space resolution, `_raw` write-through, patcher `bgcolor` |
| 2 | `bd2f2ed` | All panel encodings, box-own background, step marker, `repair_text_contrast` |
| 3 | `7193b4a` | Critic guard, CLAUDE.md rules, blast-radius report |

## Self-Check: PASSED

- `src/maxpat/aesthetics.py`, `src/maxpat/defaults.py`, `src/maxpat/builders.py`, `src/maxpat/critics/layout_critic.py`, `src/maxpat/__init__.py`, `CLAUDE.md`, `tests/test_aesthetics.py`, `tests/test_critics.py` — all present and modified.
- `260826-kvk-AFFECTED.txt`, `260826-kvk-BASELINE.txt`, `260826-kvk-measure-affected.py` — all present.
- Commits `5139d13`, `bd2f2ed`, `7193b4a` — all present in `git log`.
- `git diff --name-only HEAD~3 HEAD | grep '^patches/'` — no matches. Zero `.maxpat` files changed.
