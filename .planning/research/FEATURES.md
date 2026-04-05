# Feature Landscape: v3.0 M4L Device Creation

**Domain:** Max for Live device authoring within existing patch generation framework
**Researched:** 2026-04-05
**Confidence:** HIGH for device structure/conventions (verified against Cycling 74 docs, Ableton production guidelines, and existing kicksynth-m4l ground truth); MEDIUM for presentation layout patterns (conventions documented but optimal automation strategy TBD); HIGH for .amxd export (format fully reverse-engineered from ground truth)

---

## Context: What Exists vs What Is Needed

The framework already generates valid M4L devices -- the kicksynth-m4l.maxpat proves this with 67 boxes, 24 live.dial controls, presentation mode, plugout~, and parameter_enable. But every M4L-specific aspect was done manually: the developer had to know to add plugout~ instead of dac~, set parameter_enable on every live.* control, configure presentation_rect values, avoid gain~ before plugout~, and use the `---` naming convention for local scope.

The v3.0 milestone automates this. The framework should know what an M4L device needs, scaffold it correctly, validate it against M4L conventions, and produce professional-quality presentation layouts.

**What this research covers:** The specific features needed for M4L device creation -- scaffolding, validation, layout, parameter system, device type handling. NOT the general framework infrastructure (already built) or technology stack (Python, unchanged).

---

## Table Stakes

Features users expect from an M4L-aware framework. Missing any of these means the M4L workflow is incomplete and the developer still has to manually handle M4L conventions.

### TS-1: Device Type Scaffold (audio_effect / instrument / midi_effect)

| Aspect | Detail |
|--------|--------|
| **Why expected** | Every M4L device starts with identical boilerplate. Three device types have three distinct structures. A framework that claims M4L support must handle this automatically. |
| **What it does** | Given a device type, scaffold the correct signal/MIDI chain: **audio_effect** = plugin~ -> processing -> plugout~ (stereo); **instrument** = midiin + midiout passthrough + notein/stripnote -> synthesis -> plugout~; **midi_effect** = midiin -> processing -> midiout (no audio I/O). All three get: live.thisdevice, openinpresentation=1, devicewidth. |
| **Complexity** | Medium |
| **Dependencies** | Existing Patcher API (add_box, add_connection). Needs new convenience method or template. |
| **Notes** | Instrument devices MUST pass all unprocessed MIDI downstream via midiin->midiout. Audio limited to 2 channels. MIDI effects receive on channel 1 by default. |

### TS-2: Automatic parameter_enable on live.* UI Controls

| Aspect | Detail |
|--------|--------|
| **Why expected** | Every live.dial, live.slider, live.numbox, live.toggle, live.button, live.menu, live.tab used as a user-facing control needs `parameter_enable: 1` plus a `saved_attribute_attributes.valueof` block with at minimum `parameter_longname` and `parameter_shortname`. Without this, the control is invisible to Ableton's automation, MIDI mapping, and preset systems. |
| **What it does** | When a live.* UI object is added to an M4L device, automatically set `parameter_enable: 1` and generate a `saved_attribute_attributes` block with sensible defaults for parameter_longname (full name), parameter_shortname (abbreviated), parameter_type, parameter_mmin/mmax, parameter_initial, and parameter_unitstyle. |
| **Complexity** | Medium |
| **Dependencies** | Patcher.add_box() already sets parameter_enable=0 on UI objects. Needs to detect M4L context and flip to 1 with full parameter metadata. |
| **Notes** | parameter_longname must be unique across the entire device. parameter_shortname is typically 5-7 chars max (truncation risk). parameter_initial_enable should be 1 by default so controls restore correctly. |

### TS-3: Presentation Mode Setup

