"""M4L polish -- post-process parameter naming intelligence.

Auto-derives longname, shortname, and varname for M4L live.* controls.
Fills gaps without overriding agent-set values.

Rules:
  D-01: Never override existing non-empty values
  D-02: Derive longname from varname (snake_case -> Title Case)
  D-03: Derive shortname from longname via abbreviation table (max 8 chars)
  D-04: Derive varname from longname (Title Case -> snake_case)
"""

from __future__ import annotations

from src.maxpat.critics.m4l_critic import _LIVE_NO_PARAM


# ---------------------------------------------------------------------------
# Abbreviation table for shortname derivation (D-03)
# ---------------------------------------------------------------------------

_ABBREVIATIONS: dict[str, str] = {
    "frequency": "Freq",
    "resonance": "Reso",
    "envelope": "Env",
    "modulation": "Mod",
    "amplitude": "Amp",
    "oscillator": "Osc",
    "sustain": "Sust",
    "release": "Rel",
    "attack": "Atk",
    "decay": "Dcy",
    "velocity": "Vel",
    "volume": "Vol",
    "feedback": "Fdbk",
    "distortion": "Dist",
    "compressor": "Comp",
    "threshold": "Thresh",
    "milliseconds": "ms",
    "filter": "Filt",
    "output": "Out",
    "input": "In",
    "level": "Lvl",
}


# ---------------------------------------------------------------------------
# Name conversion helpers
# ---------------------------------------------------------------------------

def _varname_to_longname(varname: str) -> str:
    """Convert snake_case varname to Title Case longname.

    "filter_cutoff" -> "Filter Cutoff"
    """
    return varname.replace("_", " ").title()


def _longname_to_varname(longname: str) -> str:
    """Convert Title Case longname to snake_case varname.

    "Filter Cutoff" -> "filter_cutoff"
    """
    return longname.lower().replace(" ", "_")


def _abbreviate_shortname(longname: str, max_len: int = 8) -> str:
    """Abbreviate longname for Push display (max 8 chars).

    Strategy:
    1. If already fits, return as-is
    2. Apply abbreviation table word-by-word
    3. If still too long, drop leading words one at a time
    4. Final hard truncation at max_len
    """
    if len(longname) <= max_len:
        return longname

    # Abbreviate each word
    words = longname.split()
    abbreviated = []
    for word in words:
        lower = word.lower()
        if lower in _ABBREVIATIONS:
            abbreviated.append(_ABBREVIATIONS[lower])
        else:
            abbreviated.append(word)

    result = " ".join(abbreviated)
    if len(result) <= max_len:
        return result

    # Drop leading words until it fits
    while len(abbreviated) > 1 and len(" ".join(abbreviated)) > max_len:
        abbreviated.pop(0)

    result = " ".join(abbreviated)
    if len(result) <= max_len:
        return result

    # Final hard truncation
    return result[:max_len]


# ---------------------------------------------------------------------------
# Live control collection (recursive)
# ---------------------------------------------------------------------------

def _collect_live_controls(boxes: list[dict]) -> list[dict]:
    """Recursively collect all live.* UI control boxes.

    Returns the inner box dicts (not the wrapper {"box": ...}).
    Excludes non-parameter live objects (live.thisdevice, etc).
    """
    controls: list[dict] = []

    for box_entry in boxes:
        box = box_entry.get("box", box_entry)
        maxclass = box.get("maxclass", "")

        # Collect live.* controls that are parameterizable
        if maxclass.startswith("live.") and maxclass not in _LIVE_NO_PARAM:
            controls.append(box)

        # Recurse into subpatchers
        inner_patcher = box.get("patcher")
        if inner_patcher:
            inner_boxes = inner_patcher.get("boxes", [])
            controls.extend(_collect_live_controls(inner_boxes))

    return controls


# ---------------------------------------------------------------------------
# Main entry point
# ---------------------------------------------------------------------------

def derive_parameter_names(patch_dict: dict) -> dict:
    """Auto-derive longname/shortname/varname for all live.* controls.

    Mutates patch_dict in place. Returns the same dict.

    Rules:
      - Never override existing non-empty values (D-01)
      - Derive longname from varname or box text (D-02)
      - Derive shortname from longname via abbreviation (D-03)
      - Derive varname from longname (D-04)
      - Resolve duplicate longnames with index suffix
    """
    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])
    controls = _collect_live_controls(boxes)

    # Phase 1: Derive names for each control
    for box in controls:
        # Ensure saved_attribute_attributes.valueof exists
        saa = box.setdefault("saved_attribute_attributes", {})
        valueof = saa.setdefault("valueof", {})

        existing_longname = valueof.get("parameter_longname", "")
        existing_shortname = valueof.get("parameter_shortname", "")
        existing_varname = box.get("varname", "")

        # D-02: Derive longname if missing
        if not existing_longname:
            if existing_varname:
                valueof["parameter_longname"] = _varname_to_longname(existing_varname)
            else:
                # Try deriving from box text (e.g., "live.dial pitch_start")
                text = box.get("text", "")
                if text:
                    tokens = text.split()
                    # Skip the maxclass token (first word)
                    if len(tokens) > 1:
                        varname_from_text = tokens[1]
                        valueof["parameter_longname"] = _varname_to_longname(varname_from_text)

        # D-04: Derive varname if missing (needs longname to exist now)
        current_longname = valueof.get("parameter_longname", "")
        if not existing_varname and current_longname:
            box["varname"] = _longname_to_varname(current_longname)

        # D-03: Derive shortname if missing (needs longname)
        if not existing_shortname and current_longname:
            valueof["parameter_shortname"] = _abbreviate_shortname(current_longname)

    # Phase 2: Resolve duplicate longnames
    _resolve_duplicate_longnames(controls)

    return patch_dict


