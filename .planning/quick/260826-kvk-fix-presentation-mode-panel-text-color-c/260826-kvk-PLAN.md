---
phase: quick
plan: 260826-kvk
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/aesthetics.py
  - src/maxpat/defaults.py
  - src/maxpat/critics/layout_critic.py
  - src/maxpat/__init__.py
  - tests/test_aesthetics.py
  - tests/test_critics.py
  - CLAUDE.md
autonomous: true
requirements: [quick-task]

estimate:
  tokens: 62000
  raw_tokens: 62000
  tasks: 3
  confidence: low

must_haves:
  truths:
    - "A comment placed inside a light panel in PRESENTATION coordinates receives dark text, even when it sits over the dark canvas in patching coordinates"
    - "A textcolor assigned by ensure_text_contrast() to a round-tripped (pre-existing _raw) box survives Patcher.to_dict() and lands in the saved .maxpat JSON"
    - "set_canvas_background() writes the patcher-level `bgcolor` key (the one MAX honors for locked/presentation mode), so MAX never falls back to its light default while the generator assumes dark"
    - "A panel whose color is encoded as flat grad1/grad2 keys resolves to a real color instead of None"
    - "A panel carrying no color encoding at all resolves to a documented default instead of None, and the chosen text color is readable regardless of which default MAX actually uses"
    - "A box carrying its own bgcolor (add_section_header, add_step_marker) has its text contrast computed against that bgcolor, not against the panel or canvas underneath it"
    - "review_layout() emits a warning for any comment whose text fails the WCAG contrast threshold against its EFFECTIVE background in either coordinate space"
    - "The full pytest suite passes with no net regressions against the recorded baseline"
    - "No .maxpat file under patches/ is modified by this task"
  artifacts:
    - path: "src/maxpat/aesthetics.py"
      provides: "WCAG contrast primitives (relative_luminance, contrast_ratio, best_text_color), dual-coordinate-space background resolution in ensure_text_contrast(), three-encoding + default-fallback _get_panel_bgcolor(), and an opt-in repair_text_contrast() helper"
    - path: "src/maxpat/defaults.py"
      provides: "MAX_DEFAULT_PANEL_BG constant and MIN_CONTRAST_RATIO threshold, each with provenance documented in a comment"
    - path: "src/maxpat/critics/layout_critic.py"
      provides: "_check_text_contrast() upgraded to evaluate effective background (panels + both coordinate spaces + box-own bgcolor) instead of comparing against the palette canvas constant"
    - path: "tests/test_aesthetics.py"
      provides: "Regression tests that fail on the current code: presentation-space panel containment, grad1-only panel resolution, no-color panel fallback, box-own-bgcolor precedence, and _raw write-through survival"
    - path: "CLAUDE.md"
      provides: "Codified contrast rule under Rule #4 (Patch Style) and Rule #9 (Presentation Mode Parity)"
  key_links:
    - "The pure color primitives live in aesthetics.py and operate on plain dicts/lists so BOTH the Box-object caller (ensure_text_contrast) and the raw-dict caller (layout_critic._check_text_contrast) consume the same logic with no duplicated math"
    - "ensure_text_contrast() writes textcolor to box.extra_attrs AND to box._raw when _raw is not None, because the round-trip serialize path overlays only text/rects/IO/inner-patcher onto _raw and silently drops generic extra_attrs (CLAUDE.md Rule #5)"
    - "apply_auto_styling() -> ensure_text_contrast() is reached from hooks.finalize_patch(is_new=True); the is_new=False path is deliberately left untouched so existing patches are never silently rewritten"
---

<objective>
Fix presentation-mode text/panel contrast at the generator level, and add a standing critic guard so the class of bug cannot recur.

Today the generator computes text contrast in patching coordinates against a dark editing background, then MAX renders that near-white text over a light panel on MAX's light default presentation background. On `gong-model.maxpat`, 30/30 light-text presentation comments sit inside a panel in presentation coordinates and 0/30 sit inside any panel in patching coordinates — the contrast engine is measuring the wrong surface entirely.

Purpose: future generated patches ship readable presentation text by construction, and `/max-verify` flags any that do not.

