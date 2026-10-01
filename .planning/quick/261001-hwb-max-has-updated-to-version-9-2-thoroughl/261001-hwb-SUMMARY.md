---
phase: quick-261001-hwb
plan: 01
subsystem: object-database
tags: [max-9.2, object-db, sync-tool, refpages, v8, gen, buffer, claude-md, skills]
status: complete

requires:
  - phase: quick-260921-knq
    provides: tools/audit_db.py (audit_install, refpage roots) reused by the sync tool
  - phase: quick-260921-j0h
    provides: precedent for adding bundle-verified objects with parse_standard_xml plus named curation steps
provides:
  - tools/sync_max_bundle.py — dry-run report and additive apply (new, define, deltas) with an I/O snapshot guard
  - 12 Max 9.2 objects in the DB with bundle-verified I/O and min_version 9.2
  - 57 messages and 110 attributes added to 44 existing objects, additively
  - version_map "9.2" key in overrides.json and guards that accept 9.x minors
  - .claude/skills/references/max-9.2-changes.md — evidence-tiered 9.2 digest
  - CLAUDE.md, js skill, shared-capabilities, README, TECHNICAL updated for 9.2
  - unknown-key tolerance test for the patcher format
affects: [object-database, max-js-agent, max-dsp-agent, max-patch-agent, claude-md, future Max updates]

actuals:
  tokens: 48600   # chars/4 over the added lines of the realized diff ee93974..f53c921 (194,422 chars)
  tasks: 3
  commits: 3
plan_head_before: ee93974aea3ebf8381ef48c13213023d58a0ed55

tech-stack:
  added: []
  patterns:
    - "Bundle-vs-DB sync: dry-run report, then additive apply with an explicit --names allow-list"
    - "Evidence tiers on every Max claim: [bundle], [db], [notes]"
    - "Define-mapped objects take their name from the objectmappings alias, never from the refpage name attribute"
    - "Help-patch box decides outlet types; refpage decides counts"

key-files:
  created:
    - tools/sync_max_bundle.py
    - tests/test_sync_max_bundle.py
    - .claude/skills/references/max-9.2-changes.md
  modified:
    - .claude/max-objects/msp/objects.json
    - .claude/max-objects/jitter/objects.json
    - .claude/max-objects/max/objects.json
    - .claude/max-objects/mc/objects.json
    - .claude/max-objects/m4l/objects.json
    - .claude/max-objects/packages/ableton-dsp/objects.json
    - .claude/max-objects/packages/Jitter Tools/objects.json
    - .claude/max-objects/packages/jit.mo/objects.json
    - .claude/max-objects/package_info.json
    - .claude/max-objects/overrides.json
    - .claude/scripts/validate_db.py
    - tests/test_version_tags.py
    - tests/test_package_schema.py
    - tests/test_round_trip.py
    - CLAUDE.md
    - .claude/skills/max-js-agent/SKILL.md
    - .claude/skills/references/shared-capabilities.md
    - README.md
    - TECHNICAL.md

key-decisions:
  - "Additive only: no pre-existing DB value removed or rewritten; no I/O change on any pre-existing object"
  - "The sync tool cannot write overrides.json; the one version_map key was a separate byte-preserving insertion"
  - "min_version 9.2 on the 12 new objects only; 9.2-only messages and attributes are recorded in prose, not by a schema change"
  - "No gen~ rule in CLAUDE.md was retired; 9.2's compiler fixes are release-notes-only until re-tested in MAX"
  - "Native v8 timers are treated as untested: the user guide inside the 9.2 bundle still says they are unavailable"
  - "The background-layer patch-cord JSON key was not guessed; a synthetic key proves tolerance"
  - "Generator output unchanged: appversion stays 9.0.0, no .maxpat edited"

patterns-established:
  - "After a Max update: tools/audit_db.py, then tools/sync_max_bundle.py dry-run, then --apply with explicit names"

requirements-completed: [MAX92-01, MAX92-02, MAX92-03, MAX92-04, MAX92-05, MAX92-06]

