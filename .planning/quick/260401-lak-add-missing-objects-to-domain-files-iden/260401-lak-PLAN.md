---
phase: quick-260401-lak
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - .claude/max-objects/jitter/objects.json
  - .claude/max-objects/mc/objects.json
  - .claude/max-objects/max/objects.json
  - .claude/max-objects/m4l/objects.json
autonomous: true
requirements: [AUDIT-2a, AUDIT-2b, AUDIT-2c, AUDIT-2h]

must_haves:
  truths:
    - "ObjectDatabase.lookup() resolves all 21 newly-added objects"
    - "Each new entry has all required fields: name, maxclass, module, domain, inlets, outlets, arguments, messages, min_version, verified, rnbo_compatible, variable_io"
    - "Inlet/outlet counts and signal types match overrides.json source of truth"
  artifacts:
    - path: ".claude/max-objects/jitter/objects.json"
      provides: "11 new Jitter objects"
      contains: "jit.gl.layer"
    - path: ".claude/max-objects/mc/objects.json"
      provides: "7 new MC objects"
      contains: "mc.receive~"
    - path: ".claude/max-objects/max/objects.json"
      provides: "1 new MAX object (array.at)"
      contains: "array.at"
    - path: ".claude/max-objects/m4l/objects.json"
      provides: "2 new M4L objects"
      contains: "M4L.api.ObserveTransport"
  key_links:
    - from: "overrides.json _domain_other section"
      to: "domain JSON files"
      via: "inlet/outlet data copied as source of truth"
      pattern: "inlets.*outlets.*signal"
---

<objective>
Add 21 missing objects to their respective domain JSON files, as identified in audit report sections 2a, 2b, 2c, and 2h.

Purpose: Close coverage gaps so ObjectDatabase.lookup() resolves these real MAX objects instead of returning None.
Output: Updated jitter/objects.json (11 objects), mc/objects.json (7 objects), max/objects.json (1 object), m4l/objects.json (2 objects).
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/execute-plan.md
@$HOME/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@.claude/max-objects/audit/260401-jyk-database-audit-report.md (sections 2a, 2b, 2c, 2h)
@.claude/max-objects/overrides.json (lines 7300-8046 — source of truth for inlet/outlet data)
</context>

<tasks>

<task type="auto">
  <name>Task 1: Add 21 missing objects to domain JSON files</name>
  <files>.claude/max-objects/jitter/objects.json, .claude/max-objects/mc/objects.json, .claude/max-objects/max/objects.json, .claude/max-objects/m4l/objects.json</files>
  <action>
Add new object entries to 4 domain JSON files. For each object, use the override data from `overrides.json` (lines 7300-8046, under `_domain_other`) as the source of truth for inlets/outlets. Fill in all required fields using the same structure as existing entries in each domain file.

