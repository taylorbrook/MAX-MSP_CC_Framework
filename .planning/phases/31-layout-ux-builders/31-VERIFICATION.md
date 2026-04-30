---
phase: 31-layout-ux-builders
verified: 2026-04-30T00:00:00Z
status: gaps_found
score: 3/5 must-haves verified
overrides_applied: 0
gaps:
  - truth: "p.add_overlay_readout(target, format=...) returns a properly z-ordered flonum/comment readout with bring_to_front + ignoreclick=1 baked in"
    status: partial
    reason: "Builder exists, z-order and ignoreclick are correctly baked, but the headline `format=` kwarg writes a non-existent attribute on flonum (CR-01). MAX silently drops `extra_attrs['format']` because flonum's only formatting attribute is `numdecimalplaces` (int). Callers passing `'%.2f'` or `'%.1f Hz'` get nothing rendered. The success criterion's literal phrasing — `format=...` — is therefore not honored at the MAX runtime level even though the test asserts the value is stored."
    artifacts:
      - path: "src/maxpat/patcher.py:739"
        issue: "Line `readout.extra_attrs['format'] = format` — `format` is not a real flonum attribute. Confirmed by inspecting `.claude/max-objects/max/objects.json` flonum entry (attributes: bgcolor, bordercolor, cantchange, hbgcolor, htextcolor, htricolor, maximum, minimum, mouseup, numdecimalplaces, outputonclick, parameter_enable, textcolor, triangle, tricolor, triscale — no `format`)."
      - path: "tests/test_overlay_readout.py:test_format_string_baked"
        issue: "Test asserts `extra_attrs['format'] == '%.1f Hz'` which is the bug-confirming test (verifies the value is stored, not that MAX honors it)."
    missing:
      - "Translate `format='%.Nf'` to `numdecimalplaces=N` for `type='flonum'`"
      - "Decide unit-suffix policy for `'%.1f Hz'` style (raise, or route to type='comment' + prepend chain)"
      - "Update `test_format_string_baked` to assert the corrected attribute, plus add a regression test asserting flonum has no `format` key in extra_attrs after the call"
  - truth: "Auto-placement of companions via signal_role (status->readout overlay, audio->meter)"
    status: partial
    reason: "The `audio -> meter~ right-of-source` half is wired and tested (cycle~ -> meter~ integration test passes, role pass A claims the meter~ correctly). The `status -> flonum overlay` half is declared in `_ROLE_COMPANION_MAP` (D-14 verbatim) but `_place_companions` only ever places to the right; the `placement: 'overlay'` field is silently ignored. Plan 31-03 SUMMARY explicitly notes this was deferred. WR-02 also flags that Pass A has no single-parent guard, so a meter~ summing two audio sources is claimed by whichever line iterates last."
    artifacts:
      - path: "src/maxpat/layout.py:666-694"
        issue: "_place_companions reads only the right-placement code path; never branches on the role map's `placement` field. status->flonum will be positioned beside the source rather than overlaid (the opposite of what _ROLE_COMPANION_MAP and SKILL.md advertise)."
      - path: "src/maxpat/layout.py:631-648"
        issue: "Pass A claims `result[dst.id] = src` unconditionally for any matching role-companion edge. Pass B (legacy) requires single-parent (`len(parents) != 1` skip); Pass A is missing this guard, weakening the invariant."
    missing:
      - "Implement `placement='overlay'` branch in _place_companions (copy parent.patching_rect, set ignoreclick=1, bring_to_front) OR drop the `placement` field from _ROLE_COMPANION_MAP so the contract matches the code"
      - "Add single-parent guard in Pass A: `if len(incoming.get(dst.id, [])) != 1: continue` before claiming"
      - "Integration test for status outlet (currently no MSP outlet has signal_role=='status' curated, so the path is also untested at integration level)"
deferred: []
---

# Phase 31: Layout & UX Builders Verification Report

**Phase Goal:** Layout/UX recipes that currently live as prose in CLAUDE.md become callable builder functions that agents invoke directly, with companion-pair smarts powered by the new `signal_role` data.

**Verified:** 2026-04-30
**Status:** gaps_found
**Re-verification:** No -- initial verification

