---
phase: quick-260921-knq
plan: 01
subsystem: tooling
tags: [audit, object-database, refpages, read-only-tool, regression-guard]
status: complete

requires:
  - src/maxpat/db_lookup.py (ObjectDatabase, DOMAIN_LOAD_ORDER, audit_empty_io, audit_half_empty_io)
  - src/maxpat/maxclass_map.py (UI_MAXCLASSES)
provides:
  - tools/audit_db.py — reproducible read-only DB-vs-installed-Max audit (7 sections, JSON + text)
  - tests/test_audit_db.py — 33 hermetic smoke tests, green with no Max installed
affects:
  - none (pure addition; no existing module imported, modified, or re-exported)

tech-stack:
  added: []          # stdlib only: argparse, json, plistlib, subprocess, warnings, xml.etree, datetime, pathlib, hashlib
  patterns:
    - "{available, ...} section envelope: every section key always present, degrades instead of raising"
    - "named importable write-guard as the single file-write site (structural read-only enforcement)"
    - "single _git() argv-list subprocess helper, greppable as the tool's only subprocess site"

key-files:
  created:
    - tools/audit_db.py
    - tests/test_audit_db.py
  modified: []

decisions:
  - "Max's build hash lives in CFBundleShortVersionString, not CFBundleVersion — normalise short_version to the leading token and expose build_id separately"
  - "Project-local abstractions (sibling .maxpat) are classified apart from genuinely unresolved objects, so the signal is not permanently polluted by 3 false positives"
  - "has_refpage is null, not false, when the bundle is unreadable — a measurement gap is not evidence of absence"
  - "Scan ALL committed .maxpat (incl. tests/fixtures/), not just patches/ — surfacing the gen~ fixture defect is the tool working, not noise"

metrics:
  duration: ~10 min (first commit 15:00:57, last 15:07:59 PDT) + ~2 min baseline capture
  completed: 2026-09-21

actuals:
  tokens: 14423      # chars/4 over the two created files (both new, so diff == file size)
  tasks: 3
  commits: 3
  plan_head_before: 01f4e1cb8b44d54032453e721c772b5fe4843371
  commits_measured_range: 6   # BASE..HEAD; 3 of the 6 are the concurrent instance's gong-model commits
  commits_measured_filtered: 3  # git rev-list --count BASE..HEAD --grep=260921-knq
---

# Quick Task 260921-knq: Promote the DB-vs-installed-Max audit harness

Promoted NH-01's throwaway session-scratchpad harness into a committed, read-only
`tools/audit_db.py` (7 sections, JSON + scannable text summary) plus 33 hermetic
smoke tests that stay green on a machine with no Max installed. DB drift is now
measurable on demand in ~1.3 s instead of costing a full ad-hoc review.

## Full-suite baseline: before / after

| | Line |
|---|---|
| **Before** (captured pre-task, at `f707c55`+) | `2201 passed, 6 xfailed, 9 warnings in 35.12s` |
| **After** (with `tests/test_audit_db.py`) | `2234 passed, 6 xfailed, 9 warnings in 36.66s` |

Delta is **exactly +33 passed** — the new tests and nothing else. `xfailed`
unchanged at 6, warnings unchanged at 9. No pre-existing failure was absorbed,
masked, or introduced.

Note on the plan's concurrency warning: the plan anticipated that the concurrent
instance's uncommitted `patches/scala-synth/generated/scala-synth.maxpat` degraded
save would flip a byte-identity xfail. It did not during this run — xfailed held
at 6 on both sides. The file was never touched.

## Section headline counts — real run against the installed Max

`python3 tools/audit_db.py` (exit 0, ~1.3 s):

| Section | Headline |
|---|---|
| `install` | Max **9.1.5**, build `3db35fa476d`, 8 refpage roots |
| `db_age` | **82.0 days** (extracted 2026-07-01T21:43:50Z); drifted domains: `max` (logged 471, live 473) |
| *(refpage index self-check)* | 1588 objects from 1932 files, **808 name≠filename**, 0 parse errors |
| `missing_from_db` | **7** refpage names unresolved |
| `absent_from_bundle` | **22** core-domain DB names with no installed refpage |
| `empty_io` | **9** critical / **109** sinks / **100** sources |
| `patch_objects` | 71 `.maxpat` (git/HEAD), 231 distinct objects, **0 unresolved**, 3 local abstractions |
| `ui_maxclasses_gap` | **1** — `gen~`, from `tests/fixtures/expected/gen_codebox.maxpat` |

