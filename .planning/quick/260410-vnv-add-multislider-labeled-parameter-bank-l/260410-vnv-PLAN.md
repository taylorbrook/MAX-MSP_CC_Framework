---
phase: quick
plan: 260410-vnv
type: execute
wave: 1
depends_on: []
files_modified:
  - CLAUDE.md
  - src/maxpat/defaults.py
  - src/maxpat/sizing.py
autonomous: true
requirements: []
must_haves:
  truths:
    - "CLAUDE.md Rule #4 contains Multislider as Labeled Parameter Bank subsection with all specified guidance"
    - "defaults.py exports MS_BAR_HEIGHT, MS_LABEL_FONTSIZE, MS_LABEL_HEIGHT, MS_LABEL_WIDTH, MS_GAP constants"
    - "sizing.py has a comment above multislider entry noting labeled bank height override"
  artifacts:
    - path: "CLAUDE.md"
      provides: "Multislider labeled parameter bank layout rules under Rule #4"
      contains: "Multislider as Labeled Parameter Bank"
    - path: "src/maxpat/defaults.py"
      provides: "Multislider layout constants"
      contains: "MS_BAR_HEIGHT"
    - path: "src/maxpat/sizing.py"
      provides: "Comment noting labeled bank override for multislider"
      contains: "MS_BAR_HEIGHT"
  key_links: []
---

<objective>
Add multislider labeled parameter bank layout rules to project documentation and code constants.

Purpose: Codify the pattern for using multislider with horizontal bars + comment labels as a parameter bank, so agents produce consistent layouts without trial-and-error.
Output: Updated CLAUDE.md, defaults.py, sizing.py with the new rules and constants.
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/execute-plan.md
@$HOME/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@CLAUDE.md
@src/maxpat/defaults.py
@src/maxpat/sizing.py
</context>

<tasks>

<task type="auto">
  <name>Task 1: Add multislider parameter bank rules and constants</name>
  <files>CLAUDE.md, src/maxpat/defaults.py, src/maxpat/sizing.py</files>
  <action>
Three edits:

**1. CLAUDE.md** -- After the last bullet in Rule #4: Patch Style (line 86, after the "Standard object spacing" bullet), add a new subsection:

```markdown
#### Multislider as Labeled Parameter Bank

When multislider bars represent labeled parameters (with comment labels alongside):
- Set `orientation: 0` (horizontal bars stacked vertically) explicitly
- Bar-to-label alignment formula: multislider height = `size * label_spacing` where label_spacing matches comment spacing (typically 24px for fontsize=10 labels)
- Comment labels start at the same Y as the multislider top, spaced at `ms_height / ms_size` intervals
- For fontsize=10 labels: use height=18, spacing=24px, so multislider height = size * 24
- Always set `contdata: 1` for real-time feedback during drag
- Always set `setstyle: 1` for bar display
- When adding utility/routing objects (prepend chains, init messages, js engines), encapsulate them in named subpatchers (`p drift`, `p settings`, etc.) to keep top-level patch clean
- Example extra_attrs for a 14-param bank: `{"size": 14, "setminmax": [0.0, 1.0], "orientation": 0, "contdata": 1, "setstyle": 1}`
```

**2. src/maxpat/defaults.py** -- After the `H_GUTTER` line (line 18), add a blank line then these constants:

```python
# Multislider labeled parameter bank layout constants
MS_BAR_HEIGHT = 24.0       # Height per bar for labeled multislider banks
MS_LABEL_FONTSIZE = 10.0   # Font size for multislider row labels
MS_LABEL_HEIGHT = 18.0     # Comment box height for multislider row labels
MS_LABEL_WIDTH = 85.0      # Comment box width for multislider row labels
MS_GAP = 8.0               # Horizontal gap between adjacent multisliders in a bank
```

**3. src/maxpat/sizing.py** -- Above the `"multislider"` entry in UI_SIZES (line 43), add a comment:

```python
    # For labeled parameter banks, override patching_rect height with MS_BAR_HEIGHT * size
    # (see defaults.py MS_BAR_HEIGHT and CLAUDE.md Rule #4 subsection)
```

Keep the existing `"multislider": (200.0, 100.0),` line unchanged -- the comment explains when to override.
  </action>
  <verify>
    <automated>python3 -c "from src.maxpat.defaults import MS_BAR_HEIGHT, MS_LABEL_FONTSIZE, MS_LABEL_HEIGHT, MS_LABEL_WIDTH, MS_GAP; assert MS_BAR_HEIGHT == 24.0; assert MS_GAP == 8.0; print('OK')" && grep -q "Multislider as Labeled Parameter Bank" CLAUDE.md && grep -q "MS_BAR_HEIGHT" src/maxpat/sizing.py && echo "All checks passed"</automated>
  </verify>
  <done>
    - CLAUDE.md has "Multislider as Labeled Parameter Bank" subsection under Rule #4 with all 8 bullets and example
    - defaults.py exports 5 new MS_* constants with correct values
    - sizing.py has comment above multislider entry referencing MS_BAR_HEIGHT override pattern
  </done>
</task>

</tasks>

<verification>
- `python3 -c "from src.maxpat.defaults import MS_BAR_HEIGHT, MS_LABEL_FONTSIZE, MS_LABEL_HEIGHT, MS_LABEL_WIDTH, MS_GAP"` imports without error
- `grep "Multislider as Labeled Parameter Bank" CLAUDE.md` finds the subsection
- `grep "MS_BAR_HEIGHT" src/maxpat/sizing.py` finds the comment in sizing.py
</verification>

<success_criteria>
All three files updated with the specified multislider parameter bank layout rules and constants. Python imports succeed. No existing functionality changed.
</success_criteria>

<output>
After completion, create `.planning/quick/260410-vnv-add-multislider-labeled-parameter-bank-l/260410-vnv-SUMMARY.md`
</output>
