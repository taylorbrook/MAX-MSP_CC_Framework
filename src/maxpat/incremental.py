"""Incremental patching: merge generator changes into existing .maxpat files.

Provides manifest tracking and merge logic so that generate.py scripts can
update .maxpat files without overwriting user-added objects. Only
generator-owned objects (tracked in a JSON sidecar manifest) are
updated/added/removed on each run.

Public API:
    Manifest          -- Tracks generator-owned box IDs and connections.
    load_existing_patch -- Load a .maxpat JSON file (or None if missing).
    merge_and_write   -- Incremental write: merge patcher into existing .maxpat.
"""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any, TYPE_CHECKING

if TYPE_CHECKING:
    from src.maxpat.patcher import Patcher
    from src.maxpat.defaults import LayoutOptions
    from src.maxpat.validation import ValidationResult


class Manifest:
    """Tracks generator-owned box IDs and connections.

    The manifest is stored as a JSON sidecar file next to the .maxpat.
    It records which box IDs and connections the generator owns so that
    user-added objects can be preserved during regeneration.
    """

    def __init__(
        self,
        box_ids: list[str] | None = None,
        connections: list[tuple] | None = None,
    ):
        self.box_ids: list[str] = box_ids if box_ids is not None else []
        self.connections: list[tuple] = connections if connections is not None else []

    @classmethod
    def sidecar_path(cls, maxpat_path: Path) -> Path:
        """Return manifest path: same dir, stem + '.manifest.json'."""
        return maxpat_path.parent / (maxpat_path.stem + ".manifest.json")

    def save(self, path: Path) -> None:
        """Write manifest JSON to disk."""
        data = {
            "box_ids": self.box_ids,
            "connections": [list(c) for c in self.connections],
        }
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(json.dumps(data, indent=2))

    @classmethod
    def load(cls, path: Path) -> Manifest:
        """Load manifest from disk. Returns empty manifest if file missing."""
        if not path.exists():
            return cls()
        data = json.loads(path.read_text())
        return cls(
            box_ids=data.get("box_ids", []),
            connections=[tuple(c) for c in data.get("connections", [])],
        )

    @classmethod
    def from_patcher(cls, patcher: "Patcher") -> Manifest:
        """Extract box IDs and connection tuples from a Patcher."""
        box_ids = [box.id for box in patcher.boxes]
        connections = [
            (line.source_id, line.source_outlet, line.dest_id, line.dest_inlet)
            for line in patcher.lines
        ]
        return cls(box_ids=box_ids, connections=connections)


def load_existing_patch(path: Path) -> dict | None:
    """Load a .maxpat JSON file. Returns None if file does not exist."""
    if not path.exists():
        return None
    return json.loads(path.read_text())


