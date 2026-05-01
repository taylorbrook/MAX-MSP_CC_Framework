# Phase 28: Schema Foundation - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md — this log preserves the alternatives considered.

**Date:** 2026-04-27
**Phase:** 28-schema-foundation
**Areas discussed:** Back-compat derivation semantics, domain_restricted shape & semantics, verified_installed default & tri-state, audit_empty_io() shape change

---

## Back-Compat Derivation Semantics

| Option | Description | Selected |
|--------|-------------|----------|
| At load time (write-through) | Loader rewrites `signal: bool` from `signal_role` after deep-merge. Existing `outlet["signal"]` consumers see the new truth without code changes. One-time cost at `_load()`. | ✓ |
| At read time (computed property) | Leave dict alone; `get_outlet_types()` computes the bool on each call. Direct dict reads `outlet["signal"]` miss override-only role data unless callers migrate. | |
| Both fields written explicitly in overrides | Curators write both `signal_role` AND `signal: bool`; loader does no derivation. Most explicit but doubles override entry size and risks drift. | |

**User's choice:** Asked Claude to recommend the cleanest, most efficient option → write-through, then explicitly locked it in.
**Notes:** Inverse direction also locked: outlets with only legacy `signal: bool` resolve as `get_signal_role() == "audio"` (when true) or `None` (when false). `None` is the honest "not yet curated" sentinel that Phase 29's role-aware validators must check before emitting role-mismatch errors.

---

## domain_restricted Shape & Semantics

| Option | Description | Selected |
|--------|-------------|----------|
| Whitelist + closed enum + absent=False | `["rnbo"]` = "only legal in rnbo context"; allowed values `{rnbo, m4l, gen}`; absent → `False`. Loader fail-fasts on unknown domain values. | ✓ |
| Whitelist + open strings + absent=False | Same as above but free-form strings. Looser; no load-time guard against typos. | |
| Tri-state with absent=None | `None` when absent, `False` when explicitly `[]`, list when restricted. More state; distinguishes unrestricted vs unknown. | |

**User's choice:** Asked Claude to recommend the cleanest, most efficient option → whitelist + closed enum + absent=False, then explicitly locked it in.
**Notes:** Companion getter `get_domain_restrictions(name) -> list[str]` returns the list (`[]` when absent or restricted-to-nothing). `is_domain_restricted()` is bool sugar over that. Closed enum covers v5.0's known restrictions (`floor~`/RNBO, `live.*`/M4L, gen-codebox-only ops).

---

## verified_installed Default & Tri-State

| Option | Description | Selected |
|--------|-------------|----------|
| Tri-state (absent=None, true=True, false=False) | `None` honestly says "haven't audited this yet." Phase 29 warns only on explicit `False`; silent on `None`. Audit script can count `None`s as the real coverage gap. Symmetric with signal_role. | ✓ |
| Two-state, absent=True | `is_verified_installed("cycle~") == True` by default. Simpler API but loses the "unaudited vs verified" distinction. | |
| Two-state, absent=False | `is_verified_installed("cycle~") == False` until audited. Likely too noisy in practice. | |

**User's choice:** Asked Claude to choose the most efficient and consistent path → tri-state, accepted as locked.
**Notes:** Companion getter `get_install_state(name) -> Optional[bool]` returns the raw three-state. `is_verified_installed(name)` collapses to `state is True`. Phase 30 success metric = "drive `None` count down."

---

## audit_empty_io() Shape Change

| Option | Description | Selected |
|--------|-------------|----------|
| Split: keep audit_empty_io focused, add two new functions | `audit_empty_io()` unchanged; add `audit_install_coverage()` and `audit_domain_coverage()`. Single Responsibility wins. Existing call sites untouched. | ✓ |
| Extend in-place with new keys | `audit_empty_io()` returns one big dict with all five categories. Matches SCHEMA-07 wording literally but function name no longer matches what it returns. | |
| Unified audit() umbrella | Keep `audit_empty_io()` unchanged, add `audit()` that bundles all three sub-audits. Easy one-shot but doubles the surface. | |

**User's choice:** Split: keep audit_empty_io focused, add two new functions.
**Notes:** No follow-up needed. SCHEMA-07's intent (surface the new categories) is satisfied by the three-function family; the literal "extend audit_empty_io" wording is interpreted at intent level.

---

## Claude's Discretion

- Exact getter signatures (positional vs keyword args) — match existing `lookup()` style.
- Test fixture choice for back-compat coverage — pick 2–3 objects from `tests/conftest.py`'s existing fixture set; do not introduce new fixture files unless required.
- Where in `_load()` to invoke `_validate_schema_extensions()` — after overrides deep-merge, before audit caches build.
- Storage location decision (overrides.json only) — locked by inference from "small reversible delta" milestone constraint; not asked.
- Validation strictness (fail-fast at load) — locked by Phase 20 precedent; not asked.

## Deferred Ideas

- Inlet `signal_role` (symmetric to outlet roles) — v6.0+ scope.
- Message-type taxonomy on the `messages: [...]` list — v6.0+ scope.
- Population of `signal_role` on Max/Jitter/MC domains — v5.0 caps Phase 30 at MSP-only.
- Auto-extraction of `verified_installed` by diffing DB against `_pkg-source/` directory contents — Phase 30 or post-v5.0 quick task.
- Umbrella `audit()` wrapper across the three sub-audits — Phase 30 or quick task once shape is proven.
- Removing the `signal: bool` field entirely — explicitly v6.0+ work.
</content>
</invoke>
