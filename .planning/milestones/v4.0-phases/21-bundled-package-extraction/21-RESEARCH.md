# Phase 21: Bundled Package Extraction (BEAP + Vizzie) - Research

**Researched:** 2026-04-13
**Domain:** MAX/MSP package extraction -- bpatcher abstraction parsing + XML refpage pipeline
**Confidence:** HIGH

## Summary

Phase 21 extracts BEAP (~192 .maxpat files), Vizzie (~110 modules), Jitter Geometry (27 objects), and Jitter Tools (99 objects) into the object database. The work splits into two distinct pipelines: (1) a new `extract_abstractions.py` for bpatcher-based packages (BEAP/Vizzie) that parses .maxpat JSON to extract I/O counts, descriptions, and categories, and (2) extending the existing `extract_objects.py` XML pipeline with two new SOURCE_DIRS entries for Jitter Geometry and Jitter Tools.

The codebase already has per-package subdirectories under `.claude/max-objects/packages/` with empty `objects.json` files for BEAP and Vizzie, and `ObjectDatabase` auto-discovers these on load. The existing package schema (from Phase 20's ableton-dsp extraction) establishes the exact JSON structure required. The new extraction script must produce entries with `maxclass: "bpatcher"`, plus four extra fields: `abstraction_file`, `bpatcher_dimensions`, `category`, and `signal_convention`.

**Primary recommendation:** Build `extract_abstractions.py` as a standalone script (pattern-matched to `extract_objects.py`) that handles both BEAP clippings (embedded bpatcher with nested inlet/outlet objects) and Vizzie patchers (top-level inlet/outlet objects). For Jitter packages, add two entries to `PACKAGE_GLOBS` in `extract_objects.py` with a minor modification to route output to per-package subdirectories.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- D-01: Build a single unified `extract_abstractions.py` that handles both BEAP and Vizzie. BEAP uses embedded bpatchers (I/O in nested patcher), Vizzie uses top-level inlet/outlet objects -- detect pattern and branch accordingly.
- D-02: Extract object descriptions from `.maxhelp` help patches (172 BEAP, Vizzie has help dir). Richest source of description/digest text.
- D-03: Auto-discover categories from folder structure. BEAP: use `clippings/BEAP/{Category}/` subdirectory names (Oscillator, Filter, LFO, etc). Vizzie: derive from prefix patterns.
- D-04: Include ALL bp.*.maxpat files -- clippings (168) plus misc/marco_osc and misc extras (24). Total: 192 BEAP modules.
- D-05: Use `maxclass: "bpatcher"` for all BEAP and Vizzie entries. Matches actual instantiation pattern in MAX.
- D-06: Include four extra fields beyond standard object entries: `abstraction_file`, `bpatcher_dimensions`, `category`, `signal_convention`.
- D-07: Bpatcher instantiation only. No alt_maxclass for standalone abstraction mode.
- D-08: Run existing `extract_objects.py` XML pipeline. Add Jitter Geometry and Jitter Tools as new SOURCE_DIRS entries.
- D-09: Output to separate per-package directories (`packages/Jitter Geometry/objects.json`, `packages/Jitter Tools/objects.json`).
- D-10: Use XML refpages for all 99 Jitter Tools objects. Refpages are authoritative for I/O and descriptions.
- D-11: Automated cross-check: compare extracted I/O counts against help patch bpatcher instances. Extend existing audit pipeline.
- D-12: DB round-trip integration test: load ObjectDatabase, look up every BEAP/Vizzie object by name, verify I/O counts match.

### Claude's Discretion
- Parser implementation details (JSON traversal, error handling, output format)
- How to handle edge cases (BEAP modules with 0 I/O, malformed patches)
- Test structure and organization

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope.
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| PKG-05 | Abstraction extraction pipeline handles bpatcher-based packages (BEAP, Vizzie) | New `extract_abstractions.py` with dual-pattern parser (BEAP embedded bpatcher vs Vizzie top-level inlet/outlet) |
| PKG-06 | BEAP modules extracted with correct I/O counts and signal types | I/O from embedded bpatcher `numinlets`/`numoutlets` fields; signal type inferred from all-signal BEAP convention; help patch cross-check for verification |
| PKG-07 | Vizzie modules extracted with correct I/O counts | Top-level inlet/outlet object counting with `comment` attribute extraction for inlet descriptions |
| PKG-08 | All bundled packages represented in DB (including Jitter Geometry, Jitter Tools) | Add two SOURCE_DIRS entries to `extract_objects.py`; create per-package output directories; update `package_info.json` |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Python 3 (stdlib) | 3.14+ | JSON parsing, pathlib, xml.etree | Already used by extract_objects.py [VERIFIED: codebase] |
| json (stdlib) | -- | Parse .maxpat and .maxhelp files | MAX patches are JSON [VERIFIED: codebase] |
| xml.etree.ElementTree (stdlib) | -- | Parse .maxref.xml refpages | Already used in extract_objects.py [VERIFIED: codebase] |
| pathlib (stdlib) | -- | File discovery and path manipulation | Project convention [VERIFIED: codebase] |
| pytest | 9.0.2 | Test framework | Already installed and used [VERIFIED: test output] |

### Supporting
| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| collections.defaultdict | stdlib | Category counting, stats tracking | Aggregation during extraction [VERIFIED: codebase pattern] |
| argparse | stdlib | CLI for extract_abstractions.py | Script invocation options [VERIFIED: extract_objects.py pattern] |

**Installation:**
No new dependencies needed. All tools are Python stdlib + existing pytest.

## Architecture Patterns

### Recommended Project Structure
```
.claude/scripts/
  extract_objects.py          # EXISTING: XML refpage pipeline (add Jitter Geometry/Tools)
  extract_abstractions.py     # NEW: bpatcher abstraction pipeline (BEAP + Vizzie)

.claude/max-objects/packages/
  BEAP/objects.json           # Output: ~168 clipping modules + ~20 misc standalone
  Vizzie/objects.json         # Output: ~110 modules
  Jitter Geometry/objects.json # Output: 27 objects
  Jitter Tools/objects.json   # Output: 99 objects
  package_info.json           # Update: add Jitter Geometry + Jitter Tools entries

tests/
  test_package_schema.py      # EXISTING: extend with BEAP/Vizzie assertions
  test_extraction.py          # NEW: extraction pipeline tests
```

### Pattern 1: BEAP Clipping Extraction (168 modules)
**What:** BEAP clippings are .maxpat files containing a single embedded bpatcher box. I/O counts come from the bpatcher's `numinlets`/`numoutlets` fields. Inner inlet/outlet objects carry `comment` descriptions and `index` for ordering.
**When to use:** All files in `clippings/BEAP/{Category}/bp.*.maxpat`
**Example:**
```python
# Source: [VERIFIED: manual inspection of bp.Oscillator.maxpat]
# Top-level patcher -> boxes -> find maxclass=="bpatcher"
# bpatcher has: numinlets=6, numoutlets=2
# Inner patcher has inlet/outlet objects with:
#   - "index" field (1-based) for ordering
#   - "comment" field for descriptions (e.g., "CV1: 1v/oct pitch modulation input")
#   - "outlettype" field (always [''] for BEAP -- signal type inferred from convention)
for box in patcher["boxes"]:
    b = box["box"]
    if b["maxclass"] == "bpatcher":
        numinlets = b["numinlets"]    # 6
        numoutlets = b["numoutlets"]  # 2
        inner = b.get("patcher", {})
        # Extract inlet/outlet comments and ordering from inner patcher
```

### Pattern 2: BEAP Misc/Marco_osc Extraction (20 standalone modules)
**What:** Misc bp.* files that are NOT clipping wrappers. Marco_osc modules use `in~ N`/`out~ N` objects for signal I/O. Other misc files use standard `inlet`/`outlet` objects at the top level.
**When to use:** Files in `misc/bp.*.maxpat` and `misc/marco_osc/bp.*.maxpat`
**Example:**
```python
# Source: [VERIFIED: manual inspection of bp.FM-OD.maxpat]
# Marco_osc pattern: no inlet/outlet objects, uses in~/out~ objects
# Count in~ and out~ objects for I/O
for box in patcher["boxes"]:
    text = box["box"].get("text", "")
    if text.startswith("in~ "):
        signal_in_count += 1
    elif text.startswith("out~ "):
        signal_out_count += 1
# All marco_osc modules: 3 signal inlets, 1 signal outlet
```

### Pattern 3: Vizzie Module Extraction (110 modules)
**What:** Vizzie modules are .maxpat files with top-level `inlet` and `outlet` objects. Description comes from the patcher's `description` field (100% coverage). Categories from `tags` field (format: "Vizzie Generate, analyzr").
**When to use:** All `vz.*.maxpat` files in `patchers/`
**Example:**
```python
# Source: [VERIFIED: manual inspection of vz.analyzr.maxpat]
# Top-level patcher has:
#   - description: "Convert R, G, and B video components to VIZZIE data"
#   - tags: "Vizzie Generate, analyzr"
# inlet/outlet objects at top level with "comment" descriptions
for box in patcher["boxes"]:
    b = box["box"]
    if b["maxclass"] == "inlet":
        inlets.append({
            "comment": b.get("comment", ""),
            "index": b.get("index", 0),
        })
```

### Pattern 4: BEAP Description Extraction from Help Patches
**What:** BEAP help patches (.maxhelp) contain descriptions as comment boxes, typically the longest comment in the top-level or first-level subpatcher. The patches themselves have no `description` or `digest` fields.
**When to use:** For the 160 BEAP modules that have matching help files.
**Example:**
```python
# Source: [VERIFIED: manual inspection of bp.Oscillator.maxhelp]
# Description found in comment boxes within the help patch
# "Classic oscillator with the standard four geometric waveforms,
#  linear frequency modulation, pulse width modulation and sync"
# Strategy: find longest comment in top-level and first subpatcher level
```

### Pattern 5: Jitter Geometry/Tools via XML Pipeline
**What:** Standard c74object XML refpages. Same format as core domains. Add two SOURCE_DIRS entries to extract_objects.py.
**When to use:** 27 Jitter Geometry + 99 Jitter Tools (16 top-level + 83 in jit.fx/ subdir) refpages.
**Example:**
```python
# Source: [VERIFIED: manual inspection of jit.geom.shape.maxref.xml]
# Standard c74object format with inletlist/outletlist, digest, attributelist
# Add to SOURCE_DIRS (note: Jitter Tools has jit.fx/ subdirectory, use rglob):
SOURCE_DIRS.append(("packages/Jitter Geometry/docs", "", "Packages"))
# For Jitter Tools, needs rglob to find jit.fx/*.maxref.xml:
SOURCE_DIRS.append(("packages/Jitter Tools/docs", "", "Packages"))
```

### Anti-Patterns to Avoid
- **Parsing clipping names to infer I/O:** The clipping filename has no I/O information. Always read the embedded bpatcher's numinlets/numoutlets. [VERIFIED: codebase inspection]
- **Using `outlettype` for BEAP signal detection:** BEAP inlet/outlet objects all have `outlettype: ['']` (generic control). Signal type must be inferred from the BEAP convention (all 0-5V CV signals). [VERIFIED: manual inspection]
- **Treating misc internal helpers as user-facing modules:** 4 BEAP misc files are poly~ voices/pfft subpatches (bp.freqshift.poly, bp.polydronevoice, bp.rgrain, bp.diodeladder.poly) -- they should be excluded. [VERIFIED: manual inspection]

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| XML refpage parsing | Custom Jitter XML parser | Existing `parse_standard_xml()` in extract_objects.py | Handles all c74object XML schema variations, 1000+ objects already extracted with it [VERIFIED: codebase] |
| Package object schema | New JSON format | Match existing ableton-dsp schema exactly (name, maxclass, module, domain, inlets, outlets, etc.) | ObjectDatabase expects this format, tests validate it [VERIFIED: codebase] |
| Per-package directory structure | New directory organization | Follow existing `packages/{PackageName}/objects.json` convention | ObjectDatabase._load() auto-discovers these dirs [VERIFIED: codebase] |
| Test infrastructure | New test framework | Extend test_package_schema.py with BEAP/Vizzie assertions | Fixtures (db_root, all_objects) already exist [VERIFIED: codebase] |

**Key insight:** The extraction output format is rigidly defined by the existing ObjectDatabase class and test suite. Any deviation in JSON structure will cause test failures. The schema from ableton-dsp is the canonical template.

## Common Pitfalls

### Pitfall 1: BEAP Inlet Index is 1-based
**What goes wrong:** Inlet/outlet `index` fields in BEAP embedded patchers are 1-based, not 0-based. Generating inlet arrays with wrong ordering.
**Why it happens:** MAX internal indexing for nested patcher inlets uses 1-based indices, while the DB schema expects 0-based `id` fields.
**How to avoid:** When extracting from BEAP inner patchers, sort by `index` field then assign 0-based `id` values.
**Warning signs:** Inlet descriptions in wrong order compared to help patch. [VERIFIED: bp.Oscillator has index=1 through index=6]

### Pitfall 2: BEAP Clipping vs Misc File Detection
**What goes wrong:** The parser tries to extract from internal helper files (poly~ voices, pfft subpatches) that aren't user-facing modules.
**Why it happens:** All bp.*.maxpat files look similar. Some in misc/ are internal subpatches loaded by other BEAP modules.
**How to avoid:** Check for bpatcher box at top level (clippings), `in~`/`out~` objects (marco_osc), or standard `inlet`/`outlet` objects (misc standalone). Skip files with 0 I/O that are clearly poly voices (bp.*.poly, bp.polydronevoice). [VERIFIED: 4 files are internal helpers]
**Warning signs:** Objects with 0 inlets AND 0 outlets in the output.

### Pitfall 3: Jitter Tools Nested Directory
**What goes wrong:** Missing 83 jit.fx.* objects because they're in a `jit.fx/` subdirectory.
**Why it happens:** `extract_objects.py` uses `glob("*.maxref.xml")` by default, not `rglob`.
**How to avoid:** Use `rglob("*.maxref.xml")` for Jitter Tools docs directory (already the pattern used for PACKAGE_GLOBS). [VERIFIED: 16 top-level + 83 in jit.fx/ = 99 total]
**Warning signs:** Only 16 Jitter Tools objects extracted instead of 99.

### Pitfall 4: Vizzie Category Extraction
**What goes wrong:** Categories assigned from prefix patterns that don't match the actual tag-based categories.
**Why it happens:** D-03 says "derive from prefix patterns" for Vizzie, but the actual categories are cleanly available in the `tags` field.
**How to avoid:** Use the `tags` field from the .maxpat patcher (format: "Vizzie Generate, analyzr"). Extract the "Vizzie {Category}" part. All 110 modules have tags. [VERIFIED: 100% coverage with 8 categories]
**Warning signs:** Mismatched categories between extracted data and MAX's own categorization.

### Pitfall 5: Package Field Missing
**What goes wrong:** Extracted objects don't have the `package` field, causing ObjectDatabase filtering to treat them as core objects.
**Why it happens:** New extraction script doesn't add `package` field.
**How to avoid:** Every object MUST include `"package": "BEAP"` (or "Vizzie", "Jitter Geometry", "Jitter Tools"). Existing test `test_package_objects_have_package_field` will catch this. [VERIFIED: test_package_schema.py]
**Warning signs:** `db.is_core("bp.Oscillator")` returns True.

### Pitfall 6: Description Extraction Strategy Differs by Package
**What goes wrong:** Using the same description extraction for both BEAP and Vizzie.
**Why it happens:** They store descriptions differently.
**How to avoid:**
  - **Vizzie:** Description in .maxpat `patcher.description` field (100% coverage, reliable). [VERIFIED: all 110 modules]
  - **BEAP:** No description in .maxpat files. Must extract from .maxhelp help patches as longest comment text. Only 160/192 modules have help files; remaining 32 get empty descriptions. [VERIFIED: all BEAP .maxpat have empty description/digest]

### Pitfall 7: extract_objects.py Package Output Routing
**What goes wrong:** Jitter Geometry/Tools objects end up in monolithic `packages/objects.json` instead of per-package subdirectories.
**Why it happens:** Current `write_output()` writes to domain-level directories. Per-package splitting was a Phase 20 migration, not built into the pipeline.
**How to avoid:** Either (a) modify `extract_objects.py` to support per-package output routing, or (b) extract to packages/ then post-process into subdirectories. Option (a) is cleaner.
**Warning signs:** ObjectDatabase doesn't load the new objects because they're not in the expected directory.

## Code Examples

### BEAP Object Entry Schema
```python
# Source: [VERIFIED: ableton-dsp schema as template + CONTEXT.md D-05, D-06]
{
    "name": "bp.Oscillator",
    "maxclass": "bpatcher",           # D-05: always bpatcher
    "module": "max",
    "domain": "Packages",
    "category": "Oscillator",          # D-06: from clippings subdirectory
    "digest": "Classic oscillator with four geometric waveforms...",
    "description": "...",               # From help patch comment
    "inlets": [
        {"id": 0, "type": "signal", "signal": True, "hot": True,
         "digest": "CV1: 1v/oct pitch modulation input"},
        {"id": 1, "type": "signal", "signal": True, "hot": False,
         "digest": "CV2: pitch modulation input with attenuator"},
        # ... remaining inlets
    ],
    "outlets": [
        {"id": 0, "type": "signal", "signal": True,
         "digest": "Signal output"},
        {"id": 1, "type": "signal", "signal": True,
         "digest": "Signal output"},
    ],
    "arguments": [],
    "messages": [],
    "attributes": {},
    "seealso": [],
    "tags": ["BEAP", "Oscillator"],
    "min_version": 8,
    "verified": True,
    "variable_io": False,
    "rnbo_compatible": False,
    "package": "BEAP",
    # D-06 extra fields:
    "abstraction_file": "clippings/BEAP/Oscillator/bp.Oscillator.maxpat",
    "bpatcher_dimensions": [314.0, 116.0],  # width, height from patching_rect
    "signal_convention": "0-5V CV"
}
```

### Vizzie Object Entry Schema
```python
# Source: [VERIFIED: manual inspection + D-05, D-06]
{
    "name": "vz.analyzr",
    "maxclass": "bpatcher",           # D-05
    "module": "max",
    "domain": "Packages",
    "category": "Generate",            # From tags: "Vizzie Generate"
    "digest": "Convert R, G, and B video components to VIZZIE data",
    "description": "Convert R, G, and B video components to VIZZIE data",
    "inlets": [
        {"id": 0, "type": "matrix", "signal": False, "hot": True,
         "digest": "Video input"},
        {"id": 1, "type": "control", "signal": False, "hot": False,
         "digest": "Toggle analysis"},
        # ... remaining inlets
    ],
    "outlets": [
        {"id": 0, "type": "control", "signal": False,
         "digest": "averaged Red values (0. - 1.0)"},
        # ...
    ],
    "arguments": [],
    "messages": [],
    "attributes": {},
    "seealso": [],
    "tags": ["Vizzie", "Generate"],
    "min_version": 8,
    "verified": True,
    "variable_io": False,
    "rnbo_compatible": False,
    "package": "Vizzie",
    "abstraction_file": "patchers/vz.analyzr.maxpat",
    "bpatcher_dimensions": [300.0, 200.0],
    "signal_convention": "Jitter matrix"
}
```

### BEAP I/O Extraction Logic
```python
# Source: [VERIFIED: bp.Oscillator.maxpat structure]
def extract_beap_clipping_io(patcher_data: dict) -> tuple[list, list]:
    """Extract I/O from BEAP clipping (embedded bpatcher pattern)."""
    for box in patcher_data.get("boxes", []):
        b = box["box"]
        if b.get("maxclass") == "bpatcher":
            numinlets = b.get("numinlets", 0)
            numoutlets = b.get("numoutlets", 0)
            
            inner = b.get("patcher", {})
            raw_inlets = []
            raw_outlets = []
            
            for inner_box in inner.get("boxes", []):
                ib = inner_box["box"]
                if ib.get("maxclass") == "inlet":
                    raw_inlets.append({
                        "index": ib.get("index", 0),  # 1-based!
                        "comment": ib.get("comment", ""),
                    })
                elif ib.get("maxclass") == "outlet":
                    raw_outlets.append({
                        "index": ib.get("index", 0),
                        "comment": ib.get("comment", ""),
                    })
            
            # Sort by index (1-based), convert to 0-based id
            raw_inlets.sort(key=lambda x: x["index"])
            raw_outlets.sort(key=lambda x: x["index"])
            
            inlets = [
                {"id": i, "type": "signal", "signal": True,
                 "hot": i == 0, "digest": ri["comment"]}
                for i, ri in enumerate(raw_inlets)
            ]
            outlets = [
                {"id": i, "type": "signal", "signal": True,
                 "digest": ro["comment"]}
                for i, ro in enumerate(raw_outlets)
            ]
            
            return inlets, outlets
    return [], []
```

### Help Patch Cross-Check Logic
```python
# Source: [VERIFIED: bp.Oscillator.maxhelp bpatcher instances]
def cross_check_io(module_name: str, extracted_io: tuple, help_path: Path) -> list[str]:
    """Compare extracted I/O against help patch bpatcher instances."""
    mismatches = []
    with open(help_path) as f:
        data = json.load(f)
    
    def find_bpatcher_io(patcher, name, results):
        for box in patcher.get("boxes", []):
            b = box["box"]
            if b.get("maxclass") == "bpatcher" and b.get("name") == f"{name}.maxpat":
                results.append((b.get("numinlets", 0), b.get("numoutlets", 0)))
            inner = b.get("patcher", {})
            if inner:
                find_bpatcher_io(inner, name, results)
    
    refs = []
    find_bpatcher_io(data.get("patcher", {}), module_name, refs)
    
    expected_in, expected_out = extracted_io
    for ref_in, ref_out in refs:
        if ref_in != expected_in or ref_out != expected_out:
            mismatches.append(
                f"{module_name}: extracted ({expected_in},{expected_out}) "
                f"vs help ({ref_in},{ref_out})"
            )
    
    return mismatches
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Monolithic packages/objects.json | Per-package subdirectories | Phase 20 (2026-04-13) | Each package gets its own directory [VERIFIED: codebase] |
| XML-only extraction | XML + JSON abstraction parsing | Phase 21 (this phase) | BEAP/Vizzie have no XML refpages, require .maxpat parsing |
| Manual object DB entries | Automated extraction pipeline | Phase 20 (2026-04-13) | 88 package objects auto-extracted so far [VERIFIED: codebase] |

## Object Counts Summary

| Package | Source Location | File Count | Extractable | Method |
|---------|----------------|-----------|-------------|--------|
| BEAP (clippings) | clippings/BEAP/{Category}/ | 168 | 168 | Embedded bpatcher pattern [VERIFIED] |
| BEAP (misc standalone) | misc/bp.*.maxpat + misc/marco_osc/ | 24 | ~20 | Top-level inlet/outlet + in~/out~ pattern [VERIFIED] |
| BEAP (misc internal) | misc/*.poly.maxpat etc | 4 | 0 (skip) | Internal helpers [VERIFIED] |
| Vizzie | patchers/vz.*.maxpat | 110 | 110 | Top-level inlet/outlet pattern [VERIFIED] |
| Jitter Geometry | docs/*.maxref.xml | 27 | 27 | XML refpage pipeline [VERIFIED] |
| Jitter Tools | docs/*.maxref.xml + docs/jit.fx/ | 99 | 99 | XML refpage pipeline [VERIFIED] |
| **Total** | | **432** | **~424** | |

## BEAP Category Breakdown

| Category | Module Count |
|----------|-------------|
| Analysis | 2 |
| Effects | 14 |
| Envelope | 11 |
| Filter | 12 |
| Input | 3 |
| Level | 11 |
| LFO | 10 |
| MIDI | 20 |
| Mixers | 7 |
| Oscillator | 15 |
| Output | 10 |
| Quantizer | 5 |
| Random | 10 |
| Scope | 7 |
| Sequencer | 18 |
| Serialosc | 7 |
| Waveshapers | 6 |
| **Total clippings** | **168** |

[VERIFIED: filesystem enumeration of clippings/BEAP/ subdirectories]

## Vizzie Category Breakdown

| Category (from tags) | Module Count |
|---------------------|-------------|
| Vizzie Generate | 23 |
| Vizzie Effect | 23 |
| Vizzie Control | 21 |
| Vizzie Transform | 16 |
| Vizzie Mix-Composite | 10 |
| Vizzie Utility | 8 |
| Vizzie Output | 5 |
| Vizzie Input | 4 |
| **Total** | **110** |

[VERIFIED: parsed tags from all 110 vz.*.maxpat files]

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | BEAP descriptions can be reliably extracted as the longest comment in help patches | Pattern 4 | Some descriptions may be wrong or truncated; manual spot-check needed after extraction |
| A2 | All BEAP signal inlets/outlets use 0-5V CV convention uniformly | Code Examples | Some BEAP modules (MIDI, Serialosc) may have control-rate I/O mixed with signal |
| A3 | Vizzie inlet types should be classified as "matrix" for video inputs and "control" for parameter inputs | Code Examples | Vizzie uses Jitter matrices but the inlet objects don't carry type information; classification based on comment text heuristic |
| A4 | Internal helper files (4 poly/pfft subpatches) should be excluded entirely | Pitfall 2 | If any user creates patches that load these directly, they won't be in the DB |

## Open Questions

1. **BEAP Signal Type Granularity**
   - What we know: BEAP uses 0-5V CV convention for all signal I/O. All inlets connect to signal objects.
   - What's unclear: Should MIDI-category modules (bp.MIDI In, bp.Arpeggiator) have their outlets typed as "control" instead of "signal"? The bpatcher numinlets/numoutlets doesn't distinguish.
   - Recommendation: Tag all BEAP I/O as "signal" uniformly since that's the BEAP convention. Add a note in the description for MIDI modules. The BEAP signal convention field (D-06) already communicates this.

2. **Help Patch Description Quality**
   - What we know: 160 BEAP modules have help files. Descriptions found as comment boxes.
   - What's unclear: The "longest comment" heuristic may pick up instructional text rather than actual descriptions.
   - Recommendation: Use longest comment from first-level subpatcher (basic_tab pattern), filter out comments that are clearly instructional (starting with "try", "click", etc.).

3. **package_info.json Update**
   - What we know: Existing entries for BEAP and Vizzie may already be stubs in the registry. Jitter Geometry and Jitter Tools need new entries.
   - What's unclear: Whether BEAP/Vizzie already have package_info.json entries (file doesn't exist yet).
   - Recommendation: Create package_info.json entries for all 4 packages with correct object_count after extraction.

4. **test_package_schema.py Migration Completeness Test**
   - What we know: Current test asserts `total == 88` package objects.
   - What's unclear: Whether to update this assertion to include new objects or parametrize it.
   - Recommendation: Update to sum all per-package objects dynamically rather than hard-coding. The count will jump from 88 to ~512.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | pytest runs from project root |
| Quick run command | `python3 -m pytest tests/test_package_schema.py -x -q` |
| Full suite command | `python3 -m pytest tests/ -x -q` |

### Phase Requirements to Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| PKG-05 | Abstraction pipeline extracts BEAP and Vizzie | integration | `python3 -m pytest tests/test_extraction.py::TestAbstractionPipeline -x` | Wave 0 |
| PKG-06 | BEAP I/O counts correct | unit + integration | `python3 -m pytest tests/test_extraction.py::TestBEAPExtraction -x` | Wave 0 |
| PKG-07 | Vizzie I/O counts correct | unit + integration | `python3 -m pytest tests/test_extraction.py::TestVizzieExtraction -x` | Wave 0 |
| PKG-08 | All bundled packages in DB | integration | `python3 -m pytest tests/test_package_schema.py -x` | Exists (update needed) |
| D-11 | Help patch cross-check | integration | `python3 -m pytest tests/test_extraction.py::TestIOCrossCheck -x` | Wave 0 |
| D-12 | DB round-trip | integration | `python3 -m pytest tests/test_extraction.py::TestDBRoundTrip -x` | Wave 0 |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/test_package_schema.py tests/test_extraction.py -x -q`
- **Per wave merge:** `python3 -m pytest tests/ -x -q`
- **Phase gate:** Full suite green before `/gsd-verify-work`

### Wave 0 Gaps
- [ ] `tests/test_extraction.py` -- covers PKG-05, PKG-06, PKG-07, D-11, D-12
- [ ] Update `tests/test_package_schema.py::test_migration_completeness` -- change hardcoded 88 to dynamic count

## Security Domain

Security enforcement does not apply to this phase. This is a data extraction pipeline that reads local files from the MAX installation directory and writes JSON to the project's object database. No user input, network access, authentication, or cryptography involved.

## Sources

### Primary (HIGH confidence)
- Filesystem inspection of `/Applications/Max.app/Contents/Resources/C74/packages/BEAP/` -- structure, file counts, JSON parsing of .maxpat files
- Filesystem inspection of `/Applications/Max.app/Contents/Resources/C74/packages/Vizzie/` -- structure, file counts, JSON parsing of .maxpat files
- Filesystem inspection of `/Applications/Max.app/Contents/Resources/C74/packages/Jitter Geometry/` and `Jitter Tools/` -- XML refpage structure
- Codebase: `.claude/scripts/extract_objects.py` -- existing XML extraction pipeline
- Codebase: `src/maxpat/db_lookup.py` -- ObjectDatabase class and package loading
- Codebase: `tests/test_package_schema.py` -- existing package schema tests
- Codebase: `.claude/max-objects/packages/ableton-dsp/objects.json` -- canonical schema template

### Secondary (MEDIUM confidence)
- BEAP help patch description extraction pattern (heuristic, needs validation after implementation)

### Tertiary (LOW confidence)
- None

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- all stdlib Python, no external deps
- Architecture: HIGH -- patterns verified by reading actual BEAP/Vizzie/Jitter files
- Pitfalls: HIGH -- each pitfall discovered through actual file inspection
- Object counts: HIGH -- filesystem enumeration, not estimates

**Research date:** 2026-04-13
**Valid until:** Indefinite (MAX installation files are static for a given version)
