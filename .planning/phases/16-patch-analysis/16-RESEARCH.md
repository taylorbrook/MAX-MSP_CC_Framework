# Phase 16: Patch Analysis - Research

**Researched:** 2026-03-16
**Domain:** MAX/MSP patch analysis -- static analysis of .maxpat JSON to produce structured summaries
**Confidence:** HIGH

## Summary

Phase 16 builds a patch analyzer that reads any .maxpat file and produces a human-readable Markdown summary of its structure, signal flow, control paths, and functional sections. The implementation sits entirely within the existing `Patcher` class as a new `analyze()` method, leveraging Phase 14's search infrastructure (`find_boxes`) and Phase 15's graph traversal (`signal_path`, `connected_components`, `upstream`, `downstream`).

The core challenge is section detection: merging connected components by resolving send~/receive~ (and send/receive) name pairs as implicit connections, then auto-naming sections from signature objects. Signal chain tracing needs tree-style rendering (not linearization) to capture fork/merge points. All domain classification for known objects uses the ObjectDatabase's `domain` field; unknown objects use naming heuristics (~ suffix, jit. prefix, mc. prefix).

No new external dependencies are needed. Everything is built on existing codebase + Python stdlib. The ObjectDatabase provides authoritative domain classification for ~2000 known objects, aliases.json resolves shorthand names, and the maxclass_map.py UI_MAXCLASSES set identifies UI/parameter controls.

