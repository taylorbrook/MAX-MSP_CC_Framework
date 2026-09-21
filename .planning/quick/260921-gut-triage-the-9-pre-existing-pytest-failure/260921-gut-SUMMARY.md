---
phase: quick-260921-gut
plan: 01
subsystem: tests
tags: [test-suite, regression-gate, allowlist, round-trip, anchors]
status: complete

requires: []
provides:
  - green pytest baseline (exit 0) restored as a change gate
  - property-based back-compat consumer anchors (no positional line indices)
  - content-derived byte-identity exemption for MAX-compact .maxpat files
  - unconditional semantic round-trip assertion for every parametrized patch
affects:
  - tests/test_signal_role_migration.py
  - tests/test_round_trip.py
  - tests/review_blocker_allowlist.json

tech-stack:
  added: []
  patterns:
    - "anchor a property (accepted read shapes + site-count floor), never a source coordinate"
    - "content-derived test exemption over static per-file xfail, so coverage self-restores"

key-files:
  created: []
  modified:
    - tests/test_signal_role_migration.py
    - tests/test_round_trip.py
    - tests/review_blocker_allowlist.json

decisions:
  - "Byte-identity exemption is detection-based only; no static xfail marker for any file, so a clean re-save silently restores full coverage."
  - "Compact-array detector requires whitespace after `[` to avoid false-positives on string payloads containing a subscript like `[0]`."
  - "dsp_critic consumer-site floor set to 4 (the count at conversion time) so deleting any one consumer trips the anchor."
  - "Allowlist `destinations` written from a live review_patch() probe, not from the plan's transcribed table."

metrics:
  duration: ~25 min
  completed: 2026-09-21

actuals:
  tokens: 6634       # chars/4 over the realized diff (26,534 chars across 3 files)
  tasks: 3
  commits: 0         # commits are orchestrator-owned this run (see Commit Ownership)
  plan_head_before: 0d0f1cf
---

# Quick Task 260921-gut: Triage the 9 Pre-existing Pytest Failures Summary

Returned `python3 -m pytest -q` to a green baseline by individually root-causing all 9 pre-existing failures: 1 fixed outright, 2 dynamically exempted by content detection, 6 allowlisted with distinct recorded reasons — with zero files under `patches/` and zero files under `src/maxpat/` touched.

## Success Gate

**Final pytest summary line, verbatim:**

```
2176 passed, 6 xfailed, 487 warnings in 34.05s
```

**Exit code:** `pytest exit=0`

Measured at `HEAD e34ec76` (see Concurrency Note — HEAD moved repeatedly during the run; the suite was re-verified green against the latest tree).

**Collection parity:** 2182 tests collected before (9 failed + 2169 passed + 4 xfailed) and 2182 after (2176 passed + 6 xfailed). No test was deleted, skipped wholesale, or had an assertion loosened. The xfail count rose 4 → 6 because byte-identity exemptions became dynamic (3 dynamic xfails replace 1 static one).

## Live Failure Set vs Plan

Per orchestrator override 2, the live failure list was measured before any edit. It is **identical** to the 9 recorded under MF-02 — no drift, despite the three bassoon-model commits (24a32a5..0d0f1cf) that landed after planning. No extra failure appeared, so no out-of-group improvisation was needed.

## Resolution of All 9 Node IDs

