"""M4L constants for parameter types, unit styles, modulation modes, and AMXD format.

Pure data module -- IntEnum classes and named constants only.
Imported by scaffold (Phase 21), critic (Phase 22), and export (Phase 22) code.

Values verified against kicksynth-m4l.maxpat ground truth and Cycling 74 docs.
Ground-truth verified values noted; others from official documentation.
"""

from enum import IntEnum


class ParamType(IntEnum):
    """parameter_type values in saved_attribute_attributes.valueof.

    Controls how Ableton treats the parameter value.
    """
    INT = 0        # Integer values (0-255 range default)
    FLOAT = 1      # Floating point (no range restriction)
    ENUM = 2       # Enumerated list of items
    BLOB = 3       # Non-automatable, preset storage only


class UnitStyle(IntEnum):
    """parameter_unitstyle values -- controls display format in Ableton.

    Determines the unit label shown in automation lanes and device UI.
    Values 0-4 ground-truth verified; 5-8 from official docs ordering.
    """
    INT = 0        # Integer display
    FLOAT = 1      # Float display
    TIME = 2       # Milliseconds (ms)
    HERTZ = 3      # Frequency (Hz)
    DECIBEL = 4    # Decibels (dB)
    PERCENT = 5    # Percentage (%)
    PAN = 6        # Left/Right pan
    SEMITONES = 7  # Semitones for tuning
    MIDI = 8       # MIDI note numbers (0-127)
    CUSTOM = 9     # User-definable label


class ModMode(IntEnum):
    """parameter_modmode values -- modulation behavior in Ableton.

    Controls how modulators (LFO, Envelope Follower) affect the parameter.
    Only UNIPOLAR (0) ground-truth verified; others from docs.
    """
    UNIPOLAR = 0   # Modulation between min and current value
    BIPOLAR = 1    # Modulation range = 2x distance to nearest boundary
    ADDITIVE = 2   # +/- half of total range
    ABSOLUTE = 3   # Current value as upper/lower bound


class ParamVisibility(IntEnum):
    """parameter_visibility values.

    Controls whether the parameter appears in Ableton's automation system.
    """
    AUTOMATED_AND_STORED = 0  # Stored in Live Set/presets, available for automation
    STORED_ONLY = 1           # Stored but not visible to automation system
    HIDDEN = 2                # Neither stored nor automatable


# -----------------------------------------------------------------------
# AMXD Binary Format Constants
# -----------------------------------------------------------------------
# Reverse-engineered from kicksynth-m4l.amxd, confirmed via community docs.
#
# Header structure (32 bytes):
#   Offset  Len  Content
#   0       4    b"ampf"          (magic)
#   4       4    uint32 LE = 4    (version)
#   8       4    device type      (aaaa/iiii/mmmm)
#   12      4    b"meta"          (section marker)
#   16      4    uint32 LE = 4    (meta version)
#   20      4    4 zero bytes     (padding)
#   24      4    b"ptch"          (patch section marker)
#   28      4    uint32 LE        (JSON byte length)

AMXD_MAGIC = b"ampf"
AMXD_VERSION = 4
AMXD_META_MARKER = b"meta"
AMXD_META_VERSION = 4
AMXD_PATCH_MARKER = b"ptch"

AMXD_TYPE_AUDIO_EFFECT = b"aaaa"
AMXD_TYPE_INSTRUMENT = b"iiii"
AMXD_TYPE_MIDI_EFFECT = b"mmmm"

# struct format string for packing the 32-byte header
# < = little-endian, 4s = 4-char bytes, I = uint32, 4x = 4 zero bytes
AMXD_HEADER_FORMAT = "<4sI4s4sI4x4sI"
AMXD_HEADER_SIZE = 32
