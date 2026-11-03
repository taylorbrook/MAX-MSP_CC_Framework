---
phase: quick-261103-gah
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - README.md
autonomous: true
requirements:
  - QUICK-261103-gah

estimate:
  tokens: 25000
  raw_tokens: 25000
  tasks: 2
  confidence: low

must_haves:
  truths:
    - "README object-DB total, package count and test count equal the live repo values (sum of objects.json entries, packages/ dir count, pytest --collect-only)"
    - "README Patches table lists exactly the 34 patches/ projects, in case-insensitive alphabetical order, with each project's real file types"
    - "README milestone table rows are in ascending Shipped-date order"
    - "README GSD command table names only commands the installed GSD provides"
    - "README help-audit bullet states the current help_io pipeline coverage, not the v1.1 figure"
    - "Only README.md changes; no section is restyled, reworded beyond the stale clause, or restructured"
  artifacts:
    - path: "README.md"
      provides: "Up-to-date public README"
  key_links:
    - from: "README.md (Features, Quick Start, How It Works, Project Structure)"
      to: ".claude/max-objects/*/objects.json + .claude/max-objects/packages/*/objects.json"
      via: "object total and package count"
      pattern: "objects across 7 core domains"
    - from: "README.md ## Patches"
      to: "patches/*/"
      via: "tests/test_doc_signatures.py::test_readme_patch_table_lists_every_project"
      pattern: "^\\| \\*\\*"
---

<objective>
Audit README.md against the live repo and fix only claims that are verifiably stale or missing. Planning-time checks (2026-11-03, HEAD ef656373) already found the stale items listed in the tasks; the executor re-measures each before editing.

Purpose: README counts and tables drifted at v6.1.0 (Vision package added 22 DB entries and a 30th package; the face-tracker row was appended out of order). Keep the public README truthful without rewriting it.
Output: an edited README.md (README-only commits) and a SUMMARY listing every claim checked, its ground truth, and whether it changed.

