"""DSP critic -- checks signal flow, gen~ I/O matching, and gain staging.

Catches semantic DSP issues that the mechanical validation pipeline does
not detect:
  - gen~ I/O mismatches between GenExpr code and wrapper box
  - Missing gain staging before dac~/ezdac~
  - Audio rate consistency (control-rate to signal inlet)

NOTE: Does NOT duplicate validation.py Layer 4 checks (unterminated chains,
feedback loops). Focus is on semantic issues validation misses.
"""

from __future__ import annotations

import re
from collections import deque

from src.maxpat.critics.base import CriticResult
from src.maxpat.codegen import parse_genexpr_io
from src.maxpat.utils import get_box_name


# Oscillator objects that need gain staging before dac~/ezdac~
_OSCILLATOR_NAMES = frozenset({
    "cycle~", "saw~", "rect~", "tri~", "noise~", "pink~",
    "mc.cycle~", "mc.saw~", "mc.rect~", "mc.tri~",
})

# Gain objects that attenuate signal (includes MC variants)
_GAIN_NAMES = frozenset({"*~", "gain~", "mc.*~", "mc.gain~"})

# Terminal signal objects
_TERMINAL_NAMES = frozenset({"dac~", "ezdac~"})

# Objects known to output MIDI-range (0-127) or UI-range values
_MIDI_RANGE_SOURCES = frozenset({
    "ctlin", "notein", "slider", "kslider",
    "live.dial", "live.slider", "live.numbox",
    "number", "flonum",
})

# Objects that normalize/scale values into safe ranges
_NORMALIZER_NAMES = frozenset({"scale", "zmap", "clip", "clip~"})


def review_dsp(
    patch_dict: dict,
    code_context: dict | None = None,
) -> list[CriticResult]:
    """Review DSP aspects of a patch.

    Checks:
      1. gen~ I/O match between GenExpr code and wrapper box
      2. Gain staging: oscillators connected to dac~ without *~ or gain~
      3. Audio rate consistency: control-rate objects to signal inlets

    Args:
        patch_dict: A .maxpat-format dict.
        code_context: Optional dict with gen~ code strings keyed by box id.
            Format: {"gen~_code": {"obj-1": "out1 = in1 * 0.5;"}}

    Returns:
        List of CriticResult findings.
    """
    results: list[CriticResult] = []

    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])
    lines = patcher.get("lines", [])

    # Build box lookup
    box_lookup: dict[str, dict] = {}
    for box_entry in boxes:
        box = box_entry.get("box", {})
        box_id = box.get("id")
        if box_id:
            box_lookup[box_id] = box

    # Run checks
    results.extend(_check_gen_io_match(box_lookup, code_context))
    results.extend(_check_gain_staging(box_lookup, lines))
    results.extend(_check_audio_rate_consistency(box_lookup, lines))
    results.extend(_check_unsafe_gain_sources(box_lookup, lines))

    return results


# ---------------------------------------------------------------------------
# Check 1: gen~ I/O match
# ---------------------------------------------------------------------------

def _check_gen_io_match(
    box_lookup: dict[str, dict],
    code_context: dict | None,
) -> list[CriticResult]:
    """Find gen~ boxes and verify I/O counts match embedded GenExpr code.

    Looks for gen~ boxes with embedded patchers containing codebox objects.
    Also checks code_context for externally-provided code strings.
    """
    results: list[CriticResult] = []

    for box_id, box in box_lookup.items():
        # Only check gen~ boxes
        if box.get("maxclass") != "gen~":
            continue

        gen_numinlets = box.get("numinlets", 0)
        gen_numoutlets = box.get("numoutlets", 0)

        # Find codebox code from embedded patcher
        code = _extract_codebox_code(box)

        # Also check code_context for externally-provided code
        if code is None and code_context:
            gen_codes = code_context.get("gen~_code", {})
            code = gen_codes.get(box_id)

        if code is None:
            continue  # No code to check

        # Parse I/O from GenExpr code
        code_inputs, code_outputs = parse_genexpr_io(code)

        # Compare inputs
        if code_inputs > gen_numinlets:
            results.append(CriticResult(
                "blocker",
                f"gen~ I/O input mismatch: GenExpr code uses {code_inputs} "
                f"inputs (in1..in{code_inputs}) but gen~ box '{box_id}' "
                f"has only {gen_numinlets} inlet(s)",
                f"Update gen~ box to have {code_inputs} inlets, or reduce "
                f"the number of inputs in the GenExpr code",
            ))

        # Compare outputs
        if code_outputs > gen_numoutlets:
            results.append(CriticResult(
                "blocker",
                f"gen~ I/O output mismatch: GenExpr code uses {code_outputs} "
                f"outputs (out1..out{code_outputs}) but gen~ box '{box_id}' "
                f"has only {gen_numoutlets} outlet(s)",
                f"Update gen~ box to have {code_outputs} outlets, or reduce "
                f"the number of outputs in the GenExpr code",
            ))

    return results


