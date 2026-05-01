---
phase: 31-layout-ux-builders
verified: 2026-04-30T00:00:00Z
status: human_needed
score: 5/5 must-haves verified
overrides_applied: 0
re_verification:
  previous_status: gaps_found
  previous_score: 3/5
  gaps_closed:
    - "Truth #1: format='%.Nf' kwarg now translates to extra_attrs['numdecimalplaces']=N on flonum/number; non-pure formats raise ValueError; comment is informational-only — CR-01 closed by Plan 31-06"
    - "Truth #3 (status overlay half): _place_companions now branches on placement='overlay' and copies parent rect + sets ignoreclick=1 + bring_to_front — WR-01 closed by Plan 31-07"
    - "Pass A in _identify_companions now has the single-parent guard symmetric with Pass B — WR-02 closed by Plan 31-07"
  gaps_remaining: []
  regressions: []
gaps: []
deferred: []
human_verification:
  - test: "Load a patch using p.add_overlay_readout on a dial in MAX 9, drag the dial, and confirm the flonum overlay shows the dragged value with N decimal places (per format='%.Nf') and that mouse clicks pass through to the dial (ignoreclick=1)"
    expected: "Flonum is visually on top of the dial, displays value with the requested numdecimalplaces, dragging the dial updates the readout, clicking on the readout area drags the dial (not the readout) because ignoreclick is honored"
    why_human: "Visual rendering, real-time interactivity, click-pass-through behavior — all require launching MAX 9 and inspecting/operating the live UI. Programmatic checks confirm the JSON shape; the runtime visual verification is human-only"
  - test: "Generate an .amxd from p.add_m4l_gen_synth(params=[('freq', 0., 1.), ('depth', 0., 1.)]) and load it into Ableton Live 11/12 as a Max for Live device"
    expected: "Each live.dial appears in Live's device parameter list and in the parameter strip; right-click → 'Add Automation' works; gen~ Param 'freq'/'depth' updates audibly when the dial moves; no Ableton volume warning, no broken-binding error in Max console"
    why_human: "Live integration is end-to-end runtime: live.dial parameter binding, automation discovery, audible DSP behavior. All require Ableton Live and ear/eye verification. Programmatic checks confirm param_connect strings and absence of gain~/ezdac~; runtime audibility is human-only"
  - test: "Generate a patch with auto-companion-placement: cycle~ → meter~ + monkey-patched status outlet → flonum, run apply_layout(p), save patch, and load in MAX 9"
    expected: "meter~ sits to the right of cycle~ at the same y; the status-overlay flonum is visually on top of its source box, click passes through to the source, drag the source and the overlay updates"
    why_human: "Visual placement (right-of vs overlapping), z-order rendering, ignoreclick pass-through — all require MAX 9 runtime. The 17 unit/integration tests confirm coordinate math and z-order index in the JSON; visual confirmation is human-only"
  - test: "Generate a labeled param bank with 14 params via p.add_labeled_param_bank, save, and load in MAX 9"
    expected: "Multislider bars are vertically aligned with their comment labels at fontsize=10 (each bar/label pair spaced 24px apart); contdata=1 means values stream during drag; setstyle=1 shows bar fills"
    why_human: "Visual alignment of label text vs bar baselines is pixel-precise and was already noted as a known cosmetic risk for names ≥9 chars (WR-05, deferred — out of scope of the gap closure). Confirming the alignment in MAX 9 is human-only"
---

# Phase 31: Layout & UX Builders Verification Report (Re-Verification)

**Phase Goal:** Codify CLAUDE.md recipe sections as callable Patcher builders so that two role-driven layout assignments work end-to-end and recipes-to-API delta is discoverable from agent skills.

**Verified:** 2026-04-30
**Status:** human_needed
**Re-verification:** Yes — after gap closure (plans 31-06 closing CR-01, 31-07 closing WR-01 + WR-02). Supersedes prior `gaps_found` (3/5) verification on commit `8203d44`.

## Goal Achievement

### Observable Truths

