# Phase 25: Testing - Research

**Researched:** 2026-04-07
**Domain:** End-to-end M4L pipeline integration testing
**Confidence:** HIGH

## Summary

Phase 25 adds E2E integration tests that exercise the complete M4L device creation pipeline: scaffold -> add controls -> polish -> layout -> critic -> export. The existing codebase has 189 green M4L unit tests across 5 test files (scaffold, critic, export, polish, layout). The E2E tests layer on top without duplicating unit-level coverage -- they verify the pipeline as a connected flow, asserting both intermediate checkpoints and final output validity.

The research domain is narrow and well-understood: the test targets are all Python modules in this project with documented APIs, established test patterns (pytest, tmp_path, mock auto_commit_patch), and clear success criteria from CONTEXT.md decisions. No external libraries are needed beyond pytest (already installed, v9.0.2).

**Primary recommendation:** Build E2E tests using the same test helper patterns established in existing M4L test files, exercising three device types through the full pipeline with 8-12 controls per fixture.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- **D-01:** Full pipeline per device type -- each E2E test creates a scaffold, adds controls programmatically, runs polish->layout->critic->export in sequence. Minimum 3 tests (audio_effect, instrument, midi_effect).
- **D-02:** Assert on final output plus key checkpoints -- verify final .amxd validity and critic results, plus intermediate checks at post-scaffold (required objects present) and post-critic (no blockers on valid devices).
- **D-03:** Realistic devices with 8-12 controls per test fixture. Enough to exercise grouping, Push banks, layout columns, tab triggers, and overlay patterns. Each device type gets a distinct control set appropriate to its purpose.
- **D-04:** Both unit and E2E violation coverage. Existing test_m4l_critic.py unit tests stay untouched. New E2E tests build intentionally broken devices through the full pipeline and verify critic catches violations in context.

### Claude's Discretion
- File organization -- single file vs split, based on final test count
- Specific control configurations for each device type fixture
- Helper function structure for building test devices
- Whether to use shared fixtures or per-test setup

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| TEST-01 | End-to-end tests create M4L devices of each type and validate all required components | Full pipeline API chain documented; helper patterns from existing tests; control fixture designs researched |
</phase_requirements>

## Project Constraints (from CLAUDE.md)

