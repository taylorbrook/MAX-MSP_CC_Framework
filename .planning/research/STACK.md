# Technology Stack: M4L Device Creation

**Project:** MaxSystem v3.0 -- M4L Device Creation
**Researched:** 2026-04-05
**Scope:** Stack additions/changes for M4L device authoring features ONLY

## Existing Stack (NOT changing)

Python framework, 2,015-object knowledge base, Patcher API, 4-layer validation, 6 specialist agents. All validated.

## New Stack Additions

### No new libraries or dependencies needed.

The M4L device creation feature is entirely achievable with the existing Python + JSON stack. All additions are data structures, constants, and format knowledge -- not new technology.

## M4L Parameter System

### Data Structures Required

The M4L parameter system is the core new domain knowledge. Every `live.*` UI object requires `saved_attribute_attributes.valueof` in its box dict for Ableton automation.

**Ground truth structure** (from kicksynth-m4l.maxpat, verified working in Live):

```json
{
    "box": {
        "maxclass": "live.dial",
        "id": "obj-17",
        "numinlets": 1,
        "numoutlets": 2,
        "outlettype": ["", "float"],
        "parameter_enable": 1,
        "presentation": 1,
        "presentation_rect": [50.0, 30.0, 50.0, 48.0],
        "hidden": 1,
        "patching_rect": [300.0, 400.0, 50.0, 48.0],
        "saved_attribute_attributes": {
            "valueof": {
                "parameter_longname": "Pitch Start",
                "parameter_shortname": "P.Start",
                "parameter_type": 0,
                "parameter_unitstyle": 3,
                "parameter_mmin": 50.0,
                "parameter_mmax": 1000.0,
                "parameter_initial": [300.0],
                "parameter_initial_enable": 1,
                "parameter_modmode": 0
            }
        },
        "varname": "d_pitch_start"
    }
}
```

### parameter_type Enum (HIGH confidence -- verified from ground truth + official docs)

| Value | Type | Notes |
|-------|------|-------|
| 0 | Float | Continuous values. M4L restricts Int to 0-255, so use Float + unitstyle=Int for wider integer ranges. |
| 1 | Int | Integer values, 0-255 range in M4L. |
| 2 | Enum | Enumerated list. Requires `parameter_enum` array. `parameter_mmax` = count - 1. |
| 3 | Blob | Non-automatable. Preset storage only. Rare. |

### parameter_unitstyle Enum (HIGH confidence -- verified against ground truth)

Cross-referenced official docs listing order with kicksynth-m4l parameter values:
- ustyle=1 used for generic float ratios (0.01-1.0) = Float
- ustyle=2 used for decay times = Time (ms)
- ustyle=3 used for frequencies = Hertz (Hz)
- ustyle=4 used for gain values = deciBel (dB)
- ustyle=9 used for live.tab with enum items = Custom

| Value | Unit Style | Display | Verified |
|-------|------------|---------|----------|
| 0 | Int | "42" | from docs order |
| 1 | Float | "0.50" | ground truth (Body Level, Amp Curve) |
| 2 | Time | "100 ms" | ground truth (Pitch Decay, Amp Decay) |
| 3 | Hertz | "440 Hz" | ground truth (Pitch Start, Noise Tone) |
| 4 | deciBel | "-6 dB" | ground truth (EQ Low Gain, Limiter Ceiling) |
| 5 | Percentage | "50%" | from docs order |
| 6 | Pan | "L/R" | from docs order |
| 7 | Semitones | "3 st" | from docs order |
| 8 | MIDI | "C4" | from docs order |
| 9 | Custom | user-defined | ground truth (live.tab enum display) |
| 10 | Native | default float | from docs order |

### parameter_modmode Enum (MEDIUM confidence -- 0=None verified, rest from docs)

| Value | Mode | Use Case |
|-------|------|----------|
| 0 | None | No clip modulation. Default. |
| 1 | Unipolar | 0-100% modulation range. |
| 2 | Bipolar | -50% to +50%. Recommended for Float params. |
| 3 | Additive | Like bipolar but clips at limits. |
| 4 | Absolute | Fixed unit-based modulation. Recommended for Int params. |

