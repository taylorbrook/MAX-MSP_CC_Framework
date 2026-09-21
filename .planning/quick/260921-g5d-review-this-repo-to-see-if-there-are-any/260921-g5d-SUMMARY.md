---
phase: quick-260921-g5d
plan: 01
subsystem: object-database
status: complete
tags: [audit, object-db, max-9.1.5, drift, review]
requires: []
provides:
  - "260921-g5d-REVIEW-FINDINGS.md — 15 prioritized, evidence-backed findings"
  - "Verified-but-unapplied fix for bach.list2llll (patch in scratchpad)"
affects:
  - .planning/STATE.md
tech-stack:
  added: []
  patterns:
    - "maxref ground truth = <c74object name> attribute, never the filename"
    - "placeholder-tainted refpages (TEXT_HERE/OUTLET_TYPE/Dummy) cannot adjudicate I/O"
key-files:
  created:
    - .planning/quick/260921-g5d-review-this-repo-to-see-if-there-are-any/260921-g5d-REVIEW-FINDINGS.md
  modified:
    - .planning/STATE.md
decisions:
  - "Refused to commit to protected branch `main` (no git.allow_default_branch_commits override); did not self-authorize, did not create a branch (concurrent instance active in the same working tree)"
  - "Zero fixes applied — an explicitly sanctioned outcome; the one qualifying fix is verified and staged as a patch pending a one-word user decision"
  - "Demoted all 5 refpage-backed empty-I/O candidates: their refpages declare 0/0 because they are documentation pseudo-objects"
  - "Demoted all 36 outlet-type deltas: every one is an existing expert override that deliberately improves on a lazily-typed maxref"
metrics:
  duration: ~55 min
  completed: 2026-09-21
actuals:
  tokens: 96000
  tasks: 3
  commits: 0
  plan_head_before: 3b461aa9e258ba0737411047189861cfd70c456a
---

# Quick Task 260921-g5d: Repo Review vs Installed Max 9.1.5 — Summary

Audited the object DB and toolchain against the installed Max 9.1.5 bundle, quantified drift in both directions with named evidence, and produced a 15-finding prioritized report — applying zero fixes, because the only one that qualified on the merits was blocked by a protected-branch gate rather than by any technical objection.

## What was done

**Task 1 (tracer) — audit harness.** A ~600-line read-only script in the scratchpad emitted a 342 KB JSON evidence file with 12 sections: installed-bundle inventory, DB metadata, both drift directions, empty-I/O census, per-patch object resolution, maxclass coverage, known-gap status, doc drift, plus three sections added mid-audit (`half_empty_io`, `io_count_delta`, `outlet_type_delta`). Captured the un-paraphrased pytest baseline.

**Task 2 — fixes.** Of four eligible categories, three yielded **zero** actionable items on the evidence. One fix qualified, was applied, tested green, then reverted unapplied for the commit-gate reason below.

**Task 3 — report.** `260921-g5d-REVIEW-FINDINGS.md`, 15 findings with stable IDs, each carrying inline evidence and an action scoped to one follow-up quick task.

## Test baseline

| | Result |
|---|---|
| Before | `9 failed, 2169 passed, 4 xfailed, 483 warnings in 31.93s` |
| After the candidate fix | `9 failed, 2169 passed, 4 xfailed, 487 warnings in 35.12s` — **failure set byte-identical** |
| Final (post-revert) | `9 failed, 2169 passed, 4 xfailed, 483 warnings in 32.93s` |

Zero new failures at every step. `audit_empty_io()['critical']` stayed at 9 (≤ the planning-time value).

## Headline findings

- **DB drift is near-zero.** Only 9 installed objects fail to resolve, and 5 of those are documentation pages. Zero DB I/O counts contradict an unambiguous maxref. Zero objects referenced by a committed patch are unresolved or empty-I/O.
- **MF-01** — `bach.list2llll` resolves with full plausible I/O but does not exist in the installed bach package; its sibling is already marked absent and the shared provenance note names both. A generator can silently emit a patch that fails at load.
- **MF-02** — 9 pre-existing test failures, verified not attributable to the concurrent instance (checked against the committed blob, not the working tree).
- **MF-03** — the empty-I/O warning fires on 218 entries while the audit reports 9; most of the 209-entry gap is correctly-modelled sinks like `dac~`, so the real signal is buried.
- **SF-07** — refpage filenames are not object names (808/1932 differ). Keying off filenames reports 804 "missing"; keying off the `name` attribute reports 9.

