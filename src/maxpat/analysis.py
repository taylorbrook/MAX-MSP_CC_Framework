"""Patch analysis mixin for Patcher.

Provides structured Markdown analysis of patch contents: domain classification,
section detection, complexity metrics, signal/control flow tracing, hierarchy,
and parameter inventory. Extracted from patcher.py for maintainability.
"""

from __future__ import annotations

from collections import Counter, deque
from dataclasses import dataclass
from typing import TYPE_CHECKING

from src.maxpat.maxclass_map import UI_MAXCLASSES

if TYPE_CHECKING:
    from src.maxpat.patcher import Box


# ---------------------------------------------------------------------------
# Section signature mapping: object name -> section label
# Used by _name_section() for auto-naming connected components.
# ---------------------------------------------------------------------------
SECTION_SIGNATURES: dict[str, str] = {
    # Audio sources (priority: high)
    "cycle~": "Oscillator",
    "saw~": "Oscillator",
    "rect~": "Oscillator",
    "tri~": "Oscillator",
    "phasor~": "Oscillator",
    "noise~": "Noise Generator",
    "sfplay~": "Sample Player",
    "play~": "Sample Player",
    "groove~": "Sample Player",
    "buffer~": "Buffer",
    # Processing (priority: medium)
    "svf~": "Filter",
    "biquad~": "Filter",
    "onepole~": "Filter",
    "reson~": "Filter",
    "filtergraph~": "Filter",
    "lores~": "Filter",
    # Dynamics / envelope
    "adsr~": "Envelope",
    "function": "Envelope",
    "line~": "Envelope/Ramp",
    # Effects
    "tapin~": "Delay",
    "tapout~": "Delay",
    "freqshift~": "Frequency Shifter",
    "pitchshift~": "Pitch Shifter",
    "reverb~": "Reverb",
    # Output (priority: low)
    "dac~": "Audio Output",
    "ezdac~": "Audio Output",
    "adc~": "Audio Input",
    "ezadc~": "Audio Input",
    # MIDI
    "notein": "MIDI Input",
    "noteout": "MIDI Output",
    "ctlin": "MIDI Control",
    "makenote": "MIDI Note Builder",
    # Mixing
    "gain~": "Gain/Mixer",
    "*~": "Gain/Mixer",
    # Gen
    "gen~": "Gen~ DSP",
    # Control
    "metro": "Clock/Sequencer",
    "counter": "Counter/Sequencer",
    "loadbang": "Initialization",
    # Jitter
    "jit.gl.render": "OpenGL Render",
    "jit.matrix": "Matrix Processing",
}

# Priority ordering for section naming: higher number = higher priority.
# When multiple signature objects appear in a section, prefer the one with
# the highest priority to name the section.
_SECTION_NAME_PRIORITY: dict[str, int] = {
    "Oscillator": 90,
    "Noise Generator": 85,
    "Sample Player": 85,
    "Gen~ DSP": 80,
    "Filter": 70,
    "Envelope": 65,
    "Envelope/Ramp": 60,
    "Delay": 60,
    "Frequency Shifter": 60,
    "Pitch Shifter": 60,
    "Reverb": 60,
    "Gain/Mixer": 50,
    "Buffer": 40,
    "MIDI Input": 75,
    "MIDI Output": 55,
    "MIDI Control": 70,
    "MIDI Note Builder": 65,
    "Clock/Sequencer": 70,
    "Counter/Sequencer": 65,
    "Initialization": 30,
    "Audio Output": 20,
    "Audio Input": 80,
    "OpenGL Render": 75,
    "Matrix Processing": 70,
}


@dataclass
class DeviceTypeResult:
    """Result of M4L device type detection.

    Attributes:
        device_type: One of "audio_effect", "instrument", "midi_effect", "uncertain"
        confidence: 0.0-1.0, where 1.0 = unambiguous detection (per D-03)
        evidence: Which key objects were found in the patch
    """
    device_type: str
    confidence: float
    evidence: dict[str, bool]