coverage:
  - id: D1
    description: "12 Max 9.2 objects resolve with bundle-verified I/O and build through Patcher.add_box"
    requirement: MAX92-01
    verification:
      - kind: integration
        ref: "plan verify probes TRACER-E2E-OK and EXPANSION-E2E-OK (Tasks 1-2)"
        status: pass
  - id: D2
    description: "9.2 messages and attributes landed additively on 44 existing objects; dry-run delta is 0 / 0"
    requirement: MAX92-02
    verification:
      - kind: integration
        ref: "python3 tools/sync_max_bundle.py (pending 0 / 0, re-run after Task 3) and --compare-io (3077 names unchanged)"
        status: pass
  - id: D3
    description: "Committed, hermetically tested, idempotent sync tool that cannot write overrides.json"
    requirement: MAX92-03
    verification:
      - kind: unit
        ref: "tests/test_sync_max_bundle.py (64 tests)"
        status: pass
  - id: D4
    description: "min_version 9.2 recorded, version_map protects it, guards accept it"
    requirement: MAX92-04
    verification:
      - kind: unit
        ref: "tests/test_version_tags.py, tests/test_package_schema.py, OVERRIDES-INTACT probe"
        status: pass
  - id: D5
    description: "CLAUDE.md, js skill, shared-capabilities and the 9.2 reference updated; counts equal disk; every prior gen~ and buffer~ rule still present"
    requirement: MAX92-05
    verification:
      - kind: other
        ref: "plan verify probes COUNTS-OK and DOCS-OK; tests/test_claude_md.py, tests/test_agent_skills.py"
        status: pass
      - kind: manual_procedural
        ref: "Check in MAX list (8 items) — nothing in the reference was run in MAX 9.2"
        status: unknown
  - id: D6
    description: "Unknown patchline / box / patcher keys survive round-trip and validate_patch"
    requirement: MAX92-06
    verification:
      - kind: unit
        ref: "tests/test_round_trip.py::TestUnknownKeyTolerance::test_unknown_keys_survive_round_trip_and_validation"
        status: pass

duration: "48 min wall-clock (20:17Z to 21:05Z), including one checkpoint pause before the first commit"
completed: 2026-10-01
---

# Phase quick-261001-hwb Plan 01: Max 9.2 sync Summary

**The repo now matches the installed Max 9.2.0 (e9c80e453de): 12 new objects and a 57-message / 110-attribute delta are in the object database from the bundle, re-syncing is one committed additive tool, and CLAUDE.md and the skills describe 9.2 with an evidence tier on every claim. Nothing was run inside MAX — eight checks are listed for the user below.**

## Commits

| Task | Hash | Message | Files | + / − |
|---|---|---|---|---|
| 1 | `b46a8a9` | `feat(quick-261001-hwb): bundle sync tool + dspstress~, jit.web, jit.web~ from Max 9.2` | 5 | 2541 / 10 |
| 2 | `36f191b` | `feat(quick-261001-hwb): remaining nine Max 9.2 objects, additive message/attribute delta, 9.2 version tagging` | 15 | 2411 / 79 |
| 3 | `f53c921` | `docs(quick-261001-hwb): Max 9.2 guidance, re-synced object counts, unknown-key tolerance test` | 7 | 287 / 18 |

`git rev-list --count ee93974..HEAD` = 3 (measured from the plan ledger). All three were staged with explicit paths on `main` (`git.allow_default_branch_commits: true`; the protected-branch check returned `false` before each commit). Nothing was pushed. No commit touches `patches/` or anything outside the plan's `files_modified`. `git stash list` is empty before and after. `patches/.active-project.json`, `.planning/tci-phase2/` and `.planning/config.json` are untouched and unstaged.

## What landed

### Task 1 — sync tool and the three core-refpage objects (`b46a8a9`)

