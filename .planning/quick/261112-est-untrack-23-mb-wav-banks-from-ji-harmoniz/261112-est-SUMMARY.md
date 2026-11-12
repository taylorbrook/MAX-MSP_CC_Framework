---
phase: quick-261112-est
plan: 01
subsystem: repo-hygiene
tags: [git, gitignore, ji-harmonizer, wavetables]
status: complete
requires: []
provides:
  - "Anchored .gitignore patterns for generated wavetable banks (ji-harmonizer + terrain-synth)"
  - "ji-harmonizer context.md regeneration section"
affects: [patches/ji-harmonizer]
tech-stack:
  added: []
  patterns: ["Untrack derived data with git rm --cached + no-pathspec commit guarded by an exact staged-set assertion"]
key-files:
  created: []
  modified:
    - .gitignore
    - patches/ji-harmonizer/context.md
decisions:
  - "ji-harmonizer wavetable banks are untracked and regenerated on demand with render_wavetables.py --all (byte-identical); history not rewritten"
metrics:
  duration: "~2 min"
  completed: 2026-11-12
actuals:
  tokens: 1000
  tasks: 2
  commits: 1
plan_head_before: aa087eeaba40985ee1d24a9ea2d4d969ec77939a
plan_head_after: 019ce9b7d23deed1dabc63cec441bda983a66d4d
---

# Quick 261112-est Plan 01: Untrack ji-harmonizer wavetable banks Summary

The 20 ji-harmonizer `generated/bankNN-*.wav` banks (~461 MB) left the git index in one 22-path commit. They stay on disk byte-identical, anchored `.gitignore` patterns stop them being re-added, and context.md documents the 1-second deterministic regeneration.

## Commit

- `019ce9b7d23deed1dabc63cec441bda983a66d4d` chore(ji-harmonizer): untrack generated wavetable banks; regenerate on demand
  - 22 paths: 20 `D` (index-only, `git rm --cached`) + `M .gitignore` + `M patches/ji-harmonizer/context.md`
  - Committed the index with no pathspec, after asserting exactly 22 staged paths (a pathspec commit would re-read the WAVs from disk and keep them tracked)
  - Not pushed; history not rewritten

## Tasks

| Task | Name | Result |
|------|------|--------|
| 1 (tracer) | Pre-flight snapshot, untrack, gitignore + document, one commit | TRACER-OK |
| 2 | Ignore scope, patch references, auto-commit path, full suite vs baseline | SCOPE-OK, SUITE-MATCHES-BASELINE |

## Verification results

- **Pre-flight:** main checkout (git-dir == git-common-dir == `.git`), index clean, `git ls-files -- '*.wav'` = 20 paths, all under `patches/ji-harmonizer/generated/`.
- **sha256:** `shasum -a 256 -c --quiet wav-sha256-before.txt` exits 0 after the commit; 20 banks on disk, unchanged.
- **`git ls-files -- '*.wav'`:** empty (baseline 20).
- **`git status --porcelain -- patches/ji-harmonizer .gitignore`:** empty.
- **Ignore scope:** all 20 banks ignored, attributed to `.gitignore:33:/patches/ji-harmonizer/generated/bank[0-9][0-9]-*.wav`; `patches/terrain-synth/generated/bank00-torus-sdf.wav` ignored. NOT ignored (exit 1): `ji-harmonizer.maxpat`, `ji-engine.js`, `jhpresets.json`, `terrain-synth/generated/terrain-synth.maxpat`.
- **Patch references:** `ji-harmonizer.maxpat` names 20 distinct banks, 0 missing on disk; the commit did not touch the patch.
- **auto_commit_patch:** `git add --dry-run -- patches/ji-harmonizer` exits 0 and names no WAV. A directory pathspec skips ignored files silently. Only an explicitly named ignored file makes `git add` exit 1, and `src/maxpat/hooks.py` only ever passes the saved .maxpat/.js/.gendsp path, so a ji-harmonizer save cannot hit that refusal. No code change needed.
- **Test invariant:** `grep -rlE 'bank[0-9]{2}-[a-z-]+[.]wav' tests src tools scripts` prints nothing.
- **Full suite:**
  - Before: `7598 passed, 1 skipped, 4 xfailed, 37 warnings in 27.91s`
  - After: `7598 passed, 1 skipped, 4 xfailed, 37 warnings in 23.59s`
  - Failing/error ID lists: empty both runs (identical).

## Pending user check

- Open `patches/ji-harmonizer/generated/ji-harmonizer.maxpat` in MAX. Both `buffer~ jiharmA` and `buffer~ jiharmB` should load bank00 with no "can't find file". Switching a bank umenu should load the new bank. Not claimed here.

## Reminder

- Fresh clones and agent worktrees have no banks. Run `python3 patches/ji-harmonizer/tools/render_wavetables.py --all` before opening the patch in MAX.
- Clone size is unchanged because history was not rewritten. Only future checkouts, worktrees and status scans stop carrying the banks.

## Deviations from Plan

None. The plan was executed exactly as written. The commit landed on `main` under the project's `git.allow_default_branch_commits: true` override, as a sequential executor on the main working tree.

## Self-Check: PASSED

- FOUND: .gitignore pattern `/patches/ji-harmonizer/generated/bank[0-9][0-9]-*.wav`
- FOUND: `## Wavetable banks (not in git)` in patches/ji-harmonizer/context.md
- FOUND: commit 019ce9b7 (ancestor of HEAD)
- FOUND: 20/20 banks on disk, sha256 unchanged
