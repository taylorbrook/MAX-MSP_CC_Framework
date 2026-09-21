---
phase: quick-260921-knq
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - tools/audit_db.py
  - tests/test_audit_db.py
autonomous: true
requirements: [NH-01]

estimate:
  tokens: 55000
  raw_tokens: 55000
  tasks: 3
  confidence: low

must_haves:
  truths:
    - "`python3 tools/audit_db.py` exits 0 on this machine and prints a short text summary naming the installed Max version (9.1.5) and the DB age in days."
    - "`python3 tools/audit_db.py --max-app /nonexistent/Max.app` still exits 0, reports the bundle as unavailable, and still emits the DB-only sections."
    - "`--json <path>` writes one JSON document containing all seven sections: install, db_age, missing_from_db, absent_from_bundle, empty_io, patch_objects, ui_maxclasses_gap."
    - "The tool refuses (non-zero exit, no file written) when `--json` resolves inside `patches/` or `.claude/max-objects/`."
    - "missing_from_db is keyed on the refpage `<c74object name>` attribute, so it reports single-digit unresolved names against the installed 9.1.5 bundle, not ~800 filename-derived phantoms (SF-07)."
    - "The audit never runs the Max binary — the only subprocesses are `git` invocations passed as argv lists."
  artifacts:
    - tools/audit_db.py
    - tests/test_audit_db.py
  key_links:
    - "tools/audit_db.py imports ObjectDatabase from src.maxpat.db_lookup and reuses lookup() / audit_empty_io() / audit_half_empty_io() rather than re-reading the domain JSON."
    - "tools/audit_db.py imports UI_MAXCLASSES from src.maxpat.maxclass_map for the maxclass gap check."
    - "Committed .maxpat enumeration goes through `git ls-files`, with content read at HEAD via `git show HEAD:<path>` so a dirty working tree cannot skew the audit."
    - "tests/test_audit_db.py drives the tool against a tmp_path fake repo root + fake Max bundle, so the suite passes on a machine with no Max installed."
---

<objective>
Promote the throwaway DB-vs-installed-Max audit harness (NH-01 in the 260921-g5d review) into a reproducible, read-only `tools/audit_db.py` with a smoke test.

Purpose: the g5d review's 12-section evidence file lived in a session scratchpad and is gone. Without a committed harness, "is the object DB still true against the installed Max?" is an unanswerable question that costs a full ad-hoc review each time. With it, DB drift is measurable on demand.
Output: `tools/audit_db.py` (read-only, JSON + text summary) and `tests/test_audit_db.py` (hermetic smoke test, no Max required).
</objective>

<execution_context>
@~/.claude/gsd-core/workflows/execute-plan.md
@~/.claude/gsd-core/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@CLAUDE.md
@.planning/quick/260921-g5d-review-this-repo-to-see-if-there-are-any/260921-g5d-REVIEW-FINDINGS.md

# Reuse targets — read before writing any extraction logic
@src/maxpat/db_lookup.py
@src/maxpat/maxclass_map.py
@tools/extract_pkg_io.py
@scripts/audit_signal_role.py

**House facts already established (do not re-derive):**
- `ObjectDatabase(db_root=...)` accepts an explicit DB root; `DOMAIN_LOAD_ORDER` lists the 8 domain dirs; `packages/` is 29 per-package dirs, not one file.
- `audit_empty_io()` returns `critical` / `covered_by_override` / `variable_io_ok` / `by_source`; `audit_half_empty_io()` returns `sinks` / `sources`. Current reading: 9 both-empty, 109 sinks, 100 sources.
- `UI_MAXCLASSES` in `src/maxpat/maxclass_map.py` is authoritative for UI maxclasses; the DB's own `maxclass` field is NOT.
- Installed bundle: `/Applications/Max.app`. Version lives in `Contents/Info.plist` (`CFBundleShortVersionString` = 9.1.5, build in `CFBundleVersion`). Core refpages: `Contents/Resources/C74/docs/refpages/{max,msp,jit,m4l}-ref`. Bundled package refpages: `Contents/Resources/C74/packages/<Pkg>/docs/refpages` (Gen, RNBO, Node for Max, VIDDLL).
- `.claude/max-objects/extraction-log.json` carries `extraction_timestamp` (ISO 8601, currently 2026-07-01T21:43:50Z) and `domain_counts`.
- `.claude/scripts/extract_objects.py` already parses refpages; its `parse_standard_xml` reads `root.get("name")` with a filename fallback. Mirror that name derivation — the `name` attribute wins (SF-07).
- User packages under `~/Documents/Max 9/Packages` are TCC-blocked and raise `PermissionError` (SF-05). Every filesystem walk must survive that.

