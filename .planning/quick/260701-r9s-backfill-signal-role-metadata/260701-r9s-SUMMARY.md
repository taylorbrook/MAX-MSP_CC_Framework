---
phase: quick-260701-r9s
plan: 01
subsystem: object-database
status: complete
tags: [signal_role, overrides, metadata-fidelity, WR-01, phase-30]
requires:
  - src/maxpat/db_lookup.py (DOMAIN_LOAD_ORDER, ObjectDatabase, _SIGNAL_ROLE_ENUM)
provides:
  - scripts/audit_signal_role.py::backfill-metadata subcommand
  - scripts/audit_signal_role.py::_canonical_outlet_meta
  - scripts/audit_signal_role.py::_resolve_outlet_meta
  - fully-typed + digested signal_role outlets in overrides.json
affects:
  - .claude/max-objects/overrides.json (795 signal_role outlets)
tech_stack:
  added: []
  patterns:
    - "Canonical-or-role-derived metadata resolution keyed by (object_name, outlet_id)"
    - "Fill-empty-only backfill (no clobber) with atomic write + loader-acceptance check"
key_files:
  created: []
  modified:
    - scripts/audit_signal_role.py
    - tests/test_audit_signal_role.py
    - .claude/max-objects/overrides.json
decisions:
  - "Canonical map mirrors the loader's DOMAIN_LOAD_ORDER merge so core (msp/max) wins over rnbo duplicates"
  - "Role-derived fallback reuses strings already present verbatim in overrides.json (signal/Signal output, control/Control output) — no new vocabulary"
  - "Backfill scoped to signal_role outlets only (WR-01 scope); role-less outlets untouched"
metrics:
  duration_secs: 232
  completed: 2026-07-01
  tasks: 2
  files_changed: 3
requirements: [WR-01]
---

# Quick Task 260701-r9s: Backfill signal_role Outlet Metadata Summary

Closed WR-01 (Phase 30 metadata fidelity): the loaded `ObjectDatabase()` now reports **0 empty-type and 0 empty-digest** signal_role outlets, down from a measured 703/588 baseline across 795 outlets, via a new idempotent `backfill-metadata` subcommand plus a synthesis-path fix that stops future apply runs from reintroducing empty stubs.

## What Was Built

**Task 1 — helpers + synthesis fix + backfill subcommand (TDD)**
- `_canonical_outlet_meta(db_root)`: builds `(object_name, outlet_id) -> (type, digest)` by reading each domain's `objects.json` in `DOMAIN_LOAD_ORDER` (plus the `packages/*/objects.json` subdir scan). Later-loaded domains overwrite earlier, so core (msp/max) wins over rnbo — mirroring the loader's deep-merge priority. Missing domain files are skipped silently so isolated test roots work.
- `_resolve_outlet_meta(name, outlet_id, role, canon_map)`: returns canonical type/digest when present and non-empty, else the role-derived fallback (`signal`/`Signal output` for `audio`, `control`/`Control output` otherwise).
- `cmd_apply_run` new-outlet branch (`target is None` only): now populates `type`/`digest` from `_resolve_outlet_meta` instead of empty-string stubs. The existing-outlet branch is untouched, so the apply/idempotency/overwrite suite stays green.
- `cmd_backfill_run(overrides_file=None)` + `backfill-metadata` subcommand: walks every outlet that carries a `signal_role` AND has an empty `type` OR empty `digest`, fills only the empty field(s), never clobbers a non-empty value, never mutates `signal_role`, never touches role-less outlets. Idempotent (no change → returns 0 without writing). Atomic `.json.tmp` + replace, round-trip JSON validation, and a post-write `ObjectDatabase()` loader-acceptance check on the canonical default file (mirrors `cmd_apply_run`'s guards).

**Task 2 — ran the backfill on the real overrides.json**
- Measured BEFORE gap through a loaded `ObjectDatabase()`: 703 empty-type / 588 empty-digest.
- Ran `python scripts/audit_signal_role.py backfill-metadata`.
- AFTER gap: 0 / 0. Second run is byte-identical (idempotent). `overrides.json` remains valid JSON and the loader constructs without error.
- 640 outlets received rich canonical digests (e.g. `cycle~` → `(signal) Periodic waveform output`); 155 received the generic role-derived fallback (outlets with no canonical `(name, id)` source).

## Verification

- `python -m pytest tests/test_audit_signal_role.py -q` → **81 passed** (pre-existing 72 + 9 new).
- Loaded-DB gate: `ObjectDatabase()` reports 0 signal_role outlets with empty type and 0 with empty digest.
- `python scripts/audit_signal_role.py backfill-metadata` exits 0; second run byte-identical (md5 match).
- `json.load(open('.claude/max-objects/overrides.json'))` succeeds — file is valid JSON.

## Deviations from Plan

None — plan executed exactly as written.

## Threat Model Coverage

- **T-r9s-01 (overwrite of curator values):** fill-empty-only logic; non-empty `type`/`digest` left untouched; `signal_role` never mutated. Covered by `test_backfill_fills_empty_leaves_nonempty` and `test_backfill_never_mutates_signal_role`.
- **T-r9s-02 (corrupt write breaks DB load):** atomic `.tmp` + replace, round-trip JSON validation, post-write `ObjectDatabase()` loader check on the canonical file.
- **T-r9s-03 (empty stubs reintroduced by future apply):** synthesis-path fix populates metadata on new-outlet creation; guarded by `TestOutletMetaSynthesis`.
- **T-r9s-04 (broad git add):** commits scoped to exactly the three touched files by explicit path; no `git add .`/`-A`.

## Commits

- `f506ed5` test(quick-260701-r9s): add failing tests for outlet-meta synthesis + backfill (RED)
- `87576b1` feat(quick-260701-r9s): synthesize outlet metadata + add backfill-metadata (GREEN)
- `f9b4f05` fix(quick-260701-r9s): backfill type/digest on 795 signal_role outlets

## Self-Check: PASSED

- FOUND: scripts/audit_signal_role.py (`_canonical_outlet_meta`, `_resolve_outlet_meta`, `cmd_backfill_run`, `backfill-metadata` subcommand)
- FOUND: tests/test_audit_signal_role.py (TestOutletMetaSynthesis, TestBackfillMetadata)
- FOUND: .claude/max-objects/overrides.json (0/0 empty type/digest via loaded DB)
- FOUND commit f506ed5, 87576b1, f9b4f05