### parameter_visibility (MEDIUM confidence -- from docs, not in ground truth)

| Value | Mode | Notes |
|-------|------|-------|
| 0 | Automated and Stored | Default. Appears in Live automation lanes. |
| 1 | Stored Only | Saved in presets, not automatable. Multi-value supported. |
| 2 | Hidden | Internal use only. Not exposed to Live. |

### Complete valueof Attribute Set

| Attribute | Type | Required | Notes |
|-----------|------|----------|-------|
| `parameter_longname` | string | YES | Unique within device. Used for automation lane names. |
| `parameter_shortname` | string | YES | Display label on the control. Keep concise. |
| `parameter_type` | int | YES | See enum above. |
| `parameter_unitstyle` | int | YES | See enum above. |
| `parameter_mmin` | float | NO | Minimum value. Default 0.0. |
| `parameter_mmax` | float | NO | Maximum value. Default 1.0 (Float) or 127.0 (Int). |
| `parameter_initial` | [float] | NO | Initial value as single-element array. |
| `parameter_initial_enable` | int | NO | 1 to enable initial value recall. |
| `parameter_modmode` | int | NO | See enum above. Default 0. |
| `parameter_enum` | [string] | Enum only | List of enum item names. Required when type=2. |
| `parameter_steps` | int | NO | Number of discrete steps. |
| `parameter_exponent` | float | NO | Exponential scaling factor. |
| `parameter_modrange` | [float] | NO | Modulation range bounds. |
| `parameter_invisible` | int | NO | 1 to hide from automation. |

### Patcher-Level Parameters Dict

M4L patches include a `parameters` key at patcher level mapping box IDs to parameter metadata:

```json
{
    "patcher": {
        "parameters": {
            "obj-17": ["Pitch Start", "P.Start", 0],
            "obj-19": ["Pitch End", "P.End", 0],
            "parameterbanks": {
                "0": {
                    "index": 0,
                    "name": "",
                    "parameters": ["-", "-", "-", "-", "-", "-", "-", "-"],
                    "buttons": ["-", "-", "-", "-", "-", "-", "-", "-"]
                }
            },
            "inherited_shortname": 1
        }
    }
}
```

Format: `"obj-ID": ["longname", "shortname", initial_value]`

The `parameterbanks` sub-object configures Push controller bank mappings (8 params + 8 buttons per bank).

### How This Maps to Existing API

All parameter metadata flows through the existing `Box.extra_attrs` mechanism:

```python
dial = p.add_box("live.dial")
dial.extra_attrs["parameter_enable"] = 1
dial.extra_attrs["varname"] = "d_pitch_start"
dial.extra_attrs["saved_attribute_attributes"] = {
    "valueof": {
        "parameter_longname": "Pitch Start",
        "parameter_shortname": "P.Start",
        "parameter_type": 0,
        "parameter_unitstyle": 3,
        "parameter_mmin": 50.0,
        "parameter_mmax": 1000.0,
        "parameter_initial": [300.0],
        "parameter_initial_enable": 1,
        "parameter_modmode": 0,
    }
}
```

**Recommendation:** Add a convenience method rather than a new Box attribute:

```python
dial = p.add_box("live.dial")
p.configure_m4l_parameter(dial,
    longname="Pitch Start",
    shortname="P.Start",
    param_type=ParamType.FLOAT,
    unitstyle=UnitStyle.HERTZ,
    min_val=50.0,
    max_val=1000.0,
    initial=300.0,
)
```

This keeps Box clean and puts M4L-specific logic in a dedicated helper.

## .amxd File Format

### Structure (HIGH confidence -- reverse-engineered from ground truth)

The .amxd format is a trivial binary envelope around the same JSON as a .maxpat:

```
Offset  Size  Content
0       4     Magic: "ampf" (ASCII)
4       4     Version: uint32le, always 4
8       4     Device type: "iiii"=instrument, "aaaa"=audio_effect, "mmmm"=midi_effect
12      4     Meta tag: "meta" (ASCII)
16      4     Meta size: uint32le (always 4 in observed files)
20      4     Meta data: 4 zero bytes
24      4     Ptch tag: "ptch" (ASCII)
28      4     Ptch size: uint32le (byte count of JSON that follows)
32      N     Patch JSON: identical to .maxpat content, UTF-8 encoded
```