The 7 unresolved names are `Jitter GL Object (OB3D) Messages`, `Jitter Matrix
Operators`, `MC Wrapper Features`, `Parameter Properties`, `Snapshot Messages`
(five documentation pages, not objects) plus `kbm.data` and `scl.data` (data-file
pseudo-objects). This reproduces the g5d review's "9 unresolved, 5 are doc pages"
finding, now 7 because quick-260921-j0h added `node.script`/`node.codebox`.

Two independent cross-checks that the harness is keyed correctly:
- **808 name≠filename** matches CLAUDE.md's documented "808 of 1932 bundled
  refpages disagree" exactly — the SF-07 self-check lands on the known number.
- `missing_from_db` is 7, not ~795. Filename keying would manufacture the phantoms.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] The plan's Info.plist key premise was inverted for this install**

- **Found during:** Task 1, first verify run (`assert short_version == '9.1.5'` failed).
- **Issue:** The plan's house facts state `CFBundleShortVersionString` = `9.1.5`
  with "build in `CFBundleVersion`". The installed bundle actually ships
  `CFBundleShortVersionString = "9.1.5 (3db35fa476d)"` and `CFBundleVersion = "9.1.5"`
  — the build hash lives in the *short* version string. Taking the raw value made
  `short_version` `"9.1.5 (3db35fa476d)"`, violating the must-have truth that the
  summary names the version as 9.1.5.
- **Fix:** Added `_split_short_version()`, which normalises to the leading
  whitespace-delimited token and extracts any parenthesised build id. Emits
  `short_version` (`9.1.5`), `short_version_raw` (full string, nothing lost),
  `build_version` (CFBundleVersion), `build_id` (`3db35fa476d`).
- **Files modified:** `tools/audit_db.py`
- **Commit:** `673722f`
- **Test:** `TestInstallSection::test_build_id_is_split_out_of_short_version_string`
  pins the real-world string so the premise cannot silently regress.

**2. [Rule 2 - Missing critical functionality] Project-local abstractions reported as unknown objects**

- **Found during:** Task 2, first full run — `patch_objects.unresolved` came back
  with 3 entries (`terrain-lfo`, `terrain-osc`, `terrain-osc-b`), failing the plan's
  `assert p['unresolved'] == []`.
- **Issue:** These are not unknown objects. Each names a sibling `.maxpat` in
  `patches/terrain-synth/generated/` — a MAX abstraction instance, which the DB
  legitimately has no entry for. Left uncorrected, the audit's single most
  actionable number ("objects referenced but not in the DB") would report 3 false
  positives forever, training the reader to ignore it. That defeats the tool's purpose.
- **Fix:** Added `_resolve_local_abstraction()` + `_same_project()`. A name that
  fails `lookup()` but matches a sibling `<name>.maxpat` within the same directory
  or the same `patches/<project>/` tree is classified into a new `local_abstractions`
  bucket (with `defined_by` paths) instead of `unresolved`. Deliberately strict:
  resolution requires **every** referencing file to have an in-scope definition, so
  a genuinely-unknown name cannot be masked by an unrelated same-named patch elsewhere.
- **Files modified:** `tools/audit_db.py`
- **Commit:** `3c1b47d`
- **Test:** `test_sibling_maxpat_is_classified_as_a_local_abstraction` plus
  `test_unknown_objects_are_reported_unresolved` (proves the bucket does not swallow
  real unknowns).

### Additions beyond the plan (same commits, no scope change)

- `refpage_index` provenance block in the envelope (counts + `parse_errors` +
  `unreadable_roots`, minus the bulky object map) and a matching summary line —
  the SF-07 self-check number is useless if it is not visible.
- `gap_files` on `ui_maxclasses_gap`, attributing each residual maxclass to the
  files it came from. Without it the `gen~` finding is unactionable.
- `content_sources` on `patch_objects`, recording the head/worktree split so a
  reader can tell whether any file fell back off HEAD.

### Plan expectations corrected

