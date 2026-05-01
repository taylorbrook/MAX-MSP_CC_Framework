# Phase 28 Security Audit

**Phase:** 28 — schema-foundation
**ASVS Level:** 1
**Block-on:** high
**Audit completed:** 2026-04-28
**Auditor:** gsd-security-auditor

## Summary

8/8 threats CLOSED. 2 mitigations verified in code; 6 accepted risks logged below. No unregistered threat flags from any of the three phase summaries (each SUMMARY.md either omits a `## Threat Flags` section or — in 28-03 — explicitly states "None").

## Threat Verification

| Threat ID | Category | Disposition | Status | Evidence |
|-----------|----------|-------------|--------|----------|
| T-28-01 | Tampering | accept | CLOSED | Accepted-risks log below; `overrides.json` is version-controlled and PR-reviewed (T-20-03 precedent) |
| T-28-02 | Denial of Service | accept | CLOSED | Accepted-risks log below; `_validate_schema_extensions` is a one-shot O(N·outlets) walk at construction time, no remote trigger |
| T-28-03 | Information Disclosure | accept | CLOSED | Accepted-risks log below; `ValueError` messages contain only public DB content sourced from trusted overrides.json |
| T-28-04 | Tampering | mitigate | CLOSED | `src/maxpat/db_lookup.py:625` — `return list(obj.get("domain_restricted", []))` returns a fresh list copy, isolating the underlying schema list from caller mutation |
| T-28-05 | Information Disclosure | accept | CLOSED | Accepted-risks log below; the five new getters expose only version-controlled, public DB content |
| T-28-06 | Tampering | accept | CLOSED | Accepted-risks log below; overrides.json fixture additions are additive and PR-reviewed |
| T-28-07 | Denial of Service | accept | CLOSED | Accepted-risks log below; `audit_install_coverage` is on-demand, not on the patch-build hot path |
| T-28-08 | Tampering | mitigate | CLOSED | `tests/test_schema_extensions.py:355-361` — `test_get_domain_restrictions_returns_list_copy` mutates returned list with `r1.append("hacked")` and asserts the next call returns `["rnbo"]` without `"hacked"`, locking the T-28-04 invariant against regression |

## Mitigation Detail

### T-28-04 — `get_domain_restrictions` returns a fresh list copy

**File:** `src/maxpat/db_lookup.py`
**Function:** `ObjectDatabase.get_domain_restrictions`
**Line:** 625

```python
def get_domain_restrictions(self, name: str) -> list[str]:
    """Return the list of domains this object is restricted to, [] if unrestricted.

    Per D-07: absent → [] (no tri-state ceremony). Per D-08: Phase 29 iterates
    this to emit errors like "object X is restricted to {rnbo}; not allowed at
    MSP top level".

    Returns a fresh list copy so callers can't mutate the underlying schema.
    """
    canonical = self._aliases.get(name, name)
    obj = self._objects.get(canonical)
    if obj is None:
        return []
    return list(obj.get("domain_restricted", []))   # ← fresh list
```

The `list(...)` constructor materialises a new list from the underlying value, so caller mutation cannot leak into `self._objects[canonical]["domain_restricted"]`. Verified by behavioural probe in `is_domain_restricted` (which delegates to this getter) and by the regression test under T-28-08.

### T-28-08 — Regression test asserts list-copy invariant

**File:** `tests/test_schema_extensions.py`
**Class:** `TestGetters`
**Function:** `test_get_domain_restrictions_returns_list_copy`
**Lines:** 355-361

```python
def test_get_domain_restrictions_returns_list_copy(self, db):
    """Mutating the returned list does not affect a subsequent call (T-28-04)."""
    r1 = db.get_domain_restrictions("floor~")
    r1.append("hacked")
    r2 = db.get_domain_restrictions("floor~")
    assert "hacked" not in r2
    assert r2 == ["rnbo"]
```

Test executes against the production `ObjectDatabase()` fixture. `floor~` is the Plan 03 Task 2 fixture (`domain_restricted: ["rnbo"]`). The test is strengthened beyond the plan-spec to assert exact equality with `["rnbo"]`, so any drift in either the list-copy invariant or the underlying fixture surfaces immediately.