| # | Node ID | Root cause | Resolution | Reason recorded in |
|---|---------|-----------|------------|--------------------|
| 1 | `test_review_patch_no_blockers[patches/looper/generated/looper.maxpat]` | Patch added after the allowlist was committed (85b8f92, 2026-07-02); carries one fan-out blocker (`inlet` obj-51 outlet 0 → `gen~`, `meter~`) that is signal-domain, where CLAUDE.md Rule #3 says ordering does not apply | Allowlisted | `review_blocker_allowlist.json` → looper entry `reason` |
| 2 | `test_review_patch_no_blockers[.../reverse-delay-mono.maxpat]` | Same staleness; one `preset` obj-2 outlet 0 fan-out to 24 bound controls — a preset's cords to its controls *are* the binding and cannot be trigger-sequenced | Allowlisted | allowlist → reverse-delay-mono entry `reason` |
| 3 | `test_review_patch_no_blockers[.../reverse-delay.maxpat]` | Same, stereo variant: `preset` obj-2 outlet 0 → 25 bound controls (one extra umenu vs mono) | Allowlisted | allowlist → reverse-delay entry `reason` |
| 4 | `test_review_patch_no_blockers[.../simple-fm.maxpat]` | Same staleness; `kslider` obj-1 outlet 1 (velocity) → `select`, `makenote`. **Genuine control-rate fan-out debt** — the real Rule #4 pattern, exempted only because the patch is frozen | Allowlisted | allowlist → simple-fm entry `reason` |
| 5 | `test_review_patch_no_blockers[.../stereo-feedback-delay.maxpat]` | Same staleness; `preset` obj-59 outlet 0 → 8 `dial` (homogeneous bank) | Allowlisted | allowlist → stereo-feedback-delay entry `reason` |
| 6 | `test_review_patch_no_blockers[.../terrain-osc-test.maxpat]` | Same staleness; `jit.matrix` obj-18 outlet 0 → `trigger`, `jit.cellblock`. Matrix output is a by-reference handoff, and one branch is already a `trigger` | Allowlisted | allowlist → terrain-osc-test entry `reason` |
| 7 | `TestSubpatcherByteIdentity::test_byte_identical_round_trip[.../performance-patch-template.maxpat]` | File is MAX-saved compact inline arrays **at HEAD** (329 compact lines), which `json.dumps(indent=N)` structurally cannot reproduce. Permanent until re-saved by the framework | Dynamically exempted (xfail via detection) | `test_round_trip.py` → test docstring + runtime `pytest.xfail` reason string |
| 8 | `TestSubpatcherByteIdentity::test_byte_identical_round_trip[.../scala-synth.maxpat]` | **Working-tree-only.** The committed blob round-trips byte-identical; the uncommitted MAX-re-saved copy on disk (319 compact lines) does not | Dynamically exempted while the dirty copy sits on disk; auto-restores to a real assertion when it does not | `test_round_trip.py` → test docstring + runtime `pytest.xfail` reason string |
| 9 | `TestBackCompatConsumerAnchors::test_dsp_critic_outlet_signal_read_pattern_unchanged` | Test asserted a **hard-coded line index** (line 301). `dsp_critic.py` grew lines — most recently `b1a68c9 fix(critics): recognize multichannelsignal as a signal outlet type` — so the anchored `outlettype` read relocated while the behavior stayed fully intact. The test asserted a location, not a property | **Fixed outright** | `test_signal_role_migration.py` → docstring of that test |

## Correction to REVIEW-FINDINGS MF-02

MF-02 claims the **committed** `scala-synth.maxpat` blob also fails byte identity at HEAD (`162823 -> 162824`). **That claim is wrong.** Measured directly against `git show HEAD:patches/scala-synth/generated/scala-synth.maxpat`:

```
HEAD scala-synth: semantic=True  bytes 162823->162823  identical=True   compact_lines=0
WT   scala-synth: semantic=True  bytes 100771->161735  identical=False  compact_lines=319
```

The committed blob round-trips **byte-identical**, 162823 → 162823, with zero compact arrays. Only the user's uncommitted 100,771-byte MAX-re-saved working-tree copy fails. This is why a static `xfail` on scala-synth was forbidden here: it would have permanently masked a test that genuinely passes on committed state. Detection is therefore the sole mechanism — the moment the clean blob is what sits on disk, real byte-identity coverage returns by itself with no code change.

## What Was Built, Per Task

### Task 1 — De-brittle the back-compat consumer anchors
**File changed:** `tests/test_signal_role_migration.py`

Precondition verified first: `dsp_critic.py` still contains four `src_outlettype[...] in _SIGNAL_OUTLET_TYPES` reads (lines 207, 306, 408, 436), so the consumer surface is intact and adjusting the test is correct rather than a mask.

