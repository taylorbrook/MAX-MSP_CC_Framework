---
phase: quick-260319-mnh
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/validation.py
  - src/maxpat/critics/dsp_critic.py
  - tests/test_validation.py
  - tests/test_critics.py
  - CLAUDE.md
autonomous: true
requirements: [GAIN-SAFETY]

must_haves:
  truths:
    - "A *~ with a literal argument > 1.0 is flagged as a domain warning during validation"
    - "A control-rate source (slider, number, ctlin, notein) feeding *~ gain inlet without normalization is flagged by the DSP critic as a blocker"
    - "The DSP critic upgrades missing-gain-staging findings from warning to blocker so they block output"
    - "CLAUDE.md documents the 0-1 gain range rule in the MSP section"
  artifacts:
    - path: "src/maxpat/validation.py"
      provides: "Layer 4 check for unsafe gain multiplier literals"
      contains: "_check_unsafe_gain_values"
    - path: "src/maxpat/critics/dsp_critic.py"
      provides: "Blocker-level gain safety checks"
      contains: "_check_unsafe_gain_sources"
    - path: "tests/test_validation.py"
      provides: "Tests for unsafe gain literal detection"
      contains: "test_unsafe_gain_literal"
    - path: "tests/test_critics.py"
      provides: "Tests for unsafe gain source detection"
      contains: "test_unsafe_gain_source"
  key_links:
    - from: "src/maxpat/validation.py"
      to: "_check_unsafe_gain_values"
      via: "_validate_domain_rules calls it"
      pattern: "_check_unsafe_gain_values"
    - from: "src/maxpat/critics/dsp_critic.py"
      to: "_check_unsafe_gain_sources"
      via: "review_dsp calls it"
      pattern: "_check_unsafe_gain_sources"
---

<objective>
Add gain safety guards to prevent dangerous audio levels from *~ and gain~ objects receiving values outside the 0.0-1.0 range.

Purpose: Recurring issue where gain/multiply objects receive raw MIDI values (0-127) or other unscaled control data instead of normalized 0.0-1.0 values, causing dangerously loud audio output that can damage equipment and hearing. This needs to be caught at both validation and critic levels.

Output: Updated validation pipeline, DSP critic, tests, and CLAUDE.md documentation.
</objective>

<execution_context>
@/Users/taylorbrook/.claude/get-shit-done/workflows/execute-plan.md
@/Users/taylorbrook/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@src/maxpat/validation.py
@src/maxpat/critics/dsp_critic.py
@tests/test_validation.py
@tests/test_critics.py
@CLAUDE.md

<interfaces>
<!-- Key types and contracts the executor needs. -->

From src/maxpat/validation.py:
```python
class ValidationResult:
    __slots__ = ("layer", "level", "message", "auto_fixed")
    def __init__(self, layer: str, level: str, message: str, auto_fixed: bool = False): ...

def validate_patch(patch, db=None) -> list[ValidationResult]: ...
def has_blocking_errors(results: list[ValidationResult]) -> bool: ...

# Layer 4 domain rules are called from _validate_domain_rules():
#   _check_compound_argument_substitution(box_lookup)
#   _check_unterminated_chains(box_lookup, has_signal_out)
#   _check_gain_staging(box_lookup, signal_adj)
#   _check_feedback_loops(box_lookup, signal_adj)
```

From src/maxpat/critics/base.py:
```python
class CriticResult:
    def __init__(self, severity: str, finding: str, suggestion: str): ...
    # severity: "blocker" | "warning" | "note"
```

From src/maxpat/critics/dsp_critic.py:
```python
def review_dsp(patch_dict: dict, code_context: dict | None = None) -> list[CriticResult]: ...
# Calls: _check_gen_io_match, _check_gain_staging, _check_audio_rate_consistency

_OSCILLATOR_NAMES = frozenset({"cycle~", "saw~", "rect~", "tri~", "noise~", "pink~"})
_GAIN_NAMES = frozenset({"*~", "gain~"})
_TERMINAL_NAMES = frozenset({"dac~", "ezdac~"})
```
</interfaces>
</context>

<tasks>

