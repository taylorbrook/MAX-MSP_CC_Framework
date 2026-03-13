# Phase 8: Help Patch Audit Pipeline - Research

**Researched:** 2026-03-13
**Domain:** MAX/MSP help patch parsing, JSON analysis, object metadata extraction
**Confidence:** HIGH

## Summary

Phase 8 builds an offline audit tool that parses all 973 .maxhelp files from the MAX installation, extracts ground truth object metadata, and compares it against the current object database. The core technical challenge is parsing the recursive JSON structure of help patches (boxes inside subpatcher tabs), extracting outlet type arrays, inlet/outlet counts, box widths, argument patterns, and connection graphs, then producing a structured discrepancy report with confidence scores.

Research confirms that help files are standard JSON (.maxpat format) averaging 62KB each, parseable in under 0.2ms per file (all 973 in ~0.15 seconds). Each help file contains an average of 16 newobj boxes plus numerous UI widgets, with subpatcher tabs (depth 1-3) containing the actual working examples. The outlettype arrays in help patches use specific type strings ("signal", "bang", "int", "float", "list", "dictionary", "jit_matrix", "multichannelsignal") which are much richer than the DB's binary signal/control model. The audit must map help patch types to the DB's representation to identify discrepancies.

The existing database has 133 objects with empty inlets and 159 with empty outlets (223 unique objects with either empty). The overrides.json already contains 20 manually corrected objects (buffer~, info~, line~, curve~, play~, sfplay~, etc.) that represent expert knowledge and must never be overwritten. The RNBO domain has the most empty objects (43 each for inlets and outlets), but RNBO objects have no help files in the standard help directory, limiting what the audit can fix.

**Primary recommendation:** Build as a Python module at `src/maxpat/audit/` with a main entry point for CLI invocation and structured JSON output. Leverage the existing `db_lookup.py` ObjectDatabase class for comparison. Single-pass recursive traversal of all help files with per-object aggregation, confidence scoring based on instance agreement counts, and safe proposed-override generation.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- Claude decides tool location (src/maxpat/audit/ or tools/audit/ -- based on project conventions)
- Both a Python script (standalone invocation) and a thin slash command wrapper (/max-audit) for conversational access
- Single pass extraction with filtered views -- one traversal extracts all data types, flags/sub-commands filter the output (--outlets-only, --widths-only, etc.)
- Auto-detect MAX help path from /Applications/Max.app/Contents/Resources/C74/help/ (matching extraction-log.json), with --help-dir override flag
- JSON as primary output format (machine-readable, diffable, filterable)
- Discrepancies organized by object -- each object gets one entry with all its discrepancies (outlets, inlets, widths, args)
- Confidence scoring based on instance count: more help patch instances agreeing = higher confidence (e.g., 5/5 instances agree = high, 2/3 = medium)
- Audit output files live at .claude/max-objects/audit/ -- co-located with the database they audit
- Full recursive descent into all subpatcher tabs -- help files use tabs like 'Basic', 'Details', 'Arguments' containing real object instances
- Parse all .maxhelp files -- more data = better corrections
- Degenerate instance filtering: skip instances that have zero connections AND whose numoutlets/numinlets don't match the DB -- catches label objects without discarding legitimate sink objects (print, send, dac~ etc. with 0 outlets are kept)
- Build per-object outlet-to-inlet connection frequency tables -- valuable for validating outlet types (signal outlets should connect to signal inlets)
- Generate proposed-overrides.json as a separate file -- never auto-merge into overrides.json
- Manual merge happens in Phase 9 after human review
- Flag conflicts with existing manual corrections in overrides.json, never overwrite -- manual entries are always authoritative

