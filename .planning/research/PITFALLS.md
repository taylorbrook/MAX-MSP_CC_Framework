# Domain Pitfalls: M4L Device Creation

**Domain:** Max for Live device authoring within existing patch generation framework
**Researched:** 2026-04-05
**Confidence:** HIGH for parameter system pitfalls (verified against kicksynth-m4l.maxpat ground truth + Cycling 74 docs + Ableton production guidelines), HIGH for validation/critic integration pitfalls (verified against framework source code), MEDIUM for presentation rendering differences (official docs + forum reports, no direct testing)

## Critical Pitfalls

Mistakes that cause devices to fail in Ableton, require structural rewrites, or silently break automation.

### Pitfall 1: Duplicate parameter_longname Crashes or Breaks Automation

**What goes wrong:** Two or more live.* controls share the same `parameter_longname` value in their `saved_attribute_attributes.valueof` block. Ableton collects parameter longnames exactly once at device instantiation. Duplicate names cause Live and Max to desync, leading to crashes, broken automation lanes, or parameters that silently stop saving/restoring.

**Why it happens:** The Box creation path (`patcher.py` line 320) sets `parameter_enable: 0` on all UI objects by default. When an agent manually sets `parameter_enable: 1` via `extra_attrs`, it must also provide a unique `parameter_longname` inside `saved_attribute_attributes.valueof`. There is zero framework validation for longname uniqueness. If the agent copies a template and forgets to change the longname, or if a scaffold generates multiple dials from a loop with the same default name, the device will crash Live.

**Consequences:** Ableton crash on device load, or broken automation where two parameters fight for the same lane. Max auto-appends `[1]`, `[2]` suffixes to disambiguate, but these show up as duplicate entries in Live's automation dropdown. Cannot be fully fixed without editing the .maxpat JSON.

**Prevention:**
1. M4L critic must validate `parameter_longname` uniqueness across all boxes in the device (blocker-level)
2. Scaffold must generate unique longnames from control labels, never reuse defaults
3. Warn if any live.* object has `parameter_enable: 1` but no `saved_attribute_attributes.valueof.parameter_longname`
4. Warn if any live.* object retains the MAX default name format (e.g., `"live.dial"`, `"live.dial[1]"`)

**Detection:** Grep patch JSON for duplicate `parameter_longname` values. Check for live.* objects missing the `saved_attribute_attributes` block entirely.

**Phase:** M4L critic (M4L-03) -- highest-priority critic check.

**Confidence:** HIGH -- Cycling 74 forums document crashes; Ableton production guidelines explicitly require unique longnames.

---

### Pitfall 2: Existing Validation Silently Ignores M4L Signal Chains

**What goes wrong:** The validation pipeline (Layer 4) and DSP critic both check gain staging and unterminated chains, but they only recognize `dac~`/`ezdac~` as terminal objects. In M4L devices, `plugout~` IS the terminal. Result: every M4L signal chain gets flagged as "unterminated" (false positive), and gain staging checks never fire for M4L (false negative -- oscillator to plugout~ without attenuation passes unchecked).

**Why it happens:** The `_TERMINAL_NAMES` sets are hardcoded:
- `validation.py` line 41: `{"dac~", "ezdac~", "send~", "out~"}`
- `dsp_critic.py` line 33: `{"dac~", "ezdac~"}`

Nobody added `plugout~`. The gain staging BFS in `dsp_critic.py` line 235 only stops traversal at `_TERMINAL_NAMES`, so it never detects unsafe signal paths to `plugout~`.

**Consequences:**
- Every M4L device generates spurious "unterminated signal chain" warnings on `plugout~` (nuisance that trains developer to ignore warnings)
- Oscillator connected directly to `plugout~` without `*~` attenuation passes both validation and DSP critic silently (dangerous -- full-volume audio)
- Note: `gain~` should NOT be placed immediately before `plugout~` (Ableton channel strip handles volume, per `feedback_m4l_no_gain.md`). But gain staging for amplitude safety still matters.

**Prevention:**
1. Add `"plugout~"` to `_TERMINAL_NAMES` in BOTH `validation.py` and `dsp_critic.py`
2. Add `"send~"` to the DSP critic's terminal set (already in validation.py but missing from dsp_critic.py)
3. M4L critic separately enforces: `gain~` immediately before `plugout~` is a WARNING (redundant with Ableton channel strip)
4. Gain staging BFS must traverse to `plugout~` the same way it traverses to `dac~`

