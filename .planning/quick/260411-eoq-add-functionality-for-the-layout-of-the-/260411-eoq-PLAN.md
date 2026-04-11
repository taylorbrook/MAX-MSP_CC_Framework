---
phase: quick
plan: 260411-eoq
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/aesthetics.py
  - src/maxpat/patcher.py
  - src/maxpat/__init__.py
  - tests/test_aesthetics.py
autonomous: true
must_haves:
  truths:
    - "Comment text placed on a dark canvas background is automatically given a light textcolor"
    - "Comment text placed on/over a light panel is automatically given a dark textcolor"
    - "Section headers, subsections, and annotations all get contrast-appropriate textcolor when on panels"
    - "The contrast pass runs automatically during finalize_patch for new patches"
    - "Comments with explicit user-set textcolor are not overridden"
  artifacts:
    - path: "src/maxpat/aesthetics.py"
      provides: "ensure_text_contrast function that scans all comment boxes and sets textcolor based on overlapping panel or canvas background"
      contains: "def ensure_text_contrast"
    - path: "tests/test_aesthetics.py"
      provides: "Tests for contrast enforcement on comments over panels and canvas"
      contains: "TestEnsureTextContrast"
  key_links:
    - from: "src/maxpat/aesthetics.py"
      to: "src/maxpat/hooks.py"
      via: "ensure_text_contrast called from apply_auto_styling"
      pattern: "ensure_text_contrast"
---

<objective>
Add automatic font-vs-background contrast enforcement so that every comment box in a patch has readable text color relative to whatever is behind it (dark canvas or light panel).

Purpose: Currently `contrast_text_color()` exists in aesthetics.py but is never called. Comments use hardcoded semantic colors that may be unreadable on certain backgrounds (e.g., dark subsection_color text on dark canvas, or light annotation text on a light panel). This creates a manual fix burden on every patch.

Output: A new `ensure_text_contrast()` function integrated into the `apply_auto_styling` pipeline so finalize_patch handles contrast automatically.
</objective>

<context>
@src/maxpat/aesthetics.py
@src/maxpat/patcher.py
@src/maxpat/hooks.py
@src/maxpat/defaults.py
@tests/test_aesthetics.py
</context>

<tasks>

<task type="auto" tdd="true">
  <name>Task 1: Add ensure_text_contrast and integrate into styling pipeline</name>
  <files>src/maxpat/aesthetics.py, src/maxpat/__init__.py, tests/test_aesthetics.py</files>
  <behavior>
    - Test: comment on dark canvas (no panels) gets light textcolor from contrast_text_color
    - Test: comment spatially inside a light panel gets dark textcolor
    - Test: comment outside any panel on dark canvas gets light textcolor
    - Test: comment with explicit user-set textcolor (already in extra_attrs before ensure_text_contrast runs) is NOT overridden
    - Test: section_header on dark canvas gets light text; section_header on light panel gets dark text
    - Test: annotation on dark canvas gets light text; annotation on light panel gets dark text
    - Test: subsection on dark canvas gets light text
    - Test: non-comment boxes are not touched by ensure_text_contrast
    - Test: panel with custom (non-palette) bgcolor is respected for contrast calculation
    - Test: gradient panel uses color1 for contrast calculation
  </behavior>
  <action>
1. In `src/maxpat/aesthetics.py`, add function `ensure_text_contrast(patcher)`:
   - Collect all panel boxes from patcher.boxes (maxclass == "panel")
   - Get the canvas background color from patcher.props.get("editing_bgcolor") or patcher.props.get("locked_bgcolor") or AESTHETIC_PALETTE["canvas_bg"]
   - For each comment box (maxclass == "comment"):
     - Determine the effective background: check if the comment's patching_rect center point falls within any panel's patching_rect. If multiple panels overlap, use the last one in the boxes list (highest z-order for background elements). Extract the panel's bgcolor: from extra_attrs["bgfillcolor"]["color1"] for gradient panels, or extra_attrs["bgcolor"] for solid panels
     - If no panel covers the comment, use the canvas background color
     - Call `contrast_text_color(effective_bg)` to get the appropriate text color
     - Set `box.extra_attrs["textcolor"]` to that color
   - Mark the box with a private flag `box.extra_attrs.get("_user_textcolor")` -- skip if present. To support this: in `apply_auto_styling`, call `ensure_text_contrast` AFTER the existing auto-highlight loop. The semantic tier methods (add_section_header, add_subsection, add_annotation) already set textcolor -- these should be treated as overridable defaults, NOT user-set. The distinction: add a `_contrast_managed` sentinel. Actually, simpler approach: just always set textcolor based on contrast. The semantic tier colors are nice-to-have but readability trumps them. If the user explicitly wants a specific color, they can set it after finalize_patch.

   Refined approach: `ensure_text_contrast(patcher)` sets textcolor on ALL comment boxes unconditionally based on their effective background. This is correct because:
   - The semantic tier colors (header_color, subsection_color, annotation_color) were designed for the default light-gray canvas, not for the dark canvas we actually use
   - Readability is more important than semantic coloring
   - Users who want custom colors set them after finalize_patch

