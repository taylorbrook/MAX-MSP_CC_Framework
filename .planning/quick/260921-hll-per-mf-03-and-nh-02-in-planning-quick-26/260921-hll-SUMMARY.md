---
phase: quick-260921-hll
plan: 01
subsystem: db_lookup
status: complete
tags: [db-health, warnings, audit, MF-03, NH-02]
requires: []
provides:
  - "ObjectDatabase.audit_half_empty_io() — one-side-empty audit surface (sinks/sources)"
  - "empty-I/O lookup warning aligned with audit_empty_io() (both-sides-empty rule)"
affects:
  - src/maxpat/db_lookup.py
  - tests/test_db_lookup.py
  - CLAUDE.md
tech-stack:
  added: []
  patterns:
    - "warning-predicate/audit-predicate parity pinned by a whole-DB equality test, not by code inspection"
    - "junit per-test outcome diff (before/after) as the regression instrument, never suite totals"
key-files:
  created: []
  modified:
    - src/maxpat/db_lookup.py
    - tests/test_db_lookup.py
    - CLAUDE.md
decisions:
  - "D-01: align the warning with the audit (both sides empty) rather than keep the stricter check plus a sink/source exemption list — an exemption list is a second source of truth that drifts"
  - "D-02: the one-side-empty information moves to audit_half_empty_io(), it is not deleted"
  - "D-03: lookup_strict() and has_complete_io() left byte-unchanged; both keep the stricter both-sides-populated rule"
  - "D-04: verification is per-test via junit outcome maps, never by suite totals"
metrics:
  duration: ~12 min
  completed: 2026-09-21
actuals:
  tokens: 4000
  tasks: 3
  commits: 2
  plan_head_before: 592edfef4d7a7bc919ec267a05f46fb30f77c4b7
---

# Quick Task 260921-hll: Align Empty-I/O Warning Predicate + audit_half_empty_io() Summary

Closed MF-03 and NH-02: `lookup()`'s empty-I/O warning now fires on the same both-sides-empty rule as `audit_empty_io()` (218 → 9 warned names), and the 209 one-side-empty entries it no longer covers moved to a new `audit_half_empty_io()` surface — dropping the suite warning count from 487 to 9 with zero pre-existing test outcomes changed.

## What Was Built

**The problem.** Two predicates in `src/maxpat/db_lookup.py` disagreed about what "empty I/O" means. `audit_empty_io()` required **both** sides empty (9 hits). `_maybe_warn_empty_io()` fired when **either** side was empty (218 hits). The 209-name gap was almost entirely correct data — 109 zero-outlet sinks (`dac~`, `ezdac~`, `scope~`, `send~`, `print`, `panel`, `outlet`, `out~`, `mc.dac~`) and 100 zero-inlet sources (`begin~`, `bp.Input`, …) — each emitting "patch generation may fail silently" on every lookup and burying the real signal in 487 warnings per suite run.

**The fix (D-01).** `_maybe_warn_empty_io` returns early when **either** side is populated, so it fires only when both are empty — bit-for-bit the rule `audit_empty_io()` applies at its own `continue` guard. The `variable_io_rules` short-circuit, the `_empty_io_warned` dedup, the `UserWarning` category, `stacklevel=3`, and the message text are all unchanged (the message is asserted by pre-existing tests).

**The replacement channel (D-02).** `audit_half_empty_io()` returns `{"sinks": [...], "sources": [...]}` — the one-side-empty set, sorted, excluding `variable_io_rules` entries exactly as `audit_empty_io()` does. The union of this result and `audit_empty_io()`'s both-empty buckets is precisely what the old warning predicate covered: the information channel moved, it was not deleted.

**The anti-drift guard.** `test_warning_predicate_matches_audit_empty_io_exactly` sweeps `lookup()` over every canonical in the DB and asserts the warned-name set is **equal** to `audit_empty_io()["critical"] | ["covered_by_override"]`. Equality, not a count — this is what stops the two predicates silently diverging again. Both the test and the probe filter warnings by message substring, because `_maybe_warn_install_state` shares the `UserWarning` category and would otherwise be miscounted.

## Measured Results

### Probe (predicate agreement)

| Reading | Before | After |
|---|---|---|
| `WARNED` (names emitting the empty-I/O warning) | 218 | **9** |
| `AUDIT_BOTH_EMPTY` (`critical` + `covered_by_override`) | 9 | 9 |
| `MATCH` (sorted name lists equal) | **False** | **True** |

