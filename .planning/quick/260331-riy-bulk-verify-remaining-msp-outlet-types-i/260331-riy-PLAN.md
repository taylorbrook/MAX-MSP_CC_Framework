---
phase: quick-260331-riy
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - .claude/max-objects/overrides.json
autonomous: true
requirements: [QUICK-260331-riy]

must_haves:
  truths:
    - "All 204 unoverridden MSP objects have entries in overrides.json"
    - "DB-error objects (poke~, levelmeter~, spectroscope~, gridmeter~, plot~, retune~, playlist~) have corrected outlet arrays"
    - "Validation pipeline no longer emits 'unverified outlet types' warnings for any MSP tilde object"
  artifacts:
    - path: ".claude/max-objects/overrides.json"
      provides: "Verified outlet type overrides for all MSP objects"
      contains: "noise~"
  key_links:
    - from: ".claude/max-objects/overrides.json"
      to: "src/maxpat/db_lookup.py"
      via: "ObjectDatabase._overridden_objects set populated from override keys"
      pattern: "_overridden_objects"
---

<objective>
Add verified override entries for all 204 remaining MSP objects in overrides.json to eliminate "unverified outlet types" validation warnings.

Purpose: The MSP domain extraction marked ALL outlets as signal=true. For ~185 objects this is correct but unverified. For ~8 objects the DB data is wrong. Adding overrides marks all as verified (via `is_overridden()`) and corrects the errors.

Output: Updated overrides.json with all MSP objects verified.
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/execute-plan.md
@$HOME/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@.planning/quick/260331-riy-bulk-verify-remaining-msp-outlet-types-i/260331-riy-RESEARCH.md
@.claude/max-objects/overrides.json
@src/maxpat/db_lookup.py
</context>

<tasks>

<task type="auto">
  <name>Task 1: Add verified override entries for all 204 MSP objects</name>
  <files>.claude/max-objects/overrides.json</files>
  <action>
Write and run a Python script that reads overrides.json, adds entries for all 204 unoverridden MSP objects in the `_domain_msp` section (between the `_domain_msp` marker and `_domain_jitter` marker), then writes back.

The script must handle three categories of objects:

**Category A: Verified-correct objects (~185) -- DB outlets match reality, just need verification flag.**

For these objects, add a minimal entry that causes `is_overridden()` to return true without changing any DB data. Format:

```json
"noise~": {
  "_outlet_types_verified": true,
  "_audit": {
    "confidence": "HIGH",
    "source": "bulk_outlet_type_verification"
  }
}
```

This works because `db_lookup.py` line 77-85 adds the key to `_overridden_objects` even when all override keys start with `_` (those are skipped during merge but the object name is still registered).

Objects in this category (from RESEARCH.md):

Single-outlet signal: `!-~`, `!/~`, `!=~`, `%~`, `*~`, `+=~`, `+~`, `-~`, `/~`, `<=~`, `<~`, `==~`, `>=~`, `>~`, `abs~`, `acosh~`, `acos~`, `allpass~`, `asinh~`, `asin~`, `atan2~`, `atanh~`, `atan~`, `atodb~`, `average~`, `begin~`, `biquad~`, `bitand~`, `bitnot~`, `bitor~`, `bitsafe~`, `bitshift~`, `bitxor~`, `buffir~`, `cascade~`, `change~`, `click~`, `clip~`, `comb~`, `cosh~`, `cosx~`, `cos~`, `count~`, `cverb~`, `dbtoa~`, `degrade~`, `delay~`, `deltaclip~`, `delta~`, `downsamp~`, `frameaccum~`, `frameaverage~`, `framedelta~`, `framesmooth~`, `frame~`, `ftom~`, `gate~`, `gen.codebox~`, `gen~`, `in~`, `ioscbank~`, `kink~`, `log~`, `lookup~`, `lores~`, `maximum~`, `minimum~`, `mtof~`, `noise~`, `normalize~`, `onepole~`, `oscbank~`, `overdrive~`, `pass~`, `phasegroove~`, `phaseshift~`, `phasewrap~`, `phasor~`, `pink~`, `pong~`, `pow~`, `rampsmooth~`, `rand~`, `rate~`, `receive~`, `record~`, `rect~`, `reson~`, `round~`, `sah~`, `sash~`, `saw~`, `scale~`, `selector~`, `shape~`, `sig~`, `sinh~`, `sinx~`, `slide~`, `snowfall~`, `sqrt~`, `stutter~`, `table~`, `tanh~`, `tanx~`, `tapout~`, `teeth~`, `thresh~`, `trapezoid~`, `triangle~`, `tri~`, `trunc~`, `twist~`, `updown~`, `vectral~`, `wave~`

Multi-outlet all-signal: `adoutput~`, `cartopol~`, `chucker~`, `cross~`, `ezadc~`, `fbinshift~`, `fftin~`, `fft~`, `filtercoeff~`, `freqshift~`, `gizmo~`, `groove~`, `hilbert~`, `ifft~`, `plugin~`, `plugout~`, `poltocar~`, `stepcounter~`, `stepdiv~`, `stepfun~`, `svf~`, `techno~`, `where~`, `zerox~`

MCS objects: `mcs.2d.wave~`, `mcs.fffb~`, `mcs.gate~`, `mcs.gen~`, `mcs.limi~`, `mcs.selector~`, `mcs.sig~`, `mcs.wave~`

Mixed outlet (DB correct): `adsr~`, `matrix~`, `mcs.matrix~`, `minmax~`, `mstosamps~`, `number~`, `omx.4band~`, `omx.5band~`, `omx.comp~`, `omx.peaklim~`, `plugphasor~`, `sampstoms~`, `subdiv~`, `swing~`, `typeroute~`, `what~`

