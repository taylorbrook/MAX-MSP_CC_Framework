# Phase 29: Validator Depth - Context

**Gathered:** 2026-04-28
**Status:** Ready for planning

<domain>
## Phase Boundary

Validators consume the Phase 28 schema (`signal_role`, `domain_restricted`, `verified_installed`) to produce specific, actionable errors instead of generic type-mismatch warnings. External `.gendsp` files (and embedded gen~ codeboxes) get the same DSP rigor: declaration ordering already covered, plus three new error-level checks (`delay()` rejection, init-before-if/else, `clip()` rejection).

**In scope:**
- Layer 3 connection validator: role-aware errors with suggestion-driven severity tiering, dispatched ahead of the legacy signal:bool check.
- Layer 4 `_validate_domain_restrictions` guard: top-level-only scope, fires only on objects with explicit `domain_restricted` annotations.
- `db.lookup()` install-state warning: once-per-name cached `UserWarning` with suggestion line, mirrors `_maybe_warn_empty_io`.
- `validate_genexpr` extended with three ERROR-level checks (`delay()`, init-before-if/else, `clip()`).
- Embedded gen~ codeboxes inside `.maxpat` files wired to `validate_genexpr` so the new checks fire on both `.gendsp` and embedded code paths.
- Tests covering each new check family at error/warning severity boundary.

**Out of scope:**
- Populating `signal_role`, `domain_restricted`, `verified_installed` across MSP objects (Phase 30).
- Inferring restrictions from canonical domain (`rnbo/objects.json` membership) — explicit annotations only.
- Recursive scope tracking inside subpatchers / nested rnbo~ — top-level only.
- Patcher API construction-time blocks (the "defense-in-depth" alternative); Layer 4 is the single enforcement point.
- Inlet-side roles (Phase 28 deferred to v6.0+); destination-side classification stays as "signal vs control-rate".
- Promoting structure-critic warnings to blockers (Phase 33, optional).
- New umbrella `audit()` wrapper (locked out by Phase 28 D-13).

</domain>

<decisions>
## Implementation Decisions

### Role-Mismatch Action Tiering (VALID-01, VALID-05)
- **D-01:** **Tiered by mismatch class with suggestion-driven severity.** When `get_signal_role(src, outlet)` returns a non-None role and the destination inlet's role expectation conflicts, emit by tier:
  - **ERROR + auto-remove** when the canonical fix is mechanical:
    - `status` → signal-only inlet → `"use snapshot~"` (status outlet feeding signal expecting object)
    - `trigger` → signal-only inlet → `"use sig~ or click~"` (trigger feeding audio rate)
    - `data` → signal-only inlet → role mismatch, no clean fix (still reject)
    - `list` → signal-only inlet → role mismatch, no clean fix (still reject)
  - **WARNING + preserve connection** when intent is judgment-laden:
    - `trigger` → float inlet → `"trigger feeding float; user may intend bang counting"`
    - `list` → float inlet → `"list outlet feeding float; bach.* often does this — verify"`
  - **Silent (no finding)** when CLAUDE.md already permits:
    - `float` → signal inlet → signal/float inlets accept both (per CLAUDE.md)
    - `audio` → signal inlet → existing legacy behavior (no change)
- **D-02:** **Role check runs FIRST, falls through to legacy on `None`.** When `get_signal_role(src, outlet)` returns a non-None role, run the role-aware tier check and skip the legacy `signal:bool` check for that connection. When it returns `None` (unaudited per Phase 28 D-02), fall through to the existing `signal:bool` check unchanged. Clean separation; legacy is a fallback path; no double-emission.
- **D-03:** **Auto-remove keeps `auto_fixed=True` for ERROR tier.** Consistent with current Layer 3 signal→control posture. WARNING tier never removes — sets `auto_fixed=False` and preserves the line.
- **D-04:** **Error message format is `"{src_role} outlet → {dst_kind} inlet: {suggestion}"`.** Concrete, role-named, suggestion-bearing. No generic "type mismatch" language. Examples: `"status outlet → signal inlet: use snapshot~"`, `"trigger outlet → float inlet: trigger feeding float; user may intend bang counting"`.

