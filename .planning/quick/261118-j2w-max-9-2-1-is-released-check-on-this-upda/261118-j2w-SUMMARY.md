---
phase: quick-261118-j2w
plan: 01
subsystem: object-db / sync tool / reference docs
tags: [max-9.2.1, object-db, sync, docs]
status: complete
requires: [quick-261001-hwb]
provides: [max-9.2.1-db-sync, alias-doc-deltas]
affects: [validation, generation guidance]
tech-stack:
  added: []
  patterns: [alias-document deltas keyed by define alias]
key-files:
  created: []
  modified:
    - .claude/max-objects/jitter/objects.json
    - .claude/max-objects/packages/ableton-dsp/objects.json
    - .claude/max-objects/packages/Jitter Tools/objects.json
    - .claude/max-objects/idioms.json
    - .claude/max-objects/groups.json
    - .claude/max-objects/version_io.json
    - .claude/max-objects/extraction-log.json
    - tests/fixtures/help_io_baseline.json
    - tools/sync_max_bundle.py
    - tests/test_sync_max_bundle.py
    - .claude/skills/references/max-9.2-changes.md
    - .claude/skills/references/db-maintenance.md
    - .claude/skills/references/shared-capabilities.md
    - .claude/skills/references/genexpr-rules.md
    - .claude/commands/max-test.md
    - tests/test_claude_md.py
    - README.md
decisions:
  - "Sync deltas now diff define-mapped alias refpages against the alias's own entry; an alias missing from the DB or resolving to another entry is skipped (keeps v8 untouched)"
  - "jit.gl.tex2mat dimscale lands typed int (refpage) though the js declares float; recorded in docs, not hand-corrected (Rule #1)"
  - "No gen~ rule retired by 9.2.1; nested-loop codebox fix does not relax the single, non-nested for-loop rule"
metrics:
  duration: ~8 min
  completed: 2026-11-18
actuals:
  tokens: 11550
  tasks: 3
  commits: 3
plan_head_before: 4fd96665e0b84e4b43522b9927f3dfc614585482
plan_head_after: ae6dd56e224addd4a654ff748a72966435e6d47f
---

# Quick 261118-j2w: Max 9.2.1 update check Summary

The object DB is re-synced to the installed Max 9.2.1 (b6a40ee953d) bundle. The sync tool now picks up define-alias refpages, which is how jit.gl.tex2mat's new surface landed. A tiered 9.2.1 impact section is in max-9.2-changes.md, and it retires no rules.

## What changed
- DB: `jit.web` / `jit.web~` +`executejavascript` (one quoted symbol argument)
- DB: `abl.device.reverb2~` +`highshelf` / `highshelffreq` / `highshelftype` / `highshelfgain` (old `highpass*` kept, still accepted by Max)
- DB: `jit.gl.tex2mat` +`dimscale` / +`jit_matrix` (`adapt` kept); `jit.mgraphics` +`updatetextfield` (refpage is a TEXT_HERE template, so it should not be generated)
- DB: idioms +1 (`attrui` 0 -> `jit.gl.tex2mat` 0); groups/version-io re-stamped 9.2.1, no name change; extraction-log records 9.2.1
- No I/O change on any object (3114 names unchanged); help-io bundle mismatches dropped 87/848 -> 85/823 names/boxes
- Sync tool fix: `compute_deltas` now diffs define-alias refpages against the alias entry, never the name-attribute target (`v8` selectors byte-identical); 5 new tests
- Docs: max-9.2-changes.md "Max 9.2.1" section + 6-item MAX shortlist; db-maintenance / shared-capabilities / genexpr-rules / max-test / README pointers say 9.2.1
- No gen~ rule retired. The nested-loop codebox fix does not relax the single, non-nested `for`-loop rule.