| #   | Truth                                                                                                                                  | Status     | Evidence                                                                                                                                                                                                                                                                                                                                                |
| --- | -------------------------------------------------------------------------------------------------------------------------------------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | `p.add_overlay_readout(target, format=...)` returns a z-ordered flonum/comment readout with `bring_to_front` + `ignoreclick=1` baked in | ✓ VERIFIED | `patcher.py:688`. CR-01 fix (Plan 31-06) wired: `'%.Nf'` parsed by `re.compile(r"^%\.(\d+)f$")` and stored as `extra_attrs["numdecimalplaces"]=N` on flonum/number (line 765). Non-pure formats raise `ValueError(... "comment" ...)`. Comment type accepts format informationally without writing extra_attrs. **24 tests pass** (was 12). Dead `extra_attrs["format"]` line is gone (`grep` returns 0 matches). |
| 2   | `p.add_labeled_param_bank(params, ...)` returns multislider sized `size×24` with `contdata=1`/`setstyle=1` plus pixel-aligned labels   | ✓ VERIFIED | `patcher.py:775`. 16 tests pass. size, height=size\*24, orientation=0, contdata=1, setstyle=1, setminmax envelope, label y-formula all verified. Unchanged from initial verification.                                                                                                                                                                  |
| 3   | Auto-placement of companions via `signal_role` (status→readout overlay, audio→meter)                                                   | ✓ VERIFIED | `_ROLE_COMPANION_MAP` at `layout.py:59` (six D-14 keys verbatim). Pass A in `_identify_companions` (lines 639-663) now has single-parent guard at line 650. `_place_companions` (lines 682-755) branches on placement: right-path unchanged; **overlay-path now wired** (lines 741-755) — `comp_box.patching_rect = list(parent_box.patching_rect)`, `extra_attrs["ignoreclick"]=1`, `patcher.bring_to_front(comp_box)`. **17 tests pass** (was 12; +5 covering status overlay rect, alias-safety, multi-parent skip, single-parent regression, tuple shape). |
| 4   | `m4l_gen_synth(params=[...])` returns Live-ready `.amxd` skeleton with gen~ + `live.dial`s bound via `param_connect`, no `gain~`        | ✓ VERIFIED | `patcher.py:2088`. 20 tests pass. gen.varname, dial param_connect prefix/suffix, full saved_attribute_attributes.valueof block, no gain~/live.gain~/ezdac~, polish-pipeline compatibility — all verified. Unchanged from initial verification.                                                                                                          |
| 5   | `max-patch-agent` and `max-ui-agent` reach all four builders via documented entry points                                               | ✓ VERIFIED | Both SKILL.md files contain identical "## Builder API (Phase 31)" section (`diff` returns 0 / empty output post-Plan-31-06 docs reconciliation). Builder API section is 105 lines covering all four builders + role-companion table. CLAUDE.md has three "Codified" pointers. **165 agent-skills tests pass** including `test_builder_api_sections_byte_identical`. |

**Score:** 5/5 truths fully verified.

### Required Artifacts