**Working-tree hazard (live at planning time):** three unrelated modifications exist — `patches/.active-project.json`, `patches/FDNVerb/generated/FDNVerb.maxhelp`, `patches/scala-synth/generated/scala-synth.maxpat` — owned by a concurrent instance. Stage explicit paths only (`git add tools/audit_db.py tests/test_audit_db.py`). Never `git add .` / `-A`. Never `git stash` (CLAUDE.md Rule #7).
</context>

<tasks>

<task type="tracer">
  <name>Task 1: End-to-end audit skeleton — one run, real data, safe output</name>
  <files>tools/audit_db.py</files>
  <action>
Create `tools/audit_db.py` as a read-only CLI that runs end-to-end on the first commit: argument parsing, path resolution, the output write-guard, two real sections, JSON emit, and the text summary. This is the thin vertical slice; Task 2 widens it.

Module docstring states: read-only audit of `.claude/max-objects/` against the installed Max bundle; writes nothing except the `--json` output file; never executes the Max binary (version comes from `Info.plist` via `plistlib`). Cite NH-01 and quick-260921-knq as origin, matching the provenance style of `tools/extract_pkg_io.py`.

Path resolution, following the `tools/extract_pkg_io.py` pattern — `ROOT = Path(__file__).resolve().parent.parent`, `sys.path.insert(0, str(ROOT))` so `from src.maxpat.db_lookup import ObjectDatabase` works when invoked as `python3 tools/audit_db.py`.

CLI flags: `--repo-root` (default ROOT), `--db-root` (default `<repo-root>/.claude/max-objects`), `--max-app` (default `/Applications/Max.app`), `--json PATH` (optional; when omitted only the text summary prints), `--patch-source` with choices `head` and `worktree` (default `head`).

Write-guard: a module-level helper that takes the requested `--json` path and the repo root, resolves both, and raises/exits non-zero with a clear message when the resolved output path is inside `<repo-root>/patches` or `<repo-root>/.claude/max-objects`. This is the single structural guarantee behind the "writes nothing under those trees" claim, so it must be a named, importable function the test can call directly — not an inline check. It is the ONLY place the tool opens a file for writing.

Section `install`: read `<max-app>/Contents/Info.plist` with `plistlib.load` in binary mode. Emit `{available, app_path, short_version, build_version, refpage_roots: [...]}`. When the plist is missing, unreadable, or malformed, emit `{available: false, reason: "<what failed>"}` and keep going — do not raise, do not exit non-zero. `PermissionError` and `OSError` are caught and surface as the reason string (TCC, per SF-05).

Section `db_age`: load `<db-root>/extraction-log.json`, parse `extraction_timestamp` with `datetime.fromisoformat`, compute `age_days` against `datetime.now(timezone.utc)`. Emit the log's `domain_counts` alongside live counts taken from disk (7 core `<domain>/objects.json` files plus the per-package dirs under `packages/`), and a per-domain `matches` boolean. Missing log file emits `{available: false, reason: ...}`.

Envelope: a top-level dict `{generated_at, repo_root, max_app, sections: {...}}` where every section key is always present even when unavailable, so downstream consumers never KeyError. Add `install` and `db_age` now; Task 2 fills the remaining five with the same `{available, ...}` shape.

Text summary (stdout, ~10 lines): installed version, DB age in days, and one line per section with its headline count or its unavailable reason. Keep it scannable — this is what a human reads before deciding whether to open the JSON.

Exit code is 0 for any successfully-completed audit, including one where the bundle was unavailable. Reserve non-zero for the write-guard rejection and for genuinely unusable arguments. A missing Max install is a reported fact, not an error.
  </action>
  <verify>
    <automated>python3 tools/audit_db.py --json /private/tmp/claude-501/-Users-taylorbrook-Dev-MAX/d90c4435-d287-444e-ba20-fc9eeffb6aa8/scratchpad/audit-t1.json && python3 -c "import json,sys; d=json.load(open('/private/tmp/claude-501/-Users-taylorbrook-Dev-MAX/d90c4435-d287-444e-ba20-fc9eeffb6aa8/scratchpad/audit-t1.json')); s=d['sections']; assert s['install']['short_version']=='9.1.5', s['install']; assert s['db_age']['age_days']>0; print('OK', s['install']['short_version'], s['db_age']['age_days'])"</automated>
    <automated>python3 tools/audit_db.py --max-app /nonexistent/Max.app --json /private/tmp/claude-501/-Users-taylorbrook-Dev-MAX/d90c4435-d287-444e-ba20-fc9eeffb6aa8/scratchpad/audit-t1-nomax.json && python3 -c "import json; d=json.load(open('/private/tmp/claude-501/-Users-taylorbrook-Dev-MAX/d90c4435-d287-444e-ba20-fc9eeffb6aa8/scratchpad/audit-t1-nomax.json')); s=d['sections']; assert s['install']['available'] is False, s['install']; assert s['db_age']['available'] is not False; print('OK degraded')"</automated>
    <automated>python3 tools/audit_db.py --json patches/should-never-exist.json; test $? -ne 0 && test ! -e patches/should-never-exist.json && echo "OK guard"</automated>
  </verify>
  <done>One command produces a real JSON document and a text summary on this machine; the same command with a bogus `--max-app` still exits 0 with `install.available: false`; a `--json` path under `patches/` is refused with a non-zero exit and no file created.</done>
</task>

<task type="auto">
  <name>Task 2: Expand to the five remaining audit sections</name>
  <files>tools/audit_db.py</files>
  <action>
Widen the skeleton from Task 1 with the five remaining sections. Each follows the established `{available, ...}` envelope and degrades to `{available: false, reason: ...}` rather than raising.

Refpage index (shared helper, built once): walk the core refpage roots and the bundled-package refpage roots for `*.maxref.xml`. For each file parse with `xml.etree.ElementTree`, take the object name from the root element's `name` attribute, falling back to the filename stem with `.maxref` stripped only when the attribute is absent or empty — mirroring `parse_standard_xml` in `.claude/scripts/extract_objects.py`. Record for each name its source file and its declared inlet/outlet counts. Wrap the per-file parse in try/except for `ET.ParseError`, and the directory walk in try/except for `PermissionError`/`OSError`, tallying failures into a `parse_errors` / `unreadable_roots` list instead of aborting. Also emit `name_vs_filename_differs` count — the SF-07 number, which is the harness's own self-check that it is keyed correctly.

Section `missing_from_db`: refpage names that `ObjectDatabase.lookup()` returns None for. Emit the sorted list plus its count. Against the installed 9.1.5 bundle this is single-digit; if it comes out in the hundreds the name derivation regressed to filenames.

Section `absent_from_bundle`: DB canonical names from the seven core domain files (skip the per-package dirs — they are TCC-blocked upstream, per SF-05 and the g5d limitation note) that have no entry in the refpage index. Emit the sorted list, its count, and an explicit `scope` string recording that per-package files were not walked, so a future reader cannot mistake the number for full coverage.

Section `empty_io`: call `audit_empty_io()` and `audit_half_empty_io()` on the ObjectDatabase instance — do not re-derive either set. Emit `critical`, `covered_by_override`, `sinks`, `sources`, and `by_source`, and annotate each name in `critical`, `sinks`, and `sources` with a `has_refpage` boolean from the refpage index. When the bundle is unavailable, `has_refpage` is null (unknown) rather than false — an unreadable bundle is a measurement gap, not evidence of absence.

Section `patch_objects`: enumerate committed `.maxpat` files with `subprocess.run(["git", "ls-files", "--", "*.maxpat"], ...)` from the repo root, passing an argv list (never a shell string), `check=False`, `text=True`. With `--patch-source head` (the default) read each file's content via `subprocess.run(["git", "show", f"HEAD:{path}"], ...)` so a dirty working tree cannot skew the result; fall back to the on-disk copy when the blob is absent at HEAD, recording `source: "worktree"` for that file. With `--patch-source worktree` read from disk throughout. When git is unavailable or the root is not a repository, fall back to globbing `<repo-root>/patches/**/*.maxpat` and set `enumeration: "filesystem"`. For each patch, walk `patcher.boxes` recursively into nested `patcher` dicts with a depth cap (e.g. 32) to bound malformed input. Resolve the object name as the first whitespace-delimited token of `text` for `newobj` boxes, and the `maxclass` value for every other box. Emit `{files_scanned, enumeration, objects_referenced, unresolved: [{name, files}], empty_io_hits: [{name, files}]}` where unresolved means `lookup()` returned None and empty_io_hits means it resolved with both I/O sides empty. Record the documented limitation verbatim in a `limitations` field: message-box contents, attribute arguments, and objects created at runtime via scripting are not covered.

Section `ui_maxclasses_gap`: collect every distinct `maxclass` seen during the same patch walk, subtract `UI_MAXCLASSES` imported from `src.maxpat.maxclass_map`, and subtract the structural value `newobj`. Emit the residual sorted list plus the full observed maxclass tally. On the current tree this residual is expected to be empty — `codebox` was admitted in quick-260921-ima — so a non-empty result is a real finding, not noise.

Extend the text summary with one line per new section carrying its headline count. Keep total runtime reasonable; the original harness did all twelve sections in ~40s.
  </action>
  <verify>
    <automated>python3 tools/audit_db.py --json /private/tmp/claude-501/-Users-taylorbrook-Dev-MAX/d90c4435-d287-444e-ba20-fc9eeffb6aa8/scratchpad/audit-t2.json && python3 -c "import json; d=json.load(open('/private/tmp/claude-501/-Users-taylorbrook-Dev-MAX/d90c4435-d287-444e-ba20-fc9eeffb6aa8/scratchpad/audit-t2.json')); s=d['sections']; [s[k] for k in ('install','db_age','missing_from_db','absent_from_bundle','empty_io','patch_objects','ui_maxclasses_gap')]; m=s['missing_from_db']; assert m['count'] < 50, ('filename-keyed regression?', m['count']); p=s['patch_objects']; assert p['files_scanned'] >= 60, p['files_scanned']; assert p['unresolved']==[], p['unresolved']; print('OK', m['count'], p['files_scanned'], s['ui_maxclasses_gap'])"</automated>
    <automated>test "$(grep -v '^[[:space:]]*#' tools/audit_db.py | grep -c 'subprocess.run(\["git"')" = "$(grep -v '^[[:space:]]*#' tools/audit_db.py | grep -c 'subprocess.run(')" && echo "OK git-only subprocess"</automated>
    <automated>python3 tools/audit_db.py --max-app /nonexistent/Max.app --json /private/tmp/claude-501/-Users-taylorbrook-Dev-MAX/d90c4435-d287-444e-ba20-fc9eeffb6aa8/scratchpad/audit-t2-nomax.json && python3 -c "import json; d=json.load(open('/private/tmp/claude-501/-Users-taylorbrook-Dev-MAX/d90c4435-d287-444e-ba20-fc9eeffb6aa8/scratchpad/audit-t2-nomax.json')); s=d['sections']; assert s['missing_from_db']['available'] is False; assert s['patch_objects']['files_scanned'] >= 60; print('OK degraded w/ DB sections intact')"</automated>
  </verify>
  <done>All seven sections emit on a real run; `missing_from_db` is single-digit (name-attribute keying, SF-07); zero unresolved objects across committed `.maxpat` files; every subprocess invocation is a `git` argv list; with the bundle unavailable the bundle-dependent sections report unavailable while the DB- and patch-derived sections still produce data.</done>
</task>

<task type="auto" tdd="true">
  <name>Task 3: Hermetic smoke test + no-write proof, then commit</name>
  <files>tests/test_audit_db.py</files>
  <behavior>
    - Fake bundle: a tmp_path `Max.app/Contents/Info.plist` written with `plistlib.dump` (`CFBundleShortVersionString: "9.9.9"`) plus `Contents/Resources/C74/docs/refpages/max-ref/` holding two `.maxref.xml` files. Running the audit against it reports `short_version == "9.9.9"`.
    - Name-attribute keying: one fixture file is named `bitand.maxref.xml` but carries `<c74object name="&amp;">`. The refpage index must contain `&` and must NOT contain `bitand` (SF-07 regression guard — the exact bug that manufactured ~795 phantom gaps).
    - Filename fallback: a second fixture with no `name` attribute resolves to its filename stem with `.maxref` stripped.
    - Bundle unavailable: `--max-app <tmp_path>/absent.app` exits 0, `install.available` is False, and the DB-derived sections still carry data. This is what keeps the suite green on a machine with no Max installed.
    - Write guard: the guard helper rejects a path resolving under `<repo-root>/patches` and under `<repo-root>/.claude/max-objects`, and accepts a tmp_path target.
    - No-write proof: build a tmp_path fake repo root containing a minimal `.claude/max-objects/max/objects.json` (one or two objects) and a `patches/` dir holding one tiny `.maxpat`; snapshot `(relative_path, size, sha256)` for every file under both trees; run the audit with `--repo-root`/`--db-root` pointed at the fake root and `--json` into tmp_path; assert the snapshot is byte-identical afterwards and that no new paths appeared.
    - All seven section keys are present in the emitted JSON even in the fully-degraded fake-repo run.
  </behavior>
  <action>
Write `tests/test_audit_db.py` following the house convention in `tests/test_audit_signal_role.py`: import the tool as a module (`import tools.audit_db as audit_db`) and drive its top-level callables directly with kwargs where possible, falling back to `subprocess.run([sys.executable, "tools/audit_db.py", ...])` only where the CLI surface itself is under test. Build fixtures in `tmp_path` — do not add files under `tests/fixtures/`.

The tests must not depend on Max being installed: every assertion is either against the fake bundle in `tmp_path` or against the degraded path. Do not assert on the real `/Applications/Max.app`, on real object counts, or on real patch counts — those move and would make the suite machine-dependent.

If the no-write or fake-repo-root test exposes that `ObjectDatabase` cannot load a minimal `db_root`, adjust the fixture to include whatever the loader genuinely requires (e.g. an empty `aliases.json` / `overrides.json`) rather than weakening the assertion — and note the requirement in the test docstring.

Capture the full-suite baseline BEFORE adding the file (`python3 -m pytest -q 2>&1 | tail -3`) and record both the before and after lines in the SUMMARY. The expected delta is exactly the new tests; any other change in the failure set must be investigated, not absorbed. Note the concurrent-instance hazard: `patches/scala-synth/generated/scala-synth.maxpat` has an uncommitted degraded save in the working tree, which is known to flip a byte-identity xfail — attribute that to the concurrent instance rather than to this change, and do not touch the file.

Commit with explicitly enumerated paths only: `git add tools/audit_db.py tests/test_audit_db.py`. Do not stage the three pre-existing unrelated modifications. Do not `git stash`.
  </action>
  <verify>
    <automated>python3 -m pytest -q tests/test_audit_db.py</automated>
    <automated>SUITE=$(python3 -m pytest -q 2>&1); printf '%s\n' "$SUITE" | tail -3</automated>
    <automated>GS=$(git status --porcelain patches/) || exit 1; printf '%s\n' "$GS" | sort | head -5</automated>
  </verify>
  <done>`tests/test_audit_db.py` passes standalone and in the full suite; the full-suite failure set is unchanged from the pre-task baseline apart from the added tests; `git status --porcelain patches/` still shows exactly the same three pre-existing modifications and nothing else; the commit contains only `tools/audit_db.py` and `tests/test_audit_db.py`.</done>
</task>

</tasks>

<threat_model>
## Trust Boundaries

| Boundary | Description |
|----------|-------------|
| Max app bundle → audit process | Refpage XML and `Info.plist` are read from `/Applications/Max.app`; locally installed, trusted, but unvalidated by this tool. |
| Repo working tree / git objects → audit process | `.maxpat` JSON is parsed from `git show` output or disk; can be malformed or deeply nested. |
| Audit process → filesystem | The `--json` output path is the only write, and it is attacker-free but developer-typo-prone. |

## STRIDE Threat Register

| Threat ID | Category | Component | Severity | Disposition | Mitigation Plan |
|-----------|----------|-----------|----------|-------------|-----------------|
| T-knq-01 | Tampering | `--json` output path | high | mitigate | Named write-guard helper rejects any resolved path under `<repo-root>/patches` or `<repo-root>/.claude/max-objects`; it is the tool's only file-write site; Task 3 proves it both by direct call and by a byte-level snapshot of both trees. |
| T-knq-02 | Elevation of Privilege | subprocess usage | high | mitigate | Only `git ls-files` / `git show` are spawned, as argv lists with `check=False`; the Max binary is never executed (version comes from `plistlib`). Task 2 verify asserts every `subprocess.run(` call site is a `["git"` argv. |
| T-knq-03 | Denial of Service | `.maxpat` / refpage parsing | medium | mitigate | Recursive box walk carries an explicit depth cap; per-file XML parse errors and directory `PermissionError`/`OSError` are tallied, never fatal. |
| T-knq-04 | Information Disclosure | JSON output content | medium | mitigate | Output records object names, counts, and path strings only — no file contents, no user-package payloads. Default output is stdout-summary; JSON is written only where the operator points it. |
| T-knq-05 | Tampering | XML entity expansion in refpages | low | accept | `xml.etree.ElementTree` does not resolve external entities; input is the locally installed, developer-owned Max bundle. ASVS L1 for a local read-only dev tool — no hardened parser dependency added. |
| T-knq-SC | Tampering | npm/pip/cargo installs | high | mitigate | No package-manager installs in this plan — `tools/audit_db.py` and `tests/test_audit_db.py` use the Python standard library plus in-repo `src.maxpat` imports only. No `## Package Legitimacy Audit` is required because no install task exists. |

ASVS level 1, block on high (`workflow.security_asvs_level: 1`, `security_block_on: high`). All three high-severity threats are dispositioned `mitigate` with a task-level verification.
</threat_model>

<planner_contributions>
- **API coverage gate:** no ROADMAP phase exists for this quick task, so the detector resolves no scope and returns `skipped`. Per the fragment's skip branch, the checkpoint is skipped rather than answered — and on the merits the tool integrates no external API (stdlib + in-repo imports only).
- **Assumption-delta:** `phase_unresolved` → skipped. No singular→plural / required→optional / derived→chosen transition in scope.
- **Schema push gate:** no ORM-shaped files in scope → skipped silently.
- **Security:** applied as written above (ASVS level 1, block on high).
</planner_contributions>

<source_audit>
Single source for this task: NH-01 in `260921-g5d-REVIEW-FINDINGS.md`, plus the section list in the task description. No ROADMAP phase, no REQUIREMENTS.md entry, no CONTEXT.md decisions (no discuss step), no RESEARCH.md.

| Item | Source | Covered by |
|---|---|---|
| Installed version from Info.plist | description | Task 1 `install` |
| DB age | description | Task 1 `db_age` |
| missing-from-DB keyed on `<c74object name>` | description, SF-07 | Task 2 `missing_from_db` |
| absent-from-bundle | description | Task 2 `absent_from_bundle` |
| empty-I/O with refpage availability | description, MF-03/NH-02 | Task 2 `empty_io` |
| patch object resolution across committed `.maxpat` | description | Task 2 `patch_objects` |
| UI_MAXCLASSES gap check | description, SF-03 | Task 2 `ui_maxclasses_gap` |
| JSON + short text summary | description | Task 1 envelope + summary, extended in Task 2 |
| Never execute the Max binary | description | T-knq-02, Task 2 verify |
| Write nothing under `patches/` or `.claude/max-objects/` | description | T-knq-01, Task 1 guard, Task 3 snapshot |
| Small smoke test | description | Task 3 |

No item is MISSING. Deliberately out of scope and NOT silently dropped: the original harness's other five evidence sections (I/O-count deltas, outlet-type deltas, helper-symbol resolution, CLAUDE.md count-table check, user-package coverage). The description names seven sections; the remaining ones from the g5d run are additive follow-ups, and the envelope shape leaves room for them without restructuring.
</source_audit>

<verification>
- `python3 tools/audit_db.py` runs clean on this machine and its summary matches known facts: Max 9.1.5, DB extracted 2026-07-01, single-digit unresolved installed names, zero unresolved patch objects.
- `python3 tools/audit_db.py --max-app /nonexistent/Max.app` exits 0 with the bundle reported unavailable.
- `python3 -m pytest -q tests/test_audit_db.py` passes; the full suite's failure set is unchanged from the pre-task baseline.
- `git status --porcelain patches/ .claude/max-objects/` shows only the three pre-existing concurrent-instance modifications under `patches/` and nothing under `.claude/max-objects/`.
- `git show --stat HEAD` lists exactly `tools/audit_db.py` and `tests/test_audit_db.py`.
</verification>

<success_criteria>
- NH-01 closed: the audit is reproducible from a committed tool instead of a lost scratchpad script.
- Seven sections emit with a stable `{available, ...}` envelope; a missing Max install degrades rather than crashes.
- The read-only contract is structurally enforced (write-guard) and proven (snapshot test), not merely asserted in a docstring.
- The SF-07 name-attribute keying is encoded as a test, so a future re-extraction or audit cannot silently regress to filename keying.
</success_criteria>

<output>
Create `.planning/quick/260921-knq-per-nh-01-in-planning-quick-260921-g5d-r/260921-knq-SUMMARY.md` when done, recording: the before/after full-suite lines, the seven section headline counts from a real run, and any deviation from this plan (e.g. extra files `ObjectDatabase` required in the minimal fake `db_root`).
</output>