- Added module-level read-shape helpers: `_OUTLET_SIGNAL_READ_SHAPES`, `_DSP_CRITIC_READ_SHAPES`, `_find_consumer_sites()`, `_format_sites()`. A "read shape" is a tuple of substrings that must all appear on one line, so the `outlettype` membership test counts as a *site* while the bare `src_outlettype = ...` setup line above it does not.
- Both anchors now scan the whole file and assert a **site-count floor** — `_DSP_CRITIC_MIN_CONSUMER_SITES = 4`, `_PATCHER_MIN_CONSUMER_SITES = 1` — with matched line numbers included in the assertion message so future drift is self-diagnosing.
- Applied the identical restructuring to the `patcher.py` sibling anchor, which passed only by luck and carried the same anti-pattern (a scheduled recurrence of failure #9).
- Updated module-header prose, inline comments and docstrings that named `dsp_critic.py:301` / `patcher.py:250` to describe the anchored property instead of a coordinate.

**Intent preserved, proven by mutation test** (run read-only against copies in the scratchpad, no source files touched):

```
dsp_critic sites: [207, 306, 408, 436]     patcher sites: [250]
dsp_critic mutation (delete one consumer): 3 < 4 -> anchor trips OK
patcher mutation (rewrite the read away):  0 < 1 -> anchor trips OK
```

Verification: `82 passed`; no positional `lines[N]` index survives in executable code.

### Task 2 — Content-derived byte identity + unconditional semantic assertion
**File changed:** `tests/test_round_trip.py`

Precondition verified first (the MF-02 correction above) — the HEAD blob passes, so the planned root cause holds and the task proceeded.

- Added an **unconditional** semantic-losslessness assertion (`from_dict(o).to_dict() == o`) that runs for every parametrized patch **before** any exemption, including exempted ones. This is net-new coverage — no such assertion existed — and it is what actually proves `Patcher` loses no data.
- Added `count_max_compact_arrays()` + `_MAX_COMPACT_ARRAY_RE` for content-derived detection of MAX-saved compact inline numeric arrays; on detection the test calls `pytest.xfail` with a reason naming the file, the compact-line count, and the fact that semantic equality already passed.
- Removed the static `xfail` marker from the `minitaur` param (detection subsumes it); the param itself stays. No static marker added for `performance-patch-template` or `scala-synth`.
- Recorded both individual root causes in the test docstring.

**Detector validated before wiring in** — predicted byte identity matched actual outcome in **11/11** files (all ten parametrized project patches plus the committed scala-synth blob), including reproducing the plan's exact 329-compact-line count for `performance-patch-template`:

```
compact=   0  predicted=True   actual=True   HEAD scala-synth
compact= 319  predicted=False  actual=False  scala-synth (working tree)
compact= 329  predicted=False  actual=False  performance-patch-template
compact=1292  predicted=False  actual=False  minitaur
...  detector mismatches: 0
```

Verification: `51 passed, 5 xfailed`; clean HEAD blob confirms semantic OK, detector says **not** exempt, byte-identical OK.

### Task 3 — Six individually-reasoned allowlist entries
**File changed:** `tests/review_blocker_allowlist.json`

- Every signature **re-derived from a live `review_patch()` run**, not transcribed from the plan table, and each derived key confirmed equal to `_blocker_match_key(finding)`. All six patches carry exactly one fan-out blocker, as planned.
- Six entries added in alphabetical position, mirroring the existing entry shape (`severity`, `kind`, `source`, `source_id`, `outlet`, `destinations`) so `_entry_key()` matches on `kind`/`source_id`/`outlet`.
- Each entry carries a `reason` field with an individually judged root cause — no shared boilerplate. The three kinds are explicitly distinguished: inherent `preset` binding (3 entries), signal/matrix-domain where ordering is not observable (2 entries), and genuine control-rate debt (1 entry, simple-fm). Each reason states the patch is frozen per the allowlist `_doc` regression constraint.
- Extended `_doc` to record that the allowlist requires maintenance as new patches land, that the original 14 went stale on 2026-07-02, and that entries from this task onward carry `reason`.
- `src/maxpat/critics/` untouched — fan-out critic behavior changes remain scoped to the MF-03/SF-03 follow-ups.

Verification: `6 keys present, 20 total, reasons specific and distinct`.

## Commit Ownership

Per orchestrator override 1, **nothing was committed or staged by this executor** — the commit guard refuses commits on `main`, and the orchestrator owns all commits. No branch was created or switched, no config key was set, no `git add` was run. Files to commit, per task:

| Task | Files to commit |
|------|-----------------|
| 1 | `tests/test_signal_role_migration.py` |
| 2 | `tests/test_round_trip.py` |
| 3 | `tests/review_blocker_allowlist.json` |

`actuals.commits: 0` is therefore expected and correct for this run, not a signal of uncommitted work going unnoticed.

## `patches/` Invariant

This task wrote, staged, reverted, and deleted **nothing** under `patches/`. Verified as override 3 specifies:

- `git diff --cached --name-only -- patches/` → empty (`patches staged: none`)
- Every path edited is one of the plan's three `files_modified`
- `git status --porcelain -- patches/` listed the same 2 pre-existing user modifications (`patches/.active-project.json`, `patches/scala-synth/generated/scala-synth.maxpat`) at both the start and the end of the run — the dirty set did **not** change
- No `git stash`, `git add .`, `git add -A`, `git checkout -- <path>`, or `git restore` anywhere. Version comparisons used committed objects via `git show HEAD:<path>`; the working-tree scala-synth copy was only *read* as the thing under test.

`src/maxpat/` is likewise untouched — confirmed by `git status --porcelain`, which lists only the three test-layer files plus the two pre-existing `patches/` modifications and this task's `.planning/` directory.

## Concurrency Note

A concurrent Claude instance was active under `patches/` throughout. During this run it landed **9+ commits** on `main` (terrain-synth v0.6.1 and bassoon-model v0.19.0 work, including re-saves of `terrain-voice.maxpat` and `terrain-synth.maxpat`), moving HEAD `0d0f1cf → b07ae3d → e34ec76`. All of that is attributable to the other instance; this task touched none of it.

Because those commits re-saved `.maxpat` files that are parametrized into `test_integration_patches.py`, the full suite was **re-run against the latest tree** after they landed. It remained green (`2176 passed, 6 xfailed`, exit 0) and the collected-test count was unchanged, because the affected files were modified rather than added. HEAD may well have moved again since; the green result above is pinned to `e34ec76`.

## Deviations from Plan

### Auto-fixed / strengthened

**1. [Rule 2 — correctness] Tightened the compact-array detector beyond the plan's description**
- **Found during:** Task 2
- **Issue:** A naive `\[\s*-?\d[^\[\]]*\]` regex would also match a string payload containing a subscript like `[0]`, producing a false exemption that silently disables a real byte-identity assertion (threat `T-gut-02`).
- **Fix:** Required whitespace after `[` (`\[\s+-?\d[^\[\]]*\]`), matching MAX's actual `[ 34.0, 104.0 ]` output shape. Then validated the predicate against all 11 files with zero mismatches before wiring it in.
- **Files modified:** `tests/test_round_trip.py`

**2. [Rule 2 — correctness] Added site-count floors rather than a bare non-empty check**
- **Found during:** Task 1
- **Issue:** A "collected set is non-empty" assertion would still pass after three of the four `dsp_critic` consumers were deleted, weakening the anchor the plan explicitly forbade weakening.
- **Fix:** Anchored at `>= 4` for `dsp_critic.py` and `>= 1` for `patcher.py` (the plan specified the former; the latter was unspecified and set to today's count), then mutation-tested both to prove they trip on consumer removal.
- **Files modified:** `tests/test_signal_role_migration.py`

### Recorded discrepancies (no code impact)

**3. Plan's destination-composition table was slightly off for the reverse-delay pair**
- Plan table: mono = `dial x22, umenu x1, toggle x1`; stereo = `dial x22, umenu x2, toggle x1`.
- Live probe: mono = `dial x21, umenu x2, toggle x1`; stereo = `dial x21, umenu x3, toggle x1`.
- **Totals match exactly** (24 and 25), and `_entry_key()` ignores `destinations` for `fanout` entries, so matching is unaffected. Per the plan's own instruction to re-derive from a live run rather than transcribe, the **live** values were written for human auditability.

**4. Allowlist count assertion**
- The plan's `len(d) == 20` assertion was correct as written and needed no adjustment: 14 existing + 6 new = 20. Verified.

## Known Stubs

None. No stub values, placeholder text, skipped tests, or unrun `<verify>` commands were introduced. Every verification command in the plan was executed and its output is reproduced above. `.planning/WINDOWS.md` does not exist in this repo, so no ledger entry was appended (population is best-effort and non-blocking).

## Threat Flags

None. No new network endpoint, auth path, file-access pattern, or schema change at a trust boundary was introduced — the change is confined to three test-layer files. The plan's register was satisfied as designed: `T-gut-01` (20-key + distinct-reason assertion passed), `T-gut-02` (clean committed blob still passes a real byte-identity assertion; detection is never static), `T-gut-03` (`patches/` dirty set unchanged at 2, nothing staged), `T-gut-04` (all 9 reasons recorded in the artifact enforcing each resolution).

## Self-Check: PASSED

- `tests/test_signal_role_migration.py` — FOUND
- `tests/test_round_trip.py` — FOUND
- `tests/review_blocker_allowlist.json` — FOUND (valid JSON, 20 patch keys)
- Commit hashes — N/A by design: commits are orchestrator-owned this run (override 1). Working-tree state verified instead via `git status --porcelain`, which lists exactly the three intended test-layer files as modified.
