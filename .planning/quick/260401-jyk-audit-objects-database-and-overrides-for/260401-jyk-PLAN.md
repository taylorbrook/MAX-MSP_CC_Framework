---
phase: quick-260401-jyk
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - scripts/audit_objects_db.py
  - .claude/max-objects/audit/AUDIT-REPORT.md
autonomous: true
requirements: [AUDIT-01]

must_haves:
  truths:
    - "Every override key in overrides.json['objects'] maps to an object that exists in at least one domain file"
    - "Every alias in aliases.json['aliases'] resolves to a canonical name present in domain files"
    - "Every PD blocklist entry with a max_equivalent has that equivalent in domain files"
    - "No object name appears in multiple domain files with conflicting inlet/outlet definitions"
    - "Every domain object has all required fields (name, maxclass, module, domain, inlets, outlets)"
    - "Report captures all issues found with zero database modifications"
  artifacts:
    - path: "scripts/audit_objects_db.py"
      provides: "Audit script that checks all 6 areas"
      min_lines: 150
    - path: ".claude/max-objects/audit/AUDIT-REPORT.md"
      provides: "Markdown report of all issues found"
      min_lines: 20
  key_links:
    - from: "scripts/audit_objects_db.py"
      to: ".claude/max-objects/*/objects.json"
      via: "json.load for each domain"
      pattern: "objects\\.json"
    - from: "scripts/audit_objects_db.py"
      to: ".claude/max-objects/overrides.json"
      via: "json.load and iterate objects dict"
      pattern: "overrides\\.json"
---

<objective>
Audit the MAX object database for correctness: overrides, aliases, PD blocklist, cross-domain duplicates, and structural integrity. Produce a Markdown report of all issues found. No database modifications.

Purpose: Identify data quality issues before making any corrections, so the user can review and prioritize fixes.
Output: `scripts/audit_objects_db.py` (reusable audit script) + `.claude/max-objects/audit/AUDIT-REPORT.md` (findings report)
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/execute-plan.md
@$HOME/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@CLAUDE.md (object database structure, required fields, supplementary file formats)

Database structure (from inspection):
- 8 domain files at `.claude/max-objects/{domain}/objects.json` (max:470, msp:248, jitter:210, mc:215, gen:189, m4l:33, rnbo:560, packages:87)
- `overrides.json` top-level keys: `_comment`, `objects` (dict, 447 entries including 9 `_domain_*` markers and 438 real override entries), `version_map`, `variable_io_rules`, `_uncovered_empty_io`
- Override entries in `objects` dict are keyed by object name. Domain markers like `_domain_max` are string values (not dicts) and should be skipped.
- `aliases.json` structure: `{ "_comment": "...", "aliases": { "t": "trigger", ... } }` (10 aliases)
- `pd-blocklist.json` structure: `{ "_comment": "...", "blocklist": { "osc~": { "max_equivalent": "cycle~", "reason": "..." }, ... } }` (19 entries)
- Each domain object has keys: name, maxclass, module, domain, inlets (array), outlets (array), arguments, messages, min_version, verified, rnbo_compatible, variable_io, plus optional: category, digest, description, seealso, tags, attributes
- Required fields per CLAUDE.md: name, maxclass, module, domain, inlets, outlets
</context>

<tasks>

<task type="auto">
  <name>Task 1: Write comprehensive audit script</name>
  <files>scripts/audit_objects_db.py</files>
  <action>
Create a Python script at `scripts/audit_objects_db.py` that performs all 6 audit checks and writes a Markdown report to `.claude/max-objects/audit/AUDIT-REPORT.md`.

The script must:

1. **Load all data**: Read all 8 domain files (`max`, `msp`, `jitter`, `mc`, `gen`, `m4l`, `rnbo`, `packages`), `overrides.json`, `aliases.json`, `pd-blocklist.json`. Build a unified lookup dict mapping object name to list of (domain, object_data) tuples to detect cross-domain presence.

2. **Check 1 — Orphaned overrides**: For each key in `overrides["objects"]` that is a dict (skip `_domain_*` string markers), check if that key exists in any domain file. Report keys that exist in overrides but not in any domain.