def detect_device_type(patch_dict: dict) -> DeviceTypeResult:
    """Detect M4L device type from patch structure.

    Scans top-level boxes for plugin~, plugout~, midiin, midiout, dac~, ezdac~.
    Returns definitive type for unambiguous patterns, "uncertain" for ambiguous.

    Per D-01: Unambiguous patterns return definitive type. Ambiguous patterns
    (e.g., plugin~ + midiin) return "uncertain" so the system asks the user.
    Per D-02: Works on raw patch_dict (both /max-onboard and /max-new flows).
    Per D-03: Confidence is numeric 0.0-1.0 for downstream threshold setting.
    """
    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])

    has_plugin = False
    has_plugout = False
    has_midiin = False
    has_midiout = False
    has_dac = False

    for box_entry in boxes:
        box = box_entry.get("box", {})
        text = box.get("text", "")
        if not text:
            continue
        obj_name = text.split()[0]
        if obj_name == "plugin~":
            has_plugin = True
        elif obj_name == "plugout~":
            has_plugout = True
        elif obj_name == "midiin":
            has_midiin = True
        elif obj_name == "midiout":
            has_midiout = True
        elif obj_name in ("dac~", "ezdac~"):
            has_dac = True

    evidence = {
        "plugin~": has_plugin,
        "plugout~": has_plugout,
        "midiin": has_midiin,
        "midiout": has_midiout,
        "dac~": has_dac,
    }

    # Unambiguous patterns (per D-01)
    if has_midiin and has_midiout and not has_plugin and not has_plugout:
        return DeviceTypeResult("midi_effect", 1.0, evidence)
    if has_plugin and has_plugout and not has_midiin and not has_midiout:
        return DeviceTypeResult("audio_effect", 1.0, evidence)
    if has_plugout and has_midiin and not has_plugin:
        return DeviceTypeResult("instrument", 0.9, evidence)

    # Counter-signal: dac~ without plugout~ suggests non-M4L patch
    if has_dac and not has_plugout:
        return DeviceTypeResult("uncertain", 0.3, evidence)

    # Ambiguous: mixed signals -- ask user (per D-01)
    if has_plugin and has_midiin:
        return DeviceTypeResult("uncertain", 0.5, evidence)

    # No M4L objects found
    return DeviceTypeResult("uncertain", 0.0, evidence)