### Full suite (pytest)

| Metric | BEFORE | AFTER | Delta |
|---|---|---|---|
| passed | 2180 | 2186 | +6 (the new tests) |
| failed | 0 | 0 | 0 |
| errors | 0 | 0 | 0 |
| skipped | 0 | 0 | 0 |
| xfailed | 6 | 6 | 0 |
| **warnings** | **487** | **9** | **−478 (−98.2%)** |
| junit testcases | 2186 | 2192 | +6 |

Runtime 31.96s → 32.41s.

### Per-test outcome diff (D-04)

`compare_junit.py before.xml after.xml` → exit **0**:

```
SUMMARY: before=2186 after=2192 changed=0 missing=0 new=6
```

**Zero pre-existing tests changed outcome; zero went missing.** The only inventory change is six `NEW:` additions, all passing:

- `test_lookup_does_not_warn_for_zero_outlet_sink`
- `test_lookup_does_not_warn_for_zero_inlet_source`
- `test_empty_io_warning_message_names_the_object`
- `test_warning_predicate_matches_audit_empty_io_exactly`
- `test_audit_half_empty_io_shape`
- `test_audit_half_empty_io_matches_brute_force_oracle`

The baseline was already green (quick task 260921-gut triaged the 9 MF-02 failures), and no pre-existing failure was "fixed" as a side effect — per D-04 that would have been a failed verification, not a bonus.

## TDD Evidence

Tests were written first and observed RED before implementation:

```
FAILED test_lookup_does_not_warn_for_zero_outlet_sink
FAILED test_lookup_does_not_warn_for_zero_inlet_source
FAILED test_warning_predicate_matches_audit_empty_io_exactly
FAILED test_audit_half_empty_io_shape                     - AttributeError
FAILED test_audit_half_empty_io_matches_brute_force_oracle - AttributeError
5 failed, 1 passed
```

All five required RED tests failed for the intended reasons — 1/2/4 because the predicate still fired on one-side-empty entries, 5/6 with `AttributeError: 'ObjectDatabase' object has no attribute 'audit_half_empty_io'`. Test 3 (message contract) passed at RED by design; it pins existing behavior the change must not alter. After implementation: `174 passed` across `test_db_lookup.py`, `test_schema_extensions.py`, `test_audit_signal_role.py`.

## Explicit Non-Change: lookup_strict() / has_complete_io() (D-03)

Both keep the stricter "both sides populated" rule and are **byte-unchanged**, including their docstrings, which correctly describe that stricter rule. Grep evidence that neither has a production call site:

```
grep -rn "lookup_strict\|has_complete_io" --include="*.py" src/ tools/
```

returns only the definitions in `db_lookup.py` — their behavior is API surface exercised solely by tests. Changing them is a wider blast radius than MF-03 asks for. The only diff line mentioning them is the new cross-reference in `_maybe_warn_empty_io`'s docstring.

## Canary Preconditions (measured 2026-09-21)

Each canary test asserts its precondition first, so a DB change surfaces as a clear precondition failure rather than a confusing assertion failure:

| Canary | inlets | outlets | variable_io rule | Role |
|---|---|---|---|---|
| `dac~` | 2 | 0 | no | zero-outlet sink |
| `begin~` | 0 | 1 | no | zero-inlet source |
| `dsp` | 0 | 0 | no | both-empty (still warns) |

Bucket sizes at implementation time: 9 both-empty, 109 sinks, 100 sources — matching the plan's planning-time measurements exactly. Test 6 asserts the buckets are non-empty without hard-coding those numbers.

## Deviations from Plan

**1. [Scope — orchestrator directive] Docs artifacts split out of the task commit**

The plan's Task 3 step 7 specified a single commit covering code, tests, `CLAUDE.md`, `.planning/STATE.md`, and this SUMMARY. The orchestrator directed that SUMMARY/STATE and the docs commit are orchestrator-owned and that the executor must not edit `.planning/STATE.md`. Accordingly:

- **Task 3 step 6 (add the `260921-hll` row to STATE.md, refresh Last activity) was NOT performed — it is orchestrator-owned.**
- The work landed as **two** commits instead of one: code+tests, then the `CLAUDE.md` sentence.

Nothing else in Task 3 changed; the CLAUDE.md edit and both code/test commits are the executor's and are complete.

**2. [Rule 3 — blocking, environmental] Concurrent instance committed to `main` mid-run**