def merge_and_write(
    patcher: "Patcher",
    path: str | Path,
    validate: bool = True,
    layout_options: "LayoutOptions | None" = None,
) -> list["ValidationResult"]:
    """Incremental write: merge patcher into existing .maxpat, preserving user changes.

    Algorithm:
    1. Load old manifest (from sidecar). If no sidecar, this is a fresh write.
    2. Load existing .maxpat (if exists).
    3. If no existing patch: do a normal write_patch, save manifest, return.
    4. If existing patch exists:
       a. Build set of old-manifest box IDs and new-patcher box IDs.
       b. From existing patch boxes:
          - KEEP boxes whose ID is NOT in old manifest (user-added)
          - DROP boxes whose ID is in old manifest but NOT in new patcher (removed)
          - (Boxes in old manifest AND new patcher will be replaced by new version)
       c. Build merged boxes list: user-kept boxes + all new patcher boxes
       d. Same logic for connections
       e. Merge patcher-level props
    5. Build a merged Patcher, run write_patch on it.
    6. Save new manifest.

    Args:
        patcher: A Patcher instance containing the generator's current boxes/connections.
        path: Output file path for the .maxpat file.
        validate: If False, skip validation entirely. Default True.
        layout_options: Optional LayoutOptions for layout customization.

    Returns:
        List of ValidationResult from validation (empty if validate=False).
    """
    from src.maxpat.hooks import write_patch
    from src.maxpat.patcher import Patcher as PatcherClass

    path = Path(path)
    manifest_path = Manifest.sidecar_path(path)

    # Build new manifest from the current patcher
    new_manifest = Manifest.from_patcher(patcher)

    # Load old manifest
    old_manifest = Manifest.load(manifest_path)

    # Load existing patch
    existing_data = load_existing_patch(path)

    if existing_data is None:
        # Fresh write: no existing patch, just write normally
        results = write_patch(patcher, path, validate=validate, layout_options=layout_options)
        new_manifest.save(manifest_path)
        return results

    # --- Merge logic ---
    old_manifest_ids = set(old_manifest.box_ids)
    new_patcher_ids = set(new_manifest.box_ids)

    # Extract existing boxes from the on-disk .maxpat
    existing_boxes = existing_data.get("patcher", {}).get("boxes", [])
    existing_lines = existing_data.get("patcher", {}).get("lines", [])

    # Build connection identity sets for old manifest connections
    old_manifest_conns = set(old_manifest.connections)
    new_patcher_conns = set(new_manifest.connections)

    # --- Merge boxes ---
    # Keep user boxes (ID not in old manifest)
    user_boxes = [
        b for b in existing_boxes
        if b.get("box", {}).get("id") not in old_manifest_ids
    ]

    # New patcher provides all generator-owned boxes (replaces old + adds new)
    # Apply layout to the patcher first so positions are computed.
    # Match write_patch behavior: only apply auto-styling when validating.
    from src.maxpat.layout import apply_layout

    if validate:
        from src.maxpat import _apply_auto_styling
        _apply_auto_styling(patcher)

    apply_layout(patcher, layout_options)

    generator_boxes = [box.to_dict() for box in patcher.boxes]

    # Merged boxes: user boxes + generator boxes
    merged_boxes = user_boxes + generator_boxes

    # --- Merge connections ---
    # Keep user connections (not in old manifest)
    user_lines = []
    for line_entry in existing_lines:
        ld = line_entry.get("patchline", {})
        src = ld.get("source", ["", 0])
        dst = ld.get("destination", ["", 0])
        conn_tuple = (src[0], src[1], dst[0], dst[1])
        if conn_tuple not in old_manifest_conns:
            user_lines.append(line_entry)

    generator_lines = [line.to_dict() for line in patcher.lines]

    merged_lines = user_lines + generator_lines

    # --- Merge patcher-level props ---
    # Start with existing props, then overlay generator props for controlled keys
    existing_props = {
        k: v for k, v in existing_data.get("patcher", {}).items()
        if k not in ("boxes", "lines")
    }

    # Generator-controlled props that should always be overwritten
    import copy
    merged_props = copy.deepcopy(existing_props)

    # Update with generator patcher props (the generator is authoritative for these)
    for key in ("fileversion", "appversion", "classnamespace",
                "default_fontsize", "default_fontface", "default_fontname"):
        if key in patcher.props:
            merged_props[key] = copy.deepcopy(patcher.props[key])

    # Preserve user-modified props like rect, openinpresentation, bgcolor
    # by not overwriting them from patcher.props. The existing file wins.

    # Build the merged .maxpat dict.
    # Maintain key order matching Patcher.to_dict() / DEFAULT_PATCHER_PROPS:
    # all props, then boxes, lines, then trailing props (dependency_cache, autosave).
    from src.maxpat.defaults import DEFAULT_PATCHER_PROPS

    # Keys that come after boxes/lines in the standard order
    _trailing_keys = set()
    found_boxes = False
    for k in DEFAULT_PATCHER_PROPS:
        if k == "boxes":
            found_boxes = True
            continue
        if k == "lines":
            continue
        if found_boxes:
            _trailing_keys.add(k)

    ordered_props: dict[str, Any] = {}
    # First: all non-trailing, non-boxes/lines props
    for k, v in merged_props.items():
        if k not in ("boxes", "lines") and k not in _trailing_keys:
            ordered_props[k] = v
    # Then: boxes and lines
    ordered_props["boxes"] = merged_boxes
    ordered_props["lines"] = merged_lines
    # Then: trailing props (in DEFAULT_PATCHER_PROPS order)
    for k in DEFAULT_PATCHER_PROPS:
        if k in _trailing_keys and k in merged_props:
            ordered_props[k] = merged_props[k]

    merged_data = {"patcher": ordered_props}

    # Validate if requested
    results: list["ValidationResult"] = []
    if validate:
        from src.maxpat.validation import validate_patch, has_blocking_errors
        from src.maxpat.hooks import PatchValidationError

        results = validate_patch(merged_data, db=patcher.db)
        if has_blocking_errors(results):
            error_msgs = [r.message for r in results if r.level == "error" and not r.auto_fixed]
            raise PatchValidationError(
                f"Validation found blocking errors:\n" +
                "\n".join(f"  - {m}" for m in error_msgs)
            )

    # Write the merged .maxpat
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(merged_data, indent=2))

    # Save new manifest
    new_manifest.save(manifest_path)

    return results