3. **Check 2 — Override field plausibility**: For each override that IS a dict and corresponds to a real domain object, compare override fields to base object fields. Flag:
   - Override specifies more inlets/outlets than base (potential count mismatch)
   - Override changes `domain` or `module` (suspicious)
   - Override has fields not present in the base object schema

4. **Check 3 — Alias consistency**: For each alias in `aliases["aliases"]`, verify the canonical (target) name exists in at least one domain file.

5. **Check 4 — Cross-domain duplicates**: For object names that appear in 2+ domain files, compare inlet count, outlet count, and maxclass. Flag where these differ (legitimate duplicates like RNBO variants should be noted but distinguished from true conflicts).

6. **Check 5 — Structural integrity**: For every object in every domain file, verify presence of required fields: `name`, `maxclass`, `module`, `domain`, `inlets`, `outlets`. Also check that `inlets` and `outlets` are lists (not null/missing). Report objects missing any required field.

7. **Check 6 — PD blocklist consistency**: For each entry in `pd-blocklist["blocklist"]`, if `max_equivalent` is a simple object name (not a compound like "reson~ or biquad~"), verify it exists in domain files. For compound equivalents, check each named object. Flag missing equivalents.

Output format: Write Markdown report with sections for each check, including summary counts and detailed tables of issues. Each issue should include: object name, domain(s), what's wrong, and the specific values involved.

The script should:
- Use `pathlib.Path` for paths, with the project root derived from the script's location (`Path(__file__).resolve().parent.parent`)
- Print a summary to stdout when run
- Return exit code 0 (report-only, no failures)
- Handle edge cases: empty domain files, malformed entries gracefully (log and continue)
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 scripts/audit_objects_db.py && test -f .claude/max-objects/audit/AUDIT-REPORT.md && echo "PASS"</automated>
  </verify>
  <done>Script runs without errors, reads all 8 domain files + 3 supplementary files, writes AUDIT-REPORT.md</done>
</task>

<task type="auto">
  <name>Task 2: Run audit and verify report completeness</name>
  <files>.claude/max-objects/audit/AUDIT-REPORT.md</files>
  <action>
Run the audit script and verify the report covers all 6 check areas:

1. Run `python3 scripts/audit_objects_db.py` and capture output
2. Read the generated AUDIT-REPORT.md
3. Verify it has sections for all 6 checks (orphaned overrides, field plausibility, alias consistency, cross-domain duplicates, structural integrity, PD blocklist consistency)
4. Verify each section has either "No issues found" or a table of specific issues
5. Add an "Executive Summary" section at the top of the report with total issue counts per category and an overall health assessment

Do NOT modify any database files. The report is the only deliverable.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -c "
report = open('.claude/max-objects/audit/AUDIT-REPORT.md').read()
checks = ['Orphaned Overrides', 'Override Field', 'Alias Consistency', 'Cross-Domain', 'Structural Integrity', 'PD Blocklist']
missing = [c for c in checks if c not in report]
assert not missing, f'Missing sections: {missing}'
assert 'Summary' in report, 'Missing summary section'
print('All 6 audit sections present + summary')
"</automated>
  </verify>
  <done>AUDIT-REPORT.md contains all 6 check sections plus executive summary, with specific issue details and counts. No database files modified.</done>
</task>

</tasks>

<verification>
- `python3 scripts/audit_objects_db.py` runs cleanly (exit 0)
- `.claude/max-objects/audit/AUDIT-REPORT.md` exists and covers all 6 audit areas
- No files in `.claude/max-objects/` modified except within `audit/` directory
- Report includes actionable detail (object names, domains, field values) for each issue found
</verification>

<success_criteria>
- Audit script is reusable (can be re-run after fixes to verify corrections)
- Report covers all 6 areas from the task description
- Every issue includes enough detail for the user to evaluate whether a fix is needed
- Zero changes to any database file (overrides.json, aliases.json, pd-blocklist.json, domain objects.json files)
</success_criteria>

<output>
After completion, create `.planning/quick/260401-jyk-audit-objects-database-and-overrides-for/260401-jyk-01-SUMMARY.md`
</output>