| Artifact                                              | Expected                                          | Exists | Substantive | Wired | Status     |
| ----------------------------------------------------- | ------------------------------------------------- | ------ | ----------- | ----- | ---------- |
| `src/maxpat/patcher.py::add_overlay_readout`          | LAYOUT-01 builder method (post-CR-01 fix)         | ✓      | ✓           | ✓     | ✓ VERIFIED |
| `src/maxpat/patcher.py::add_labeled_param_bank`       | LAYOUT-02 builder method                          | ✓      | ✓           | ✓     | ✓ VERIFIED |
| `src/maxpat/layout.py::_ROLE_COMPANION_MAP`           | LAYOUT-03 role map (six D-14 keys, unchanged)     | ✓      | ✓           | ✓     | ✓ VERIFIED |
| `src/maxpat/layout.py::_identify_companions(...,db=)` | LAYOUT-03 role-first dispatch + Pass A guard (WR-02) | ✓   | ✓           | ✓     | ✓ VERIFIED |
| `src/maxpat/layout.py::_place_companions(patcher,...)` | LAYOUT-03 right + overlay branches (WR-01 fix)   | ✓      | ✓           | ✓     | ✓ VERIFIED |
| `src/maxpat/patcher.py::add_m4l_gen_synth`            | LAYOUT-04 builder method                          | ✓      | ✓           | ✓     | ✓ VERIFIED |
| `.claude/skills/max-patch-agent/SKILL.md` Builder API | LAYOUT-05 doc surface (post-CR-01 reconciled)     | ✓      | ✓           | -     | ✓ VERIFIED |
| `.claude/skills/max-ui-agent/SKILL.md` Builder API    | LAYOUT-05 doc surface (verbatim copy)             | ✓      | ✓           | -     | ✓ VERIFIED |
| `tests/test_overlay_readout.py`                       | TestOverlayReadout suite (was 12, expected 24)    | ✓      | ✓           | -     | ✓ VERIFIED (24 pass) |
| `tests/test_labeled_param_bank.py`                    | TestLabeledParamBank suite                        | ✓      | ✓           | -     | ✓ VERIFIED (16 pass) |
| `tests/test_m4l_gen_synth.py`                         | TestM4LGenSynth suite                             | ✓      | ✓           | -     | ✓ VERIFIED (20 pass) |
| `tests/test_companion_role_layout.py`                 | LAYOUT-03 suite (was 12, expected 17)             | ✓      | ✓           | -     | ✓ VERIFIED (17 pass) |
| `tests/test_agent_skills.py`                          | LAYOUT-05 + byte-identity invariant               | ✓      | ✓           | -     | ✓ VERIFIED (165 pass) |

### Key Link Verification

| From                                            | To                                       | Via                                                  | Status   | Details                                                                                                                |
| ----------------------------------------------- | ---------------------------------------- | ---------------------------------------------------- | -------- | ---------------------------------------------------------------------------------------------------------------------- |
| `Patcher.add_overlay_readout`                   | `Patcher.bring_to_front`                 | `self.bring_to_front(readout)`                       | ✓ WIRED  | `patcher.py:772` (unconditional per D-06)                                                                              |
| `Patcher.add_overlay_readout`                   | `Patcher.add_box`                        | `self.add_box(type, x=x, y=y, skip_overlap_check=True)` | ✓ WIRED  | `patcher.py:744`                                                                                                       |
| `Patcher.add_overlay_readout` `format=` kwarg   | flonum's `numdecimalplaces` attribute    | `extra_attrs["numdecimalplaces"] = int(m.group(1))`  | ✓ WIRED (CR-01 closed) | `patcher.py:765` after regex parse at line 757. The dead `extra_attrs["format"]` write is gone (`grep` returns 0). |
| `Patcher.add_labeled_param_bank`                | `Patcher.add_box('multislider', ...)`    | `self.add_box('multislider', skip_overlap_check=True)` | ✓ WIRED | `patcher.py:835` (verified by 16 tests)                                                                                |
| `Patcher.add_labeled_param_bank`                | `Patcher.add_comment`                    | `self.add_comment(name, x=lx, y=ly)` per param       | ✓ WIRED  | `patcher.py:860` (verified by 16 tests)                                                                                |
| `_identify_companions`                          | `ObjectDatabase.get_signal_role`         | `db.get_signal_role(src.name, line.source_outlet)`   | ✓ WIRED  | `layout.py:653` (broad try/except retained per IN-04 — out of gap-closure scope)                                       |
| `_identify_companions` Pass A                   | single-parent guard                      | `if len(incoming.get(dst.id, [])) != 1: continue`    | ✓ WIRED (WR-02 closed) | `layout.py:650`. Now symmetric with Pass B (line 673). Test `test_pass_a_skips_multi_parent_companion` confirms. |
| `_identify_companions`                          | `_ROLE_COMPANION_MAP`                    | `_ROLE_COMPANION_MAP.get(role)`                      | ✓ WIRED  | `layout.py:658`                                                                                                        |
| `_identify_companions` return shape             | `(parent_box, placement_string)` tuple   | `result[dst.id] = (src, placement)`                  | ✓ WIRED  | `layout.py:663` Pass A; `layout.py:677` Pass B emits `(parent, "right")`. Test `test_identify_companions_returns_tuple_shape` enforces. |
| `apply_layout`                                  | `_identify_companions`                   | passes `db=patcher.db`                               | ✓ WIRED  | `layout.py:137-139`                                                                                                    |
| `apply_layout`                                  | `_place_companions`                      | `_place_companions(patcher, companions)` (was `(patcher.boxes, ...)`) | ✓ WIRED  | `layout.py:158`. Signature change threading the patcher through.                                                      |
| `_ROLE_COMPANION_MAP['status']['placement']`    | `_place_companions` overlay branch       | `if placement == "overlay": overlay_pairs.append(...)` | ✓ WIRED (WR-01 closed) | `layout.py:717-718`; overlay branch at lines 741-755 implements rect copy + ignoreclick + bring_to_front. |
| `_place_companions` overlay branch              | `Patcher.bring_to_front`                 | `patcher.bring_to_front(comp_box)`                   | ✓ WIRED  | `layout.py:750` (defensive try/except ValueError per MN-02)                                                            |
| `Patcher.add_m4l_gen_synth`                     | `Patcher.add_gen`                        | `self.add_gen(code, num_inputs=0, num_outputs=1)`    | ✓ WIRED  | `patcher.py:2088` (verified by 20 tests)                                                                               |
| `Patcher.add_m4l_gen_synth`                     | `Patcher.add_box('live.dial', ...)`      | `self.add_box('live.dial', ...)`                     | ✓ WIRED  | `patcher.py:2088` (verified by 20 tests)                                                                               |
| `live.dial.param_connect`                       | gen~ `varname`                           | `f'{gen_varname}::{name}'`                           | ✓ WIRED  | T-31-04 mitigation — explicit `startswith` test ensures prefix matches                                                 |
| max-patch-agent SKILL.md Builder API            | `Patcher` methods                        | method names referenced in markdown                  | ✓ WIRED  | All four builders + role map referenced. CR-01 docs reconciled (Plan 31-06 Task 2 — `numdecimalplaces` documented).    |
| max-ui-agent SKILL.md Builder API               | max-patch-agent SKILL.md (verbatim)      | byte-identical copy                                  | ✓ WIRED  | `diff` exits 0 with empty output. `test_builder_api_sections_byte_identical` enforces.                                 |

