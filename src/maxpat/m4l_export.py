"""M4L device export -- produces .amxd files from .maxpat patches.

Standalone module per D-02. Called explicitly by agents or users.
Not auto-triggered on save. Clean separation from hooks.py.
"""

from __future__ import annotations

import json
import os
import struct
from pathlib import Path

from src.maxpat.m4l_constants import (
    AMXD_MAGIC,
    AMXD_VERSION,
    AMXD_META_MARKER,
    AMXD_META_VERSION,
    AMXD_PATCH_MARKER,
    AMXD_HEADER_FORMAT,
    AMXD_TYPE_AUDIO_EFFECT,
    AMXD_TYPE_INSTRUMENT,
    AMXD_TYPE_MIDI_EFFECT,
)
from src.maxpat.project import auto_commit_patch


_DEVICE_TYPE_BYTES = {
    "audio_effect": AMXD_TYPE_AUDIO_EFFECT,
    "instrument": AMXD_TYPE_INSTRUMENT,
    "midi_effect": AMXD_TYPE_MIDI_EFFECT,
}


def write_amxd(
    patch_path: str | Path,
    output_path: str | Path,
    device_type: str,
) -> Path:
    """Export a .maxpat as .amxd with correct 32-byte binary header.

    Reads the .maxpat JSON, re-serializes with tab indentation,
    prepends the AMXD binary header, and writes to output_path.
    Auto-commits the output file to git per CLAUDE.md Rule #7.

    Args:
        patch_path: Path to source .maxpat file.
        output_path: Path for output .amxd file.
        device_type: One of "audio_effect", "instrument", "midi_effect".

    Returns:
        Path to the created .amxd file.

    Raises:
        FileNotFoundError: If patch_path does not exist.
        KeyError: If device_type is not recognized.
    """
    patch_path = Path(patch_path)
    output_path = Path(output_path)

    if not patch_path.exists():
        raise FileNotFoundError(f"Patch file not found: {patch_path}")

    # Read and re-serialize JSON with tab indentation (AMXD convention)
    patch_text = patch_path.read_text(encoding="utf-8")
    patch_data = json.loads(patch_text)
    json_bytes = json.dumps(patch_data, indent="\t").encode("utf-8")

    # Build 32-byte header
    type_bytes = _DEVICE_TYPE_BYTES[device_type]  # KeyError if invalid
    header = struct.pack(
        AMXD_HEADER_FORMAT,
        AMXD_MAGIC,          # b"ampf"
        AMXD_VERSION,        # 4
        type_bytes,          # b"aaaa" / b"iiii" / b"mmmm"
        AMXD_META_MARKER,    # b"meta"
        AMXD_META_VERSION,   # 4
        # 4x = 4 zero bytes (padding) -- implicit in format
        AMXD_PATCH_MARKER,   # b"ptch"
        len(json_bytes),     # JSON byte length
    )

    # Write binary file
    output_path.parent.mkdir(parents=True, exist_ok=True)
    with open(output_path, "wb") as f:
        f.write(header)
        f.write(json_bytes)
        f.flush()
        os.fsync(f.fileno())

    # Auto-commit per CLAUDE.md Rule #7
    try:
        parts = list(output_path.resolve().parts)
        if "patches" in parts:
            patches_idx = parts.index("patches")
            if len(parts) > patches_idx + 1:
                project_dir = Path(*parts[:patches_idx + 2])
                base_dir = Path(*parts[:patches_idx])
                auto_commit_patch(
                    project_dir, base_dir,
                    description=f"export {output_path.name}",
                    files=[str(output_path)],
                )
    except Exception:
        pass  # Never let commit failure block export

    return output_path
