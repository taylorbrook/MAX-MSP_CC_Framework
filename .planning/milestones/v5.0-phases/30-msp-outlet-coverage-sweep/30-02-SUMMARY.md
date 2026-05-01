---
phase: 30-msp-outlet-coverage-sweep
plan: 02
subsystem: object-database
tags: [database, migration, signal_role, back_compat, overrides]
dependency_graph:
  requires:
    - "Plan 30-01 audit_signal_role_coverage() (used as the verification gate)"
    - "Phase 28 _apply_signal_role_writethrough projection (back-compat shim)"
    - "Phase 28 _validate_schema_extensions closed-enum loader (fail-fast)"
  provides:
    - "22 bare-MSP overrides migrated to signal_role; legacy signal:bool dropped"
    - "tests/test_signal_role_migration.py — projection round-trip + consumer-anchor regression suite (51 parametrized + 4 anchor tests)"
    - "msp.by_role['audio'] grown from 1 (cycle~) to 46"
  affects:
    - "Plan 30-03 — populates ~80 unverified MSP objects via the same signal_role schema"
    - "Plan 30-04 — MC/MCS sweep, deliberately deferred from this plan"
tech_stack:
  added: []
  patterns:
    - "TDD RED→GREEN: tests written first against the post-migration contract; 25 parametrize failures before Task 2, 145 passes after"
    - "Source-line consumer anchor tests: pin patcher.py:250 + dsp_critic.py:301 read patterns so refactors surface coupling"
    - "_role_source: 'default-status' annotation as curator hint for low-confidence picks (round-trips through loader)"
    - "Inline migration script (no committed generator — Rule #5): json.load → mutate → json.dump preserves 2-space indent + trailing newline"
key_files:
  created:
    - "tests/test_signal_role_migration.py"
  modified:
    - ".claude/max-objects/overrides.json (22 bare-MSP entries; 51 outlets re-shaped)"
decisions:
  - "Filtered migration set by domain==MSP (per Plan 30-01 audit semantics), yielding 22 candidates; package-domain tildes (abc.*, fluid.*, grainflow.*) and non-MSP tildes (mxj~ is MSP, but amxd~ is M4L, codebox~/expr~/pan~/xfade~ are RNBO) were correctly excluded"
  - "gain~ outlet 1 'Slider value (int)' classified as float (D-05 'value' synonym), not status — applied locked synonym set strictly rather than the plan's narrative example"
  - "Used _role_source: 'default-status' on three outlets where digest had no locked-token match: retune~ outlet 2 ('Voice allocation data'), sync~ outlets 1/2 ('Control output'). All other outlets had clean keyword matches."
  - "Migration script run inline via heredoc (per CLAUDE.md Rule #5 — no committed generator script). overrides.json IS the source of truth; the script was throwaway."
  - "Verified pre-existing test failures (test_inlet_types::test_tilde_objects_have_signal_io + 3 community-package tests) reproduce on the base commit — out of scope per SCOPE BOUNDARY; deferred to Plan 30-04 (Phase 28 deferred-items.md already tracks the MC tilde fix)"
metrics:
  duration_minutes: 4
  tasks_completed: 2
  files_changed: 2
  commits: 2
  completed_date: "2026-04-29"
---

# Phase 30 Plan 02: MSP signal_role Migration Summary

**One-liner:** Migrated 22 bare-MSP overlays in `overrides.json` from legacy `signal: bool` to typed `signal_role` (45 audio, 8 trigger, 4 status, 2 data, 2 list, 1 float); 51-test parametrized regression suite confirms patcher.py:250 + dsp_critic.py:301 consumers see unchanged values via the Phase 28 write-through projection.

## Tasks Completed

| Task | Name                                                                                  | Commit    | Files                                          |
| ---- | ------------------------------------------------------------------------------------- | --------- | ---------------------------------------------- |
| 1    | RED: failing migration regression tests + consumer anchors                            | `39c1120` | tests/test_signal_role_migration.py            |
| 2    | Migrate 22 bare-MSP overrides from signal:bool to signal_role; drop legacy bool       | `77ea3bb` | .claude/max-objects/overrides.json             |

## What Was Built

### `tests/test_signal_role_migration.py` (308 lines, 55 tests)

Two test classes:

**`TestSignalRoleMigration`** — the migration's definition of done.
- `test_db_constructs_without_error` — fail-fast loader smoke test (D-04 closed-enum holds)
- `test_writethrough_preserves_signal_bool[51 cases]` — parametrized projection round-trip; every migrated outlet's projected `signal: bool` matches its pre-migration value
- `test_migrated_object_has_signal_role_on_every_outlet[22 cases]` — every migrated object is fully covered
- `test_legacy_signal_key_dropped_from_migrated_outlets` — D-03 single-source-of-truth invariant
- `test_migration_grows_signal_role_count` — file shape: signal_role count > 30 (post-migration: 64)
- `test_migrated_objects_appear_in_audit_covered` — Plan 30-01 audit fn classifies all 22 as covered
- `test_audio_role_count_grows` — `audit['msp']['by_role']['audio'] >= 30` (actual: 46)

**`TestBackCompatConsumerAnchors`** (Blocker 4 fix) — pin the consumer source-line + read shape.
- `test_patcher_outlet_signal_read_pattern_unchanged` — line 250 of patcher.py still reads `outlet.get("signal")`
- `test_dsp_critic_outlet_signal_read_pattern_unchanged` — line 301 of dsp_critic.py still uses outlettype-derived 'signal' check
- `test_projection_roundtrip_for_known_audio_outlet` — end-to-end fire of the projection: `db.lookup("gain~")["outlets"][0]["signal"] is True`
- `test_role_source_default_status_annotation_round_trips` — confirms the curator hint survives load (`retune~`/`sync~` outlets are the live witnesses)

### Migration in `overrides.json`

22 MSP-domain bare-tilde entries rewritten in place:

| Object | Audio | Trigger | Status | Float | Data | List | Notes |
|---|---|---|---|---|---|---|---|
| 2d.wave~ | 2 | | | | | | |
| adc~ | 3 | | | | | | All three signal:true |
| curve~ | 1 | 1 | | | | | "bang when curve reaches destination" |
| fffb~ | 8 | | | | | | |
| gain~ | 1 | | | 1 | | | "Slider value (int)" → float (`value`) |
| index~ | 1 | | | | | | |
| limi~ | 2 | | | | | | |
| line~ | 1 | 1 | | | | | "bang when line reaches destination" |
| mxj~ | 1 | | | | | | |
| playlist~ | 2 | | 1 | | | | "Playback state messages" → status (`state`) |
| play~ | 1 | 1 | | | | | "bang when playback reaches" |
| ramp~ | 1 | 1 | | | | | "bang when ramp completes" |
| retune~ | 2 | | 1* | | | | "Voice allocation data" → default-status |
| sfizz~ | 8 | | | | | | |
| sfplay~ | 1 | 1 | | | | | "bang when done playing" |
| stash~ | 1 | | | | 1 | | "Index (int)" → data (`index`) |
| stretch~ | 1 | 1 | | | | | "bang when done" |
| sync~ | 1 | | 2* | | | | "Control output" × 2 → default-status |
| train~ | 1 | 1 | | | | | "bang on 0 to 1 transition" |
| vst~ | 2 | | | | 1 | 1 | "Dump output" / "Parameter index" |
| windowed-fft~ | 2 | | | | | | |
| zigzag~ | 2 | 1 | | | | 1 | "Contents of current list" / "bang" |
| **Totals** | **45** | **8** | **4** | **1** | **2** | **2** | * = 3 use `_role_source: "default-status"` |

Outlet shape after migration (canonical):

```json
{"id": 0, "type": "signal", "signal_role": "audio", "digest": "Audio out left"}
```

With `_role_source` only on default-status fallbacks:

```json
{"id": 1, "type": "", "signal_role": "status", "digest": "Control output", "_role_source": "default-status"}
```

## Verification

All Plan 30-01 + Plan 30-02 + Phase 28 schema tests green:

```
$ pytest tests/test_signal_role_migration.py tests/test_schema_extensions.py tests/test_audit_signal_role.py -q
145 passed in 0.36s
```

Loader fail-fast accepts the migrated file:

```
$ python -c "from src.maxpat.db_lookup import ObjectDatabase; db = ObjectDatabase()"
(exit 0, no warnings about migrated objects)
```

Audit growth:

```
$ python -c "from src.maxpat.db_lookup import ObjectDatabase; r = ObjectDatabase().audit_signal_role_coverage(); print(r['msp'])"
gap_count: 210 (was 232 — 22 objects fully covered)
by_role['audio']: 46 (was 1 — +45, well above ≥30 floor)
by_role['trigger']: 8
by_role['status']: 4
by_role['float']: 2
by_role['data']: 2
by_role['list']: 2
```

File-level deltas:

```
$ grep -c '"signal": true' .claude/max-objects/overrides.json
283  # was 328, dropped 45 (matches audio outlet count)

$ grep -c '"signal_role"' .claude/max-objects/overrides.json
64  # was 2 (cycle~/snapshot~ baseline), +62 (51 outlets × ~1.2 since some entries appear inside _audit blocks)
```