## Goal Achievement

### Observable Truths

| #   | Truth                                                                                                                                  | Status     | Evidence                                                                                                                                                                                                                                                                                                                            |
| --- | -------------------------------------------------------------------------------------------------------------------------------------- | ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | `p.add_overlay_readout(target, format=...)` returns a z-ordered flonum/comment readout with `bring_to_front` + `ignoreclick=1` baked in | PARTIAL    | Method exists at `patcher.py:688`. `bring_to_front(readout)` invoked unconditionally; `ignoreclick=1` baked when `editable=False`. 12 tests pass. **BUT** `extra_attrs['format'] = format` writes a non-existent attribute on flonum -- MAX silently drops it. Headline `format=` kwarg is non-functional in actual MAX (CR-01). |
| 2   | `p.add_labeled_param_bank(params, ...)` returns multislider sized `size×24` with `contdata=1`/`setstyle=1` plus pixel-aligned labels   | VERIFIED   | Method exists at `patcher.py:746`. 16 tests verify size, height=size\*24, orientation=0, contdata=1, setstyle=1, setminmax envelope, label y-formula. Cycle~ multislider DB I/O confirmed non-empty. WR-05/IN-02 flag a label-width estimate that overlaps the multislider for names ≥9 chars (cosmetic, not goal-blocking).        |
| 3   | Auto-placement of companions via `signal_role` (status→readout overlay, audio→meter)                                                   | PARTIAL    | `_ROLE_COMPANION_MAP` exists at `layout.py:59` with all six D-14 keys. Audio→meter~ right placement WIRED + integration test passes. **BUT** status→flonum overlay placement is declared in the map but `_place_companions` never branches on `placement: 'overlay'` -- the second half of the must-have is unimplemented (WR-01).  |
| 4   | `m4l_gen_synth(params=[...])` returns Live-ready `.amxd` skeleton with gen~ + `live.dial`s bound via `param_connect`, no `gain~`        | VERIFIED   | Method exists at `patcher.py:2059`. 20 tests verify gen.varname, dial param_connect prefix/suffix, full `saved_attribute_attributes.valueof` block, no `gain~`/`live.gain~`/`ezdac~` between gen~ and plugout~, polish-pipeline compatibility, top-level `param_connect` after to_dict.                                              |
| 5   | `max-patch-agent` and `max-ui-agent` reach all four builders via documented entry points                                               | VERIFIED   | Both SKILL.md files contain identical "## Builder API (Phase 31)" section listing all four builders with signatures + when-to-call guidance + role-companion table. CLAUDE.md annotated with three blockquote pointers. 12 new agent-skills tests pass; full agent-skills suite 165/165 green.                                       |

**Score:** 3/5 truths fully verified, 2 partial.

### Required Artifacts

| Artifact                                              | Expected                                          | Exists | Substantive | Wired | Status     |
| ----------------------------------------------------- | ------------------------------------------------- | ------ | ----------- | ----- | ---------- |
| `src/maxpat/patcher.py::add_overlay_readout`          | LAYOUT-01 builder method                          | ✓      | ✓           | ✓     | ✓ VERIFIED |
| `src/maxpat/patcher.py::add_labeled_param_bank`       | LAYOUT-02 builder method                          | ✓      | ✓           | ✓     | ✓ VERIFIED |
| `src/maxpat/layout.py::_ROLE_COMPANION_MAP`           | LAYOUT-03 role map (six D-14 keys)                | ✓      | ✓           | ✓     | ✓ VERIFIED |
| `src/maxpat/layout.py::_identify_companions(...,db=)` | LAYOUT-03 role-first dispatch + legacy fall-through | ✓      | ✓           | ✓     | ✓ VERIFIED |
| `src/maxpat/patcher.py::add_m4l_gen_synth`            | LAYOUT-04 builder method                          | ✓      | ✓           | ✓     | ✓ VERIFIED |
| `.claude/skills/max-patch-agent/SKILL.md` Builder API | LAYOUT-05 doc surface                             | ✓      | ✓           | -     | ✓ VERIFIED |
| `.claude/skills/max-ui-agent/SKILL.md` Builder API    | LAYOUT-05 doc surface (verbatim copy)             | ✓      | ✓           | -     | ✓ VERIFIED |
| `tests/test_overlay_readout.py::TestOverlayReadout`   | 10 tests for D-03..D-06                           | ✓      | ✓           | -     | ✓ VERIFIED (12 collected, all pass) |
| `tests/test_labeled_param_bank.py::TestLabeledParamBank` | 16 tests for D-07..D-10                        | ✓      | ✓           | -     | ✓ VERIFIED (16/16 pass) |
| `tests/test_m4l_gen_synth.py::TestM4LGenSynth`        | 20 tests for D-15                                 | ✓      | ✓           | -     | ✓ VERIFIED (20/20 pass) |
| `tests/test_companion_role_layout.py`                 | 10+ tests for LAYOUT-03                           | ✓      | ✓           | -     | ✓ VERIFIED (12/12 pass) |
| `tests/test_agent_skills.py` extensions               | 5+ tests for LAYOUT-05                            | ✓      | ✓           | -     | ✓ VERIFIED (165/165 pass) |