The plan's working-tree hazard listed two unrelated modified files. During execution a second instance (FDNVerb project) additionally modified `patches/FDNVerb/generated/FDNverb.gendsp`, added untracked `patches/FDNVerb/versions.json` and `patches/patches/`, and **committed twice to `main`** — `d9e0ef6` (interleaved between my two commits) and `5c56163` (after them).

Consequence: the Task 3 verify gate's `git show ... HEAD -- patches/` assertion failed, because `HEAD` was no longer my commit. This is an artifact of the shared branch, not a defect in the work. The substantive assertion was re-run against my actual commits and holds:

```
cc70854  patches/ bytes: 0   → src/maxpat/db_lookup.py, tests/test_db_lookup.py
e85398f  patches/ bytes: 0   → CLAUDE.md
```

Both are ancestors of `HEAD`. Neither staged, committed, reverted, nor stashed anything under `patches/`; all concurrent-instance files remain modified-but-unstaged (` M` prefix) or untracked. Only explicit paths were ever staged — no `git add .`, no `git add -A`, no `git stash` (CLAUDE.md Rule #7).

This also contaminates the ledger commit count: `git rev-list --count 592edfe..HEAD` reports **4**, of which only **2** are this task's. The frontmatter records `commits: 2` (mine, verified by `git show --name-only` per commit) with the foreign pair named above.

No other deviations — no bugs found, no missing critical functionality, no architectural changes, no package installs.

## Commits

| Commit | Scope | Files |
|---|---|---|
| `cc70854` | `fix(db-lookup): align empty-I/O warning with audit predicate, add audit_half_empty_io (MF-03, NH-02)` | `src/maxpat/db_lookup.py`, `tests/test_db_lookup.py` |
| `e85398f` | `docs(claude-md): note aligned empty-I/O warning predicate and audit_half_empty_io (MF-03, NH-02)` | `CLAUDE.md` |

Base (`plan_head_before`): `592edfef4d7a7bc919ec267a05f46fb30f77c4b7`.

Interleaved foreign commits on `main` from a concurrent instance, not part of this task: `d9e0ef6`, `5c56163`.

## Measurement Artifacts

All under the session scratchpad, never in the repo (per the working-tree safety constraint):

```
$SCRATCH/probe_empty_io_warnings.py   instrument: WARNED / AUDIT_BOTH_EMPTY / MATCH, always exit 0
$SCRATCH/compare_junit.py             per-test outcome diff, non-zero on any changed/missing pre-existing test
$SCRATCH/before.xml  / after.xml      junit outcome maps (2186 / 2192 testcases)
$SCRATCH/before-summary.txt / after-summary.txt   pytest tail lines carrying the warning counts
$SCRATCH/before-probe.txt / after-probe.txt       218/9/False → 9/9/True
```

## Requirements Closed

- **MF-03** — the two predicates now apply the same rule, proven by a whole-DB equality assertion rather than code inspection.
- **NH-02** — `audit_half_empty_io()` exists and is verified against an independent brute-force oracle.

**Still open** from `.planning/quick/260921-g5d-review-this-repo-to-see-if-there-are-any/260921-g5d-REVIEW-FINDINGS.md`: follow-up items **4, 5 and 6** of the review's task table remain unaddressed by this task.

## Known Stubs

None. No stubs, skipped tests, or unrun verifications were introduced. (`.planning/WINDOWS.md` does not exist in this project; no ledger entry was appended.)

## Threat Flags

None. This task touched no network, no user input, no authentication, and installed no packages. T-hll-01 (narrowing could mask a genuinely broken one-side-empty entry) is mitigated as planned: the channel moved to `audit_half_empty_io()`, the equality test prevents future drift, and `lookup_strict()`/`has_complete_io()` retain the stricter rule. T-hll-03 (git index / concurrent-instance files) is mitigated and was actively exercised — see Deviation 2.

## Self-Check: PASSED

- `src/maxpat/db_lookup.py` — FOUND, `audit_half_empty_io` defined (1 occurrence)
- `tests/test_db_lookup.py` — FOUND, 6 new tests passing
- `CLAUDE.md` — FOUND, contains `audit_half_empty_io`
- Commit `cc70854` — FOUND in `main` history, ancestor of HEAD
- Commit `e85398f` — FOUND in `main` history, ancestor of HEAD
- `$SCRATCH/before.xml`, `after.xml`, `before-summary.txt`, `after-summary.txt`, `before-probe.txt`, `after-probe.txt`, both helper scripts — all FOUND and non-empty
