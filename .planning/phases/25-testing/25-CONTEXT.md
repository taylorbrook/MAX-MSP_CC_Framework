# Phase 25: Testing - Context

**Gathered:** 2026-04-07
**Status:** Ready for planning

<domain>
## Phase Boundary

End-to-end M4L workflow test suite validates the complete device creation pipeline from scaffold through export. Adds integration tests that exercise the full pipeline (scaffold->polish->layout->critic->export) as a connected flow, layering on top of existing unit tests per module.

</domain>

<decisions>
## Implementation Decisions

### Pipeline Integration
- **D-01:** Full pipeline per device type -- each E2E test creates a scaffold, adds controls programmatically, runs polish->layout->critic->export in sequence. Minimum 3 tests (audio_effect, instrument, midi_effect).
- **D-02:** Assert on final output plus key checkpoints -- verify final .amxd validity and critic results, plus intermediate checks at post-scaffold (required objects present) and post-critic (no blockers on valid devices).

### Test Device Complexity
- **D-03:** Realistic devices with 8-12 controls per test fixture. Enough to exercise grouping, Push banks, layout columns, tab triggers, and overlay patterns. Each device type gets a distinct control set appropriate to its purpose (e.g., instrument gets pitch/amp/filter groups, audio_effect gets input/output/effect groups).

### Violation Test Strategy
- **D-04:** Both unit and E2E violation coverage. Existing test_m4l_critic.py unit tests stay untouched. New E2E tests build intentionally broken devices through the full pipeline and verify critic catches violations in context (gain~->plugout~, missing parameter_enable, duplicate longnames).

### Test File Organization

### Claude's Discretion
- File organization -- single file vs split, based on final test count
- Specific control configurations for each device type fixture
- Helper function structure for building test devices
- Whether to use shared fixtures or per-test setup

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### M4L Pipeline Modules (test targets)
- `src/maxpat/project.py` -- create_m4l_project() scaffold function
- `src/maxpat/m4l_polish.py` -- polish_m4l_device() parameter naming, Push banks, info text
- `src/maxpat/m4l_layout.py` -- Presentation mode layout engine
- `src/maxpat/critics/m4l_critic.py` -- M4L critic with device completeness, gain~/plugout~ rule, parameter validation
- `src/maxpat/m4l_export.py` -- write_amxd() binary export
- `src/maxpat/m4l_constants.py` -- AMXD header constants, ParamType, UnitStyle enums

### Existing Unit Tests (do not duplicate)
- `tests/test_m4l_scaffold.py` -- 270 lines, scaffold creation per device type
- `tests/test_m4l_critic.py` -- 794 lines, 34 tests for individual critic checks
- `tests/test_m4l_export.py` -- 213 lines, binary header validation
- `tests/test_m4l_polish.py` -- 733 lines, parameter naming/Push bank tests
- `tests/test_m4l_layout.py` -- 1,403 lines, presentation layout tests

### Success Criteria
- `REQUIREMENTS.md` TEST-01 -- E2E tests create M4L devices of each type and validate all required components

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `test_m4l_scaffold.py:_scaffold_and_load()` -- Helper that scaffolds a device and returns (patch_dict, project_dir). Pattern to follow for E2E fixture setup.
- `test_m4l_export.py:_write_test_maxpat()` -- Helper that writes minimal .maxpat JSON. E2E tests will need a richer version with actual controls.
- `src/maxpat/m4l_constants.py` -- AMXD_HEADER_FORMAT, AMXD_TYPE_* constants for binary validation.

### Established Patterns
- All M4L tests mock `auto_commit_patch` to avoid git commits during tests
- Tests use pytest `tmp_path` fixture for isolated file I/O
- Critic tests build patch dicts in-memory and call critic functions directly
- Device type detection uses `detect_device_type()` from `m4l_detection.py`

### Integration Points
- E2E tests will call: `create_m4l_project()` -> manually add controls to patch dict -> `polish_m4l_device()` -> layout functions -> `review_patch()` (critic) -> `write_amxd()`
- `critics/__init__.py:review_patch()` auto-detects M4L devices and runs M4L critic -- E2E tests should use this entry point, not call M4L critic directly

</code_context>

<specifics>
## Specific Ideas

No specific requirements -- open to standard approaches

</specifics>

<deferred>
## Deferred Ideas

None -- discussion stayed within phase scope

</deferred>

---

*Phase: 25-testing*
*Context gathered: 2026-04-07*
