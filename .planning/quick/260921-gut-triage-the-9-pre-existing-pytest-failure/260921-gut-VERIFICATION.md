---
phase: quick-260921-gut
verified: 2026-09-21T00:00:00Z
status: passed
score: 6/6 must-haves verified
covered_files:
  - .planning/quick/260921-gut-triage-the-9-pre-existing-pytest-failure/260921-gut-PLAN.md
  - .planning/quick/260921-gut-triage-the-9-pre-existing-pytest-failure/260921-gut-SUMMARY.md
  - tests/review_blocker_allowlist.json
  - tests/test_integration_patches.py
  - tests/test_round_trip.py
  - tests/test_signal_role_migration.py
covered_digest: "v1:sha256:359d867780625a4134ac6cb3f2e5f217752f0e0a0feb5e4e0e2d702d58b1aeae"
behavior_unverified: 0
overrides_applied: 0
---

# Quick Task 260921-gut: Triage the 9 Pre-existing Pytest Failures — Verification Report

**Phase Goal:** Return `python3 -m pytest -q` to a green baseline by individually root-causing and resolving the 9 pre-existing failures recorded under REVIEW-FINDINGS MF-02, without touching `patches/`.
**Verified:** 2026-09-21
**Status:** passed
**Re-verification:** No — initial verification

## Goal Achievement

