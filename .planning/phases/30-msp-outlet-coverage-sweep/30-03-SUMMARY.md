---
phase: 30-msp-outlet-coverage-sweep
plan: 03
subsystem: object-database
tags: [database, audit, signal_role, classifier, msp, cli, mass-population]
dependency_graph:
  requires:
    - "Plan 30-01 audit_signal_role_coverage() (read as input to classifier walker)"
    - "Plan 30-01 scripts/audit_signal_role.py skeleton (extended in this plan)"
    - "Plan 30-02 _SIGNAL_ROLE_ENUM closed enum (Phase 28 D-04)"
    - "Phase 28 _validate_schema_extensions fail-fast loader (post-write loader-acceptance check)"
    - "Phase 28 _apply_signal_role_writethrough projection (back-compat shim)"
  provides:
    - "Digest-keyword classifier (D-04 conflict policy + D-05 LOCKED synonym set + D-08 three-tier confidence)"
    - "_classify_outlet top-level helper (Plan 30-04 MC fall-through reuse)"
    - "_parse_review_md / _escape_pipe pair (pipe-in-digest roundtrip — Warning 5)"
    - "cmd_apply_run with path-traversal guard, enum guard, overwrite refusal, post-write loader check"
    - "cmd_audit_run + --write-review flag (emits SIGNAL-ROLE-REVIEW.md and signal-role-audit.json)"
    - "358 new MSP signal_role entries in overrides.json (msp_gap_count: 210 → 0)"
    - "SIGNAL-ROLE-REVIEW.md (curator audit trail) and signal-role-audit.json (drift snapshot) committed under phase dir"
  affects:
    - "Plan 30-04 (MC sweep) — imports _classify_outlet for sibling-mirror fall-through cases"
    - "Phase 29 role-aware validators — now have full MSP coverage to dispatch on"
tech_stack:
  added:
    - "scripts/audit_signal_role.py classifier + --apply pipeline"
  patterns:
    - "Top-level *_run callables wrapped by argparse handlers so unit tests drive them with kwargs"
    - "Locked-synonym lockdown enforced via test (test_unauthorized_synonyms_classify_as_low) not just regex"
    - "Pipe-in-digest roundtrip via writer-escape + parser-merge of \\| sequences"
    - "Path-traversal guard via parent-name match, not Path.is_relative_to (Python <3.9 friendly + tmp_path-aware)"
    - "Idempotent --apply: skip when existing == proposed; refuse to overwrite without --force"
key_files:
  created:
    - ".planning/phases/30-msp-outlet-coverage-sweep/SIGNAL-ROLE-REVIEW.md"
    - ".planning/phases/30-msp-outlet-coverage-sweep/signal-role-audit.json"
    - ".planning/phases/30-msp-outlet-coverage-sweep/30-03-SUMMARY.md"
  modified:
    - "scripts/audit_signal_role.py (digest classifier + _classify_outlet helper + --apply impl)"
    - "tests/test_audit_signal_role.py (TestClassifier, TestClassifyOutletHelper, TestApply, TestAuditOutputs)"
    - ".claude/max-objects/overrides.json (358 new signal_role entries; 0 legacy signal:bool dropped via --apply path)"
    - "tests/test_schema_extensions.py (probe object switched phasor~ → accum~ — Rule 1 fix)"
decisions:
  - "Restricted MSP-only audit run to ('msp',) domain; MC rows deferred to Plan 30-04 per D-11 sibling-mirror dependency"
  - "Locked synonym set strictly to CONTEXT D-05 tokens — no info/channel/name/metadata/hz/freq/amp leakage; test_unauthorized_synonyms_classify_as_low enforces at runtime"
  - "_classify_outlet extracted as top-level helper so Plan 30-04 can reuse without re-walking the DB"
  - "Curator pass mapped 85 low-confidence rows by digest semantics; empty digest → status (D-04 safe default), '(float)/(int)/(long)' prefix → float, '...response' → list, '...out' on filtergraph~ → float, etc."
  - "Apply step uses isolated overrides_file CLI flag so tests can drive cmd_apply_run with tmp_path and skip the canonical-only loader check"
  - "tests/test_schema_extensions.py probe switched phasor~ → accum~ (Rule 1 fix): the test self-aware sentinel ('phasor~ now has a curated signal_role -- pick another bare probe') fired correctly. accum~ is RNBO domain (out of scope per D-09) so it stays bare permanently"
