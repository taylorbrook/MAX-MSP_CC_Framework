# Phase 1: Object Knowledge Base - Research

**Researched:** 2026-03-09
**Domain:** MAX/MSP object extraction, structured knowledge base design, XML parsing
**Confidence:** HIGH

## Summary

Phase 1 builds the foundational knowledge base that every subsequent phase depends on. The MAX 9.1.2 installation at `/Applications/Max.app/` contains **2,148 XML refpage files** across core refpages (1,175), Gen~ (194), RNBO (560), and additional packages (219). Each XML file follows a consistent `<c74object>` schema with structured data for inlets, outlets, arguments, methods, attributes, and cross-references. This XML structure is well-suited for automated extraction using Python's built-in `xml.etree.ElementTree`.

The extracted data must be stored in a format optimized for Claude's consumption during patch generation. JSON files per domain namespace provide the best balance: human-readable, easy to diff, fast to load as context slices, and trivially queryable by name. The database must also handle several known data quality challenges: 591 objects use generic `INLET_TYPE` instead of specific types, 520 use generic `OUTLET_TYPE`, and objects with variable inlet/outlet counts (pack, route, select, trigger) require rule-based descriptions rather than fixed counts.

**Primary recommendation:** Build a Python extraction script that parses all 2,148 XML refpages into domain-organized JSON files, with an overrides layer for expert corrections and a PD confusion blocklist to prevent hallucination of Pure Data objects.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- Extract all 1,924 maxref XML files from the MAX installation upfront -- automated extraction means marginal cost per object is near-zero
- Apply equal curation depth across all domains (Max, MSP, Jitter, MC, Gen~, RNBO~) -- no domain gets shortchanged
- Objects with variable inlet/outlet counts (pack, route, select, etc.) store the default count plus a rule describing how arguments change them -- validators apply rules at generation time
- RNBO-compatible subset marked as a flag per object (`rnbo_compatible: true/false`), not a separate whitelist -- single source of truth
- Query interface supports both name-based lookup ("look up cycle~") and domain/category browsing ("list all MSP filter objects")
- Include object relationships from XML seealsolist and common pairings (tapin~/tapout~, notein/stripnote, loadbang/trigger) -- helps Claude suggest correct companion objects
- Hot/cold inlet semantics marked in the database from Phase 1 -- not deferred to Phase 2
- #1 rule: Never guess objects -- if an object isn't in the database, Claude must not use it
- Opinionated style enforcement: top-to-bottom signal flow, explicit trigger objects for fan-out, comments on non-obvious connections, named sends/receives over long patch cords
- Domain-specific rule sections: MSP (signal termination, gain staging), Gen~ (History patterns, in/out binding), RNBO (export constraints), N4M (max-api patterns)
- MAX installation XML refpages are the authoritative source
- py2max is secondary for gap-filling where XML is incomplete or ambiguous
- Override layer: separate overrides file where expert corrections take precedence over extracted data
- Version tracking: per-object `min_version` and optional `max_version` fields -- MAX 9 additions marked as `min_version: 9`
- Incomplete objects: flag + best effort -- extract what's available, mark incomplete fields with a confidence flag (`verified: false`)

### Claude's Discretion
- Database storage format (SQLite vs JSON files vs hybrid) -- optimize for access quality
- Access pattern implementation (context injection, tool-based lookup, domain slices, or combination)
- PD blocklist inclusion -- use judgment on whether it's needed given DB enforcement
- Extraction script architecture and implementation details

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| ODB-01 | Framework includes structured knowledge base of MAX objects with name, maxclass, inlets, outlets, arguments, and message types | XML `<c74object>` schema provides all these fields directly; extraction script maps each to JSON fields |
| ODB-02 | Object database sourced from MAX installation XML refpages (1,924 files), py2max MaxRef, and manual curation | 2,148 XML files identified across core + packages; py2max MaxRefDB provides 1,157 objects for gap-filling; overrides layer handles manual curation |
| ODB-03 | Objects version-tagged for MAX 8 vs MAX 9 compatibility | No version field in XML -- must infer from object presence (array.*, string.* = MAX 9), store as `min_version` field, curate manually via overrides |
| ODB-04 | MAX 9 objects included (ABL devices, step sequencer, array, string objects) | 40+ array.* objects, 20+ string.* objects, 74 abl.* objects all found in installation XML |
| ODB-05 | Object entries include domain classification (Max, MSP, Jitter, MC) | XML `module` attribute provides domain (max, msp, jit, m4l); MC objects identifiable by `mc.` prefix in msp-ref; category attribute provides sub-classification |
| ODB-06 | Object entries include signal vs control inlet/outlet types | XML inlet/outlet `type` attribute provides: signal, signal/float, INLET_TYPE (control), matrix, multi-channel signal, float, int, bang, etc. |
| ODB-07 | RNBO-compatible object subset marked separately in database | 558 RNBO refpage files provide definitive list; 213 overlap with core MAX objects, 345 are RNBO-only; cross-reference by name to set `rnbo_compatible` flag |
| FRM-04 | CLAUDE.md with MAX/MSP development rules, conventions, and object reference guidance | Research identifies key rules: no hallucination, PD confusion guard, signal flow conventions, domain-specific patterns |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Python 3.14 | 3.14.2 (installed) | XML extraction script | Available on system, xml.etree is stdlib, no dependencies needed |
| xml.etree.ElementTree | stdlib | Parse MAX XML refpages | Built-in, handles all XML parsing needs, no external deps |
| json | stdlib | Serialize extracted data | Output format is JSON, stdlib handles this |
| pathlib | stdlib | File path operations | Clean cross-platform path handling |

