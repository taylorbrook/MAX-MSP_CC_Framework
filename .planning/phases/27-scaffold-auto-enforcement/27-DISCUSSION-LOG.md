# Phase 27: Scaffold Auto-Enforcement - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md -- this log preserves the alternatives considered.

**Date:** 2026-04-08
**Phase:** 27-scaffold-auto-enforcement
**Areas discussed:** parameter_enable enforcement point, --- prefix enforcement scope, Idempotency and override behavior, Test strategy

---

## parameter_enable Enforcement Point

| Option | Description | Selected |
|--------|-------------|----------|
| Add to polish_m4l_device() | New pass in the existing polish pipeline: after derive_parameter_names, add ensure_parameter_enable(). Runs post-build, catches all live.* controls regardless of which agent created them. | ✓ |
| Enforce in Patcher.add_box() | Set parameter_enable=1 whenever a live.* object is added. Earlier in pipeline, but couples M4L logic into general Patcher API. | |
| You decide | Claude picks the best approach based on codebase patterns. | |

**User's choice:** Add to polish_m4l_device()
**Notes:** Consistent with existing polish pattern. Catches all controls regardless of creation path.

---

## --- Prefix Enforcement Scope

| Option | Description | Selected |
|--------|-------------|----------|
| Add to polish_m4l_device() | New pass: ensure_m4l_prefixes() in the polish pipeline. Supersedes Phase 21 D-04's scaffold-only rule. | ✓ |
| Keep scaffold-only, add critic warning | Don't auto-fix. Let m4l_critic flag missing prefixes so agents learn. Keeps D-04 intact. | |
| You decide | Claude picks based on Phase 27 requirements. | |

**User's choice:** Add to polish_m4l_device()
**Notes:** Supersedes D-04 from Phase 21. Polish catches everything agents missed.

---

## Idempotency and Override Behavior

| Option | Description | Selected |
|--------|-------------|----------|
| Fill gaps only | Only set parameter_enable=1 if currently 0 or missing. Only add --- prefix if not present. Same pattern as derive_parameter_names(). | ✓ |
| Always overwrite | Force parameter_enable=1 and --- prefix regardless. Guarantees correctness but could overwrite intentional choices. | |
| You decide | Claude picks based on existing polish patterns. | |

**User's choice:** Fill gaps only
**Notes:** Consistent with derive_parameter_names() pattern. Safe for re-runs.

---

## Test Strategy

| Option | Description | Selected |
|--------|-------------|----------|
| Unit + integration | Unit tests for both functions individually, plus integration test through full pipeline. | ✓ |
| Unit tests only | Test enforcement functions in isolation with mock patch dicts. | |
| You decide | Claude picks based on existing test patterns. | |

**User's choice:** Unit + integration
**Notes:** Full pipeline coverage ensures enforcement works end-to-end.

---

## Claude's Discretion

- Pass ordering within polish pipeline
- Default parameter_type and parameter_unitstyle values
- Object name extraction from box text

## Deferred Ideas

None -- discussion stayed within phase scope.