### Key Link Verification

| From                                            | To                                       | Via                                                  | Status   | Details                                                                                                                |
| ----------------------------------------------- | ---------------------------------------- | ---------------------------------------------------- | -------- | ---------------------------------------------------------------------------------------------------------------------- |
| `Patcher.add_overlay_readout`                   | `Patcher.bring_to_front`                 | `self.bring_to_front(readout)`                       | ✓ WIRED  | `patcher.py:743`                                                                                                       |
| `Patcher.add_overlay_readout`                   | `Patcher.add_box`                        | `self.add_box(type, x=x, y=y, skip_overlap_check=True)` | ✓ WIRED  | `patcher.py:736`                                                                                                       |
| `Patcher.add_overlay_readout` `format=` kwarg   | flonum's `numdecimalplaces` attribute    | (should be) `extra_attrs["numdecimalplaces"]=N`      | ✗ NOT_WIRED | Writes `extra_attrs["format"]` instead. flonum has no `format` attribute -- MAX silently drops it. CR-01.            |
| `Patcher.add_labeled_param_bank`                | `Patcher.add_box('multislider', ...)`    | `self.add_box('multislider', skip_overlap_check=True)` | ✓ WIRED | `patcher.py` (verified by 16 tests)                                                                                    |
| `Patcher.add_labeled_param_bank`                | `Patcher.add_comment`                    | `self.add_comment(name, x=lx, y=ly)` per param       | ✓ WIRED  | `patcher.py` (verified by 16 tests)                                                                                    |
| `_identify_companions`                          | `ObjectDatabase.get_signal_role`         | `db.get_signal_role(src.name, line.source_outlet)`   | ✓ WIRED  | `layout.py:639` (wrapped in try/except -- IN-04 flags this as too broad but functional)                                |
| `_identify_companions`                          | `_ROLE_COMPANION_MAP`                    | `_ROLE_COMPANION_MAP.get(role)`                      | ✓ WIRED  | `layout.py:644`                                                                                                        |
| `apply_layout`                                  | `_identify_companions`                   | passes `db=patcher.db`                               | ✓ WIRED  | Confirmed by 31-03-SUMMARY: `companions = _identify_companions(component_boxes, patcher.lines, rows, db=patcher.db)` |
| `_ROLE_COMPANION_MAP['status']['placement']`    | `_place_companions` overlay branch       | (advertised) `placement='overlay'` dispatch          | ✗ NOT_WIRED | `_place_companions` (`layout.py:666-694`) only does right-placement; `placement` field is read nowhere. WR-01.       |
| `Patcher.add_m4l_gen_synth`                     | `Patcher.add_gen`                        | `self.add_gen(code, num_inputs=0, num_outputs=1)`    | ✓ WIRED  | `patcher.py` (verified by 20 tests)                                                                                    |
| `Patcher.add_m4l_gen_synth`                     | `Patcher.add_box('live.dial', ...)`      | `self.add_box('live.dial', ...)`                     | ✓ WIRED  | `patcher.py` (verified by 20 tests)                                                                                    |
| `live.dial.param_connect`                       | gen~ `varname`                           | `f'{gen_varname}::{name}'`                           | ✓ WIRED  | T-31-04 mitigation -- explicit `startswith` test ensures prefix matches                                                |
| max-patch-agent SKILL.md Builder API            | `Patcher` methods                        | method names referenced in markdown                  | ✓ WIRED  | Lines 80-176, all four builders + role map referenced                                                                  |
| max-ui-agent SKILL.md Builder API               | max-patch-agent SKILL.md (verbatim)      | byte-identical copy                                  | ✓ WIRED  | `test_builder_api_sections_byte_identical` enforces byte-identity                                                      |

