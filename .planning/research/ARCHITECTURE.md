# Architecture Patterns: v1.1 Patch Quality & Aesthetics

**Domain:** Integration architecture for help patch auditing, DB corrections, aesthetics, and refined positioning
**Researched:** 2026-03-13
**Confidence:** HIGH (based on direct analysis of existing codebase, help patch format, and .maxpat structure)

## Current Architecture Summary

The existing system follows a clean pipeline:

```
Patcher (build) -> apply_layout() -> to_dict() -> validate_patch() -> write_patch()
```

Key components and their files:

| Component | File(s) | Responsibility |
|-----------|---------|----------------|
| Data Model | `src/maxpat/patcher.py` | `Patcher`, `Box`, `Patchline` classes |
| Layout Engine | `src/maxpat/layout.py` | Row-based topological positioning, midpoints |
| Object Database | `src/maxpat/db_lookup.py` | `ObjectDatabase` loads JSON, resolves aliases, computes I/O |
| Validation | `src/maxpat/validation.py` | 4-layer pipeline (JSON, objects, connections, domain) |
| Critics | `src/maxpat/critics/` | Semantic review (DSP, structure, RNBO, external) |
| Sizing | `src/maxpat/sizing.py` | Content-aware box dimensions, UI_SIZES map |
| Defaults | `src/maxpat/defaults.py` | Font, spacing, patcher prop constants |
| Maxclass Map | `src/maxpat/maxclass_map.py` | UI vs newobj resolution |
| Hooks | `src/maxpat/hooks.py` | write_patch, write_gendsp, write_js file output |
| Codegen | `src/maxpat/codegen.py` | GenExpr/N4M/js script generation |
| Public API | `src/maxpat/__init__.py` | Re-exports generate_patch, all public types |
| Object DB Files | `.claude/max-objects/{domain}/objects.json` | Per-domain object definitions |
| Overrides | `.claude/max-objects/overrides.json` | Expert corrections merged on top |
| Agent Skills | `.claude/skills/max-{name}-agent/SKILL.md` | Agent instructions and boundaries |

## v1.1 Feature Integration Map

Four new capabilities must integrate with this architecture:

1. **Help Patch Audit Pipeline** -- Extract ground truth from ~972 `.maxhelp` files, compare against DB, produce corrections
2. **Object DB Corrections** -- Flow audit results into `overrides.json` (and potentially base domain files)
3. **Patch Aesthetics** -- Add panel backgrounds, comment styling, bgcolor support to generated patches
4. **Refined Object Positioning** -- Improve layout.py spacing, alignment, and grouping

### Data Flow Overview

```
Help Patches (.maxhelp)                           Existing Components
        |                                                  |
        v                                                  |
+------------------+                                       |
| help_audit.py    |  NEW: parse, extract, compare         |
+------------------+                                       |
        |                                                  |
        v                                                  |
+------------------+     +-------------------+             |
| audit_report.json|---->| overrides.json    |  MODIFIED   |
+------------------+     | (expanded)        |             |
                         +-------------------+             |
                                |                          |
                                v                          |
                         +-------------------+             |
                         | db_lookup.py      |  UNCHANGED  |
                         | (loads overrides) |             |
                         +-------------------+             |
                                |                          |
                                v                          |
+------------------+     +-------------------+             |
| aesthetics.py    |---->| patcher.py        |  MODIFIED   |
| NEW              |     | (Box.extra_attrs  |  (minor)    |
+------------------+     |  + Patcher.props) |             |
                         +-------------------+             |
                                |                          |
                                v                          |
                         +-------------------+             |
                         | layout.py         |  MODIFIED   |
                         | (spacing, panels) |             |
                         +-------------------+             |
                                |                          |
                                v                          |
                         +-------------------+             |
                         | validation.py     |  MODIFIED   |
                         | (aesthetic checks)|  (minor)    |
                         +-------------------+             |
```

---

## Component 1: Help Patch Audit Pipeline

### New File: `src/maxpat/help_audit.py`

**Purpose:** Parse `.maxhelp` files from the MAX installation, extract ground truth object metadata (outlet types, inlet counts, argument patterns, connection patterns), compare against the object database, and produce a structured audit report.

**Why a new file:** This is a standalone offline tool, not part of the generation pipeline. It reads external `.maxhelp` files and produces reports. It has no business being embedded in existing modules.

### Architecture