- **`ui_maxclasses_gap` is not empty.** The plan expected an empty residual on the
  current tree. The real run returns `['gen~']`, traced to
  `tests/fixtures/expected/gen_codebox.maxpat`. Per the plan's own framing
  ("a non-empty result is a real finding, not noise") this is the tool working.
  Investigated and confirmed **not** a live builder bug: `Patcher().add_gen(...)`
  emits the correct `{"maxclass": "newobj", "text": "gen~"}`. Defect is confined to
  a hand-written expected-output fixture. Out of scope to fix (not in
  `files_modified`); recorded as **DEF-knq-01** in `deferred-items.md`.
- **No `ObjectDatabase` fixture workaround was needed.** The plan anticipated the
  minimal fake `db_root` might require empty `aliases.json` / `overrides.json`
  stubs. It does not — every supplementary file in `ObjectDatabase._load` is guarded
  by an `exists()` check, so `max/objects.json` alone loads. Verified empirically
  and recorded in the test module docstring.

## TDD note (Task 3, `tdd="true"`)

Honest reporting: **there was no RED phase.** The plan orders the tool's
implementation (Tasks 1–2) before the test file (Task 3), so all 33 tests passed on
first run. To establish that the tests actually constrain behavior rather than
merely observing it, the central SF-07 regression guard was **mutation-checked**:
regressing the name derivation to filename keying (`name = stem`) failed 4 tests
(`test_name_attribute_wins_over_filename`, `test_declared_io_counts_are_recorded`,
`test_malformed_xml_is_tallied_not_fatal`,
`test_fake_bundle_run_reports_its_version_and_resolves_refpages`); restoring made
all 33 green again. `git status --porcelain tools/` confirmed the file was restored
byte-identical to its commit.

## Threat mitigations verified

| Threat | Verification |
|---|---|
| T-knq-01 (output path tampering) | `guard_output_path()` is the sole file-write site. Refuses `patches/`, `.claude/max-objects/`, a `..` traversal path, and both tree roots; accepts `patches-backup/` (no naive prefix match). Proven by a `(size, sha256)` snapshot of both protected trees across a full run. |
| T-knq-02 (subprocess EoP) | `_git()` is the only `subprocess.run(` in the file and is literally `subprocess.run(["git", *args], ...)`. Plan's greppable equality check passes. The Max binary is never executed — version comes from `plistlib`. |
| T-knq-03 (parse DoS) | Depth cap (32) on nested-patcher recursion, asserted by `test_deep_nesting_is_capped_not_fatal` (cap + 50 levels). XML parse errors, malformed `.maxpat`, malformed plist, and `PermissionError`/`OSError` on roots are all tallied, never fatal. |
| T-knq-04 (info disclosure) | Output carries object names, counts and path strings only. No file contents. JSON only where the operator points it. |
| T-knq-05 (XML entities) | Accepted as planned — `xml.etree.ElementTree` does not resolve external entities; input is the locally installed developer-owned bundle. |
| T-knq-SC (package installs) | No installs. Stdlib + in-repo `src.maxpat` imports only. |

## Known Stubs

None. No `TODO`/`FIXME`/placeholder markers, no skipped or xfailed tests, no unrun
`<verify>` steps — every verify in all three tasks was executed and passed.

## Threat Flags

None. The tool opens no network endpoint, adds no auth path, and introduces no
schema change. Its only new file-access surface is the `--json` target, already
dispositioned as T-knq-01 and structurally guarded.

## Concurrency hygiene

A second instance committed to `main` underneath this task (3 `gong-model` commits
interleaved with mine — hence `commits_measured_range: 6` against
`commits_measured_filtered: 3`). No rebase or reset was performed. All staging used
explicit paths with a `-- <path>` pathspec; `git add .`/`-A`, `git stash`, and
`git checkout` on foreign files were never used. Final state:
`git status --porcelain patches/` still shows exactly the three pre-existing
modifications (`.active-project.json`, `FDNVerb.maxhelp`, `scala-synth.maxpat`) and
nothing else; `.claude/max-objects/` is clean. My 3 commits touch exactly
`tools/audit_db.py` and `tests/test_audit_db.py`.

## Self-Check: PASSED

- `tools/audit_db.py` — FOUND
- `tests/test_audit_db.py` — FOUND
- commit `673722f` — FOUND
- commit `3c1b47d` — FOUND
- commit `96518af` — FOUND