### Data-Flow Trace (Level 4)

| Artifact                          | Data Variable                            | Source                                                     | Produces Real Data                              | Status   |
| --------------------------------- | ---------------------------------------- | ---------------------------------------------------------- | ----------------------------------------------- | -------- |
| `add_overlay_readout` `format=`   | `readout.extra_attrs['format']`          | Caller's `format` kwarg, stored verbatim                   | NO -- attribute does not exist on flonum/comment; MAX silently drops it on load | ✗ DISCONNECTED (CR-01) |
| `add_overlay_readout` z-order     | `readout` position in `p.boxes`          | `self.bring_to_front(readout)`                             | YES -- moves to index 0 (renders on top)         | ✓ FLOWING |
| `add_overlay_readout` ignoreclick | `readout.extra_attrs['ignoreclick']`     | Conditional: if not editable, set to 1                     | YES -- valid flonum attribute, MAX honors it     | ✓ FLOWING |
| `add_labeled_param_bank` size     | `ms.extra_attrs['size']`                 | `len(params)`                                              | YES -- multislider attribute, MAX honors it      | ✓ FLOWING |
| `add_labeled_param_bank` height   | `ms.patching_rect[3]`                    | `len(params) * 24.0`                                       | YES -- patching_rect renders in MAX              | ✓ FLOWING |
| `add_labeled_param_bank` setminmax | `ms.extra_attrs['setminmax']`           | `[min(mins), max(maxes)]`                                  | YES -- valid multislider attribute               | ✓ FLOWING |
| `_identify_companions` (audio)    | `result[dst.id] = src` for audio outlets | `db.get_signal_role` + `_ROLE_COMPANION_MAP['audio']`      | YES -- meter~ placed right of source by `_place_companions` | ✓ FLOWING |
| `_identify_companions` (status)   | `result[dst.id] = src` for status outlets | `db.get_signal_role` + `_ROLE_COMPANION_MAP['status']`     | NO -- `_place_companions` ignores `placement='overlay'`; flonum gets right-placement | ✗ HOLLOW_PROP (WR-01) |
| `add_m4l_gen_synth` param_connect | `dial.extra_attrs['param_connect']`      | `f'{gen_varname}::{name}'`                                 | YES -- valid live.dial attribute, Live honors it (verified per bassoon-model.maxpat) | ✓ FLOWING |
| `add_m4l_gen_synth` valueof block | `dial.extra_attrs['saved_attribute_attributes']['valueof']` | Hardcoded ParamType/UnitStyle/ModMode constants | YES -- matches verified bassoon-model shape    | ✓ FLOWING |

### Behavioral Spot-Checks