- `tools/sync_max_bundle.py`: dry-run report in seven sections (install, new objects, define aliases, deltas, collisions, alias documents, overrides that shadow refpage names), `--json`, `--apply new|deltas`, `--names`, `--snapshot-io`, `--compare-io`. It reuses `parse_standard_xml` from `.claude/scripts/extract_objects.py` and `audit_install` from `tools/audit_db.py`, spawns no subprocess and never launches Max.
- `dspstress~` (msp, 1 / 0), `jit.web` (jitter, 1 / 2), `jit.web~` (jitter, 1 / 4) landed through the tool.
- `.claude/scripts/validate_db.py`: `check_min_version_range` accepts `4 <= v < 10`.
- `tests/test_sync_max_bundle.py`: 50 hermetic tests on a fake bundle and fake DB.

### Task 2 — remaining nine objects, the delta, version tagging (`36f191b`)

- `--apply define` and package destinations added to the tool; 14 more tests (64 total).
- Landed: `abl.device.reverb2~` (4 / 2), `abl.device.stereocompressor~` (6 / 3), `abl.dsp.djfilter~` (4 / 1), `jit.message` (1 / 2), `jit.path.ui` (1 / 4), and the define aliases `jit.gl.web` (1 / 2), `jit.gl.web~` (1 / 4), `jit.unpack.geomat` (1 / 5), `jit.gl.tex2mat` (1 / 1). All 12 are `min_version: 9.2`, `maxclass: newobj`. No tool abort, so nothing was hand-written.
- Additive delta: **57 messages on 23 objects, 110 attributes on 28 objects, 44 distinct objects, 7 files.**
- `overrides.json`: `version_map` gains `"9.2": {"exact": [12 names]}` as its first key (+16 / −0); `objects`, `variable_io_rules`, `_uncovered_empty_io`, `_comment` equal the base commit.
- `package_info.json`: `object_count` ableton-dsp 77 → 80, jit.mo 9 → 10, Jitter Tools 99 → 102.
- Guards: `check_max9_objects` and `test_abl_objects_are_max9` accept `9 <= v < 10`; the ableton-dsp count pin is 80.

### Task 3 — guidance, counts, format-tolerance test (`f53c921`)

| File | Change |
|---|---|
| `.claude/skills/references/max-9.2-changes.md` (new, 184 lines) | Evidence tiers; the 12 objects; 9.2-only messages and attributes (27 objects named by the release notes) and the DB gaps closed alongside (17 objects); `buffer~` argument forms from the refpage; `udpsend` / `udpreceive`; `v8` additions with the identifiers seen in the bundled examples; Gen; patcher format; 15 fixed-bug lines reviewed against repo guidance; no-impact items; the Check in MAX list; the re-sync workflow |
| `CLAUDE.md` (+13 / −5) | Count table re-synced (msp 247, jitter 222, packages 1496); refpage statistics re-synced (1935 files, 7 unresolved) plus the define-mapped naming exception; `jit.web~` help-box-over-refpage case; post-update sync workflow; one new `buffer~` bullet; one new final Gen~ bullet; two js bullets (`js` vs `v8`, 9.2 `v8` additions); two Version Compatibility bullets. The five removed lines are the in-place edits to those count and statistics lines — no rule was deleted or reworded |
| `.claude/skills/max-js-agent/SKILL.md` | Three "Key Differences" rows corrected (async, file I/O, network); new "Max 9.2 additions (`v8` family)" subsection: object scope, what the bundle shows, what is release-notes-only, `node.script` for older builds, network code opt-in. Function-signature lines untouched |
| `.claude/skills/references/shared-capabilities.md` | New "Max 9.2" section pointing to the reference and the two tools |
| `README.md`, `TECHNICAL.md` | Object counts only: total 3,430 → 3,444; core 1,941 → 1,948; package 1,489 → 1,496; rows max 471 → 473, msp 246 → 247, jitter 218 → 222 |
| `tests/test_round_trip.py` | `TestUnknownKeyTolerance::test_unknown_keys_survive_round_trip_and_validation` |

