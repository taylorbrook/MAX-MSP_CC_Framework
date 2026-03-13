# Technology Stack: v1.1 Patch Quality & Aesthetics

**Project:** MaxSystem v1.1 -- Object DB Audit, Patch Aesthetics, Refined Positioning
**Researched:** 2026-03-13
**Overall Confidence:** HIGH

## Executive Summary

The v1.1 milestone requires three capabilities: (1) parsing ~973 MAX help patches to extract ground truth object data (outlet types, inlet counts, argument formats, connection patterns), (2) generating patches with visual polish (panels, background colors, comment styling), and (3) enriching the layout engine with aesthetic defaults.

**No new dependencies are needed.** All three capabilities are achievable with Python stdlib (`json`, `pathlib`, `os`, `collections`, `csv`) and the existing project codebase. The .maxhelp files are standard JSON (same format as .maxpat), parsable in 0.17s for all 973 files including deep recursive traversal of 53,178 boxes and 31,476 connections. The aesthetic properties (panel objects, comment bubble styling, background layering, font overrides) are simple JSON key/value pairs in the existing box dict structure, requiring only additions to `patcher.py`, `defaults.py`, and `layout.py`.

The v1.0 STACK.md recommended py2max, Zod, fast-xml-parser, Vitest, and SQLite. In practice, the project built a custom Python stack (`patcher.py`, `layout.py`, `db_lookup.py`, `validation.py`) without py2max or Zod. For v1.1, continue with the same custom Python-only approach. Do NOT introduce new libraries.

## Recommended Stack Additions (v1.1)

### Help Patch Parsing & Audit Tools

| Technology | Version | Purpose | Why |
|------------|---------|---------|-----|
| Python `json` (stdlib) | 3.14 | Parse .maxhelp JSON files | Already used throughout project. Parses all 973 help patches in 0.17s including recursive subpatcher traversal. .maxhelp files are identical JSON format to .maxpat. No external parser needed. |
| Python `pathlib` (stdlib) | 3.14 | File discovery and path handling | Walk `/Applications/Max.app/Contents/Resources/C74/help/{max,msp,jitter,m4l}/` directories. Already used in `db_lookup.py`. |
| Python `collections` (stdlib) | 3.14 | Data aggregation (Counter, defaultdict) | Aggregate outlet types, argument patterns, connection patterns across 53,178 boxes. Already used in `layout.py` and `validation.py`. |
| Python `csv` (stdlib) | 3.14 | Audit report generation | Optional. Generate diff reports (DB vs help patch ground truth) as CSV for review. |

**Key finding:** The help patch directory structure is:
```
/Applications/Max.app/Contents/Resources/C74/help/
  max/     (Max control objects)
  msp/     (MSP audio objects)
  jitter/  (Jitter video objects)
  m4l/     (Max for Live objects)
  resources/
```

Help files use `.maxhelp` extension but are identical JSON format to `.maxpat`. 973 help patches cover 934 of our 1,672 DB objects. The remaining 738 are mostly operator variants (`+`, `-`, `*~`, etc.), MC wrappers (`mc.cycle~`), and Gen internals that share help files with their base objects.

### Aesthetic Patch Generation

| Technology | Version | Purpose | Why |
|------------|---------|---------|-----|
| Existing `patcher.py` | Current | Extended Box model with aesthetic properties | Add `bgcolor`, `textcolor`, `bubble`, `bubbleside`, `style`, `fontface`, `background`, `rounded`, `border`, `bordercolor` to `extra_attrs` or as first-class Box properties. Panel objects already work as boxes with `maxclass="panel"`. |
| Existing `defaults.py` | Current | Aesthetic default constants | Add constants for help-file-standard styling: comment font size (13.0), bubble default (True for annotations), helpfile_label style, panel default colors, textbutton step-marker styling. |
| Existing `layout.py` | Current | Panel positioning and background layering | Panels are background decorative objects. Add panel support to layout engine: panels need `background: 1` to draw behind other objects, and `ignoreclick: 1` to not intercept mouse events. |

**No new files needed** for aesthetics -- the existing Box/Patcher model already supports arbitrary JSON properties via `extra_attrs`. The work is adding convenience methods and defaults, not new infrastructure.

### What Specifically Needs to Change

#### `patcher.py` -- New Methods

```python
# Add panel support (background rectangle)
def add_panel(self, x, y, width, height, bgcolor=None, border=0, rounded=0) -> Box

# Add styled comment (help-file quality)
def add_styled_comment(self, text, x, y, style="helpfile_label", bubble=False, bubbleside=0) -> Box
```

#### `defaults.py` -- New Constants