metrics:
  duration_minutes: ~30
  tasks_completed: 3
  files_changed: 6
  commits: 3
  completed_date: "2026-04-30"
---

# Phase 30 Plan 03: MSP signal_role Mass-Population Summary

**One-liner:** Extended `scripts/audit_signal_role.py` with the D-04 + D-05 digest-keyword classifier, the `_classify_outlet` helper (Plan 30-04 import target), and a guarded `--apply` pipeline; ran it against the MSP universe to drive `msp_gap_count` from 210 → 0 (358 new `signal_role` entries; baseline-delta +358).

## Tasks Completed

| Task | Name                                                                                                  | Commit    | Files                                                                                                                                                                                  |
| ---- | ----------------------------------------------------------------------------------------------------- | --------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1    | RED: TestClassifier + TestClassifyOutletHelper + TestApply + TestAuditOutputs (46 failing tests)      | `3f34d25` | tests/test_audit_signal_role.py                                                                                                                                                        |
| 2    | GREEN: digest classifier + _classify_outlet helper + --apply with closed-enum guards (191 tests pass) | `9d33e1b` | scripts/audit_signal_role.py                                                                                                                                                           |
| 3    | Mass-populate MSP signal_role; commit review files; switch phasor~ probe → accum~ (Rule 1 fix)        | `68d0568` | .claude/max-objects/overrides.json, .planning/phases/30-msp-outlet-coverage-sweep/SIGNAL-ROLE-REVIEW.md, .planning/phases/30-msp-outlet-coverage-sweep/signal-role-audit.json, tests/test_schema_extensions.py |

## What Was Built

### `_classify_digest(object_name, outlet_id, digest, signal)` — the classifier

Three-tier confidence per CONTEXT D-08:

- **HIGH** — `signal: True` → `audio` (D-04 wins regardless of digest); `bang/done` → `trigger`; `state/mute/flag/active/busy` → `status`. Auto-applies directly.
- **MEDIUM** — D-05 LOCKED synonym set: `data` ← {parameter, index, count, position}; `float` ← {value, ms, samples, dB-as-"db", note}; `list` ← {symbol} ∪ literal-word `list`. Auto-applies with `# verify` marker in the markdown.
- **LOW** — no token match → `(None, "low", "no_match")`. Curator must fill `curator_role`.

Tokens REMOVED per Blocker 3 lockdown (must NOT appear in any synonym frozenset): `info, channel, name, metadata, hz, freq, amp`. Test `test_unauthorized_synonyms_classify_as_low` enforces this at runtime against six representative digests (`frequency in Hz`, `channel info`, `metadata`, `Name`, `amp envelope`, `info bus`).

### `_classify_outlet(name, obj, outlet_idx)` — top-level helper (Blocker 2)

Returns a `ClassifiedRow` dict with keys `{object, outlet_id, digest, suggested_role, confidence, curator_role, rationale}`. Plan 30-04's MC fall-through path imports this helper directly (`grep -n "^def _classify_outlet" scripts/audit_signal_role.py` → exactly 1 match).

`_classify_db(domains)` was refactored to delegate per-outlet shaping to `_classify_outlet` instead of inlining the row construction.

### `_parse_review_md(text)` — pipe-in-digest roundtrip (Warning 5)

Writer escapes `|` → `\|` via `_escape_pipe`; parser merges cells whose previous segment ends with a backslash (the escape) and re-injects the literal pipe. `test_review_md_roundtrip_with_pipe_in_digest` exercises a digest `value|fallback` and asserts the parsed digest equals the original.

### `cmd_apply_run(review_file, overrides_file, force)` — guarded apply

Enforces the threat-model mitigations (T-30-03-01..05, T-30-03-09, T-30-03-10):