def _extract_codebox_code(gen_box: dict) -> str | None:
    """Extract GenExpr code from an embedded codebox inside a gen~ box."""
    inner_patcher = gen_box.get("patcher")
    if not inner_patcher:
        return None

    inner_boxes = inner_patcher.get("boxes", [])
    for entry in inner_boxes:
        inner_box = entry.get("box", {})
        if inner_box.get("maxclass") == "codebox":
            code = inner_box.get("code")
            if code:
                return code

    return None


# ---------------------------------------------------------------------------
# Check 2: Gain staging
# ---------------------------------------------------------------------------

def _check_gain_staging(
    box_lookup: dict[str, dict],
    lines: list[dict],
) -> list[CriticResult]:
    """Detect oscillators connected to dac~/ezdac~ without gain staging.

    Uses BFS from each oscillator. If it reaches dac~/ezdac~ without passing
    through a gain object (*~ or gain~), emit a warning.
    """
    results: list[CriticResult] = []

    # Build signal adjacency from patchlines
    signal_adj: dict[str, list[str]] = {}
    for line_entry in lines:
        patchline = line_entry.get("patchline", line_entry)
        source = patchline.get("source", [])
        destination = patchline.get("destination", [])
        if len(source) < 2 or len(destination) < 2:
            continue

        src_id, src_outlet = source[0], source[1]
        dst_id = destination[0]

        src_box = box_lookup.get(src_id)
        if not src_box:
            continue

        # Check if this is a signal connection
        src_outlettype = src_box.get("outlettype", [])
        is_signal = (
            src_outlet < len(src_outlettype)
            and src_outlettype[src_outlet] == "signal"
        )

        if is_signal:
            signal_adj.setdefault(src_id, []).append(dst_id)

    # Find oscillator boxes
    osc_ids = [
        box_id for box_id, box in box_lookup.items()
        if get_box_name(box) in _OSCILLATOR_NAMES
    ]

    # BFS from each oscillator
    for osc_id in osc_ids:
        osc_name = get_box_name(box_lookup[osc_id])
        queue = deque([(osc_id, False)])  # (current_id, passed_through_gain)
        visited: set[tuple[str, bool]] = set()

        while queue:
            current_id, has_gain = queue.popleft()
            state = (current_id, has_gain)
            if state in visited:
                continue
            visited.add(state)

            for next_id in signal_adj.get(current_id, []):
                next_box = box_lookup.get(next_id)
                if not next_box:
                    continue
                next_name = get_box_name(next_box)

                next_has_gain = has_gain or (next_name in _GAIN_NAMES)

                if next_name in _TERMINAL_NAMES:
                    if not next_has_gain:
                        results.append(CriticResult(
                            "blocker",
                            f"Missing gain staging: '{osc_name}' ({osc_id}) "
                            f"connected to '{next_name}' ({next_id}) without "
                            f"passing through *~ or gain~",
                            f"Insert a '*~ 0.5' or 'gain~' between "
                            f"'{osc_name}' and '{next_name}' to control volume",
                        ))
                    continue  # Don't traverse past dac~

                queue.append((next_id, next_has_gain))

    return results


# ---------------------------------------------------------------------------
# Check 3: Audio rate consistency
# ---------------------------------------------------------------------------