Scope rules (user directive: no restyling, no restructure):
- Edit README.md only. Do NOT edit TECHNICAL.md, CHANGELOG.md, CLAUDE.md or installer/README.md, even where they carry the same stale numbers; list those lines in SUMMARY as a follow-up instead.
- Historical milestone-row figures (e.g. the v4.0 row's object count) describe that release and stay as written.
- Change the smallest span that makes a claim true; keep table shapes, column alignment and bullet names.
- If the executor finds a pre-identified item already correct at execution time, skip it and say so in SUMMARY. If nothing at all is stale, make no README commit and record that in SUMMARY.
</objective>

<execution_context>
@~/.claude/gsd-core/workflows/execute-plan.md
@~/.claude/gsd-core/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@CLAUDE.md
@README.md
@CHANGELOG.md

Ground-truth sources (read only what each task names):
- .claude/max-objects/*/objects.json and .claude/max-objects/packages/*/objects.json (object total; do NOT use extraction-log.json total_objects, it is extraction metadata that predates the Vision curation)
- tests/fixtures/help_io_baseline.json (help_io coverage: sources.bundle.files, totals.files)
- tests/test_doc_signatures.py (README guards: Patches table == patches/ dirs, Legacy Engine wording, no U+FFFD)
- ~/.claude/skills/gsd-*/SKILL.md (installed GSD command names and descriptions)

Planning-time measurements (re-measure; use the live value if it differs):
- Object total 3,467 (1,948 core + 1,519 package) across 30 package dirs (Vision is the 30th)
- Tests collected: 7,550
- src/maxpat LOC 40,775 (README's "~40,800" is still correct, leave it)
- 9 agent skill dirs, 7 critics (src/maxpat/critics/*_critic.py), 11 .claude/commands/*.md: all match README, leave them
- help_io baseline: 2,114 bundle .maxhelp files (Max 9.2.0) + 1,333 installed-package help files = 3,447
</context>

<tasks>

<task type="tracer">
  <name>Task 1: Count claims end-to-end (object total, package count, test count)</name>
  <files>README.md</files>
  <read_first>README.md lines 13, 77, 198, 211, 214, 216</read_first>
  <action>
Prove the measure -> edit -> guard-test path on the numeric claims first.

1. Measure live values from the repo root: object total = sum of len() over every .claude/max-objects/*/objects.json plus every .claude/max-objects/packages/*/objects.json; package count = number of .claude/max-objects/packages/*/objects.json files; test count = first token of the last line of python3 -m pytest --collect-only -q. Also confirm the LOC (find src/maxpat -name '*.py' | xargs cat | wc -l rounds to ~40,800) so it can be left alone.
2. Replace the pre-Vision object total in all four places it appears (Features bullet line 13, Quick Start research step line 77, How It Works "Object Database" paragraph line 198, Project Structure tree comment line 211) with the live total, comma-formatted (3,467 at planning time).
3. Replace the pre-Vision package count (one fewer than live) in its three places (lines 13, 198, 211) with the live count (30 at planning time). Keep the parenthetical package examples on line 13 unchanged.
4. Replace the test count in the Project Structure tree comment (line 216) with the live collected count, comma-formatted (7,550 at planning time).
5. Keep the tree comment column alignment (same-width numbers, so no padding change is expected). Do not touch the v4.0 milestone row's historical figure.
6. Note for SUMMARY: TECHNICAL.md line 86 (grand total and package subtotal) and line 834 (test count) carry the same stale numbers; record them as a follow-up, do not edit.
  </action>
  <verify>
    <automated>python3 -c "import json,glob;ps=glob.glob('.claude/max-objects/packages/*/objects.json');n=sum(len(json.load(open(f))) for f in glob.glob('.claude/max-objects/*/objects.json')+ps);r=open('README.md').read();assert r.count(format(n,','))>=4,n;assert '3,445' not in r;assert r.count(str(len(ps))+' packages')>=3,len(ps);print('db ok',n,len(ps))" && python3 -c "import subprocess;o=subprocess.run(['python3','-m','pytest','--collect-only','-q'],capture_output=True,text=True).stdout.strip().splitlines()[-1];n=int(o.split()[0]);r=open('README.md').read();assert '('+format(n,',')+' tests)' in r,n;print('tests ok',n)" && python3 -m pytest tests/test_doc_signatures.py tests/test_dead_code_removed.py -q</automated>
  </verify>
  <done>README states the live object total in all 4 places, the live package count in all 3 places and the live test count; both count assertions print "ok"; the 134 README/doc guard tests pass (baseline at HEAD: both assertions fail, guards pass).</done>
</task>

<task type="auto">
  <name>Task 2: Remaining stale claims (help-audit bullet, table order, file types, GSD commands, missing prerequisites/tree entry) and a full-README sweep</name>
  <files>README.md</files>
  <read_first>README.md lines 23, 29-38, 151-190, 206-264; tests/fixtures/help_io_baseline.json (sources.bundle.files, totals.files); tools/help_io.py docstring lines 1-25; ~/.claude/skills/gsd-verify-work/SKILL.md frontmatter</read_first>
  <action>
Fix each pre-identified item after re-checking it, then sweep the rest of README once.

a. Help-audit bullet (line 23): its help-file count is the v1.1 figure. The current pipeline is tools/help_io.py run via python3 tools/audit_db.py --help-io, which compares every box in the shipped help files with the DB; the baseline tests/fixtures/help_io_baseline.json records sources.bundle.files (2,114 in the Max 9.2.0 bundle) and totals.files minus that (1,333 from installed packages). Corrections are not automatic: they land through a tools/sync_max_bundle.py dry-run then explicit --apply steps (and overrides.json). Rewrite only the clause after the bullet name so it states those two counts (read from the baseline) and that reviewed corrections go into the DB via sync_max_bundle.py --apply. Keep the bullet name "Help patch audit pipeline".
b. Patches table: move the face-tracker row up so it sits between disintegrate and FDNVerb; the table is case-insensitive alphabetical everywhere else. Add `.maxhelp` to the FDNVerb Files cell (patches/FDNVerb ships a .maxhelp). Re-check every row's Files cell against the extensions actually present in patches/NAME/ (maxpat, gendsp, js, maxhelp, amxd; ignore test-results/); planning found FDNVerb the only mismatch.
c. Milestone table: move the v5.0 row (shipped 2026-05-01) from the bottom to directly above the v6.0.0 row so Shipped dates ascend. Row text unchanged.
d. GSD command table: the installed GSD exposes hyphenated skill names (confirm with ls ~/.claude/skills piped to grep '^gsd-'); the colon-prefixed form is stale and the fourth row names a command that does not exist. Change the first three rows to /gsd-discuss-phase, /gsd-plan-phase, /gsd-execute-phase (descriptions unchanged) and replace the fourth row with /gsd-verify-work and the description from its SKILL.md frontmatter ("Validate built features through conversational UAT"). Keep the GSD repo link and surrounding prose as written.
e. Prerequisites, MAX 9 bullet (line 31): add a short clause that the Vision package jit.vis.* objects (and the other objects tagged min_version 9.2, see .claude/skills/references/max-9.2-changes.md) need Max 9.2+. Source: CHANGELOG 6.1.0 and the DB min_version field.
f. Project Structure tree: add a versions.json line under the {project-name}/ block (after status.md), with a short aligned comment such as "Version history (bumped on every iteration)"; src/maxpat/project.py writes it and 33 of 34 projects have it.
g. Sweep: read Note, Features, Quick Start, Commands, How It Works and Project Structure once more and check every remaining concrete claim (named commands and flags exist in .claude/commands/*.md, named files and paths exist, named APIs exist in src/maxpat, counts match). Planning found these correct: 11 commands incl. /max-diagnose, /max-iterate --fix, /max-verify --live; tools/max_bridge/max-bridge.maxpat; --check-deps in install.sh and installer/bin/create-max-framework.js; 9 agents; 7 critics; dsp_sim smoke; add_m4l_device/add_m4l_gen_synth/polish_m4l_device/export_amxd; add_rnbo/generate_rnbo_wrapper. Fix anything else only if it is verifiably wrong against the repo; otherwise leave it.
h. Run the README guard tests, then commit README.md alone by explicit path (git add README.md; never git add . or -A, per CLAUDE.md Rule #7 multi-instance safety) with message "docs(readme): refresh counts, tables and GSD commands after v6.1.0 (quick 261103-gah)". Do not use git stash.
i. SUMMARY: a table of every claim checked (claim, README line, ground truth + source command/file, changed yes/no), plus the follow-up list of the same stale numbers in TECHNICAL.md (lines 86 and 834) and anything else found outside README.
  </action>
  <verify>
    <automated>python3 -c "import re,json;r=open('README.md').read();s=r.split('## Patches')[1].split('\n## ')[0];rows=re.findall(r'^\|\s*\*\*([^*]+)\*\*',s,re.M);assert rows==sorted(rows,key=str.lower),'patch order';assert re.search(r'^\| \*\*FDNVerb\*\*.*\.maxhelp',s,re.M),'FDNVerb files';m=r.split('| Milestone |')[1];d=re.findall(r'^\| \*\*[^|]+\| (\d{4}-\d{2}-\d{2})',m,re.M);assert len(d)==13 and d==sorted(d),'milestone order';assert '/gsd:' not in r and '/gsd-verify-work' in r and 'verify-phase' not in r,'gsd';b=json.load(open('tests/fixtures/help_io_baseline.json'));assert '973' not in r and format(b['sources']['bundle']['files'],',') in r,'help count';assert 'versions.json' in r,'tree';assert '9.2' in r.split('## Prerequisites')[1].split('\n## ')[0],'prereq';print('readme ok')" && python3 -m pytest tests/test_doc_signatures.py tests/test_dead_code_removed.py -q && C=$(git log -1 --format=%H --grep='quick 261103-gah') && test -n "$C" && F=$(git show --name-only --format= "$C") && test "$F" = "README.md" && echo "commit scope ok"</automated>
  </verify>
  <done>All seven structural assertions print "readme ok" (baseline at HEAD: every one fails); the doc guard tests pass; the commit whose message contains "quick 261103-gah" touches README.md only (prints "commit scope ok"); SUMMARY lists every checked claim with its ground truth and the TECHNICAL.md follow-up lines.</done>
</task>

</tasks>

<threat_model>
## Trust Boundaries

| Boundary | Description |
|----------|-------------|
| repo docs -> public readers | README.md is published on GitHub and in the npm/install.sh release; wrong claims mislead users but carry no code path |

## STRIDE Threat Register

| Threat ID | Category | Component | Severity | Disposition | Mitigation Plan |
|-----------|----------|-----------|----------|-------------|-----------------|
| T-261103-01 | Tampering | git commit scope | low | mitigate | Commit README.md by explicit path only (no git add . / -A, no git stash); Task 2 verify asserts the commit touches only README.md |
| T-261103-02 | Repudiation | README factual claims | low | mitigate | Every changed number is re-measured from a named repo source and recorded in SUMMARY with its command/file |
| T-261103-SC | Tampering | npm/pip/cargo installs | low | accept | No package installs in this plan |
</threat_model>

<verification>
- Task 1 and Task 2 automated commands pass from the repo root.
- python3 -m pytest tests/test_doc_signatures.py tests/test_dead_code_removed.py -q passes (134 tests at planning time).
- Every commit this plan made (Task 1 and Task 2) lists README.md only in git show --stat SHA (use the SHAs recorded in SUMMARY); git stash list is unchanged.
- Diff review: every hunk is a stale-claim fix or a row move; no prose rewrites elsewhere.
</verification>

<success_criteria>
- README counts (objects, packages, tests) equal live repo values.
- Patches table: 34 rows, case-insensitive alphabetical, correct file types.
- Milestone table in ascending date order.
- GSD table names only installed commands.
- Help-audit bullet, Prerequisites and Project Structure reflect the current pipeline, Max 9.2 requirement and versions.json.
- README-only commit(s); SUMMARY records every checked claim and the TECHNICAL.md follow-up.
</success_criteria>

<output>
Create `.planning/quick/261103-gah-review-the-readme-to-see-if-it-needs-upd/261103-gah-SUMMARY.md` when done
</output>