- All M4L tests must mock `auto_commit_patch` to avoid git commits during tests [VERIFIED: existing test pattern in test_m4l_scaffold.py, test_m4l_export.py]
- Tests use pytest `tmp_path` fixture for isolated file I/O [VERIFIED: all existing test files]
- No generator scripts (Rule #5) -- tests build Patcher instances in-memory [VERIFIED: CLAUDE.md]
- Object database is single source of truth for objects, I/O counts, behaviors [VERIFIED: CLAUDE.md Rule #1]
- Gain safety: gain~ -> plugout~ is a blocker [VERIFIED: m4l_critic.py, CLAUDE.md MSP rules]

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| pytest | 9.0.2 | Test framework | Already installed, used by all 1400+ existing tests |

### Supporting
| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| unittest.mock | stdlib | Mock auto_commit_patch | Every test that calls scaffold/export functions |
| struct | stdlib | AMXD binary header validation | Asserting .amxd output validity |
| json | stdlib | Patch dict construction and .maxpat reading | Throughout all tests |

[VERIFIED: pytest 9.0.2 confirmed via `python3 -m pytest --version`]

No new packages needed. Zero install step.

## Architecture Patterns

### Recommended Test File Organization

**Recommendation: Single file** (`tests/test_m4l_e2e.py`)

Rationale: The decision scope (D-01 through D-04) yields approximately 15-20 tests. This fits comfortably in one file with clear class grouping, matching the project pattern where `test_m4l_critic.py` has 34 tests in 794 lines.

```
tests/
  test_m4l_e2e.py        # NEW -- full pipeline E2E tests
  test_m4l_scaffold.py   # EXISTING -- untouched
  test_m4l_critic.py     # EXISTING -- untouched
  test_m4l_export.py     # EXISTING -- untouched
  test_m4l_polish.py     # EXISTING -- untouched
  test_m4l_layout.py     # EXISTING -- untouched
```

### Pattern 1: Pipeline Helper Function

The core test helper creates a device, adds controls, and runs the pipeline.

```python
# Source: derived from existing _scaffold_and_load pattern in test_m4l_scaffold.py
def _build_device(device_type, name, tmp_path, controls):
    """Scaffold device, add controls to patch_dict, return (patch_dict, project_dir, patch_path)."""
    with mock_patch("src.maxpat.project.auto_commit_patch"):
        from src.maxpat.project import create_m4l_project
        project_dir = create_m4l_project(device_type, name, tmp_path)
    
    patch_path = project_dir / "generated" / f"{name}.maxpat"
    patch_dict = json.loads(patch_path.read_text())
    
    # Add controls to patcher boxes
    for ctrl in controls:
        patch_dict["patcher"]["boxes"].append({"box": ctrl})
    
    return patch_dict, project_dir, patch_path
```

```python
# Source: derived from m4l_polish.py and m4l_layout.py entry points
def _run_pipeline(patch_dict, patch_path, device_type, tmp_path):
    """Run polish -> layout -> critic -> export. Return (results, amxd_path, amxd_bytes)."""
    from src.maxpat.m4l_polish import polish_m4l_device
    from src.maxpat.m4l_layout import layout_m4l_presentation
    from src.maxpat.critics import review_patch
    from src.maxpat.m4l_export import write_amxd
    
    polish_m4l_device(patch_dict)
    layout_m4l_presentation(patch_dict)
    
    # Write polished/laid-out patch back so export reads it
    patch_path.write_text(json.dumps(patch_dict, indent=2))
    
    critic_results = review_patch(patch_dict)
    
    amxd_path = patch_path.parent / f"{patch_path.stem}.amxd"
    with mock_patch("src.maxpat.m4l_export.auto_commit_patch"):
        write_amxd(patch_path, amxd_path, device_type)
    
    amxd_bytes = amxd_path.read_bytes()
    return critic_results, amxd_path, amxd_bytes
```

### Pattern 2: Control Fixture Builder

Builds realistic control sets per device type (D-03).

```python
# Source: derived from test_m4l_polish.py:_make_live_control and m4l_polish.py semantics
def _make_control(box_id, maxclass, varname, longname=None, **extras):
    """Build a live.* control box dict."""
    box = {
        "id": box_id,
        "maxclass": maxclass,
        "numinlets": 1,
        "numoutlets": 2,
        "outlettype": ["", "float"],
        "parameter_enable": 1,
    }
    if varname:
        box["varname"] = varname
    if longname:
        box.setdefault("saved_attribute_attributes", {}).setdefault("valueof", {})["parameter_longname"] = longname
    box.update(extras)
    return box
```

### Pattern 3: Test Class Organization

```python
class TestAudioEffectE2E:
    """Full pipeline E2E for audio_effect (8-12 controls)."""
    # test_scaffold_has_required_objects
    # test_polish_derives_all_names
    # test_layout_assigns_presentation_rects
    # test_critic_no_blockers
    # test_export_valid_amxd
    # test_presentation_within_169px

class TestInstrumentE2E:
    """Full pipeline E2E for instrument (8-12 controls)."""

class TestMidiEffectE2E:
    """Full pipeline E2E for midi_effect (8-12 controls)."""

class TestViolationE2E:
    """Intentionally broken devices caught by critic through full pipeline."""
    # test_gain_plugout_violation_caught
    # test_missing_parameter_enable_warning
    # test_duplicate_longname_caught
```

### Anti-Patterns to Avoid
- **Duplicating unit test assertions:** E2E tests should NOT re-test individual critic rules in isolation. The unit tests already cover that. E2E tests verify the critic catches issues *through the full pipeline*.
- **Skipping intermediate checkpoints:** Don't only assert on final .amxd. Verify post-scaffold (objects present) and post-critic (no blockers) to catch regressions in specific pipeline stages.
- **Hardcoding presentation_rect values:** Assert on properties (int type, within 169px) not exact pixel values. Layout algorithm may change.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Device scaffolding | Custom patch dict builder | `create_m4l_project()` | Already handles all device types with correct boilerplate |
| Parameter naming | Manual longname/shortname setup | `polish_m4l_device()` | Handles abbreviation, dedup, Push banks, info text in correct order |
| Layout positioning | Manual presentation_rect math | `layout_m4l_presentation()` | Handles grouping, column-packing, tabbed layout, z-order |
| Critic invocation | Direct m4l_critic calls | `review_patch()` | Auto-detects M4L device type and runs all critics |
| AMXD validation | Custom binary parsing | `struct.unpack(AMXD_HEADER_FORMAT, ...)` | Constants already defined in m4l_constants.py |

## Common Pitfalls

### Pitfall 1: Forgetting to mock auto_commit_patch
**What goes wrong:** Tests try to run `git add` / `git commit` in the test runner, causing failures or polluting the repo.
**Why it happens:** Both `create_m4l_project()` and `write_amxd()` call `auto_commit_patch()`.
**How to avoid:** Mock both paths: `src.maxpat.project.auto_commit_patch` and `src.maxpat.m4l_export.auto_commit_patch`.
**Warning signs:** Test failures mentioning git, or unexpected git commits.

### Pitfall 2: Not writing polished patch back to disk before export
**What goes wrong:** `write_amxd()` reads from the file path, not from the dict. If you polish/layout the dict but don't write it back, export reads the stale pre-polish file.
**Why it happens:** `write_amxd()` takes a file path and does `json.loads(patch_path.read_text())`.
**How to avoid:** After `polish_m4l_device()` and `layout_m4l_presentation()`, write `patch_dict` back to `patch_path` before calling `write_amxd()`.
**Warning signs:** Export .amxd body doesn't contain the polished parameter names.

### Pitfall 3: Asserting exact pixel coordinates
**What goes wrong:** Tests become brittle -- any layout algorithm change breaks all E2E tests.
**Why it happens:** Over-specifying expected coordinates.
**How to avoid:** Assert structural properties: all coords are int, all y + h <= 169, presentation=1, devicewidth >= 300. Don't assert exact x/y values.
**Warning signs:** Tests break when layout constants change in m4l_layout.py.

### Pitfall 4: Controls without longname or varname
**What goes wrong:** `_classify_parameter()` uses longname for group classification. Controls without names get classified as "Main" and may not exercise the grouping/tabbing logic.
**Why it happens:** Forgetting to set varname or longname on test fixture controls.
**How to avoid:** Always set `varname` on each test control. Polish will derive longname from it.
**Warning signs:** All controls end up in one "Main" group instead of being spread across groups.

### Pitfall 5: Module-level global state in m4l_layout
**What goes wrong:** `_readout_counter` in m4l_layout.py is a module-level global that persists across tests.
**Why it happens:** `add_readout_overlay()` increments a global counter for unique readout IDs.
**How to avoid:** Don't depend on specific readout IDs in assertions. Or reset the counter if needed.
**Warning signs:** Readout IDs change based on test execution order.

## Code Examples

### Example 1: Audio Effect Control Fixture (8 controls)
```python
# Source: derived from m4l_polish.py _classify_parameter keywords
# Covers 3+ groups: Filter (cutoff, reso), Amp (volume), FX (delay_time, delay_feedback),
# Mix (dry_wet), plus 2 more to total 8-10
AUDIO_EFFECT_CONTROLS = [
    _make_control("obj-ae-1", "live.dial", "filter_cutoff"),
    _make_control("obj-ae-2", "live.dial", "filter_resonance"),
    _make_control("obj-ae-3", "live.slider", "amp_volume"),
    _make_control("obj-ae-4", "live.dial", "delay_time"),
    _make_control("obj-ae-5", "live.dial", "delay_feedback"),
    _make_control("obj-ae-6", "live.dial", "mod_rate"),
    _make_control("obj-ae-7", "live.dial", "mod_depth"),
    _make_control("obj-ae-8", "live.dial", "dry_wet"),
]
```

### Example 2: Instrument Control Fixture (10 controls)
```python
# Source: derived from m4l_polish.py _classify_parameter keywords
# Covers pitch, filter, amp, envelope groups
INSTRUMENT_CONTROLS = [
    _make_control("obj-in-1", "live.dial", "pitch_tune"),
    _make_control("obj-in-2", "live.dial", "pitch_detune"),
    _make_control("obj-in-3", "live.dial", "filter_cutoff"),
    _make_control("obj-in-4", "live.dial", "filter_resonance"),
    _make_control("obj-in-5", "live.dial", "amp_volume"),
    _make_control("obj-in-6", "live.dial", "attack"),
    _make_control("obj-in-7", "live.dial", "decay"),
    _make_control("obj-in-8", "live.dial", "sustain"),
    _make_control("obj-in-9", "live.dial", "release"),
    _make_control("obj-in-10", "live.dial", "mod_depth"),
]
```

### Example 3: Asserting 169px Height Cap
```python
# Source: m4l_layout.py DEVICE_HEIGHT constant
from src.maxpat.m4l_layout import DEVICE_HEIGHT

def _assert_within_height(patch_dict):
    """All presentation_rect y + h <= DEVICE_HEIGHT (169px)."""
    for box_entry in patch_dict["patcher"]["boxes"]:
        box = box_entry.get("box", {})
        rect = box.get("presentation_rect")
        if rect and len(rect) == 4:
            y, h = rect[1], rect[3]
            assert y + h <= DEVICE_HEIGHT, (
                f"Box {box.get('id')} exceeds 169px: y={y} + h={h} = {y+h}"
            )
```

### Example 4: Asserting AMXD Validity
```python
# Source: m4l_constants.py and test_m4l_export.py pattern
import struct
from src.maxpat.m4l_constants import AMXD_HEADER_FORMAT, AMXD_HEADER_SIZE

def _assert_valid_amxd(raw_bytes, device_type):
    """Verify AMXD binary header and JSON body."""
    assert len(raw_bytes) > AMXD_HEADER_SIZE
    assert raw_bytes[0:4] == b"ampf"
    
    type_map = {"audio_effect": b"aaaa", "instrument": b"iiii", "midi_effect": b"mmmm"}
    assert raw_bytes[8:12] == type_map[device_type]
    
    json_len = struct.unpack_from("<I", raw_bytes, 28)[0]
    json_body = raw_bytes[AMXD_HEADER_SIZE:]
    assert len(json_body) == json_len
    
    data = json.loads(json_body)
    assert "patcher" in data
```

### Example 5: Violation E2E Test
```python
# Source: derived from test_m4l_critic.py::TestGainPlugout + D-04
def test_gain_plugout_violation_through_pipeline(self, tmp_path):
    """Build device with gain~->plugout~ through full pipeline, verify blocker."""
    patch_dict, project_dir, patch_path = _build_device(
        "audio_effect", "violation-test", tmp_path, controls=[...]
    )
    # Manually add gain~ -> plugout~ connection to patch_dict
    # (scaffold has plugin~ -> plugout~, we insert gain~ between)
    # Run full pipeline
    # Assert critic results contain gain~/plugout~ blocker
```

## Pipeline Function Signatures

Key functions the E2E tests call, in pipeline order:

| Function | Module | Signature | Mutates | Returns |
|----------|--------|-----------|---------|---------|
| `create_m4l_project` | `project.py` | `(device_type, name, base_dir, devicewidth=300.0)` | disk | Path |
| `polish_m4l_device` | `m4l_polish.py` | `(patch_dict)` | in-place | same dict |
| `layout_m4l_presentation` | `m4l_layout.py` | `(patch_dict)` | in-place | same dict |
| `review_patch` | `critics/__init__.py` | `(patch_dict)` | no | list[CriticResult] |
| `write_amxd` | `m4l_export.py` | `(patch_path, output_path, device_type)` | disk | Path |

[VERIFIED: all signatures confirmed from source code]

## Tabbed Layout Trigger

E2E tests with 8-12 controls will exercise both single-page and tabbed layout:
- `TAB_CONTROL_THRESHOLD = 8` -- more than 8 controls triggers tabbed mode [VERIFIED: m4l_layout.py]
- `TAB_GROUP_THRESHOLD = 3` -- more than 3 groups triggers tabbed mode [VERIFIED: m4l_layout.py]
- Audio effect fixture (8 controls, 4+ groups) will trigger tabbed layout via group count
- A separate test with fewer controls (e.g., midi_effect with 4 controls in 2 groups) will exercise single-page layout

This means the instrument fixture (10 controls, 4+ groups) will definitely hit tabbed, while midi_effect can be designed with fewer controls to hit single-page.

## Existing Test Baseline

| Test File | Tests | Lines | Green |
|-----------|-------|-------|-------|
| test_m4l_scaffold.py | 30 | 271 | Yes |
| test_m4l_critic.py | 34 | 795 | Yes |
| test_m4l_export.py | 14 | 214 | Yes |
| test_m4l_polish.py | 30+ | 733 | Yes |
| test_m4l_layout.py | 90+ | 1,403 | Yes |
| **Total M4L** | **189** | **3,416** | **Yes** |

Full suite: 1417 passing, 27 pre-existing failures (all in integration/roundtrip tests, unrelated to M4L).

[VERIFIED: `python3 -m pytest tests/test_m4l_*.py -x --tb=no -q` returns 189 passed]

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | None (default discovery) |
| Quick run command | `python3 -m pytest tests/test_m4l_e2e.py -x -q` |
| Full suite command | `python3 -m pytest tests/ -x --tb=short -q` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| TEST-01 | E2E creates audio_effect with all components | integration | `python3 -m pytest tests/test_m4l_e2e.py::TestAudioEffectE2E -x` | Wave 0 |
| TEST-01 | E2E creates instrument with all components | integration | `python3 -m pytest tests/test_m4l_e2e.py::TestInstrumentE2E -x` | Wave 0 |
| TEST-01 | E2E creates midi_effect with all components | integration | `python3 -m pytest tests/test_m4l_e2e.py::TestMidiEffectE2E -x` | Wave 0 |
| TEST-01 | Critic catches violations in pipeline context | integration | `python3 -m pytest tests/test_m4l_e2e.py::TestViolationE2E -x` | Wave 0 |
| TEST-01 | .amxd export valid for all types | integration | `python3 -m pytest tests/test_m4l_e2e.py -k "amxd" -x` | Wave 0 |
| TEST-01 | Layout respects 169px height cap | integration | `python3 -m pytest tests/test_m4l_e2e.py -k "169" -x` | Wave 0 |
| TEST-01 | Zero regressions on existing tests | regression | `python3 -m pytest tests/test_m4l_*.py -x --tb=short -q` | existing |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/test_m4l_e2e.py -x -q`
- **Per wave merge:** `python3 -m pytest tests/test_m4l_*.py -x --tb=short -q`
- **Phase gate:** Full M4L suite green before `/gsd-verify-work`

### Wave 0 Gaps
- [ ] `tests/test_m4l_e2e.py` -- the entire E2E test file (this phase creates it)

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | midi_effect fixture with 4-6 controls and 2 groups will exercise single-page layout | Tabbed Layout Trigger | Low -- if it triggers tabbed, adjust control count down |
| A2 | `m4l_detection.py` referenced in CONTEXT.md canonical refs does not exist; detection logic is in `critics/__init__.py:_detect_m4l_device()` | Architecture | Low -- E2E tests use `review_patch()` which handles detection internally |

## Open Questions

1. **Pre-existing test failures (27)**
   - What we know: 27 tests fail in test_analysis.py, test_integration_patches.py, test_round_trip.py -- all pre-existing, unrelated to M4L
   - What's unclear: Whether these are expected or known issues
   - Recommendation: Ignore for this phase. Regression check should compare M4L test count only (189 existing + new E2E tests, all green).

## Sources

### Primary (HIGH confidence)
- `src/maxpat/project.py` -- create_m4l_project() signature and behavior
- `src/maxpat/m4l_polish.py` -- polish_m4l_device() pipeline, _classify_parameter keywords
- `src/maxpat/m4l_layout.py` -- layout_m4l_presentation(), DEVICE_HEIGHT=169, tab thresholds
- `src/maxpat/critics/__init__.py` -- review_patch() auto-detection flow
- `src/maxpat/m4l_export.py` -- write_amxd() reads from file path, not dict
- `src/maxpat/m4l_constants.py` -- AMXD header format constants
- `src/maxpat/critics/m4l_critic.py` -- all 6 check functions
- `tests/test_m4l_scaffold.py` -- _scaffold_and_load() pattern, mock pattern
- `tests/test_m4l_critic.py` -- _make_patch(), _make_m4l_patch() helpers
- `tests/test_m4l_export.py` -- _write_test_maxpat(), export helper pattern
- `tests/test_m4l_layout.py` -- _make_live_control(), _make_patch_with_controls()

### Secondary (MEDIUM confidence)
- None needed -- all information from codebase

### Tertiary (LOW confidence)
- None

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- pytest already in use, no new dependencies
- Architecture: HIGH -- all APIs verified from source code, test patterns extracted from existing files
- Pitfalls: HIGH -- discovered from reading actual source (write_amxd reads from file, global readout counter, mock paths)

**Research date:** 2026-04-07
**Valid until:** 2026-05-07 (stable -- internal test code, no external dependencies)