## Still needed
- `jit.gl.web` / `jit.gl.web~` lack `executejavascript` in the DB. Confirm it works in MAX, then add it by an explicit DB step.
- `mc.abl.dsp.djfilter~` is unresolved. It needs the family-wide `mc.abl.dsp.*` alias decision (~40 names); alias the family together, never one name alone.
- `jit.gl.tex2mat` `dimscale` is typed int (from the refpage) but the js takes floats. If attribute types ever start to matter, fix it with an override.
- `jit.gl.grab` / `jit.gl.movie~` still have no refpage or help box (DEF-hwb-13), unchanged.

## What to check in MAX
- `jit.gl.tex2mat @dimscale 0.5 0.5` with `dim 0 0`, plus a `jit_matrix` message into it
- `jit.web executejavascript "document.title"` on a loaded page
- `abl.device.reverb2~`: old `@highpass*` and new `@highshelf*` names both accepted
- `jit.gl.web executejavascript` (decides the follow-up above)
- `mc.abl.dsp.djfilter~` instantiates, and what its I/O is (decides the family alias)
- `playlist~` pause after play in `patches/spectraldetector` and `patches/tape-wobble`, only if they rely on it

## Tasks

| Task | Name | Commit |
|---|---|---|
| 1 | Version guard, baselines, documented 9.2.1 re-sync | 2456f243 |
| 2 | Sync deltas cover define-mapped alias refpages; tex2mat landed | 6246956a |
| 3 | 9.2.1 impact assessment, pointers, full-suite check | ae6dd56e |

## Verification
- Guard: `CFBundleShortVersionString` = `9.2.1 (b6a40ee953d)`.
- Final dry-run: 0 pending deltas, 0 pending idioms, version-io +0 -0 ~0; `--compare-io` reports 3114 names unchanged.
- SYNC-CLEAN, LOOKUP-OK, TEX2MAT-OK and DOCS-OK gates pass. CLAUDE.md is byte-identical to the base.
- Full suite at base: 1 failure, `test_idioms.py::test_committed_idioms_are_current`, caused by the 1 pending 9.2.1 idiom. After: 0 failures. Nothing failed that passed before. The only change in the FAILED set is that test, fixed by the sync itself.
- Final count: 7603 passed, 1 skipped. The clean baseline ran in a temp worktree at the base commit and showed 6 extra skips; those tests depend on files the worktree did not have.
- Audit drift line before sync: "db age 25.89 days, drifted domains: packages".

## Deviations from Plan

1. **[Rule 3 - Blocking] Baseline re-run in a temp worktree.** The first full-suite baseline overlapped the `--apply` steps. The real-DB guard raised a teardown ERROR, so that baseline was contaminated. I re-ran it at the base commit in a detached temp worktree, then removed the worktree.
2. **Strict FAILED-set equality not met, by improvement.** The plan's diff gate expects identical sets. The base failure was the pending idiom this task lands, so the set went from 1 to 0. Nothing new failed.
3. **Applied `--apply deltas --names jit.gl.tex2mat`** for the alias delta. It was the only alias delta, and its refpage checked out. The other three alias docs produced no delta.
4. **extraction-log history has two same-day 9.2.1 rows**, one from each `--refresh-log` that the plan specifies (Task 1 and Task 2). That is the tool's normal behaviour, so I left it.
5. **Test fixes during RED:** the first draft compared the whole core file, which other deltas legitimately change. I narrowed it to the `corething` entry.

## TDD Gate Compliance
RED: before the fix, 2 of the 5 new tests failed (keyed-by-alias, apply-alias-only). The 3 guard tests passed at base, which is expected because they protect against a bad implementation. GREEN: all 104 sync tests pass after the fix. Test and fix share commit 6246956a, per the plan's single-commit instruction.

## Known Stubs
None.

## Threat Flags
None. T-j2w-01 is mitigated by the `located[1] != alias` guard, covered by `test_alias_resolving_to_its_name_attribute_target_is_never_written`. T-j2w-02 is covered by `--compare-io`.

## Self-Check: PASSED