### Claude's Discretion
- Tool location within project structure
- Proposed overrides format details (whether to include audit metadata inline or keep it pure)
- Internal architecture (class structure, module organization)
- Test strategy for the audit tool itself

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| AUDIT-01 | Help patch parser recursively descends into subpatcher tabs to find all object instances across 973 .maxhelp files | Help files use nested patcher dicts inside box dicts; recursive descent is straightforward. Subpatcher tabs are `maxclass: "newobj"` boxes with a `patcher` key. Average depth is 1-3 levels. |
| AUDIT-02 | Parser filters degenerate instances and extracts outlet types only from connected instances | Degenerate filtering requires cross-referencing box IDs against `lines` array. Connection data uses `["obj-id", outlet_index]` format. Legitimate 0-outlet objects (print, send, dac~) must be preserved. |
| AUDIT-03 | Outlet type audit compares DB signal/control types against help patch outlettype arrays | Help patches use specific strings ("signal", "bang", "int", "float", etc.) while DB uses binary signal:true/false. Mapping: "signal"/"multichannelsignal" = signal; everything else = control. 90 objects have varying outlettype patterns across instances (mostly math objects with int/float argument sensitivity). |
| AUDIT-04 | Inlet/outlet count validation cross-references DB counts against help patch instances | Help patch boxes have `numinlets` and `numoutlets` fields. Variable I/O objects produce different counts per instance. The existing `variable_io_rules` in overrides.json covers 12 objects. |
| AUDIT-05 | Per-object box width extraction from help patch patching_rect | Every box has `patching_rect: [x, y, width, height]`. Width is index 2. The current `sizing.py` uses character-count estimation; help patch widths are ground truth. |
| AUDIT-06 | Argument format extraction from help patch newobj text fields | Object text is `"name arg1 arg2 ..."`. Splitting on space gives arguments. Need to handle quoted strings, negative numbers, and @attribute syntax. |
| AUDIT-07 | Connection pattern extraction builds per-object outlet-to-inlet frequency tables | Lines use `{"patchline": {"source": ["obj-id", outlet], "destination": ["obj-id", inlet]}}`. Need to resolve obj-id to object name via box ID lookup within each patcher scope. |
| AUDIT-08 | Audit produces human-readable diff report with confidence scores | Confidence = agreement ratio: all instances agree = HIGH, majority agree = MEDIUM, split = LOW. Report structured as JSON per-object with all discrepancy types. |
| AUDIT-09 | Batch override generation writes proposed overrides, never overwriting existing manual corrections | Must load current overrides.json, check for existing entries, and flag conflicts. Proposed overrides must match the established format (objects dict with inlet/outlet arrays). |
| AUDIT-10 | Coverage tracker identifies and prioritizes 292 objects with empty I/O data | Research found 223 unique objects with empty inlets or outlets (133 empty inlets, 159 empty outlets). RNBO domain has the most (43 each) but lacks help files. Priority: objects with matching help files first. |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Python | 3.14 | Runtime (project already uses 3.14) | Project standard |
| json (stdlib) | built-in | Parse .maxhelp JSON files | Help files are JSON; no external parser needed |
| pathlib (stdlib) | built-in | File path handling | Project convention (used in db_lookup.py, conftest.py) |
| argparse (stdlib) | built-in | CLI argument parsing for standalone invocation | Stdlib, no dependency for simple flags |
| collections.Counter (stdlib) | built-in | Instance counting and frequency tables | Needed for confidence scoring aggregation |

### Supporting
| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| pytest | 9.0.2 | Test framework (already installed) | Testing audit tool correctness |
| src.maxpat.db_lookup.ObjectDatabase | existing | Load current DB for comparison | Core dependency -- comparison target |

### Alternatives Considered
| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| json stdlib | orjson/ujson | Marginal speed gain; not worth adding dependency since parsing is already 0.15s total |
| argparse | click/typer | More features but external dependency; argparse sufficient for simple flags |
| Manual JSON traversal | jsonpath-ng | Overkill; the structure is well-known and consistent |

**Installation:**
```bash
# No new dependencies needed -- everything is stdlib or already installed
```

## Architecture Patterns

### Recommended Project Structure
```
src/maxpat/audit/
    __init__.py          # Package init, version
    parser.py            # HelpPatchParser: recursive descent, box extraction
    analyzer.py          # AuditAnalyzer: comparison engine, confidence scoring
    reporter.py          # AuditReporter: JSON output formatting, diff generation
    overrides.py         # OverrideGenerator: proposed overrides creation, conflict detection
    cli.py               # CLI entry point with argparse (--help-dir, --outlets-only, etc.)
```