Output: a corrected contrast engine in `src/maxpat/aesthetics.py`, evidence-backed constants in `defaults.py`, an upgraded `_check_text_contrast` in `layout_critic.py`, regression tests that fail on today's code, and the rule codified in `CLAUDE.md`.
</objective>

<execution_context>
@$HOME/.claude/gsd-core/workflows/execute-plan.md
@$HOME/.claude/gsd-core/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@./CLAUDE.md
@src/maxpat/aesthetics.py
@src/maxpat/critics/layout_critic.py
</context>

<verified_findings>
Measured against real files on disk. Do NOT re-derive these — use them.

**F-1 — `bgcolor` is the correct patcher-level key.** Across MAX's own 1018 shipped `.maxpat` files under `/Applications/Max.app/Contents/Resources/C74/`, patcher-level keys are `bgcolor` = 11, `editing_bgcolor` = 2. Across this repo's `patches/*/generated/*.maxpat`: `editing_bgcolor` = 35, `locked_bgcolor` = 7, `bgcolor` = 1 (`patches/wormhole/generated/wormhole.maxpat`, `bgcolor: [0.11, 0.11, 0.13, 1.0]` — the working reference). Conclusion: `set_canvas_background()` must write `bgcolor` in addition to the two it already writes.

**F-2 — panel color encodings, counted in this repo (`patches/*/generated/*.maxpat`, 58 panels total):**
| encoding present | count |
|---|---|
| `grad1` + `grad2` + `mode` (no `bgcolor`/`bgfillcolor`) | 35 |
| `bgcolor` + `mode` | 10 |
| `bgcolor` + `bordercolor` + `mode` | 9 |
| `bordercolor` + `grad1` + `grad2` + `mode` | 2 |
| `bgfillcolor` + `mode` | 2 |

The "37 panels with no color attribute" figure in the root-cause report is the 35 + 2 grad-only panels — they carry color, just in a form `_get_panel_bgcolor()` cannot read. The genuinely-uncolored case is still real: across MAX's own 2973 shipped panel boxes, 2769 use `bgcolor`, 85 use `grad1`/`grad2`, and **84 carry no color key at all**. Both cases must be handled.

**F-3 — MAX's default panel color is NOT derivable from disk.** `/Applications/Max.app/Contents/Resources/C74/interfaces/maxcolors.json` has no `panel` entry, and `docs/refpages/max-ref/panel.maxref.xml` documents `bgcolor`/`bgfillcolor` without default values. Do NOT rabbit-hole hunting for it, and do NOT guess a number and let readability depend on it (CLAUDE.md Rule #1). The design below makes the constant's exact value non-load-bearing: for an indeterminate background, pick the text color that maximizes the MINIMUM contrast ratio across the candidate backgrounds, so the result is readable either way.

**F-4 — the pre-existing critic check has the identical bug.** `src/maxpat/critics/layout_critic.py:338 _check_text_contrast()` compares each comment's textcolor luminance against the `AESTHETIC_PALETTE["canvas_bg"]` constant. It ignores panels, ignores presentation coordinates, ignores the patcher's actual background, and ignores the box's own bgcolor. Upgrade this function; do NOT create a new critic module — it is already wired into `review_layout()` at line 62 and therefore into `review_patch()` and `/max-verify`.

**F-5 — two existing tests assert the buggy behavior and MUST be corrected, not preserved.** In `tests/test_aesthetics.py`: `test_section_header_on_dark_canvas` (~L751) asserts a section header gets LIGHT text `[0.80,0.80,0.82,1.0]`. But `add_section_header` sets the box's own `bgcolor` to `header_bgcolor` `[0.88,0.90,0.95,1.0]` (light) — so that assertion locks in light-on-light, i.e. the exact unreadable pairing the user reported. `test_subsection_on_dark_canvas` is fine (subsections set no bgcolor). Audit the whole `TestEnsureTextContrast` class for the same pattern and correct any test that encodes light-on-light or dark-on-dark; do NOT weaken assertions elsewhere just to make the suite green.

**F-6 — the save path is git-safe in tests.** `hooks._auto_commit_saved_file()` (L28) only commits when the path contains a `patches/` component. A test that saves to pytest's `tmp_path` will not touch git.

**F-7 — `apply_auto_styling` runs only on new patches.** `hooks.finalize_patch()` (L78-85) calls `apply_auto_styling(patcher)` only when `is_new=True`. Edited patches never re-run contrast. Leave that branch alone — see D-4.
</verified_findings>