On-disk counts, re-verified before writing: max 473, msp 247, jitter 222, mc 222, gen 189, m4l 35, rnbo 560 (core 1,948); 29 package dirs, 1,496 objects; total 3,444.

## Dry-run totals

| | Before any apply | After Task 2 | Re-run after Task 3 |
|---|---|---|---|
| New refpage-backed objects | 8 | 0 | 0 |
| Documentation pages | 6 | 6 | 6 |
| `define_missing` | 9 | 4 | 4 (`jit.geom.topoints`, `jit.gl.grab`, `jit.gl.movie~`, `jit.gl.textureinfo`) |
| Delta objects / messages / attributes | 44 / 57 / 110 | 0 / 0 / 0 | 0 / 0 / 0 |
| Collisions | 3 | 3 | 3 |
| Alias documents | 4 | 4 | 4 |
| Overrides lacking refpage names | `expr`, `funnel`, `waveform~` | same | same |

`--compare-io` against the pre-task snapshot: 3077 pre-existing names unchanged. `tools/audit_db.py`: unresolved refpage names 10 → 7 (5 documentation pages, `kbm.data`, `scl.data`); "absent from Max" 22 → 24 (`jit.gl.web`, `jit.gl.web~` have no refpage by design).

## Per-file numstat, `ee93974..f53c921`

| File | + | − |
|---|---|---|
| `.claude/max-objects/jitter/objects.json` | 811 | 36 |
| `.claude/max-objects/m4l/objects.json` | 92 | 1 |
| `.claude/max-objects/max/objects.json` | 81 | 11 |
| `.claude/max-objects/mc/objects.json` | 8 | 1 |
| `.claude/max-objects/msp/objects.json` | 59 | 4 |
| `.claude/max-objects/overrides.json` | 16 | 0 |
| `.claude/max-objects/package_info.json` | 3 | 3 |
| `.claude/max-objects/packages/Jitter Tools/objects.json` | 478 | 2 |
| `.claude/max-objects/packages/ableton-dsp/objects.json` | 560 | 0 |
| `.claude/max-objects/packages/jit.mo/objects.json` | 86 | 0 |
| `.claude/scripts/validate_db.py` | 10 | 13 |
| `.claude/skills/max-js-agent/SKILL.md` | 14 | 3 |
| `.claude/skills/references/max-9.2-changes.md` | 184 | 0 |
| `.claude/skills/references/shared-capabilities.md` | 9 | 0 |
| `CLAUDE.md` | 13 | 5 |
| `README.md` | 4 | 4 |
| `TECHNICAL.md` | 6 | 6 |
| `tests/test_package_schema.py` | 1 | 1 |
| `tests/test_round_trip.py` | 57 | 0 |
| `tests/test_sync_max_bundle.py` | 1008 | 0 |
| `tests/test_version_tags.py` | 8 | 3 |
| `tools/sync_max_bundle.py` | 1717 | 0 |

Removed lines in the object files are line-level only (a trailing comma gained, an empty `{}` / `[]` opening up). The Tasks 1–2 executor checked independently against `ee93974` that every pre-existing entry keeps byte-equal values except `messages` (old list is a prefix) and `attributes` (old keys kept).

## Test results

| Point | passed | failed | xfailed | xpassed |
|---|---|---|---|---|
| Baseline `ee93974` | 2211 | 3 | 2 | 1 |
| After Task 1 | 2261 | 3 | 2 | 1 |
| After Task 2 | 2275 | 3 | 2 | 1 |
| After Task 3 (final) | **2276** | **3** | **2** | **1** |

The failing set is byte-identical to the baseline at every point: `tests/test_integration_patches.py::test_review_patch_no_blockers` for minitaur, physics-composition and timestretch — pre-existing, other work's patches, neither fixed nor worsened. The +65 passes are this plan's tests (64 sync-tool tests, 1 tolerance test).