### Pattern 1: Recursive Patcher Traversal
**What:** Walk the nested patcher/boxes structure depth-first to collect all object instances.
**When to use:** Every help file parse.
**Example:**
```python
# Source: Verified from help file JSON structure analysis
def traverse_patcher(patcher: dict, depth: int = 0) -> list[BoxInstance]:
    """Recursively extract all object box instances from a patcher hierarchy."""
    instances = []

    # Build ID -> box map for this patcher scope (needed for connection resolution)
    id_map: dict[str, dict] = {}
    for box_wrapper in patcher.get("boxes", []):
        box = box_wrapper.get("box", {})
        box_id = box.get("id", "")
        id_map[box_id] = box

    # Extract connections for this scope
    connections = []
    for line_wrapper in patcher.get("lines", []):
        patchline = line_wrapper.get("patchline", {})
        source = patchline.get("source", [])      # ["obj-id", outlet_index]
        destination = patchline.get("destination", [])  # ["obj-id", inlet_index]
        if len(source) >= 2 and len(destination) >= 2:
            connections.append((source[0], source[1], destination[0], destination[1]))

    # Track which boxes have connections
    connected_ids = set()
    for src_id, _, dst_id, _ in connections:
        connected_ids.add(src_id)
        connected_ids.add(dst_id)

    # Extract newobj instances
    for box_id, box in id_map.items():
        maxclass = box.get("maxclass", "")
        text = box.get("text", "")
        if maxclass == "newobj" and text:
            obj_name = text.split()[0]
            instances.append(BoxInstance(
                name=obj_name,
                text=text,
                numinlets=box.get("numinlets", 0),
                numoutlets=box.get("numoutlets", 0),
                outlettype=box.get("outlettype", []),
                patching_rect=box.get("patching_rect", []),
                box_id=box_id,
                depth=depth,
                is_connected=box_id in connected_ids,
                connections=[(s, so, d, di) for s, so, d, di in connections
                             if s == box_id or d == box_id],
            ))

        # Recurse into subpatchers (tabs)
        if "patcher" in box:
            instances.extend(traverse_patcher(box["patcher"], depth + 1))

    return instances
```

### Pattern 2: Degenerate Instance Filtering
**What:** Filter out objects used as labels/decoration in help patches.
**When to use:** Before aggregation, after extraction.
**Example:**
```python
# Source: CONTEXT.md decision + verified analysis
def is_degenerate(instance: BoxInstance, db: ObjectDatabase) -> bool:
    """Check if an instance is a label/decoration, not a real working object.

    A degenerate instance has zero connections AND its I/O counts don't match
    the DB. Legitimate sink objects (print, send, dac~) with 0 outlets are kept
    because their counts match the DB even with no outgoing connections.
    """
    if instance.is_connected:
        return False  # Has connections -- real instance

    # No connections -- check if I/O counts match DB
    db_obj = db.lookup(instance.name)
    if db_obj is None:
        return True  # Unknown object with no connections -- degenerate

    db_inlets, db_outlets = db.compute_io_counts(instance.name)
    # Allow some flexibility for variable_io objects
    if db_obj.get("variable_io"):
        return False  # Can't reliably determine expected counts

    # If counts match DB, it's a real instance (just unconnected)
    if instance.numinlets == db_inlets and instance.numoutlets == db_outlets:
        return False

    return True  # Counts don't match AND no connections -- degenerate
```

### Pattern 3: Outlet Type Mapping (Help Patch to DB)
**What:** Convert help patch outlettype strings to DB signal/control classification.
**When to use:** During outlet type comparison.
**Example:**
```python
# Source: Verified from full outlettype survey across 973 help files
SIGNAL_TYPES = {"signal", "multichannelsignal"}

def classify_outlet_type(help_type: str) -> tuple[bool, str]:
    """Map help patch outlettype string to DB signal/control classification.

    Returns: (is_signal, type_string)
        is_signal: True for signal outlets, False for control
        type_string: "signal", "multichannelsignal", or "" (control)
    """
    if help_type == "signal":
        return (True, "signal")
    elif help_type == "multichannelsignal":
        return (True, "multichannelsignal")
    else:
        # All other types are control: "", "bang", "int", "float",
        # "list", "dictionary", "jit_matrix", "jit_gl_texture", etc.
        return (False, "")
```