**Total header: 32 bytes.** JSON payload is byte-for-byte identical to the .maxpat file.

### Verified against kicksynth-m4l.amxd

- File size: 103,996 bytes (32 header + 103,964 JSON)
- Device type: `b"iiii"` = instrument (correct -- kicksynth has MIDI input via notein)
- JSON content: identical keys to the .maxpat file
- Loaded successfully in Ableton Live

### Implementation (trivial -- ~15 lines)

```python
import struct

DEVICE_TYPE_CODES = {
    "audio_effect": b"aaaa",
    "instrument": b"iiii",
    "midi_effect": b"mmmm",
}

def write_amxd(json_bytes: bytes, device_type: str, path: str) -> None:
    """Write a .amxd file from .maxpat JSON bytes."""
    header = b"ampf"
    header += struct.pack("<I", 4)                          # version
    header += DEVICE_TYPE_CODES[device_type]                # device type
    header += b"meta"
    header += struct.pack("<I", 4)                          # meta size
    header += b"\x00\x00\x00\x00"                          # meta data
    header += b"ptch"
    header += struct.pack("<I", len(json_bytes))            # patch size
    with open(path, "wb") as f:
        f.write(header + json_bytes)
```

**Verdict:** .amxd export is straightforward. NOT a future/deferred item -- can ship in v3.0.

### Checksum Concern

Forum posts mention a "checksum" in the .amxd header. Our analysis shows the meta block is just 4 zero bytes with no checksum. This may be a forum misunderstanding, or checksums may only appear in frozen devices created by Live's freeze process. Since we generate unfrozen devices, the simple format above is correct.

## Presentation Mode .maxpat Keys

### Patcher-Level Keys (already supported)

| Key | Value for M4L | Current Default | Change Needed |
|-----|---------------|-----------------|---------------|
| `openinpresentation` | 1 | 0 | Set to 1 for M4L devices |
| `devicewidth` | e.g. 614.0 | 0.0 | Set to device width in pixels |

Both already in `DEFAULT_PATCHER_PROPS` and directly accessible via `patcher.props["openinpresentation"] = 1`.

### Box-Level Keys (already supported)

| Key | Type | Notes |
|-----|------|-------|
| `presentation` | int (0/1) | Already a Box attribute: `box.presentation = True` |
| `presentation_rect` | [x, y, w, h] | Already a Box attribute: `box.presentation_rect = [...]` |
| `hidden` | int (0/1) | For tab-based visibility. Set via `extra_attrs["hidden"] = 1`. |

### Presentation Layout Guidelines (from Ableton M4L Production Guidelines)

| Guideline | Detail |
|-----------|--------|
| Whole pixels | Use integer coordinates for presentation_rect to avoid blurry rendering on non-retina |
| Minimize width | Reference similar existing devices as benchmarks |
| Dynamic colors | Use default live.* colors for theme compatibility |
| Ableton Sans | Use Ableton Sans font for native look |
| Tabbed UI | Reuse screen real estate with live.tab |
| Device width | Set via devicewidth patcher prop |

## What NOT to Add

### Do NOT add per-object parameter metadata to DB
`parameter_type`, `parameter_unitstyle` are per-instance, not per-class. A live.dial for frequency has unitstyle=3 (Hz); the same live.dial for gain has unitstyle=4 (dB). The object DB should NOT hardcode these.

### Do NOT create a LiveBox subclass
M4L boxes use the same Box class. Parameter metadata goes through `extra_attrs` and a convenience method. A subclass would fragment the API for no benefit.

### Do NOT implement frozen device export
Frozen .amxd files bundle all dependencies. This requires Live's internal freeze process. Our unfrozen .amxd export (32-byte header + JSON) is correct for development devices.

### Do NOT add Push bank auto-configuration
The `parameterbanks` structure is for Push controller mapping. Default to empty banks. Too device-specific to automate.

### Do NOT add parameter validation against Live's limits
Live accepts arbitrary parameter ranges. The 0-255 limit for Int type is a display limitation, not a hard constraint.