### Observable Truths

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| 1 | `python3 -m pytest -q` exits 0 from the repo root | ✓ VERIFIED | Ran independently: `2178 passed, 6 xfailed, 487 warnings` (run count drifted +2 from the SUMMARY's 2176 solely because a concurrent Claude instance landed unrelated `patches/terrain-synth` commits between my runs — confirmed via `git log`; `0 failed` held in every run). Exit code captured explicitly: `EXIT=0`. |
| 2 | All 9 previously-failing node ids resolve to passed or xfailed — none failed | ✓ VERIFIED | Ran the exact 9 node ids in one invocation: `7 passed, 2 xfailed in 0.30s`. The 2 xfails are the two `TestSubpatcherByteIdentity` params (performance-patch-template, scala-synth), matching the plan's expected disposition. |
| 3 | Each of the 9 failures has its individual root cause recorded in the artifact that implements its resolution | ✓ VERIFIED | 6 allowlist entries each carry a distinct `reason` field (437–556 chars, all substantively different — preset-inherent x3, signal/matrix-domain x2, genuine control debt x1); 2 round-trip exemptions carry root cause in the test docstring + runtime `pytest.xfail` message; 1 anchor fix carries root cause in the test docstring. Read all three files directly. |
| 4 | scala-synth byte-identity retains REAL coverage: the assertion still executes and passes against the clean committed blob | ✓ VERIFIED | Independently re-ran the plan's own verification script against `git show HEAD:patches/scala-synth/generated/scala-synth.maxpat`: `semantic OK, byte-identical OK, bytes 162823 -> 162823`, `compact arrays at HEAD: 0`. The dynamic detector correctly does NOT exempt this file at HEAD — a real byte-for-byte assertion executes and passes. |
| 5 | No file under `patches/` is modified, staged, or reverted | ✓ VERIFIED | `git status --porcelain -- patches/` shows only the two pre-existing user modifications (`.active-project.json`, `scala-synth.maxpat`) unchanged from session start. `git diff --cached --name-only -- patches/` is empty. `git diff --name-only dacd83f^..784a54d` touches only the three test-layer files — zero hits under `patches/` or `src/`. |
| 6 | Round-trip semantic losslessness is asserted for every parametrized patch, including ones exempted from byte identity | ✓ VERIFIED | Read `tests/test_round_trip.py` lines 1378–1382: the unconditional `assert result == original` runs first, unconditionally, before the compact-array check and the `pytest.xfail` call — for all 3 parametrized files including the 2 exempted ones. |

**Score:** 6/6 truths verified (0 present, behavior-unverified)

### Independent Mutation-Test Re-Verification (going beyond SUMMARY's claim)

The SUMMARY claims the de-brittled anchors "still fail if the consumer read pattern is deleted," backed by a mutation test whose output it reproduces. Rather than trust that narrative, I reproduced the mutation independently (in `/private/tmp`, never touching the real repo files) using the actual shape constants imported from `tests.test_signal_role_migration`:

- Genuinely removing one of the 4 `dsp_critic.py` consumer sites (rewriting `outlettype`/`_SIGNAL_OUTLET_TYPES` substrings away on that one line, not just renaming — my first attempt used a suffix-append which was a false negative because the mutated identifier still contained the original as a substring; corrected and re-ran) → site count drops to 3, which is `< _DSP_CRITIC_MIN_CONSUMER_SITES (4)` → **anchor trips**, confirmed.
- Removing the single `patcher.py` consumer site → site count drops to 0, which is `< _PATCHER_MIN_CONSUMER_SITES (1)` → **anchor trips**, confirmed.

Both anchors are genuine regression detectors, not just non-empty checks.

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `tests/test_signal_role_migration.py` | Property-based (not line-indexed) back-compat anchors | ✓ VERIFIED | No `lines[N]` positional index remains in executable code; anchors use `_find_consumer_sites()` + site-count floors. |
| `tests/test_round_trip.py` | Content-derived byte-identity exemption + unconditional semantic assertion | ✓ VERIFIED | `count_max_compact_arrays()` + `_MAX_COMPACT_ARRAY_RE` implement content detection; no static xfail marker remains on any of the 3 parametrized files. |
| `tests/review_blocker_allowlist.json` | 6 new signature-scoped entries with distinct reasons | ✓ VERIFIED | 20 total patch keys (14 original + 6 new); all 6 new entries carry `severity`/`kind`/`source`/`source_id`/`outlet`/`destinations`/`reason` matching the existing entry shape. |

### Key Link Verification

| From | To | Via | Status | Details |
|------|-----|-----|--------|---------|
| `review_blocker_allowlist.json` path keys | `_is_allowlisted()` in `tests/test_integration_patches.py` | `patch_path.relative_to(_REPO_ROOT).as_posix()` | ✓ WIRED | Read `_is_allowlisted`/`_entry_key`/`_blocker_match_key` directly (lines 54–93): matching is per-patch dict lookup + `(kind, source_id, outlet)` tuple equality — confirmed signature-scoped, not path-only. A new blocker on an already-allowlisted patch with a different `(source_id, outlet)` would NOT match and would still fail. |
| New allowlist entry fields (`kind`/`source_id`/`outlet`) | `_entry_key()` | direct field read, unknown fields (`reason`) ignored | ✓ WIRED | Confirmed `_entry_key()` only reads `kind`, `source_id`, `outlet`/`inlet`, `destinations` — `reason` is safely ignored, exactly as claimed. |
| MAX-compact-array detection in source text | `json.dumps(indent=N)` structural inability | `count_max_compact_arrays()` gates `pytest.xfail` | ✓ WIRED | Confirmed via independent run against the HEAD scala-synth blob: 0 compact lines detected → no xfail → real byte-identity assertion executes and passes. |

### Behavioral Spot-Checks

| Behavior | Command | Result | Status |
|----------|---------|--------|--------|
| Full suite exits 0 | `python3 -m pytest -q` (run twice, independently) | `2176→2178 passed, 6 xfailed, 0 failed` both times; `EXIT=0` captured explicitly | ✓ PASS |
| All 9 original node ids resolve | single `pytest -q <9 node ids> -v` invocation | `7 passed, 2 xfailed` | ✓ PASS |
| Committed scala-synth blob passes real byte-identity | plan's own verify script re-run against `git show HEAD:...` | `clean HEAD blob: semantic OK, byte-identical OK, bytes 162823 -> 162823` | ✓ PASS |
| Anchors are mutation-sensitive (not just non-empty checks) | independent mutation of shape-scan logic in scratch, not touching repo files | both anchors trip below their floors on genuine single-site removal | ✓ PASS |
| Commit diff scope excludes `patches/` and `src/` | `git diff --name-only dacd83f^..784a54d` | only the 3 test-layer files | ✓ PASS |
| `patches/` dirty set unchanged | `git status --porcelain -- patches/` | same 2 pre-existing files, nothing staged | ✓ PASS |

### Requirements Coverage

| Requirement | Source Plan | Description | Status | Evidence |
|-------------|------------|-------------|--------|----------|
| MF-02 | 260921-gut-PLAN.md | Triage the 9 baseline test failures to green or explicit xfail | ✓ SATISFIED | All 9 node ids resolve; suite is green; each carries an individually recorded root cause. |

**Correction to REVIEW-FINDINGS MF-02 verified independently:** the original finding claimed the committed scala-synth blob fails byte identity at HEAD (`162823 -> 162824`). I re-ran the exact byte-comparison against `git show HEAD:patches/scala-synth/generated/scala-synth.maxpat` myself and confirmed it round-trips byte-identical (`162823 -> 162823`, 0 compact-array lines). The correction recorded in the SUMMARY and in the `test_round_trip.py` docstring is accurate, not a self-serving claim.

### Anti-Patterns Found

None. Scanned the diffs of all three modified files for `TBD`/`FIXME`/`XXX`/`TODO`/`HACK`/`PLACEHOLDER`, empty-return stubs, and hardcoded-empty-data patterns — none present. No assertion was loosened; both round-trip and anchor changes are strict strengthenings (unconditional semantic assertion added; site-count floor added instead of a bare non-empty check).

### Human Verification Required

None. All must-haves resolve to programmatically-verifiable evidence (git diffs, live pytest runs, independent mutation testing).

### Gaps Summary

None. All 6 must-have truths verified against live command output and direct file reads, not SUMMARY narrative. The one place I initially got a discrepant result (my first mutation-test attempt on `dsp_critic.py` produced a false negative because I appended a suffix to the constant name rather than genuinely removing the read) was traced to my own test methodology, corrected, and re-run — it does not reflect a flaw in the phase's work.

---

_Verified: 2026-09-21_
_Verifier: Claude (gsd-verifier)_