### Pattern 4: Confidence Scoring
**What:** Rate confidence based on instance agreement counts.
**When to use:** When aggregating per-object findings.
**Example:**
```python
# Source: CONTEXT.md decision
def compute_confidence(
    instances: list[BoxInstance],
    key_fn,  # e.g., lambda inst: tuple(inst.outlettype)
) -> tuple[str, float, any]:
    """Compute confidence score for a finding based on instance agreement.

    Returns: (confidence_level, agreement_ratio, consensus_value)
    """
    if not instances:
        return ("NONE", 0.0, None)

    values = Counter(key_fn(inst) for inst in instances)
    most_common_value, most_common_count = values.most_common(1)[0]
    total = sum(values.values())
    ratio = most_common_count / total

    if ratio >= 1.0:
        level = "HIGH"      # All instances agree (e.g., 5/5)
    elif ratio >= 0.75:
        level = "MEDIUM"    # Strong majority (e.g., 4/5, 3/4)
    elif ratio >= 0.5:
        level = "LOW"       # Simple majority (e.g., 3/5)
    else:
        level = "CONFLICT"  # No majority -- needs manual review

    return (level, ratio, most_common_value)
```

### Anti-Patterns to Avoid
- **Loading entire DB into memory per file:** Load ObjectDatabase once at startup, reuse across all 973 files.
- **Filtering out 0-outlet objects as degenerate:** Objects like `print`, `send`, `send~`, `dac~`, `thispatcher` legitimately have 0 outlets. Only filter if BOTH no connections AND mismatched I/O counts.
- **Treating outlettype strings as exact DB types:** The DB uses "signal"/"" only; help patches use "bang", "int", "float", "list", etc. Map to signal/control binary first.
- **Flattening subpatcher connections:** Each subpatcher has its own scope for box IDs and lines. Connection resolution must stay within patcher scope.
- **Ignoring `@attribute` syntax in text parsing:** Object text like `line~ @activeout 1` has arguments after `@` that are attributes, not positional args.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Object lookup and alias resolution | Custom name resolution | `ObjectDatabase.lookup()` from db_lookup.py | Already handles aliases, domain priority, overrides |
| Variable I/O computation | Custom arg counting | `ObjectDatabase.compute_io_counts()` | Already implements all formula types |
| Outlet type computation for DB side | Manual outlet array building | `ObjectDatabase.get_outlet_types()` | Already handles variable I/O expansion |
| JSON parsing | Custom parser | `json.load()` (stdlib) | Help files are valid JSON; 0.15s for all 973 files |

**Key insight:** The existing `db_lookup.py` ObjectDatabase class is the comparison baseline. It already loads all domains, applies overrides, resolves aliases, and computes variable I/O. The audit tool should instantiate it once and use it for all DB-side lookups.

## Common Pitfalls

### Pitfall 1: Subpatcher Tab Structure
**What goes wrong:** Missing objects inside subpatcher tabs because the parser only looks at top-level boxes.
**Why it happens:** Help files use `p basic`, `p examples`, `p details` etc. as tab containers. The actual working object instances live 1-3 levels deep inside these subpatchers.
**How to avoid:** Always recurse into any box that has a `patcher` key, regardless of depth. Verified: the trigger.maxhelp has all useful instances at depth >= 1.
**Warning signs:** Object instance count is suspiciously low (e.g., < 5 per file).

### Pitfall 2: Variable I/O Objects Produce Different Counts
**What goes wrong:** Flagging `trigger b i f` (3 outlets) as a discrepancy vs the DB default (2 outlets).
**Why it happens:** Variable I/O objects have different inlet/outlet counts depending on arguments.
**How to avoid:** When comparing counts, compute expected counts from the object's arguments using `ObjectDatabase.compute_io_counts(name, args)`. Only flag genuine discrepancies where the help patch count doesn't match the argument-computed count.
**Warning signs:** Many false positives on trigger, pack, unpack, route, select, gate, switch, spray.