```python
# src/maxpat/help_audit.py

class HelpPatchAuditor:
    """Parse MAX help patches and compare against ObjectDatabase."""

    def __init__(self, help_root: Path, db: ObjectDatabase):
        self.help_root = help_root
        self.db = db

    def discover_help_patches(self) -> dict[str, Path]:
        """Map object names to their .maxhelp file paths."""
        # Scan help_root/{max,msp,jitter,m4l}/*.maxhelp
        # Return {object_name: path}

    def extract_object_truth(self, help_path: Path) -> ObjectTruth:
        """Extract ground truth from a single help patch."""
        # Parse JSON, find all instances of the target object
        # Extract: outlettype, numinlets, numoutlets
        # Extract: connection patterns (what outlets connect to what)
        # Extract: argument examples from text fields
        # Return structured ObjectTruth

    def compare_with_db(self, name: str, truth: ObjectTruth) -> list[Discrepancy]:
        """Compare extracted truth against database entry."""
        # Check outlet types match
        # Check inlet/outlet counts match
        # Check signal flags match
        # Return list of Discrepancy objects

    def audit_domain(self, domain: str) -> AuditReport:
        """Audit all objects in a domain."""

    def audit_all(self) -> AuditReport:
        """Audit all domains."""

    def generate_overrides(self, report: AuditReport) -> dict:
        """Convert discrepancies into overrides.json format."""


@dataclass
class ObjectTruth:
    """Ground truth extracted from a help patch."""
    name: str
    instances: list[ObjectInstance]
    connections: list[ConnectionPattern]

@dataclass
class ObjectInstance:
    """A single instance of an object found in a help patch."""
    text: str               # Full text (e.g., "line~ 0.5")
    numinlets: int
    numoutlets: int
    outlettype: list[str]   # e.g., ["signal", "bang"]
    depth: int              # Nesting depth in subpatchers

@dataclass
class Discrepancy:
    """A mismatch between help patch truth and DB entry."""
    object_name: str
    field: str              # "outlettype", "numinlets", etc.
    db_value: Any
    help_value: Any
    confidence: str         # "HIGH", "MEDIUM", "LOW"
    source_file: str

@dataclass
class AuditReport:
    """Complete audit results for a domain or all domains."""
    total_objects: int
    audited: int
    discrepancies: list[Discrepancy]
    missing_help: list[str]  # Objects with no help patch
    timestamp: str
```

### Key Design Decisions

**Extract outlet types from help patches, not arguments.** Help patches contain `outlettype` arrays on every object instance. These are MAX's own declaration of what type each outlet produces. This is the single most valuable data point -- our current DB has widespread outlet type errors (as documented in `feedback_msp_outlet_types.md`).

**Use the most common instance as ground truth.** A help patch may contain multiple instances of the same object with different arguments (and therefore different outlet counts for variable_io objects). The auditor should:
1. Group instances by argument pattern
2. For the default (no-argument) case, use the instance matching that pattern
3. For variable_io objects, verify the formula against multiple instances

**Store audit results as JSON.** The audit report goes to `.claude/max-objects/audit-report.json` -- a structured file that can be:
- Inspected by humans
- Diff'd across audit runs
- Fed to the override generator

**Generate overrides, not replace base files.** The audit pipeline produces entries for `overrides.json`, not direct modifications to domain files. Reasons:
1. `overrides.json` is the established correction mechanism
2. Base domain files were extracted from multiple sources; wholesale replacement risks losing data
3. Overrides are clearly marked as corrections and can be reviewed

### Help Patch Discovery Strategy

```
/Applications/Max.app/Contents/Resources/C74/help/
    max/    -> .claude/max-objects/max/objects.json
    msp/    -> .claude/max-objects/msp/objects.json
    jitter/ -> .claude/max-objects/jitter/objects.json
    m4l/    -> .claude/max-objects/m4l/objects.json
```

The auditor needs a configurable MAX installation path. Default: `/Applications/Max.app`. The path should be discoverable (check common locations) or configurable via environment variable / argument.

### What To Extract Per Object

From parsing help patch `.maxhelp` JSON files:

| Field | Source | Use |
|-------|--------|-----|
| `outlettype` | `box.outlettype` array on object instances | Fix mixed signal/control outlet types |
| `numinlets` | `box.numinlets` on object instances | Verify inlet counts |
| `numoutlets` | `box.numoutlets` on object instances | Verify outlet counts |
| Arguments | `box.text` field (everything after object name) | Verify argument patterns, variable_io rules |
| Connections from outlets | `patchline.source` where source is our object | Verify outlet behavior (signal outlets connect to signal inlets) |
| Connections to inlets | `patchline.destination` where dest is our object | Verify inlet types and hot/cold behavior |