**Detection:** Run existing validation on kicksynth-m4l.maxpat -- false positive unterminated warnings should exist right now.

**Phase:** Validation update (small additive fix, do early -- zero risk of breaking existing behavior).

**Confidence:** HIGH -- verified by reading `validation.py` lines 41, 635 and `dsp_critic.py` lines 33, 235.

---

### Pitfall 3: Missing saved_attribute_attributes Makes Parameters Non-Functional

**What goes wrong:** A `live.dial` has `parameter_enable: 1` but no `saved_attribute_attributes` block. The dial appears visually correct in MAX standalone, but in Ableton: no automation lane, no MIDI mapping, parameter values don't save with the Live Set, and the dial may revert to default on device reload.

**Why it happens:** The Box class has no first-class support for `saved_attribute_attributes`. It must be set via `extra_attrs`, which is a raw dict with no schema validation. The required structure (from kicksynth-m4l ground truth) is:

```json
{
  "saved_attribute_attributes": {
    "valueof": {
      "parameter_longname": "Unique Name",
      "parameter_shortname": "Short",
      "parameter_type": 0,
      "parameter_mmin": 0.0,
      "parameter_mmax": 1.0,
      "parameter_initial": [0.5],
      "parameter_initial_enable": 1,
      "parameter_modmode": 0,
      "parameter_unitstyle": 1
    }
  }
}
```

An agent might set `parameter_enable: 1` and forget `saved_attribute_attributes` entirely, or omit required fields. MAX standalone shows no error -- the failure only manifests in Ableton.

**Consequences:** Parameters appear in device but cannot be automated, MIDI-mapped, or stored. User thinks device works in MAX, discovers it is broken in Ableton.

**Prevention:**
1. Scaffold must auto-generate complete `saved_attribute_attributes` for every live.* control
2. M4L critic: if `parameter_enable == 1` then `saved_attribute_attributes.valueof` must exist with at minimum `parameter_longname`, `parameter_shortname`, `parameter_type`
3. Consider adding a `set_m4l_parameter()` convenience method to Box that validates the structure

**Detection:** Grep for boxes with `parameter_enable: 1` that lack `saved_attribute_attributes`.

**Phase:** Scaffold (M4L-01) + Critic (M4L-03).

**Confidence:** HIGH -- verified against kicksynth-m4l.maxpat where all 24 live.dials have complete `saved_attribute_attributes` blocks.

---

### Pitfall 4: Missing openinpresentation and devicewidth Patcher Properties

**What goes wrong:** An M4L device .maxpat has `openinpresentation: 0` (the framework default in `DEFAULT_PATCHER_PROPS`, line 63 of `defaults.py`). When loaded in Ableton, the device shows patching mode instead of presentation mode -- exposing raw wiring to the user. Even if all UI objects have `presentation: 1` and `presentation_rect` set correctly, the patcher-level flag must be `1`.

Similarly, `devicewidth: 0.0` (default) means Ableton auto-sizes the device width, which may produce an unusably narrow or wide device.

**Why it happens:** `DEFAULT_PATCHER_PROPS` sets `openinpresentation: 0` and `devicewidth: 0.0` -- correct for standalone MAX, wrong for M4L. No framework-level distinction exists between "this is an M4L device" and "this is a regular patch."

**Consequences:** Device loads in Ableton showing raw patch cords. User sees internal wiring instead of polished UI.

**Prevention:**
1. M4L scaffold must set `openinpresentation: 1` and a sensible `devicewidth` on `patcher.props`
2. M4L critic: if patch contains `plugout~` or live.* UI controls, `openinpresentation` must be `1`
3. Critic should warn if `devicewidth` is 0.0 in a detected M4L device

**Detection:** Check `patcher.props["openinpresentation"]` value.

**Phase:** Scaffold (M4L-01) + Critic (M4L-03).

**Confidence:** HIGH -- verified against kicksynth-m4l.maxpat (`openinpresentation: 1`, `devicewidth: 614.0`). Cycling 74 docs confirm.

---

### Pitfall 5: gain~ Before plugout~ Duplicates Ableton Volume Control

**What goes wrong:** A `gain~` or `live.gain~` is placed in the signal chain immediately before `plugout~`, creating a volume fader that duplicates Ableton's channel strip volume.

**Why it happens:** Standard MAX habit -- always put gain before output. In standalone MAX with `dac~`, this is correct. In M4L, the channel strip handles volume post-device.