def _check_audio_rate_consistency(
    box_lookup: dict[str, dict],
    lines: list[dict],
) -> list[CriticResult]:
    """Detect control-rate objects connected to signal inlets.

    A non-~ object (control rate) connecting to a signal object's inlet
    where signal flow is expected is a potential issue.

    NOTE: Some signal inlets (like *~ inlet 1) accept both signal and
    float values, so this is a warning, not a blocker. We only flag
    when a control-rate outlet connects to inlet 0 of a signal object
    that normally expects signal input.
    """
    results: list[CriticResult] = []

    for line_entry in lines:
        patchline = line_entry.get("patchline", line_entry)
        source = patchline.get("source", [])
        destination = patchline.get("destination", [])
        if len(source) < 2 or len(destination) < 2:
            continue

        src_id, src_outlet = source[0], source[1]
        dst_id, dst_inlet = destination[0], destination[1]

        src_box = box_lookup.get(src_id)
        dst_box = box_lookup.get(dst_id)
        if not src_box or not dst_box:
            continue

        src_name = get_box_name(src_box)
        dst_name = get_box_name(dst_box)

        # Source is control-rate (no ~ suffix in name)
        src_is_signal = src_name.endswith("~")

        # Destination is signal-rate (~ suffix in name)
        dst_is_signal = dst_name.endswith("~")

        if src_is_signal or not dst_is_signal:
            continue  # Not a control-to-signal connection

        # Check if the source outlet is control-rate
        src_outlettype = src_box.get("outlettype", [])
        if src_outlet < len(src_outlettype) and src_outlettype[src_outlet] == "signal":
            continue  # Source outlet is actually signal

        # This is a control-rate object feeding a signal-rate object
        # Only flag for inlet 0 (primary signal input) to reduce noise
        if dst_inlet == 0:
            results.append(CriticResult(
                "warning",
                f"Control-rate to signal-rate: '{src_name}' ({src_id}) "
                f"outlet {src_outlet} connected to '{dst_name}' ({dst_id}) "
                f"inlet {dst_inlet} -- control data feeding signal input",
                f"Use a 'sig~' object to convert control data to signal rate, "
                f"or verify this is intentional (some inlets accept both)",
            ))

    return results


# ---------------------------------------------------------------------------
# Check 4: Unsafe gain sources
# ---------------------------------------------------------------------------

def _is_normalizer(box: dict) -> bool:
    """Check if a box is a normalizer/scaler that constrains values to safe range."""
    name = get_box_name(box)
    if name in _NORMALIZER_NAMES:
        return True

    text = box.get("text", "")
    # Division by 127 normalizes MIDI range: "/ 127." or "!/ 127."
    if text.startswith("/ 127") or text.startswith("!/ 127"):
        return True
    # Small multiplication factor like "* 0.007" (approx 1/127)
    if text.startswith("* 0.00") and not text.startswith("* 0.0 "):
        return True
    # expr/vexpr: only treat as normalizer if text contains division/scaling patterns
    if name in ("expr", "vexpr"):
        # Division by common ranges, or multiplication by small constant < 1.0
        if re.search(r'[/!]\s*127|[/!]\s*255|[/!]\s*100|\*\s*0\.\d', text):
            return True
        return False

    return False


def _parse_line_tilde_targets(text: str) -> list[float]:
    """Parse target values from a message box feeding line~.

    line~ message format: target1 time1 target2 time2 ...
    Values at even indices (0, 2, 4...) are target values.
    A single number with no time is also a valid target.
    """
    targets: list[float] = []
    parts = text.split()
    for i, part in enumerate(parts):
        if i % 2 == 0:  # even indices are target values
            try:
                targets.append(float(part))
            except ValueError:
                pass
    return targets