---

## Component 2: Object DB Corrections

### Modified File: `.claude/max-objects/overrides.json`

**Current structure:**
```json
{
  "objects": { ... },          // Per-object overrides
  "version_map": { ... },      // Version compatibility
  "variable_io_rules": { ... } // I/O computation formulas
}
```

**Expanded structure (additive, no breaking changes):**
```json
{
  "objects": {
    "line~": {
      "outlets": [...],
      "_note": "...",
      "_audit": {
        "source": "help_patch",
        "audited": "2026-03-13",
        "confidence": "HIGH"
      }
    }
  },
  "version_map": { ... },
  "variable_io_rules": { ... },
  "_audit_metadata": {
    "last_run": "2026-03-13",
    "max_version": "9.0",
    "help_patch_root": "/Applications/Max.app/...",
    "total_audited": 972,
    "total_discrepancies": 147,
    "domains_audited": ["max", "msp", "jitter", "m4l"]
  }
}
```

### Modified File: `src/maxpat/db_lookup.py`

**No code changes required.** The existing `_load()` method already deep-merges `overrides.json` onto loaded objects. As long as the audit pipeline produces overrides in the existing format, `db_lookup.py` picks them up automatically.

The only potential change: if we add a bulk-override mechanism that writes to domain files directly (for wholesale corrections of many objects), we would need a `reload()` method. Recommendation: defer this -- use overrides.json for now.

### New File: `.claude/max-objects/audit-report.json`

**Purpose:** Machine-readable audit results. Not loaded by the runtime -- purely for inspection and tracking.

```json
{
  "timestamp": "2026-03-13T14:30:00Z",
  "summary": {
    "total_objects_in_db": 2015,
    "help_patches_found": 972,
    "objects_audited": 945,
    "discrepancies_found": 147,
    "overrides_generated": 89,
    "unresolved": 58
  },
  "discrepancies": [
    {
      "object": "line~",
      "domain": "msp",
      "field": "outlets[1].signal",
      "db_value": true,
      "help_value": false,
      "resolution": "override_generated",
      "confidence": "HIGH"
    }
  ]
}
```

---

## Component 3: Patch Aesthetics

### New File: `src/maxpat/aesthetics.py`

**Purpose:** Apply visual styling to generated patches -- panel backgrounds, comment formatting, bgcolor, section grouping. This is a post-construction, pre-layout pass that adds visual elements.

**Why a new file:** Aesthetics are orthogonal to layout. Layout computes positions; aesthetics add visual elements (panels, styled comments) and set visual properties (colors, fonts). Mixing them into layout.py would violate single responsibility.

### Architecture

```python
# src/maxpat/aesthetics.py

class PatchStyle:
    """Defines visual styling for a patch section."""
    bgcolor: list[float]          # [r, g, b, a] 0.0-1.0
    panel_color: list[float]      # Panel background
    comment_fontsize: float       # Section label font size
    comment_fontface: int         # 0=regular, 1=bold
    comment_textcolor: list[float]

# Predefined styles
STYLE_DEFAULT = PatchStyle(...)
STYLE_MSP = PatchStyle(...)       # Subtle blue tint for audio sections
STYLE_CONTROL = PatchStyle(...)   # Neutral for control flow
STYLE_INIT = PatchStyle(...)      # Subtle for initialization sections


def add_section_panel(
    patcher: Patcher,
    boxes: list[Box],
    label: str | None = None,
    style: PatchStyle = STYLE_DEFAULT,
    padding: float = 10.0,
) -> Box:
    """Add a panel background behind a group of boxes.

    Creates a panel object sized to encompass all given boxes plus padding.
    Adds a comment label above the panel if label is provided.
    Panel is added to the patcher's box list at index 0 (renders behind).

    Must be called AFTER layout (boxes need positions).
    """

def add_section_label(
    patcher: Patcher,
    text: str,
    x: float,
    y: float,
    style: PatchStyle = STYLE_DEFAULT,
) -> Box:
    """Add a styled comment label at a specific position."""

def apply_patcher_bgcolor(
    patcher: Patcher,
    color: list[float],
) -> None:
    """Set the patcher-level background color."""
    # Sets patcher.props["bgcolor"] = color
    # Also sets patcher.props["editing_bgcolor"] for edit mode

def style_comment(
    box: Box,
    fontsize: float = 13.0,
    fontface: int = 0,
    textcolor: list[float] | None = None,
) -> None:
    """Apply styling to a comment box."""
    # Sets box.extra_attrs for fontsize, fontface, textcolor
```