**Template for each new entry** (match existing entries' structure exactly):
- `name`: object name (e.g., "jit.gl.layer")
- `maxclass`: "newobj" (all jitter/mc/max/m4l objects use maxclass "newobj")
- `module`: domain module ("jit" for jitter, "msp" for mc, "max" for max, "m4l" for m4l)
- `domain`: domain label ("Jitter", "MC", "Max", "M4L")
- `category`: appropriate category (see below per object)
- `digest`: brief description of the object
- `description`: empty string (no extracted description available)
- `inlets`: copy from overrides.json, adding `"hot": true` for inlet 0 and `"hot": false` for others (match existing entry pattern)
- `outlets`: copy from overrides.json exactly
- `arguments`: empty array `[]`
- `messages`: empty array `[]`
- `attributes`: empty object `{}`
- `seealso`: empty array `[]`
- `tags`: domain-appropriate tags
- `min_version`: 8 for jitter/mc objects, 9 for array.at (MAX 9 array accessor), 8 for M4L objects
- `verified`: false (these are audit-derived, not manually verified)
- `rnbo_compatible`: false
- `variable_io`: false

**Jitter objects (11) — add to jitter/objects.json:**

1. `jit.gl.layer` — GL rendering layer. Category: "Jitter GL". 1 inlet, 2 outlets.
2. `jit.mo.sin` — Motion sine generator. Category: "Jitter Gen". 1 inlet, 2 outlets.
3. `jit.time.sin` — Time-based sine. Category: "Jitter Gen". 1 inlet, 2 outlets.
4. `jit.*` — Jitter matrix multiply. Category: "Jitter Matrix Ops". 2 inlets, 2 outlets.
5. `jit.fx.rota` — FX rotation. Category: "Jitter FX". 1 inlet, 1 outlet.
6. `jit.gl.movie` — GL movie playback. Category: "Jitter GL". 1 inlet, 2 outlets.
7. `jit.gl.pbr` — Physically-based rendering. Category: "Jitter GL". 8 inlets, 2 outlets.
8. `jit.gl.polymovie` — Polymovie GL. Category: "Jitter GL". 1 inlet, 3 outlets.
9. `jit.time` — Time base. Category: "Jitter Gen". 1 inlet, 2 outlets.
10. `jit.time.perlin` — Perlin noise time. Category: "Jitter Gen". 1 inlet, 2 outlets.
11. `jit.time.saw` — Sawtooth time. Category: "Jitter Gen". 1 inlet, 2 outlets.

**MC objects (7) — add to mc/objects.json:**

1. `mc.receive~` — Multichannel wireless receive. Category: "Multichannel, Routing". 1 inlet (non-signal), 1 outlet (signal=true). Module: "msp", domain: "MC".
2. `mc.send~` — Multichannel wireless send. Category: "Multichannel, Routing". 1 inlet (non-signal), 0 outlets.
3. `mc.sum~` — Multichannel sum to mono. Category: "Multichannel, MSP Operators". 1 inlet (non-signal), 1 outlet (signal=true).
4. `mc.capture~` — Multichannel signal capture. Category: "Multichannel". 1 inlet (non-signal), 0 outlets.
5. `mcp.record~` — Multichannel record (parameter). Category: "Multichannel". 3 inlets (non-signal), 1 outlet (signal=true).
6. `mcs.loudness~` — Multichannel loudness analysis (sum). Category: "Multichannel, Analysis". 1 inlet (non-signal), 6 outlets (non-signal).
7. `mcs.sfizz~` — Multichannel SFZ player (sum). Category: "Multichannel". 2 inlets (non-signal), 1 outlet (signal=true).

**MAX object (1) — add to max/objects.json:**

1. `array.at` — Array element accessor. Category: "Array". 2 inlets, 2 outlets (all non-signal). min_version: 9.

**M4L objects (2) — add to m4l/objects.json:**

1. `M4L.api.ObserveTransport` — Observe Live transport state. Category: "Max for Live". 1 inlet, 1 outlet.
2. `M4L.api.ToggleTransport` — Toggle Live transport. Category: "Max for Live". 1 inlet, 0 outlets.

Insert each object in alphabetical order within the JSON file (maintaining existing sort order). The JSON must remain valid and parseable.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -c "
import json
from pathlib import Path

# Verify JSON parseable
for f in ['jitter/objects.json', 'mc/objects.json', 'max/objects.json', 'm4l/objects.json']:
    path = Path('.claude/max-objects') / f
    data = json.loads(path.read_text())
    print(f'{f}: {len(data)} objects, valid JSON')

# Verify all 21 new objects exist via ObjectDatabase.lookup()
from src.maxpat.db_lookup import ObjectDatabase
db = ObjectDatabase()
expected = [
    'jit.gl.layer', 'jit.mo.sin', 'jit.time.sin', 'jit.*', 'jit.fx.rota',
    'jit.gl.movie', 'jit.gl.pbr', 'jit.gl.polymovie', 'jit.time', 'jit.time.perlin', 'jit.time.saw',
    'mc.receive~', 'mc.send~', 'mc.sum~', 'mc.capture~', 'mcp.record~', 'mcs.loudness~', 'mcs.sfizz~',
    'array.at', 'M4L.api.ObserveTransport', 'M4L.api.ToggleTransport'
]
missing = [n for n in expected if not db.lookup(n)]
if missing:
    print(f'FAIL: Missing objects: {missing}')
    exit(1)

# Verify required fields
required_fields = ['name', 'maxclass', 'module', 'domain', 'inlets', 'outlets', 'arguments', 'messages', 'min_version', 'verified', 'rnbo_compatible', 'variable_io']
for name in expected:
    obj = db.lookup(name)
    missing_fields = [f for f in required_fields if f not in obj]
    if missing_fields:
        print(f'FAIL: {name} missing fields: {missing_fields}')
        exit(1)

# Verify I/O counts match overrides
checks = {
    'jit.gl.layer': (1, 2), 'jit.gl.pbr': (8, 2), 'jit.gl.polymovie': (1, 3),
    'mc.receive~': (1, 1), 'mc.send~': (1, 0), 'mcs.loudness~': (1, 6),
    'mcp.record~': (3, 1), 'mcs.sfizz~': (2, 1), 'array.at': (2, 2),
    'M4L.api.ToggleTransport': (1, 0)
}
for name, (exp_in, exp_out) in checks.items():
    obj = db.lookup(name)
    actual_in, actual_out = len(obj['inlets']), len(obj['outlets'])
    if actual_in != exp_in or actual_out != exp_out:
        print(f'FAIL: {name} I/O mismatch: expected ({exp_in},{exp_out}), got ({actual_in},{actual_out})')
        exit(1)

print(f'OK: All {len(expected)} objects found with correct fields and I/O counts')
"</automated>
  </verify>
  <done>All 21 objects added to their respective domain JSON files, each with all required fields, inlet/outlet counts matching overrides.json, and resolving via ObjectDatabase.lookup()</done>
</task>

</tasks>

<verification>
- All 4 domain JSON files are valid JSON
- ObjectDatabase.lookup() returns non-None for all 21 new objects
- Each new entry has all 12 required fields
- Inlet/outlet counts and signal types match overrides.json
- Existing objects in each file are unmodified
</verification>

<success_criteria>
- 21 objects added across 4 domain files
- All resolve via ObjectDatabase.lookup()
- Zero existing entries disturbed
- All JSON files parse cleanly
</success_criteria>

<output>
After completion, create `.planning/quick/260401-lak-add-missing-objects-to-domain-files-iden/260401-lak-SUMMARY.md`
</output>