<locked_decisions>
These are decided. Implement them; do not re-litigate.

- **D-1 — Presentation wins on conflict.** When a box exists in both coordinate spaces and the two spaces demand opposite text colors, choose the color that is correct for PRESENTATION, because that is the user-facing surface. Record this rationale in the `ensure_text_contrast()` docstring. The critic still emits a `note` (not a warning) naming the box, so the patching-mode compromise is visible rather than silent.
- **D-2 — Box's own bgcolor takes precedence** over any panel or canvas underneath it. A box that paints its own background IS its own background.
- **D-3 — WCAG relative luminance and contrast ratio, minimum target 4.5:1.** Replace the `luminance > 0.5` binary flip. Evaluate every candidate text color against the effective background and pick the highest-ratio candidate. Where the background is indeterminate (F-3), pick the candidate with the highest MINIMUM ratio across the candidate backgrounds.
- **D-4 — no bulk rewrite of existing patches.** Do not modify any file under `patches/`. Do not change the `is_new=False` branch of `finalize_patch`. Ship `repair_text_contrast(patcher)` as an explicitly-called opt-in helper and report the measured list of affected files in SUMMARY.md so the user can opt in per-patch later.
- **D-5 — upgrade the existing critic function, do not add a new critic module** (F-4).
- **D-6 — palette identity is unchanged.** Do not restyle the cool/neutral palette. New constants only; existing palette entries keep their values unless a specific entry is provably the unreadable half of a pair (`step_marker_text` is the one candidate — see Task 2).
</locked_decisions>

<commit_staging_constraint>
The working tree has FIVE pre-existing uncommitted `.maxpat` modifications that are NOT part of this task: `patches/kicksynth/generated/kicksynth.maxpat`, `patches/performancepatchtest/generated/performance-patch-template.maxpat`, `patches/reverse-delay/generated/reverse-delay.maxpat`, `patches/stereo-feedback-delay/generated/stereo-feedback-delay.maxpat`, `patches/timestretch/generated/timestretch.maxpat`.

Per CLAUDE.md Rule #7, `git add .` and `git add -A` are forbidden. Every commit in this plan MUST stage an explicit, named file list drawn only from `src/`, `tests/`, `CLAUDE.md`, and `.planning/`. Before each commit, run `git status --short` and confirm the five paths above are still unstaged. `git stash` is prohibited.
</commit_staging_constraint>

<tasks>

<task type="tracer" tdd="true">
  <name>Task 1: End-to-end presentation contrast — one path, proven on disk</name>
  <files>tests/test_aesthetics.py, src/maxpat/aesthetics.py, src/maxpat/defaults.py</files>
  <precondition>`python3 -m pytest tests/test_aesthetics.py tests/test_critics.py tests/test_claude_md.py -q` currently reports 169 passed. Record the full-suite baseline first with `python3 -m pytest -q 2>&1 | tail -3` and save it to the quick-task directory as `260826-kvk-BASELINE.txt`.</precondition>
  <behavior>
    Write these tests FIRST and confirm they fail against current code:
    - A patcher with a dark canvas, a panel whose `presentation_rect` covers a light region, and a comment whose `presentation_rect` sits inside that panel but whose `patching_rect` sits far outside it: after `ensure_text_contrast()`, the comment's textcolor is the DARK candidate. (This is the headline regression — it reproduces the gong-model 30/30 finding.)
    - The same patcher taken through `Patcher.from_dict(p.to_dict())` so every box carries `_raw`, then `ensure_text_contrast()`, then `to_dict()` again: the resulting dict for that comment contains the dark `textcolor`. (Proves the `_raw` write-through; without it this fix ships silently broken.)
    - After `set_canvas_background(p)`, `p.props` contains a `bgcolor` key equal to the canvas color.
    - A disk round-trip via `save_patch_roundtrip(p.to_dict(), tmp_path / "t.maxpat")` followed by `json.load`: the comment's `textcolor` is present and dark in the file. (`tmp_path` is outside any `patches/` tree, so no git commit is triggered — F-6.)
  </behavior>
  <action>