### Integration with Existing Model

**Box.extra_attrs is the integration point.** The `Box` class already has `extra_attrs: dict[str, Any]` which gets merged into the serialized box dict via `d.update(self.extra_attrs)` in `Box.to_dict()`. This is exactly where aesthetic properties go:

```python
# Setting bgcolor on a panel
panel_box.extra_attrs["bgcolor"] = [0.9, 0.9, 0.95, 1.0]

# Setting comment styling
comment_box.extra_attrs["fontsize"] = 14.0
comment_box.extra_attrs["fontface"] = 1  # bold
comment_box.extra_attrs["textcolor"] = [0.2, 0.2, 0.2, 1.0]
```

**Patcher.props is the other integration point.** Patcher-level bgcolor goes into `patcher.props["bgcolor"]`, `patcher.props["editing_bgcolor"]`, and `patcher.props["locked_bgcolor"]`. The current `DEFAULT_PATCHER_PROPS` in defaults.py does not include these (they are optional in .maxpat format), but they can be added at runtime.

### Modifications to Existing Files

**`src/maxpat/patcher.py` -- Minor addition:**
- Add `add_panel()` convenience method on Patcher (creates a panel Box with proper sizing)
- Panel boxes use maxclass "panel" which is already in UI_MAXCLASSES and UI_SIZES

**`src/maxpat/sizing.py` -- No changes needed:**
- Panel already has a default size in UI_SIZES: `(128.0, 128.0)`
- Panel sizes for section backgrounds will be computed dynamically by aesthetics.py and set via `patching_rect`

**`src/maxpat/defaults.py` -- Add color constants:**
```python
# Aesthetic color constants
PANEL_BGCOLOR_DEFAULT = [0.93, 0.93, 0.93, 1.0]   # Light gray
PANEL_BGCOLOR_MSP = [0.88, 0.90, 0.95, 1.0]       # Light blue tint
LABEL_FONTSIZE = 14.0
LABEL_FONTFACE_BOLD = 1
SECTION_PADDING = 10.0
```

### Panel Rendering Order

In .maxpat files, boxes render in array order -- first box draws first (behind everything else). Panels MUST be inserted at the beginning of the boxes array to render behind objects. The aesthetics module must handle this:

```python
# Insert panel at index 0 so it renders behind all objects
patcher.boxes.insert(0, panel_box)
```

This is important: if panels are appended (the default behavior of `add_box`), they render ON TOP of objects, obscuring them.

### When to Apply Aesthetics

Aesthetics must be applied AFTER layout (boxes need positions for panel sizing) but BEFORE serialization:

```
Patcher (build) -> apply_layout() -> apply_aesthetics() -> to_dict() -> validate_patch()
```

This means the generation pipeline in `src/maxpat/__init__.py` needs modification:

```python
def generate_patch(patcher, aesthetics=True):
    apply_layout(patcher)
    if aesthetics:
        from src.maxpat.aesthetics import apply_default_aesthetics
        apply_default_aesthetics(patcher)
    patch_dict = patcher.to_dict()
    results = validate_patch(patch_dict, db=patcher.db)
    ...
```

---

## Component 4: Refined Object Positioning

### Modified File: `src/maxpat/layout.py`

The layout engine is well-structured with clear separation of concerns (graph building, component detection, topological sort, positioning, UI controls, companions, midpoints, auto-sizing). Refinements integrate by modifying existing functions and adding new helper functions within the same file.

### Specific Refinements

**1. Inlet-aligned connections (reduce diagonal cables)**

Currently, child objects are centered under their parent's center-x. Improvement: when a child connects to a specific parent outlet, align the child's corresponding inlet with that outlet's x-position.

```python
# Current: center under parent center
ideal_x = parent_center_x - box_width * 0.5

# Improved: align inlet under parent outlet
outlet_x = _outlet_x(parent, source_outlet)
inlet_x = _inlet_x(child, dest_inlet)
ideal_x = outlet_x - (inlet_x - child_x)
```