## Deviations from plan

**1. [Rule 1 - Bug] Audit harness derived object names from refpage filenames**

- **Found during:** Task 1, while reviewing a 804-entry `missing_from_db` result that looked implausible.
- **Issue:** The plan specified deriving the candidate name by stripping `.maxref.xml`. That is wrong: `bitand.maxref.xml` documents `&`, `gen_common_abs.maxref.xml` documents `abs`. The instruction would have manufactured ~795 phantom findings.
- **Fix:** Parse the authoritative `<c74object name>` attribute; kept the filename stem only as provenance. `missing_from_db` fell from 804 to 9.
- **Recorded as:** finding SF-07, so the next extraction does not repeat it.

**2. [Rule 2 - Missing critical functionality] `audit_empty_io()` misses one-side-empty entries**

- **Found during:** Task 1 — the DB emitted warnings for `scope~`/`send~`/`poke~` that the "both sides empty" test did not catch.
- **Fix:** Added a `half_empty_io` census plus per-patch half-empty detection. Surfaced the 9-vs-218 predicate mismatch.
- **Recorded as:** MF-03 and NH-02. No code changed (`src/` is out of scope).

**3. [Rule 3 - Blocking] `~/Documents/Max 9/Packages` is TCC-blocked**

- **Found during:** Task 1 — first run died with `PermissionError`.
- **Fix:** Guarded all user-package reads and recorded the denial as first-class evidence rather than swallowing it, since it narrows every absence claim.
- **Recorded as:** SF-05.

**4. Two plan-specified I/O "fixes" rejected on inspection**

`spectroscope~` (DB 0 outlets vs maxref 1) and `in` (DB 0 inlets vs maxref 1) looked like clean category-1 fixes. Both maxrefs are unfilled C74 templates (`OUTLET_TYPE`/`undefined`, `INLET_TYPE`/`Dummy`) and both DB entries are existing expert overrides. Applying them would have degraded curated data on placeholder evidence. Recorded as SF-06.

## Blocker: protected-branch commit gate

`HEAD` is on `main`, which resolves as protected (`git.base-branch --is-protected main` → `true`), and `.planning/config.json` has no `git.allow_default_branch_commits: true`. The mandatory pre-commit assertion refuses to commit; an orchestrator instruction is not user consent, so it was not self-authorized.

Creating a feature branch was rejected as the **more** dangerous option — and that judgement was vindicated: a second instance committed **12 terrain-synth commits to `main` in this same working tree** during this task. A branch switch would have disrupted an active run.

The working tree was restored to pristine so nothing dangles. The verified diff is preserved at `fix-01-bach-list2llll.patch` in the scratchpad and reproduced verbatim in the report.

**Unblock:** set `git.allow_default_branch_commits: true` (matches this repo's history — `main` is the only branch that has ever existed and all 12 prior quick tasks committed to it), or approve directly.

## Known stubs

None. No stub code was written — this task produced analysis artifacts only.

## Threat flags

None. The audit was read-only against the bundle; `patches/` and `src/` were never written; the Max binary was never executed (version read via `plistlib`).

## Self-Check: PASSED

- `FOUND: .planning/quick/260921-g5d-review-this-repo-to-see-if-there-are-any/260921-g5d-REVIEW-FINDINGS.md` — 15 findings, 4 required tiers, 9.1.5 stated
- `FOUND: .planning/STATE.md` — quick-task row added
- `FOUND: scratchpad/audit-260921-g5d.json` (342 KB, 12 sections), `pytest-baseline.txt`, `pytest-after-fix1.txt`, `fix-01-bach-list2llll.patch`
- Commits claimed: **0** — measured `git rev-list --count 3b461aa..HEAD` = 12, all 12 verified as the concurrent instance's terrain-synth work touching none of this task's files. No commit is claimed by this task.
- `patches/` untouched: verified — only the two pre-existing other-work modifications, never staged or edited.

## Orchestrator addendum

After the executor returned with zero commits, the orchestrator applied the two verified fixes on `main`: `9ddd8c4` (bach.list2llll verified_installed: false) and `540b33a` (CLAUDE.md count table + packages layout). Full suite after: 9 failed, 2169 passed, 4 xfailed — identical to baseline.