### Domain-Restricted Guard (VALID-02, VALID-05)
- **D-05:** **Explicit `domain_restricted` only — no canonical-domain inference.** Hard-block fires only on objects whose `db.is_domain_restricted(name)` returns `True` (i.e., have an explicit `domain_restricted: ["rnbo"|"m4l"|"gen"]` entry in overrides.json). No inference from the object's `domain` field. Predictable, fail-closed, zero false positives. Phase 30 expands coverage by adding annotations.
- **D-06:** **New Layer 4 check `_validate_domain_restrictions` in validation.py.** Sibling to `_validate_domain_rules` (line 582). Runs after Layer 3, walks `patch_dict["patcher"]["boxes"]` (top level only), checks `db.get_domain_restrictions(name)` for each, emits `ValidationResult("domain", "error", ...)` if the box is at top level and not allowed there. No Patcher API hook; no construction-time fast-fail; Layer 4 is the single enforcement point.
- **D-07:** **Top-level scope only.** Do NOT recurse into subpatchers or rnbo~ inner patchers. A domain-restricted object is illegal iff it appears in `patch_dict["patcher"]["boxes"]` at the outer level. Catches the canonical violation (`floor~` at MSP top level outside an `rnbo~` container) and stays simple. The "user nests `floor~` inside a `p subpatcher` outside any `rnbo~`" edge case is considered niche and explicitly out of scope.
- **D-08:** **Always ERROR severity, never auto-fixed.** Domain restrictions are correctness violations (object cannot legally appear here); auto-removing the BOX would mangle the patch. Emit error, leave the box, let the caller decide.

### Install-State Warning (VALID-03, VALID-05)
- **D-09:** **`db.lookup()` once-per-name with cached suppression.** Mirror `_maybe_warn_empty_io` exactly: emit `warnings.warn(...)` from `lookup()` the first time a `verified_installed: false` object is queried, cache the canonical name in a new `_install_warned: set[str]`, never warn again that process. Lookup-time per the requirement's literal phrasing.
- **D-10:** **Phase 28 D-10 reaffirmed: warn ONLY on explicit `False`.** `None` (unaudited, default) stays silent. Avoids the "warning storm before Phase 30 lands" failure mode that motivated D-10.
- **D-11:** **Match empty-IO message shape + suggestion line.** `warnings.warn(f"{name} marked verified_installed: false — not present in this install. Run package extraction or remove from overrides.json if intentional.", UserWarning, stacklevel=4)`. Same `UserWarning` category as the empty-IO warning (no new subclass this phase). Same `stacklevel=4`. Callers that want to silence install/IO noise can filter both with a single `warnings.filterwarnings("ignore", category=UserWarning, module="db_lookup")`.
- **D-12:** **No ValidationResult emission for install-state.** The `db.lookup()` warning IS the surface. `validate_patch()` does NOT add a per-box install warning — that would create a second redundant channel. Single channel, single audience.