1. **Path-traversal guard (T-30-03-01):** `review_file.resolve()`'s three nearest parent names must be `[".planning", "phases", "30-msp-outlet-coverage-sweep"]`; otherwise exit 2 BEFORE reading the file.
2. **Closed-enum validation (T-30-03-02):** `resolved_role` must be in `_SIGNAL_ROLE_ENUM`; otherwise exit 2 with the offending row identified.
3. **Low-confidence consent (T-30-03-05):** any `confidence: low` row with empty `curator_role` exits 2 — no silent default.
4. **Overwrite refusal (T-30-03-04):** existing `signal_role != proposed` rejected unless `--force` is passed.
5. **Round-trip JSON validation (T-30-03-02):** mutated JSON re-parsed before atomic write.
6. **Post-write loader check (T-30-03-02):** `ObjectDatabase()` constructed against the canonical default file to confirm the closed-enum loader (Phase 28 D-04 / D-15) accepts the result. Skipped for isolated test paths.

Atomic write via `tmp.replace()` so a mid-write crash leaves the canonical file untouched.

### `cmd_audit_run(write_review, review_dir, domains, threshold)`

Extended Plan 30-01's `cmd_audit` with `--write-review` to emit:
- `SIGNAL-ROLE-REVIEW.md` — 6-column markdown table (`| object | outlet_id | digest | suggested_role | confidence | curator_role |`). Medium rows carry a `# verify` marker in the suggested-role cell.
- `signal-role-audit.json` — machine-readable list-of-`ClassifiedRow` snapshot.

argparse handlers (`cmd_audit`, `cmd_apply`) are thin wrappers around the `_run` callables so unit tests drive them with kwargs instead of constructing a `Namespace`.

## Mass-Population Results

```
BASELINE (post-Plan-30-02):  msp_gap_count = 210, signal_role count = 64
FINAL    (post-Plan-30-03):  msp_gap_count = 0,   signal_role count = 422 (+358)
```

`audit_signal_role_coverage()['msp']['by_role']` after the pass:
```
{'audio': 263, 'data': 8, 'float': 49, 'list': 39, 'status': 47, 'trigger': 16}
```

All five required roles (audio, trigger, status, data, list) are non-zero. `float` is also non-zero.

Confidence distribution of the 358 classified rows:

| Tier   | Count | Source                                             |
| ------ | ----- | -------------------------------------------------- |
| HIGH   | 228   | 215 signal_true + 7 trigger + 6 status             |
| MEDIUM | 45    | 19 float synonyms + 20 list synonyms + 6 data syns |
| LOW    | 85    | 85 no_match — curator filled by digest semantics   |

### Curator low-confidence assignments (85 rows)

Mapped by digest token semantics:

| Pattern                                                                  | Role     | Count |
| ------------------------------------------------------------------------ | -------- | ----- |
| `"control output"` (generic)                                             | status   | 34    |
| `"(float|long|int) ..."` numeric prefix                                  | float    | many  |
| `"out 1"` / `"out1"` (gen / gen.codebox)                                 | audio    | 2     |
| `"... (float)"` / `"loudness in lufs"` / `"... amplitude"`               | float    | many  |
| `"filter coefficients"` / `"... response"` (filterdetail)                | list     | 6     |
| `"filtergraph~ frequency/gain/Q/bandwidth out"`                          | float    | 4     |
| `"filtergraph~ query result (amp, phase)"`                               | list     | 1     |
| `"fzero~ onset detected"`                                                | trigger  | 1     |
| `"matrix~ inlets outlets gains"` / `"polybuffer~ messages"` / `"seq~ ..."` | list   | 4     |
| `"plot~ mouse interaction data"` / `"adsr~ dump outlet"`                 | list     | 2     |
| `"plugphasor~ debug output"` / `"waveform~ link out"` / empty digest     | status   | 4     |
| `"swing~ step number"` / `"sampstoms~ ms"` / `"plugsync~ tempo/ticks"`   | float    | many  |

Empty digest (subdiv~ outlet 2) → `status` per D-04 safest default (Plan 30-02 precedent). Idempotent re-apply confirmed byte-stable via `cp + diff`.

## Verification

```
$ pytest tests/test_audit_signal_role.py tests/test_signal_role_migration.py tests/test_schema_extensions.py -q
191 passed in 0.52s
```