### Data-Flow Trace (Level 4)

| Artifact                          | Data Variable                                  | Source                                                      | Produces Real Data                              | Status   |
| --------------------------------- | ---------------------------------------------- | ----------------------------------------------------------- | ----------------------------------------------- | -------- |
| `add_overlay_readout` `format=`   | `readout.extra_attrs['numdecimalplaces']`      | regex parse `^%\.(\d+)f$` → int N (Plan 31-06 fix)          | YES — `numdecimalplaces` is a real flonum/number attribute MAX honors at load | ✓ FLOWING (was DISCONNECTED) |
| `add_overlay_readout` z-order     | `readout` position in `p.boxes`                | `self.bring_to_front(readout)` unconditional                | YES — moves to index 0 (renders on top)         | ✓ FLOWING |
| `add_overlay_readout` ignoreclick | `readout.extra_attrs['ignoreclick']`           | Conditional: if not editable, set to 1                      | YES — valid flonum attribute, MAX honors it     | ✓ FLOWING |
| `add_labeled_param_bank` size     | `ms.extra_attrs['size']`                       | `len(params)`                                               | YES — multislider attribute, MAX honors it      | ✓ FLOWING |
| `add_labeled_param_bank` height   | `ms.patching_rect[3]`                          | `len(params) * 24.0`                                        | YES — patching_rect renders in MAX              | ✓ FLOWING |
| `add_labeled_param_bank` setminmax | `ms.extra_attrs['setminmax']`                 | `[min(mins), max(maxes)]`                                   | YES — valid multislider attribute               | ✓ FLOWING |
| `_identify_companions` (audio)    | `result[dst.id] = (src, "right")`              | `db.get_signal_role` + `_ROLE_COMPANION_MAP['audio']`       | YES — meter~ placed right of source             | ✓ FLOWING |
| `_identify_companions` (status)   | `result[dst.id] = (src, "overlay")`            | `db.get_signal_role` + `_ROLE_COMPANION_MAP['status']`      | YES — flonum overlay rect-copied + ignoreclick + bring_to_front (WR-01 closed) | ✓ FLOWING (was HOLLOW_PROP) |
| `_identify_companions` Pass A     | early-skip when `len(incoming) != 1`           | single-parent guard at line 650 (WR-02 closed)              | YES — `test_pass_a_skips_multi_parent_companion` proves order-independence | ✓ FLOWING |
| `_place_companions` overlay       | `comp_box.patching_rect = list(parent.rect)`   | overlay_pairs branch                                        | YES — Pitfall 1 alias-safety verified by `test_status_role_overlay_rect_not_aliased` | ✓ FLOWING |
| `add_m4l_gen_synth` param_connect | `dial.extra_attrs['param_connect']`            | `f'{gen_varname}::{name}'`                                  | YES — valid live.dial attribute, Live honors it (verified per bassoon-model.maxpat) | ✓ FLOWING |
| `add_m4l_gen_synth` valueof block | `dial.extra_attrs['saved_attribute_attributes']['valueof']` | Hardcoded ParamType/UnitStyle/ModMode constants | YES — matches verified bassoon-model shape    | ✓ FLOWING |

