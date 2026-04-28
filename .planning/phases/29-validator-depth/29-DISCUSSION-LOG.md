# Phase 29: Validator Depth - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md — this log preserves the alternatives considered.

**Date:** 2026-04-28
**Phase:** 29-validator-depth
**Areas discussed:** Role-mismatch action, Domain guard scope, .gendsp critic strategy, Install warning emission point

---

## Area Selection

| Option | Description | Selected |
|--------|-------------|----------|
| Role-mismatch action | Layer 3 currently auto-removes signal→control. New role-aware mismatches: auto-remove vs report-only vs tier? | ✓ |
| Domain guard scope | Explicit `domain_restricted` only vs canonical-domain inference vs hardcoded seed | ✓ |
| .gendsp critic strategy | Extend validate_genexpr vs new review_gendsp vs split syntax/semantics | ✓ |
| Install warning emission point | db.lookup() once-per-name vs validate_patch() per-box vs both | ✓ |

User selected all four areas for discussion.

---

## Role-Mismatch Action (VALID-01, VALID-05)

### Q1 — What should the connection validator do on role mismatch?

| Option | Description | Selected |
|--------|-------------|----------|
| Tier by mismatch class | ERROR+auto-remove for mechanical fixes (status→signal: snapshot~), WARNING+preserve for ambiguous (trigger→float), silent for float→signal (signal/float inlets accept both) | ✓ |
| All → ERROR + auto-remove | Consistent with current Layer 3 signal→control. Risk: removes intentional connections | |
| All → WARNING, preserve | Report-only, never destructive. Risk: drifts back to generic-warning anti-pattern | |
| ERROR for restricted pairs only, no auto-remove | Role-aware error message but never destructive. Diverges from current auto-fix posture | |

**User's choice:** Tier by mismatch class
**Notes:** Tiered approach matches existing Layer 3 posture for clear-cut cases; preserves judgment on ambiguous role pairs.

### Q2 — Tier-mapping shape?

| Option | Description | Selected |
|--------|-------------|----------|
| Suggestion-driven tiering | ERROR+auto-remove when canonical mechanical fix exists (status→signal: snapshot~, trigger→signal: sig~/click~). WARNING+preserve when judgment-laden (trigger→float, list→float). | ✓ |
| Outlet-shape tiering | ERROR if dst expects audio AND src is non-audio. WARNING for everything else. Simpler rule | |
| Severity table per pair | Explicit lookup table mapping every (src_role, dst_inlet_kind) pair. Most precise, most code | |

**User's choice:** Suggestion-driven tiering
**Notes:** Lets the suggestion field carry weight; recognizes that "no clean fix" cases (data/list→signal) still warrant ERROR.

### Q3 — Check ordering relative to legacy signal/control check?

| Option | Description | Selected |
|--------|-------------|----------|
| Role check FIRST, fall through to legacy | When `get_signal_role()` non-None → tier check; when None → fall through to existing signal:bool check. Cleanest separation | ✓ |
| Legacy first, role check enriches errors | Existing check unchanged; role replaces message text. Smaller diff | |
| Single unified check using role-or-bool | Compute effective role for every outlet, dispatch through one tier table. Cleanest long-term, biggest blast radius | |

**User's choice:** Role check FIRST, fall through to legacy
**Notes:** Honors Phase 28 D-02 (`None` means "fall back to boolean check, do not emit role-mismatch error").

---

## Domain Guard Scope (VALID-02, VALID-05)

### Q1 — What should `domain_restricted` checks treat as restricted?

| Option | Description | Selected |
|--------|-------------|----------|
| Explicit `domain_restricted` only | Hard-block ONLY objects with explicit annotation. Predictable, fail-closed | ✓ |
| Explicit + canonical-domain heuristic | Also infer from object's domain JSON membership. Catches more, false-positive risk for shared objects | |
| Explicit + small built-in seed list | Hardcoded seed of ~5-10 known restricted objects. Bridges the gap pragmatically | |

**User's choice:** Explicit `domain_restricted` only
**Notes:** Predictability over coverage; Phase 30 expands annotations.

### Q2 — Where should the domain guard live?

| Option | Description | Selected |
|--------|-------------|----------|
| New Layer 4 check in validation.py | Sibling to `_validate_domain_rules`. Walks every box, emits ERROR if outside allowed scope | ✓ |
| Hook into Patcher.add_object | Block at construction time. Fail-fast at API boundary. Doesn't help with loaded .maxpat | |
| Both — Patcher fast-fail + Layer 4 catch | Defense in depth | |

**User's choice:** New Layer 4 check in validation.py
**Notes:** Single enforcement point; matches existing validator lifecycle.

### Q3 — Scope detection?

| Option | Description | Selected |
|--------|-------------|----------|
| Top-level only (simplest) | Flag only when in `patch_dict.patcher.boxes` (outer level). Don't recurse | ✓ |
| Recursive with rnbo~ scope tracking | Walk every nested patcher, track scope via wrapper name. Most thorough | |
| Recursive but flat-scope only (no inheritance) | Walk nested patchers, but only treat immediate parent as scope. Edge case: p inside rnbo~ wouldn't count | |

**User's choice:** Top-level only (simplest)
**Notes:** Catches the canonical violation (`floor~` at MSP top level); nested edge cases deferred.

---

## .gendsp Critic Strategy (VALID-04, VALID-05)