Add to `src/maxpat/defaults.py`, near AESTHETIC_PALETTE: `MIN_CONTRAST_RATIO = 4.5` and `MAX_DEFAULT_PANEL_BG`. Give each a comment recording provenance — the ratio cites WCAG AA for normal text; the panel constant cites finding F-3 above, stating plainly that MAX ships no discoverable default and that the value is a documented assumption whose exact figure is made non-load-bearing by the maximize-the-minimum rule in `best_text_color`. Do not add these to AESTHETIC_PALETTE (D-6 keeps the palette dict untouched); they are separate module-level constants.

In `src/maxpat/aesthetics.py` add three pure primitives that take plain lists and return plain values, with no Box or Patcher dependency, so the raw-dict critic in Task 3 can import them unchanged:
  - `relative_luminance(rgba)` — WCAG: linearize each of R, G, B (channel divided by 12.92 below the 0.03928 knee, otherwise `((c + 0.055) / 1.055) ** 2.4`), then weight 0.2126 / 0.7152 / 0.0722.
  - `contrast_ratio(fg, bg)` — `(lighter + 0.05) / (darker + 0.05)` over the two relative luminances.
  - `best_text_color(backgrounds, candidates=None)` — accepts a LIST of candidate backgrounds (one entry when the background is known, several when it is indeterminate) and returns the candidate text color maximizing the minimum `contrast_ratio` across that list. Default candidates are the two existing palette-adjacent text colors `[0.20,0.20,0.25,1.0]` and `[0.80,0.80,0.82,1.0]`. Ties break toward the dark candidate.

Keep the existing `contrast_text_color(bg_color)` signature working — reimplement its body as `best_text_color([bg_color])`, preserving the `None` -> `annotation_color` branch so current callers and tests are unaffected.

Rewrite `ensure_text_contrast()` so that, for each comment box, it resolves the effective background per coordinate space rather than once in patching space:
  - Build the panel list once, and for each panel record both its `patching_rect` and its `presentation_rect` (when the panel is in presentation).
  - Determine the patching-space background from the box's `patching_rect` center against panels' `patching_rect`s, falling back to the patcher background.
  - When the box is in presentation, determine the presentation-space background from the box's `presentation_rect` center against panels' `presentation_rect`s, falling back to the patcher background.
  - Feed the resolved background(s) to `best_text_color`. Per D-1, when the two spaces disagree the presentation result wins; state that rationale in the docstring.

Read the patcher background from `patcher.props`, preferring `bgcolor`, then `editing_bgcolor`, then `locked_bgcolor`, then the palette canvas value.

Update `set_canvas_background()` to write `bgcolor` alongside `editing_bgcolor` and `locked_bgcolor`, all to the same value (F-1).

