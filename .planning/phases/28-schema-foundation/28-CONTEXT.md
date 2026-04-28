# Phase 28: Schema Foundation - Context

**Gathered:** 2026-04-27
**Status:** Ready for planning

<domain>
## Phase Boundary

Extend the object database with three typed first-class fields — `signal_role` (per-outlet), `domain_restricted` (per-object), `verified_installed` (per-object) — plus a back-compat shim that keeps every existing `outlet["signal"]` consumer working unchanged. Schema delta only. Population of the new fields across MSP objects is Phase 30; validators that read them are Phase 29.

**In scope:** schema additions in `overrides.json`, loader/validator/getter wiring in `src/maxpat/db_lookup.py`, three audit functions, regression-protective tests for the back-compat shim.

**Out of scope:** populating `signal_role` on objects beyond a minimal example/fixture set; adding new validators that read the schema (Phase 29); removing the `signal: bool` field anywhere (deferred to v6.0+); inlet roles or message-type taxonomy.

</domain>

<decisions>
## Implementation Decisions

### Back-Compat Derivation (signal_role ↔ signal:bool)
- **D-01:** **Write-through at load time.** After deep-merging overrides, the loader projects `signal_role` onto each outlet's `signal: bool` (`signal_role == "audio"` → `True`, every other role → `False`). The bool is materialized in the in-memory dict so existing direct readers (`patcher.py:250`, `dsp_critic.py:301`) need zero code changes.
- **D-02:** **Reverse derivation is honest, not lossy.** For outlets that have only the legacy `signal: bool` (no curated role), `get_signal_role(name, outlet)` returns `"audio"` when `signal: true` and `None` when `signal: false`. `None` means "not yet curated"; Phase 29's role-aware validators must treat `None` as "fall back to the boolean check, do not emit a role-mismatch error."
- **D-03:** **Single source of truth for curators is `signal_role`.** Curators add `signal_role` to overrides; the loader writes the corresponding `signal: bool`. They do NOT hand-edit both fields (avoids drift).
- **D-04:** **Six-value closed enum for `signal_role`:** `audio | trigger | status | float | data | list` (per SCHEMA-01). Loader fail-fasts at `_load()` on any unknown value, mirroring `_validate_variable_io_rules` (the quick-260421-b3a precedent).

### domain_restricted Shape
- **D-05:** **Whitelist semantic.** `domain_restricted: ["rnbo"]` means "this object is only legal in rnbo context." (Aligns with the success-criterion phrasing "to determine where it can legally appear.")
- **D-06:** **Closed enum:** `{rnbo, m4l, gen}`. Covers every restriction signaled in v5.0 requirements (`floor~`/RNBO, `live.*`/M4L, gen-codebox-only ops). Adding a new domain later = one-line enum extension. Loader fail-fasts on unknown values.
- **D-07:** **Absent = unrestricted.** When the field is absent on an object, `is_domain_restricted(name)` returns `False`. No tri-state ceremony for the default case.
- **D-08:** **Two getters:** `get_domain_restrictions(name) -> list[str]` returns the list (`[]` when absent or restricted-to-nothing — Phase 29 iterates this to emit `"object X is restricted to {rnbo}; not allowed at MSP top level"` errors). `is_domain_restricted(name)` is bool sugar for `bool(get_domain_restrictions(name))`.

### verified_installed Default
- **D-09:** **Tri-state, symmetric with signal_role.** `get_install_state(name) -> Optional[bool]`. Absent → `None` ("unaudited"); explicit `true` → `True` ("audited and present in `_pkg-source/`"); explicit `false` → `False` ("audited and known missing from this install").
- **D-10:** **`is_verified_installed(name)` collapses to `state is True`.** Returns `True` only when the object is explicitly verified. Any other state (including `None`) returns `False` — but Phase 29 must distinguish: it warns ONLY on explicit `False`, NOT on `None`. `None` is silent so the existing 2,015 absent-field objects don't generate a warning storm before Phase 30's audit lands.
- **D-11:** `[informational]` **Phase 30 coverage metric is "drive None count down."** The audit script classifies each absent-field object as a coverage gap; Phase 30 success is measured against shrinking that bucket, not against a verified/unverified ratio. Not a Phase 28 deliverable — recorded here so Phase 30 planning sees the locked metric definition.

