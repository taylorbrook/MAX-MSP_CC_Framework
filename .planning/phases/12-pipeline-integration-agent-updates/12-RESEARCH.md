# Phase 12: Pipeline Integration & Agent Updates - Research

**Researched:** 2026-03-13
**Domain:** Python pipeline integration, agent documentation (SKILL.md files)
**Confidence:** HIGH

## Summary

Phase 12 wires aesthetic styling (Phase 10) and layout improvements (Phase 11) into the main `generate_patch()` pipeline so patches are polished by default, and updates all 6 agent SKILL.md files with new capabilities. The codebase is well-structured: all building blocks exist in `aesthetics.py`, `patcher.py`, `defaults.py`, and `layout.py`. The `generate_patch()` function in `__init__.py` is the single integration point for auto-styling. Agent SKILL.md files follow a consistent format with "Key Functions" sections that need aesthetic method additions.

This is primarily an integration and documentation phase -- no new libraries, no new architectural patterns, no new algorithms. The work is: (1) modify `generate_patch()` to call `set_canvas_background()` and `set_object_bgcolor()` before layout, (2) add an optional `layout_options` parameter to `generate_patch()`, (3) export `LayoutOptions` from `__init__.py`, (4) update 6 SKILL.md files with aesthetic capability documentation, and (5) cross-reference DSP agent curated object lists against audit corrections.

**Primary recommendation:** Keep changes minimal and surgical -- the existing code is clean and well-tested. Focus on pipeline integration (small code changes) and agent documentation (content updates).

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- Always apply canvas background color (AESTHETIC_PALETTE["canvas_bg"]) -- agents don't need to remember to call set_canvas_background()
- No auto-panels -- panels are a project-level decision, surfaced during project discuss phase, not applied by default
- Always highlight dac~ and loadbang with subtle background color via set_object_bgcolor()
- Add optional `layout_options: LayoutOptions | None = None` parameter to generate_patch() -- passes through to apply_layout()
- All 6 agents (patch, dsp, rnbo, js, ext, ui) get aesthetic capability documentation
- Format: method list with one-line "when to use" descriptions, matching existing "Key Functions" section style
- Document Patcher methods: add_section_header, add_subsection, add_annotation, add_bubble, add_panel, add_step_marker
- Document aesthetics.py helpers: set_canvas_background, set_object_bgcolor, auto_size_panel, is_complex_patch
- Document LayoutOptions in all agents: note generate_patch() accepts it, list key fields
- DB layer is enough for outlet type corrections -- ObjectDatabase merges overrides.json automatically
- Validation pipeline catches connection errors -- no need for agents to know about specific corrections
- Cross-reference DSP agent's curated object lists against audit corrections and update descriptions where significant corrections were found

### Claude's Discretion
- LayoutOptions exported from public API (src.maxpat.__init__) alongside other public types
- Import path organization for new exports
- Exact wording and ordering of new SKILL.md sections
- Which audit corrections are "significant" enough to update in DSP agent's curated object lists

### Deferred Ideas (OUT OF SCOPE)
- Panel auto-addition as a project-level preference in max-discuss flow -- future enhancement to project kickoff
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| AGNT-01 | Agent SKILL.md files updated with corrected outlet types and connection patterns from audit findings | DB layer handles this transparently via overrides.json merge. DSP agent curated object lists need cross-referencing against audit corrections. No per-agent outlet type documentation needed. |
| AGNT-02 | Agent docs updated with aesthetic capabilities (comment styling, panels, layout options) | All 6 agents need new "Aesthetic Capabilities" sections documenting Patcher methods, aesthetics.py helpers, and LayoutOptions. Format matches existing "Key Functions" style. |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Python | 3.14 | Runtime | Project standard |
| pytest | 9.0.2 | Testing | Project standard |

### Supporting
No new libraries needed. This phase uses only existing project modules:

| Module | File | Purpose |
|--------|------|---------|
| `aesthetics` | `src/maxpat/aesthetics.py` | `set_canvas_background()`, `set_object_bgcolor()`, `auto_size_panel()`, `is_complex_patch()` |
| `defaults` | `src/maxpat/defaults.py` | `AESTHETIC_PALETTE`, `LayoutOptions` dataclass |
| `patcher` | `src/maxpat/patcher.py` | `add_section_header()`, `add_subsection()`, `add_annotation()`, `add_bubble()`, `add_panel()`, `add_step_marker()` |
| `layout` | `src/maxpat/layout.py` | `apply_layout(patcher, options)` -- already accepts `LayoutOptions` parameter |
| `__init__` | `src/maxpat/__init__.py` | `generate_patch()` -- integration point |

## Architecture Patterns

### Integration Point: generate_patch()

The current `generate_patch()` function (lines 63-100 of `__init__.py`) follows this pipeline:

```
apply_layout(patcher) -> patcher.to_dict() -> validate_patch(patch_dict) -> raise if errors
```

The modified pipeline will be:

```
_apply_auto_styling(patcher) -> apply_layout(patcher, layout_options) -> patcher.to_dict() -> validate_patch() -> raise if errors
```

**Auto-styling must happen BEFORE layout** because:
1. `set_canvas_background()` modifies `patcher.props` (patcher-level, not box-level) -- order-independent but logically first
2. `set_object_bgcolor()` adds `extra_attrs["bgcolor"]` to boxes -- has no layout side effects, but should happen before serialization
3. The `layout_options` parameter passes through to `apply_layout()` which already accepts it

### Pattern: Auto-styling helper function

Create a private `_apply_auto_styling()` function inside `__init__.py` that:
1. Calls `set_canvas_background(patcher)` (always, using default palette)
2. Iterates `patcher.boxes` to find `dac~` and `loadbang` objects
3. Calls `set_object_bgcolor(box, palette_key="emphasis_dac")` for dac~/ezdac~
4. Calls `set_object_bgcolor(box, palette_key="emphasis_loadbang")` for loadbang

Object detection for auto-highlighting:
- `dac~`: check `box.name == "dac~"` or `box.name == "ezdac~"`
- `loadbang`: check `box.name == "loadbang"`

### Pattern: LayoutOptions pass-through

```python
def generate_patch(
    patcher: Patcher,
    layout_options: LayoutOptions | None = None,
) -> tuple[dict, list[ValidationResult]]:
    _apply_auto_styling(patcher)
    apply_layout(patcher, layout_options)
    # ... rest unchanged
```

The `write_patch()` function in `hooks.py` also calls `generate_patch()` and `apply_layout()`. It needs the same `layout_options` parameter added so it passes through correctly. Currently `write_patch()` has two code paths:
1. `validate=True`: calls `generate_patch(patcher)` -- needs layout_options forwarded
2. `validate=False`: calls `apply_layout(patcher)` directly -- needs layout_options forwarded

### Pattern: Agent SKILL.md sections

All 6 agent SKILL.md files use consistent markdown structure. The new aesthetic documentation should be added as a new `### Aesthetic Capabilities` section within the existing `## Capabilities` hierarchy.

Current "Key Functions" format (example from max-patch-agent):
```markdown
### Key Functions
- `Patcher()` -- create a new patch
- `Box(name, args, db)` -- create a validated box
- `generate_patch(patcher)` -- layout + serialize + validate
```

New aesthetic section format should match this style:
```markdown
### Aesthetic Capabilities
- `add_section_header(text)` -- large bold header comment for patch sections
- `add_subsection(text)` -- bold subsection label
...
```

### Public API Export Pattern

`LayoutOptions` should be added to `__init__.py` imports and `__all__` list, following existing patterns:

```python
from src.maxpat.defaults import LayoutOptions
# ... in __all__:
"LayoutOptions",
```