### Supporting
| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| py2max (reference only) | latest | Gap-filling data source | Install to extract MaxRefDB data for objects with incomplete XML |
| collections.defaultdict | stdlib | Aggregate extraction stats | Counting objects per domain, tracking extraction issues |
| argparse | stdlib | CLI for extraction script | Allow re-extraction with options |

### Alternatives Considered
| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| JSON files | SQLite database | SQLite needs query layer; JSON loads directly as context for Claude, human-readable, git-diffable |
| JSON files | Single large JSON | Too large for context injection; domain slices allow selective loading |
| lxml | xml.etree.ElementTree | lxml faster but requires install; etree is stdlib and sufficient for 2,148 files |

**Installation:**
```bash
# No installation needed for core extraction -- all stdlib
# For py2max gap-filling (optional secondary source):
pip install py2max
```

## Architecture Patterns

### Recommended Project Structure
```
.claude/
  max-objects/              # Object knowledge base root
    max/                    # Max domain objects (control)
      objects.json          # All Max objects in one file
    msp/                    # MSP domain objects (audio)
      objects.json
    jitter/                 # Jitter domain objects (video/matrix)
      objects.json
    mc/                     # MC multichannel objects
      objects.json
    gen/                    # Gen~ patcher objects
      objects.json
    rnbo/                   # RNBO-only objects (not in core)
      objects.json
    m4l/                    # Max for Live objects
      objects.json
    packages/               # Package objects (abl, jit.mo, etc.)
      objects.json
    overrides.json          # Expert corrections (takes precedence)
    pd-blocklist.json       # PD objects that don't exist in MAX
    aliases.json            # Object aliases (t -> trigger, b -> bangbang)
    relationships.json      # Common object pairings
    extraction-log.json     # Extraction stats and issues
  scripts/
    extract_objects.py      # XML extraction script
    merge_sources.py        # Merge XML + py2max + overrides
    validate_db.py          # Database consistency checks
CLAUDE.md                   # MAX/MSP development rules and conventions
```

### Pattern 1: Object Entry Schema
**What:** Normalized JSON structure for each MAX object
**When to use:** Every object in the database follows this schema
**Example:**
```json
{
  "name": "cycle~",
  "maxclass": "cycle~",
  "module": "msp",
  "domain": "MSP",
  "category": "MSP Synthesis",
  "digest": "Sinusoidal oscillator",
  "description": "Generate a periodic waveform...",
  "inlets": [
    {
      "id": 0,
      "type": "signal/float",
      "signal": true,
      "digest": "Frequency",
      "hot": true
    },
    {
      "id": 1,
      "type": "signal/float",
      "signal": true,
      "digest": "Phase (0-1)",
      "hot": false
    }
  ],
  "outlets": [
    {
      "id": 0,
      "type": "signal",
      "signal": true,
      "digest": "Output"
    }
  ],
  "arguments": [
    {
      "name": "frequency",
      "type": "number",
      "optional": true,
      "digest": "Oscillator frequency (initial)"
    },
    {
      "name": "buffer-name",
      "type": "symbol",
      "optional": true,
      "digest": "Buffer name"
    }
  ],
  "messages": ["float", "signal", "reset", "set", "setall"],
  "attributes": {
    "frequency": { "type": "float", "get": true, "set": true },
    "phase": { "type": "float", "get": true, "set": true },
    "buffer": { "type": "symbol", "get": true, "set": true }
  },
  "seealso": ["buffer~", "cos~", "phasor~", "wave~"],
  "tags": ["MSP", "oscillator", "MSP Synthesis"],
  "rnbo_compatible": true,
  "min_version": 4,
  "verified": true,
  "variable_io": false
}
```

