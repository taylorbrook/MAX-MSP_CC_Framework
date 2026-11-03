---
phase: quick-261103-gah
plan: 01
subsystem: docs
tags: [readme, docs, v6.1.0]
status: complete
requires: []
provides: [up-to-date README.md]
affects: [README.md]
tech-stack:
  added: []
  patterns: []
key-files:
  created: []
  modified: [README.md]
decisions:
  - "README-only scope: TECHNICAL.md carries the same stale counts; recorded as follow-up, not edited"
metrics:
  duration: 2min
  completed: 2026-11-03
actuals:
  tokens: 6000
  tasks: 2
  commits: 2
plan_head_before: ef656373a9db0e81f9bb7390af1fa9633384f618
plan_head_after: 3f66cb64a288227e88265c8f53bde420a3b3ed03
---

# Phase quick-261103-gah Plan 01: README refresh after v6.1.0 Summary

README counts (3,467 objects / 30 packages / 7,550 tests), the help_io audit bullet, Patches and milestone table order, FDNVerb file types, hyphenated GSD commands, the Max 9.2 prerequisite and the versions.json tree entry now match the live repo. README.md is the only file changed.

## Commits

| Task | Commit | Files |
|------|--------|-------|
| 1 Count claims | 1d9b1d3c | README.md |
| 2 Stale claims + sweep | 3f66cb64 | README.md |

## Claims checked

| Claim | README line | Ground truth (source) | Changed |
|-------|-------------|-----------------------|---------|
| Object total (Features) | 13 | 3,467 = 1,948 core + 1,519 package (sum of len() over `.claude/max-objects/*/objects.json` + `packages/*/objects.json`) | yes, 3,445 -> 3,467 |
| Package count (Features) | 13 | 30 (`packages/*/objects.json`) | yes, 29 -> 30 |
| Object total (Quick Start research) | 77 | 3,467 | yes |
| Object total + package count (How It Works) | 198 | 3,467 / 30 | yes |
| Object total + package count (tree) | 211 | 3,467 / 30 | yes |
| Test count (tree) | 216 | 7,550 (`pytest --collect-only -q`) | yes, 7,509 -> 7,550 |
| src/maxpat ~40,800 LOC | 214 | 40,775 | no (correct) |
| Help patch audit bullet | 23 | help_io baseline: 2,114 bundle files (Max 9.2.0) + 1,333 package = 3,447; `audit_db.py --help-io`, `sync_max_bundle.py --apply` | yes, replaced "973 ... automatically correct" clause |
| MAX 9 prerequisite | 31 | 22 `jit.vis.*` + other `min_version` 9.2 objects need 9.2+ (CHANGELOG 6.1.0, max-9.2-changes.md) | yes, clause added |
| Patches table order | 157-190 | case-insensitive alpha; face-tracker was after gen-eq | yes, moved before FDNVerb |
| Patches Files cells | 157-190 | per-dir extensions; only FDNVerb mismatched (has .maxhelp) | yes, FDNVerb only |
| Patches table = 34 dirs | 157-190 | 34 `patches/*/` | no (correct) |
| Milestone order | 250-264 | v5.0 (2026-05-01) was last | yes, moved above v6.0.0 |
| v4.0 row "2,450 objects" | 261 | historical figure | no (by design) |
| GSD commands | 236-239 | installed `~/.claude/skills/gsd-*`: hyphenated; `verify-phase` absent | yes, -> `/gsd-discuss-phase`, `/gsd-plan-phase`, `/gsd-execute-phase`, `/gsd-verify-work` |
| Tree: versions.json | 219-223 | `src/maxpat/project.py:237` writes it; 33/34 projects have it | yes, line added |
| 11 slash commands incl. /max-diagnose | 137-149 | 11 `.claude/commands/*.md` | no (correct) |
| `/max-iterate --fix`, `/max-verify --live` | 131, 143 | present in command files | no |
| `tools/max_bridge/max-bridge.maxpat` | 103, 171 | exists | no |
| `--check-deps` | 32 | install.sh, installer/bin/create-max-framework.js | no |
| 9 agents | 15, 212 | 9 `.claude/skills/max-*` dirs | no |
| 7 critics | 16, 202 | 7 `src/maxpat/critics/*_critic.py` | no |
| dsp_sim smoke | 18 | `src/maxpat/dsp_sim/smoke.py` | no |
| M4L / RNBO / builder APIs | 17, 20 | add_m4l_device, add_m4l_gen_synth, polish_m4l_device, export_amxd, add_rnbo, generate_rnbo_wrapper, add_labeled_param_bank, add_overlay_readout, replace_box_safe all defined | no |
| edit_patch / save_patch_roundtrip / write_gendsp / apply_fixes | 12, 196, 202 | defined in src/maxpat | no |
| requirements-dev.txt, LICENSE, CHANGELOG.md, TECHNICAL.md, .active-project.json | various | exist | no |

## Verification

- Task 1 verify: `db ok 3467 30`, `tests ok 7550`.
- Task 2 verify: `readme ok`, `commit scope ok`.
- `tests/test_doc_signatures.py tests/test_dead_code_removed.py`: 134 passed.
- Both commits touch README.md only; `git stash list` unchanged.

## Deviations from Plan

None - plan executed exactly as written. Every planning-time measurement matched the live value.

## Follow-ups (outside README scope, not edited)

- TECHNICAL.md:86 — "Grand total: 3,445 objects (1,948 core + 1,497 package)" -> 3,467 (1,948 + 1,519).
- TECHNICAL.md:834 — "7,509 tests" -> 7,550 (test file count also worth re-checking).
- patches/granularsynthtest has no versions.json (the only project missing one).
- No stale `3,445`/`7,509`/`29 packages`/`973`/`/gsd:` found in CHANGELOG.md, CLAUDE.md or installer/README.md.

## Self-Check: PASSED

- README.md modified; commits 1d9b1d3c and 3f66cb64 are ancestors of HEAD.