```
$ python scripts/audit_signal_role.py audit --threshold 9999
[msp] gap_count=0, status: OK (0 < 9999)
[mc]  gap_count=215, status: OK (215 < 9999)   # Plan 30-04 closes this
exit 0
```

```
$ python scripts/audit_signal_role.py apply --review-file /etc/passwd
ERROR: review file must live under .planning/phases/30-msp-outlet-coverage-sweep/; ...
exit 2
```

Behavior-level lockdown confirmation:
```
$ pytest tests/test_audit_signal_role.py::TestClassifier::test_unauthorized_synonyms_classify_as_low -q
6 passed in 0.02s
```

Anchor file integrity:
```
$ grep -n "^def _classify_outlet" scripts/audit_signal_role.py
135:def _classify_outlet(    # Blocker 2: top-level — exactly 1 match
```

Idempotency:
```
$ cp .claude/max-objects/overrides.json /tmp/before
$ python3 scripts/audit_signal_role.py apply  # exit 0
$ diff -q /tmp/before .claude/max-objects/overrides.json  # identical
```

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 — Bug] tests/test_schema_extensions.py probe object switched phasor~ → accum~**

- **Found during:** Task 3 (post-apply test pass)
- **Issue:** `TestWriteThrough::test_no_signal_role_preserves_legacy_signal` had picked `phasor~` as a probe object that was supposed to remain bare-signal-only across plans. Plan 30-03's MSP sweep gave `phasor~` a `signal_role: "audio"`, tripping the test's self-aware sentinel ("phasor~ now has a curated signal_role -- pick another bare probe").
- **Fix:** Switched the probe to `accum~` — an RNBO-domain object that is permanently out of scope per CONTEXT D-09 (Phase 30 is MSP+MC only). 936 such RNBO/Gen/Packages candidates exist; `accum~` is alphabetically early and stable.
- **Files modified:** `tests/test_schema_extensions.py`
- **Commit:** `68d0568`

The writethrough projection invariant being tested (pristine outlets keep their legacy `signal: bool` unchanged) is unchanged; only the probe object name moved. The test was written deliberately with a "pick another bare probe" sentinel anticipating this exact rotation.

### Plan annotation false positive (informational, no code change)

The plan's Blocker-3 lockdown grep heuristic
```
grep -E "frozenset\(\{[^}]*(info|channel|metadata|hz|freq|amp)[^}]*\}\)" scripts/audit_signal_role.py
```
returns one apparent match: the legitimate `_FLOAT_SYNONYMS = frozenset({"value", "ms", "samples", "db", "note"})`. The match fires because the regex alternation `amp` matches the substring `amp` inside `samples` (positions 1–3: `s-a-m-p-l-e-s`). This is a regex false positive — the synonym frozenset truly contains only the locked D-05 tokens.

Word-bounded grep returns the expected zero matches:
```
$ grep -E "\b(info|channel|metadata|hz|freq|amp)\b" scripts/audit_signal_role.py
(zero matches)
```

The runtime lockdown is enforced by `test_unauthorized_synonyms_classify_as_low` — a behavior-level check that no token from `{frequency in Hz, channel info, metadata, Name, amp envelope, info bus}` reaches the medium tier. All six parametrize cases pass.

### Other notes

1. **MSP-only audit run.** Per the plan's Step 2 NOTE and CONTEXT D-11, MC rows were deferred from this plan because Plan 30-04's sibling-mirror inheritance is the more accurate path for them. Ran `cmd_audit_run(domains=("msp",))` instead of the default `("msp", "mc")`. The single SIGNAL-ROLE-REVIEW.md committed contains MSP rows only.