### Pattern 2: Variable I/O Object Schema
**What:** Objects whose inlet/outlet count depends on arguments
**When to use:** pack, unpack, route, select, trigger, gate, switch, funnel, spray
**Example:**
```json
{
  "name": "trigger",
  "maxclass": "trigger",
  "aliases": ["t"],
  "module": "max",
  "domain": "Max",
  "inlets": [
    { "id": 0, "type": "control", "signal": false, "digest": "Input", "hot": true }
  ],
  "outlets": [
    { "id": 0, "type": "control", "signal": false, "digest": "Output (rightmost)" },
    { "id": 1, "type": "control", "signal": false, "digest": "Output (leftmost)" }
  ],
  "variable_io": true,
  "io_rule": {
    "description": "Number of arguments determines number of outlets. Each argument (i, f, b, l, s, or a constant) creates one outlet. Default: 2 outlets (int, int).",
    "inlet_count": "fixed:1",
    "outlet_count": "arg_count",
    "default_outlets": 2
  }
}
```

### Pattern 3: Inlet Type Normalization
**What:** Map the inconsistent XML type values to a normalized set
**When to use:** During extraction, normalize all inlet/outlet types
**Example:**
```python
INLET_TYPE_MAP = {
    # Signal types
    "signal": "signal",
    "Signal": "signal",
    "signal/float": "signal/float",
    "Signal/Float": "signal/float",
    "signal or float": "signal/float",
    "float / signal": "signal/float",
    "float/signal": "signal/float",
    "signal, float": "signal/float",
    "int / signal": "signal/int",
    "int/signal": "signal/int",
    "signal, int": "signal/int",
    "int/float/sig": "signal/float",
    "signal/message": "signal/message",
    "signal/msg": "signal/message",
    "signal, message": "signal/message",
    "signal, list": "signal/list",
    "signal or multi-channel signal": "signal/mc",

    # Multichannel signal types
    "multi-channel signal": "mc_signal",
    "multi-channel signal, float": "mc_signal/float",
    "multi-channel signal, message": "mc_signal/message",

    # Matrix types
    "matrix": "matrix",
    "texture/matrix": "texture/matrix",

    # Control types (all map to 'control')
    "INLET_TYPE": "control",
    "OUTLET_TYPE": "control",
    "int": "int",
    "float": "float",
    "bang": "bang",
    "list": "list",
    "List": "list",
    "symbol": "symbol",
    "anything": "anything",
    "message": "message",
    "number": "number",
    "int/float": "number",
    "int, list": "int/list",
    "int/list": "int/list",
    "int/float/list": "anything",
    "bang/int": "bang/int",
    "bang/anything": "bang/anything",
    "dict": "dict",
    "dictionary": "dict",
    "midievent": "midievent",
    "inactive": "inactive",
}

def is_signal_type(normalized_type):
    """Returns True if inlet/outlet carries audio signal."""
    return normalized_type in ("signal", "signal/float", "signal/int",
                                "signal/message", "signal/list",
                                "signal/mc", "mc_signal",
                                "mc_signal/float", "mc_signal/message")
```

### Pattern 4: Hot/Cold Inlet Inference
**What:** Determine hot/cold semantics from XML structure and conventions
**When to use:** During extraction for all non-signal objects
**Example:**
```python
def infer_hot_cold(inlets, module):
    """
    MAX convention: inlet 0 (leftmost) is always hot.
    For control objects, all other inlets are cold (store but don't trigger output).
    For signal objects, all signal inlets are hot (audio rate).

    Exceptions to mark in overrides:
    - Some objects have multiple hot inlets (e.g., zl, coll)
    - Signal objects always process all signal inlets (they're all "hot" in audio domain)
    """
    for inlet in inlets:
        if module in ("msp",) and is_signal_type(inlet["type"]):
            inlet["hot"] = True  # All signal inlets are "hot" (processed at audio rate)
        elif inlet["id"] == 0:
            inlet["hot"] = True  # Leftmost is always hot for control objects
        else:
            inlet["hot"] = False  # All others cold by default
    return inlets
```

### Anti-Patterns to Avoid
- **Building a single monolithic JSON file:** Too large for context injection (~50MB+ for all objects). Split by domain.
- **Using SQLite as primary storage:** Adds query layer complexity. Claude consumes text/JSON directly. SQLite better as build artifact, not runtime format.
- **Parsing XML with regex:** XML refpages have nested structures (attributes with child enums, arggroups). Use proper XML parser.
- **Trusting XML inlet types blindly:** 591 objects use generic `INLET_TYPE` instead of specific types. Must handle gracefully with fallback classification.
- **Assuming fixed inlet/outlet counts for all objects:** ~20+ objects have variable I/O based on arguments. Store rules, not just counts.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| XML parsing | Custom string/regex parser | `xml.etree.ElementTree` | XML has edge cases (CDATA, entities, encoding); stdlib handles all of them |
| JSON schema validation | Custom validator | Define schema, validate during extraction | Catches malformed entries at build time |
| RNBO compatibility lookup | Manual whitelist | Cross-reference RNBO package refpages | 558 RNBO refpages provide authoritative list |
| PD confusion guard | Training-data-based rules | Explicit blocklist from known PD objects | Finite, enumerable list (osc~, lop~, hip~, etc.) |
| Object alias resolution | Hardcoded alias table | Extract from XML `discussion` sections + known aliases | XML documents some aliases; supplement with curated list |