**Where:** Modify `_position_component()` function. The `_parent_center_x()` helper becomes `_parent_alignment_x()` which considers the specific outlet/inlet indices from the patchlines.

**2. Comment placement near related objects**

Currently, comments are disconnected objects placed in the rightmost column. Improvement: if a comment is associated with a nearby object (by proximity in the construction order or by naming convention), place it above or beside that object.

**Where:** Add `_identify_associated_comments()` function. Associate comments with the next non-comment box added after them (a convention: comments precede the object they describe). Place associated comments above their target, similar to UI control placement.

**3. Panel-aware spacing**

After aesthetics adds panels, the layout should account for panel padding in spacing calculations. Panels expand the bounding box and may need gap adjustments.

**Where:** Modify `_auto_size_patcher_rect()` to account for panel padding. If `apply_aesthetics()` runs after layout, panels are sized to fit existing positions -- no retroactive layout change needed. The auto-sizing just needs to include panel bounds.

**4. Configurable spacing via layout options**

Currently, spacing constants are module-level in defaults.py. Some patches benefit from tighter or looser spacing. Add a `LayoutOptions` dataclass passed to `apply_layout()`.

```python
@dataclass
class LayoutOptions:
    v_spacing: float = V_SPACING
    h_gutter: float = H_GUTTER
    start_x: float = 30.0
    start_y: float = 30.0
    component_gap: float = 40.0
    companion_gap: float = 5.0

def apply_layout(patcher: Patcher, options: LayoutOptions | None = None) -> None:
    if options is None:
        options = LayoutOptions()
    ...
```

**Where:** `src/maxpat/layout.py` -- Add `LayoutOptions` dataclass, thread through existing functions. The defaults match current behavior (backward compatible).

**5. Grid snapping**

MAX patches typically use a 15x15 grid (visible in DEFAULT_PATCHER_PROPS: `"gridsize": [15.0, 15.0]`). Currently, positions are computed as floating point without grid alignment. Add optional grid snapping.

**Where:** Add `_snap_to_grid()` helper, call at the end of positioning.

### Modifications Summary

| Function | Change |
|----------|--------|
| `apply_layout()` | Accept optional `LayoutOptions` parameter |
| `_position_component()` | Use inlet/outlet alignment instead of center alignment |
| `_position_disconnected()` | Extract associated comments before positioning |
| `_auto_size_patcher_rect()` | Include panel bounds in size calculation |
| New: `LayoutOptions` | Configurable spacing dataclass |
| New: `_parent_alignment_x()` | Outlet-to-inlet alignment calculation |
| New: `_identify_associated_comments()` | Comment-to-object association |
| New: `_snap_to_grid()` | Optional 15px grid snapping |

---

## Component Dependency Graph

```
help_audit.py (standalone tool)
    |
    v
overrides.json (data file, expanded)
    |
    v
db_lookup.py (no code change, loads overrides as before)
    |
    v
patcher.py (minor: add_panel convenience)
    |
    v
layout.py (modified: LayoutOptions, alignment, comments, grid snap)
    |
    v
aesthetics.py (new: panel/comment/bgcolor styling)
    |
    v
__init__.py (modified: generate_patch pipeline includes aesthetics)
    |
    v
validation.py (minor: aesthetic-aware checks)
    |
    v
defaults.py (minor: add color/aesthetic constants)
```

---

## What is New vs Modified vs Unchanged

### New Files

| File | Purpose | Depends On |
|------|---------|------------|
| `src/maxpat/help_audit.py` | Help patch parsing, DB comparison, override generation | `db_lookup.py`, filesystem |
| `src/maxpat/aesthetics.py` | Panel creation, comment styling, bgcolor application | `patcher.py`, `defaults.py` |
| `.claude/max-objects/audit-report.json` | Audit results (generated, not code) | `help_audit.py` output |

### Modified Files

