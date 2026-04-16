---
phase: quick
plan: 260416-ery
type: execute
wave: 1
depends_on: []
files_modified:
  - .claude/max-objects/packages/FluCoMa/objects.json
  - .claude/max-objects/package_info.json
autonomous: true
requirements: []

must_haves:
  truths:
    - "ObjectDatabase.lookup('fluid.dataset~') returns the dataset object (tilde suffix)"
    - "ObjectDatabase.lookup('fluid.bufhpss~') returns a valid entry (missing buf* variant now present)"
    - "All FluCoMa entries have maxclass='newobj'"
    - "fluid.hpss~ has 3 outlets (harmonic, percussive, residual)"
    - "package_info.json shows FluCoMa with object_count=80 and extracted=true"
    - "No old wrong-name keys remain (e.g., fluid.dataset without tilde)"
  artifacts:
    - path: ".claude/max-objects/packages/FluCoMa/objects.json"
      provides: "Complete FluCoMa object database with ~80 correctly-named entries"
    - path: ".claude/max-objects/package_info.json"
      provides: "Updated FluCoMa metadata with correct object count"
  key_links:
    - from: "src/maxpat/db_lookup.py"
      to: ".claude/max-objects/packages/FluCoMa/objects.json"
      via: "ObjectDatabase._load() iterates packages/ subdirectories"
      pattern: "pkg_dir / \"objects.json\""
---

<objective>
Fix all gaps in the FluCoMa Max package object database identified by research.

The research found 5 systemic issues in `.claude/max-objects/packages/FluCoMa/objects.json`:
1. 34 objects missing `~` suffix (e.g., `fluid.dataset` should be `fluid.dataset~`)
2. 1 misspelling (`fluid.skeans` should be `fluid.skmeans~`)
3. 24 missing buf* variant objects + 6 missing utility/misc objects
4. All 53 entries have wrong `maxclass` (object name instead of `"newobj"`)
5. `fluid.hpss~` has wrong outlet count (2 instead of 3)
6. `package_info.json` shows `object_count: 0, extracted: false`

Purpose: Claude's patch generation for FluCoMa objects currently breaks on lookup failures (wrong names) and produces invalid connections (wrong maxclass, wrong I/O counts). Fixing this makes FluCoMa objects usable in patch generation.

Output: Corrected `objects.json` with ~80 entries, updated `package_info.json`.
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/execute-plan.md
@$HOME/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@.planning/quick/260416-ery-review-the-integration-of-the-flucoma-ma/260416-ery-RESEARCH.md
@.claude/max-objects/packages/FluCoMa/objects.json
@.claude/max-objects/package_info.json
</context>

<tasks>

<task type="auto">
  <name>Task 1: Fix existing entries and add missing objects to FluCoMa objects.json</name>
  <files>.claude/max-objects/packages/FluCoMa/objects.json</files>
  <action>
Write a Python script that loads the current objects.json, applies all fixes, and writes the corrected file. The script must:

**A. Fix maxclass on ALL entries:** Change every entry's `"maxclass"` from the object name to `"newobj"`.

**B. Rename 34 objects (add ~ suffix):** For each object listed in RESEARCH.md Category 1, rename the key AND update the `"name"` field to include the `~` suffix. The 34 objects are: fluid.bufcompose, fluid.buffflatten (also fix triple-f to double-f: fluid.bufflatten~), fluid.bufnmf, fluid.bufnmfcross, fluid.bufnmfseed, fluid.bufscale, fluid.bufselect, fluid.bufselectevery, fluid.bufstats, fluid.bufstft, fluid.bufthreaddemo, fluid.bufthresh, fluid.chroma, fluid.dataset, fluid.datasetquery, fluid.grid, fluid.kdtree, fluid.kmeans, fluid.knnclassifier, fluid.knnregressor, fluid.labelset, fluid.loudness, fluid.mds, fluid.melbands, fluid.mfcc, fluid.mlpclassifier, fluid.mlpregressor, fluid.nmfmatch, fluid.normalize, fluid.pca, fluid.pitch, fluid.robustscale, fluid.spectralshape, fluid.standardize, fluid.umap.

**C. Fix misspelling:** Rename `fluid.skeans` to `fluid.skmeans~` (fix key, name, and maxclass).

**D. Fix fluid.hpss~ outlets:** Update to 3 outlets: (0: harmonic signal, 1: percussive signal, 2: residual signal).

**E. Add 24 missing buf* objects:** Create entries following the same schema as existing buf* objects. Each gets:
- `maxclass: "newobj"`, `module: "msp"`, `domain: "Packages"`, `package: "FluCoMa"`
- `category`: match the real-time counterpart's category (e.g., fluid.bufhpss~ gets "decomposition", fluid.bufpitch~ gets "analysis", fluid.bufampslice~ gets "slicing")
- Standard buf* I/O pattern: 1 control inlet (messages for buffer name, params), 1 control outlet (bang on completion). These are non-realtime buffer processors, NOT signal objects. Set `signal: false` on all inlets/outlets.
- `verified: false`, `variable_io: false`, `rnbo_compatible: false`
- `min_version: 8`
- Appropriate digest/description derived from the real-time counterpart name