### Pitfall 3: Math Object Outlettype Variation
**What goes wrong:** Flagging `+` as inconsistent because some instances have outlettype `["int"]` and others have `["float"]`.
**Why it happens:** Math objects in MAX output int or float depending on whether their arguments/inputs are int or float. The help patch captures the specific instance type.
**How to avoid:** For the 90 objects with varying outlet types, the audit should report the most common pattern and note the variation, but not treat int/float variation as a signal/control discrepancy. Both "int" and "float" are control types.
**Warning signs:** High number of "CONFLICT" confidence ratings on basic math objects.

### Pitfall 4: Overwriting Manual Corrections
**What goes wrong:** Proposed overrides clobber carefully verified manual entries in overrides.json.
**Why it happens:** The audit generates corrections without checking if the object already has a manual override.
**How to avoid:** Load overrides.json at startup. For each proposed correction, check if the object name exists in `overrides.objects`. If it does, mark the proposal as "CONFLICT_WITH_MANUAL" and include both values for human review, but never propose overwriting.
**Warning signs:** Proposed overrides that disagree with existing overrides.json entries (e.g., proposing buffer~ outlets are signal when overrides.json correctly marks them as control).

### Pitfall 5: Patcher Scope for Connection Resolution
**What goes wrong:** Resolving box ID "obj-3" at the wrong patcher level, connecting boxes from different subpatchers.
**Why it happens:** Box IDs are only unique within a single patcher scope. "obj-3" in the top-level patcher is a different object than "obj-3" in a subpatcher.
**How to avoid:** Build the id_map and connection graph per-patcher-scope, never globally. Each recursive call to traverse_patcher builds its own scope.
**Warning signs:** Connection graphs show impossible connections between objects in different subpatchers.

### Pitfall 6: @attribute Arguments in Object Text
**What goes wrong:** Parsing `line~ @activeout 1` and treating "@activeout" and "1" as positional arguments.
**Why it happens:** Object text after `@` is attribute syntax, not positional arguments.
**How to avoid:** When parsing arguments from text, split on the first `@` occurrence. Everything before `@` is positional args; everything after is attribute key/value pairs.
**Warning signs:** Variable I/O computation produces wrong counts for objects with `@attribute` syntax.

## Code Examples

Verified patterns from direct analysis of help file structure:

### Help File JSON Structure
```python
# Source: Direct analysis of /Applications/Max.app/Contents/Resources/C74/help/
# Top-level structure of every .maxhelp file:
{
    "patcher": {
        "fileversion": 1,
        "appversion": {"major": 9, "minor": 0, ...},
        "boxes": [
            {
                "box": {
                    "id": "obj-7",
                    "maxclass": "newobj",
                    "text": "p basic",        # Tab subpatcher
                    "numinlets": 0,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [x, y, width, height],
                    "patcher": {              # Subpatcher content (recurse here)
                        "boxes": [...],
                        "lines": [...]
                    }
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": ["obj-id", outlet_index],
                    "destination": ["obj-id", inlet_index]
                }
            }
        ]
    }
}
```

### CLI Interface Design
```python
# Source: CONTEXT.md decisions
# src/maxpat/audit/cli.py
import argparse
from pathlib import Path

DEFAULT_HELP_DIR = Path("/Applications/Max.app/Contents/Resources/C74/help")

def main():
    parser = argparse.ArgumentParser(description="MAX help patch audit tool")
    parser.add_argument(
        "--help-dir", type=Path, default=DEFAULT_HELP_DIR,
        help="Path to MAX help directory"
    )
    parser.add_argument(
        "--output-dir", type=Path,
        default=Path(".claude/max-objects/audit"),
        help="Output directory for audit results"
    )
    # Filtered views (single pass, filtered output)
    parser.add_argument("--outlets-only", action="store_true")
    parser.add_argument("--widths-only", action="store_true")
    parser.add_argument("--empty-io-only", action="store_true")
    parser.add_argument("--connections-only", action="store_true")
    parser.add_argument("--args-only", action="store_true")

    args = parser.parse_args()
    # ... run audit
```