# ---------------------------------------------------------------------------
# Push bank organization (POLISH-02)
# ---------------------------------------------------------------------------

_BANK_KEYWORDS: dict[str, set[str]] = {
    "Pitch": {"pitch", "tune", "tuning", "detune", "transpose", "semitone", "cent", "octave"},
    "Amp": {"amp", "amplitude", "volume", "level", "gain", "velocity", "body"},
    "Filter": {"filter", "cutoff", "resonance", "reso", "freq", "tone", "drive", "hp", "lp", "bp"},
    "Envelope": {"envelope", "env", "attack", "decay", "sustain", "release", "adsr", "curve"},
    "Mod": {"modulation", "mod", "lfo", "rate", "depth", "amount", "speed"},
    "FX": {"delay", "reverb", "chorus", "flanger", "phaser", "distortion", "comp", "eq"},
    "Noise": {"noise", "sub"},
    "Mix": {"mix", "dry", "wet", "send", "return", "pan", "width"},
}


def _classify_parameter(longname_or_varname: str) -> str:
    """Classify a parameter into a semantic group by keywords.

    Splits on spaces and underscores, scores against _BANK_KEYWORDS.
    First word (prefix) gets +2 bonus if found in any keyword set.
    Returns group name with highest score, or "Main" if no match.
    """
    parts = set(longname_or_varname.lower().replace("_", " ").split())
    # Prefix is the first word
    tokens = longname_or_varname.lower().replace("_", " ").split()
    prefix = tokens[0] if tokens else ""

    best_group = "Main"
    best_score = 0
    for group_name, keywords in _BANK_KEYWORDS.items():
        score = len(parts & keywords)
        # Bonus for prefix match
        if prefix in keywords:
            score += 2
        if score > best_score:
            best_score = score
            best_group = group_name

    return best_group


def organize_push_banks(patch_dict: dict) -> dict:
    """Organize parameters into semantic Push banks of 8.

    Mutates patch_dict in place. Returns the same dict.

    - Collects all live.* controls via _collect_live_controls
    - Classifies each parameter into a semantic group
    - Chunks each group into banks of 8, padding partial banks with "-"
    - Creates or reuses the live.banks box
    - Sets _parameter_banks attribute with bank data
    """
    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])
    controls = _collect_live_controls(boxes)

    if not controls:
        return patch_dict

    # Collect longnames and classify into groups
    groups: dict[str, list[str]] = {}
    for box in controls:
        saa = box.get("saved_attribute_attributes", {})
        valueof = saa.get("valueof", {})
        longname = valueof.get("parameter_longname", "")
        if not longname:
            continue
        group = _classify_parameter(longname)
        groups.setdefault(group, []).append(longname)

    if not groups:
        return patch_dict

    # Build bank dicts: chunk each group into banks of 8
    bank_dicts: list[dict] = []
    for group_name, longnames in groups.items():
        for chunk_idx in range(0, len(longnames), 8):
            chunk = longnames[chunk_idx : chunk_idx + 8]
            # Pad to 8
            padded = chunk + ["-"] * (8 - len(chunk))
            # Name: "Filter", "Filter 2", etc.
            bank_num = chunk_idx // 8
            name = group_name if bank_num == 0 else f"{group_name} {bank_num + 1}"
            bank_dicts.append({"name": name, "parameters": padded})

    # Find or create live.banks box
    banks_box = None
    for entry in boxes:
        box = entry.get("box", entry)
        if box.get("maxclass") == "live.banks":
            banks_box = box
            break

    if banks_box is None:
        banks_box = {
            "id": "obj-live-banks",
            "maxclass": "live.banks",
            "numinlets": 1,
            "numoutlets": 1,
            "outlettype": [""],
            "patching_rect": [20.0, 20.0, 315.0, 45.0],
        }
        boxes.append({"box": banks_box})

    banks_box["_parameter_banks"] = {"banks": bank_dicts}

    return patch_dict


def _resolve_duplicate_longnames(controls: list[dict]) -> None:
    """Append index suffix to duplicate longnames."""
    # Collect all longnames with their box refs
    longname_groups: dict[str, list[dict]] = {}
    for box in controls:
        saa = box.get("saved_attribute_attributes", {})
        valueof = saa.get("valueof", {})
        ln = valueof.get("parameter_longname", "")
        if ln:
            longname_groups.setdefault(ln, []).append(valueof)

    # For any group with duplicates, rename later occurrences
    for longname, valueofs in longname_groups.items():
        if len(valueofs) <= 1:
            continue
        # First occurrence keeps the name, subsequent get " 2", " 3", etc.
        for i, valueof in enumerate(valueofs[1:], start=2):
            valueof["parameter_longname"] = f"{longname} {i}"