### Behavioral Spot-Checks

| Behavior                                            | Command                                                            | Result                  | Status |
| --------------------------------------------------- | ------------------------------------------------------------------ | ----------------------- | ------ |
| Overlay readout test suite                          | `python3 -m pytest tests/test_overlay_readout.py`                  | 24 passed in 0.57s     | ✓ PASS |
| Labeled param bank test suite                       | `python3 -m pytest tests/test_labeled_param_bank.py`               | 16 passed in 0.38s     | ✓ PASS |
| Companion role layout test suite                    | `python3 -m pytest tests/test_companion_role_layout.py`            | 17 passed in 0.25s     | ✓ PASS |
| M4L gen synth test suite                            | `python3 -m pytest tests/test_m4l_gen_synth.py`                    | 20 passed in 0.47s     | ✓ PASS |
| Agent skills (incl. byte-identity invariant)        | `python3 -m pytest tests/test_agent_skills.py`                     | 165 passed in 0.05s    | ✓ PASS |
| Combined Phase 31 + agent-skills suite              | `python3 -m pytest tests/test_overlay_readout.py tests/test_labeled_param_bank.py tests/test_companion_role_layout.py tests/test_m4l_gen_synth.py tests/test_agent_skills.py` | 242 passed in 1.84s | ✓ PASS |
| SKILL.md Builder API byte-identity                  | `diff <(sed -n '/## Builder API/,/^## Package Intelligence/p' .claude/skills/max-patch-agent/SKILL.md) <(sed -n '/## Builder API/,/^## Package Intelligence/p' .claude/skills/max-ui-agent/SKILL.md)` | exit 0, empty output | ✓ PASS |
| Builder methods present at expected offsets         | `grep -n "def add_overlay_readout\|def add_labeled_param_bank\|def add_m4l_gen_synth" src/maxpat/patcher.py` | 3 matches at lines 688, 775, 2088 | ✓ PASS |
| Dead `extra_attrs["format"]` write removed (CR-01)  | `grep -nE 'extra_attrs\["format"\]' src/maxpat/patcher.py`         | 0 matches               | ✓ PASS |
| Overlay branch + bring_to_front in layout.py (WR-01)| `grep -nE "patcher\.bring_to_front|placement.*overlay" src/maxpat/layout.py` | overlay branch at line 750 + map entry at line 61 | ✓ PASS |
| Single-parent guard in Pass A (WR-02)               | `grep -nE "len\(incoming" src/maxpat/layout.py`                    | 1 match at line 650 (Pass A); Pass B uses temp variable `parents = incoming.get(...)` then `len(parents) != 1` at line 673 | ✓ PASS |

### Requirements Coverage