### .gendsp / Embedded Codebox Validation (VALID-04, VALID-05)
- **D-13:** **Extend `validate_genexpr` in code_validation.py with three new ERROR-level checks.** Single entry point covers both `.gendsp` files (already routed via `hooks.validate_code_file`) and embedded codeboxes (newly wired this phase). New checks become Check 7, 8, 9 alongside existing checks 1–6. No new module, no `review_gendsp` parallel function.
- **D-14:** **Check 7: `delay()` rejection.** Pattern-match on `\bdelay\s*\(` outside comments → ERROR `"delay() is not supported in GenExpr codebox; use Delay.read/write (declare Delay myDelay(max_samples) first)"`. Compile-fatal in MAX, so ERROR.
- **D-15:** **Check 8: `clip()` rejection.** Pattern-match on `\bclip\s*\(` outside comments → ERROR `"clip() does not exist in expr/GenExpr; use min(max(x, lo), hi)"`. Compile-fatal, so ERROR.
- **D-16:** **Check 9: init-before-if/else.** Light flow analysis: scan if/else blocks; for each variable assigned inside the block, verify the same name is assigned at least once before the block (or declared via `Param`/`History`). If not → ERROR `"variable '{name}' used inside if/else without prior init; GenExpr errors with 'not defined'"`. Skip names declared via `Param`/`History`/`Delay`/`Buffer`/`Data`. Accepts some false-positives on shadowed names — D-19 lists the documented limitations.
- **D-17:** **Wire embedded gen~ codeboxes to `validate_genexpr` in this phase.** Add a new call site (likely from `validate_patch()` Layer 5, or a new sibling) that walks every gen~ box's embedded `patcher`, finds boxes with `maxclass: "codebox"` and a `code` attribute, and runs `validate_genexpr` on each `code` string. Emits ValidationResult findings with `layer="code"` (existing convention). VALID-04 parity is achieved in BOTH directions — `.gendsp` files and embedded codeboxes get the same checks.

### Severity Vocabulary & Two-Channel Contract (VALID-05)
- **D-18:** **Keep two existing vocabularies — do not unify.** `ValidationResult.level ∈ {error, warning, info, fixed}` for `validate_patch()` outputs. `CriticResult.severity ∈ {blocker, warning, note}` for `review_dsp` and friends. VALID-05 requires "every finding distinguishes error/warning across all four new check families" — this is satisfied by the per-decision severity assignments above (D-01, D-08, D-09 W, D-14/15/16 E). No unification work this phase; out of scope.
- **D-19:** **Per-family severity table** (exactly what callers can grep on):
  | Family | ERROR | WARNING |
  |---|---|---|
  | Role mismatch (Layer 3) | status/trigger/data/list → signal-only inlet | trigger/list → float inlet |
  | Domain restriction (Layer 4) | always (per D-08) | n/a |
  | Install state (db.lookup) | n/a | always when `verified_installed: false` (per D-09) |
  | GenExpr (.gendsp + embedded) | `delay()`, `clip()`, init-before-if/else, declaration ordering (existing) | missing semicolon (existing), Param missing min/max (existing) |
- **D-20:** **Init-before-if/else known limitations (documented, accepted):** The Check 9 implementation does NOT do full scope analysis. Documented false-positive cases that are acceptable for v5.0:
  - Variables shadowed by an inner declaration may still flag (rare in DSP code).
  - Variables initialized via complex destructuring (multi-return calls) may not be detected as "initialized."
  Both are noted in the suggestion line: `"...if this is a false positive, restructure to assign before the if/else."`