| Aspect | Detail |
|--------|--------|
| **Why expected** | Presentation mode IS the M4L device UI. In Ableton, users only see the presentation view. The patcher attribute `openinpresentation: 1` must be set, and every user-facing control needs `presentation: 1` with a `presentation_rect`. |
| **What it does** | Set top-level patcher `openinpresentation: 1`. Set `devicewidth` to the specified or default width. Set `presentation: 1` and appropriate `presentation_rect` on all user-facing objects. Height is always 169px (Ableton constraint). |
| **Complexity** | Low |
| **Dependencies** | Box already has `presentation` and `presentation_rect` fields. Patcher defaults already include `openinpresentation`. |
| **Notes** | All coordinates in presentation_rect must be whole pixels (not decimals like 4.356) to avoid blurry rendering. The kicksynth-m4l already uses integer coords throughout -- this should be enforced. |

### TS-4: No gain~ Before plugout~ Rule

| Aspect | Detail |
|--------|--------|
| **Why expected** | Ableton's channel strip handles volume. Adding gain~ before plugout~ creates double-volume-control confusion and can cause level issues. This is already documented in project memory (feedback_m4l_no_gain.md) but not enforced by any critic. |
| **What it does** | Critic check that detects gain~ objects connected (directly or through a short chain) to plugout~ and flags them as errors. The correct pattern is signal -> plugout~ directly, or signal -> *~ (for mixing/panning, not volume) -> plugout~. |
| **Complexity** | Low |
| **Dependencies** | DSP critic infrastructure exists. Needs M4L-specific check added. |
| **Notes** | live.gain~ is also suspect before plugout~ in most cases, though some devices use it for input gain staging. Critic should warn, not error, on live.gain~. |

### TS-5: Device Completeness Validation

| Aspect | Detail |
|--------|--------|
| **Why expected** | An M4L device missing plugout~ won't produce audio. One missing midiin won't receive MIDI. One missing live.thisdevice won't initialize properly. These are structural requirements, not style preferences. |
| **What it does** | Validate that a device has the minimum required objects for its type: **audio_effect** must have plugout~ (plugin~ optional -- passthrough if absent); **instrument** must have midiin, midiout, and plugout~; **midi_effect** must have midiin and midiout. All types should have live.thisdevice. Warn if parameter_enable is missing on any live.* control. |
| **Complexity** | Medium |
| **Dependencies** | Needs device type detection (TS-8) to know which checks to run. |
| **Notes** | plugin~ is NOT required for audio effects -- if absent, Ableton passes audio through the device's processing chain automatically via plugout~. But plugout~ IS required. |

### TS-6: Local Naming Convention (--- Prefix)

| Aspect | Detail |
|--------|--------|
| **Why expected** | Multiple instances of the same M4L device on different tracks share a global namespace for buffer~, coll, send/receive, and value objects. Without the `---` prefix, instance 2 stomps on instance 1's data. This is the single most common M4L bug for shared devices. |
| **What it does** | When generating named objects (buffer~, coll, dict, send, receive, send~, receive~, value) inside an M4L device, automatically prefix names with `---` so Ableton's runtime replaces them with per-instance unique IDs. Warn if any named object lacks the prefix in M4L context. |
| **Complexity** | Low |
| **Dependencies** | None. String-level transformation on object arguments. |
| **Notes** | The `---` prefix is M4L-specific -- it has NO effect in standalone MAX. It is replaced at runtime with a 3-digit unique number. Only applies to named objects, not to parameter longnames or shortnames. |

### TS-7: M4L Dispatch and Agent Routing

| Aspect | Detail |
|--------|--------|
| **Why expected** | The router needs to recognize M4L tasks and inject M4L-specific context into agent prompts. Without this, agents build generic MAX patches and miss all M4L conventions. |
| **What it does** | Add M4L keywords to dispatch rules: "Max for Live", "M4L", "Ableton", "Live device", "audio effect", "instrument", "MIDI effect", "plugin~", "plugout~". Route to DSP + UI + M4L-specific instructions. Agent SKILL.md files get M4L sections. |
| **Complexity** | Low |
| **Dependencies** | Router infrastructure exists. Small config changes. |
| **Notes** | The kicksynth-m4l was built without any M4L routing -- the developer had to manually supply all M4L knowledge. This is the primary workflow bottleneck. |