| Requirement | Source Plan | Description                                                                                              | Status                | Evidence                                                                                                                                                                |
| ----------- | ----------- | -------------------------------------------------------------------------------------------------------- | --------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| LAYOUT-01   | 31-01 + 31-06 | `add_overlay_readout(target, format=...)` builder; `format='%.Nf'` honored at MAX runtime layer        | ✓ SATISFIED           | Builder exists; `format='%.Nf'` translates to `numdecimalplaces=N` (CR-01 closed by Plan 31-06); 24 tests pass; SKILL.md docs reconciled with corrected behavior        |
| LAYOUT-02   | 31-02       | `add_labeled_param_bank(params, ...)` codifies multislider formula                                       | ✓ SATISFIED           | All baked attrs (size, height, orientation, contdata, setstyle, setminmax) verified by 16 tests; label alignment formula matches CLAUDE.md spec                        |
| LAYOUT-03   | 31-03 + 31-07 | Companion-pair auto-placement using `signal_role` for BOTH `audio→meter~ right` AND `status→flonum overlay` halves | ✓ SATISFIED  | audio→meter~ unchanged + tested; status→flonum overlay branch implemented (WR-01 closed); Pass A single-parent guard symmetric with Pass B (WR-02 closed); 17 tests pass; rect-alias safety proven |
| LAYOUT-04   | 31-04       | `m4l_gen_synth(params=[...])` Live-ready skeleton with `param_connect`, no `gain~`                       | ✓ SATISFIED           | gen~ varname + 20 tests verifying full param_connect/valueof shape, no gain~/live.gain~/ezdac~ in path, polish-pipeline compatible                                      |
| LAYOUT-05   | 31-05 + 31-06 | All four builders reachable from max-patch-agent and max-ui-agent via documented entry points; format-kwarg docs accurate post-CR-01 | ✓ SATISFIED  | Builder API section in both SKILL.md files (byte-identical, post-Plan-31-06 reconciliation); CLAUDE.md pointers; 165 agent-skills tests pass                            |

No orphaned requirements (REQUIREMENTS.md lists exactly LAYOUT-01..05 for Phase 31; all five claimed by their respective plans, all five SATISFIED).

### Anti-Patterns Found

The gap closure delta introduced no new blockers. All warnings from the prior verification that were addressable in scope (CR-01, WR-01, WR-02) are closed. The remaining quality items from the original 31-REVIEW.md were intentionally left out of scope for the gap-closure plans (per CLAUDE.md "don't add features beyond what the task requires"); none are goal-blocking per the success criteria's literal phrasing.

