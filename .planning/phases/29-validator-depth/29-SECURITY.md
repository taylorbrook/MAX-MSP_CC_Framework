---
phase: 29
slug: validator-depth
status: verified
threats_open: 0
asvs_level: 1
created: 2026-04-29
---

# Phase 29 — Security

> Per-phase security contract: threat register, accepted risks, and audit trail.

---

## Trust Boundaries

| Boundary | Description | Data Crossing |
|----------|-------------|---------------|
| validator → developer console | `warnings.warn` text composed from canonical names already committed to `overrides.json`. | Curated object names (no PII, no secrets, no network input). |
| code text → `validate_genexpr` regex passes | GenExpr source code from `.gendsp` files or embedded codeboxes; treated as opaque text by Python regex, never evaluated/exec'd. | GenExpr text (opaque, never executed). |
| patch JSON → connection validator | `patch_dict` (.maxpat content) crosses into `_validate_connections`; treated as opaque schema, never evaluated. | Patch JSON (opaque schema). |
| `overrides.json` → `get_signal_role` / role tier dispatch | Role data already validated at load time (Phase 28 enum check). | Curated role enums. |
| patch JSON → domain restriction guard | Top-level boxes scanned for `domain_restricted` annotations from curated `overrides.json`. | Patch JSON + curated annotations. |
| patch JSON → embedded codebox walker | gen~ inner-patcher codebox `code` text passed verbatim to `validate_genexpr`. | Codebox text (opaque). |

---

## Threat Register

| Threat ID | Category | Component | Disposition | Mitigation | Status |
|-----------|----------|-----------|-------------|------------|--------|
| T-29-01 | I (Information disclosure) | `_maybe_warn_install_state` warning text in `db_lookup.py` | accept | Warning text composed solely from canonical object names curated in committed `overrides.json` (no PII, no secrets, no network input). Surfaces only to developer-only stderr via Python `warnings`. ASVS L1 informational-disclosure controls do not apply. | closed |
| T-29-02 | T (Tampering) | `validate_genexpr` regex passes — Checks 7/8/9 patterns `\bdelay\s*\(`, `\bclip\s*\(`, assignment scan | accept | GenExpr code is pattern-matched, never executed. Patterns are bounded (constant prefix, no nested quantifiers, no backtracking traps), so ReDoS is not feasible on user-controlled input. Validator never writes to disk; output is `ValidationResult` records to a developer console. | closed |
| T-29-03 | T (Tampering) | `_classify_role_mismatch` / `_ROLE_TIER_TABLE` / tier dispatch in `_validate_connections` | accept | Patch JSON parsed by `validate_patch` only; tier dispatch reads role data exclusively from already-curated `overrides.json` (Phase 28 enforces enum at load time). No untrusted code execution; no I/O. ASVS L1 input-validation already enforced upstream by Layers 1/2 of the pipeline. | closed |
| T-29-04 | T (Tampering) | `_validate_domain_restrictions` walker in `validation.py` | accept | Domain restriction data comes exclusively from curated `overrides.json` (Phase 28 enforces enum at load time). The walker reads `patch_dict["patcher"]["boxes"]` but never executes any of it. ASVS L1 input-validation already enforced upstream by Layers 1/2. No auth or PII surface. | closed |
| T-29-05 | T (Tampering) | `_validate_embedded_genexpr` walker in `validation.py` | accept | Codebox `code` attribute is text only; `validate_genexpr` applies bounded regex (no ReDoS, no `exec`, no I/O). The walker never compiles or executes the GenExpr code. ASVS L1 input-validation upstream by Layers 1/2 of the pipeline. No auth or PII surface. | closed |

*Status: open · closed*
*Disposition: mitigate (implementation required) · accept (documented risk) · transfer (third-party)*

---

## Accepted Risks Log

| Risk ID | Threat Ref | Rationale | Accepted By | Date |
|---------|------------|-----------|-------------|------|
| AR-29-01 | T-29-01 | Developer-only stderr channel; warning text composed from curated canonical names. No external/untrusted input. ASVS L1 disclosure controls N/A. | Taylor Brook | 2026-04-29 |
| AR-29-02 | T-29-02 | Bounded regex (constant prefixes, no nested quantifiers) over text that is never `exec`'d; no disk writes. ReDoS not feasible. | Taylor Brook | 2026-04-29 |
| AR-29-03 | T-29-03 | Role dispatch reads only curated `overrides.json` enums (Phase 28 load-time validation). No code execution; no I/O. | Taylor Brook | 2026-04-29 |
| AR-29-04 | T-29-04 | Domain restrictions sourced from curated `overrides.json`; walker reads boxes but never executes. No auth/PII surface. | Taylor Brook | 2026-04-29 |
| AR-29-05 | T-29-05 | Embedded codebox `code` is text-only; regex pass is bounded with no `exec`/I/O. Walker never compiles GenExpr. | Taylor Brook | 2026-04-29 |

*Accepted risks do not resurface in future audit runs.*

---

## Security Audit Trail

| Audit Date | Threats Total | Closed | Open | Run By |
|------------|---------------|--------|------|--------|
| 2026-04-29 | 5 | 5 | 0 | /gsd-secure-phase (user-accepted) |

---

## Sign-Off

- [x] All threats have a disposition (mitigate / accept / transfer)
- [x] Accepted risks documented in Accepted Risks Log
- [x] `threats_open: 0` confirmed
- [x] `status: verified` set in frontmatter

**Approval:** verified 2026-04-29