Task 3 verify commands, all run: `COUNTS-OK`, `DOCS-OK`, `tests/test_claude_md.py` + `tests/test_agent_skills.py` + `tests/test_round_trip.py` (241 passed, 1 xfailed, 1 xpassed), `SUITE-UNCHANGED`.

## Deviations from Plan

### Tasks 1–2 (from the handoff)

1. **Checkpoint before the first commit** — the protected-branch check refused `main`; the user chose to commit on `main` and the orchestrator set `git.allow_default_branch_commits`.
2. **Package refpage walk is recursive under `docs/`** (Jitter Tools keeps 83 refpages under `docs/jit.fx/`); totals match the planner's exactly this way.
3. **Doc-page rule widened** to any page whose name contains whitespace.
4. **Extra collision rule** `foreign_name_attribute`; no effect on today's bundle.
5. **C2 widened**: drops placeholder arguments and template tags, blanks a template `category`.
6. **C4 gained `multichannelsignal`**; none of the 12 uses it.
7. **Two write sites**: `write_db_file` (DB tree) and `write_report` (`--json` / `--snapshot-io`, refuses `patches/` and the DB root).
8. **Exit code 1** when a named object aborts or an apply runs with no bundle; 2 for guard refusals.
9. **Define entries without a refpage** also take `module`, `domain`, `category` from the define target.
10. **Define mode does not let an alias refpage veto help-box counts**; not exercised by the four real aliases.
11. **One commit per task**, no separate failing-test commit.

### Task 3

**12. [TDD] The behavior-block test passed on its first run.** It characterizes tolerance the code already has, so there was no RED phase and no separate test commit. To show it is not vacuous it was mutation-checked in memory (no source edited): dropping the key in `to_dict` at each of the three levels, stripping the line in validation, and emitting an error naming the key — all five were caught.

**13. [Rule 1 — bug] Skill table said js file I/O is "Not available".** Wrong independently of 9.2: the bundle ships `File` / `Folder` examples under `Examples/javascript/file`. The row now says so. The plan asked for this row to "reflect Part A item 6", which does not cover file I/O.

**14. The `setsize` / `sizeinsamps` retain argument is not in the 9.2 refpage.** The plan asked for its argument form "exactly as the refpage describes"; the refpage still documents `setsize <ms> [channels]` and `sizeinsamps <samples> [channels]`. Recorded as release-notes-only with "do not generate it" in both the reference and CLAUDE.md.

**15. Native v8 timers are marked untested, not described as available.** The plan listed them among the v8 additions. No bundled v8 example calls them, and the user guide inside the 9.2 bundle (`C74/docs/userguide/content/javascript.json`) still says `setImmediate` / `setTimeout` "are not available" and to use `Task`. Guidance keeps `Task`.

**16. `js` is not the V8 object.** The installed refpages call `js` / `jsui` the Legacy Engine (ECMAScript 5) and `v8` / `v8ui` / `v8.codebox` the Modern Engine. CLAUDE.md's existing bullet "`js` object runs V8 JavaScript inline in MAX" was kept (additive-only constraint) and a clarifying bullet added beside it. Follow-up DEF-hwb-22.

**17. Patchline-key scan widened.** All 3,948 patches in the bundle were scanned; 48 are saved by 9.2 (the plan observed 36 help patches) and none carries a patchline key beyond `source`, `destination`, `midpoints`, `order`, `hidden`, `color`.

**18. CLAUDE.md's "~795 phantom gaps" figure was not recomputed** — `tools/audit_db.py` does not report it. The two figures it reports were re-synced.

**19. The reference has a twelfth section**, "Keeping the DB in step with Max" (three lines).

## Live values that differed from `observed_facts`