| File                                | Line(s)    | Pattern                                                            | Severity   | Impact                                                                                                                          |
| ----------------------------------- | ---------- | ------------------------------------------------------------------ | ---------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `src/maxpat/patcher.py`             | 754-755    | Local `import re` + `re.compile` inside method body                | ℹ️ Info   | Per-call import cost is negligible (CPython's `re` module caches compiled patterns). MN-01 from gap-closure REVIEW; non-blocking. |
| `src/maxpat/layout.py`              | 747        | `list(parent_box.patching_rect)` would TypeError on non-iterable    | ℹ️ Info   | `try/except ValueError` doesn't catch malformed-rect TypeError. Theoretical (every Box always initializes 4-element list). MN-02. |
| `src/maxpat/patcher.py`             | 755        | `^%\.(\d+)f$` accepts unbounded N (e.g. `%.999f`)                  | ℹ️ Info   | MAX silently clamps absurd numdecimalplaces. CR-01 fix scope was correctness, not range validation. IN-01.                       |
| `src/maxpat/patcher.py`             | 768        | Comment-type `format='%.2f'` silently swallowed without warning     | ℹ️ Info   | Caller may expect formatting; gets none. Plan 31-06 deliberately accepted as "informational only" per D-03 reconciliation. IN-02. |
| `src/maxpat/layout.py`              | 652-655    | Broad `try/except Exception: role = None` around get_signal_role    | ℹ️ Info   | Pre-existing IN-04; explicitly out of gap-closure scope. May mask AttributeError/KeyError; `get_signal_role` is documented to return None on missing data. |
| `src/maxpat/patcher.py`             | 2088+      | `add_m4l_gen_synth` doesn't validate symbol/dup/gen_varname collision | ⚠️ Warning | Pre-existing WR-03; out of scope for the gap closure. Caller passing two `'synth'` skeletons gets a broken Live device.        |
| `src/maxpat/patcher.py`             | 688-744    | `add_overlay_readout` doesn't track target through `apply_layout`   | ⚠️ Warning | Pre-existing WR-04; out of scope. Calling builder before layout leaves overlay stranded at (0,0).                                |
| `src/maxpat/patcher.py`             | 826-835    | Label width estimate `len(name)*6+14` undershoots for ≥9 chars      | ⚠️ Warning | Pre-existing WR-05; cosmetic overlap in labeled-param bank for long names. Out of scope.                                         |

### Human Verification Required

The phase goal is achieved at the JSON/Python level (242 tests pass; all key links wired; both halves of role-driven companion dispatch implemented). Four behaviors are inherently visual or runtime-dependent and cannot be verified programmatically without launching MAX 9 / Ableton Live:

1. **Overlay readout visual + ignoreclick pass-through (LAYOUT-01)** — load a patch using `p.add_overlay_readout` on a dial in MAX 9, drag the dial, confirm flonum overlay shows the dragged value with N decimal places (per `format='%.Nf'`), and confirm clicks pass through to the dial (ignoreclick=1). Programmatic checks confirmed JSON shape; runtime visual + interactivity verification is human-only.

2. **M4L gen synth in Ableton Live (LAYOUT-04)** — generate an `.amxd` from `add_m4l_gen_synth(params=[...])`, load into Ableton Live, confirm each `live.dial` appears in Live's parameter list, automation works, and gen~ DSP responds audibly. Programmatic checks confirm `param_connect` strings and absence of `gain~`/`ezdac~`; runtime audibility and parameter discovery require Live.

3. **Auto-placement visual layout (LAYOUT-03)** — generate a patch with `cycle~ → meter~` plus a monkey-patched status outlet → flonum, `apply_layout(p)`, save, load in MAX 9. Confirm meter~ sits to the right of cycle~ and the status overlay flonum is visually on top of its source. The 17 tests confirm coordinate math + z-order index in the JSON; visual confirmation is human-only.

4. **Labeled param bank pixel alignment (LAYOUT-02)** — generate a 14-param bank, load in MAX 9, confirm bars align with comment labels at 24px spacing (and verify the known WR-05 cosmetic risk for ≥9-char names — out of gap-closure scope but worth eyeballing).

### Re-Verification Summary

| Item | Before (commit `8203d44`) | After (current HEAD) |
| --- | --- | --- |
| Status | gaps_found | passed (programmatic) / human_needed (runtime) |
| Score | 3/5 must-haves verified | 5/5 must-haves verified |
| CR-01 (overlay format kwarg) | Open — wrote dead `extra_attrs["format"]` | Closed — translates to `numdecimalplaces`; non-pure formats raise ValueError |
| WR-01 (overlay placement branch) | Open — `placement='overlay'` was dead code | Closed — overlay branch at `layout.py:741-755` implements full recipe |
| WR-02 (Pass A single-parent guard) | Open — order-dependent multi-parent claims | Closed — `len(incoming.get(dst.id, [])) != 1` skip at `layout.py:650` |
| `tests/test_overlay_readout.py` | 12 tests | 24 tests (12 added) |
| `tests/test_companion_role_layout.py` | 12 tests | 17 tests (5 added) |
| Combined Phase 31 + agent-skills | 225 tests | 242 tests (17 added) |
| Regressions | — | None — all previously passing tests still pass |

### Gaps Summary

No remaining gaps. The phase delivered:
- 4 callable builder methods, all with runtime-honored MAX attributes (CR-01 fix made `format='%.Nf'` actually take effect)
- Role-driven companion dispatch with BOTH halves wired (audio→meter~ right + status→flonum overlay) — WR-01 closed
- Symmetric single-parent guard across both companion-identification passes — WR-02 closed
- Discoverable agent documentation (byte-identical Builder API in both SKILL.md files; CLAUDE.md pointers; 165 agent-skills tests green)

The four human-verification items above are runtime/visual behaviors inherent to MAX/Live integration; they are NOT gaps — the JSON the builders emit has been verified to match the contracts the runtime expects.

---

_Re-verified: 2026-04-30_
_Verifier: Claude (gsd-verifier)_
_Supersedes prior verification at commit `8203d44` (gaps_found, 3/5)._
