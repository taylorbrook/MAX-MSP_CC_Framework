# Phase 25: Testing - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md -- this log preserves the alternatives considered.

**Date:** 2026-04-07
**Phase:** 25-testing
**Areas discussed:** Pipeline integration depth, Test device complexity, Violation test strategy, Test file organization

---

## Pipeline Integration Depth

| Option | Description | Selected |
|--------|-------------|----------|
| Full pipeline per device type | Each test runs scaffold->add controls->polish->layout->critic->export. 3 tests minimum. | :heavy_check_mark: |
| Stage-pair integration tests | Test adjacent stages in pairs. More granular but less true E2E. | |
| Single golden-path test | One comprehensive audio_effect test. Fastest, least coverage. | |

**User's choice:** Full pipeline per device type

| Option | Description | Selected |
|--------|-------------|----------|
| Final output only | Assert on final .amxd and critic results only. | |
| Assert at each stage | Check state after every pipeline step. | |
| Final + key checkpoints | Final output plus 1-2 critical intermediate checks. | :heavy_check_mark: |

**User's choice:** Final + key checkpoints (post-scaffold required objects, post-critic no blockers)

---

## Test Device Complexity

| Option | Description | Selected |
|--------|-------------|----------|
| Moderate (4-6 controls) | Enough for grouping and layout without being slow. | |
| Minimal (1-2 controls) | Fastest, may miss integration bugs. | |
| Realistic (8-12 controls) | Full complexity with groups, tabs, overlays, Push banks. | :heavy_check_mark: |

**User's choice:** Realistic (8-12 controls)

---

## Violation Test Strategy

| Option | Description | Selected |
|--------|-------------|----------|
| Pipeline-level violation tests | Build broken devices through full pipeline, verify critic catches in context. | |
| Rely on existing unit tests | 34 unit tests already cover violations. E2E only tests valid devices. | |
| Both levels | Keep unit tests AND add E2E violation tests. | :heavy_check_mark: |

**User's choice:** Both levels -- existing unit tests stay, new E2E tests add pipeline-level violation coverage.

---

## Test File Organization

**User's choice:** Claude's discretion -- pick organization based on final test count.

---

## Claude's Discretion

- File organization (single vs split)
- Control configurations per device type fixture
- Helper function structure
- Shared fixtures vs per-test setup

## Deferred Ideas

None -- discussion stayed within phase scope