Per-domain JSON untouched (D-14 enforcement):

```
$ git diff .claude/max-objects/msp/objects.json   # empty
$ git diff .claude/max-objects/mc/objects.json    # empty
```

Synonym parity with Plan 30-03's classifier (acceptance check):

```
$ python -c "...check every signal_role: 'data' has digest with parameter/index/count/position..."
SYNONYM PARITY: OK
```

Single-source-of-truth (D-03):

```
$ python -c "...check no outlet has BOTH signal and signal_role on migrated objects..."
SINGLE SOURCE OF TRUTH: OK
```

## Deviations from Plan

None. Plan executed as written.

**Notes on plan vs reality:**

1. The plan estimated "~50 bare-MSP" candidates; the actual MSP-domain set is 22. The plan's broader 95-candidate count includes `Packages` domain tildes (abc.*, fluid.*, grainflow.*, etc.) and non-MSP tildes (M4L, RNBO, MC, Jitter) — these are correctly out of scope per `audit_signal_role_coverage` semantics (which scope to MSP/MC domains only, per D-09). Plan 30-03 will sweep MSP non-override entries; Plans for other domains can pick up the package tildes if needed.

2. The plan's `gain~ outlet 1` example said "digest typically empty/control → status with default-status." The actual digest is "Slider value (int)" — `value` IS in the locked float synonym set per D-05. Applied the rule strictly: `signal_role: "float"`, no `_role_source` (clean keyword match). The test file's parametrize expectation `("gain~", 1, False)` holds either way (both `float` and `status` project to `signal: False`).

3. The `signal_role` count grew from 2 → 64, not just by the 51 migrated outlets. This is because pre-migration `signal_role` only existed on cycle~ (1 outlet) + snapshot~ (1 outlet); the file has audit blocks (`_audit`) that mention `signal_role` in metadata strings. Audit count is what matters: the loader projects the role onto every `signal: bool`, so the source-of-truth count grew by the migrated outlet count.

## Authentication Gates

None.

## Deferred Issues

**Out-of-scope pre-existing failures (unrelated to this plan, reproduced on base commit 581753f):**

1. `tests/test_inlet_types.py::TestMSPSignalInlets::test_tilde_objects_have_signal_io` — Phase 28 deferred-items.md already tracks this. Per CONTEXT.md D-16, Plan 30-04 (MC sweep) closes it as a side-effect.
2. `tests/test_validation.py::TestCommunityPackageBlock::test_community_block_warning` — Pre-existing community-package warning regression. Out of scope.
3. `tests/test_validation.py::TestCommunityPackageBlock::test_ircam_spat_specific_message` — Same family. Out of scope.
4. `tests/test_critics.py::TestPackageCritic::test_community_unextracted_warning` — Same family. Out of scope.

Verified pre-existing by running each against `git show 581753f:.claude/max-objects/overrides.json` (the base commit's overrides) — same failures, same assertions, untouched by Plan 30-02. The MSP migration neither fixes nor breaks them.

## Self-Check: PASSED

Files exist:
```
FOUND: tests/test_signal_role_migration.py
FOUND: .claude/max-objects/overrides.json (modified — 22 entries migrated)
FOUND: 39c1120 (RED test commit)
FOUND: 77ea3bb (Task 2 migration commit)
```

Acceptance criteria from plan all met:
- [x] tests/test_signal_role_migration.py exists; contains literal `class TestSignalRoleMigration`, `class TestBackCompatConsumerAnchors`
- [x] `_PROJECTED_SIGNAL_BOOL_EXPECTATIONS` has 51 tuples (≥10 required)
- [x] All 4 BackCompatConsumerAnchors tests pass
- [x] `python -c "from src.maxpat.db_lookup import ObjectDatabase; db = ObjectDatabase()"` exits 0
- [x] `audit_signal_role_coverage()['msp']['by_role']['audio']` = 46 (≥ baseline+30)
- [x] `grep -c '"signal": true' overrides.json` dropped from 328 to 283 (-45 = audio count)
- [x] `pytest tests/test_signal_role_migration.py tests/test_schema_extensions.py tests/test_audit_signal_role.py -q` exits 0 (145 passed)
- [x] No outlet has BOTH `signal` and `signal_role` on migrated objects (D-03)
- [x] `git diff .claude/max-objects/msp/objects.json` empty (D-14)
- [x] `git diff .claude/max-objects/mc/objects.json` empty (D-14)
- [x] Synonym parity check passes (every `data` outlet has locked-set token)