**Key insight:** The MAX installation XML is the single source of truth. Everything else (py2max, manual curation, overrides) is supplementary. The extraction script should be idempotent and re-runnable as MAX updates.

## Common Pitfalls

### Pitfall 1: INLET_TYPE/OUTLET_TYPE Generics
**What goes wrong:** 591 objects have `type="INLET_TYPE"` instead of specific types. If stored as-is, the database cannot distinguish signal from control inlets for ~50% of Max-domain objects.
**Why it happens:** The XML refpages use placeholder types for many control-flow objects where the type is implied by the domain (Max objects = control, MSP objects = signal).
**How to avoid:** During extraction, apply domain-based inference: if `module="max"` and type is `INLET_TYPE`, classify as `control`. If `module="msp"` and type is `INLET_TYPE`, check the object name for `~` suffix and other signals.
**Warning signs:** Object entries where all inlets show type "INLET_TYPE" -- these need classification.

### Pitfall 2: Variable I/O Without Rules
**What goes wrong:** Objects like `pack 0 0 0` have 3 inlets but the XML only shows the default 2. Generating patches with wrong inlet counts causes connection errors.
**Why it happens:** XML reflects default argument count, not runtime behavior.
**How to avoid:** Maintain a curated `variable_io` list with rules describing how arguments change I/O counts. Currently identified objects: pack, unpack, route, select, trigger (t), gate, switch, funnel, spray, matrix~, selector~, router, routepass, and several others.
**Warning signs:** Connection validation fails for objects with non-default argument counts.

### Pitfall 3: Module Attribute Inconsistency
**What goes wrong:** The `module` attribute is inconsistent across XML files: "max", "Max", "msp", "MSP", "jit", "m4l", "" (empty), "core".
**Why it happens:** Different XML generators/editors across Cycling '74's codebase.
**How to avoid:** Normalize during extraction. Map: {"max", "Max"} -> "max", {"msp", "MSP"} -> "msp", {"jit"} -> "jit", {"m4l"} -> "m4l", {"core"} -> "max". For empty module, infer from file path (msp-ref/ -> msp, max-ref/ -> max).
**Warning signs:** Domain queries returning incomplete results.

### Pitfall 4: RNBO Objects Have Different Behavior
**What goes wrong:** Assuming RNBO `cycle~` is identical to MAX `cycle~`. RNBO cycle~ has 2 outlets (signal + phase), MAX cycle~ has 1 outlet. RNBO uses `rnbooptionlist` and `rnboattributelist` instead of standard `attributelist`.
**Why it happens:** RNBO is a separate runtime with its own object implementations.
**How to avoid:** RNBO refpages are a separate data source. When `rnbo_compatible: true`, store RNBO-specific differences (different outlet count, options, etc.) in a separate `rnbo_details` field.
**Warning signs:** Generated RNBO patches with wrong outlet counts or unsupported attributes.

### Pitfall 5: Gen~ Objects Use Different XML Schema
**What goes wrong:** Parsing Gen~ XML with the same code as core refpages fails. Gen~ uses `<constructorlist>`, `<geninletlist>`, and `kind="genobject_dsp"` instead of standard `<inletlist>` and `<outletlist>`.
**Why it happens:** Gen~ is a different object ecosystem with its own patcher format.
**How to avoid:** Write a separate parser branch for Gen~ objects that handles `<geninletlist>`, `<constructorlist>`, and `kind` attribute. Identify Gen~ objects by `module="gen-dsp"` or `module="gen-jit"` or `kind="genobject_*"`.
**Warning signs:** Gen~ objects with empty inlet/outlet lists in the database.

### Pitfall 6: PD Object Hallucination
**What goes wrong:** LLMs trained on both Pure Data and MAX documentation generate patches using PD-only objects (osc~, lop~, hip~, bp~, vcf~, tabread~, tabwrite~, catch~, throw~, readsf~, writesf~).
**Why it happens:** Training data conflates PD and MAX object names. Many have similar functions but different names.
**How to avoid:** Maintain an explicit PD blocklist. When Claude proposes an object, check against both the database (positive match) and the blocklist (negative match with suggested MAX equivalent).
**Warning signs:** Objects with tildes that aren't in the database -- likely PD objects.

