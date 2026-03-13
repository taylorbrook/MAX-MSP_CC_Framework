"""Help patch parser with recursive patcher descent.

Recursively traverses .maxhelp JSON files to extract all newobj box instances,
including those nested inside subpatcher tabs. Each instance captures metadata
needed for downstream audit analysis: object name, text, I/O counts, outlet
types, position/size, connection status, and nesting depth.
"""

from __future__ import annotations

import json
from pathlib import Path

from src.maxpat.audit import BoxInstance


def parse_object_text(text: str) -> tuple[str, list[str], dict[str, str]]:
    """Parse newobj text into object name, positional args, and attributes.

    Splits on the first ``@`` to separate positional arguments from attribute
    key/value pairs. Handles empty text gracefully.

    Args:
        text: The full text of a newobj box (e.g., ``"cycle~ 440"``).

    Returns:
        Tuple of (name, positional_args, attributes).

    Examples:
        >>> parse_object_text("cycle~ 440")
        ('cycle~', ['440'], {})
        >>> parse_object_text("line~ @activeout 1")
        ('line~', [], {'activeout': '1'})
        >>> parse_object_text("t b i f")
        ('t', ['b', 'i', 'f'], {})
        >>> parse_object_text("")
        ('', [], {})
    """
    parts = text.split()
    if not parts:
        return ("", [], {})

    name = parts[0]
    positional: list[str] = []
    attributes: dict[str, str] = {}

    i = 1
    while i < len(parts):
        if parts[i].startswith("@"):
            attr_key = parts[i][1:]  # Remove leading @
            if i + 1 < len(parts) and not parts[i + 1].startswith("@"):
                attributes[attr_key] = parts[i + 1]
                i += 2
            else:
                attributes[attr_key] = ""
                i += 1
        else:
            positional.append(parts[i])
            i += 1

    return (name, positional, attributes)


def traverse_patcher(
    patcher: dict,
    depth: int = 0,
    source_file: str = "",
) -> list[BoxInstance]:
    """Recursively extract all newobj box instances from a patcher hierarchy.

    For each patcher scope:
    1. Build an id_map of box_id -> box dict
    2. Extract connections from the ``lines`` array
    3. Build a ``connected_ids`` set of all box IDs that appear in any patchline
    4. Yield a ``BoxInstance`` for each ``maxclass == "newobj"`` box with non-empty text
    5. Recurse into any box that has a ``patcher`` key

    Args:
        patcher: A patcher dict containing ``boxes`` and ``lines`` arrays.
        depth: Current nesting depth (0 = top-level).
        source_file: Path to the source .maxhelp file.

    Returns:
        List of BoxInstance objects found at this level and all nested levels.
    """
    instances: list[BoxInstance] = []

    # Step 1: Build ID -> box map for this patcher scope
    id_map: dict[str, dict] = {}
    for box_wrapper in patcher.get("boxes", []):
        box = box_wrapper.get("box", {})
        box_id = box.get("id", "")
        if box_id:
            id_map[box_id] = box

    # Step 2: Extract connections for this scope
    connections: list[tuple[str, int, str, int]] = []
    for line_wrapper in patcher.get("lines", []):
        patchline = line_wrapper.get("patchline", {})
        source = patchline.get("source", [])
        destination = patchline.get("destination", [])
        if len(source) >= 2 and len(destination) >= 2:
            connections.append((source[0], source[1], destination[0], destination[1]))

    # Step 3: Build connected_ids set
    connected_ids: set[str] = set()
    for src_id, _, dst_id, _ in connections:
        connected_ids.add(src_id)
        connected_ids.add(dst_id)

    # Step 4: Extract newobj instances
    for box_id, box in id_map.items():
        maxclass = box.get("maxclass", "")
        text = box.get("text", "")

        if maxclass == "newobj" and text:
            obj_name = text.split()[0]
            box_connections = [
                (s, so, d, di)
                for s, so, d, di in connections
                if s == box_id or d == box_id
            ]
            instances.append(
                BoxInstance(
                    name=obj_name,
                    text=text,
                    numinlets=box.get("numinlets", 0),
                    numoutlets=box.get("numoutlets", 0),
                    outlettype=box.get("outlettype", []),
                    patching_rect=box.get("patching_rect", []),
                    box_id=box_id,
                    depth=depth,
                    is_connected=box_id in connected_ids,
                    connections=box_connections,
                    source_file=source_file,
                )
            )

        # Step 5: Recurse into subpatchers
        if "patcher" in box:
            instances.extend(
                traverse_patcher(box["patcher"], depth + 1, source_file)
            )

    return instances


class HelpPatchParser:
    """Stateless parser for MAX help patch files.

    Provides methods to parse individual .maxhelp files or entire directories
    of help patches, extracting all newobj box instances with full metadata.
    """

    def __init__(self) -> None:
        """Initialize the parser. No state needed -- parser is stateless."""

    def parse_file(self, path: Path) -> list[BoxInstance]:
        """Parse a single .maxhelp (or .maxpat) JSON file.

        Opens the JSON file, calls ``traverse_patcher`` on the top-level
        patcher, and sets ``source_file`` on all returned instances.

        Args:
            path: Path to the .maxhelp JSON file.

        Returns:
            List of BoxInstance objects found in the file.
        """
        with open(path) as f:
            data = json.load(f)

        patcher = data.get("patcher", {})
        source = str(path)
        instances = traverse_patcher(patcher, depth=0, source_file=source)
        return instances

    def parse_directory(self, help_dir: Path) -> dict[str, list[BoxInstance]]:
        """Parse all .maxhelp files in a directory.

        Globs for ``*.maxhelp`` files, parses each, and returns a dict keyed
        by the object name (derived from the filename stem, e.g.,
        ``"cycle~"`` from ``cycle~.maxhelp``).

        Args:
            help_dir: Directory containing .maxhelp files.

        Returns:
            Dict mapping object name to list of BoxInstance objects found.
        """
        results: dict[str, list[BoxInstance]] = {}
        for help_file in sorted(help_dir.glob("*.maxhelp")):
            obj_name = help_file.stem
            try:
                instances = self.parse_file(help_file)
                results[obj_name] = instances
            except (json.JSONDecodeError, KeyError):
                # Skip unparseable files
                results[obj_name] = []
        return results