The 24 missing buf* objects from RESEARCH.md: fluid.bufampfeature~, fluid.bufampgate~, fluid.bufampslice~, fluid.bufaudiotransport~, fluid.bufchroma~, fluid.bufhpss~, fluid.bufloudness~, fluid.bufmelbands~, fluid.bufmfcc~, fluid.bufnoveltyfeature~, fluid.bufnoveltyslice~, fluid.bufonsetfeature~, fluid.bufonsetslice~, fluid.bufpitch~, fluid.bufsinefeature~, fluid.bufsines~, fluid.bufspectralshape~, fluid.buftransients~, fluid.buftransientslice~.

NOTE: That is 19, not 24. Cross-check RESEARCH.md -- some buf* objects already exist in the DB (just with wrong names, handled in step B). Only add objects that are truly absent after the rename step.

**F. Add 6 missing non-buf objects:**
- `fluid.buf2list` -- control only (no ~), 1 control inlet, 1 control outlet, category "utility", digest "Convert buffer contents to Max list"
- `fluid.list2buf` -- control only (no ~), 1 control inlet, 1 control outlet, category "utility", digest "Convert Max list to buffer contents"
- `fluid.jit.plotter` -- control only (no ~), category "utility", digest "Jitter-based data plotter"
- `fluid.audiofilesin` -- control only (no ~), category "utility", digest "Audio file input helper"
- `fluid.concataudiofiles` -- control only (no ~), category "utility", digest "Concatenate audio files"
- `fluid.gain~` -- signal object, 1 signal inlet + 1 control inlet, 1 signal outlet, category "utility", digest "Gain control"

**G. Sort keys alphabetically** in the final JSON output.

**H. Do NOT add `fluid.waveform~`** -- it is a separate repo, not part of the main FluCoMa package (per RESEARCH.md).

Run the script, then verify the output with a second script that checks: total object count, no entries without ~  suffix (except fluid.plotter, fluid.stats, fluid.buf2list, fluid.list2buf, fluid.jit.plotter, fluid.audiofilesin, fluid.concataudiofiles), all maxclass values are "newobj", fluid.hpss~ has 3 outlets.
  </action>
  <verify>
    <automated>python3 -c "
import json
with open('.claude/max-objects/packages/FluCoMa/objects.json') as f:
    data = json.load(f)
errors = []
# Count check
if len(data) < 75:
    errors.append(f'Too few objects: {len(data)}, expected ~80')
# maxclass check
bad_mc = [n for n,o in data.items() if o.get('maxclass') != 'newobj']
if bad_mc:
    errors.append(f'Wrong maxclass: {bad_mc[:5]}...')
# No old wrong names
no_tilde_ok = {'fluid.plotter','fluid.stats','fluid.buf2list','fluid.list2buf','fluid.jit.plotter','fluid.audiofilesin','fluid.concataudiofiles'}
bad_names = [n for n in data if not n.endswith('~') and n not in no_tilde_ok]
if bad_names:
    errors.append(f'Missing tilde: {bad_names}')
# hpss outlets
hpss = data.get('fluid.hpss~',{})
if len(hpss.get('outlets',[])) != 3:
    errors.append(f'fluid.hpss~ has {len(hpss.get(\"outlets\",[]))} outlets, expected 3')
# key objects exist
for key in ['fluid.dataset~','fluid.bufhpss~','fluid.skmeans~','fluid.gain~','fluid.buf2list']:
    if key not in data:
        errors.append(f'Missing: {key}')
if errors:
    print('FAIL:'); [print(f'  - {e}') for e in errors]; exit(1)
else:
    print(f'PASS: {len(data)} objects, all checks green')
"
    </automated>
  </verify>
  <done>objects.json has ~80 correctly-named FluCoMa entries, all with maxclass="newobj", correct I/O for fluid.hpss~, no stale wrong-name keys, all missing objects added</done>
</task>

<task type="auto">
  <name>Task 2: Update package_info.json with correct FluCoMa metadata</name>
  <files>.claude/max-objects/package_info.json</files>
  <action>
Read `.claude/max-objects/package_info.json`, update the `FluCoMa` entry:
- Set `"object_count"` to the actual count from the updated objects.json (read it and count keys)
- Set `"extracted": true`
- Set `"version": "1.0.9"` (latest release per RESEARCH.md)

Write the file back. Do not modify other package entries.
  </action>
  <verify>
    <automated>python3 -c "