### TS-8: Device Type Detection

| Aspect | Detail |
|--------|--------|
| **Why expected** | When loading an existing M4L device for iteration, the framework must detect its type to apply correct validation rules. |
| **What it does** | Analyze a patch to determine device type: has plugout~ + no midiin = audio_effect; has midiin + midiout + plugout~ = instrument; has midiin + midiout + no plugout~ = midi_effect. Report device type in analysis output and use it to gate critic checks. |
| **Complexity** | Low |
| **Dependencies** | analysis.py infrastructure exists. Needs new detection method. |
| **Notes** | Edge case: some instrument devices use both plugin~ (sidechain input) and plugout~. The presence of midiin/midiout is the true instrument/midi_effect indicator. |

### TS-9: .amxd Export

| Aspect | Detail |
|--------|--------|
| **Why expected** | M4L devices are loaded in Ableton as .amxd files. Without export, every device requires manual conversion. |
| **What it does** | Write a .amxd file from the same JSON used for .maxpat. The .amxd format is a 32-byte fixed binary header + the identical JSON payload. Header encodes device type: `b"aaaa"` = audio_effect, `b"iiii"` = instrument, `b"mmmm"` = midi_effect. Implementation is ~15 lines of Python using `struct.pack`. |
| **Complexity** | Low |
| **Dependencies** | TS-8 (device type detection) to auto-determine which header to write. |
| **Notes** | Previously classified as anti-feature (AF-1) due to "partially opaque format." Stack research fully reverse-engineered the format from kicksynth-m4l.amxd: magic `"ampf"` + version(4) + device_type(4 chars) + `"meta"` + meta_size(4) + 4 zero bytes + `"ptch"` + json_size(4) + JSON. Verified: JSON is byte-for-byte identical between .maxpat and .amxd. This is trivial to implement and should ship in v3.0. Only covers unfrozen (development) devices -- freezing is done in Live. |

---

## Differentiators

Features that set the framework apart from manual M4L development. Not strictly required, but make the framework significantly more valuable for M4L work.

### DF-1: Intelligent Presentation Layout Engine

| Aspect | Detail |
|--------|--------|
| **Value proposition** | Professional M4L devices have carefully organized presentation layouts: controls grouped by function, consistent spacing, labels, sections. The current grid fallback (4-per-row) produces unusable layouts. An intelligent layout engine that understands M4L conventions would be a significant time-saver. |
| **What it does** | Given a set of UI controls with semantic grouping hints (section names, functional groups), produce a presentation layout that follows M4L conventions: tab bar at top (full width), control groups in rows of related parameters, meters/scopes on the right edge, section labels above groups, consistent 169px height constraint. Support common patterns: tabbed views, overlay views, single-page layouts. |
| **Complexity** | High |
| **Dependencies** | TS-3 (presentation setup). Needs control classification by function. |
| **Notes** | Three common layout patterns in professional M4L devices: (1) Single page -- all controls visible, works for simple effects with fewer than 15 parameters; (2) Tabbed -- live.tab at top, visibility controlled by tab selection, works for complex devices with 15+ parameters (kicksynth pattern); (3) Overlay -- secondary panel toggles on/off for advanced settings. The devicewidth varies but common values are 614px (kicksynth), ~320px (simple utilities), ~900px+ (complex instruments). |

### DF-2: Parameter Naming Intelligence

| Aspect | Detail |
|--------|--------|
| **Value proposition** | Good parameter naming makes devices feel native. Bad naming (default "live.dial[1]") makes devices feel amateur. Automatically generating meaningful parameter_longname ("Filter Cutoff"), parameter_shortname ("Cutoff"), and matching varname ("filter_cutoff") from context saves significant manual configuration. |
| **What it does** | When the developer specifies a parameter name (e.g., "Filter Cutoff"), automatically derive: parameter_longname = "Filter Cutoff", parameter_shortname = "Cutoff" (or "F.Cut" if too long), varname = "d_filter_cutoff" (prefixed for namespace), parameter_unitstyle from context (Hz for frequency, ms for time, % for mix/level, dB for gain). |
| **Complexity** | Medium |
| **Dependencies** | TS-2 (parameter_enable automation). |
| **Notes** | Ableton truncates shortnames to roughly 5-7 characters. The kicksynth uses abbreviated prefixes: "P.Start" for "Pitch Start", "A.Decay" for "Amp Decay". This pattern should be codified. |