### Anti-Patterns to Avoid
- **Don't duplicate DB corrections in agent docs**: The ObjectDatabase merges overrides.json automatically. Agents never need to know about specific outlet type corrections.
- **Don't add auto-panels**: User explicitly deferred this -- panels are a project-level decision.
- **Don't modify aesthetics.py or defaults.py**: These modules are complete from Phase 10. Only consume them.
- **Don't break generate_patch() signature compatibility**: The new `layout_options` parameter must be optional (default None) so all existing callers continue to work.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Canvas background | Custom patcher.props manipulation | `set_canvas_background(patcher)` from aesthetics.py | Already handles both editing_bgcolor and locked_bgcolor |
| Object highlighting | Manual extra_attrs["bgcolor"] setting | `set_object_bgcolor(box, palette_key=...)` from aesthetics.py | Palette-aware, validates input |
| Layout configuration | Module-level constant overrides | `LayoutOptions` dataclass from defaults.py | Already integrated with apply_layout() |

## Common Pitfalls

### Pitfall 1: Breaking existing tests by changing generate_patch() signature
**What goes wrong:** Adding a required parameter to generate_patch() breaks all 847 existing tests and all callers.
**Why it happens:** Forgetting to make the new parameter optional.
**How to avoid:** `layout_options: LayoutOptions | None = None` -- always optional, defaults to None (which apply_layout already handles as "use defaults").
**Warning signs:** Test failures in test_generation.py or test_hooks.py.

### Pitfall 2: Auto-styling modifying boxes that are already styled
**What goes wrong:** If a user manually set bgcolor on a dac~ box, auto-styling overwrites it.
**Why it happens:** Unconditionally calling set_object_bgcolor() on all matching boxes.
**How to avoid:** Only apply auto-styling if the box does not already have bgcolor in extra_attrs. Check `if "bgcolor" not in box.extra_attrs:` before applying.
**Warning signs:** User-set colors disappearing.

### Pitfall 3: write_patch() not forwarding layout_options
**What goes wrong:** Users calling write_patch() directly (the most common entry point) don't get layout_options support.
**Why it happens:** write_patch() in hooks.py calls generate_patch() and apply_layout() separately and must be updated.
**How to avoid:** Add layout_options parameter to write_patch() too, and forward it to both code paths.
**Warning signs:** LayoutOptions only works with generate_patch() but not write_patch().