Pure control outlet (DB correct): `avg~`, `edge~`, `fftinfo~`, `filtergraph~`, `framesnap~`, `fzero~`, `loudness~`, `peakamp~`, `plugsync~`, `seq~`, `snapshot~`, `spike~`, `waveform~`, `zplane~`

No-outlet objects (DB correct): `capture~`, `ezdac~`, `fftout~`, `mxj~`, `out~`, `plugsend~`, `scope~`, `send~`

Non-tilde control objects (DB correct): `ddg.mono`, `filterdesign`, `filterdetail`, `gen`, `gen.codebox`, `multirange`, `out`

MCS mixed (DB likely correct): `mcs.groove~`

**Category B: DB-error objects (~7) -- need corrected outlet arrays.**

Use full outlet array overrides matching existing format (see gain~, info~ entries as templates):

1. `poke~`: Set `"outlets": []` (0 outlets -- writes to buffer only)
2. `levelmeter~`: Set outlets to 1 control outlet: `[{"id": 0, "type": "", "signal": false, "digest": "RMS level in dB (float)"}]`
3. `spectroscope~`: Set `"outlets": []` (display only, 0 outlets)
4. `gridmeter~`: Set `"outlets": []` (display only, 0 outlets)
5. `plot~`: Set outlets to 1 control outlet: `[{"id": 0, "type": "", "signal": false, "digest": "Mouse interaction data"}]`
6. `retune~`: Set outlets to 3: `[{"id": 0, "type": "signal", "signal": true, "digest": "Pitch-corrected audio"}, {"id": 1, "type": "signal", "signal": true, "digest": "Detected pitch"}, {"id": 2, "type": "", "signal": false, "digest": "Voice allocation data"}]`
7. `playlist~`: Set outlets to default 3: `[{"id": 0, "type": "signal", "signal": true, "digest": "Audio output (variable with channelcount)"}, {"id": 1, "type": "signal", "signal": true, "digest": "Position signal"}, {"id": 2, "type": "", "signal": false, "digest": "Playback state messages"}]` with `_note` about variable I/O

For DB-error objects, set `_audit.source` to `"outlet_type_correction"` and `_audit.confidence` to `"HIGH"`.

**Category C: Skip 2 non-objects.**

Do NOT add entries for `MC Wrapper Features` or `Snapshot Messages` -- these are documentation entries, not real objects.

**Implementation approach:**

Write a Python3 script that:
1. Reads overrides.json
2. Identifies the MSP section (between `_domain_msp` and `_domain_jitter`)
3. For each of the 204 objects listed above (minus 2 non-objects = 202 entries), creates the appropriate override entry
4. Inserts new entries in alphabetical order within the MSP section, interleaved with existing entries
5. Writes back with `json.dump(data, f, indent=2)` + trailing newline

The script should use `collections.OrderedDict` or careful dict insertion to maintain key ordering within the objects dict. New MSP entries must appear between existing MSP entries alphabetically.

Run the script, then delete it (no generator scripts per Rule #5).
  </action>
  <verify>
    <automated>python3 -c "
import json
from src.maxpat.db_lookup import ObjectDatabase

# Verify all MSP objects are now overridden
db = ObjectDatabase()
msp = json.loads(open('.claude/max-objects/msp/objects.json').read())
non_objects = {'MC Wrapper Features', 'Snapshot Messages'}
missing = []
for name in msp:
    if name in non_objects:
        continue
    if not db.is_overridden(name):
        missing.append(name)
if missing:
    print(f'FAIL: {len(missing)} MSP objects still not overridden: {missing[:10]}...')
    exit(1)

# Verify DB-error corrections
poke = db.lookup('poke~')
assert len(poke.get('outlets', [{'x':1}])) == 0, f'poke~ should have 0 outlets, got {len(poke.get(\"outlets\", []))}'
lm = db.lookup('levelmeter~')
assert lm['outlets'][0]['signal'] == False, 'levelmeter~ outlet should be control'
spec = db.lookup('spectroscope~')
assert len(spec.get('outlets', [{'x':1}])) == 0, 'spectroscope~ should have 0 outlets'

print(f'PASS: All {len(msp) - len(non_objects)} MSP objects verified as overridden')
print('PASS: DB-error corrections verified (poke~, levelmeter~, spectroscope~)')
" && python3 -m pytest tests/ -x -q 2>&1 | tail -3
    </automated>
  </verify>
  <done>All 202 real MSP objects have override entries in overrides.json. DB-error objects have corrected outlet arrays. Test suite passes. No "unverified outlet types" warnings for MSP tilde objects.</done>
</task>

</tasks>

<verification>
- `ObjectDatabase.is_overridden(name)` returns True for every MSP domain object (except 2 non-objects)
- DB-error objects (poke~, levelmeter~, spectroscope~, gridmeter~, plot~, retune~, playlist~) have corrected outlet data
- Full test suite passes with no regressions
- overrides.json is valid JSON with maintained section ordering
</verification>

<success_criteria>
- 0 MSP tilde objects missing from overrides.json (was 204)
- 7 DB-error objects have corrected outlet arrays
- `python3 -m pytest tests/ -x -q` passes
- No "unverified outlet types" warnings for any MSP object in validation output
</success_criteria>

<output>
After completion, create `.planning/quick/260331-riy-bulk-verify-remaining-msp-outlet-types-i/260331-riy-SUMMARY.md`
</output>