### DF-3: Push Controller Bank Organization

| Aspect | Detail |
|--------|--------|
| **Value proposition** | Professional M4L devices work seamlessly with Ableton Push. Parameters appear on Push in organized banks with descriptive names ("Envelope", "Filter", "Osc") rather than generic "Bank 1", "Bank 2". |
| **What it does** | Generate a live.banks object configuration that maps parameters to Push banks by functional group. Bank names derived from parameter grouping (same groups used for presentation layout). 8 parameters per bank (Push constraint). |
| **Complexity** | Medium |
| **Dependencies** | DF-2 (parameter naming, grouping). |
| **Notes** | live.banks is already in the M4L object database. The object accepts bank definitions via attributes. Not all devices need Push support, but professional ones do. |

### DF-4: Info Text / Annotations

| Aspect | Detail |
|--------|--------|
| **Value proposition** | Professional Ableton devices show descriptive tooltips in Live's Info View when hovering over controls. This is the "Annotation" and "Annotation Name" attributes on live.* objects. Adding these automatically from parameter descriptions elevates device polish significantly. |
| **What it does** | When generating live.* controls, populate the Annotation attribute with a description of what the control does. Populate Annotation Name with the parameter's display name. These appear in Ableton's Info View pane. |
| **Complexity** | Low |
| **Dependencies** | TS-2 (parameter system). |
| **Notes** | The M4L Production Guidelines explicitly call this out as a quality marker. Most amateur devices omit annotations entirely. |

### DF-5: M4L Object Relationships in Database

| Aspect | Detail |
|--------|--------|
| **Value proposition** | The relationships.json file informs agents about common object pairings. Currently has zero M4L entries. Adding M4L relationships means agents automatically suggest companion objects -- when plugin~ is used, suggest plugout~; when live.path is used, suggest live.object; when midiin is used, suggest midiout. |
| **What it does** | Add M4L relationship entries: plugin~/plugout~ (required_pair), midiin/midiout (required_pair in M4L), live.thisdevice standalone, live.path/live.object/live.observer (api_chain), live.dial/prepend (common_pair for gen~ param routing). |
| **Complexity** | Low |
| **Dependencies** | None -- data-only change to relationships.json. |
| **Notes** | The kicksynth pattern of live.dial -> prepend "param_name" -> gen~ is the dominant parameter routing pattern for gen~-based devices. This should be a documented relationship. |

### DF-6: Missing M4L Objects in Database