**Primary recommendation:** Implement analyze() as a single Patcher method that computes all analysis facets (inventory, signal chains, sections, hierarchy, parameters, complexity) and returns a Markdown string. Use a private helper per facet (_inventory, _signal_chains, _sections, etc.) to keep the method organized.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- Analysis includes ALL of: signal flow chains, control flow paths, object inventory by domain, subpatcher hierarchy map, parameter/UI control list, and complexity metrics
- Both signal and control flow traced -- MIDI input chains, loadbang initialization paths, message routing alongside audio chains
- Complexity metrics at the top: total objects, connections, max nesting depth, unique object types, domain breakdown percentages
- Signal chain presentation uses tree structure showing every fork and merge point -- not linearized or flat list
- Concise overview by default -- metrics summary, section list with 1-line descriptions, signal chain tree (object names), parameter list
- Primary heuristic: connected components (Phase 15's connected_components()) enhanced with send~/receive~ pair matching -- objects linked by matching send~/receive~ names are treated as implicitly connected, merging those components
- Also resolve send/receive (control rate) pairs by matching names for section merging
- Auto-name sections from key/signature objects using a keyword-to-label mapping (cycle~ -> "Oscillator", svf~ -> "Filter", adsr~ -> "Envelope", etc.) with fallback to "Section N"
- Name sections only -- no inter-section relationship inference (modulation detection, sidechain identification, etc.)
- Section detection at top level only -- subpatchers listed in hierarchy map but not further decomposed into sections
- Markdown string returned directly from analyze() method
- analyze() is a Patcher method (not standalone module)
- /max-onboard prints analysis to conversation only -- no file artifact saved
- Best-guess classification from naming heuristics: ~ suffix -> signal/MSP domain, jit. prefix -> Jitter, mc. prefix -> multichannel, etc. Fallback to "External/Unknown"
- Silent classification -- unknown objects included in normal inventory without flagging
- Unknown ~ objects included in signal chain tracing -- chain follows connections, not DB knowledge
- Send~/receive~ pairs resolved by matching name arguments and treated as implicit connections for both section detection and chain tracing

### Claude's Discretion
- Keyword-to-label mapping dictionary contents (which objects map to which section names)
- Signal chain tree rendering format details (indentation, arrow style, etc.)
- Control flow tracing depth and presentation
- Internal implementation of send~/receive~ name matching
- How parameter/UI controls are detected (by maxclass list vs DB metadata)
- Complexity metric calculation details

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| AN-01 | Patch analyzer produces structured summary -- object inventory by domain, signal flow chains, control flow paths, subpatcher map, parameter list, complexity metrics | analyze() method on Patcher; ObjectDatabase provides domain field; _build_adj/signal_path provide chain tracing; connected_components provides section base; UI_MAXCLASSES provides parameter detection |
| AN-02 | /max-onboard command analyzes an existing .maxpat file from any source, builds understanding of its structure, and produces a human-readable summary | read_patch() loads any .maxpat; analyze() returns Markdown string; /max-onboard is a slash command that prints output (wired in Phase 17) |
| AN-03 | Patch analyzer identifies functional sections by connected components and spatial proximity -- grouping objects into logical units | connected_components() + send~/receive~ name pair resolution + signature object keyword mapping |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Python stdlib | 3.14 | All implementation | Zero dependencies policy (STATE.md decision) |
| src.maxpat.patcher | existing | Patcher, Box, Patchline data model | Existing codebase -- analyze() lives here |
| src.maxpat.db_lookup | existing | ObjectDatabase for domain lookup | Authoritative object domain classification |
| src.maxpat.hooks | existing | read_patch() for loading .maxpat | Entry point for /max-onboard |
| src.maxpat.maxclass_map | existing | UI_MAXCLASSES for parameter detection | Distinguishes UI controls from non-UI objects |

### Supporting
| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| collections.deque | stdlib | BFS traversal (already used) | Section merging, chain tracing |
| collections.Counter | stdlib | Object counting for inventory | Domain breakdown, object frequency |
| src.maxpat.aliases.json | existing | Alias resolution (s~ -> send~) | Normalizing send/receive shorthand |

### Alternatives Considered
None. The locked decision specifies analyze() as a Patcher method using existing infrastructure. No new dependencies.

## Architecture Patterns

### Recommended Project Structure
```
src/maxpat/
    patcher.py          # analyze() method added to Patcher class
                        # Private helpers: _analyze_inventory, _analyze_signal_chains,
                        # _analyze_sections, _analyze_hierarchy, _analyze_parameters,
                        # _analyze_complexity, _resolve_send_receive_pairs
tests/
    test_analysis.py    # New test file for analyze() method
```

### Pattern 1: analyze() Method with Private Facet Helpers
**What:** Single public `analyze()` method on Patcher that calls private helper methods for each analysis facet.
**When to use:** This is the only pattern. analyze() computes all facets and assembles them into a Markdown string.
**Example:**
```python
# In Patcher class
def analyze(self) -> str:
    """Produce structured Markdown summary of patch contents."""
    complexity = self._analyze_complexity()
    inventory = self._analyze_inventory()
    sections = self._analyze_sections()
    signal_chains = self._analyze_signal_chains()
    control_paths = self._analyze_control_paths()
    hierarchy = self._analyze_hierarchy()
    parameters = self._analyze_parameters()

    lines = []
    lines.append(f"# Patch Analysis")
    lines.append("")
    lines.append(complexity)
    lines.append(inventory)
    lines.append(sections)
    lines.append(signal_chains)
    lines.append(control_paths)
    lines.append(hierarchy)
    lines.append(parameters)
    return "\n".join(lines)
```

### Pattern 2: Send~/Receive~ Pair Resolution
**What:** Scan all boxes for send~/receive~ (and send/receive, s~/r~, s/r) objects, extract name arguments, build a mapping of name -> (sender_box_ids, receiver_box_ids), then use this mapping to merge connected components.
**When to use:** Section detection and signal chain tracing.
**Example:**
```python
def _resolve_send_receive_pairs(self) -> dict[str, tuple[list[str], list[str]]]:
    """Build mapping: channel_name -> (sender_ids, receiver_ids)."""
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
```

### Pattern 3: Section Auto-Naming from Signature Objects
**What:** After merging components, scan each component's boxes for signature object names (cycle~, svf~, adsr~, dac~, etc.) and pick the most descriptive label using a priority-ordered keyword-to-label mapping.
**When to use:** Section naming.
**Example:**
```python
SECTION_SIGNATURES: dict[str, str] = {
    # Audio sources
    "cycle~": "Oscillator",
    "saw~": "Oscillator",
    "rect~": "Oscillator",
    "tri~": "Oscillator",
    "noise~": "Noise Generator",
    "sfplay~": "Sample Player",
    "play~": "Sample Player",
    "groove~": "Sample Player",
    "buffer~": "Buffer",
    # Processing
    "svf~": "Filter",
    "biquad~": "Filter",
    "onepole~": "Filter",
    "reson~": "Filter",
    "filtergraph~": "Filter",
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
    # Output
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
```

### Pattern 4: Signal Chain Tree Rendering
**What:** For each audio source (objects with no signal inputs or only `adc~`/`ezadc~` sources), trace downstream through signal connections, building a tree structure that captures fork points where one object feeds multiple downstream paths.
**When to use:** Signal chain section of analysis output.
**Example output format:**
```
### Signal Flow

cycle~ 440
  -> *~ 0.5
    -> svf~ 1000 0.5
      -> *~ (envelope)
        -> dac~ (L)
        -> dac~ (R)

adc~ 1
  -> send~ live-input
  ...-> receive~ live-input  (wireless)
    -> svf~
      -> dac~
```

### Pattern 5: Complexity Metrics Calculation
**What:** Compute total objects, total connections, max nesting depth, unique object types, and domain breakdown percentages by recursively walking the patcher tree.
**When to use:** Top of analysis output.
**Key metrics:**
- Total objects (recursive into subpatchers)
- Total connections (recursive)
- Max nesting depth (0 = flat, 1 = has subpatchers, etc.)
- Unique object names (count of distinct `box.name` values)
- Domain breakdown: MSP %, Max %, Jitter %, MC %, etc. (from DB lookup, with heuristic fallback)

### Anti-Patterns to Avoid
- **Linearizing signal chains:** CONTEXT.md explicitly says tree structure, not flat list. Every fork point must show branches.
- **Flagging unknown objects:** CONTEXT.md says "silent classification" -- unknown objects appear in inventory without warnings. Goal is patch understanding, not DB coverage auditing.
- **Deep section analysis of subpatchers:** CONTEXT.md says section detection at top level only. Subpatchers listed in hierarchy, not decomposed into sections.
- **Relationship inference between sections:** No modulation detection, sidechain identification, or inter-section flow inference. Just name sections.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Connected components | Custom BFS grouping | `self.connected_components()` | Already implemented in Phase 15, tested |
| Signal path tracing | Custom signal graph walk | `self.signal_path(box)` + `self.downstream(box, signal_only=True)` | Already implemented, handles subpatcher crossing |
| Object search | Custom box iteration | `self.find_boxes(name=..., recursive=True)` | Already implemented, handles alias resolution |
| Alias resolution | Custom name mapping | `self.db._aliases` dict | Already loaded from aliases.json |
| Domain classification (known) | Custom object-to-domain mapping | `self.db.lookup(name)["domain"]` | Already has 2000+ objects classified by domain |
| UI object detection | Custom list of UI types | `UI_MAXCLASSES` from maxclass_map.py | Already maintained and verified |
| Adjacency building | Custom line iteration | `self._build_adj(signal_only=...)` | Already implemented with sorted output |

**Key insight:** Phase 16 is primarily an assembly phase -- combining existing primitives (search, traversal, database lookup) into a coherent analysis output. The infrastructure is already built; the new work is orchestration and presentation.

## Common Pitfalls

### Pitfall 1: Missing Alias Resolution for Send/Receive
**What goes wrong:** Searching for `send~` but missing `s~` objects, or searching for `send` but missing `s` objects.
**Why it happens:** aliases.json maps `s~` -> `send~`, `r~` -> `receive~`, `s` -> `send`, `r` -> `receive`. Real patches use the short forms frequently.
**How to avoid:** Search for ALL forms: `send~`, `s~` (signal) and `send`, `s` (control). Check `box.name` against both canonical and alias forms.
**Warning signs:** Sections that should be merged remain separate; signal chains appear disconnected at send~/receive~ boundaries.

### Pitfall 2: Box.name vs Box.text for Object Identification
**What goes wrong:** Using `box.text` ("send~ live-input") to identify an object type instead of `box.name` ("send~").
**Why it happens:** For `maxclass="newobj"`, the text field contains the full text including arguments. `box.name` is already parsed to just the object name (first word), and `box.args` contains the rest.
**How to avoid:** Always use `box.name` for object identification and `box.args` for argument extraction (e.g., send~/receive~ channel names).
**Warning signs:** Name matching fails on objects with arguments.

### Pitfall 3: Subpatcher Boxes With Inner Patchers
**What goes wrong:** Counting inner patcher objects in top-level inventory or treating subpatcher inlet/outlet objects as part of the parent patch.
**Why it happens:** `box._inner_patcher` gives access to the full inner Patcher including its boxes and lines. Walking into it unintentionally inflates counts.
**How to avoid:** For inventory, signal chains, and section detection -- operate on `self.boxes` (top level) only. Only recurse into `_inner_patcher` explicitly for hierarchy mapping and recursive complexity metrics.
**Warning signs:** Inflated object counts; inlet/outlet objects appearing in signal chains.

### Pitfall 4: Comment/Panel Objects in Section Detection
**What goes wrong:** Comments and panel boxes appear as disconnected single-element components, creating noise in section detection.
**Why it happens:** Comments and panels have no connections (no inlets/outlets effectively). `connected_components()` returns them as single-element groups.
**How to avoid:** Filter out boxes with `maxclass` in `{"comment", "panel"}` before section detection (or exclude single-element groups that contain only comments/panels from the output).
**Warning signs:** Sections named "Section 1", "Section 2" that are just comment labels.

### Pitfall 5: Signal Chain Sources Misidentification
**What goes wrong:** Starting signal chain trace from the wrong objects (e.g., from a `*~` in the middle of a chain).
**Why it happens:** Need to identify true audio sources -- objects with no signal inputs or whose signal inputs come only from non-~ objects.
**How to avoid:** Build signal-only adjacency (`_build_adj(signal_only=True)`), find ~ objects that have no entries in the reverse adjacency (no signal inputs), or are `adc~`/`ezadc~`. These are chain roots.
**Warning signs:** Partial signal chains; same objects appearing in multiple "chains" when they should be one tree.

### Pitfall 6: Send~/Receive~ Creating Cycles
**What goes wrong:** Treating send~/receive~ as bidirectional connections for component merging and inadvertently creating infinite traversal loops in chain tracing.
**Why it happens:** Send~/receive~ is one-directional (send -> receive) but for component merging it is treated as undirected connectivity.
**How to avoid:** For section detection (component merging), treat send~/receive~ pairs as undirected edges. For signal chain tracing, treat them as directed edges (send -> receive only). Use visited sets in both cases.
**Warning signs:** Infinite loops in chain tracing; stack overflow.

## Code Examples

### Example 1: Domain Classification with Heuristic Fallback
```python
def _classify_domain(self, box: Box) -> str:
    """Classify a box's domain using DB lookup with heuristic fallback."""
    # Try DB lookup first
    if self.db:
        obj_data = self.db.lookup(box.name)
        if obj_data and "domain" in obj_data:
            return obj_data["domain"]  # "Max", "MSP", "Jitter", etc.

    # Heuristic fallback for unknown objects
    name = box.name
    if name.endswith("~"):
        return "MSP"
    if name.startswith("jit."):
        return "Jitter"
    if name.startswith("mc."):
        return "MC"
    if name.startswith("live."):
        return "M4L"
    # Check maxclass for UI objects
    if box.maxclass in UI_MAXCLASSES and box.maxclass not in ("newobj", "comment", "message"):
        return "Max"
    return "External/Unknown"
```

### Example 2: Component Merging via Send/Receive Pairs
```python
def _merge_components_by_send_receive(
    self,
    components: list[list[Box]],
) -> list[list[Box]]:
    """Merge connected components linked by send~/receive~ name pairs."""
    # Build box_id -> component_index mapping
    box_to_comp: dict[str, int] = {}
    for i, comp in enumerate(components):
        for box in comp:
            box_to_comp[box.id] = i

    # Find send/receive pairs
    pairs = self._resolve_send_receive_pairs()

    # Union-find style merging
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

    for channel, (senders, receivers) in pairs.items():
        comp_indices = set()
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
```

### Example 3: Signal Chain Tree Building
```python
def _build_signal_tree(self, root_id: str, forward: dict, box_map: dict, visited: set) -> dict:
    """Build a tree dict from a signal chain root."""
    box = box_map[root_id]
    node = {"name": box.name, "args": box.args, "children": []}
    visited.add(root_id)
    for neighbor_id, outlet_idx in forward.get(root_id, []):
        if neighbor_id not in visited and box_map.get(neighbor_id, Box).__class__.__name__:
            child = self._build_signal_tree(neighbor_id, forward, box_map, visited)
            node["children"].append(child)
    return node
```

### Example 4: Parameter/UI Control Detection
```python
def _analyze_parameters(self) -> str:
    """List UI controls and parameter objects."""
    params = []
    # UI objects by maxclass
    ui_controls = {"slider", "dial", "rslider", "multislider",
                   "number", "flonum", "toggle", "button",
                   "kslider", "nslider", "umenu", "textbutton",
                   "tab", "gain~", "live.dial", "live.slider",
                   "live.numbox", "live.toggle", "live.button",
                   "live.menu", "live.tab", "live.gain~"}
    for box in self.boxes:
        if box.maxclass in ui_controls:
            # Check for scripting name or varname
            varname = box.extra_attrs.get("varname", "")
            label = varname if varname else box.maxclass
            params.append(f"- {label} ({box.maxclass})")
    return "\n".join(params) if params else "(none detected)"
```

### Example 5: Subpatcher Hierarchy Map
```python
def _analyze_hierarchy(self, depth: int = 0) -> list[str]:
    """Build indented hierarchy of subpatchers."""
    lines = []
    for box in self.boxes:
        if box._inner_patcher is not None:
            indent = "  " * depth
            sub_name = box.args[0] if box.args else box.name
            inner_count = len(box._inner_patcher.boxes)
            lines.append(f"{indent}- **{sub_name}** ({inner_count} objects)")
            # Recurse into inner patcher
            lines.extend(
                box._inner_patcher._analyze_hierarchy(depth + 1)
            )
    return lines
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Manual patch reading | Automated Patcher.from_dict() | Phase 13 (2026-03-15) | Any .maxpat can be loaded programmatically |
| No graph queries | downstream/upstream/signal_path/connected_components | Phase 15 (2026-03-16) | Full graph traversal available |
| No search API | find_boxes/find_box with alias resolution | Phase 14 (2026-03-16) | Fast object lookup by any criteria |

**No deprecated items for this phase.** All infrastructure is newly built in v2.0.

## Open Questions

1. **Signal chain tree rendering: how deep before truncation?**
   - What we know: Small-medium patches (50-150 objects) will have manageable trees. Large patches could have very deep chains.
   - What's unclear: Whether an extremely deep chain (20+ levels) should be truncated with "..." or always shown in full.
   - Recommendation: Show full tree for now. Concise mode already limits to object names only (no attributes beyond args). Can add truncation later if users request it.

2. **Wireless connection rendering in signal chains**
   - What we know: send~/receive~ pairs create "wireless" connections that break the visual continuity of a signal chain tree.
   - What's unclear: Best way to show the "jump" from send~ to receive~ in tree rendering.
   - Recommendation: Use `...-> receive~ name (wireless)` notation to show the jump, as sketched in Pattern 4 above. The `...->` prefix visually indicates a wireless connection rather than a direct cable.

3. **Control flow tracing scope**
   - What we know: CONTEXT.md says trace MIDI input chains, loadbang paths, message routing. But "control flow" is essentially everything that isn't signal.
   - What's unclear: How much control flow detail to show in "concise overview" mode.
   - Recommendation: Show notable control flow origins only: loadbang chains, MIDI input chains (notein, ctlin), metro/clock chains. Don't enumerate every message path.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | pyproject.toml or implicit |
| Quick run command | `python3 -m pytest tests/test_analysis.py -x -q` |
| Full suite command | `python3 -m pytest tests/ -x -q` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| AN-01 | analyze() produces structured Markdown with all 6 facets | unit | `python3 -m pytest tests/test_analysis.py::TestAnalyze -x` | Wave 0 |
| AN-01 | Object inventory groups by domain correctly | unit | `python3 -m pytest tests/test_analysis.py::TestInventory -x` | Wave 0 |
| AN-01 | Signal chains traced from sources to sinks | unit | `python3 -m pytest tests/test_analysis.py::TestSignalChains -x` | Wave 0 |
| AN-01 | Complexity metrics computed recursively | unit | `python3 -m pytest tests/test_analysis.py::TestComplexity -x` | Wave 0 |
| AN-01 | Subpatcher hierarchy mapped | unit | `python3 -m pytest tests/test_analysis.py::TestHierarchy -x` | Wave 0 |
| AN-01 | Parameters/UI controls listed | unit | `python3 -m pytest tests/test_analysis.py::TestParameters -x` | Wave 0 |
| AN-02 | read_patch + analyze() produces summary for real .maxpat file | integration | `python3 -m pytest tests/test_analysis.py::TestOnboard -x` | Wave 0 |
| AN-03 | Sections detected via connected components | unit | `python3 -m pytest tests/test_analysis.py::TestSections -x` | Wave 0 |
| AN-03 | Sections merged by send~/receive~ name pairs | unit | `python3 -m pytest tests/test_analysis.py::TestSendReceiveMerge -x` | Wave 0 |
| AN-03 | Sections auto-named from signature objects | unit | `python3 -m pytest tests/test_analysis.py::TestSectionNaming -x` | Wave 0 |
| AN-03 | Alias forms (s~/r~/s/r) resolved for section merging | unit | `python3 -m pytest tests/test_analysis.py::TestAliasResolution -x` | Wave 0 |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/test_analysis.py -x -q`
- **Per wave merge:** `python3 -m pytest tests/ -x -q`
- **Phase gate:** Full suite green before `/gsd:verify-work`

### Wave 0 Gaps
- [ ] `tests/test_analysis.py` -- all analysis tests (new file)
- No framework install needed -- pytest already in use
- No shared fixtures needed beyond existing conftest.py (DB_ROOT, all_objects)

## Sources

### Primary (HIGH confidence)
- `src/maxpat/patcher.py` -- Patcher class, Box class, all graph traversal methods (connected_components, signal_path, downstream, upstream, _build_adj, find_boxes)
- `src/maxpat/hooks.py` -- read_patch() for loading .maxpat files
- `src/maxpat/db_lookup.py` -- ObjectDatabase with domain field, alias resolution
- `src/maxpat/maxclass_map.py` -- UI_MAXCLASSES set for parameter detection
- `.claude/max-objects/aliases.json` -- s~ -> send~, r~ -> receive~, s -> send, r -> receive
- `.claude/max-objects/relationships.json` -- send~/receive~ as required_pair
- Real patches analyzed: performancepatchtest (68 boxes, 43 lines, 7 subpatchers, send~/receive~ usage), scala-synth (135 boxes, 110 lines)
- `tests/test_patcher.py` -- Existing graph traversal tests (TestDownstream, TestUpstream, TestSignalPath, TestConnectedComponents)

### Secondary (MEDIUM confidence)
- `.planning/phases/16-patch-analysis/16-CONTEXT.md` -- All locked decisions and discretion areas
- `.planning/REQUIREMENTS.md` -- AN-01, AN-02, AN-03 requirement definitions

### Tertiary (LOW confidence)
None -- all findings verified against existing codebase.

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- all code exists and is tested in prior phases
- Architecture: HIGH -- analyze() pattern follows established Patcher method conventions; all primitives verified in codebase
- Pitfalls: HIGH -- identified from direct inspection of real .maxpat files and existing code behavior

**Research date:** 2026-03-16
**Valid until:** Indefinite -- this is internal codebase analysis, not external library research