## Python Constants to Add

```python
# src/maxpat/m4l_constants.py

from enum import IntEnum

class DeviceType:
    AUDIO_EFFECT = "audio_effect"
    INSTRUMENT = "instrument"
    MIDI_EFFECT = "midi_effect"

class ParamType(IntEnum):
    FLOAT = 0
    INT = 1
    ENUM = 2
    BLOB = 3

class UnitStyle(IntEnum):
    INT = 0
    FLOAT = 1
    TIME = 2        # ms
    HERTZ = 3       # Hz
    DECIBEL = 4     # dB
    PERCENTAGE = 5  # %
    PAN = 6         # L/R
    SEMITONES = 7   # st
    MIDI = 8        # note names
    CUSTOM = 9      # user-defined
    NATIVE = 10     # default float

class ModMode(IntEnum):
    NONE = 0
    UNIPOLAR = 1
    BIPOLAR = 2
    ADDITIVE = 3
    ABSOLUTE = 4

class ParamVisibility(IntEnum):
    AUTOMATED_AND_STORED = 0
    STORED_ONLY = 1
    HIDDEN = 2

# .amxd binary header
AMXD_MAGIC = b"ampf"
AMXD_VERSION = 4
AMXD_DEVICE_TYPES = {
    DeviceType.AUDIO_EFFECT: b"aaaa",
    DeviceType.INSTRUMENT: b"iiii",
    DeviceType.MIDI_EFFECT: b"mmmm",
}
AMXD_META_TAG = b"meta"
AMXD_PTCH_TAG = b"ptch"
AMXD_META_DATA = b"\x00\x00\x00\x00"
AMXD_HEADER_SIZE = 32

# Default M4L patcher prop overrides
M4L_PATCHER_DEFAULTS = {
    "openinpresentation": 1,
}

# Device type detection patterns
DEVICE_TYPE_SIGNALS = {
    DeviceType.AUDIO_EFFECT: {
        "requires": ["plugin~", "plugout~"],
        "excludes": ["notein", "midiin"],
    },
    DeviceType.INSTRUMENT: {
        "requires": ["plugout~"],
        "optional": ["notein", "midiin", "plugin~"],
        "has_midi_input": True,
    },
    DeviceType.MIDI_EFFECT: {
        "requires": ["midiin", "midiout"],
        "excludes": ["plugin~", "plugout~"],
    },
}
```

## Alternatives Considered

| Category | Recommended | Alternative | Why Not |
|----------|-------------|-------------|---------|
| Parameter metadata | `extra_attrs` + convenience method | New Box attributes | Fragments API; parameters are M4L-specific |
| Parameter metadata | `extra_attrs` + convenience method | New LiveBox subclass | Over-engineering; same Box handles all types |
| .amxd export | Simple binary wrapper function | Use Live's freeze API | Freeze is for frozen devices; we make unfrozen dev devices |
| Parameter enums | Python IntEnum constants | Dict lookups | IntEnum is type-safe, readable, debuggable |
| M4L patcher defaults | Override `patcher.props` | New M4L Patcher subclass | Props dict is already the customization point |

## Sources

- kicksynth-m4l.maxpat -- ground truth M4L device (framework-generated, working in Live)
- kicksynth-m4l.amxd -- ground truth binary file (reverse-engineered format)
- [Device Parameters in Max for Live](https://docs.cycling74.com/userguide/m4l/live_parameters/) -- parameter system overview
- [Parameter Properties Reference (Max 5)](https://docs.cycling74.com/max5/refpages/m4l-ref/parameters.html) -- unitstyle/type listing
- [Parameter Mode](https://docs.cycling74.com/userguide/parameter_mode/) -- parameter_enable, visibility
- [M4L Production Guidelines](https://github.com/Ableton/maxdevtools/blob/main/m4l-production-guidelines/m4l-production-guidelines.md) -- Ableton's official device design guidelines
- [Cycling '74 Forum: .amxd file format](https://cycling74.com/forums/max-for-live-device-file-format) -- community format analysis
- [Cycling '74 Forum: amxd type conversion](https://cycling74.com/forums/amxd-midi-effect-to-audio-effect) -- device type bytes
