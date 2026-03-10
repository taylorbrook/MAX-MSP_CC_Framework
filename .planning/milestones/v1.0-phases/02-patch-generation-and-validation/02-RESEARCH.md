# Phase 2: Patch Generation and Validation - Research

**Researched:** 2026-03-09
**Domain:** .maxpat file generation, layout algorithms, multi-layer validation
**Confidence:** HIGH

## Summary

Phase 2 builds the core patch generation engine that transforms an abstract description of MAX objects and connections into valid .maxpat JSON files. The .maxpat format is undocumented by Cycling '74 but is well understood through community reverse-engineering, the py2max library (MIT, 418+ tests, 99% coverage), and examination of existing patches. The format is straightforward JSON with a `patcher` wrapper containing `boxes` and `lines` arrays.

The critical architectural decisions are: (1) a maxclass mapping layer that distinguishes UI objects (which use their own name as maxclass) from non-UI objects (which use `maxclass: "newobj"` with the object name in the `text` field), (2) a column-based layout engine driven by topological sort of the connection graph, and (3) a multi-layer validation pipeline that auto-fixes what it can and blocks output only on unfixable structural errors.

**Primary recommendation:** Build a Python generation library with direct JSON construction (no external dependencies beyond the standard library), using the existing object database as the single source of truth for object existence, inlet/outlet counts, signal types, and variable I/O computation.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- Column-based layout: objects arranged in vertical columns by signal flow stage (source -> processing -> output)
- Column width is dynamic -- determined by the widest object in that column, not a fixed pixel value
- Fixed gutter of ~60-80px between columns (right edge of widest object to left edge of next column)
- Objects within a column are left-aligned
- Top-to-bottom signal flow within columns (per CLAUDE.md conventions)
- ~80-120px vertical spacing between objects in a column (per CLAUDE.md)
- Content-aware box sizing: box width calculated from the content/arguments
- UI control objects (sliders, dials, number boxes) positioned above the objects they control
- When UI objects exist, auto-generate a basic presentation mode layout grouping controls together
- Both patching mode and presentation mode layouts included in generated patches
- Section header comments label major groupings (e.g., "// OSCILLATOR", "// FILTER CHAIN")
- Inline comments on non-obvious connections explaining WHY a connection exists
- Descriptive send~/receive~ naming convention only (e.g., send~ lfo_to_filter)
- Subpatchers ([p name]) created for logical groupings with descriptive names
- Abstractions (separate .maxpat files with #1 #2 argument substitution) used when the same object pattern repeats with different parameters
- Inline subpatcher when one-off, abstraction when reused with varying arguments
- Validation auto-fix + report: auto-fixes what it can, reports what changed
- Blocks output only on unfixable structural errors
- Auto hook on .maxpat file write (FRM-05) -- triggers validation immediately
- Multi-layer validation: JSON structure validity, object existence against database, connection bounds and type checks, domain-specific rules
- Domain-specific validation: unterminated signal chains, missing gain staging, hot/cold inlet ordering, feedback loop detection
- Output directory: patches/<project_name>/ under project root
- Flat structure within each project folder
- Numeric prefixes for ordering: 00_main_patch.maxpat, 01_abstraction.maxpat, etc.
- Match MAX 9 defaults for metadata (fileversion, appversion, rect, editing_bgcolor, etc.)
- Full single-patch complexity: any number of objects, subpatchers, abstractions, UI controls
- All domains supported: Max, MSP, Jitter, MC
- bpatcher generation included
- Limit is "one main patch + its dependencies" -- multi-patch project orchestration is Phase 4

### Claude's Discretion
- Generation engine implementation approach (Python library, direct JSON construction, or hybrid)
- Layout algorithm implementation details (topological sort internals, overlap resolution)
- Validation auto-fix strategies (which fixes are safe to apply automatically)
- bpatcher sizing and embedded UI mapping

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| PAT-01 | Framework generates valid .maxpat JSON files that open in MAX without errors | .maxpat JSON structure fully documented below; py2max confirms the format; verified against Cycling74 examples |
| PAT-02 | Generated patches include correct patcher wrapper, boxes array, and lines array structure | Complete patcher structure with all required/optional fields documented |
| PAT-03 | Subpatcher and bpatcher generation supported (nested patchers) | Subpatcher uses maxclass "newobj" with text "p name" and embedded patcher object; bpatcher uses maxclass "bpatcher" with name field |
| PAT-04 | Connection validation checks outlet/inlet index bounds before output | Object database provides inlet/outlet arrays with counts; variable_io rules in overrides.json enable dynamic count computation |
| PAT-05 | Connection validation enforces signal/control type matching | Object database inlet/outlet entries include signal boolean field for type checking |
| PAT-06 | Patch layout engine positions objects with top-to-bottom signal flow convention | Column-based layout with topological sort documented; py2max FlowLayoutManager provides reference algorithm |
| PAT-07 | Layout engine spaces objects readably (~80-120px vertical, ~150-200px horizontal) | Content-aware box sizing algorithm documented; spacing constants defined by user decisions |
| PAT-08 | Multi-layer validation pipeline: JSON validity, object existence, connection bounds, domain-specific checks | Four-layer validation architecture documented with auto-fix strategies |
| FRM-05 | Hooks for pre/post validation (file writes trigger patch validation) | File write hook pattern documented -- wrapper function that validates after every .maxpat write |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Python 3.x | 3.11+ | Generation engine and validation | Already used for Phase 1 scripts; no new dependencies needed |
| json (stdlib) | built-in | .maxpat file serialization | .maxpat files are plain JSON; stdlib handles this perfectly |
| pathlib (stdlib) | built-in | File path management | Already used in Phase 1 conftest.py |
| collections (stdlib) | built-in | defaultdict for graph adjacency, Counter for stats | Topological sort and validation need graph structures |
| typing (stdlib) | built-in | Type hints for API clarity | Matches Phase 1 patterns |

### Supporting
| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| pytest | 7.x+ | Test framework | Already in use (68 tests, 0.06s); extend for patch generation tests |
| copy (stdlib) | built-in | Deep copy of patcher templates | Needed when cloning template structures for new patches |

### Alternatives Considered
| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| Direct JSON construction | py2max library | py2max adds external dependency; direct JSON is simpler, no version coupling, full control |
| Custom layout | networkx for topological sort | Overkill; stdlib-only topological sort is ~30 lines |
| Schema validation | jsonschema library | No official .maxpat schema exists; custom validation against object database is more accurate |

**Installation:**
```bash
# No new packages needed -- Python stdlib + existing pytest
pip install pytest  # Already installed from Phase 1
```

## Architecture Patterns

### Recommended Project Structure
```
src/
  maxpat/
    __init__.py          # Public API: generate_patch(), validate_patch()
    patcher.py           # Patcher, Box, Patchline dataclasses + JSON serialization
    layout.py            # Column-based layout engine with topological sort
    validation.py        # Multi-layer validation pipeline
    sizing.py            # Content-aware box sizing calculations
    maxclass_map.py      # UI vs newobj maxclass resolution
    db_lookup.py         # Object database interface (wraps .claude/max-objects/)
    hooks.py             # File write hooks (FRM-05)
    defaults.py          # MAX 9 default patcher properties, constants
tests/
    test_patcher.py      # Patcher/Box/Patchline unit tests
    test_layout.py       # Layout engine tests
    test_validation.py   # Validation pipeline tests
    test_sizing.py       # Box sizing tests
    test_generation.py   # End-to-end generation tests
    test_hooks.py        # File write hook tests
    fixtures/
      expected/          # Known-good .maxpat files for comparison
```

### Pattern 1: .maxpat JSON Structure (Verified)

**What:** The complete JSON structure for a valid .maxpat file.
**When to use:** Every time a patch is generated.

```json
{
  "patcher": {
    "fileversion": 1,
    "appversion": {
      "major": 9,
      "minor": 0,
      "revision": 0,
      "architecture": "x64",
      "modernui": 1
    },
    "classnamespace": "box",
    "rect": [85.0, 104.0, 640.0, 480.0],
    "bglocked": 0,
    "openinpresentation": 0,
    "default_fontsize": 12.0,
    "default_fontface": 0,
    "default_fontname": "Arial",
    "gridonopen": 1,
    "gridsize": [15.0, 15.0],
    "gridsnaponopen": 1,
    "objectsnaponopen": 1,
    "statusbarvisible": 2,
    "toolbarvisible": 1,
    "lefttoolbarpinned": 0,
    "toptoolbarpinned": 0,
    "righttoolbarpinned": 0,
    "bottomtoolbarpinned": 0,
    "toolbars_unpinned_last_save": 0,
    "tallnewobj": 0,
    "boxanimatetime": 200,
    "enablehscroll": 1,
    "enablevscroll": 1,
    "devicewidth": 0.0,
    "description": "",
    "digest": "",
    "tags": "",
    "style": "",
    "subpatcher_template": "",
    "assistshowspatchername": 0,
    "boxes": [],
    "lines": [],
    "dependency_cache": [],
    "autosave": 0
  }
}
```
Source: py2max Patcher class defaults + verified against Cycling74 gen-workshop examples

### Pattern 2: Box JSON Structure

**What:** How individual objects are represented in the boxes array.
**When to use:** Every object added to a patch.

Non-UI object (most objects -- cycle~, trigger, pack, etc.):
```json
{
  "box": {
    "maxclass": "newobj",
    "text": "cycle~ 440",
    "id": "obj-1",
    "numinlets": 2,
    "numoutlets": 1,
    "outlettype": ["signal"],
    "patching_rect": [200.0, 100.0, 80.0, 22.0],
    "fontname": "Arial",
    "fontsize": 12.0
  }
}
```

UI object (toggle, button, number, flonum, slider, dial, comment, message, etc.):
```json
{
  "box": {
    "maxclass": "toggle",
    "id": "obj-2",
    "numinlets": 1,
    "numoutlets": 1,
    "outlettype": ["int"],
    "patching_rect": [200.0, 50.0, 24.0, 24.0],
    "parameter_enable": 0
  }
}
```

Comment object:
```json
{
  "box": {
    "maxclass": "comment",
    "text": "// OSCILLATOR SECTION",
    "id": "obj-3",
    "numinlets": 1,
    "numoutlets": 0,
    "patching_rect": [200.0, 30.0, 150.0, 20.0],
    "fontname": "Arial",
    "fontsize": 12.0
  }
}
```

Message box:
```json
{
  "box": {
    "maxclass": "message",
    "text": "440",
    "id": "obj-4",
    "numinlets": 2,
    "numoutlets": 1,
    "outlettype": [""],
    "patching_rect": [200.0, 60.0, 50.0, 22.0],
    "fontname": "Arial",
    "fontsize": 12.0
  }
}
```
Source: Verified against multiple GitHub .maxpat files and py2max Box class

### Pattern 3: Patchline (Connection) Structure

**What:** How connections between objects are represented.
**When to use:** Every connection in a patch.

```json
{
  "patchline": {
    "source": ["obj-1", 0],
    "destination": ["obj-5", 0],
    "order": 0
  }
}
```

Hidden connection (for send~/receive~ style):
```json
{
  "patchline": {
    "source": ["obj-1", 0],
    "destination": ["obj-5", 0],
    "hidden": 1,
    "midpoints": []
  }
}
```
Source: Verified against Cycling74 SDK scripting docs and .maxpat examples

### Pattern 4: Subpatcher Structure

**What:** How subpatchers (p name) are embedded.
**When to use:** Logical groupings of objects.

```json
{
  "box": {
    "maxclass": "newobj",
    "text": "p my_subpatcher",
    "id": "obj-10",
    "numinlets": 1,
    "numoutlets": 1,
    "outlettype": [""],
    "patching_rect": [200.0, 200.0, 120.0, 22.0],
    "fontname": "Arial",
    "fontsize": 12.0,
    "patcher": {
      "fileversion": 1,
      "appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
      "classnamespace": "box",
      "rect": [100.0, 100.0, 400.0, 300.0],
      "bglocked": 0,
      "openinpresentation": 0,
      "default_fontsize": 12.0,
      "default_fontface": 0,
      "default_fontname": "Arial",
      "gridonopen": 1,
      "gridsize": [15.0, 15.0],
      "boxes": [
        {
          "box": {
            "maxclass": "inlet",
            "id": "obj-1",
            "numinlets": 0,
            "numoutlets": 1,
            "outlettype": [""],
            "patching_rect": [50.0, 30.0, 30.0, 30.0],
            "comment": "Input"
          }
        },
        {
          "box": {
            "maxclass": "outlet",
            "id": "obj-2",
            "numinlets": 1,
            "numoutlets": 0,
            "patching_rect": [50.0, 250.0, 30.0, 30.0],
            "comment": "Output"
          }
        }
      ],
      "lines": [],
      "dependency_cache": [],
      "autosave": 0
    },
    "saved_object_attributes": {
      "description": "",
      "digest": "",
      "globalpatchername": "",
      "tags": ""
    }
  }
}
```
Source: Verified against GitHub .maxpat files with nested subpatchers (estine/maxmsp_patches, Cycling74/gen-workshop)

### Pattern 5: bpatcher Structure

**What:** How bpatchers (inline UI patches) are embedded.
**When to use:** Patches that render UI inline in parent patch.

```json
{
  "box": {
    "maxclass": "bpatcher",
    "name": "my_control.maxpat",
    "id": "obj-20",
    "numinlets": 1,
    "numoutlets": 1,
    "outlettype": [""],
    "patching_rect": [200.0, 100.0, 200.0, 100.0],
    "args": [],
    "bgmode": 0,
    "border": 0,
    "clickthrough": 0,
    "enablehscroll": 0,
    "enablevscroll": 0,
    "lockeddragscroll": 0,
    "offset": [0.0, 0.0],
    "viewvisibility": 1
  }
}
```

Or embedded (patcher inside the bpatcher box):
```json
{
  "box": {
    "maxclass": "bpatcher",
    "id": "obj-20",
    "numinlets": 1,
    "numoutlets": 1,
    "outlettype": [""],
    "patching_rect": [200.0, 100.0, 200.0, 100.0],
    "patcher": {
      "fileversion": 1,
      "appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
      "rect": [0.0, 0.0, 200.0, 100.0],
      "boxes": [],
      "lines": []
    }
  }
}
```
Source: Verified against estine/maxmsp_patches bpatcher_example.maxpat and rec/swirly bad-bpatcher.maxpat

### Pattern 6: Presentation Mode

**What:** How presentation mode layout is added to boxes and patcher.
**When to use:** When UI objects exist and need a clean control layout.

Patcher-level: set `"openinpresentation": 1` to open in presentation mode by default.

Per-box: add `"presentation": 1` and `"presentation_rect": [x, y, w, h]`:
```json
{
  "box": {
    "maxclass": "slider",
    "id": "obj-5",
    "numinlets": 1,
    "numoutlets": 1,
    "outlettype": [""],
    "patching_rect": [200.0, 50.0, 20.0, 140.0],
    "presentation": 1,
    "presentation_rect": [20.0, 20.0, 20.0, 140.0]
  }
}
```
Source: Cycling74 documentation on Presentation Mode, verified against .maxpat examples

### Pattern 7: Maxclass Resolution

**What:** Mapping between object names and .maxpat maxclass values.
**When to use:** Every object added to a patch must resolve its maxclass.

The critical distinction in .maxpat files:
- **UI objects** use their own name as `maxclass` (e.g., `"maxclass": "toggle"`)
- **Non-UI objects** use `"maxclass": "newobj"` with the object name in `"text"` (e.g., `"text": "cycle~ 440"`)

Known UI maxclass names (use their own name, NOT "newobj"):
```
comment, message, number, flonum, toggle, button, slider, dial, rslider,
multislider, kslider, nslider, panel, led, radiogroup, textbutton, tab,
pictctrl, pictslider, incdec, swatch, colorpicker, chooser, listbox,
umenu, textedit, attrui, preset, matrixctrl, nodes, jsui, fpic, lcd,
hint, dropfile, ubutton, playbar,
inlet, outlet, patcher, bpatcher,
meter~, levelmeter~, spectroscope~, scope~, number~, gain~, ezdac~, ezadc~,
live.dial, live.slider, live.numbox, live.toggle, live.button, live.text,
live.menu, live.tab, live.meter~, live.gain~
```

Everything else (cycle~, trigger, pack, route, send~, receive~, etc.) uses `maxclass: "newobj"`.

Source: Verified against MAX SDK scripting docs (sdk.cdn.cycling74.com), py2max Box class, and multiple .maxpat file examples

### Anti-Patterns to Avoid
- **Setting maxclass to object name for non-UI objects:** cycle~ is NOT `"maxclass": "cycle~"` -- it must be `"maxclass": "newobj", "text": "cycle~ 440"`. Getting this wrong produces files MAX cannot open.
- **Omitting numinlets/numoutlets:** MAX uses these fields to determine patch cord attachment points. Omitting them produces broken UI even if connections work.
- **Hardcoding inlet/outlet counts:** Always compute from the object database. Variable I/O objects (trigger, pack, route, select, gate, etc.) change counts based on arguments.
- **Connecting without validating signal types:** Signal outlets to control inlets causes silent audio glitches. Always check the `signal` boolean on inlet/outlet entries.
- **Using sequential integer IDs:** MAX uses "obj-N" format strings. Must be unique within a patcher scope (including subpatchers having their own ID namespace).

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Object existence check | Custom name list | Object database (.claude/max-objects/) | 2,012 objects with full metadata already exist |
| Alias resolution | Hardcoded alias map | aliases.json | Already maintained, covers t->trigger, b->bangbang, etc. |
| Variable I/O computation | Per-object if/else chains | overrides.json variable_io_rules | 12 rules covering all variable I/O objects with formulas |
| PD confusion guard | Training data filtering | pd-blocklist.json | 18 PD objects with MAX equivalents already catalogued |
| Topological sort | networkx or igraph dependency | Kahn's algorithm (~30 lines stdlib) | No external dependency needed for DAG sort |
| JSON serialization | Custom string building | json.dumps with indent=2 | stdlib json module handles all .maxpat formatting correctly |

**Key insight:** The Phase 1 object database is the single source of truth. Every piece of metadata needed for generation and validation already exists in the JSON files. No new data extraction or external library is needed.

## Common Pitfalls

### Pitfall 1: Maxclass Confusion
**What goes wrong:** Using the database `maxclass` field directly in .maxpat output. The database stores the MAX object class name (e.g., `cycle~`), but .maxpat files use `"newobj"` as the maxclass for most objects with the name in the `text` field.
**Why it happens:** The database schema uses `maxclass` to mean "MAX class identity" while .maxpat format uses `maxclass` to mean "JSON box type."
**How to avoid:** Build a maxclass resolver that maps: UI objects keep their name as maxclass; everything else becomes `"newobj"` with `text` set to the object name + arguments.
**Warning signs:** Patches that show empty boxes or fail to display object names in MAX.

### Pitfall 2: Outlet Type Arrays
**What goes wrong:** Omitting or incorrectly specifying the `outlettype` array on boxes.
**Why it happens:** This field isn't in the object database -- it must be derived from outlet signal types.
**How to avoid:** Map from database outlet `signal: true` to `"signal"`, `signal: false` to `""` (empty string for control outlets). The `outlettype` array must have exactly as many entries as `numoutlets`.
**Warning signs:** Patch cords showing wrong colors (yellow for signal, grey for control) or MAX warnings about outlet types.

### Pitfall 3: Variable I/O Count Mismatch
**What goes wrong:** Using default inlet/outlet counts from the database for objects like `trigger b i f s` (should have 4 outlets, not the default 2).
**Why it happens:** Database stores default counts; actual counts depend on arguments.
**How to avoid:** Check `variable_io: true` on every object, then apply the formula from `overrides.json variable_io_rules` to compute actual counts from the provided arguments.
**Warning signs:** Connection validation passes (indices look valid against defaults) but MAX shows broken patch cords.

### Pitfall 4: Subpatcher Inlet/Outlet Count
**What goes wrong:** Setting numinlets/numoutlets on the subpatcher box without matching the inlet/outlet objects inside the subpatcher.
**Why it happens:** The outer box inlet/outlet count must match the number of `inlet` and `outlet` objects placed inside the subpatcher.
**How to avoid:** Count the inlet/outlet objects placed inside the subpatcher and set the parent box's numinlets/numoutlets to match.
**Warning signs:** Missing patch cord connection points on the subpatcher box in MAX.

### Pitfall 5: Signal Feedback Loops
**What goes wrong:** Creating circular signal connections without proper delay (causes MAX audio engine crash or infinite values).
**Why it happens:** In control domain, feedback is common and safe. In signal domain, it creates undefined behavior without single-sample delay.
**How to avoid:** During validation, detect cycles in the signal graph. If a cycle exists, verify it contains either tapin~/tapout~ or a gen~ object with History.
**Warning signs:** MAX console errors about feedback, audio clicks/pops, or complete audio silence.

### Pitfall 6: Hot/Cold Inlet Ordering in Generated Connections
**What goes wrong:** Generating connections that send values to the hot inlet before cold inlets are populated, causing computation with stale values.
**Why it happens:** Connection order in the `lines` array affects execution order in MAX. If a trigger/fan-out sends to inlet 0 before inlet 1, the object computes before the right operand is set.
**How to avoid:** When generating connections from a fan-out (trigger object or multiple connections from one outlet), order them in the `lines` array right-to-left (cold inlets first, hot inlet last). The `order` field on patchlines can also control this.
**Warning signs:** Objects computing with default/zero values instead of intended inputs.

### Pitfall 7: Presentation Rect vs Patching Rect
**What goes wrong:** Setting `presentation_rect` but forgetting `"presentation": 1` on the box, or vice versa.
**Why it happens:** Both properties must be set for an object to appear in presentation mode.
**How to avoid:** Always set both together. If a box has `presentation_rect`, it must also have `"presentation": 1`.
**Warning signs:** Objects visible in patching mode but invisible in presentation mode.

## Code Examples

### Example 1: Content-Aware Box Sizing
```python
# Source: Derived from MAX behavior -- box width scales with text content
# Font: Arial 12pt (MAX default)
# Approximate character width: 7px per character for Arial 12pt

MIN_BOX_WIDTH = 40.0   # Minimum for very short objects
DEFAULT_HEIGHT = 22.0   # Standard text box height
CHAR_WIDTH = 7.0        # Approximate pixels per character at 12pt Arial
PADDING = 16.0          # Left + right padding inside the box

def calculate_box_width(text: str) -> float:
    """Calculate box width from its text content, matching MAX auto-sizing."""
    width = len(text) * CHAR_WIDTH + PADDING
    return max(width, MIN_BOX_WIDTH)

# UI object sizes (fixed dimensions in MAX)
UI_SIZES = {
    "toggle":   (24.0, 24.0),
    "button":   (24.0, 24.0),
    "slider":   (20.0, 140.0),   # Vertical slider default
    "dial":     (40.0, 40.0),
    "number":   (50.0, 22.0),
    "flonum":   (50.0, 22.0),
    "led":      (24.0, 24.0),
    "meter~":   (15.0, 100.0),
    "gain~":    (22.0, 140.0),
    "ezdac~":   (45.0, 45.0),
    "ezadc~":   (45.0, 45.0),
    "spectroscope~": (300.0, 100.0),
    "scope~":   (130.0, 130.0),
    "multislider": (200.0, 100.0),
    "kslider":  (336.0, 53.0),
    "panel":    (128.0, 128.0),
    "comment":  None,  # Text-based sizing like newobj
    "message":  None,  # Text-based sizing like newobj
    "inlet":    (30.0, 30.0),
    "outlet":   (30.0, 30.0),
}
```

### Example 2: Column-Based Layout with Topological Sort
```python
# Source: py2max FlowLayoutManager pattern + Kahn's algorithm
from collections import deque, defaultdict

def topological_sort_columns(boxes: list, connections: list) -> list[list]:
    """Assign boxes to columns using topological sort (Kahn's algorithm).

    Returns list of columns, where each column is a list of box IDs
    ordered top-to-bottom.
    """
    # Build adjacency and in-degree
    in_degree = defaultdict(int)
    adj = defaultdict(list)
    all_ids = {box["id"] for box in boxes}

    for conn in connections:
        src = conn["source"][0]
        dst = conn["destination"][0]
        if src in all_ids and dst in all_ids:
            adj[src].append(dst)
            in_degree[dst] += 1

    # Initialize with source nodes (in-degree 0)
    queue = deque()
    for box in boxes:
        bid = box["id"]
        if in_degree[bid] == 0:
            queue.append(bid)

    columns = []
    visited = set()

    while queue:
        # Current level = one column
        column = []
        next_queue = deque()

        while queue:
            node = queue.popleft()
            if node not in visited:
                visited.add(node)
                column.append(node)

                for neighbor in adj[node]:
                    in_degree[neighbor] -= 1
                    if in_degree[neighbor] == 0:
                        next_queue.append(neighbor)

        if column:
            columns.append(column)
        queue = next_queue

    # Handle disconnected nodes (no connections)
    disconnected = [box["id"] for box in boxes if box["id"] not in visited]
    if disconnected:
        columns.append(disconnected)

    return columns
```

### Example 3: Validation Pipeline
```python
# Source: Architectural pattern from validate_db.py (Phase 1)

class ValidationResult:
    def __init__(self, layer: str, level: str, message: str, auto_fixed: bool = False):
        self.layer = layer       # "json", "objects", "connections", "domain"
        self.level = level       # "error", "warning", "info", "fixed"
        self.message = message
        self.auto_fixed = auto_fixed

def validate_patch(patch_data: dict, db) -> list[ValidationResult]:
    """Run all validation layers. Returns list of results."""
    results = []

    # Layer 1: JSON structure validity
    results.extend(validate_json_structure(patch_data))
    if any(r.level == "error" for r in results):
        return results  # Stop early -- structure is broken

    # Layer 2: Object existence against database
    results.extend(validate_objects_exist(patch_data, db))

    # Layer 3: Connection bounds and type checks
    results.extend(validate_connections(patch_data, db))

    # Layer 4: Domain-specific rules
    results.extend(validate_domain_rules(patch_data, db))

    return results

def has_blocking_errors(results: list[ValidationResult]) -> bool:
    """Only unfixable errors block output."""
    return any(r.level == "error" and not r.auto_fixed for r in results)
```

### Example 4: Object Database Lookup
```python
# Source: Phase 1 conftest.py pattern, adapted for generation

import json
from pathlib import Path

DB_ROOT = Path(".claude/max-objects")
DOMAIN_DIRS = ["max", "msp", "jitter", "mc", "gen", "m4l", "rnbo", "packages"]
# Load core domains last so they take priority over RNBO duplicates
DOMAIN_LOAD_ORDER = ["rnbo", "packages", "m4l", "gen", "mc", "jitter", "msp", "max"]

class ObjectDatabase:
    def __init__(self, db_root: Path = DB_ROOT):
        self._objects = {}
        self._aliases = {}
        self._variable_io_rules = {}
        self._pd_blocklist = {}
        self._load(db_root)

    def _load(self, db_root: Path):
        # Load aliases
        aliases_path = db_root / "aliases.json"
        if aliases_path.exists():
            self._aliases = json.loads(aliases_path.read_text()).get("aliases", {})

        # Load variable I/O rules
        overrides_path = db_root / "overrides.json"
        if overrides_path.exists():
            data = json.loads(overrides_path.read_text())
            self._variable_io_rules = data.get("variable_io_rules", {})

        # Load PD blocklist
        pd_path = db_root / "pd-blocklist.json"
        if pd_path.exists():
            self._pd_blocklist = json.loads(pd_path.read_text()).get("blocklist", {})

        # Load objects (core domains last for priority)
        for domain_dir in DOMAIN_LOAD_ORDER:
            json_path = db_root / domain_dir / "objects.json"
            if json_path.exists():
                data = json.loads(json_path.read_text())
                for name, obj in data.items():
                    self._objects[name] = obj

    def lookup(self, name: str) -> dict | None:
        """Look up object by name, resolving aliases."""
        canonical = self._aliases.get(name, name)
        return self._objects.get(canonical)

    def exists(self, name: str) -> bool:
        canonical = self._aliases.get(name, name)
        return canonical in self._objects

    def is_pd_object(self, name: str) -> bool:
        return name in self._pd_blocklist

    def compute_io_counts(self, name: str, args: list) -> tuple[int, int]:
        """Compute actual inlet/outlet counts for variable_io objects."""
        obj = self.lookup(name)
        if not obj or not obj.get("variable_io"):
            inlets = len(obj["inlets"]) if obj else 0
            outlets = len(obj["outlets"]) if obj else 0
            return inlets, outlets

        rule = self._variable_io_rules.get(name, {})
        # Apply formula from rule
        inlets = self._apply_io_rule(rule.get("inlet_count", ""), args,
                                      rule.get("default_inlets", len(obj["inlets"])))
        outlets = self._apply_io_rule(rule.get("outlet_count", ""), args,
                                       rule.get("default_outlets", len(obj["outlets"])))
        return inlets, outlets
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Binary .maxb format | JSON .maxpat format | MAX 5 (2008) | Enables programmatic generation |
| Manual patch scripting | py2max / MaxPyLang libraries | 2022-2024 | Reference implementations exist |
| MAX 8 appversion | MAX 9 appversion | 2024 | Generated patches should target MAX 9 defaults |
| No presentation mode | Dual-mode layout (patching + presentation) | MAX 5 | UI objects need both rect types |

**Deprecated/outdated:**
- Binary .maxb format: replaced by JSON .maxpat in MAX 5
- MAX 8 appversion values (major: 8, minor: 5, revision: 5): update to MAX 9 values for current patches
- py2max LayoutManager (basic horizontal): replaced by FlowLayoutManager and MatrixLayoutManager

## Open Questions

1. **Exact MAX 9 appversion values**
   - What we know: MAX 8 uses `{"major": 8, "minor": 5, "revision": 5}`. MAX 9 uses `{"major": 9, ...}`.
   - What's unclear: The exact minor and revision values for the latest MAX 9 release.
   - Recommendation: Use `{"major": 9, "minor": 0, "revision": 0}` as a safe default. MAX is forward-compatible with older fileversion values. Can be updated when a user opens a patch in MAX 9 and checks.

2. **Exact outlettype string values**
   - What we know: `"signal"` for MSP outlets, `""` (empty string) for generic control outlets, `"multichannelsignal"` for MC outlets.
   - What's unclear: Whether specific control types (int, float, bang, list, symbol) are used or if `""` covers all.
   - Recommendation: Use `"signal"` for `signal: true` outlets, `""` for `signal: false` outlets. This matches all observed .maxpat files. MC outlets use `"multichannelsignal"`.

3. **Editing bgcolor for MAX 9**
   - What we know: MAX 9 introduced new default colors for the patcher background.
   - What's unclear: Exact RGBA values for the MAX 9 default editing/lock background colors.
   - Recommendation: Omit `editing_bgcolor` and `lock_bgcolor` initially -- MAX uses its own defaults when these fields are absent. Add them later if needed for visual consistency.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 7.x+ |
| Config file | none -- uses default discovery (tests/ directory) |
| Quick run command | `python3 -m pytest tests/ -x --tb=short -q` |
| Full suite command | `python3 -m pytest tests/ -v --tb=long` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| PAT-01 | Generated .maxpat is valid JSON that matches expected structure | unit | `python3 -m pytest tests/test_patcher.py -x` | Wave 0 |
| PAT-02 | Patcher wrapper contains boxes array and lines array | unit | `python3 -m pytest tests/test_patcher.py::test_patcher_structure -x` | Wave 0 |
| PAT-03 | Subpatcher and bpatcher nesting generates correctly | unit | `python3 -m pytest tests/test_patcher.py::test_subpatcher -x` | Wave 0 |
| PAT-04 | Connection validation catches out-of-bounds indices | unit | `python3 -m pytest tests/test_validation.py::test_connection_bounds -x` | Wave 0 |
| PAT-05 | Signal/control type mismatch detected | unit | `python3 -m pytest tests/test_validation.py::test_signal_type -x` | Wave 0 |
| PAT-06 | Layout produces top-to-bottom signal flow | unit | `python3 -m pytest tests/test_layout.py::test_top_to_bottom -x` | Wave 0 |
| PAT-07 | Spacing is within 80-120px vertical, 150-200px horizontal | unit | `python3 -m pytest tests/test_layout.py::test_spacing -x` | Wave 0 |
| PAT-08 | All four validation layers run and report | integration | `python3 -m pytest tests/test_validation.py -x` | Wave 0 |
| FRM-05 | File write triggers validation automatically | unit | `python3 -m pytest tests/test_hooks.py -x` | Wave 0 |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/ -x --tb=short -q`
- **Per wave merge:** `python3 -m pytest tests/ -v --tb=long`
- **Phase gate:** Full suite green before `/gsd:verify-work`

### Wave 0 Gaps
- [ ] `tests/test_patcher.py` -- covers PAT-01, PAT-02, PAT-03 (patcher structure, boxes, lines, subpatchers, bpatchers)
- [ ] `tests/test_validation.py` -- covers PAT-04, PAT-05, PAT-08 (connection bounds, signal types, multi-layer pipeline)
- [ ] `tests/test_layout.py` -- covers PAT-06, PAT-07 (topological sort, column layout, spacing)
- [ ] `tests/test_hooks.py` -- covers FRM-05 (file write hook triggers validation)
- [ ] `tests/test_sizing.py` -- covers content-aware box sizing
- [ ] `tests/test_generation.py` -- end-to-end generation of simple and complex patches
- [ ] `tests/fixtures/expected/` -- known-good .maxpat files for comparison
- [ ] `src/maxpat/` -- entire generation library (new module)

## Sources

### Primary (HIGH confidence)
- py2max Patcher class (github.com/shakfu/py2max) -- complete field definitions for .maxpat structure, layout algorithms, Box/Patchline classes
- Cycling74 Max SDK scripting docs (sdk.cdn.cycling74.com/max-sdk-8.0.3/chapter_scripting.html) -- maxclass resolution, connection format, UI vs newobj distinction
- Cycling74 gen-workshop .maxpat examples (github.com/Cycling74/gen-workshop) -- real .maxpat files with subpatchers, gen~ embedding
- Project object database (.claude/max-objects/) -- 2,012 objects with inlet/outlet metadata, signal types, variable I/O rules, aliases, relationships, PD blocklist

### Secondary (MEDIUM confidence)
- estine/maxmsp_patches bpatcher_example.maxpat -- bpatcher JSON structure
- rec/swirly bad-bpatcher.maxpat -- bpatcher with embedded patcher
- Cycling74 Presentation Mode documentation -- presentation/presentation_rect field usage
- py2max FlowLayoutManager -- topological sort + barycenter crossing minimization algorithm

### Tertiary (LOW confidence)
- MAX 9 exact appversion values -- not verified; using {"major": 9, "minor": 0, "revision": 0} as conservative default
- Exact editing_bgcolor/lock_bgcolor values for MAX 9 -- omitting these fields; MAX uses own defaults
- Complete list of UI maxclass names -- verified core set of ~50 objects, but edge cases may exist

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- Python stdlib + json, no dependencies, matches Phase 1 patterns
- Architecture: HIGH -- .maxpat JSON structure verified against multiple sources; layout algorithm well-understood
- Pitfalls: HIGH -- maxclass confusion, variable I/O, and signal type issues verified against real .maxpat files and SDK docs
- Validation: HIGH -- multi-layer pipeline architecture modeled on Phase 1 validate_db.py

**Research date:** 2026-03-09
**Valid until:** 2026-06-09 (stable domain -- .maxpat format changes rarely)