**Consequences:** Double volume control. Gain staging confusion. Possible clipping if user maxes both.

**Prevention:** M4L critic: trace signal connections backward from `plugout~` inlets. If `gain~` or `live.gain~` is directly connected (or within 1-2 hops), flag as warning. Exception: `*~` with a constant for mixing is fine; `live.gain~` as input gain (not output) is fine.

**Detection:** Graph traversal from plugout~ backward through signal connections.

**Phase:** M4L critic (M4L-03).

**Confidence:** HIGH -- documented in project memory `feedback_m4l_no_gain.md`.

## Moderate Pitfalls

### Pitfall 6: Presentation Layout Exceeds 169px Height

**What goes wrong:** A device looks correct in MAX's presentation mode (no height constraint) but clips when displayed in Ableton's device view, which is fixed at 169 pixels high. Controls positioned below y=169 are simply not visible.

**Why it happens:** The current `_apply_presentation_layout` in `layout.py` uses a crude grid with `grid_y_start = 20.0` and `grid_v_spacing = 40.0`. For a `live.dial` (48px tall): row 2 bottom edge = 20 + 2*(48+40) + 48 = 244px. That is 75px past the 169px boundary -- invisible in Ableton.

**Consequences:** Device UI works in MAX but large portions are clipped in Ableton. User sees incomplete controls.