```python
# Aesthetic constants from help patch analysis (973 patches analyzed)
HELPFILE_COMMENT_FONTSIZE = 13.0     # 2,329 bubble comments + 885 non-bubble = 13pt standard
HELPFILE_LABEL_STYLE = "helpfile_label"  # 739 uses in help patches
BUBBLE_DEFAULT_SIDE = 0              # 0=left (default), 2=right, 3=bottom

# Panel defaults (from 159 panels across help patches)
PANEL_DEFAULT_BGCOLOR = [0.866667, 0.839216, 0.815686, 1.0]  # Warm tan, most common (24x)
PANEL_DEFAULT_MODE = 0               # Solid fill (140x) vs gradient (19x)
PANEL_DEFAULT_BORDER = 1             # Thin border (39x at 1, 50x at 2)
PANEL_DEFAULT_ROUNDED = 0            # Sharp corners (68x at 0)
PANEL_DEFAULT_PROPORTION = 0.39      # Standard proportion (99x)

# Textbutton step markers (from help patch convention: 565 with background=1)
STEP_MARKER_BGCOLOR = [0.9, 0.65, 0.05, 1.0]   # Orange/amber
STEP_MARKER_TEXTCOLOR = [0.34902, 0.34902, 0.34902, 1.0]  # Dark gray
STEP_MARKER_ROUNDED = 60.0           # Circular appearance
STEP_MARKER_FONTNAME = "Arial Bold"
```

#### `layout.py` -- Panel and Background Awareness

Background objects (`background: 1`) must be positioned BEFORE regular objects in the boxes array (MAX renders in array order, background objects go to back layer). The layout engine needs to:
1. Sort boxes so `background=1` objects come first in the array
2. Skip panel/background objects during topological layout (they are decorative)
3. Size panels to encompass their associated object groups

#### `db_lookup.py` -- No Changes

The database structure is fine. Audit results flow into `overrides.json` (existing correction mechanism). The audit tool is a standalone script, not a modification to the runtime lookup.

## Audit Tool Architecture

The audit tool is a new standalone script (`scripts/audit_help_patches.py`) that:

1. **Walks** all 973 .maxhelp files
2. **Extracts** per-object: outlet types, inlet count, outlet count, argument patterns, connection patterns
3. **Compares** against the object database (`db_lookup.py`)
4. **Generates** a diff report and optionally updates `overrides.json`

**Performance:** Full recursive parse of all help patches takes 0.17s. Comparison against 1,672 DB objects adds negligible overhead. Total audit runtime will be under 1 second.

**Data extraction from help patches (verified):**
- `outlettype` array: Available on every box. Ground truth for signal vs control outlet classification. Found 1,007 unique objects with outlet types, including 10 mixed signal/control objects (e.g., `line~` = `["signal", "bang"]`, `zigzag~` = `["signal", "signal", "", "bang"]`).
- `numinlets` / `numoutlets`: Available on every box. Reflects actual argument-dependent counts.
- `text` field: Contains object name and arguments (e.g., `"cycle~ 440."`, `"t b i f"`).
- Connection patterns: Source/destination with outlet/inlet indices. Validates which outlets connect to which types of inlets.

## What NOT to Add

| Technology | Why Not |
|------------|---------|
| py2max | Project already has its own Patcher/Box/Patchline model. py2max would be a parallel system with different conventions. The custom stack is well-tested (624 tests) and exactly fits the project's needs. |
| Zod / TypeScript validation | Originally planned in v1.0 STACK.md but never adopted. Python validation pipeline works well. Adding TypeScript for aesthetics would introduce unnecessary build complexity. |
| SQLite for audit results | Overkill. Audit results go directly into `overrides.json` (existing mechanism). A JSON diff report is sufficient. |
| Pillow / image processing | Not needed. Panel colors and box styling are pure JSON properties, not image manipulation. |
| NetworkX / graph libraries | The existing layout engine has its own graph algorithms (BFS, topological sort). No external graph library needed for panel grouping. |
| Configuration files (YAML/TOML) | Aesthetic defaults should be Python constants in `defaults.py`, not external config files. Keeps the single-file pattern established by the project. |
| fast-xml-parser | Originally planned for maxref XML parsing. Already done in v1.0 extraction. Help patches are JSON, not XML. |
| Template engines (Jinja2, Mako) | Aesthetic patches are generated programmatically via Python. Template engines add dependency for no benefit. |

## Existing Stack Unchanged

These v1.0 technologies remain exactly as-is for v1.1:

| Technology | Status | Notes |
|------------|--------|-------|
| Python 3.14 | Keep | Runtime for all scripts, tests, generation |
| pytest | Keep | Test framework for audit tool tests and aesthetic tests |
| `json` (stdlib) | Keep | .maxpat and .maxhelp parsing |
| Custom Patcher/Box/Patchline | Keep | Core generation model, extended with aesthetic properties |
| `validation.py` pipeline | Keep | 4-layer validation, may add aesthetic validation rules |
| `overrides.json` | Keep | Correction mechanism, audit tool writes results here |
| `db_lookup.py` ObjectDatabase | Keep | Runtime object lookup, no structural changes |