### Q1 — Where should the three missing GenExpr checks land?

| Option | Description | Selected |
|--------|-------------|----------|
| Extend `validate_genexpr` in code_validation.py | Add Check 7/8/9. Single entry point covers .gendsp + embedded codeboxes. Simplest | ✓ |
| New `review_gendsp()` in dsp_critic.py | Mirror `review_dsp` for .gendsp. Better long-term separation | |
| Split: extend genexpr for syntax, review_gendsp for semantics | Most honest separation, most code, risk of agents forgetting both | |

**User's choice:** Extend `validate_genexpr` in code_validation.py
**Notes:** No new module; hooks.validate_code_file already routes .gendsp → validate_genexpr.

### Q2 — Severity for the three new GenExpr checks?

| Option | Description | Selected |
|--------|-------------|----------|
| All three → ERROR | All are documented MAX errors that prevent gen~ from compiling. Consistent with 'unbalanced braces' (existing error) | ✓ |
| ERROR for compile-fatal, WARNING for init-before-if/else | Conservative on flow analysis (false-positive risk on shadowed names) | |
| All three → WARNING | Report-only, never block. Loses VALID-05's clear distinction | |

**User's choice:** All three → ERROR
**Notes:** All three are guaranteed runtime/compile failures, not stylistic. Init-before-if/else accepts documented false-positive limitations.

### Q3 — Embedded codebox parity scope?

| Option | Description | Selected |
|--------|-------------|----------|
| Wire embedded codeboxes in this phase | Add validate_genexpr call for every gen~ box's embedded codebox. Parity in both directions | ✓ |
| Out of scope — .gendsp parity only | Read requirement narrowly; embedded codeboxes get validate_genexpr in Phase 30+ | |
| Wire embedded ONLY for the three new checks | Add only the three new checks to embedded code, not full validate_genexpr | |

**User's choice:** Wire embedded codeboxes in this phase
**Notes:** VALID-04 phrasing implies embedded codeboxes are the rigor baseline; this phase delivers parity in both directions.

---

## Install Warning Emission Point (VALID-03, VALID-05)

### Q1 — Where and how often should `verified_installed: false` warnings fire?

| Option | Description | Selected |
|--------|-------------|----------|
| db.lookup() once-per-name, cached | Mirror `_maybe_warn_empty_io` exactly. Lookup-time per requirement's literal phrasing | ✓ |
| validate_patch() once-per-patch | Tied to actual patch usage. Risk of duplicate warnings | |
| Both — db.lookup() warn + validate_patch() ValidationResult | Two channels, two audiences. More code | |

**User's choice:** db.lookup() once-per-name, cached
**Notes:** Matches existing once-per-process posture; respects Phase 28 D-10 (warn ONLY on explicit False).

### Q2 — Warning shape and category?

| Option | Description | Selected |
|--------|-------------|----------|
| UserWarning + bach.llll2list-style template | Match `_maybe_warn_empty_io` exactly. Same category, same stacklevel | |
| New InstallWarning subclass | Future-proof for filterable categories. Slightly more code | |
| Match empty-IO exactly + suggestion field | Same as option 1 plus a stock suggestion line for actionability | ✓ |

**User's choice:** Match empty-IO exactly + suggestion field
**Notes:** Same UserWarning category; adds 'Run package extraction or remove from overrides.json if intentional' for actionability.

---

## Wrap-Up

### Q1 — Anything else to lock before writing CONTEXT.md?

| Option | Description | Selected |
|--------|-------------|----------|
| Write CONTEXT.md now | Decisions captured for all four areas; ship it | ✓ |
| VALID-05 severity contract — lock per-family mapping | Concrete severity table downstream agents can grep | |
| Cross-cutting test fixture decision | Decide upfront which fixtures get role/domain examples | |

**User's choice:** Write CONTEXT.md now
**Notes:** Per-family severity table was added as D-19 anyway; test fixtures captured under Claude's Discretion.

---

## Claude's Discretion

- Tier-table location (inline dict vs module-level constant)
- Test fixture choices (reuse Phase 28 patterns; pick `floor~` for domain-restricted, `bach.llll2list` for install-state)
- Exact `_install_warned` set placement on `ObjectDatabase`
- Where the embedded-codebox walker lives (validation.py preferred over dsp_critic.py)
- First-error-and-stop vs accumulate for init-before-if/else (matches Check 5's `break` posture either way)
- Embedded-codebox walker recursion depth (gen~ inside gen~)

## Deferred Ideas

- Canonical-domain inference for `domain_restricted` (implicit from rnbo/objects.json membership) — Phase 30+
- Recursive scope tracking inside subpatchers / nested rnbo~ — Phase 30+ if real cases emerge
- Patcher API construction-time fast-fail for domain-restricted objects — defense-in-depth deferred
- Validation `InstallWarning` subclass — re-use UserWarning until tooling needs filterable categories
- `validate_patch()` per-box install-state ValidationResult — single-channel via db.lookup() suffices
- Severity vocabulary unification (`ValidationResult.level` ↔ `CriticResult.severity`) — v6.0+ if at all
- Promoting structure-critic warnings to ERROR/blocker — Phase 33 (optional)
- Per-inlet `signal_role` — v6.0+
- Full scope analysis for init-before-if/else (proper AST/parser) — light flow analysis with documented false-positive limitations is acceptable