| File | What Changes | Risk |
|------|-------------|------|
| `.claude/max-objects/overrides.json` | Many new object entries from audit | LOW -- additive, existing entries unchanged |
| `src/maxpat/defaults.py` | Add color/aesthetic constants | LOW -- additive constants |
| `src/maxpat/layout.py` | LayoutOptions param, alignment logic, comment placement, grid snap | MEDIUM -- core layout changes need thorough testing |
| `src/maxpat/__init__.py` | Pipeline includes aesthetics step | LOW -- opt-in parameter |
| `src/maxpat/patcher.py` | Add `add_panel()` convenience | LOW -- new method, no existing changes |
| `src/maxpat/validation.py` | Aesthetic-aware checks (panel validation) | LOW -- additive layer 4 checks |
| `.claude/skills/max-patch-agent/SKILL.md` | Document aesthetic capabilities | LOW -- documentation |
| `.claude/skills/max-ui-agent/SKILL.md` | Document panel/bgcolor features | LOW -- documentation |
| `src/maxpat/sizing.py` | Possibly update panel dynamic sizing | LOW -- panel size is overridden by aesthetics |

### Unchanged Files

| File | Why Unchanged |
|------|--------------|
| `src/maxpat/db_lookup.py` | Already loads overrides via deep merge -- no changes needed |
| `src/maxpat/hooks.py` | write_patch calls generate_patch which handles the pipeline |
| `src/maxpat/maxclass_map.py` | Panel already in UI_MAXCLASSES |
| `src/maxpat/critics/` | Critic system operates on dict output, independent of aesthetics |
| `src/maxpat/codegen.py` | GenExpr generation unchanged |
| `src/maxpat/rnbo.py` | RNBO generation unchanged |
| `src/maxpat/externals.py` | External scaffolding unchanged |

---

## Suggested Build Order

Build order is driven by dependencies and testability.

### Phase 1: Help Patch Audit Pipeline

**Build:** `src/maxpat/help_audit.py` + tests
**Dependencies:** Only `db_lookup.py` (read-only)
**Output:** `audit-report.json` + proposed overrides

This is the foundation. Everything else depends on having correct data. The audit pipeline is a standalone tool with no impact on existing functionality -- zero risk to the generation pipeline.

**Test strategy:**
- Unit tests with fixture `.maxhelp` files (copy a few real help patches to `tests/fixtures/`)
- Compare extracted outlet types against known-correct overrides (line~, buffer~, etc.)
- Verify discrepancy detection for objects already corrected in overrides.json

### Phase 2: Object DB Corrections

**Build:** Run audit, review results, merge approved corrections into `overrides.json`
**Dependencies:** Phase 1 complete
**Output:** Expanded overrides.json, audit-report.json

This phase is primarily a data task, not a code task. The audit pipeline generates proposed overrides; a human reviews and approves them. The code change is updating the JSON file.

**Test strategy:**
- Verify db_lookup loads expanded overrides correctly
- Run existing 624 tests to ensure no regressions from new override entries
- Add specific tests for corrected objects (e.g., "line~ outlet 1 is control, not signal")

### Phase 3: Aesthetic Foundations

**Build:** `src/maxpat/aesthetics.py` + `defaults.py` color constants + `patcher.py` add_panel()
**Dependencies:** None on Phase 1/2 (can parallelize)
**Output:** Aesthetic styling functions, panel creation

**Test strategy:**
- Panel box serializes correctly (maxclass, bgcolor, patching_rect)
- Comment styling applies correct extra_attrs
- Patcher bgcolor sets correctly in props
- Panel renders behind objects (index 0 in boxes array)

### Phase 4: Layout Refinements

**Build:** LayoutOptions, inlet alignment, comment association, grid snap in `layout.py`
**Dependencies:** None on Phase 1/2/3 (can parallelize with Phase 3)
**Output:** Improved positioning

**Test strategy:**
- LayoutOptions defaults produce identical output to current behavior (backward compat)
- Inlet alignment reduces average horizontal cable distance
- Grid snapping produces positions on 15px boundaries
- Comment association places comments near their targets

### Phase 5: Pipeline Integration

**Build:** Update `generate_patch()` in `__init__.py`, update agent skills, add aesthetic validation
**Dependencies:** Phase 3 + Phase 4 complete
**Output:** End-to-end generation with aesthetics and refined layout

**Test strategy:**
- Full pipeline test: Patcher -> layout -> aesthetics -> serialize -> validate
- Generated patches open in MAX without errors
- Aesthetic opt-out (aesthetics=False) produces identical output to current behavior

### Phase 6: Agent Updates

**Build:** Update SKILL.md files for all relevant agents with corrected data patterns and aesthetic capabilities
**Dependencies:** Phase 2 (corrected data) + Phase 5 (pipeline ready)
**Output:** Updated agent documentation

This is the final phase because agents need to know about both the corrected object data AND the aesthetic capabilities.