<task type="auto" tdd="true">
  <name>Task 1: Add gain safety checks to validation pipeline and DSP critic</name>
  <files>src/maxpat/validation.py, src/maxpat/critics/dsp_critic.py, tests/test_validation.py, tests/test_critics.py</files>
  <behavior>
    - Test: *~ with argument > 1.0 (e.g., "*~ 127") produces domain warning "unsafe gain multiplier"
    - Test: *~ with argument 0.5 produces no unsafe gain warning
    - Test: *~ with argument 1.0 produces no unsafe gain warning (1.0 is the boundary, still safe)
    - Test: *~ with no argument produces no unsafe gain warning
    - Test: gain~ with no explicit argument produces no unsafe gain warning
    - Test: DSP critic flags number/slider/ctlin connected to *~ inlet 1 (gain control inlet) without normalization as blocker
    - Test: DSP critic does NOT flag when *~ inlet 1 receives from a signal object (cycle~, noise~, etc.) -- those are signal modulation, not gain
    - Test: DSP critic does NOT flag when *~ inlet 0 receives control data (inlet 0 is signal input, not gain)
    - Test: DSP critic upgrades missing-gain-staging (osc->dac) from warning to blocker
    - Test: scale or clip~ or / 127. between control source and *~ inlet 1 suppresses the blocker
  </behavior>
  <action>
    **In `src/maxpat/validation.py`:**

    1. Add a new function `_check_unsafe_gain_values(box_lookup)` that:
       - Iterates all boxes, finds `*~` objects
       - Parses the first argument from the text field (e.g., "*~ 127" -> 127.0)
       - If the argument is a literal float/int AND > 1.0, emit a domain warning:
         `"Unsafe gain multiplier: '*~ {arg}' ({box_id}) has value > 1.0 -- gain values should be 0.0-1.0 to prevent dangerous audio levels"`
       - Skip if no argument or argument is not a number literal (could be a variable)
    2. Call `_check_unsafe_gain_values(box_lookup)` from `_validate_domain_rules()` after the existing gain staging check.

    **In `src/maxpat/critics/dsp_critic.py`:**

    1. Define `_MIDI_RANGE_SOURCES` as a frozenset of objects known to output MIDI-range (0-127) or UI-range (0-255, 0-127) values: `{"ctlin", "notein", "slider", "kslider", "live.dial", "live.slider", "live.numbox", "number", "flonum"}`. Also include "number~" is NOT one of these (it is signal).

    2. Define `_NORMALIZER_NAMES` as a frozenset of objects that normalize/scale values: `{"scale", "zmap", "clip", "clip~", "/ 127.", "!/ 127."}`. Since we parse from text, check for objects whose name is `scale`, `zmap`, `clip`, `clip~`, or whose text starts with `/ ` or `!/ ` (division objects). Also include `expr` and `vexpr` since they might normalize, and `*` with a small float argument (like `* 0.00787`  which is 1/127). For simplicity, check for: name in {"scale", "zmap", "clip", "clip~"} OR text matches `/ 127` or `* 0.007` pattern. Be pragmatic, not exhaustive.

    3. Add function `_check_unsafe_gain_sources(box_lookup, lines)` that:
       - Builds a control adjacency graph (non-signal connections only)
       - For each `*~` box, checks what feeds inlet 1 (the gain/multiplier inlet)
       - Traces backward from inlet 1 through control-rate connections
       - If it reaches a MIDI-range source without passing through a normalizer, emit a **blocker**:
         `"Unsafe gain source: '{src_name}' ({src_id}) feeds '*~' ({dst_id}) inlet 1 without normalization -- raw MIDI/UI values (0-127) will cause dangerous audio levels. Insert 'scale 0 127 0. 1.' or '/ 127.' before the gain input"`

    4. Change `_check_gain_staging` severity from "warning" to "blocker" -- missing gain staging (oscillator directly to dac~ without *~ or gain~) is a hearing safety issue that should block output.

    5. Call `_check_unsafe_gain_sources(box_lookup, lines)` from `review_dsp()`.

    **In `tests/test_validation.py`:**

    Add a new test class `TestLayer4UnsafeGainValues` with tests for:
    - `test_unsafe_gain_literal_warning`: `*~ 127` produces domain warning with "unsafe gain"
    - `test_safe_gain_literal_no_warning`: `*~ 0.5` produces no unsafe gain warning
    - `test_gain_at_unity_no_warning`: `*~ 1.0` produces no unsafe gain warning
    - `test_gain_no_arg_no_warning`: `*~` alone produces no unsafe gain warning
    - `test_gain_negative_literal_no_warning`: `*~ -0.5` -- negative is not > 1.0, no warning

    **In `tests/test_critics.py`:**

    Add a new test class `TestDSPCriticGainSafety` with tests for:
    - `test_midi_source_to_gain_inlet_blocker`: ctlin -> *~ inlet 1 without normalizer = blocker
    - `test_signal_source_to_gain_inlet_no_warning`: cycle~ -> *~ inlet 1 = no unsafe gain warning (signal modulation is fine)
    - `test_normalized_midi_to_gain_no_warning`: ctlin -> scale 0 127 0. 1. -> *~ inlet 1 = no warning
    - `test_missing_gain_staging_is_now_blocker`: cycle~ -> dac~ = blocker (not warning)
    - `test_number_to_gain_inlet_blocker`: number box -> *~ inlet 1 = blocker
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_validation.py::TestLayer4UnsafeGainValues tests/test_critics.py::TestDSPCriticGainSafety -x -v</automated>
  </verify>
  <done>All new gain safety tests pass. Validation pipeline catches *~ with literal args > 1.0. DSP critic blocks output when MIDI-range control sources feed *~ gain inlet without normalization. Missing gain staging is now a blocker.</done>