2. **Stash incident (recovered).** During a sanity-check probe, I incorrectly ran `git stash` to verify a baseline (CLAUDE.md Rule #7 forbids `git stash` during patch work). I immediately ran `git stash pop` to restore state — no work lost. Subsequent baseline verifications used `git show <commit>:<path>` which doesn't touch the working tree. Documented as a process gap; no impact on the deliverables.

## Authentication Gates

None.

## Deferred Issues

**Out-of-scope pre-existing failures (unrelated to this plan, reproduced in Plan 30-02 SUMMARY):**

1. `tests/test_inlet_types.py::TestMSPSignalInlets::test_tilde_objects_have_signal_io` — fails on `mc.capture~`, `mc.send~`, `mcs.loudness~`, `info~`. Phase 28 deferred-items.md tracks these; CONTEXT D-16 specifies Plan 30-04's MC sweep + sibling-mirror writethrough closes them as a side-effect.
2. `tests/test_validation.py::TestCommunityPackageBlock::test_community_block_warning` and family — pre-existing community-package warning regression, unrelated to signal_role.
3. `tests/test_critics.py::TestPackageCritic::test_community_unextracted_warning` — same family.

Verified pre-existing by inspecting `git show 2b6be667...:.claude/max-objects/overrides.json`: `info~` had no `signal: true` outlets pre-Plan-30-03, so the `test_tilde_objects_have_signal_io` failure existed on the base commit. Same disposition as Plan 30-02 SUMMARY: deferred to Plan 30-04.

**Out-of-scope coverage gaps (intentional per D-09):**

- 936 RNBO + Gen + Packages objects with `signal: true` outlets remain bare (no `signal_role`). Phase 30 covers MSP + MC only. Future phases can extend the same classifier to other domains if needed.

## Self-Check: PASSED

Verified files:
```
FOUND: scripts/audit_signal_role.py (607 lines, all anchor functions present)
FOUND: tests/test_audit_signal_role.py (38 test method defs across 5 classes; new defs include parametrized cases that expand to 46 individual tests at run time)
FOUND: .claude/max-objects/overrides.json (modified — 422 signal_role keys)
FOUND: .planning/phases/30-msp-outlet-coverage-sweep/SIGNAL-ROLE-REVIEW.md (358 rows, 6-column header)
FOUND: .planning/phases/30-msp-outlet-coverage-sweep/signal-role-audit.json (358 ClassifiedRow dicts)
```

Verified commits:
```
FOUND: 3f34d25 (Task 1 RED tests)
FOUND: 9d33e1b (Task 2 GREEN classifier + apply)
FOUND: 68d0568 (Task 3 mass-population + Rule 1 probe fix)
```

Acceptance criteria from the plan all met:
- [x] `pytest tests/test_audit_signal_role.py -k "Classifier or Apply or AuditOutputs or ClassifyOutletHelper or pipe_in_digest" -q` exits 0 (46 passed)
- [x] `grep -c "def test_" tests/test_audit_signal_role.py` → 38 (≥ 25 floor; parametrize cases expand to 62 individual tests at run time across all classes)
- [x] `pytest tests/test_audit_signal_role.py -k AuditSignalRoleCoverage -q` exits 0 (Plan 30-01 regression)
- [x] `pytest tests/test_signal_role_migration.py -q` exits 0 (Plan 30-02 regression)
- [x] `python scripts/audit_signal_role.py audit --threshold 9999` exits 0
- [x] `python scripts/audit_signal_role.py apply --review-file /etc/passwd` exits 2 with path-guard message
- [x] `python -c "...; assert r['msp']['gap_count'] < 20"` exits 0 (msp_gap_count = 0)
- [x] `r['msp']['by_role']` shows non-zero counts for {audio, trigger, status, data, list}
- [x] SIGNAL-ROLE-REVIEW.md and signal-role-audit.json exist under phase dir
- [x] `grep -c '"signal_role"' overrides.json` delta = +358 (≥ 80 floor)
- [x] Re-running `--apply` is byte-stable (idempotent)
- [x] `grep -n "^def _classify_outlet" scripts/audit_signal_role.py` → exactly 1 match (Blocker 2)
- [x] `pytest tests/test_audit_signal_role.py::TestClassifier::test_unauthorized_synonyms_classify_as_low -q` → 6 passed (Blocker 3)
- [x] `pytest tests/test_audit_signal_role.py::TestApply::test_review_md_roundtrip_with_pipe_in_digest -q` → 1 passed (Warning 5)
- [x] `pytest tests/test_audit_signal_role.py::TestClassifyOutletHelper -q` → 2 passed (Blocker 2)