Tasks 1–2: no contradiction; two details the plan did not state (Jitter Tools' `docs/jit.fx/` subdirectory; the six topic pages carry empty inlet / outlet lists).

Task 3, against the plan and the release notes:

| Plan / notes say | Live value |
|---|---|
| 36 help patches saved by 9.2 | 48 bundle patches saved by 9.2 (help + examples); same conclusion — no new patchline key |
| `buffer~` `setsize` / `sizeinsamples` retain argument | Not in the 9.2 refpage; the message is spelled `sizeinsamps` |
| v8 native timers | Bundled user guide says unavailable |
| `jit.gl.textureset` "insert message" | The refpage documents `insert` as an attribute |
| `alpha_blend` attribute (notes overview) | Appears nowhere in the bundle; `alpha_mode` is listed in 23 Jitter refpages and is not in the DB |
| `fftin~` / `fftout~` `copyinput` / `copyoutput` / `updatewindow` | `fftin~` documents only `updatewindow`; `fftout~` documents all three |
| `dict.compare` `@fuzzy`, `maxurl` `streaming_buffering`, `expr` constants | Not found in the bundled refpages |
| CLAUDE.md: 808 of 1932 refpages, 9 unresolved | 808 of 1935, 7 unresolved |
| Baseline 2211 passed | Final 2276 passed; failing set unchanged |

## Untested in MAX — for the user

Nothing in this task was run in MAX 9.2. `[bundle]` in the reference means Max ships a file that says so.

1. Instantiate each of the 12 new objects; confirm inlet / outlet counts.
2. `jit.web~` and `jit.gl.web~` outlet order (audio L, audio R, matrix or texture, dumpout).
3. `jit.gl.web`: whether the message list inherited from `jit.web` is right for the texture variant.
4. A gen~ codebox that needs the `History one(1)` de-hoist workaround, compiled without it on 9.2 — and on an older 9.x build before any rule is relaxed.
5. `buffer~` `trim` and `replacechannel`; whether `setsize` / `sizeinsamps` accept a retain argument and in which position.
6. `v8`: `setTimeout` / `setInterval`, `toJSON()` on a Dict, one bundled network example.
7. `udpsend` / `udpreceive` with `@port`, `@host`, `@active`.
8. Save a patch with one background-layer patch cord and commit it, so the JSON key can be read.

## Follow-ups and deferred items

Full list with IDs: `261001-hwb-deferred-items.md`.

- **Plan S10:** `extraction-log.json` left as a timestamped artifact; `tools/audit_db.py` cannot see flat `docs/` package layouts; phantom `v8` key in `packages/Jitter Tools/objects.json`; the three pre-existing review-blocker failures.
- Four define aliases older than 9.2 still unresolved: `jit.geom.topoints`, `jit.gl.grab`, `jit.gl.movie~`, `jit.gl.textureinfo`.
- `overrides.json` message lists that shadow refpage names, for expert review: `expr` (19), `funnel` (2), `waveform~` (15).
- `jit.gl.web` / `jit.gl.web~` port digests are empty.
- `js` vs `v8` wording in CLAUDE.md and the js skill (DEF-hwb-22).
- `thispatcher` `showparameterwindow` and Jitter `alpha_mode` are documented by the bundle but not in the DB.
- README / TECHNICAL test-count figures are stale (out of scope: object counts only).
- Local `main` is 68 commits ahead of `origin/main`; nothing was pushed.

## Known Stubs

None. The 9.2 reference marks unverified items as `[notes]`; those are documentation tiers, not code stubs.

## Threat Flags

None. Task 3 adds no network endpoint, auth path, file-access pattern or schema change. T-hwb-08 is mitigated as planned: the js skill and CLAUDE.md state that network clients and servers are generated only when the task explicitly asks for them.

## Self-Check: PASSED

- Files present: `tools/sync_max_bundle.py`, `tests/test_sync_max_bundle.py`, `.claude/skills/references/max-9.2-changes.md`, `tests/test_round_trip.py`, `CLAUDE.md`, this summary, `261001-hwb-deferred-items.md`.
- Commits present: `b46a8a9`, `36f191b`, `f53c921`.
- Working tree after Task 3: only `.planning/config.json`, `patches/.active-project.json`, `.planning/tci-phase2/` and this plan directory remain uncommitted, as instructed. STATE.md and ROADMAP.md were not touched.