class AnalysisMixin:
    """Patch analysis methods mixed into Patcher.

    Expects ``self.boxes``, ``self.lines``, ``self.db``, and graph methods
    (``connected_components``, ``downstream``, ``_build_adj``,
    ``_resolve_send_receive_pairs``) to be provided by the host class.
    """

    def _classify_domain(self, box: "Box") -> str:
        """Classify a box's domain using DB lookup with heuristic fallback.

        Returns one of: "Max", "MSP", "Jitter", "MC", "M4L", "Gen",
        "Packages", "RNBO", or "External/Unknown".
        """
        # Try DB lookup first
        if self.db:
            obj_data = self.db.lookup(box.name)
            if obj_data and "domain" in obj_data:
                return obj_data["domain"]

        # Heuristic fallback for unknown objects
        # Check prefixes BEFORE tilde suffix -- mc.foo~ is MC, not MSP
        name = box.name
        if name.startswith("jit."):
            return "Jitter"
        if name.startswith("mc."):
            return "MC"
        if name.startswith("live."):
            return "M4L"
        if name.endswith("~"):
            return "MSP"
        # Check maxclass for UI objects
        if box.maxclass in UI_MAXCLASSES and box.maxclass not in (
            "newobj", "comment", "message",
        ):
            return "Max"
        return "External/Unknown"

    def _resolve_send_receive_pairs(
        self,
    ) -> dict[str, tuple[list[str], list[str]]]:
        """Build mapping: channel_name -> (sender_box_ids, receiver_box_ids).

        Scans self.boxes for send~/receive~ (and aliases s~/r~, send/receive,
        s/r). Boxes with empty args are skipped.
        """
        pairs: dict[str, tuple[list[str], list[str]]] = {}
        send_names = {"send~", "send", "s~", "s"}
        recv_names = {"receive~", "receive", "r~", "r"}
        for box in self.boxes:
            if box.name in send_names and box.args:
                channel = box.args[0]
                pairs.setdefault(channel, ([], []))
                pairs[channel][0].append(box.id)
            elif box.name in recv_names and box.args:
                channel = box.args[0]
                pairs.setdefault(channel, ([], []))
                pairs[channel][1].append(box.id)
        return pairs

    def _merge_components_by_send_receive(
        self,
        components: "list[list[Box]]",
    ) -> "list[list[Box]]":
        """Merge connected components linked by send~/receive~ name pairs.

        Uses union-find to merge components that share a send/receive channel.
        Returns merged components sorted largest-first.
        """
        if not components:
            return []

        # Build box_id -> component_index mapping
        box_to_comp: dict[str, int] = {}
        for i, comp in enumerate(components):
            for box in comp:
                box_to_comp[box.id] = i

        # Union-find
        parent = list(range(len(components)))

        def find(x: int) -> int:
            while parent[x] != x:
                parent[x] = parent[parent[x]]
                x = parent[x]
            return x

        def union(a: int, b: int) -> None:
            ra, rb = find(a), find(b)
            if ra != rb:
                parent[rb] = ra

        # Find send/receive pairs and union their components
        pairs = self._resolve_send_receive_pairs()
        for _channel, (senders, receivers) in pairs.items():
            comp_indices: set[int] = set()
            for box_id in senders + receivers:
                if box_id in box_to_comp:
                    comp_indices.add(box_to_comp[box_id])
            indices = list(comp_indices)
            for i in range(1, len(indices)):
                union(indices[0], indices[i])

        # Rebuild merged components
        merged: dict[int, list[Box]] = {}
        for i, comp in enumerate(components):
            root = find(i)
            merged.setdefault(root, []).extend(comp)

        result = list(merged.values())
        result.sort(key=lambda c: len(c), reverse=True)
        return result

    def _name_section(
        self,
        boxes: "list[Box]",
        section_num: int = 0,
    ) -> str:
        """Auto-name a section from its signature objects.

        Uses SECTION_SIGNATURES to find labels, picks the highest-priority
        label when multiple signatures are found. Falls back to
        "Section {section_num}" when no signatures match.

        Args:
            boxes: The boxes in the section.
            section_num: Fallback section number (used if no signature found).

        Returns:
            The section name string.
        """
        best_name: str | None = None
        best_priority = -1
        for box in boxes:
            label = SECTION_SIGNATURES.get(box.name)
            if label:
                priority = _SECTION_NAME_PRIORITY.get(label, 0)
                if priority > best_priority:
                    best_priority = priority
                    best_name = label
        if best_name:
            return best_name
        return f"Section {section_num}"

    def _analyze_sections(self) -> str:
        """Detect functional sections via connected components + send/receive merging.

        Filters out single-element groups consisting of only a comment or panel.
        Merges components linked by send~/receive~ or send/receive name pairs.
        Auto-names each section from signature objects.

        Returns:
            Markdown string with "## Sections" header.
        """
        components = self.connected_components()

        # Filter out comment/panel-only single-element groups
        filtered: list[list[Box]] = []
        for comp in components:
            if len(comp) == 1 and comp[0].maxclass in ("comment", "panel"):
                continue
            filtered.append(comp)

        # Merge via send/receive pairs
        merged = self._merge_components_by_send_receive(filtered)

        lines = ["## Sections", ""]
        if not merged:
            lines.append("(no sections detected)")
            return "\n".join(lines)

        section_counter = 1
        for comp in merged:
            name = self._name_section(comp, section_num=section_counter)
            if name.startswith("Section "):
                section_counter += 1
            obj_count = len(comp)
            # Build 1-line description from key objects (top 3 unique names)
            unique_names: list[str] = []
            seen: set[str] = set()
            for box in comp:
                if box.name not in seen and box.maxclass != "comment":
                    seen.add(box.name)
                    unique_names.append(box.name)
                    if len(unique_names) >= 3:
                        break
            desc = ", ".join(unique_names)
            lines.append(f"- **{name}** ({obj_count} objects) -- {desc}")

        return "\n".join(lines)

    # -- Complexity metrics ---------------------------------------------------

    def _count_recursive(self) -> tuple[int, int, int]:
        """Recursively count objects, connections, and max nesting depth.

        Returns:
            (total_objects, total_connections, max_depth)
        """
        total_objs = len(self.boxes)
        total_conns = len(self.lines)
        max_depth = 0
        for box in self.boxes:
            if box._inner_patcher is not None:
                sub_objs, sub_conns, sub_depth = box._inner_patcher._count_recursive()
                total_objs += sub_objs
                total_conns += sub_conns
                max_depth = max(max_depth, sub_depth + 1)
        return total_objs, total_conns, max_depth

    def _analyze_complexity(self) -> str:
        """Compute complexity metrics for the patch.

        Includes top-level counts, recursive totals, unique object types,
        and domain breakdown percentages.

        Returns:
            Markdown string with "## Overview" header.
        """
        top_objects = len(self.boxes)
        top_connections = len(self.lines)
        total_objects, total_connections, max_depth = self._count_recursive()
        unique_names = len({b.name for b in self.boxes})

        # Domain breakdown
        domain_counts: dict[str, int] = {}
        for box in self.boxes:
            domain = self._classify_domain(box)
            domain_counts[domain] = domain_counts.get(domain, 0) + 1

        lines = ["## Overview", ""]
        lines.append(f"- **Objects:** {top_objects} (top level), {total_objects} (recursive total)")
        lines.append(f"- **Connections:** {top_connections} (top level), {total_connections} (recursive total)")
        lines.append(f"- **Max nesting depth:** {max_depth}")
        lines.append(f"- **Unique object types:** {unique_names}")

        if domain_counts and top_objects > 0:
            parts = []
            for domain, count in sorted(domain_counts.items(), key=lambda x: -x[1]):
                pct = round(100 * count / top_objects)
                parts.append(f"{domain} {pct}%")
            lines.append(f"- **Domain breakdown:** {', '.join(parts)}")

        return "\n".join(lines)

    # -- Object inventory -----------------------------------------------------

    def _analyze_inventory(self) -> str:
        """Group top-level boxes by domain with counts and key objects.

        Returns:
            Markdown string with "## Object Inventory" header and table.
        """
        domain_boxes: dict[str, list[str]] = {}
        for box in self.boxes:
            domain = self._classify_domain(box)
            domain_boxes.setdefault(domain, []).append(box.name)

        lines = ["## Object Inventory", ""]
        if not domain_boxes:
            lines.append("(no objects)")
            return "\n".join(lines)

        lines.append("| Domain | Count | Key Objects |")
        lines.append("|--------|-------|-------------|")
        for domain, names in sorted(domain_boxes.items(), key=lambda x: -len(x[1])):
            count = len(names)
            top_objs = Counter(names).most_common(5)
            key_str = ", ".join(f"{n}({c})" if c > 1 else n for n, c in top_objs)
            lines.append(f"| {domain} | {count} | {key_str} |")

        return "\n".join(lines)

    # -- Signal chain tracing -------------------------------------------------

    def _analyze_signal_chains(self) -> str:
        """Trace signal chains from audio sources and render as trees.

        Finds signal chain roots (~ objects with no signal inputs), builds
        trees via DFS, and integrates send~/receive~ wireless connections.

        Returns:
            Markdown string with "## Signal Flow" header.
        """
        forward, reverse, box_map = self._build_adj(signal_only=True)

        # Find signal chain roots: ~ objects with no signal-rate inputs
        roots: list[str] = []
        for box in self.boxes:
            if not box.name.endswith("~"):
                continue
            if box.id not in reverse:
                roots.append(box.id)

        if not roots:
            return "## Signal Flow\n\n(no signal objects detected)"

        # Build send~/receive~ mapping for wireless connections
        sr_pairs = self._resolve_send_receive_pairs()
        # Map send~ box_id -> channel name for wireless annotation
        send_channels: dict[str, str] = {}
        recv_channels: dict[str, list[str]] = {}  # channel -> receiver box_ids
        for channel, (senders, receivers) in sr_pairs.items():
            for sid in senders:
                send_channels[sid] = channel
            recv_channels[channel] = receivers

        lines = ["## Signal Flow", ""]
        visited_global: set[str] = set()

        def render_tree(box_id: str, indent: int, visited: set[str]) -> None:
            box = box_map.get(box_id)
            if box is None:
                return
            prefix = "  " * indent + ("-> " if indent > 0 else "")
            label = box.text if box.text else box.name
            lines.append(f"{prefix}{label}")
            visited.add(box_id)
            visited_global.add(box_id)

            # Check if this is a send~ -- show wireless continuation
            if box_id in send_channels:
                channel = send_channels[box_id]
                for recv_id in recv_channels.get(channel, []):
                    recv_box = box_map.get(recv_id)
                    if recv_box and recv_id not in visited:
                        wireless_label = f"...-> receive~ {channel} (wireless)"
                        lines.append("  " * (indent + 1) + wireless_label)
                        visited.add(recv_id)
                        visited_global.add(recv_id)
                        # Continue tree from receive~'s downstream
                        for neighbor_id, _ in forward.get(recv_id, []):
                            if neighbor_id not in visited:
                                render_tree(neighbor_id, indent + 2, visited)
                return

            # Normal downstream children
            for neighbor_id, _ in forward.get(box_id, []):
                if neighbor_id not in visited:
                    render_tree(neighbor_id, indent + 1, visited)

        for root_id in roots:
            if root_id not in visited_global:
                render_tree(root_id, 0, set())
                lines.append("")

        return "\n".join(lines).rstrip()

    # -- Control flow paths ---------------------------------------------------

    def _analyze_control_paths(self) -> str:
        """Show notable control flow origins and their downstream chains.

        Traces from loadbang, notein, ctlin, midiin, metro, counter objects.
        Shows first 3-5 downstream objects per origin.

        Returns:
            Markdown string with "## Control Flow" header.
        """
        notable_origins = {"loadbang", "notein", "ctlin", "midiin", "metro", "counter"}
        forward, _reverse, box_map = self._build_adj(signal_only=False)

        origins: list[Box] = []
        for box in self.boxes:
            if box.name in notable_origins:
                origins.append(box)

        if not origins:
            return "## Control Flow\n\n(no notable control sources detected)"

        lines = ["## Control Flow", ""]
        for origin in origins:
            # BFS to get first few downstream objects
            chain: list[str] = []
            visited: set[str] = {origin.id}
            queue: deque[str] = deque()
            for neighbor_id, _ in forward.get(origin.id, []):
                if neighbor_id not in visited:
                    queue.append(neighbor_id)
            while queue and len(chain) < 5:
                nid = queue.popleft()
                if nid in visited:
                    continue
                visited.add(nid)
                nbox = box_map.get(nid)
                if nbox:
                    chain.append(nbox.name)
                    for next_id, _ in forward.get(nid, []):
                        if next_id not in visited:
                            queue.append(next_id)

            chain_str = " -> ".join(chain)
            if len(chain) >= 5:
                chain_str += " -> ..."
            origin_label = origin.text if origin.text else origin.name
            lines.append(f"- **{origin_label}** -> {chain_str}")

        return "\n".join(lines)

    # -- Subpatcher hierarchy -------------------------------------------------

    def _hierarchy_lines(self, depth: int = 0) -> list[str]:
        """Build indented hierarchy of subpatchers (recursive helper).

        Args:
            depth: Current indentation depth.

        Returns:
            List of formatted lines.
        """
        lines: list[str] = []
        for box in self.boxes:
            if box._inner_patcher is not None:
                indent = "  " * depth
                sub_name = box.args[0] if box.args else box.name
                inner_count = len(box._inner_patcher.boxes)
                lines.append(f"{indent}- **{sub_name}** ({inner_count} objects)")
                lines.extend(box._inner_patcher._hierarchy_lines(depth + 1))
        return lines

    def _analyze_hierarchy(self) -> str:
        """List subpatcher tree with indentation and object counts.

        Returns:
            Markdown string with "## Subpatchers" header.
        """
        hier_lines = self._hierarchy_lines()
        lines = ["## Subpatchers", ""]
        if hier_lines:
            lines.extend(hier_lines)
        else:
            lines.append("(none)")
        return "\n".join(lines)

    # -- Parameters / UI Controls ---------------------------------------------

    def _analyze_parameters(self) -> str:
        """List UI controls and parameter objects.

        Detects objects by maxclass against a known set of UI control types.
        Uses varname from extra_attrs as label when available.

        Returns:
            Markdown string with "## Parameters / UI Controls" header.
        """
        ui_controls = {
            "slider", "dial", "rslider", "multislider",
            "number", "flonum", "toggle", "button",
            "kslider", "nslider", "umenu", "textbutton",
            "tab", "gain~", "live.dial", "live.slider",
            "live.numbox", "live.toggle", "live.button",
            "live.menu", "live.tab", "live.gain~",
        }
        params: list[str] = []
        for box in self.boxes:
            if box.maxclass in ui_controls:
                varname = box.extra_attrs.get("varname", "")
                label = varname if varname else box.maxclass
                params.append(f"- {label} ({box.maxclass})")

        lines = ["## Parameters / UI Controls", ""]
        if params:
            lines.extend(params)
        else:
            lines.append("(none detected)")
        return "\n".join(lines)

    # -- Public analyze method ------------------------------------------------

    def analyze(self) -> str:
        """Produce structured Markdown summary of patch contents.

        Computes all analysis facets and assembles them into a single
        Markdown string covering: complexity overview, object inventory,
        functional sections, signal flow chains, control flow paths,
        subpatcher hierarchy, and parameters.

        Returns:
            Complete Markdown analysis string.
        """
        complexity = self._analyze_complexity()
        inventory = self._analyze_inventory()
        sections = self._analyze_sections()
        signal_chains = self._analyze_signal_chains()
        control_paths = self._analyze_control_paths()
        hierarchy = self._analyze_hierarchy()
        parameters = self._analyze_parameters()

        parts = [
            "# Patch Analysis",
            "",
            complexity,
            "",
            inventory,
            "",
            sections,
            "",
            signal_chains,
            "",
            control_paths,
            "",
            hierarchy,
            "",
            parameters,
        ]
        return "\n".join(parts)