### Argument Parsing from Object Text
```python
# Source: Verified from help patch text field analysis
def parse_object_text(text: str) -> tuple[str, list[str], dict[str, str]]:
    """Parse newobj text into name, positional args, and attributes.

    Examples:
        "cycle~ 440" -> ("cycle~", ["440"], {})
        "line~ @activeout 1" -> ("line~", [], {"activeout": "1"})
        "buffer~ mybuf 1000" -> ("buffer~", ["mybuf", "1000"], {})
        "t b i f" -> ("t", ["b", "i", "f"], {})
    """
    parts = text.split()
    if not parts:
        return ("", [], {})

    name = parts[0]
    positional = []
    attributes = {}

    i = 1
    while i < len(parts):
        if parts[i].startswith("@"):
            # Attribute: @key value
            attr_key = parts[i][1:]  # Remove @
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
```

### Proposed Override Format
```python
# Source: Matches existing overrides.json structure
# proposed-overrides.json should match the established format:
{
    "_comment": "Audit-generated proposed corrections. Review before merging.",
    "_audit_date": "2026-03-XX",
    "_audit_stats": {
        "files_parsed": 973,
        "objects_analyzed": 934,
        "discrepancies_found": 0,
        "conflicts_with_manual": 0
    },
    "objects": {
        "some_object": {
            "outlets": [
                {"id": 0, "type": "signal", "signal": true, "digest": "Signal output"},
                {"id": 1, "type": "", "signal": false, "digest": "bang when done"}
            ],
            "_audit": {
                "confidence": "HIGH",
                "instances": 5,
                "agreement": "5/5",
                "source_files": ["some_object.maxhelp"],
                "conflicts_with_manual": false
            }
        }
    }
}
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Character-count box width estimation | Help-patch-measured widths as override table | This phase (08) | More accurate layout sizing via LYOT-01 |
| Manual outlet type correction (overrides.json) | Automated audit + proposed corrections | This phase (08) | Systematic coverage of all 934 objects with help files |
| Empty I/O data accepted as-is | Audit identifies and proposes fills | This phase (08) | Reduces 223 empty-I/O objects to only those without help file coverage |

**Key data points from research:**
- 973 help files contain 16,024 newobj instances across 1,047 unique object names
- 934 object names overlap between help files and DB (out of 1,672 DB objects)
- 90 objects have varying outlettype patterns (mostly math objects with int/float variation)
- 941 objects have consistent outlettype across all instances
- 13 unique outlettype strings in common use (plus ~15 rare/object-specific strings)
- Parsing all 973 files takes ~0.15 seconds
- Total help file data: 57.6 MB across 973 files

## Open Questions

1. **RNBO Domain Coverage**
   - What we know: RNBO has 43 objects with empty inlets and 43 with empty outlets, but no .maxhelp files exist in the standard help directory for RNBO objects.
   - What's unclear: Whether RNBO help files exist elsewhere or if RNBO objects must remain with empty I/O data.
   - Recommendation: Mark RNBO objects as "no help file coverage" in the audit report. Phase 9 can investigate RNBO-specific documentation separately.

2. **Objects Only in Help Files (39 objects)**
   - What we know: 39 help file names don't match any DB object (e.g., `bitand`, `bitor`, `equals`, `flonum~`, `gswitch2`).
   - What's unclear: Whether these are aliases, deprecated objects, or extraction gaps.
   - Recommendation: Log these as potential DB gaps in the audit report for Phase 9 investigation.

3. **Proposed Override Granularity**
   - What we know: CONTEXT.md leaves format details to Claude's discretion.
   - What's unclear: Whether audit metadata (confidence, instances, source files) should be inline in proposed-overrides.json or in a separate audit-metadata.json.
   - Recommendation: Use inline `_audit` keys (prefixed with underscore, matching the existing `_note` and `_comment` convention in overrides.json). This keeps the proposal self-documenting while the underscore prefix ensures db_lookup.py ignores metadata during merge.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | none (pytest defaults, pyproject.toml if exists) |
| Quick run command | `python3 -m pytest tests/test_audit.py -x -q` |
| Full suite command | `python3 -m pytest tests/ -x -q` |

### Phase Requirements to Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| AUDIT-01 | Recursive descent parses all subpatcher tabs | unit | `python3 -m pytest tests/test_audit.py::test_recursive_descent -x` | Wave 0 |
| AUDIT-02 | Degenerate instance filtering | unit | `python3 -m pytest tests/test_audit.py::test_degenerate_filtering -x` | Wave 0 |
| AUDIT-03 | Outlet type comparison (signal/control mapping) | unit | `python3 -m pytest tests/test_audit.py::test_outlet_type_comparison -x` | Wave 0 |
| AUDIT-04 | Inlet/outlet count validation with variable I/O | unit | `python3 -m pytest tests/test_audit.py::test_io_count_validation -x` | Wave 0 |
| AUDIT-05 | Box width extraction from patching_rect | unit | `python3 -m pytest tests/test_audit.py::test_box_width_extraction -x` | Wave 0 |
| AUDIT-06 | Argument format extraction with @attribute handling | unit | `python3 -m pytest tests/test_audit.py::test_argument_parsing -x` | Wave 0 |
| AUDIT-07 | Connection pattern extraction per-patcher-scope | unit | `python3 -m pytest tests/test_audit.py::test_connection_extraction -x` | Wave 0 |
| AUDIT-08 | Audit report generation with confidence scores | integration | `python3 -m pytest tests/test_audit.py::test_report_generation -x` | Wave 0 |
| AUDIT-09 | Override generation preserves manual entries | unit | `python3 -m pytest tests/test_audit.py::test_override_safety -x` | Wave 0 |
| AUDIT-10 | Empty I/O coverage tracker | unit | `python3 -m pytest tests/test_audit.py::test_empty_io_tracker -x` | Wave 0 |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/test_audit.py -x -q`
- **Per wave merge:** `python3 -m pytest tests/ -x -q`
- **Phase gate:** Full suite green (652 existing + new audit tests) before `/gsd:verify-work`