### Audit Function Shape (SCHEMA-07)
- **D-12:** **Three focused functions, not one bloated dict.**
  - `audit_empty_io()` — unchanged shape `{critical, covered_by_override, variable_io_ok}`. Existing callers untouched.
  - `audit_install_coverage() -> {unaudited: [...], verified_false: [...]}` — surfaces objects with `verified_installed: False` and (separately) absent-field objects.
  - `audit_domain_coverage() -> {restricted_no_coverage: [...]}` — surfaces objects flagged `domain_restricted: ["X"]` whose canonical name does not appear in the `X` domain JSON (orphaned restriction → likely overrides typo or missing extraction).
- **D-13:** **No umbrella `audit()` wrapper this phase.** If Phase 30 wants a one-shot CLI entry point, it can compose the three. Keeps Phase 28 surface minimal.

### Storage Location
- **D-14:** **Overrides.json only.** All three new fields land in `overrides.json` first. Extracted per-domain JSONs stay pristine this phase. Future extraction passes (post-v5.0) may write `signal_role` directly, but that's not Phase 28 scope.

### Validation Strictness
- **D-15:** **Fail-fast at load** for unknown enum values across all three fields (signal_role enum, domain_restricted enum, non-bool `verified_installed`). Mirrors `_validate_variable_io_rules` precedent. The validation method should be a single `_validate_schema_extensions()` that walks the merged objects after deep-merge completes.

### Claude's Discretion
- Exact getter signatures (positional vs keyword args) — match existing `lookup()` style.
- Test fixture choice for back-compat coverage — pick 2–3 objects from `tests/conftest.py`'s existing fixture set; do not introduce new fixture files unless required.
- Where in `_load()` to invoke `_validate_schema_extensions()` — after overrides deep-merge, before audit caches build.

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Roadmap & Requirements (this milestone)
- `.planning/ROADMAP.md` §"Phase 28: Schema Foundation" — phase goal, success criteria, requirements list (SCHEMA-01..07).
- `.planning/REQUIREMENTS.md` §"Schema Foundation (Phase 28)" — the seven SCHEMA-* requirements verbatim, plus the Out-of-Scope list.
- `.planning/STATE.md` — milestone-level decisions (3-field scope cap; `signal: bool` retained as derived shim through v5.0).
- `.planning/PROJECT.md` §"Key Decisions" — JSON-per-domain rationale, override deep-merge pattern.

### Prior Phase Artifacts (the schema-loader precedent)
- `.planning/milestones/v4.0-phases/20-db-schema-foundation/20-02-PLAN.md` — Phase 20 plan establishing the per-package subdirectory loader, deep-merge pattern, and `allowed_packages` filter. The new schema fields piggyback on this same `_load()` machinery.
- `.planning/milestones/v4.0-phases/20-db-schema-foundation/20-01-SUMMARY.md` — package_info.json registry shape; analogous to how the new validation may want a small registry file.
- `.planning/milestones/v4.0-phases/20-db-schema-foundation/20-VERIFICATION.md` — verification format used for schema-foundation phases.

### Codebase Anchors (must read before editing)
- `src/maxpat/db_lookup.py` — the `ObjectDatabase` class. Key extension points:
  - `_load()` (line ~69) — where new fields are deep-merged onto objects.
  - `_validate_variable_io_rules()` (line ~141) — fail-fast precedent for `_validate_schema_extensions()`.
  - `lookup()` (line ~177) — keyword-only args style for new getters.
  - `audit_empty_io()` (line ~574) — sibling pattern for the two new audit functions.
- `.claude/max-objects/overrides.json` — current overrides shape; new fields nest at the same level as `inlets`/`outlets`/`_audit`.
- `src/maxpat/patcher.py:250` (`if outlet.get("signal"):`) — back-compat reader #1; verify untouched after write-through derivation lands.
- `src/maxpat/critics/dsp_critic.py:301` — back-compat reader #2; same.
- `tests/conftest.py` — `all_objects` and `objects_by_domain` fixtures; tests for the new schema layer onto these.