| Behavior                                            | Command                                                            | Result                  | Status |
| --------------------------------------------------- | ------------------------------------------------------------------ | ----------------------- | ------ |
| Phase 31 builder tests pass                         | `python3 -m pytest tests/test_overlay_readout.py tests/test_labeled_param_bank.py tests/test_m4l_gen_synth.py tests/test_companion_role_layout.py` | 60 passed in 1.32s   | ✓ PASS |
| Agent-skills tests pass                             | `python3 -m pytest tests/test_agent_skills.py`                     | 165 passed in 0.05s     | ✓ PASS |
| Builder methods importable                          | `grep -n "def add_overlay_readout\|def add_labeled_param_bank\|def add_m4l_gen_synth" src/maxpat/patcher.py` | 3 matches at lines 688, 746, 2059 | ✓ PASS |
| `_ROLE_COMPANION_MAP` defined                       | `grep -n "_ROLE_COMPANION_MAP" src/maxpat/layout.py`               | Definition at line 59 + 3 references | ✓ PASS |
| SKILL.md files contain Builder API section          | `grep -n "## Builder API" .claude/skills/max-*/SKILL.md`           | 1 occurrence each       | ✓ PASS |
| CLAUDE.md has codified pointers                     | `grep -n "Codified.*add_overlay_readout\|Codified.*add_labeled_param_bank\|Codified.*add_m4l_gen_synth" CLAUDE.md` | 3 matches at lines 94, 116, 227 | ✓ PASS |
| flonum has no `format` attribute (CR-01 verification) | `python3 -c "from src.maxpat.db_lookup import ObjectDatabase; db=ObjectDatabase(); print('format' in (db.lookup('flonum').get('attributes') or {}))"` | `False` -- `format` not in flonum attributes | ✓ PASS (CR-01 confirmed) |

### Requirements Coverage

| Requirement | Source Plan | Description                                                                                              | Status                | Evidence                                                                                                                                                |
| ----------- | ----------- | -------------------------------------------------------------------------------------------------------- | --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| LAYOUT-01   | 31-01       | `add_overlay_readout(target, format=...)` builder                                                        | PARTIAL (CR-01)       | Builder exists, z-order/ignoreclick wired, but `format=` kwarg silently dropped by MAX (writes non-existent attribute on flonum)                        |
| LAYOUT-02   | 31-02       | `add_labeled_param_bank(params, ...)` codifies multislider formula                                       | SATISFIED             | All baked attrs (size, height, orientation, contdata, setstyle, setminmax) verified by 16 tests; label alignment formula matches CLAUDE.md spec        |
| LAYOUT-03   | 31-03       | Companion-pair auto-placement using signal_role                                                          | PARTIAL (WR-01)       | audio→meter~ right placement WIRED + tested; status→flonum overlay declared but unimplemented (`_place_companions` ignores `placement='overlay'`)       |
| LAYOUT-04   | 31-04       | `m4l_gen_synth(params=[...])` Live-ready skeleton with `param_connect`, no `gain~`                       | SATISFIED             | gen~ varname + 20 tests verifying full param_connect/valueof shape, no gain~/live.gain~/ezdac~ in path, polish-pipeline compatible                      |
| LAYOUT-05   | 31-05       | All four builders reachable from max-patch-agent and max-ui-agent via documented entry points           | SATISFIED             | Builder API section in both SKILL.md files (byte-identical), CLAUDE.md pointers, 12 new tests pass                                                      |

No orphaned requirements (REQUIREMENTS.md lists exactly LAYOUT-01..05 for Phase 31; all five claimed by their respective plans).

### Anti-Patterns Found

