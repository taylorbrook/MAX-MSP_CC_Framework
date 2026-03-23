# UI Presets Reference

Standardized control appearance derived from rhythmic-sampler dial patterns. All agents generating UI controls should follow these presets for visual consistency.

## Dial Preset

Exact JSON attributes for dial objects:

```json
{
  "box": {
    "maxclass": "dial",
    "numinlets": 1,
    "numoutlets": 1,
    "outlettype": [""],
    "parameter_enable": 0,
    "patching_rect": [X, Y, 40.0, 40.0],
    "presentation": 1,
    "presentation_rect": [X, Y, 55.0, 55.0],
    "varname": "descriptive_name_dial"
  }
}
```

**Key values:**
- Patching mode size: **40x40px**
- Presentation mode size: **55x55px**
- `parameter_enable`: 0 (no automation/parameter system)
- Always include `varname` with descriptive `_dial` suffix
- Always set both `presentation: 1` and explicit `presentation_rect`
- Output range: 0-127 (default dial behavior)

## Scale Chain Presets

Standard mappings from dial output (0-127) to parameter ranges:

| Parameter Type | Scale Text | Output Range | Example Use |
|----------------|-----------|--------------|-------------|
| Frequency (Hz) | `scale 0 127 20. 20000.` | 20-20000 | Filter cutoff |
| Normalized 0-1 | `scale 0 127 0. 1.` | 0.0-1.0 | Volume, resonance, mix |
| Gain (dB) | `scale 0 127 -70. 6.` | -70 to +6 | Level meter range |
| Time (ms) | `scale 0 127 1. 5000.` | 1-5000 | Delay, attack, release |
| Pitch (semitones) | `expr pow(2., $f1 / 12.)` | Ratio | Pitch shift |
| Percentage | `scale 0 127 0. 100.` | 0-100 | Dry/wet, feedback |
| Detune (cents) | `scale 0 127 -100. 100.` | -100 to +100 | Fine tuning |

**Pattern:** `dial` (0-127) -> `scale 0 127 min max` -> parameter inlet

## Number Display Preset

Readout box for showing mapped parameter value:

```json
{
  "box": {
    "maxclass": "number",
    "numinlets": 1,
    "numoutlets": 2,
    "outlettype": ["", "bang"],
    "patching_rect": [X, Y, 50.0, 22.0],
    "presentation": 1,
    "presentation_rect": [X, Y, 100.0, 22.0]
  }
}
```

- Patching: **50x22px**
- Presentation: **100x22px**
- Connected AFTER the scale object (shows mapped value, not raw 0-127)
- Always set `presentation: 1`

## Presentation Layout Grid

Consistent dial layout using 60px horizontal column spacing:

| Column | X Position |
|--------|-----------|
| 1 | 5 |
| 2 | 65 |
| 3 | 125 |
| 4 | 185 |
| 5 | 245 |
| 6 | 305 |

**Vertical spacing:** 80px per row (55px dial + 25px gap for label below)

**Labels:** Comment objects placed below each dial with parameter name.

## Toggle/Button Presets

### Toggle
```json
{
  "box": {
    "maxclass": "toggle",
    "numinlets": 1,
    "numoutlets": 1,
    "outlettype": ["int"],
    "parameter_enable": 0,
    "patching_rect": [X, Y, 20.0, 20.0],
    "presentation": 1,
    "presentation_rect": [X, Y, 30.0, 30.0]
  }
}
```

### Button
```json
{
  "box": {
    "maxclass": "button",
    "numinlets": 1,
    "numoutlets": 1,
    "outlettype": ["bang"],
    "parameter_enable": 0,
    "patching_rect": [X, Y, 20.0, 20.0],
    "presentation": 1,
    "presentation_rect": [X, Y, 30.0, 30.0]
  }
}
```

## Complete Dial Chain Example

A typical dial-to-parameter chain for filter cutoff:

```
dial (40x40, presentation 55x55, varname "cutoff_dial")
  |
scale 0 127 20. 20000.
  |
  +---> number (50x22, presentation 100x22)
  |
  +---> gen~ param message: "cutoff $1"
```