Write the resolved color to `box.extra_attrs["textcolor"]` and, when `box._raw is not None`, also to `box._raw["textcolor"]`. Without the second write the round-trip serialize path drops it (CLAUDE.md Rule #5). Add a short inline note at that write explaining why both destinations are required.

Scope this task to the single presentation path only. Panel encodings beyond what the tracer test needs, box-own-bgcolor precedence, and the step marker are Task 2 — do not start them here.
  </action>
  <verify>
    <automated>python3 -m pytest tests/test_aesthetics.py -q</automated>
  </verify>
  <done>All four new tests pass; they failed before the `aesthetics.py` change. `git status --short` shows the five pre-existing `.maxpat` paths still unstaged. Committed with an explicit file list: `git add src/maxpat/aesthetics.py src/maxpat/defaults.py tests/test_aesthetics.py && git commit`.</done>
</task>

<task type="auto" tdd="true">
  <name>Task 2: Complete the engine — all panel encodings, box-own background, opt-in repair</name>
  <files>src/maxpat/aesthetics.py, src/maxpat/defaults.py, src/maxpat/__init__.py, tests/test_aesthetics.py</files>
  <behavior>
    Write these tests first and confirm they fail:
    - A panel carrying only flat `grad1`/`grad2` keys (the 35-panel majority encoding, F-2) resolves to the `grad1` color rather than `None`, and a comment over it gets the readable candidate.
    - A panel carrying no color key at all resolves to a color rather than `None`, and the comment over it receives a text color whose contrast ratio is at least `MIN_CONTRAST_RATIO` against BOTH the assumed default and the canvas.
    - `add_section_header()` followed by `ensure_text_contrast()` on a dark canvas yields text whose contrast ratio against the header's OWN light `bgcolor` clears `MIN_CONTRAST_RATIO`. This replaces the assertion in the existing `test_section_header_on_dark_canvas` (F-5).
    - `add_step_marker()` followed by `ensure_text_contrast()` yields a marker textcolor whose contrast ratio against the amber `step_marker_bg` clears `MIN_CONTRAST_RATIO`.
    - `repair_text_contrast()` on a patcher loaded via `from_dict` returns a count of boxes it changed, and the changed textcolors are present after a second `to_dict()`.
  </behavior>
  <action>
Extend `_get_panel_bgcolor()` to cover all three encodings in priority order — `bgfillcolor` dict (read `color1`, or `color` when `color1` is absent), then flat `grad1` at the top level of the attributes, then `bgcolor` — and to return `MAX_DEFAULT_PANEL_BG` instead of `None` when a panel carries none of them. Have it report whether the color was found or assumed (return a tuple, or a small named result) so callers can route an assumed background into `best_text_color` as a multi-candidate list per D-3 and F-3, and so the Task 3 critic can downgrade its finding for that case.

Because the raw-dict critic must reuse this, refactor the attribute access to go through a small helper that takes a plain attribute dict — `Box.extra_attrs` on the object side, the raw box dict on the critic side. Both entry points call the same resolver.

Apply D-2: before consulting panels or canvas, check whether the box itself carries a `bgcolor`. If it does, that is the effective background for that box in both spaces. This alone fixes `add_section_header`, which pairs a light `header_bgcolor` with light text today.

Broaden the box filter beyond `maxclass == "comment"`. Include boxes whose text color is generator-controlled and which render text over a background — at minimum comments and the `textbutton` produced by `add_step_marker`. Keep the existing guarantee that boxes with no generator-set text color are left untouched, so `test_non_comment_boxes_untouched` still holds for plain objects like `toggle`; adjust that test only if the broadened filter genuinely subsumes its subject, and say so in the commit message if you do.

For the step marker specifically, stop hardcoding white. Have `add_step_marker` derive its text color from the marker's own `bgcolor` via `best_text_color`, so the amber chip gets whichever candidate actually reads. Leave the `step_marker_text` palette entry in place for back-compat unless a test proves it unused; per D-6 do not touch other palette entries.

Add `repair_text_contrast(patcher)` — an explicitly-called helper that runs the same resolution over an already-loaded patcher and returns the number of boxes whose textcolor it changed. Export it from `src/maxpat/__init__.py` alongside `ensure_text_contrast`. Per D-4 it must not be wired into any automatic path; the `is_new=False` branch of `hooks.finalize_patch` stays exactly as it is.

Correct the existing tests identified in F-5. Correct them by fixing the expected value to the readable one; do not delete them and do not loosen unrelated assertions to reach green.
  </action>
  <verify>
    <automated>python3 -m pytest tests/test_aesthetics.py tests/test_layout.py tests/test_patcher.py -q</automated>
  </verify>
  <done>All new tests pass. The two tests named in F-5 now assert readable pairings. `repair_text_contrast` is importable from `src.maxpat`. `git diff --stat` shows zero files under `patches/`. Committed with an explicit file list covering only `src/maxpat/aesthetics.py`, `src/maxpat/defaults.py`, `src/maxpat/__init__.py`, `tests/test_aesthetics.py`.</done>
</task>

<task type="auto">
  <name>Task 3: Critic guard, CLAUDE.md rule, and measured impact report</name>
  <files>src/maxpat/critics/layout_critic.py, tests/test_critics.py, CLAUDE.md</files>
  <action>
Rewrite `_check_text_contrast()` in `src/maxpat/critics/layout_critic.py` to import the primitives from `src.maxpat.aesthetics` and evaluate each text-bearing box against its EFFECTIVE background instead of against the `AESTHETIC_PALETTE["canvas_bg"]` constant (F-4). It receives raw dicts, so read `patching_rect`, `presentation_rect`, `presentation`, `bgcolor`, `bgfillcolor`, and `grad1` straight off the box dicts and feed them to the shared resolver built in Task 2. Give it access to the patcher-level background as well — `review_layout` currently passes only `box_list`, so also thread through the patcher props dict (prefer `bgcolor`, then `editing_bgcolor`, then `locked_bgcolor`, then the palette value) and update the `review_layout` call site at line 62 accordingly.

Replace the luminance-delta threshold with a `contrast_ratio` test against `MIN_CONTRAST_RATIO`. Severity: `warning` when the effective background is known and the ratio falls short; `note` when the background was assumed rather than found, and `note` for the D-1 case where presentation was chosen and patching mode is the compromised space. Name the offending box's text (truncated) and the measured ratio in the finding, and point the suggestion at `ensure_text_contrast()` / `repair_text_contrast()`.

Add tests to `tests/test_critics.py`: a patch dict with a light panel and light presentation text over it produces a contrast warning; the same patch with dark text produces none; a panel with no color encoding produces a `note` rather than a `warning`.

Then codify the rule in `CLAUDE.md`. Under Rule #4 (Patch Style), add a short subsection stating that text color is never chosen against the editing background alone — it is resolved against the effective background in whichever coordinate space the text is displayed in, using a WCAG contrast ratio, and that a box's own background wins over any panel beneath it. Under Rule #9 (Presentation Mode Parity), add that presentation parity includes contrast parity: a control or label promoted into presentation must be readable against its presentation-mode background, and that the patcher-level `bgcolor` key is what MAX honors for locked and presentation mode — leaving it unset makes MAX fall back to its light default while generator-side logic assumes dark. Keep both additions tight; `tests/test_claude_md.py` asserts on section headings, so preserve the existing `Rule #4` and `Rule #9` heading text verbatim.

Finally, measure and report — do not fix — the existing blast radius. Write a short script into the quick-task directory that walks `patches/*/generated/*.maxpat` and, for every text-bearing box, computes the contrast ratio against its effective background in the space where it is displayed. Save the per-file counts to `260826-kvk-AFFECTED.txt` in the quick-task directory. Per D-4 this is a report only: no `.maxpat` file is edited.
  </action>
  <verify>
    <automated>python3 -m pytest -q 2>&1 | tail -3</automated>
  </verify>
  <done>Full suite shows no net regressions against `260826-kvk-BASELINE.txt` (same or fewer failures; every previously-passing test still passes). `260826-kvk-AFFECTED.txt` exists with per-file counts. `git status --short` shows the five pre-existing `.maxpat` paths still unstaged and unmodified. Committed with an explicit file list covering only `src/maxpat/critics/layout_critic.py`, `tests/test_critics.py`, `CLAUDE.md`, and the `.planning/quick/260826-kvk-*/` artifacts.</done>
</task>

</tasks>

<verification>
1. `python3 -m pytest -q` — no net regressions vs `260826-kvk-BASELINE.txt`.
2. `git status --short` — the five pre-existing `.maxpat` modifications are still present and unstaged; no file under `patches/` appears in any commit from this task (`git log --stat -3` confirms).
3. Behavioral proof of the headline fix: a patcher with a light panel in presentation and a comment over it yields dark comment text that survives a `to_dict` -> `from_dict` -> `to_dict` cycle and lands in a file saved to a temp path.
4. `review_patch()` on a synthetic light-panel/light-text patch dict returns at least one contrast finding.
</verification>

<success_criteria>
- Presentation-space contrast is resolved from `presentation_rect`, not `patching_rect`.
- `set_canvas_background()` writes the patcher-level `bgcolor`.
- All three panel color encodings resolve, and the uncolored case yields a readable result rather than `None`.
- A box's own `bgcolor` governs its text contrast.
- Text color assignment survives the round-trip serialize path via the `_raw` write-through.
- `review_layout()` flags sub-threshold contrast using the real effective background.
- The rule is written into `CLAUDE.md` under Rules #4 and #9.
- Zero `.maxpat` files changed; the affected-file list is reported for later opt-in repair.
</success_criteria>

<output>
Create `.planning/quick/260826-kvk-fix-presentation-mode-panel-text-color-c/260826-kvk-SUMMARY.md` when done.

The SUMMARY must include the measured affected-file table from `260826-kvk-AFFECTED.txt` and an explicit note that those patches were deliberately left unmodified per D-4, with `repair_text_contrast(patcher)` named as the opt-in path. Also record finding F-7 (contrast is not recomputed on the `is_new=False` edit path) as a known, deliberate limitation.
</output>
