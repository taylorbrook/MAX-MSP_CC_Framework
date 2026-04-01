---
phase: quick-260401-lpk
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - .claude/max-objects/overrides.json
  - .claude/max-objects/verified-objects.json
autonomous: true
requirements: [QUICK-260401-LPK]
must_haves:
  truths:
    - "overrides.json contains no user-abstraction entries (fswap, pan2, etc.)"
    - "overrides.json contains no metadata-only entries (only _audit + _outlet_types_verified)"
    - "7 low-agreement overrides have _needs_verification: true flag"
    - "ObjectDatabase loads correctly and all tests pass"
    - "verified-objects.json contains the 195 extracted metadata-only entries"
  artifacts:
    - path: ".claude/max-objects/overrides.json"
      provides: "Cleaned overrides with only real I/O corrections"
    - path: ".claude/max-objects/verified-objects.json"
      provides: "Tracking file for metadata-only verified objects"
  key_links:
    - from: "src/maxpat/db_lookup.py"
      to: ".claude/max-objects/overrides.json"
      via: "JSON load in _load()"
      pattern: "overrides_data.get\\(\"objects\""
---

<objective>
Clean overrides.json by removing 10 user-abstraction entries, separating ~195 metadata-only entries into a tracking file, and flagging 7 low-agreement overrides for future verification.

Purpose: Reduce overrides.json to only genuine I/O corrections, making it easier to audit and maintain.
Output: Cleaned overrides.json (~229 real entries), new verified-objects.json tracking file.
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/execute-plan.md
@$HOME/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@src/maxpat/db_lookup.py
@.claude/max-objects/overrides.json
</context>

<tasks>

<task type="auto">
  <name>Task 1: Clean overrides.json and create verified-objects.json</name>
  <files>.claude/max-objects/overrides.json, .claude/max-objects/verified-objects.json</files>
  <action>
Write a Python script (run inline, not saved) that:

1. Load overrides.json

2. Remove 10 user-abstraction entries from objects: fswap, pan2, pan2S, pcontrol_ExamplePatch, poobah, thru, transratio, urn-jb, xbendout2, yafr2

3. Identify metadata-only entries: entries where ALL keys start with "_" (i.e., no real inlet/outlet corrections -- they only have _audit and _outlet_types_verified). There should be ~195 of these.

4. Extract those metadata-only entries into a new dict for verified-objects.json:
```json
{
  "_comment": "Objects verified by audit as having correct I/O in domain files. Tracking file only -- not loaded by ObjectDatabase.",
  "objects": {
    "!-~": { "_outlet_types_verified": true, "_audit": { ... } },
    ...
  }
}
```

5. Remove the metadata-only entries from overrides.json objects dict.

6. Add "_needs_verification": true to the _audit dict of these 7 low-agreement entries (they stay in overrides.json since they have real corrections): receive, bondo, mousestate, pipe, jit.gl.pix, jit.phys.multiple, mc.targetlist

7. Write both files back with indent=2 and trailing newline. Preserve all other top-level keys in overrides.json (version_map, variable_io_rules, _uncovered_empty_io, _comment). Preserve domain separator comment keys (_domain_max, _domain_msp, etc.) in overrides.json.

8. Print summary counts: entries removed, entries separated, entries flagged, entries remaining.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -c "
import json
with open('.claude/max-objects/overrides.json') as f:
    data = json.load(f)
objects = {k:v for k,v in data['objects'].items() if not k.startswith('_')}

# No user abstractions
ua = ['fswap','pan2','pan2S','pcontrol_ExamplePatch','poobah','thru','transratio','urn-jb','xbendout2','yafr2']
for name in ua:
    assert name not in objects, f'{name} still in overrides'

# No metadata-only entries
for name, entry in objects.items():
    non_meta = [k for k in entry if not k.startswith('_')]
    assert non_meta, f'{name} is metadata-only, should have been separated'

# Low-agreement flagged
flagged = ['receive','bondo','mousestate','pipe','jit.gl.pix','jit.phys.multiple','mc.targetlist']
for name in flagged:
    assert objects[name]['_audit'].get('_needs_verification'), f'{name} not flagged'

# verified-objects.json exists and has entries
with open('.claude/max-objects/verified-objects.json') as f:
    vdata = json.load(f)
assert len(vdata['objects']) >= 190, f'Expected ~195, got {len(vdata[\"objects\"])}'

print('All checks passed')
print(f'overrides.json real entries: {len(objects)}')
print(f'verified-objects.json entries: {len(vdata[\"objects\"])}')
"
    </automated>
  </verify>
  <done>overrides.json has ~229 real correction entries (no user abstractions, no metadata-only). verified-objects.json has ~195 metadata-only entries. 7 low-agreement entries flagged.</done>
</task>

<task type="auto">
  <name>Task 2: Verify ObjectDatabase loads correctly and all tests pass</name>
  <files></files>
  <action>
1. Run the ObjectDatabase smoke test inline:
```python
from src.maxpat.db_lookup import ObjectDatabase
db = ObjectDatabase()
# Verify core lookups still work
assert db.exists("cycle~"), "cycle~ missing"
assert db.exists("t"), "alias t missing"
assert db.lookup("trigger") is not None, "trigger missing"
# Verify overridden objects still get overrides applied
assert db.is_overridden("*"), "* should still be overridden"
# Verify user abstractions are NOT in the DB (they never were in domain files)
for ua in ['fswap','pan2','pan2S','pcontrol_ExamplePatch','poobah','thru','transratio','urn-jb','xbendout2','yafr2']:
    assert not db.exists(ua), f"{ua} should not exist"
# Verify variable I/O still works
assert db.compute_io_counts("trigger", ["b","i","f"]) == (1, 3)
print("ObjectDatabase smoke test passed")
```

2. Run the full test suite: `python3 -m pytest tests/ -x -q`

Both must pass with zero failures.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -m pytest tests/ -x -q 2>&1 | tail -5</automated>
  </verify>
  <done>ObjectDatabase loads the cleaned overrides.json without errors. All existing tests pass.</done>
</task>

</tasks>

<verification>
- overrides.json: no user abstractions, no metadata-only entries, 7 flagged entries, domain separators preserved
- verified-objects.json: ~195 metadata-only entries, tracking-only file
- ObjectDatabase: loads correctly, lookups work, overrides applied
- Full test suite: all tests pass
</verification>

<success_criteria>
- overrides.json reduced from ~434 to ~229 real entries
- 10 user-abstraction entries removed
- ~195 metadata-only entries in verified-objects.json
- 7 low-agreement entries flagged with _needs_verification
- `python3 -m pytest tests/ -x -q` passes
</success_criteria>

<output>
After completion, create `.planning/quick/260401-lpk-clean-overrides-json-remove-user-abstrac/260401-lpk-SUMMARY.md`
</output>