### Convention References
- `CLAUDE.md` §"How to Use the Database" — empty-I/O caveat, maxclass-not-authoritative caveat, `lookup_strict()` rationale. The new audit functions extend the same diagnostic family.

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- **`_validate_variable_io_rules()` (db_lookup.py:141)** — direct template for `_validate_schema_extensions()`. Same fail-fast posture, same per-object loop, same `ValueError` shape.
- **Overrides deep-merge loop (db_lookup.py:125–134)** — already iterates `overrides_data["objects"][name]` and writes each key onto `self._objects[name]`. New fields slot in for free; no merge-logic changes needed.
- **`_maybe_warn_empty_io` (db_lookup.py:241)** — the one-time-warning pattern. If we want lookup-time warnings on `verified_installed: False`, this is the template (Phase 29 will use it).
- **`audit_empty_io()` (db_lookup.py:574)** — exact sibling for the two new audit functions; same return-dict-of-sorted-lists shape.
- **`tests/test_package_schema.py`** (Phase 20) — class structure (`TestPackageObjectSchema`, `TestPackageInfoSchema`, `TestPackageAPI`) directly portable to a new `tests/test_schema_extensions.py`.

### Established Patterns
- **Fail-fast at load > silent fallback** (quick-260421-b3a). Every typo is a load-time `ValueError`, not a runtime mystery.
- **Keyword-only args on optional filters** (`lookup(name, *, allowed_packages=...)`). New getters should follow.
- **Aliases are resolved before lookup** (`canonical = self._aliases.get(name, name)`). Every new getter must do the same.
- **Per-outlet metadata lives in the outlet dict**, not the object dict (signal: bool already lives there). `signal_role` follows that pattern. `domain_restricted` and `verified_installed` are per-object.
- **`audit_*` functions return sorted lists keyed in a dict** — composable, deterministic, testable.

### Integration Points
- **No new files in `.claude/max-objects/`** this phase. Schema lives in the existing `overrides.json`.
- **No public API additions outside `db_lookup.py`** this phase. All new surface is on `ObjectDatabase`.
- **Existing 21 tests in `tests/test_object_schema.py` and friends MUST stay green** — back-compat is the primary verification anchor.

</code_context>

<specifics>
## Specific Ideas

- The exact PR/commit shape from Phase 20 Plan 02 is the right north star: one test file added (`tests/test_schema_extensions.py` with ≥15 tests), one source file modified (`db_lookup.py`), `tests/conftest.py` only touched if a new fixture is genuinely needed.
- A minimal example population (1 object per new field, in overrides.json) lands as a test fixture so the back-compat shim is verifiable end-to-end without waiting for Phase 30.
- The `signal_role` enum value `"data"` exists for objects like `buffer~`/`Data` outlets that emit non-audio sample-rate data; keep it in the enum even if Phase 28 doesn't populate any examples.
- Failure-mode test: an override with `signal_role: "frobnitz"` MUST raise `ValueError` at `ObjectDatabase()` construction. Same for `domain_restricted: ["rbno"]` (typo of `rnbo`) and `verified_installed: "yes"` (string instead of bool).

</specifics>

<deferred>
## Deferred Ideas

- **Inlet `signal_role`** — symmetric concept for inlets. Out of scope; v5.0 explicitly capped at outlet roles. Reconsider in v6.0+ alongside `signal: bool` removal.
- **Message-type taxonomy** — typing the `messages: [...]` list. Out of scope; same v6.0+ window.
- **Population of `signal_role` across non-MSP domains** (Max, Jitter, MC) — Phase 30 is MSP-only by design. Other domains stay on the boolean shim indefinitely.
- **Auto-extraction of `verified_installed`** by diffing the loaded DB against `_pkg-source/` directory contents — would be a nice CLI in Phase 30 or post-v5.0. Not this phase.
- **Umbrella `audit()` wrapper** — could be added in Phase 30 or via a quick task once the three sub-audits prove their shape.
- **Removing the `signal: bool` field** — explicitly v6.0+ work; back-compat shim is permanent through v5.0.

</deferred>

---

*Phase: 28-schema-foundation*
*Context gathered: 2026-04-27*
</content>
</invoke>