| Aspect | Detail |
|--------|--------|
| **Value proposition** | Rule #1 (Never Guess Objects) blocks agents from using objects not in the DB. live.adsrui (envelope editor), live.adsr~ (envelope generator), and live.scope~ (in wrong domain) are real M4L objects that agents cannot use. |
| **What it does** | Add live.adsrui and live.adsr~ to m4l/objects.json with verified I/O counts, arguments, and attributes. Move live.scope~ categorization to M4L domain (it's currently in packages/). |
| **Complexity** | Low |
| **Dependencies** | None -- data-only changes. |
| **Notes** | live.scope~ is already in UI_SIZES (131x131) and UI_MAXCLASSES. Just needs domain correction in the JSON. live.adsrui and live.adsr~ need full entries with inlet/outlet verification. |

---

## Anti-Features

Features to explicitly NOT build in v3.0. These are tempting but premature, out of scope, or actively harmful.

### AF-1: Live API Automation (live.path / live.object Chains)

| Anti-Feature | Why Avoid | What to Do Instead |
|--------------|-----------|-------------------|
| Automated generation of Live API query chains (live.path -> live.object -> live.observer) for controlling Ableton parameters | The Live API is vast and contextual. Generating correct path strings ("live_set tracks 0 mixer_device volume") requires deep knowledge of the Ableton object model. Getting paths wrong causes silent failures. This is advanced M4L territory best left to manual patching. | Document live.path/live.object/live.observer as available objects in the DB. Add relationship entries. Let agents suggest them but don't auto-generate path strings. |

### AF-2: Modulator Device Type

| Anti-Feature | Why Avoid | What to Do Instead |
|--------------|-----------|-------------------|
| Full support for modulator devices (LFO, Envelope Follower style) | Modulators have a unique "Map" button paradigm and control surface integration that differs significantly from the three standard device types. The mapping system uses internal APIs not well-documented for custom creation. Very few users create custom modulators vs effects/instruments. | Support the three standard types (audio_effect, instrument, midi_effect) first. Add modulator as a future milestone if demand emerges. |

### AF-3: Automatic Latency Compensation Declaration

| Anti-Feature | Why Avoid | What to Do Instead |
|--------------|-----------|-------------------|
| Automatically calculating and setting device latency in the patcher inspector | Latency depends on the specific DSP algorithms used (FFT-based processing, lookahead limiters, etc.) and cannot be reliably determined from patch structure alone. An incorrect latency declaration is worse than none. | Document latency as a manual step in device finalization. The Patcher Inspector's "Defined Latency" attribute is a single number in samples -- easy for the developer to set after testing. |

### AF-4: Cross-Platform Testing (Windows/Push 3 Standalone)

| Anti-Feature | Why Avoid | What to Do Instead |
|--------------|-----------|-------------------|
| Automated testing on multiple platforms | The framework runs on macOS and generates .maxpat JSON files. Platform-specific issues (font rendering, external compatibility) can only be caught by running the device in Live on each platform, which is outside the framework's scope. | Note in the production checklist that devices should be tested on target platforms. Focus on generating structurally correct .maxpat files that are platform-agnostic. |

### AF-5: Frozen Device Export

| Anti-Feature | Why Avoid | What to Do Instead |
|--------------|-----------|-------------------|
| Exporting frozen .amxd files that bundle all dependencies | Frozen devices consolidate abstractions, audio files, externals into a single file. This requires Live's internal freeze process and is not documented for external tooling. | Export unfrozen .amxd files (TS-9). Document that freezing is done in Live via File > Freeze Device. |

---

## Feature Dependencies

```
TS-8 (Device Type Detection)
  |
  v
TS-5 (Device Completeness Validation) --> TS-4 (No gain~ Before plugout~)
  ^
  |
TS-1 (Device Type Scaffold)
  |
  +---> TS-3 (Presentation Mode Setup)
  |       |
  |       v
  |     DF-1 (Intelligent Presentation Layout)
  |
  +---> TS-2 (Automatic parameter_enable)
  |       |
  |       v
  |     DF-2 (Parameter Naming Intelligence) --> DF-3 (Push Banks)
  |       |
  |       v
  |     DF-4 (Info Text / Annotations)
  |
  +---> TS-6 (Local Naming Convention)
  |
  +---> TS-9 (.amxd Export) -- depends on TS-8 for device type

TS-7 (M4L Dispatch) -- independent, no deps
DF-5 (Relationships) -- independent, no deps
DF-6 (Missing Objects) -- independent, no deps
```

---

## Parameter System Reference

Derived from official Cycling 74 documentation and verified against kicksynth-m4l ground truth.

### parameter_type Values

| Code | Type | Description | Range |
|------|------|-------------|-------|
| 0 | Float | Floating point values | Unrestricted (use parameter_mmin/mmax) |
| 1 | Int | Integer values | 0-255 max range |
| 2 | Enum | Enumerated list | Set via parameter_enum array |
| 3 | Blob | Non-automatable data | Preset storage only |

### parameter_unitstyle Values

Derived from kicksynth-m4l evidence and official documentation:

| Code | Style | Display | Used When |
|------|-------|---------|-----------|
| 0 | Int | "42" | Integer display |
| 1 | Float | "0.50" | Generic float, percentage-like (0-1 range) |
| 2 | Time | "200 ms" | Time values in milliseconds |
| 3 | Hertz | "440 Hz" / "1.2 kHz" | Frequency values |
| 4 | deciBel | "-6.0 dB" | Gain, loudness |
| 5 | Percentage | "50%" | Percentage display |
| 6 | Pan | "50L" / "C" / "50R" | Pan position |
| 7 | Semitones | "7 st" | Musical intervals |
| 8 | MIDI | "C3" / "A4" | MIDI note names |
| 9 | Custom | user-defined | sprintf-style format strings |
| 10 | Native | float default | Default float display |

### parameter_modmode Values

| Code | Mode | Description |
|------|------|-------------|
| 0 | Off | No modulation |
| 1 | Unipolar | Modulates between min and current value |
| 2 | Bipolar | +/- distance from current to nearest boundary |
| 3 | Additive | +/- half of total range |
| 4 | Absolute | Current value as upper or lower bound |

### Parameter Visibility

| Setting | Automation | Preset Storage |
|---------|-----------|----------------|
| Automated and Stored | Yes | Yes |
| Stored Only | No | Yes |
| Hidden | No | No |

---

## Device Type Structure Reference

### audio_effect

```
Required:  plugout~ (stereo, 2 channels)
Optional:  plugin~ (if processing input; omit for generators that happen to be effects)
Patcher:   openinpresentation: 1, devicewidth: <width>
Init:      live.thisdevice -> bang on load
Chain:     plugin~ -> [processing] -> plugout~
```

### instrument

```
Required:  midiin, midiout, plugout~
Optional:  plugin~ (sidechain input)
Patcher:   openinpresentation: 1, devicewidth: <width>
Init:      live.thisdevice -> bang on load
MIDI:      midiin -> midiout (passthrough ALL unprocessed MIDI)
           notein/stripnote for note processing
Chain:     MIDI -> [synthesis] -> plugout~
```

### midi_effect

```
Required:  midiin, midiout
Forbidden: plugout~, plugin~ (no audio I/O)
Patcher:   openinpresentation: 1, devicewidth: <width>
Init:      live.thisdevice -> bang on load
MIDI:      midiin -> [processing] -> midiout
           Use midiselect for selective filtering
```

### Common to All Types

- `openinpresentation: 1` in patcher attributes
- `devicewidth` set to a fixed pixel value
- `live.thisdevice` for initialization bang
- All live.* UI controls with `parameter_enable: 1`
- `---` prefix on all named objects (buffer~, send, receive, coll, dict, value)
- Presentation height fixed at 169px by Ableton
- Whole-pixel coordinates in presentation_rect
- No send~/receive~ between M4L devices (not supported)

---

## Presentation Layout Conventions

### Common Widths (from professional M4L devices)

| Device Complexity | Width | Example |
|-------------------|-------|---------|
| Simple utility | ~320px | Single-knob effects, MIDI filters |
| Standard effect | ~614px | Kicksynth, standard EQ/compressor |
| Complex instrument | ~900px+ | Multi-oscillator synths, samplers |

### Layout Patterns

**Pattern 1: Single Page**
- All controls visible simultaneously
- Best for: fewer than 15 parameters
- Layout: rows of related controls, labels above groups
- Meters/scopes on right edge

**Pattern 2: Tabbed (kicksynth pattern)**
- live.tab spanning full device width at top (y=0, height=20px)
- Tab names = functional sections ("Body", "Sub+Noise", "Click", "Master")
- Controls per tab shown/hidden via scripting (thispatcher + js tab-controller)
- Each tab's controls positioned at same y-offset (y=30px after tab bar)
- Scope/visualization on dedicated tab

**Pattern 3: Overlay**
- Primary view always visible
- Toggle button reveals secondary panel (advanced settings)
- Overlay covers full device area
- Good for: devices with primary + advanced parameter sets

### Standard Spacing

| Element | Value | Notes |
|---------|-------|-------|
| Tab bar height | 20px | live.tab at y=0, full devicewidth |
| Content area top | 20-30px | Below tab bar or device top |
| live.dial size | 50x48px | Standard, can resize |
| live.slider width | 40-50px | Vertical orientation typical |
| Horizontal gap between controls | 10-20px | Within a group |
| Group gap | 30-40px | Between functional groups |
| Meter/scope placement | Right edge | Typically 140px wide |
| Bottom margin | ~5px | 169px height constraint |

---

## MVP Recommendation

### Phase 1: Foundation (must-have for any M4L device)

Prioritize in this order:

1. **TS-1: Device Type Scaffold** -- Eliminates manual boilerplate, the single biggest friction point
2. **TS-7: M4L Dispatch** -- Makes agents aware of M4L context (zero-dependency, small change)
3. **TS-6: Local Naming Convention** -- Prevents the most common M4L bug (instance collision)
4. **TS-2: Automatic parameter_enable** -- Ensures controls are automatable in Live
5. **TS-3: Presentation Mode Setup** -- Ensures device renders correctly in Live

### Phase 2: Quality (validation and correctness)

6. **TS-8: Device Type Detection** -- Required by critics and .amxd export
7. **TS-5: Device Completeness Validation** -- Catches missing required objects
8. **TS-4: No gain~ Before plugout~** -- Catches the documented gotcha
9. **TS-9: .amxd Export** -- Trivial (15 LOC), completes the device creation loop
10. **DF-5: Relationships** -- Small data change, improves agent suggestions
11. **DF-6: Missing Objects** -- Small data change, unblocks ADSR devices

### Phase 3: Polish (differentiators)

12. **DF-2: Parameter Naming Intelligence** -- Better automation names
13. **DF-4: Info Text / Annotations** -- Professional tooltips
14. **DF-1: Intelligent Presentation Layout** -- The big one; defer until more devices built
15. **DF-3: Push Banks** -- Nice-to-have for professional distribution

### Defer Indefinitely

- AF-1: Live API automation (too complex, too contextual)
- AF-2: Modulator device type (insufficient demand signal)
- AF-5: Frozen device export (requires Live's internal freeze process)

---

## Sources

- [Cycling 74: User Interfaces in Max for Live](https://docs.cycling74.com/userguide/m4l/live_userinterfaces/) -- Device dimensions, presentation mode workflow
- [Cycling 74: Device Parameters in Max for Live](https://docs.cycling74.com/userguide/m4l/live_parameters/) -- Parameter types, naming, modulation
- [Cycling 74: Creating Audio Effect Devices](https://docs.cycling74.com/userguide/m4l/live_audiodevices/) -- plugin~/plugout~ requirements
- [Cycling 74: Creating MIDI Effects](https://docs.cycling74.com/userguide/m4l/live_midieffects/) -- midiin/midiout requirements, midiselect
- [Ableton M4L Production Guidelines (GitHub)](https://github.com/Ableton/maxdevtools/blob/main/m4l-production-guidelines/m4l-production-guidelines.md) -- Professional quality standards, --- naming, annotations, pixel-perfect layout
- [Cycling 74: live.thisdevice Reference](https://docs.cycling74.com/legacy/max8/refpages/live.thisdevice) -- Initialization bang, enable/disable outlets
- [Ableton Reference Manual: Max for Live](https://www.ableton.com/en/manual/max-for-live/) -- Device types, browser organization
- [Cycling 74 Forum: .amxd file format](https://cycling74.com/forums/max-for-live-device-file-format) -- Community format analysis
- [Cycling 74 Forum: amxd type conversion](https://cycling74.com/forums/amxd-midi-effect-to-audio-effect) -- Device type bytes in .amxd header
- Kicksynth-m4l.maxpat + kicksynth-m4l.amxd ground truth (local) -- Verified parameter system, .amxd binary format