### Pitfall 4: Agent SKILL.md test regressions
**What goes wrong:** test_agent_skills.py has specific content assertions (e.g., "add_connection" must appear in patch agent, specific function signature patterns).
**Why it happens:** Tests verify exact string patterns in SKILL.md content.
**How to avoid:** Read test_agent_skills.py carefully before modifying any SKILL.md. All existing assertions must continue to pass. New content should not conflict with existing assertions (e.g., don't add text that would match negative assertions).
**Warning signs:** test_agent_skills.py failures.

### Pitfall 5: Auto-styling in subpatchers
**What goes wrong:** Auto-styling traverses only top-level patcher.boxes, missing dac~/loadbang inside subpatchers.
**Why it happens:** Not considering nested patchers.
**How to avoid:** Only style top-level boxes -- subpatchers are internal implementation details. dac~ and loadbang inside subpatchers are rare and should not be auto-highlighted (they serve structural purposes, not user-facing emphasis).
**Warning signs:** Unexpected highlighting inside subpatcher views.

### Pitfall 6: Audit cross-reference scope creep
**What goes wrong:** Spending excessive time cross-referencing every audit correction against DSP agent curated lists.
**Why it happens:** The audit has findings for 1022 objects, but the DSP agent only lists ~40 curated objects.
**How to avoid:** Only check the specific objects listed in the DSP agent's Signal Chain Construction section. For each listed object, check if overrides.json has corrections for it. Only update the description if the correction is significant (e.g., wrong outlet count in the DB that would affect how agents connect to it).
**Warning signs:** Updating descriptions for minor corrections (e.g., help patch width differences).

## Code Examples

### generate_patch() with auto-styling (integration point)

```python
# Source: analysis of __init__.py lines 63-100 + aesthetics.py
from src.maxpat.aesthetics import set_canvas_background, set_object_bgcolor
from src.maxpat.defaults import LayoutOptions

_AUTO_HIGHLIGHT = {
    "dac~": "emphasis_dac",
    "ezdac~": "emphasis_dac",
    "loadbang": "emphasis_loadbang",
}

def _apply_auto_styling(patcher: Patcher) -> None:
    """Apply default aesthetic styling to a patcher."""
    set_canvas_background(patcher)
    for box in patcher.boxes:
        palette_key = _AUTO_HIGHLIGHT.get(box.name)
        if palette_key and "bgcolor" not in box.extra_attrs:
            set_object_bgcolor(box, palette_key=palette_key)

def generate_patch(
    patcher: Patcher,
    layout_options: LayoutOptions | None = None,
) -> tuple[dict, list[ValidationResult]]:
    _apply_auto_styling(patcher)
    apply_layout(patcher, layout_options)
    patch_dict = patcher.to_dict()
    results = validate_patch(patch_dict, db=patcher.db)
    if has_blocking_errors(results):
        error_msgs = [r.message for r in results if r.level == "error" and not r.auto_fixed]
        raise PatchGenerationError(
            f"Patch generation blocked by unfixable errors:\n" +
            "\n".join(f"  - {m}" for m in error_msgs)
        )
    return (patch_dict, results)
```

### Agent SKILL.md aesthetic section template

```markdown
### Aesthetic Capabilities

**Auto-applied by generate_patch():**
- Canvas background color is set automatically (off-white with blue tint)
- `dac~` and `loadbang` objects are highlighted with subtle background colors
- No manual styling calls needed for default aesthetics

**Patcher methods for explicit styling:**
- `add_section_header(text)` -- 16pt bold colored header with background (for patch sections)
- `add_subsection(text)` -- 12pt bold dark gray label (for subsection grouping)
- `add_annotation(text, target=box)` -- 10pt italic light gray note (for inline documentation)
- `add_bubble(text, bubbleside=1)` -- comment with arrow pointer (for callout notes)
- `add_panel(x, y, w, h, gradient=True)` -- background panel for visual grouping
- `add_step_marker(number, x, y)` -- numbered amber circle (for step-by-step patches)

**Aesthetics helpers (from `src.maxpat.aesthetics`):**
- `set_canvas_background(patcher, color=None)` -- override canvas color (auto-applied)
- `set_object_bgcolor(box, palette_key=None, color=None)` -- highlight specific objects
- `auto_size_panel(boxes, padding=18)` -- compute panel rect to enclose boxes
- `is_complex_patch(patcher)` -- heuristic: True if 10+ boxes or subpatchers present

**Layout options:**
- `generate_patch(patcher, layout_options=LayoutOptions(...))` -- customize layout
- Key fields: `v_spacing` (vertical gap), `h_gutter` (horizontal gap), `grid_snap` (15px grid), `inlet_align` (cable straightening), `comment_gap` (annotation offset)
```

### DSP agent curated object cross-reference

Objects currently listed in DSP agent SKILL.md "Signal Chain Construction":
```
Oscillators: cycle~, saw~, rect~, noise~, phasor~, pink~, rand~
Filters: biquad~, onepole~, reson~, svf~, cascade~, lores~, cross~
Delays: tapin~/tapout~, delay~, allpass~, comb~
Dynamics: limi~ (peak limiter), gate~, deltaclip~ (slew limiter), gen~ (custom compressor/limiter via GenExpr)
Effects: reverb~, chorus~, flanger~, phaser~
Gain: *~, line~, dbtoa/atodb
Monitoring: meter~, levelmeter~, scope~, spectroscope~, snapshot~
```

Cross-reference check: look up each object in overrides.json. Only flag objects with outlet type corrections or I/O count changes that would affect agent connection patterns.

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Manual styling per patch | Auto-styling in generate_patch() | Phase 12 (this phase) | Every generated patch gets polished by default |
| Agents unaware of aesthetics | Agent docs list aesthetic methods | Phase 12 (this phase) | Agents can add section headers, panels, etc. |
| Fixed layout constants | LayoutOptions dataclass | Phase 11 | Customizable spacing, grid, alignment |

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | none (defaults) |
| Quick run command | `python3 -m pytest tests/ -x --tb=short -q` |
| Full suite command | `python3 -m pytest tests/ --tb=short -q` |

### Phase Requirements to Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| AGNT-01 | DSP agent curated object lists reflect audit corrections | unit | `python3 -m pytest tests/test_agent_skills.py -x` | Existing file, new tests needed |
| AGNT-02-a | generate_patch() applies canvas bg automatically | unit | `python3 -m pytest tests/test_generation.py -x` | Existing file, new tests needed |
| AGNT-02-b | generate_patch() highlights dac~/loadbang automatically | unit | `python3 -m pytest tests/test_generation.py -x` | Existing file, new tests needed |
| AGNT-02-c | generate_patch() accepts layout_options parameter | unit | `python3 -m pytest tests/test_generation.py -x` | Existing file, new tests needed |
| AGNT-02-d | LayoutOptions exported from public API | unit | `python3 -m pytest tests/test_generation.py -x` | Existing file, new tests needed |
| AGNT-02-e | All 6 agent SKILL.md files reference aesthetic capabilities | unit | `python3 -m pytest tests/test_agent_skills.py -x` | Existing file, new tests needed |
| AGNT-02-f | write_patch() forwards layout_options | unit | `python3 -m pytest tests/test_hooks.py -x` | Existing file, new tests needed |
| REGRESS | All 847 existing tests still pass | regression | `python3 -m pytest tests/ -x --tb=short -q` | All existing |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/ -x --tb=short -q`
- **Per wave merge:** `python3 -m pytest tests/ --tb=short -q`
- **Phase gate:** Full suite green before `/gsd:verify-work`

### Wave 0 Gaps
None -- existing test infrastructure covers all phase requirements. New tests will be added to existing test files (`test_generation.py`, `test_agent_skills.py`, `test_hooks.py`).

## Open Questions

1. **Which audit corrections are "significant" for DSP agent curated lists?**
   - What we know: overrides.json has corrections for many objects. DSP agent lists ~40 curated objects.
   - What's unclear: Threshold for "significant" -- outlet type changes? I/O count changes? Both?
   - Recommendation: Only update descriptions for objects with outlet type corrections (signal vs control) or I/O count changes that affect connection patterns. Width-only or argument-format-only changes are not significant for agent documentation.

2. **Should auto-styling also highlight key processor objects (emphasis_processor palette key)?**
   - What we know: AESTHETIC_PALETTE has "emphasis_processor" key ([0.85, 0.87, 0.95, 1.0] - pale blue). CONTEXT.md only mentions dac~ and loadbang.
   - What's unclear: Whether any other objects should be auto-highlighted.
   - Recommendation: Stick to CONTEXT.md decisions -- only dac~/ezdac~ and loadbang. The emphasis_processor key exists for manual use by agents when they want to highlight specific objects.

## Sources

### Primary (HIGH confidence)
- Direct code analysis of `src/maxpat/__init__.py` (generate_patch function)
- Direct code analysis of `src/maxpat/aesthetics.py` (all helpers)
- Direct code analysis of `src/maxpat/defaults.py` (LayoutOptions, AESTHETIC_PALETTE)
- Direct code analysis of `src/maxpat/layout.py` (apply_layout accepts LayoutOptions)
- Direct code analysis of `src/maxpat/hooks.py` (write_patch function)
- Direct code analysis of `src/maxpat/patcher.py` (all Patcher methods)
- All 6 agent SKILL.md files read and analyzed
- `tests/test_agent_skills.py` analyzed for content assertions
- `tests/test_aesthetics.py` analyzed for existing aesthetic tests
- `tests/test_generation.py` analyzed for existing pipeline tests
- `.claude/max-objects/overrides.json` (7365 lines, audit corrections)
- Full test suite run: 847 tests passing

### Secondary (MEDIUM confidence)
- 12-CONTEXT.md user decisions
- STATE.md project history

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- no new dependencies, pure integration of existing code
- Architecture: HIGH -- single integration point (generate_patch), well-understood pipeline
- Pitfalls: HIGH -- direct code analysis reveals all edge cases
- Agent docs: HIGH -- all 6 SKILL.md files read, format is consistent and simple

**Research date:** 2026-03-13
**Valid until:** 2026-04-13 (stable -- internal codebase, no external dependencies)