### Claude's Discretion
- **Tier-table location** — inline dict in `validation.py` near `_validate_connections`, OR module-level `_ROLE_TIER_TABLE` constant. Either works; pick whichever survives diff review better.
- **Test fixture choices** — pick 2–3 objects from existing fixtures plus add 1 explicit `verified_installed: false` example (e.g., `bach.llll2list` from existing memory) and 1 `domain_restricted: ["rnbo"]` example (e.g., `floor~`). Re-use Phase 28's `tests/test_schema_extensions.py` fixture pattern.
- **Exact `_install_warned` placement** — instance set on `ObjectDatabase`, sibling to `_empty_io_warned`. Reset behavior in tests via `db._install_warned.clear()` if needed.
- **Where the embedded-codebox walker lives** — new private function in `validation.py` (e.g., `_validate_embedded_genexpr`) called from `validate_patch()` after Layer 4. Alternative: extend `dsp_critic.review_dsp()`. Validation.py is preferred because findings flow through the `ValidationResult` pipeline (consistent with `.gendsp` going through `hooks.validate_code_file`).
- **Whether to emit a single warning or many on init-before-if/else** — first-error-and-stop is fine (matches Check 5's `break` posture).
- **Embedded codebox walker recursion** — gen~ patchers can themselves contain nested gen~ subpatchers; recurse vs flat is up to the planner.

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Roadmap & Requirements (this milestone)
- `.planning/ROADMAP.md` §"Phase 29: Validator Depth" — phase goal, success criteria, requirements list (VALID-01..05).
- `.planning/REQUIREMENTS.md` §"Validator Depth (Phase 29)" — the five VALID-* requirements verbatim.
- `.planning/STATE.md` — milestone-level decisions for v5.0 (3-field scope cap, `signal: bool` derived shim through v5.0).
- `.planning/PROJECT.md` §"Key Decisions" — JSON-per-domain rationale, override deep-merge pattern.

### Prior Phase Artifacts (the schema this phase consumes)
- `.planning/phases/28-schema-foundation/28-CONTEXT.md` — Phase 28 locked decisions, especially:
  - **D-02:** `get_signal_role()` returning `None` = "unaudited" → role validators MUST fall back to boolean check, not emit role-mismatch error.
  - **D-10:** Install warnings fire ONLY on explicit `verified_installed: False`, never on `None`.
  - **D-13:** No umbrella `audit()` wrapper this milestone.
- `.planning/phases/28-schema-foundation/28-VERIFICATION.md` — Phase 28 acceptance evidence (getter signatures, audit shapes).
- `.planning/phases/28-schema-foundation/28-01-SUMMARY.md` — schema validation infrastructure (enums + fail-fast validator + signal_role write-through).
- `.planning/phases/28-schema-foundation/28-02-SUMMARY.md` — five getter methods landed (`get_signal_role`, `get_install_state`, `is_verified_installed`, `get_domain_restrictions`, `is_domain_restricted`).
- `.planning/phases/28-schema-foundation/28-03-SUMMARY.md` — three audit functions + test fixtures + ≥15 tests pattern.

### Codebase Anchors (must read before editing)
- `src/maxpat/db_lookup.py` — `ObjectDatabase` class. Key extension points:
  - `lookup()` (line ~177) — add the `_install_warned` once-per-name warning here, mirroring `_maybe_warn_empty_io`.
  - `_maybe_warn_empty_io()` (line ~377) — exact template for `_maybe_warn_install_state` (or inline equivalent).
  - `get_signal_role()` (line ~553), `is_domain_restricted()` (line ~627), `get_install_state()` (line ~587) — getters from Phase 28; consume these in Phase 29.
- `src/maxpat/validation.py` — Layer architecture:
  - `validate_patch()` (line ~84) — orchestration; new Layer 4 check slots in alongside `_validate_domain_rules`.
  - `_validate_connections()` (line ~420) — the role-aware tier dispatch lives here.
  - `_inlet_accepts_signal()` (line ~543) — current legacy fallback path; keep unchanged when role is None.
  - `_validate_domain_rules()` (line ~582) — sibling pattern for new `_validate_domain_restrictions`.
- `src/maxpat/code_validation.py` — GenExpr validation:
  - `validate_genexpr()` (line ~40) — extend with Check 7 (`delay()`), Check 8 (`clip()`), Check 9 (init-before-if/else) at ERROR severity.
  - Existing Check 5 (declaration ordering, line ~128) — exact severity precedent for the new ERROR checks.
- `src/maxpat/critics/dsp_critic.py:review_dsp()` — keep separate; do NOT add genexpr-syntax checks here. `dsp_critic` stays focused on semantic DSP review (gen~ I/O match, gain staging, audio-rate consistency).
- `src/maxpat/critics/base.py:CriticResult` — severity vocab `{blocker, warning, note}`. NOT changed in this phase (D-18).
- `src/maxpat/hooks.py:validate_code_file()` (line ~273) — already routes `.gendsp` → `validate_genexpr`; the three new checks land via this same route automatically.
- `tests/conftest.py` — `all_objects`, `objects_by_domain`, schema-extension fixtures from Phase 28.
- `tests/test_schema_extensions.py` — class structure and fixture conventions to mirror for new tests.
- `tests/test_validation.py` — Layer 3 / Layer 4 test conventions; new tests slot in here for connection role-mismatch + domain-restricted guard.
- `tests/test_code_validation.py` (if present; else `tests/test_critics.py`) — new GenExpr Check 7/8/9 tests.

### Convention References
- `CLAUDE.md` §"How to Use the Database" — `lookup_strict()` rationale, empty-IO caveat. The new install warning extends the same diagnostic family.
- `CLAUDE.md` §"Domain-Specific Rules → MSP" — `floor~` is RNBO-only; `expr` has no `clip()`; `delay()` not supported in GenExpr codebox. Authoritative source for the three new error messages.
- `CLAUDE.md` §"Domain-Specific Rules → Gen~ (GenExpr DSP Code)" — Delay.read/write, declaration ordering, init-before-if/else rationale.
- `~/.claude/projects/-Users-taylorbrook-Dev-MAX/memory/feedback_floor_tilde_rnbo.md` — empirical evidence for `floor~` RNBO-only restriction.
- `~/.claude/projects/-Users-taylorbrook-Dev-MAX/memory/feedback_expr_no_clip.md` — empirical evidence for `clip()` rejection.
- `~/.claude/projects/-Users-taylorbrook-Dev-MAX/memory/feedback_genexpr_delay_syntax.md` — empirical evidence for `delay()` rejection + init-before-if/else.

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- **`_maybe_warn_empty_io` (db_lookup.py:377)** — exact template for the `_install_warned` once-per-name pattern. Same `UserWarning`, same `stacklevel=4`, same `set[str]` cache pattern. Sibling implementation differs only in the trigger condition (`get_install_state(name) is False` instead of empty I/O).
- **`_validate_domain_rules` (validation.py:582)** — direct template for `_validate_domain_restrictions`. Same per-box loop, same `ValidationResult("domain", "error", ...)` shape, same lookup pattern.
- **`_validate_connections` (validation.py:420)** — role-aware tier dispatch grafts onto the existing signal-source branch (line ~505). The new code reads `db.get_signal_role(src_name, src_outlet)`; when non-None, runs tier dispatch instead of falling through to `_inlet_accepts_signal`.
- **`validate_genexpr` Check 5 (code_validation.py:128)** — declaration-ordering check is the precedent for ERROR-level pattern-match checks. Checks 7/8/9 follow the same shape (regex on lines + ValidationResult).
- **`hooks.validate_code_file` (hooks.py:273)** — already routes `.gendsp` files to `validate_genexpr`. No changes needed here; the three new checks fire automatically via the existing call site.
- **Phase 28's `tests/test_schema_extensions.py`** — class structure (`TestSchemaValidation`, `TestSchemaGetters`, `TestAuditFunctions`) is the template for new `TestRoleAwareValidation`, `TestDomainGuard`, `TestInstallWarning`, `TestGenExprChecks` classes.

### Established Patterns
- **Fail-fast at load > silent fallback** (Phase 28 precedent). Same posture for runtime: when role data exists, USE it; when absent, fall through deterministically.
- **Once-per-name cached warnings** (`_empty_io_warned` set + `stacklevel=4`). New `_install_warned` follows.
- **Auto-fix only when fix is unambiguous.** Layer 3 already auto-removes obvious signal→control mismatches. Role-aware tier extends this; auto-removes only the ERROR tier (unambiguous fix), preserves WARNING tier (ambiguous intent).
- **Severity vocabulary stays per-subsystem.** `ValidationResult.level` for validation.py; `CriticResult.severity` for critics. No unification work this phase.
- **Top-level-only scope detection.** Cheaper than recursion, catches the high-value cases. Recursion explicitly deferred (Phase 30+ if real cases emerge).

### Integration Points
- **No new files in `src/maxpat/`** unless the planner determines `_validate_embedded_genexpr` deserves its own helper module. Default: live inside validation.py.
- **No new files in `.claude/max-objects/`** — schema lives in existing `overrides.json`, fixtures in tests.
- **No public API additions outside the existing pipeline.** All new surface is on `ObjectDatabase.lookup()` (warning), `validate_patch()` (Layer 4 + embedded-codebox walk), `validate_genexpr` (Checks 7-9). No new top-level exports.
- **Existing 21+ tests in test_validation.py and test_code_validation.py MUST stay green.** Back-compat via `signal:bool` derivation (Phase 28 D-01) is the primary regression anchor — the role-first-then-fallback ordering (D-02) preserves all current connection-removal behavior for unannotated objects.
- **`hooks.validate_code_file` is the public `.gendsp` entry point.** Test it end-to-end with a fixture `.gendsp` containing `delay(`, `clip(`, and an init-before-if/else case.

</code_context>

<specifics>
## Specific Ideas

- The error message format `"{src_role} outlet → {dst_kind} inlet: {suggestion}"` is the literal canonical shape — it matches the language in VALID-01 ("status outlet → signal inlet (use snapshot~)") and the discussion's role-pair examples.
- `_install_warned` set name follows the existing `_empty_io_warned` precedent (private, instance-level, plain `set[str]`).
- The three GenExpr ERROR checks should reuse the existing `_DECL_PREFIXES` set (`code_validation.py:129`) so `Param`/`History`/`Delay`/`Buffer`/`Data` names are exempt from Check 9.
- `floor~` and `bach.llll2list` are the canonical test fixtures (the former for domain-restricted ERROR, the latter for install-state WARNING). Both are referenced in user feedback memories and known-good empirical evidence.
- Init-before-if/else Check 9 is allowed to use a simple regex-based scan (look for assignments inside `if {...}` blocks, then check whether the assigned name appears in any previous line's LHS or in a `Param`/`History` declaration). Documented limitations (D-20) are acceptable.

</specifics>

<deferred>
## Deferred Ideas

- **Canonical-domain inference for `domain_restricted`** (every object in `rnbo/objects.json` auto-flagged outside rnbo~) — explicit-only this phase per D-05; revisit in Phase 30+ if explicit annotations prove too sparse.
- **Recursive scope tracking inside subpatchers / nested rnbo~** — top-level only this phase per D-07; revisit in Phase 30+ if real-world misuse emerges.
- **Patcher API construction-time fast-fail for domain-restricted objects** — Layer 4 only this phase per D-06; defense-in-depth approach deferred unless a regression case shows late-detection cost.
- **Validation `InstallWarning` subclass** for filterable warning categories — re-use existing `UserWarning` this phase per D-11; create a subclass only when tooling explicitly needs to filter install warnings independently.
- **`validate_patch()` per-box install-state ValidationResult** — `db.lookup()` warning is the single channel per D-12; revisit if downstream tools need machine-readable install findings.
- **Severity vocabulary unification** between `ValidationResult.level` and `CriticResult.severity` — out of scope per D-18; v6.0+ if at all.
- **Promoting structure-critic warnings to ERROR/blocker** — Phase 33 (optional, judgment call after Phase 29 evidence).
- **Per-inlet `signal_role`** — Phase 28 explicitly capped at outlet roles; v6.0+.
- **Full scope analysis for init-before-if/else** (proper AST or scope-tracking parser) — light flow analysis with documented false-positive limitations is acceptable per D-20; revisit if false-positives prove disruptive.

</deferred>

---

*Phase: 29-validator-depth*
*Context gathered: 2026-04-28*