| File                                | Line(s)    | Pattern                                                            | Severity   | Impact                                                                                                                          |
| ----------------------------------- | ---------- | ------------------------------------------------------------------ | ---------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `src/maxpat/patcher.py`             | 739        | `extra_attrs["format"] = format` -- attribute does not exist on flonum | 🛑 Blocker | Headline `format=` kwarg is non-functional -- MAX drops it silently. Goal-impacting for must-have #1 (CR-01).                  |
| `src/maxpat/layout.py`              | 61, 666-694 | `_ROLE_COMPANION_MAP['status']['placement']='overlay'` declared but `_place_companions` only places right | ⚠️ Warning | status→flonum overlay path is dead code; mismatch between data structure and behavior. Goal-impacting for must-have #3 (WR-01). |
| `src/maxpat/layout.py`              | 631-648    | Pass A in `_identify_companions` lacks single-parent guard          | ⚠️ Warning | meter~ summing two audio sources gets claimed by last line iterated -- order-dependent (WR-02).                                 |
| `src/maxpat/patcher.py`             | 2059-2173  | `add_m4l_gen_synth` doesn't validate documented invariants (no symbol check, no dup name check, no gen_varname collision check) | ⚠️ Warning | Caller passing `"freq cutoff"` or two `'synth'` skeletons gets a broken Live device that loads with no obvious error (WR-03).   |
| `src/maxpat/patcher.py`             | 688-744    | `add_overlay_readout` doesn't track target through `apply_layout`   | ⚠️ Warning | Calling builder before layout leaves overlay stranded at (0,0); contract is silent on ordering (WR-04).                         |
| `src/maxpat/patcher.py`             | 826-835    | Label width estimate `len(name)*6+14` undershoots `add_comment`'s `len(name)*7+16`; names ≥9 chars overlap multislider | ⚠️ Warning | Cosmetic but visible: `"frequency"` overlaps multislider's left edge by 3px; `"modulation_depth"` pushes label off-screen (WR-05). |
| `src/maxpat/layout.py`              | 638-641    | `try/except Exception` around `db.get_signal_role` is too broad     | ℹ️ Info    | `get_signal_role` is documented to return None on missing-data paths; broad except masks real bugs (IN-04).                     |
| `src/maxpat/patcher.py`             | 2129-2143  | Hard-coded layout coordinates in `add_m4l_gen_synth` (gen~ at 200,200; plugout~ at 200,400; dials at 50,100) | ℹ️ Info    | `apply_layout` overwrites these anyway -- defaulting to (0,0) would be more honest (IN-03).                                     |
| `src/maxpat/patcher.py`             | 832-834    | `add_labeled_param_bank` sets `fontsize=10` and `height=18` but doesn't shrink width to match | ℹ️ Info    | Underlying issue for WR-05; comment width still uses default fontsize-12 metrics (IN-02).                                       |

### Human Verification Required

None at this time -- all gaps are programmatically detectable and addressable. Manual Live-runtime verification of `m4l_gen_synth` output (loading a generated `.amxd` in Ableton Live, confirming each `live.dial` appears in the device parameter list and automates the gen~ Param) was deferred per `31-VALIDATION.md` "Manual-Only Verifications" but is not blocking goal verification. Manual MAX-runtime verification of `add_overlay_readout`'s `format=` rendering is moot until CR-01 is fixed (no point loading a patch where the format string is silently dropped).

### Gaps Summary

The phase delivered substantial value: 4 callable builder methods, role-driven companion dispatch with audio→meter~ working end-to-end, and discoverable agent documentation across both SKILL.md files. 60 builder tests pass, 165 agent-skills tests pass. Three of five must-haves are fully verified.

Two must-haves are partial:

1. **CR-01 (must-have #1, LAYOUT-01):** The `format=` kwarg of `add_overlay_readout` is the headline parameter in the success criterion's literal phrasing -- and it is silently non-functional. `extra_attrs['format']` is written but flonum has no such attribute (confirmed by direct DB inspection). The 5-step prose recipe was successfully codified for `bring_to_front` and `ignoreclick=1`, but the format-string promise is broken at the MAX runtime layer. This is a contract bug, not a polish issue. Fix: translate `'%.Nf'` to `numdecimalplaces=N` and decide on unit-suffix policy (raise vs. route to comment+prepend).

2. **WR-01 (must-have #3, LAYOUT-03):** The `audio → meter~ right` half of role-driven companion-pair placement works (cycle~ → meter~ integration test passes). The `status → flonum overlay` half is declared in `_ROLE_COMPANION_MAP` but `_place_companions` never branches on the `placement` field. The success criterion's literal phrasing names BOTH halves ("status→readout overlay, audio→meter"); only one ships. Plan 31-03's SUMMARY explicitly acknowledged this deferral. Either implement the overlay branch or remove `placement` from the map (so the contract matches the code).

Both gaps are well-defined, isolated, and addressable in a follow-up plan. No goal regressions to investigate -- the existing builder + dispatch surfaces are sound; the deltas are scoped feature gaps.

The five WR-warnings beyond CR-01 and WR-01 (WR-02 single-parent guard, WR-03 m4l invariant validation, WR-04 layout-ordering, WR-05 label-width overlap) are quality issues that should be fixed alongside the must-have closures but do not, individually, block goal verification per the goal's literal phrasing.

---

_Verified: 2026-04-30_
_Verifier: Claude (gsd-verifier)_