### Pitfall 7: Hot/Cold Semantics Not in XML
**What goes wrong:** XML does not explicitly tag inlets as hot or cold. Without this data, Claude may generate patches with timing bugs (e.g., sending to cold inlet first, expecting output).
**Why it happens:** Hot/cold is a runtime semantic convention, not a property the XML documents.
**How to avoid:** Apply the convention rule (inlet 0 = hot, all others cold for control objects; all signal inlets are effectively "hot" for MSP objects). Override specific exceptions in overrides.json.
**Warning signs:** Patches where cold inlets receive data before hot inlets, causing unexpected ordering.

## Code Examples

### XML Extraction Core Logic
```python
# Source: Verified from MAX 9.1.2 XML refpage structure analysis
import xml.etree.ElementTree as ET
from pathlib import Path
import json

def parse_maxref_xml(filepath: Path) -> dict:
    """Parse a single .maxref.xml file into normalized object dict."""
    tree = ET.parse(filepath)
    root = tree.getroot()

    obj = {
        "name": root.get("name", ""),
        "module": root.get("module", "").lower(),
        "category": root.get("category", ""),
        "kind": root.get("kind", ""),
        "digest": "",
        "description": "",
        "inlets": [],
        "outlets": [],
        "arguments": [],
        "messages": [],
        "attributes": {},
        "seealso": [],
        "tags": [],
    }

    # Extract digest
    digest_el = root.find("digest")
    if digest_el is not None and digest_el.text:
        obj["digest"] = digest_el.text.strip()

    # Extract inlets
    inletlist = root.find("inletlist")
    if inletlist is not None:
        for inlet in inletlist.findall("inlet"):
            inlet_data = {
                "id": int(inlet.get("id", 0)),
                "type": inlet.get("type", "INLET_TYPE"),
                "digest": "",
            }
            dig = inlet.find("digest")
            if dig is not None and dig.text:
                inlet_data["digest"] = dig.text.strip()
            obj["inlets"].append(inlet_data)

    # Extract outlets
    outletlist = root.find("outletlist")
    if outletlist is not None:
        for outlet in outletlist.findall("outlet"):
            outlet_data = {
                "id": int(outlet.get("id", 0)),
                "type": outlet.get("type", "OUTLET_TYPE"),
                "digest": "",
            }
            dig = outlet.find("digest")
            if dig is not None and dig.text:
                outlet_data["digest"] = dig.text.strip()
            obj["outlets"].append(outlet_data)

    # Extract arguments
    objarglist = root.find("objarglist")
    if objarglist is not None:
        for arg in objarglist.findall("objarg"):
            arg_data = {
                "name": arg.get("name", ""),
                "type": arg.get("type", ""),
                "optional": arg.get("optional", "0") == "1",
            }
            dig = arg.find("digest")
            if dig is not None and dig.text:
                arg_data["digest"] = dig.text.strip()
            desc = arg.find("description")
            if desc is not None and desc.text:
                arg_data["description"] = desc.text.strip()
            obj["arguments"].append(arg_data)

    # Extract methods (message names)
    methodlist = root.find("methodlist")
    if methodlist is not None:
        for method in methodlist.findall("method"):
            obj["messages"].append(method.get("name", ""))

    # Extract seealso
    seealsolist = root.find("seealsolist")
    if seealsolist is not None:
        for sa in seealsolist.findall("seealso"):
            obj["seealso"].append(sa.get("name", ""))

    # Extract tags from metadata
    metadatalist = root.find("metadatalist")
    if metadatalist is not None:
        for md in metadatalist.findall("metadata"):
            if md.get("name") == "tag" and md.text:
                obj["tags"].append(md.text.strip())

    return obj
```

### Gen~ Object Parser Branch
```python
# Source: Verified from Gen package XML structure (gen-dsp, gen-jit)
def parse_gen_xml(filepath: Path) -> dict:
    """Parse Gen~ .maxref.xml with different schema."""
    tree = ET.parse(filepath)
    root = tree.getroot()

    obj = {
        "name": root.get("name", ""),
        "module": root.get("module", ""),  # gen-dsp, gen-jit, gen-common
        "category": root.get("category", ""),
        "kind": root.get("kind", ""),  # genobject_dsp, genobject_jit
        "digest": "",
        "description": "",
        "inlets": [],
        "outlets": [],
        "constructors": [],
        "seealso": [],
    }

    # Gen~ uses <geninletlist> instead of <inletlist>
    geninletlist = root.find("geninletlist")
    if geninletlist is not None:
        for i, inlet in enumerate(geninletlist.findall("geninlet")):
            obj["inlets"].append({
                "id": i,
                "name": inlet.get("name", ""),
                "type": inlet.get("type", "float"),
                "optional": inlet.get("optional", "0") == "1",
                "digest": "",
            })
            dig = inlet.find("digest")
            if dig is not None and dig.text:
                obj["inlets"][-1]["digest"] = dig.text.strip()

    # Gen~ uses <constructorlist> for argument patterns
    constructorlist = root.find("constructorlist")
    if constructorlist is not None:
        for con in constructorlist.findall("constructor"):
            dig = con.find("digest")
            if dig is not None and dig.text:
                obj["constructors"].append(dig.text.strip())

    return obj
```