import json
with open('.claude/max-objects/package_info.json') as f:
    data = json.load(f)
fc = data.get('FluCoMa', {})
with open('.claude/max-objects/packages/FluCoMa/objects.json') as f:
    obj_count = len(json.load(f))
errors = []
if fc.get('extracted') != True:
    errors.append('extracted not True')
if fc.get('object_count') != obj_count:
    errors.append(f'object_count={fc.get(\"object_count\")}, expected {obj_count}')
if fc.get('version') != '1.0.9':
    errors.append(f'version={fc.get(\"version\")}, expected 1.0.9')
if errors:
    print('FAIL:'); [print(f'  - {e}') for e in errors]; exit(1)
else:
    print(f'PASS: FluCoMa metadata correct (count={obj_count}, extracted=true, version=1.0.9)')
"
    </automated>
  </verify>
  <done>package_info.json FluCoMa entry shows correct object_count matching objects.json, extracted=true, version=1.0.9</done>
</task>

<task type="auto">
  <name>Task 3: Verify ObjectDatabase integration end-to-end</name>
  <files></files>
  <action>
Run a Python script that imports ObjectDatabase from src.maxpat.db_lookup and performs end-to-end lookups to confirm the fixed data integrates correctly with the lookup system. Test:

1. `db.lookup("fluid.dataset~")` returns non-None (renamed object found)
2. `db.lookup("fluid.dataset")` returns None (old wrong name gone)
3. `db.lookup("fluid.bufhpss~")` returns non-None (new buf* object found)
4. `db.lookup("fluid.skmeans~")` returns non-None (misspelling fixed)
5. `db.lookup("fluid.skeans")` returns None (old misspelling gone)
6. `db.lookup("fluid.hpss~")` returns entry with 3 outlets
7. `db.lookup("fluid.hpss~")["maxclass"]` == "newobj"
8. `db.lookup("fluid.gain~")` returns non-None (new utility object)
9. `db.lookup("fluid.buf2list")` returns non-None (no-tilde utility)
10. `db.exists("fluid.waveform~")` returns False (correctly excluded)

If any assertion fails, print which test failed and exit 1. This confirms the full ObjectDatabase lookup chain (file loading, package directory scanning, key matching) works with the corrected data.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -c "
import sys; sys.path.insert(0, '.')
from src.maxpat.db_lookup import ObjectDatabase
db = ObjectDatabase()
tests = [
    ('fluid.dataset~ exists', db.lookup('fluid.dataset~') is not None),
    ('fluid.dataset gone', db.lookup('fluid.dataset') is None),
    ('fluid.bufhpss~ exists', db.lookup('fluid.bufhpss~') is not None),
    ('fluid.skmeans~ exists', db.lookup('fluid.skmeans~') is not None),
    ('fluid.skeans gone', db.lookup('fluid.skeans') is None),
    ('fluid.hpss~ 3 outlets', len(db.lookup('fluid.hpss~').get('outlets',[])) == 3),
    ('fluid.hpss~ maxclass newobj', db.lookup('fluid.hpss~').get('maxclass') == 'newobj'),
    ('fluid.gain~ exists', db.lookup('fluid.gain~') is not None),
    ('fluid.buf2list exists', db.lookup('fluid.buf2list') is not None),
    ('fluid.waveform~ excluded', not db.exists('fluid.waveform~')),
]
failed = [(n,r) for n,r in tests if not r]
if failed:
    print('FAIL:'); [print(f'  - {n}') for n,_ in failed]; exit(1)
else:
    print(f'PASS: all {len(tests)} integration tests passed')
"
    </automated>
  </verify>
  <done>ObjectDatabase correctly loads, resolves, and returns all fixed/added FluCoMa objects, old wrong names return None</done>
</task>

</tasks>

<threat_model>
## Trust Boundaries

No trust boundaries -- this is a static data file update to a local knowledge base. No user input, no network access, no external services.

## STRIDE Threat Register

| Threat ID | Category | Component | Disposition | Mitigation Plan |
|-----------|----------|-----------|-------------|-----------------|
| T-quick-01 | Tampering | objects.json | accept | Local-only dev tool, no external consumers. Git history tracks all changes. |
</threat_model>

<verification>
- All 3 task verify scripts pass
- `git diff --stat` shows only objects.json and package_info.json changed
- No objects.json entries with wrong maxclass
- No stale wrong-name keys remaining
</verification>

<success_criteria>
- FluCoMa objects.json has ~80 entries with correct names, maxclass="newobj", and verified I/O for known cases
- package_info.json reflects actual state (count, extracted=true, version)
- ObjectDatabase lookups work end-to-end for renamed, added, and excluded objects
</success_criteria>

<output>
After completion, create `.planning/quick/260416-ery-review-the-integration-of-the-flucoma-ma/260416-ery-SUMMARY.md`
</output>