## Integration Points

### Help Patch Audit -> overrides.json

```
scripts/audit_help_patches.py
  reads: /Applications/Max.app/.../help/**/*.maxhelp
  reads: .claude/max-objects/*/objects.json
  writes: .claude/max-objects/overrides.json (updates)
  writes: scripts/audit_report.json (diff report)
```

### Aesthetic Generation -> Existing Pipeline

```
src/maxpat/patcher.py (add_panel, add_styled_comment)
  uses: src/maxpat/defaults.py (new aesthetic constants)

src/maxpat/layout.py (background-aware positioning)
  reads: box.extra_attrs["background"] to determine layering

src/maxpat/validation.py (optional aesthetic rules)
  checks: panel objects have background=1
  checks: styled comments have valid bubbleside values
```

### Help Patch Path Discovery

```python
# Standard path on macOS (verified on this machine)
HELP_BASE = Path("/Applications/Max.app/Contents/Resources/C74/help")
HELP_DIRS = ["max", "msp", "jitter", "m4l"]
# Pattern: {HELP_BASE}/{domain}/{object_name}.maxhelp
```

## File Size and Performance

| Metric | Value |
|--------|-------|
| Help patches total | 973 files, 57 MB |
| Average help patch | 62 KB |
| Largest help patch | 1.5 MB |
| Parse time (all, recursive) | 0.17s |
| Total boxes (deep) | 53,178 |
| Total connections (deep) | 31,476 |
| Unique objects in help patches | 1,156 |
| DB objects with help coverage | 934 / 1,672 (56%) |

## Aesthetic Property Reference

Properties verified across 973 help patches. These are the JSON keys that produce visual styling in MAX:

### Comment Styling
| Property | Type | Common Values | Frequency |
|----------|------|---------------|-----------|
| `fontsize` | float | 13.0 (help standard) | 9,076 uses |
| `fontname` | string | "Arial" | 8,959 uses |
| `bubble` | int (0/1) | 1 (annotation style) | 4,953 uses |
| `bubbleside` | int | 0=left, 2=right, 3=bottom | 1,124 uses |
| `style` | string | "helpfile_label" | 2,923 uses |
| `textjustification` | int | 0=left, 1=center, 2=right | 393 uses |
| `fontface` | int | 0=regular, 1=bold, 2=italic | varies |

### Panel (Background Rectangle)
| Property | Type | Common Values | Frequency |
|----------|------|---------------|-----------|
| `bgcolor` | [r,g,b,a] | [0.87, 0.84, 0.82, 1.0] (warm tan) | 100 uses |
| `mode` | int | 0=solid fill, 1=gradient | 159 total |
| `border` | int | 1 or 2 | 92 uses |
| `bordercolor` | [r,g,b,a] | [0,0,0,1] (black) | 71 uses |
| `rounded` | float | 0 (sharp), 4, 15 | 81 uses |
| `background` | int (0/1) | 1 (draw behind) | 27 uses |
| `angle` | float | 0.0 or 270.0 (gradient) | 117 uses |
| `proportion` | float | 0.39 | 99 uses |

### Background Layering
| Property | Type | Effect | Frequency |
|----------|------|--------|-----------|
| `background` | int (0/1) | Draw behind other objects | 1,096 total |
| `ignoreclick` | int (0/1) | Don't intercept mouse events | 4,939 total |

Objects with `background: 1` are drawn on the back layer. Combined with `ignoreclick: 1`, they become purely decorative. Most common on textbutton (step markers: 954), jit.pwindow (92), and panel (27).

## Sources

### Verified on Machine (HIGH confidence)
- Help patch directory: `/Applications/Max.app/Contents/Resources/C74/help/` -- 973 .maxhelp files confirmed
- .maxhelp format: JSON, identical to .maxpat -- verified by parsing all 973 files with `json.load()`
- Aesthetic properties: Extracted from recursive analysis of 53,178 boxes across all help patches
- Panel patterns: 159 panel objects analyzed across 50 help patches
- Comment styling: 12,075 comment objects analyzed, top patterns documented
- Parsing performance: Benchmarked at 0.17s for full recursive parse of all help patches

### Existing Codebase (HIGH confidence)
- `src/maxpat/patcher.py` -- Box model already supports `extra_attrs` for arbitrary properties
- `src/maxpat/defaults.py` -- Centralized constants, easy to extend
- `src/maxpat/layout.py` -- Component-based layout, ready for panel awareness
- `src/maxpat/db_lookup.py` -- ObjectDatabase loads and applies overrides.json
- `src/maxpat/validation.py` -- 4-layer pipeline, extensible for aesthetic rules
- `.claude/max-objects/overrides.json` -- Existing correction mechanism for DB entries