### Wave 0 Gaps
- [ ] `tests/test_audit.py` -- covers AUDIT-01 through AUDIT-10 (new file)
- [ ] `tests/fixtures/sample_help.json` -- minimal synthetic help file for unit tests (avoids dependency on MAX installation)
- [ ] `src/maxpat/audit/__init__.py` -- package init (new directory)

## Sources

### Primary (HIGH confidence)
- Direct file system analysis of `/Applications/Max.app/Contents/Resources/C74/help/` -- 973 files, JSON structure verified
- Direct analysis of help file JSON structure (boxes, lines, patcher nesting, outlettype arrays)
- Existing codebase: `src/maxpat/db_lookup.py`, `src/maxpat/sizing.py`, `src/maxpat/defaults.py`
- Existing data: `.claude/max-objects/overrides.json` (20 manual entries), `extraction-log.json` (extraction metadata)
- Full outlettype string survey: 13+ unique type strings across 55,000+ outlet type values

### Secondary (MEDIUM confidence)
- CONTEXT.md decisions and specific implementation guidance from user discussion
- Object count and coverage statistics (934 overlap between help files and DB)

### Tertiary (LOW confidence)
- None -- all findings are from direct file system and codebase analysis

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH - all stdlib Python, no external dependencies, verified against project conventions
- Architecture: HIGH - JSON structure directly verified from help files, patterns tested with sample code
- Pitfalls: HIGH - all identified from direct analysis of real data (variable I/O, outlet type variation, scope issues)
- Help file format: HIGH - directly parsed and analyzed 973 files
- Empty I/O coverage: HIGH - counted from actual DB files (133 empty inlets, 159 empty outlets)

**Research date:** 2026-03-13
**Valid until:** 2026-04-13 (stable -- MAX help file format does not change between patches)
