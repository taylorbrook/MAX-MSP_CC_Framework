# Phase 27: Scaffold Auto-Enforcement - Context

**Gathered:** 2026-04-08
**Status:** Ready for planning

<domain>
## Phase Boundary

Add code automation for `parameter_enable` and `---` prefix so M4L scaffold requirements are satisfied by code, not just agent instructions. `create_m4l_project()` or `polish_m4l_device()` auto-sets `parameter_enable=1` with `saved_attribute_attributes` on all `live.*` UI controls, and named objects auto-prefixed with `---` in M4L context. Closes SCAFFOLD-04 and SCAFFOLD-05 gaps from v3.0-MILESTONE-AUDIT.md.

</domain>

<decisions>
## Implementation Decisions

### parameter_enable Enforcement Point
- **D-01:** Add `ensure_parameter_enable()` as a new pass inside `polish_m4l_device()`. Runs post-build, catches all `live.*` controls regardless of which agent created them. Consistent with existing polish pipeline pattern (derive_parameter_names -> organize_push_banks -> populate_info_text).
- **D-02:** `ensure_parameter_enable()` sets `parameter_enable=1` and creates `saved_attribute_attributes.valueof` with required fields (parameter_type, parameter_unitstyle) on any `live.*` control that lacks them. Excludes objects in the `_NON_PARAMETER_LIVE` set already defined in m4l_critic.py (live.thisdevice, live.banks, etc.).

### --- Prefix Enforcement Scope
- **D-03:** Add `ensure_m4l_prefixes()` as a new pass inside `polish_m4l_device()`. Scans all named objects (buffer~, coll, dict, send, receive, send~, receive~, value) and adds `---` prefix if missing. This supersedes Phase 21 D-04's scaffold-only limitation -- polish now catches everything agents missed.
- **D-04:** Prefix enforcement targets objects whose first argument is a name (not `#1` substitution or empty). The `---` prefix is prepended to the name in the box text.

### Idempotency and Override Behavior
- **D-05:** Fill gaps only -- never overwrite existing values. Only set `parameter_enable=1` if currently 0 or missing. Only add `---` prefix if not already present. Follows the same pattern as `derive_parameter_names()` which never overrides existing non-empty values. Safe for re-runs and idempotent.

### Test Strategy
- **D-06:** Unit tests for `ensure_parameter_enable()` and `ensure_m4l_prefixes()` individually with mock patch dicts covering: controls missing parameter_enable, controls already correct (idempotency), non-parameter live objects excluded, named objects without prefix, named objects already prefixed.
- **D-07:** Integration test: `create_m4l_project()` -> add `live.*` controls programmatically -> `polish_m4l_device()` -> verify `parameter_enable=1` and `---` prefix on all applicable objects in the output.

### Claude's Discretion
- Exact ordering of ensure_parameter_enable() and ensure_m4l_prefixes() within the polish pipeline (before or after existing passes)
- Default values for parameter_type and parameter_unitstyle when creating saved_attribute_attributes
- How to extract the object name from box text for prefix detection (splitting on spaces, handling edge cases)

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Enforcement Implementation
- `src/maxpat/m4l_polish.py` -- Existing polish pipeline: derive_parameter_names(), organize_push_banks(), populate_info_text(), polish_m4l_device(). New passes go here.
- `src/maxpat/critics/m4l_critic.py` -- `_NON_PARAMETER_LIVE` set (line 26) defines which live.* objects should NOT require parameter_enable. Enforcement must use the same exclusion list.
- `src/maxpat/m4l_constants.py` -- ParamType, UnitStyle enums for saved_attribute_attributes defaults.

### Scaffold Context
- `src/maxpat/project.py` -- `create_m4l_project()` function (line 99). Scaffold creates live.thisdevice but no live.* controls -- enforcement is in polish, not scaffold.
- `src/maxpat/patcher.py` -- `add_box()` sets `parameter_enable=0` as default (line 321, 643). Polish overrides this.

### Reference Device
- `patches/kicksynth/generated/kicksynth-m4l.maxpat` -- Ground-truth M4L device showing correct parameter_enable and saved_attribute_attributes structure.

### Requirements
- `.planning/REQUIREMENTS.md` -- SCAFFOLD-04 (parameter_enable auto-set), SCAFFOLD-05 (--- prefix auto-set)

### Prior Phase Context
- `.planning/phases/21-scaffold-and-routing/21-CONTEXT.md` -- D-04 (--- prefix at scaffold-time only) is superseded by D-03 above.

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `_collect_live_controls()` in m4l_polish.py -- Already iterates all live.* boxes in a patch. Reuse for ensure_parameter_enable().
- `_NON_PARAMETER_LIVE` set in m4l_critic.py -- Exclusion list for objects that shouldn't get parameter_enable. Import or duplicate for enforcement.
- `polish_m4l_device()` compositor -- Already chains 3 passes. Adding 2 more is the established pattern.

### Established Patterns
- Polish passes mutate patch_dict in place and return it (same function signature for all passes)
- `derive_parameter_names()` fills gaps only -- never overrides existing non-empty values. New passes follow this pattern.
- `saved_attribute_attributes.valueof` is the standard nested structure for parameter metadata

### Integration Points
- `polish_m4l_device()` is the single entry point called by agents after build. Adding passes here means all M4L devices automatically get enforcement.
- `m4l_critic.py` already checks for missing parameter_enable -- after enforcement, critic warnings for these should drop to zero.

</code_context>

<specifics>
## Specific Ideas

No specific requirements -- open to standard approaches.

</specifics>

<deferred>
## Deferred Ideas

None -- discussion stayed within phase scope.

</deferred>

---

*Phase: 27-scaffold-auto-enforcement*
*Context gathered: 2026-04-08*