**Prevention:**
1. M4L presentation layout must enforce: all `presentation_rect` y + height <= 169
2. Prefer wide/horizontal layouts over tall/vertical ones
3. Use tabbed interfaces (kicksynth's `live.tab` pattern) to fit many controls in limited vertical space
4. Critic must warn if any presentation_rect exceeds 169px height boundary

**Detection:** Check `max(presentation_rect[1] + presentation_rect[3])` across all presentation objects.

**Phase:** Presentation layout (M4L-04) + Critic (M4L-03).

**Confidence:** HIGH for the 169px constraint (documented in Cycling 74 docs). MEDIUM for the specific layout.py interaction (calculated, not runtime-tested).

---

### Pitfall 7: varname Missing on Live.* Objects

**What goes wrong:** `live.*` objects without a `varname` attribute cannot be reliably addressed by pattr, pattrstorage, or the Live API. The `varname` serves as the scripting name.

**Why it happens:** The Box class has no `varname` in its creation path. The kicksynth-m4l.maxpat sets unique `varname` on every live.* object (e.g., `"d_pitch_start"`), but via `extra_attrs` manually.

**Consequences:** Parameters work for basic automation but fail with preset systems, pattrstorage, and some Push integration features.

**Prevention:**
1. Scaffold must auto-generate unique `varname` for every live.* object
2. Use naming convention: sanitized version of short name (e.g., `"Pitch Start"` -> `"d_pitch_start"`)
3. Critic: all live.* objects with `parameter_enable: 1` must have a `varname`

**Phase:** Scaffold (M4L-01).

**Confidence:** HIGH -- verified against kicksynth-m4l ground truth (all 24 dials + tab + scope + meter have varname).

---

### Pitfall 8: Instance Namespace Collision (Missing --- Prefix)

**What goes wrong:** Named objects like `buffer~ mysample`, `send mydata`, `coll mydict` use global names. When two instances of the device are loaded on different tracks, they share the same namespace -- audio buffers get overwritten, send/receive messages cross between instances.

**Why it happens:** In standalone MAX, name scoping is not an issue. In M4L, all devices share a single MAX universe. The `---` prefix (e.g., `send ---cutoff`) is replaced at runtime with a unique device ID.

**Consequences:** Multiple device instances interfere with each other. Extremely hard to debug -- only manifests with multiple instances.

**Prevention:**
1. M4L scaffold should auto-prefix `---` on all send/receive/buffer~/coll names
2. M4L critic: scan for `buffer~`, `coll`, `dict`, `send`, `receive`, `send~`, `receive~`, `value` objects with names not starting with `---`
3. Document in CLAUDE.md M4L section

**Phase:** CLAUDE.md rules (M4L-07) + Scaffold (M4L-01) + Critic (M4L-03).

**Confidence:** HIGH -- documented in Ableton production guidelines and Cycling 74 docs.

---

### Pitfall 9: Device Type Detection False Positives

**What goes wrong:** A regular MAX patch that happens to contain `plugin~` (for sidechain input) or `live.dial` (aesthetics preference) gets incorrectly classified as M4L. The M4L critic fires on a non-M4L patch, producing spurious warnings.

**Why it happens:** Device type detection based on single-object presence is ambiguous. `live.dial` appears in non-M4L patches. `plugin~` can be used in standalone MAX.

**Prevention:**
1. Use confidence scoring, not single-object detection:
   - `plugout~` present: strong signal
   - `plugin~` present: moderate signal
   - `openinpresentation: 1`: moderate signal
   - live.* with `parameter_enable: 1`: strong signal
   - `dac~`/`ezdac~` present: counter-signal (likely standalone)
   - Require 2+ strong signals OR 1 strong + 2 moderate
2. Better: scaffold sets explicit M4L marker in patcher metadata
3. M4L critic should only auto-invoke at high confidence

**Phase:** Device type detection (M4L-08) + Critic auto-invoke.

**Confidence:** MEDIUM -- scenarios are architecturally predictable but hypothetical.

---

### Pitfall 10: Router Dispatch "live" Keyword Ambiguity

**What goes wrong:** Adding M4L keywords to the router causes non-M4L tasks to get incorrectly routed. "Build a synthesizer with live controls" (meaning real-time, interactive) gets routed as M4L because "live" is a keyword.

**Why it happens:** "live" is massively overloaded: "live performance", "live coding", "live input" (adc~), vs. "Ableton Live". Words "device", "effect", "instrument" are also ambiguous in MAX context.

**Prevention:**
1. M4L dispatch keywords must be multi-word phrases:
   - GOOD: "Max for Live", "M4L", "Ableton device", "audio effect device"
   - BAD: "live", "device", "effect", "instrument"
2. Require co-occurrence: "live" only triggers M4L routing when paired with "Ableton", "M4L", "Max for Live"
3. Regression test existing dispatch paths

**Phase:** Router dispatch (M4L-02).

**Confidence:** MEDIUM -- standard disambiguation problem, but "live" is uniquely overloaded in this domain.

---

### Pitfall 11: live.thisdevice Initialization Timing Race Conditions

**What goes wrong:** Initialization logic uses `loadbang` but some operations need the Live API ready (which fires after `loadbang`). Using `delay` or `deferlow` to "fix" timing creates fragile race conditions. Known edge case: `live.thisdevice` bang fires BEFORE control surface init when Live opens a project file directly.

**Why it happens:** `live.thisdevice` fires when device is "completely initialized" but this does NOT guarantee Live API control surfaces are ready. In MAX standalone, `live.thisdevice` acts like `loadbang` -- timing issues are invisible during development.

**Consequences:** Device works when manually added but fails on project load. Intermittent bugs.

**Prevention:**
1. Scaffold includes `live.thisdevice` in every M4L device (currently absent from kicksynth-m4l)
2. Init pattern: `live.thisdevice` -> `trigger` for ordered setup, NOT `loadbang` -> `delay`
3. For Live API operations: defer until `live.thisdevice` bang
4. Critic warning if `delay`/`deferlow` downstream of `loadbang` in M4L device

**Phase:** Scaffold (M4L-01) + CLAUDE.md rules (M4L-07).

**Confidence:** HIGH -- documented by Cycling 74, confirmed in forums with specific startup edge case.

---

### Pitfall 12: plugout~ maxclass Ambiguity Between DB and Reality

**What goes wrong:** The MSP object database says `plugout~` has `maxclass: "plugout~"`. The kicksynth-m4l ground truth shows `maxclass: "newobj"`. If someone "fixes" `maxclass_map.py` to match the DB by adding plugin~/plugout~ to `UI_MAXCLASSES`, the generated output changes silently.

**Why it happens:** `plugin~`/`plugout~` are NOT in `UI_MAXCLASSES`, so `resolve_maxclass()` returns `"newobj"`. This accidentally matches working output. But the DB disagrees.

**Prevention:**
1. Verify in MAX which maxclass is correct
2. If `newobj` correct: update msp/objects.json DB entries
3. Do NOT add plugin~/plugout~ to UI_MAXCLASSES without testing
4. Current behavior (newobj) matches working output -- leave as-is until verified

**Phase:** Early verification task (M4L-09) -- resolve before other work touches plugin~/plugout~.

**Confidence:** MEDIUM -- current behavior works by accident.

## Minor Pitfalls

### Pitfall 13: Fractional Pixel Coordinates in Presentation

**What goes wrong:** `presentation_rect` values like `[4.356, 30.7, 50.0, 48.0]` cause blurry rendering on non-Retina displays.

**Prevention:** Round all presentation_rect values to integers. Ableton production guidelines explicitly state "whole-pixel dimensions."

**Phase:** Presentation layout (M4L-04).

**Confidence:** HIGH -- documented in Ableton production guidelines.

---

### Pitfall 14: plugin~/plugout~ Missing from Layout _IO_OBJECT_NAMES

**What goes wrong:** `suggest_subpatchers()` in `layout.py` uses `_IO_OBJECT_NAMES` to protect I/O objects from subpatcher extraction. This set only includes `dac~`, `ezdac~`, `adc~`, `ezadc~`, `inlet`, `outlet`. Missing: `plugin~`, `plugout~`. Subpatcher suggestion could recommend wrapping plugout~ into a subpatcher, breaking device audio routing.

**Prevention:** Add `"plugin~"`, `"plugout~"` to `_IO_OBJECT_NAMES` in `layout.py` line 1091.

**Phase:** Early fix alongside M4L-09.

**Confidence:** HIGH -- verified by reading layout.py line 1091.

---

### Pitfall 15: parameter_type Magic Numbers and Enum/Range Mismatches

**What goes wrong:** `parameter_type` uses magic numbers: 0 = Float, 1 = Int, 2 = Enum, 3 = Blob. A typo (`parameter_type: 1` instead of `0` for continuous dial) produces stepped automation. `parameter_type: 2` (Enum) without matching `parameter_enum` array shows blank entries. Int type with `parameter_mmax > 255` exceeds Live's display limit.

**Prevention:**
1. Define named constants: `M4L_PARAM_FLOAT = 0`, `M4L_PARAM_INT = 1`, `M4L_PARAM_ENUM = 2`, `M4L_PARAM_BLOB = 3`
2. Define `parameter_unitstyle` constants: 0=Int, 1=Float, 2=ms, 3=Hz, 4=dB, 5=%, 6=Pan, 7=Semitones, 8=MIDI, 9=Custom
3. Critic: warn if Enum type but no `parameter_enum` list

**Phase:** Constants module + Scaffold helpers (M4L-01).

**Confidence:** MEDIUM -- values verified against ground truth and docs.

---

### Pitfall 16: live.text Output Mode Default

**What goes wrong:** `live.text` defaults to "Mouse Down" output mode, but M4L button behavior expects "Mouse Up" for most use cases. Triggers on mouse-down feel wrong in Ableton's UI.

**Prevention:** Scaffold should set `live.text` output mode to "Mouse Up". Exception: performance controls needing timing accuracy.

**Phase:** CLAUDE.md rules (M4L-07).

**Confidence:** HIGH -- documented in Ableton production guidelines.

---

### Pitfall 17: parameter_modmode Omission

**What goes wrong:** `parameter_modmode` (present on all 24 parameters in kicksynth-m4l) controls clip modulation behavior. Omitting it may cause unexpected default modulation mode. Guidelines recommend Bipolar for Float, Absolute for Int.

**Prevention:** Include `parameter_modmode` in all `saved_attribute_attributes.valueof` blocks. Value 0 = Unipolar is safe default.

**Phase:** Scaffold (M4L-01).

**Confidence:** MEDIUM -- present in ground truth; consequences of omission not well-documented.

---

### Pitfall 18: Patcher-Level parameters Dict Out of Sync

**What goes wrong:** The patcher-level `parameters` dict (mapping box IDs to parameter metadata) gets out of sync with box-level `saved_attribute_attributes`. Live may show stale parameter names.

**Prevention:** Auto-generate patcher-level `parameters` dict from box-level metadata on save. Never maintain manually.

**Phase:** Scaffold (M4L-01) or save pipeline.

**Confidence:** LOW -- not observed in ground truth (kicksynth-m4l has no patcher-level parameters dict), but documented in forums.

## Phase-Specific Warnings

| Phase Topic | Likely Pitfall | Mitigation |
|-------------|---------------|------------|
| M4L Scaffold (M4L-01) | Missing saved_attribute_attributes structure, forgetting openinpresentation, no varname, no --- scoping | Use kicksynth-m4l.maxpat as template; validate against Pitfalls 3-5, 7-8 |
| Router Dispatch (M4L-02) | "live" keyword false positives, disrupting existing dispatch | Multi-word phrases only; regression test all existing dispatch paths (Pitfall 10) |
| M4L Critic (M4L-03) | Too strict: blocking valid patches with live.dial; Too loose: missing parameter uniqueness | Confidence-scored device detection (Pitfall 9); parameter_longname uniqueness check (Pitfall 1) |
| Presentation Layout (M4L-04) | Exceeding 169px height, fractional pixels, grid spacing too generous | Hard cap at 169px; round to integers; test with real device sizes (Pitfalls 6, 13) |
| Validation Updates | Adding plugout~ to terminals might affect existing tests | Additive change -- existing tests should not break (Pitfall 2) |
| Database Updates (M4L-05, M4L-06) | Wrong maxclass for plugin~/plugout~ | Resolve M4L-09 FIRST before adding relationships or changing maps (Pitfall 12) |
| CLAUDE.md Rules (M4L-07) | Rules too detailed or too vague | Follow existing CLAUDE.md patterns; test with agent prompts |
| Device Type Detection (M4L-08) | Single-object detection causing false positives | Confidence scoring not binary detection (Pitfall 9) |

## Integration Risk Matrix

| Existing Module | M4L Touchpoint | Risk | Specific Pitfall |
|-----------------|----------------|------|------------------|
| `validation.py` _TERMINAL_NAMES | Add plugout~ | LOW (additive) | #2 |
| `dsp_critic.py` _TERMINAL_NAMES | Add plugout~ | LOW (additive) | #2 |
| `dsp_critic.py` gain staging BFS | Traverse to plugout~ | LOW (additive) | #2 |
| `layout.py` _IO_OBJECT_NAMES | Add plugin~/plugout~ | LOW (additive) | #14 |
| `layout.py` presentation grid | Replace with M4L-aware layout | MEDIUM (behavior change) | #6, #13 |
| `patcher.py` Box.to_dict() | Need varname, saved_attribute_attributes | MEDIUM (via extra_attrs) | #3, #7 |
| `defaults.py` DEFAULT_PATCHER_PROPS | Override openinpresentation, devicewidth | LOW (scaffold sets props) | #4 |
| `maxclass_map.py` UI_MAXCLASSES | Do NOT add plugin~/plugout~ until verified | MEDIUM (could break) | #12 |
| `critics/__init__.py` auto-detect | Add M4L critic gating | MEDIUM (false positives) | #9 |
| Router dispatch-rules.md | Add M4L keywords | MEDIUM (false positives) | #10 |

## Sources

- Cycling 74 Documentation: [Device Parameters in Max for Live](https://docs.cycling74.com/userguide/m4l/live_parameters/)
- Cycling 74 Documentation: [live.thisdevice Reference](https://docs.cycling74.com/legacy/max8/refpages/live.thisdevice)
- Cycling 74 Documentation: [Max for Live Limitations](https://docs.cycling74.com/max5/vignettes/core/live_limitations.html)
- Cycling 74 Documentation: [User Interfaces in Max for Live](https://docs.cycling74.com/max5/vignettes/core/live_userinterfaces.html)
- Ableton Official: [Max for Live Production Guidelines](https://github.com/Ableton/maxdevtools/blob/main/m4l-production-guidelines/m4l-production-guidelines.md)
- Cycling 74 Forums: [bPatchers creating duplicate automation lanes](https://cycling74.com/forums/bpatchers-creating-duplicate-automation-lanes-in-live)
- Cycling 74 Forums: [Difference between .amxd and .maxpat](https://cycling74.com/forums/difference-between-amxd-and-maxpat)
- Cycling 74 Forums: [Initialization order inconsistency](https://cycling74.com/forums/initialization-order-inconsistency)
- Cycling 74 Forums: [live.thisdevice bang before control_surface init](https://cycling74.com/forums/live-thisdevice-bang-comes-before-control_surface-init-on-live-exe-startup)
- Framework source: `validation.py` lines 33-41, 616-654 (terminal names, unterminated chain check)
- Framework source: `dsp_critic.py` lines 24-33, 171-249 (oscillator names, gain staging BFS)
- Framework source: `patcher.py` lines 296-344 (Box.to_dict creation path, parameter_enable default)
- Framework source: `layout.py` lines 1057-1083 (presentation grid), 1091-1094 (IO object names)
- Framework source: `defaults.py` lines 51-93 (DEFAULT_PATCHER_PROPS)
- Framework source: `maxclass_map.py` lines 12-52 (UI_MAXCLASSES)
- Ground truth: `patches/kicksynth/generated/kicksynth-m4l.maxpat` (working M4L device)
- Project memory: `feedback_m4l_no_gain.md` (gain~/plugout~ rule)
