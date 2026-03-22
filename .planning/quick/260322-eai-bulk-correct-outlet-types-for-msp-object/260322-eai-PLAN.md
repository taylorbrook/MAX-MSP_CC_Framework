---
phase: quick-260322-eai
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - .claude/max-objects/overrides.json
  - tests/test_object_schema.py
autonomous: true
requirements: [MSP-OUTLET-FIX]

must_haves:
  truths:
    - "gain~ outlet 1 is marked signal: false (control) after override"
    - "index~ has exactly 1 outlet after override (extraction error corrected)"
    - "ObjectDatabase.lookup('gain~') returns corrected outlet types"
    - "ObjectDatabase.lookup('index~') returns single outlet"
    - "ObjectDatabase.is_overridden('gain~') returns True"
    - "ObjectDatabase.is_overridden('index~') returns True"
  artifacts:
    - path: ".claude/max-objects/overrides.json"
      provides: "gain~ and index~ outlet corrections"
      contains: "gain~"
    - path: "tests/test_object_schema.py"
      provides: "Verification tests for new overrides"
  key_links:
    - from: ".claude/max-objects/overrides.json"
      to: "src/maxpat/db_lookup.py"
      via: "ObjectDatabase._load() deep-merges objects key"
      pattern: "overrides_data.get.*objects"
---

<objective>
Add outlet type overrides for gain~ and index~ -- the only 2 MSP objects identified by research as needing correction.

Purpose: gain~ outlet 1 is control (slider value int), not signal. index~ has 1 outlet, not 2 (extraction duplicated inlet 1 digest as outlet 1). These corrections ensure validation and connection-checking use accurate outlet types.

Output: Updated overrides.json with 2 new MSP entries, tests confirming correct loading.
</objective>

<execution_context>
@~/.claude/get-shit-done/workflows/execute-plan.md
@~/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@.planning/quick/260322-eai-bulk-correct-outlet-types-for-msp-object/260322-eai-RESEARCH.md
@.claude/max-objects/overrides.json
@src/maxpat/db_lookup.py

<interfaces>
From src/maxpat/db_lookup.py:
```python
class ObjectDatabase:
    def lookup(self, name: str) -> dict | None  # Returns object dict with outlets array
    def is_overridden(self, name: str) -> bool   # True if object has overrides applied
```

Override format in overrides.json (under "objects" key):
```json
{
  "object_name": {
    "outlets": [
      {"id": 0, "type": "signal", "signal": true, "digest": "..."},
      {"id": 1, "type": "", "signal": false, "digest": "..."}
    ],
    "_audit": {
      "confidence": "HIGH",
      "source": "outlet_type_correction",
      "note": "..."
    }
  }
}
```
MSP section starts at `"_domain_msp"` marker. Entries are alphabetical within section.
</interfaces>
</context>

<tasks>

<task type="auto" tdd="true">
  <name>Task 1: Add gain~ and index~ overrides to overrides.json with tests</name>
  <files>.claude/max-objects/overrides.json, tests/test_object_schema.py</files>
  <behavior>
    - Test: ObjectDatabase.lookup("gain~")["outlets"] has 2 entries: outlet 0 signal=true, outlet 1 signal=false
    - Test: ObjectDatabase.lookup("index~")["outlets"] has exactly 1 entry: outlet 0 signal=true
    - Test: ObjectDatabase.is_overridden("gain~") returns True
    - Test: ObjectDatabase.is_overridden("index~") returns True
  </behavior>
  <action>
    **Tests first** -- add a test class `TestMspOutletOverrides` to `tests/test_object_schema.py` with 4 tests:
    1. `test_gain_tilde_outlet_1_is_control` -- lookup gain~, assert outlets[1]["signal"] is False
    2. `test_index_tilde_has_single_outlet` -- lookup index~, assert len(outlets) == 1
    3. `test_gain_tilde_is_overridden` -- assert is_overridden("gain~")
    4. `test_index_tilde_is_overridden` -- assert is_overridden("index~")

    Run tests -- they should FAIL (gain~ and index~ not yet in overrides).

    **Then add overrides** to `.claude/max-objects/overrides.json` in the MSP section, alphabetically:

    **gain~** (insert between fffb~ at ~line 2208 and info~ at ~line 2291):
    ```json
    "gain~": {
      "outlets": [
        {"id": 0, "type": "signal", "signal": true, "digest": "Scaled audio output (signal)"},
        {"id": 1, "type": "", "signal": false, "digest": "Slider value (int)"}
      ],
      "_audit": {
        "confidence": "HIGH",
        "source": "outlet_type_correction",
        "note": "Outlet 1 is control (current slider value as int), not signal. Confirmed via official docs."
      }
    }
    ```

    **index~** (insert between info~ at ~line 2291 and limi~ at ~line 2375):
    ```json
    "index~": {
      "outlets": [
        {"id": 0, "type": "signal", "signal": true, "digest": "Sample value at index"}
      ],
      "_audit": {
        "confidence": "HIGH",
        "source": "outlet_count_correction",
        "note": "Only 1 outlet per official docs. Outlet 1 was extraction error (inlet 1 digest duplicated as outlet 1)."
      }
    }
    ```

    Run tests again -- should PASS.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_object_schema.py::TestMspOutletOverrides -xvs</automated>
  </verify>
  <done>gain~ outlet 1 correctly marked as control (signal: false). index~ has exactly 1 outlet. Both objects return is_overridden=True. All existing tests still pass.</done>
</task>

<task type="auto">
  <name>Task 2: Verify no regressions in validation and existing tests</name>
  <files></files>
  <action>
    Run the full test suite to confirm no regressions from the override changes. Pay special attention to:
    - `tests/test_validation.py` (uses overrides for signal-to-control guard logic)
    - `tests/test_object_schema.py` (existing override/schema tests)
    - `tests/test_critics.py` (DSP critics may reference gain~)

    If any test fails, diagnose and fix. The overrides should only ADD data, not change existing entries.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/ -x --timeout=60 -q</automated>
  </verify>
  <done>Full test suite passes with zero failures. Override additions cause no regressions.</done>
</task>

</tasks>

<verification>
- `python -m pytest tests/test_object_schema.py::TestMspOutletOverrides -xvs` passes
- `python -m pytest tests/ -x -q` passes (full suite, no regressions)
- `python -c "from src.maxpat.db_lookup import ObjectDatabase; db = ObjectDatabase(); g = db.lookup('gain~'); print(g['outlets'][1]['signal'])"` prints `False`
- `python -c "from src.maxpat.db_lookup import ObjectDatabase; db = ObjectDatabase(); i = db.lookup('index~'); print(len(i['outlets']))"` prints `1`
</verification>

<success_criteria>
- gain~ has 2 outlets: outlet 0 signal, outlet 1 control
- index~ has 1 outlet: outlet 0 signal (extraction error fixed)
- Both objects marked as overridden in ObjectDatabase
- Full test suite green
</success_criteria>

<output>
After completion, create `.planning/quick/260322-eai-bulk-correct-outlet-types-for-msp-object/260322-eai-01-SUMMARY.md`
</output>