---

## Parallelization Opportunities

```
Phase 1 (audit) -----> Phase 2 (corrections) -----> Phase 6 (agents)
                                                        ^
Phase 3 (aesthetics) --------+                          |
                              |-> Phase 5 (integration) +
Phase 4 (layout) ------------+
```

Phases 1, 3, and 4 can run in parallel -- they modify different files with no overlapping concerns. Phase 2 depends only on Phase 1. Phase 5 depends on 3+4. Phase 6 depends on 2+5.

---

## Patterns to Follow

### Pattern 1: Additive Data, Not Destructive Replacement

All DB corrections go through `overrides.json`, preserving original data in domain files. This maintains audit trail, allows rollback, and prevents loss of manually curated data.

### Pattern 2: Optional Pipeline Steps

Aesthetics are opt-in via parameter on `generate_patch()`. Existing code that calls `generate_patch()` without the parameter gets identical behavior. This prevents any regression risk.

### Pattern 3: Dataclass Configuration

Use `LayoutOptions` and `PatchStyle` dataclasses for configuration instead of more module-level constants. This makes the API explicit about what is configurable and provides good defaults.

### Pattern 4: Separation of Computation and Styling

Layout computes positions. Aesthetics add visual elements. They are separate passes in the pipeline. This means:
- Layout tests do not need to account for panels
- Aesthetic tests do not need to account for positioning
- Either can be improved independently

### Pattern 5: Fixture-Based Testing for Help Patches

Copy a representative set of `.maxhelp` files into `tests/fixtures/help_patches/` for deterministic testing. Do not make tests depend on the MAX installation being present -- that would break CI and other developers' machines.

---

## Anti-Patterns to Avoid

### Anti-Pattern 1: Modifying Base Domain Files Directly

**What:** Writing audit corrections directly into `max/objects.json`, `msp/objects.json`, etc.
**Why bad:** Destroys the audit trail. Makes it impossible to distinguish extracted data from corrections. Risk of overwriting manually curated fields.
**Instead:** Use `overrides.json` exclusively for corrections. If the override file grows too large (>500 entries), split into `overrides-audit.json` and load both in `db_lookup.py`.

### Anti-Pattern 2: Layout-Aware Aesthetics

**What:** Having aesthetics code compute positions or move objects.
**Why bad:** Creates coupling between layout and aesthetics. Layout changes break aesthetics and vice versa.
**Instead:** Aesthetics only reads positions (to size panels) and adds new elements. It never moves existing boxes.

### Anti-Pattern 3: Hardcoded MAX Installation Path

**What:** Baking `/Applications/Max.app/...` into the audit code.
**Why bad:** Breaks on different installations (Ableton bundled MAX, different versions, non-standard paths).
**Instead:** Accept path as parameter. Provide autodiscovery that checks common locations. Fall back to environment variable.

### Anti-Pattern 4: Blocking Pipeline on Aesthetic Warnings

**What:** Making aesthetic issues (missing panel, unstyled comments) into blocking errors in validation.
**Why bad:** Aesthetics are enhancement, not correctness. Blocking on aesthetics prevents functional patches from being generated.
**Instead:** Aesthetic issues are "info" level in validation, never "error".

---

## Scalability Considerations

| Concern | At Current Scale | If DB Doubles | Notes |
|---------|-----------------|---------------|-------|
| Override file size | ~200 entries, ~15KB | ~400 entries, ~30KB | Still fast, single JSON load |
| Audit runtime | ~972 help patches, ~30s | ~2000, ~60s | Offline tool, speed not critical |
| Panel rendering | 1-3 panels per patch | 5-10 panels | MAX handles fine, no performance concern |
| Layout computation | <50 boxes typical | <100 boxes | Current O(n^2) graph ops are fine |

---

## Sources

- Direct analysis of `/Users/taylorbrook/Dev/MAX/src/maxpat/` codebase (all files read)
- Direct analysis of MAX help patches at `/Applications/Max.app/Contents/Resources/C74/help/`
- Existing overrides.json corrections (19 objects with known outlet type issues)
- `.maxpat` format analysis from help patch structure (patcher props, box attributes, outlettype arrays)
- Memory feedback: `feedback_msp_outlet_types.md`, `feedback_layout_spacing.md`, `feedback_multislider_fetch.md`
- Confidence: HIGH -- all recommendations based on direct codebase analysis and .maxpat format verification