### RNBO Compatibility Cross-Reference
```python
# Source: Verified RNBO refpage naming convention (rnbo_<objectname>.maxref.xml)
def build_rnbo_compatible_set(rnbo_refpage_dir: Path) -> set:
    """Build set of object names that are RNBO-compatible."""
    rnbo_names = set()
    for xml_file in rnbo_refpage_dir.glob("rnbo_*.maxref.xml"):
        # Strip rnbo_ prefix and .maxref.xml suffix
        name = xml_file.stem.replace("rnbo_", "", 1).replace(".maxref", "")
        rnbo_names.add(name)
    return rnbo_names
    # Result: 558 RNBO object names
    # 213 overlap with core MAX/MSP objects
    # 345 are RNBO-only (math ops, converters, etc.)
```

### PD Blocklist Structure
```json
{
  "_comment": "Pure Data objects that do NOT exist in MAX/MSP. LLMs commonly confuse these.",
  "blocklist": {
    "osc~": { "max_equivalent": "cycle~", "reason": "PD sinusoidal oscillator" },
    "lop~": { "max_equivalent": "onepole~", "reason": "PD one-pole lowpass filter" },
    "hip~": { "max_equivalent": "onepole~", "reason": "PD one-pole highpass filter" },
    "bp~": { "max_equivalent": "reson~", "reason": "PD bandpass filter" },
    "vcf~": { "max_equivalent": "reson~ or biquad~", "reason": "PD voltage-controlled filter" },
    "tabread~": { "max_equivalent": "index~ or play~ or wave~", "reason": "PD table read" },
    "tabwrite~": { "max_equivalent": "poke~ or record~", "reason": "PD table write" },
    "catch~": { "max_equivalent": "receive~", "reason": "PD audio bus receive" },
    "throw~": { "max_equivalent": "send~", "reason": "PD audio bus send" },
    "readsf~": { "max_equivalent": "sfplay~", "reason": "PD sound file reader" },
    "writesf~": { "max_equivalent": "sfrecord~", "reason": "PD sound file writer" },
    "tabread": { "max_equivalent": "table or coll", "reason": "PD table lookup" },
    "tabwrite": { "max_equivalent": "table or coll", "reason": "PD table write" },
    "soundfiler": { "max_equivalent": "buffer~", "reason": "PD sound file loader" },
    "vline~": { "max_equivalent": "line~", "reason": "PD virtual line" },
    "netsend": { "max_equivalent": "udpsend or mxj net.tcp.send", "reason": "PD network send" },
    "netreceive": { "max_equivalent": "udpreceive or mxj net.tcp.recv", "reason": "PD network receive" },
    "wrap~": { "max_equivalent": "pong~ @mode wrap", "reason": "PD wrap (MAX uses pong~ or %~ operator)" },
    "clip~": { "max_equivalent": "clip~ exists in MAX too -- verify context", "reason": "Both PD and MAX have clip~" }
  }
}
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Max 8 (no array/string objects) | MAX 9 adds array.*, string.*, dict operations | MAX 9 (2023) | 60+ new objects need version tagging |
| No ABL devices | ABL DSP devices (74 objects) | MAX 9 | New synthesis/effects primitives |
| No MC (multichannel) | MC multichannel wrapping (~210 objects) | MAX 8.1 (2019) | mc.* objects wrap existing MSP objects |
| Manual RNBO object list | RNBO has own refpage package (558 objects) | MAX 8.3+ | Authoritative RNBO compatibility source |
| Gen~ limited operators | Gen~ 194 operators (DSP + Jitter + common) | Ongoing | Separate parser needed for gen-specific XML schema |

**Deprecated/outdated:**
- py2max MaxRefDB caches 1,157 objects but is not authoritative -- use only for gap-filling
- Older MAX documentation may reference deprecated objects or removed features

## XML Schema Summary

### Core Refpage Schema (`<c74object>`)
| XML Element | Maps To | Notes |
|-------------|---------|-------|
| `@name` | object name | Primary identifier |
| `@module` | domain | Inconsistent casing: max/Max/msp/MSP/jit |
| `@category` | category/subcategory | Comma-separated, e.g., "MSP Synthesis" |
| `@kind` | object kind | Gen~ uses genobject_dsp, genobject_jit |
| `<digest>` | short description | 1-line summary |
| `<description>` | full description | May contain XML markup |
| `<inletlist>/<inlet>` | inlet definitions | `@id`, `@type`, `<digest>` |
| `<outletlist>/<outlet>` | outlet definitions | `@id`, `@type`, `<digest>` |
| `<objarglist>/<objarg>` | constructor arguments | `@name`, `@type`, `@optional` |
| `<methodlist>/<method>` | accepted messages | `@name`, `<arglist>` |
| `<attributelist>/<attribute>` | object attributes | `@name`, `@type`, `@get`, `@set` |
| `<seealsolist>/<seealso>` | related objects | `@name` |
| `<metadatalist>/<metadata>` | tags | `@name="tag"` entries |

### RNBO Refpage Extensions
| XML Element | Maps To | Notes |
|-------------|---------|-------|
| `<rnboinletlist>/<inlet>` | RNBO inlets | Uses `@id`, `@name`, `@type` |
| `<rnbooutletlist>/<outlet>` | RNBO outlets | Different from core outlets |
| `<rnbooptionlist>/<option>` | RNBO options | e.g., interpolation mode |
| `<rnboattributelist>/<attribute>` | RNBO attributes | Distinct from core attributes |

### Gen~ Refpage Extensions
| XML Element | Maps To | Notes |
|-------------|---------|-------|
| `<geninletlist>/<geninlet>` | Gen~ inlets | `@name`, `@type` (usually float) |
| `<constructorlist>/<constructor>` | Constructor patterns | Multiple forms |
| `@kind` = genobject_dsp/jit | Gen~ domain | DSP vs Jitter gen objects |

## File Count Inventory

| Source | Count | Domain |
|--------|-------|--------|
| Core max-ref | 473 | Max (control) |
| Core msp-ref | 455 | MSP (audio) + MC (~210 mc.* objects) |
| Core jit-ref | 210 | Jitter (video/matrix) |
| Core m4l-ref | 37 | Max for Live |
| Package: Gen~ | 194 | Gen~ (DSP + Jitter + common operators) |
| Package: RNBO | 560 | RNBO (558 unique objects) |
| Package: ableton-dsp | 74 | ABL devices (MAX 9) |
| Package: Jitter Tools | 99 | Jitter extensions |
| Package: Jitter Geometry | 27 | Jitter 3D geometry |
| Package: jit.mo | 8 | Jitter motion/animation |
| Package: maxforlive-elements | 3 | M4L UI elements |
| Package: Others | 8 | Misc packages |
| **TOTAL** | **2,148** | All domains |

## Inlet/Outlet Type Inventory

Types found across all 2,148 XML files:

| Normalized Type | XML Variants | Signal? | Count (approx) |
|----------------|-------------|---------|----------------|
| `control` | INLET_TYPE, OUTLET_TYPE | No | ~1,500 |
| `signal` | signal, Signal | Yes | ~757 |
| `signal/float` | signal/float, Signal/Float, float/signal, signal or float, signal, float | Yes (accepts float) | ~213 |
| `signal/int` | signal/int, int/signal, int / signal | Yes (accepts int) | ~10 |
| `signal/message` | signal/message, signal/msg, signal, message | Yes (accepts messages) | ~5 |
| `mc_signal` | multi-channel signal | Yes (multichannel) | ~30 |
| `matrix` | matrix | No (Jitter) | ~400 |
| `float` | float | No | ~50 |
| `int` | int | No | ~30 |
| `bang` | bang | No | ~10 |
| `list` | list, List | No | ~10 |
| `anything` | anything | No | ~20 |
| `dict` | dict, dictionary | No | ~5 |

## Open Questions

1. **MAX 9 Object Version Attribution**
   - What we know: array.*, string.*, abl.* objects are MAX 9 additions. MC objects came in MAX 8.1.
   - What's unclear: Exact version for each object; XML does not contain version metadata.
   - Recommendation: Create a curated `version_map` in overrides.json for known MAX 9 objects. Default `min_version: 8` for all others. This is a manual curation task.

2. **Gen~ Outlet Inference**
   - What we know: Gen~ XML uses `<geninletlist>` but does NOT have a `<genoutletlist>` in many files. Outlets are often implicit.
   - What's unclear: Whether gen~ outlets can be reliably inferred from the XML.
   - Recommendation: Gen~ objects output through their construct pattern. Most have 1 output. For DSP objects, default to 1 signal outlet. Curate exceptions in overrides.

3. **Object Aliases Completeness**
   - What we know: `t` -> trigger, `b` -> bangbang are common aliases. XML `<discussion>` sections sometimes mention aliases.
   - What's unclear: Full list of aliases across all objects.
   - Recommendation: Seed from known aliases (t, b, i, f, p, sel, r, s) and supplement during testing.

4. **py2max Gap Coverage**
   - What we know: py2max MaxRefDB has 1,157 objects with inlet/outlet counts and categories.
   - What's unclear: Exactly which fields py2max has that XML lacks, and whether the data is compatible.
   - Recommendation: Install py2max, dump its database, and diff against XML extraction to identify genuine gaps. This is a supplementary task after primary extraction.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | Python unittest + custom validation scripts |
| Config file | None -- Wave 0 creates test infrastructure |
| Quick run command | `python3 .claude/scripts/validate_db.py --quick` |
| Full suite command | `python3 .claude/scripts/validate_db.py --full` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| ODB-01 | Each object has name, maxclass, inlets, outlets, args, messages | unit | `python3 -m pytest tests/test_object_schema.py -x` | Wave 0 |
| ODB-02 | Database contains entries from XML, py2max, and overrides | integration | `python3 -m pytest tests/test_source_coverage.py -x` | Wave 0 |
| ODB-03 | Objects have min_version field | unit | `python3 -m pytest tests/test_version_tags.py -x` | Wave 0 |
| ODB-04 | MAX 9 objects present (array.*, string.*, abl.*) | smoke | `python3 -m pytest tests/test_max9_objects.py -x` | Wave 0 |
| ODB-05 | Objects have domain classification | unit | `python3 -m pytest tests/test_domain_classification.py -x` | Wave 0 |
| ODB-06 | Inlets/outlets have signal vs control types | unit | `python3 -m pytest tests/test_inlet_types.py -x` | Wave 0 |
| ODB-07 | RNBO-compatible objects flagged | integration | `python3 -m pytest tests/test_rnbo_flag.py -x` | Wave 0 |
| FRM-04 | CLAUDE.md exists with rules and conventions | smoke | `python3 -m pytest tests/test_claude_md.py -x` | Wave 0 |

### Sampling Rate
- **Per task commit:** `python3 .claude/scripts/validate_db.py --quick`
- **Per wave merge:** `python3 .claude/scripts/validate_db.py --full`
- **Phase gate:** Full suite green before `/gsd:verify-work`

### Wave 0 Gaps
- [ ] `tests/test_object_schema.py` -- covers ODB-01, validates JSON schema per object
- [ ] `tests/test_source_coverage.py` -- covers ODB-02, verifies multi-source extraction
- [ ] `tests/test_version_tags.py` -- covers ODB-03, checks min_version field exists
- [ ] `tests/test_max9_objects.py` -- covers ODB-04, spot-checks array.*, string.*, abl.*
- [ ] `tests/test_domain_classification.py` -- covers ODB-05, checks domain field
- [ ] `tests/test_inlet_types.py` -- covers ODB-06, validates signal/control classification
- [ ] `tests/test_rnbo_flag.py` -- covers ODB-07, validates rnbo_compatible flag
- [ ] `tests/test_claude_md.py` -- covers FRM-04, checks CLAUDE.md structure
- [ ] `tests/conftest.py` -- shared fixtures (load object database, paths)
- [ ] Framework install: `pip install pytest` (if not available)

## Sources

### Primary (HIGH confidence)
- MAX 9.1.2 installation XML refpages at `/Applications/Max.app/Contents/Resources/C74/docs/refpages/` -- 1,175 core files analyzed
- MAX 9.1.2 Gen~ package XML at `/Applications/Max.app/Contents/Resources/C74/packages/Gen/` -- 194 files, different schema confirmed
- MAX 9.1.2 RNBO package XML at `/Applications/Max.app/Contents/Resources/C74/packages/RNBO/` -- 560 files, RNBO-specific schema confirmed
- MAX 9.1.2 ableton-dsp package at `/Applications/Max.app/Contents/Resources/C74/packages/ableton-dsp/` -- 74 files
- Direct XML file analysis of trigger, cycle~, jit.matrix, pack, route, dac~, adsr~, svf~, snapshot~, int, loadbang -- schema fully mapped

### Secondary (MEDIUM confidence)
- [py2max GitHub repository](https://github.com/shakfu/py2max) -- MaxRefDB schema with 1,157 objects, SQLite storage
- [py2max MaxRef module](https://github.com/shakfu/py2max/tree/main/py2max/maxref) -- db.py, parser.py, category.py identified

### Tertiary (LOW confidence)
- PD/MAX object mapping -- verified core objects (osc~, lop~, hip~, bp~) against MAX installation; equivalents confirmed by checking MAX refpage existence

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- Python stdlib + MAX XML is straightforward, no external deps needed
- Architecture: HIGH -- JSON per domain is well-suited for Claude context injection, schema verified from XML analysis
- Pitfalls: HIGH -- Every pitfall identified from direct XML file analysis (type inconsistency, variable I/O, module casing all verified)
- RNBO compatibility: HIGH -- 558 RNBO refpages provide definitive list, naming convention verified
- Version tagging: MEDIUM -- No version field in XML; must curate manually for MAX 9 objects
- Hot/cold semantics: MEDIUM -- Convention-based inference; exceptions need manual curation
- Gen~ parsing: MEDIUM -- Different XML schema confirmed; outlet inference needs testing

**Research date:** 2026-03-09
**Valid until:** 2026-04-09 (stable -- MAX installation XML changes only with major releases)