2. Call `ensure_text_contrast(patcher)` at the end of `apply_auto_styling()` in aesthetics.py.

3. Export `ensure_text_contrast` from `src/maxpat/__init__.py` alongside existing aesthetics exports.

4. In `tests/test_aesthetics.py`, add class `TestEnsureTextContrast` with the tests from the behavior block above. Use `Patcher()` instances with `set_canvas_background()` to set dark/light backgrounds, `add_panel()` for panels, and `add_comment()` / `add_section_header()` / `add_annotation()` for text. Call `ensure_text_contrast(patcher)` and assert textcolor values.

Helper for point-in-rect check (private function in aesthetics.py):
```python
def _point_in_rect(px, py, rect):
    """Check if point (px, py) is inside [x, y, w, h] rect."""
    x, y, w, h = rect
    return x <= px <= x + w and y <= py <= y + h
```
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_aesthetics.py::TestEnsureTextContrast -xvs</automated>
  </verify>
  <done>
    - ensure_text_contrast function exists in aesthetics.py and is called from apply_auto_styling
    - Comments on dark canvas get light text ([0.80, 0.80, 0.82, 1.0])
    - Comments on light panels get dark text ([0.20, 0.20, 0.25, 1.0])
    - Non-comment boxes are untouched
    - All tests pass
  </done>
</task>

<task type="auto">
  <name>Task 2: Add contrast check to layout critic</name>
  <files>src/maxpat/critics/layout_critic.py, tests/test_aesthetics.py</files>
  <action>
Add a new check `_check_text_contrast` to the layout critic that flags comment boxes with poor contrast against their effective background. This catches patches that were loaded/edited without running ensure_text_contrast (e.g., manually edited patches).

In `src/maxpat/critics/layout_critic.py`:
1. Add `_check_text_contrast(box_list)` function:
   - For each comment box, extract its textcolor (default to [0.0, 0.0, 0.0, 1.0] if absent)
   - For now, check contrast against the default canvas_bg (0.333 gray) since the critic works on raw dicts without patcher context
   - Compute luminance of textcolor and luminance of canvas_bg
   - If the contrast ratio (abs difference of luminances) is below 0.3, flag a warning: "Low contrast text: comment '{text}' has textcolor luminance {L1:.2f} on canvas luminance {L2:.2f}"
   - Suggestion: "Set textcolor for better readability, or use ensure_text_contrast() in the styling pipeline"

2. Call `_check_text_contrast` from `review_layout` alongside existing checks.

3. Add 2 tests in `tests/test_aesthetics.py` class `TestContrastCritic`:
   - Test: comment with dark text on dark canvas triggers warning
   - Test: comment with light text on dark canvas does NOT trigger warning

Use the critic's raw-dict interface (build patch_dict manually or via patcher.to_dict()).
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_aesthetics.py::TestContrastCritic -xvs</automated>
  </verify>
  <done>
    - Layout critic detects low-contrast comment text
    - Dark text on dark canvas triggers a warning
    - Light text on dark canvas passes without warning
    - All existing tests still pass: `python -m pytest tests/test_aesthetics.py -x`
  </done>
</task>

</tasks>

<verification>
```bash
cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_aesthetics.py -xvs
```
All existing and new tests pass. No regressions in the aesthetic/layout pipeline.
</verification>

<success_criteria>
- ensure_text_contrast is integrated into apply_auto_styling and runs during finalize_patch
- Comments on dark canvas get light text automatically
- Comments on light panels get dark text automatically
- Layout critic warns about low-contrast text in loaded patches
- All tests pass (existing + new)
</success_criteria>

<output>
After completion, create `.planning/quick/260411-eoq-add-functionality-for-the-layout-of-the-/260411-eoq-SUMMARY.md`
</output>