## Accepted Risks Log

The following six threats are accepted per the phase's threat register. Each entry below is the audit-trail evidence required for `accept` disposition.

### T-28-01 — Tampering of `overrides.json` (curated schema fields)

**Accepted because:** the file lives in version control. Modifications go through PR review. Same disposition as T-20-03 from the Phase-20 db-schema-foundation milestone. No runtime write path exists from user input to `overrides.json`.

### T-28-02 — DoS via `_validate_schema_extensions` walk

**Accepted because:** the validator runs exactly once at `ObjectDatabase` construction. It is O(N·outlets) over ~3,000 objects (a few-millisecond walk in practice). There is no remote or repeated-trigger path — the constructor is invoked once per Python process. The same disposition was applied to the precedent `_validate_variable_io_rules` walk.

### T-28-03 — Information Disclosure via `ValueError` messages

**Accepted because:** the validator's `ValueError` payloads are constructed from (a) object names — public DB content — and (b) the offending value the curator placed in `overrides.json` — also trusted, version-controlled, public content. No secrets, credentials, file paths outside the project tree, or runtime-user data are reachable through this exception path.

### T-28-05 — Information Disclosure via the five new getters

**Accepted because:** all five getters (`get_signal_role`, `get_install_state`, `is_verified_installed`, `get_domain_restrictions`, `is_domain_restricted`) read from `self._objects`, populated solely from version-controlled, public DB JSON files. Same exposure surface as the existing `lookup`, `is_overridden`, `is_core`, `get_package`, `get_package_info` getters which already ship under the same disposition.

### T-28-06 — Tampering of `overrides.json` fixture additions

**Accepted because:** the four new fixture entries (`cycle~`, `snapshot~`, `floor~`, `bach.llll2list`) are additive — no existing entries removed or modified — and were reviewed via the standard git-diff PR flow. Each new entry includes an `_audit` block citing the source (CLAUDE.md or memory file), confidence level, and finding so the diff is self-documenting. Same disposition as T-20-03 / T-28-01.

### T-28-07 — DoS via `audit_install_coverage` walk

**Accepted because:** the audit functions are not invoked on any patch-build hot path. They are intended for the Phase-30 audit script (`audit_install_coverage`) and Phase-29 typo-detection workflow (`audit_domain_coverage`). The O(N) walk over ~3,000 objects completes in single-digit milliseconds. No remote trigger, no repeated-call hot path.

## Unregistered Flags

**None.**

- `28-01-SUMMARY.md` does not include a `## Threat Flags` section (no new attack surface declared by executor).
- `28-02-SUMMARY.md` does not include a `## Threat Flags` section (no new attack surface declared by executor).
- `28-03-SUMMARY.md` includes a `## Threat Flags` section that explicitly states `"None. This plan introduces no new network endpoints, auth paths, file access patterns, or schema changes at trust boundaries beyond what was already declared in the plan's <threat_model>."`

All threat surface for the phase was declared up-front in the three plans' `<threat_model>` blocks and verified above.

## Verification Methodology

For each threat ID:

1. **`accept` dispositions (T-28-01, T-28-02, T-28-03, T-28-05, T-28-06, T-28-07):** verified by presence of the corresponding entry in this document's "Accepted Risks Log" section, with explicit rationale matching the plan's stated mitigation reasoning.

2. **`mitigate` dispositions (T-28-04, T-28-08):** verified by reading the cited file at the specified line and confirming the declared pattern:
   - T-28-04: `src/maxpat/db_lookup.py:625` contains `return list(obj.get("domain_restricted", []))` — confirmed.
   - T-28-08: `tests/test_schema_extensions.py:355-361` contains a regression test that mutates the getter's return value and asserts a subsequent call yields the unmutated list — confirmed.

3. **Threat-flag survey:** all three phase summaries (`28-01-SUMMARY.md`, `28-02-SUMMARY.md`, `28-03-SUMMARY.md`) checked for `## Threat Flags` sections — none introduce unregistered attack surface.

## Result

**SECURED.** All 8 threats from the phase threat register are CLOSED. Two mitigations are present in implemented code with regression-test coverage; six accepted-risk entries are logged with rationale.