def _check_unsafe_gain_sources(
    box_lookup: dict[str, dict],
    lines: list[dict],
) -> list[CriticResult]:
    """Detect MIDI-range control sources feeding *~ gain inlet without normalization.

    Traces backward from *~ inlet 1 (the gain/multiplier inlet) through
    control-rate connections. If it reaches a MIDI-range source (ctlin, notein,
    number, slider, etc.) without passing through a normalizer (scale, clip,
    / 127.), emit a blocker.

    Also traces through line~ (signal-rate) to detect >1.0 message values
    and MIDI sources feeding the gain inlet indirectly.
    """
    results: list[CriticResult] = []

    # Build control adjacency: for each (dst_id, dst_inlet) -> list of src_ids
    # Only non-signal connections
    ctrl_predecessors: dict[tuple[str, int], list[str]] = {}
    # Build signal adjacency: for each (dst_id, dst_inlet) -> list of src_ids
    sig_predecessors: dict[tuple[str, int], list[str]] = {}

    for line_entry in lines:
        patchline = line_entry.get("patchline", line_entry)
        source = patchline.get("source", [])
        destination = patchline.get("destination", [])
        if len(source) < 2 or len(destination) < 2:
            continue

        src_id, src_outlet = source[0], source[1]
        dst_id, dst_inlet = destination[0], destination[1]

        src_box = box_lookup.get(src_id)
        if not src_box:
            continue

        src_outlettype = src_box.get("outlettype", [])
        is_signal = (
            src_outlet < len(src_outlettype)
            and src_outlettype[src_outlet] == "signal"
        )

        key = (dst_id, dst_inlet)
        if is_signal:
            sig_predecessors.setdefault(key, []).append(src_id)
        else:
            ctrl_predecessors.setdefault(key, []).append(src_id)

    # Also build general control backward adjacency (any inlet) for tracing
    ctrl_backward: dict[str, list[str]] = {}
    for line_entry in lines:
        patchline = line_entry.get("patchline", line_entry)
        source = patchline.get("source", [])
        destination = patchline.get("destination", [])
        if len(source) < 2 or len(destination) < 2:
            continue

        src_id, src_outlet = source[0], source[1]
        dst_id = destination[0]

        src_box = box_lookup.get(src_id)
        if not src_box:
            continue

        src_outlettype = src_box.get("outlettype", [])
        is_signal = (
            src_outlet < len(src_outlettype)
            and src_outlettype[src_outlet] == "signal"
        )
        if is_signal:
            continue

        ctrl_backward.setdefault(dst_id, []).append(src_id)

    # Names with a gain inlet at index 1 (mc.gain~ excluded: only 1 inlet)
    _GAIN_INLET_1_NAMES = frozenset({"*~", "mc.*~"})

    def _trace_ctrl_backward(start_ids: list[str], gain_name: str, gain_id: str):
        """BFS backward from control sources to find MIDI-range origins."""
        for start_src in start_ids:
            queue = deque([start_src])
            visited: set[str] = set()

            while queue:
                current_id = queue.popleft()
                if current_id in visited:
                    continue
                visited.add(current_id)

                current_box = box_lookup.get(current_id)
                if not current_box:
                    continue

                current_name = get_box_name(current_box)

                # If we hit a normalizer, this path is safe -- stop tracing
                if _is_normalizer(current_box):
                    continue

                # Check message boxes for >1.0 target values (line~ path)
                if current_box.get("maxclass") == "message":
                    targets = _parse_line_tilde_targets(
                        current_box.get("text", ""),
                    )
                    if any(abs(t) > 1.0 for t in targets):
                        results.append(CriticResult(
                            "blocker",
                            f"Unsafe gain source: message '{current_box.get('text', '')}' "
                            f"({current_id}) feeds '{gain_name}' ({gain_id}) "
                            f"inlet 1 via line~ with value >1.0 "
                            f"-- will cause dangerous audio levels",
                            f"Keep message target values in 0.0-1.0 range "
                            f"for gain control",
                        ))
                    continue

                # If we hit a MIDI-range source, flag it
                if current_name in _MIDI_RANGE_SOURCES:
                    results.append(CriticResult(
                        "blocker",
                        f"Unsafe gain source: '{current_name}' ({current_id}) "
                        f"feeds '{gain_name}' ({gain_id}) inlet 1 without "
                        f"normalization -- raw MIDI/UI values (0-127) will "
                        f"cause dangerous audio levels",
                        f"Insert 'scale 0 127 0. 1.' or '/ 127.' before the "
                        f"gain input",
                    ))
                    continue

                # Continue tracing backward
                for prev_id in ctrl_backward.get(current_id, []):
                    queue.append(prev_id)

    # Find all *~/mc.*~ boxes and check what feeds inlet 1
    for box_id, box in box_lookup.items():
        name = get_box_name(box)
        if name not in _GAIN_INLET_1_NAMES:
            continue

        # Get control sources feeding inlet 1 (gain inlet) -- direct control
        inlet_1_ctrl = ctrl_predecessors.get((box_id, 1), [])

        # Get signal sources feeding inlet 1 -- check for line~
        inlet_1_sig = sig_predecessors.get((box_id, 1), [])
        line_tilde_ctrl_sources: list[str] = []
        for sig_src_id in inlet_1_sig:
            sig_src_box = box_lookup.get(sig_src_id)
            if sig_src_box and get_box_name(sig_src_box) == "line~":
                # Trace backward from line~'s control inputs
                line_ctrl = ctrl_backward.get(sig_src_id, [])
                line_tilde_ctrl_sources.extend(line_ctrl)

        # Trace from direct control sources
        if inlet_1_ctrl:
            _trace_ctrl_backward(inlet_1_ctrl, name, box_id)

        # Trace from line~ control inputs (line~ acts as signal bridge)
        if line_tilde_ctrl_sources:
            _trace_ctrl_backward(line_tilde_ctrl_sources, name, box_id)

    return results