</task>

<task type="auto">
  <name>Task 2: Update CLAUDE.md with gain safety rule and update existing tests</name>
  <files>CLAUDE.md, tests/test_critics.py</files>
  <action>
    **In `CLAUDE.md`:**

    1. In the MSP (Audio/Signal) section, after the existing bullet "Use `*~ 0.5` or `*~` with `line~` for gain control -- never connect raw oscillators to `dac~` at full volume", add a new bullet:
       `- Gain safety: values feeding *~ or gain~ for volume control MUST be in the 0.0-1.0 range. Raw MIDI (0-127), slider, or number values must be normalized first (use scale 0 127 0. 1. or / 127.). The validation pipeline and DSP critic will block output that violates this rule.`

    2. Do NOT change any other content.

    **In `tests/test_critics.py`:**

    Update the existing `TestDSPCritic` tests that assert `r.severity == "warning"` for gain staging findings to expect `"blocker"` instead, since Task 1 upgraded them. Specifically:
    - `test_missing_gain_staging_cycle`: change `warnings = [r for r in results if r.severity == "warning"]` to check for `"blocker"` severity
    - `test_missing_gain_staging_noise`: same change
    - `test_proper_gain_staging_no_warning`: this one checks for absence of gain warnings so it still passes (no change needed)
    - In `TestReviewPatchCombined.test_review_patch_catches_gain_issue`: update to check for blocker severity
    - `test_review_patch_combines_both_critics`: the `has_gain` check looks for "gain" in finding text regardless of severity, so it still passes

    Run full test suite to ensure no regressions.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_validation.py tests/test_critics.py -x -v</automated>
  </verify>
  <done>CLAUDE.md documents the 0-1 gain range rule. All existing gain staging tests updated to expect blocker severity. Full validation and critic test suites pass with no regressions.</done>
</task>

</tasks>

<verification>
1. `python -m pytest tests/test_validation.py tests/test_critics.py -x -v` -- all tests pass
2. `python -m pytest tests/ -x` -- full suite passes, no regressions
3. `grep -n "unsafe gain\|Unsafe gain\|GAIN_SAFETY\|0.0-1.0" src/maxpat/validation.py src/maxpat/critics/dsp_critic.py` -- confirms new checks exist
4. `grep -n "Gain safety" CLAUDE.md` -- confirms documentation added
</verification>

<success_criteria>
- *~ 127 detected as unsafe by validation (domain warning)
- ctlin -> *~ inlet 1 (no normalizer) detected as unsafe by DSP critic (blocker)
- cycle~ -> dac~ (no gain) is now a blocker, not just a warning
- CLAUDE.md MSP section documents the 0-1 gain range rule
- All existing tests still pass (no regressions)
</success_criteria>

<output>
After completion, create `.planning/quick/260319-mnh-add-gain-safety-guard-ensure-gain-multip/260319-mnh-SUMMARY.md`
</output>
