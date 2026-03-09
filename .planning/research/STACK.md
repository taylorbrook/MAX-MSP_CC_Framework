# Technology Stack

**Project:** MaxSystem -- Claude Code Framework for MAX/MSP Development
**Researched:** 2026-03-08
**Overall Confidence:** HIGH

## Executive Summary

MaxSystem is a Claude Code development framework, not a MAX/MSP application. The framework infrastructure (agents, skills, hooks, validators, templates, object database) runs entirely within the Claude Code ecosystem using its native extension points: skills (`.claude/skills/`), agents (`.claude/agents/`), hooks (`.claude/hooks/`), and scripts (`.claude/scripts/`). The primary runtime for validation scripts, database construction, and code generation utilities is **Python 3**, matching the Plugin Freedom System's proven architecture and leveraging the existing `py2max` library for .maxpat generation/validation. TypeScript is used only where it provides clear advantages (Zod schemas for .maxpat JSON validation, Node for Max code generation testing).

The .maxpat format is an undocumented JSON format -- Cycling '74 has never published a specification. However, the structure is reverse-engineerable and well-understood through py2max (1,157 documented objects, 418+ tests) and direct examination of the 1,175+ maxref XML files bundled with the local MAX installation at `/Applications/Max.app/Contents/Resources/C74/docs/refpages/`.

## Recommended Stack

### Framework Infrastructure (Claude Code Extension System)

| Technology | Version | Purpose | Why | Confidence |
|------------|---------|---------|-----|------------|
| Claude Code Skills | Current | Slash commands for patch generation, project lifecycle | Native Claude Code extension point; skills = `/slash-commands` with SKILL.md frontmatter, supporting files, and subagent delegation | HIGH |
| Claude Code Agents | Current | Specialized subagents (DSP, patching, Gen~, RNBO~, externals, UI) | Native `.claude/agents/*.md` files with system prompts, tool restrictions, and model selection; proven in Plugin Freedom System with 11 agents | HIGH |
| Claude Code Hooks | Current | Pre/post validation, agent memory, session management | 16 hook events (PreToolUse, PostToolUse, Stop, SessionStart, SubagentStop, etc.); hooks receive JSON on stdin, return decisions on stdout | HIGH |
| Python 3.14+ | 3.14.2 (local) | Hook scripts, validators, database construction, extraction | Matches Plugin Freedom System architecture; direct access to py2max; XML parsing for maxref extraction; no compilation step | HIGH |
| CLAUDE.md | Current | Framework knowledge base, object reference summaries, conventions | Persistent context loaded every session; tiered (global, project, nested) | HIGH |

### .maxpat JSON Generation and Validation

| Technology | Version | Purpose | Why | Confidence |
|------------|---------|---------|-----|------------|
| py2max | Latest (pip) | .maxpat file generation and manipulation | Purpose-built Python library for offline .maxpat generation; Patcher/Box/Patchline classes mapping 1:1 to JSON format; 5 layout strategies; round-trip JSON support; 1,157 documented objects in MaxRef database; 418+ tests | HIGH |
| Zod | 4.3.x | .maxpat JSON schema validation (TypeScript layer) | 14x faster string parsing vs Zod 3; TypeScript-first with static type inference; can define strict schemas for patcher structure, box definitions, patchline connections; used for pre-generation validation of patch structure | MEDIUM |
| fast-xml-parser | 5.4.x | Parse maxref XML files during database construction | Zero dependencies; TypeScript native; 3,800+ ops/s; parses `<c74object>` XML with inlets, outlets, arguments, attributes, messages into JSON for object database | HIGH |
| Custom JSON Schema | N/A | .maxpat format specification (reverse-engineered) | No official spec exists; must define from examination of real .maxpat files; key structure: `{ patcher: { fileversion, appversion, rect, boxes: [{ box: { id, maxclass, numinlets, numoutlets, outlettype, patching_rect, text } }], lines: [{ patchline: { source: [id, outlet], destination: [id, inlet] } }] } }` | HIGH |

### Object Database Construction

| Technology | Version | Purpose | Why | Confidence |
|------------|---------|---------|-----|------------|
| Python 3 + fast-xml-parser | See above | Extract structured data from 1,175+ maxref XML files | XML files at `/Applications/Max.app/Contents/Resources/C74/docs/refpages/{max-ref,msp-ref,jit-ref,m4l-ref}/` plus Gen (189 files) and RNBO (560 files); c74object XML schema includes: name, module, category, digest, inletlist, outletlist, objarglist, attributelist, messagelist, seealsolist | HIGH |
| SQLite | 3.x (stdlib) | Object database storage | Zero-config; Python stdlib; fast queries; single-file DB; can bundle with framework; queryable for inlet/outlet counts, argument types, categories, version compatibility | HIGH |
| JSON export | N/A | Portable object reference for CLAUDE.md injection | Export SQLite data as JSON for embedding in agent context; tiered: summary (names + categories), detail (inlets/outlets/args), full (everything including messages and attributes) | HIGH |

### MAX External Development Support

| Technology | Version | Purpose | Why | Confidence |
|------------|---------|---------|-----|------------|
| Min-DevKit | 0.6.0 | C++ external development (recommended path) | Modern C++; CMake-based; includes testing framework, automatic documentation generation, package creation scripts; Apple Silicon support since v0.6.0; templates for common external types | HIGH |
| Max SDK | 8.2.0 | C external development (fallback/advanced) | Traditional C API; more low-level control; same CMake build system since 8.2; Apple Silicon support; use when Min-DevKit abstractions are insufficient or mixing C/C++ | MEDIUM |
| CMake | 3.19+ | Build system for externals | Required by both Min-DevKit and Max SDK; generates Xcode projects on macOS; framework generates CMakeLists.txt templates | HIGH |

**Recommendation: Min-DevKit as primary, Max SDK as fallback.** Min-DevKit provides modern C++ with built-in testing, documentation generation, and package scaffolding. The two share unified base headers since SDK 8.2. Use Max SDK directly only when needing C-only interfaces or low-level API access not exposed by Min-DevKit.

### Gen~/RNBO~/Node for Max Code Generation

| Technology | Version | Purpose | Why | Confidence |
|------------|---------|---------|-----|------------|
| GenExpr (custom parser) | N/A | Gen~ codebox code generation and validation | GenExpr is C/JavaScript-like syntax with `inN`/`outN` keywords, `History`, `Data`, `Buffer`, `Param` declarations; no external parser exists -- must build custom tokenizer/validator for syntax checking | MEDIUM |
| RNBO object subset | MAX 9.x | RNBO patch generation | RNBO uses a subset of Max objects in `rnbo~` subpatchers; stored as `.rbnopat` (same JSON format as .maxpat); py2max supports .rbnopat generation; Gen can be embedded within RNBO | HIGH |
| Node.js | 24.x (local) | Node for Max code generation and testing | N4M scripts use `require("max-api")` for Max communication; framework generates testable JavaScript with `max-api` calls stubbed for offline testing; `node.script` object hosts in MAX | HIGH |
| max-api (npm) | Latest | Node for Max API stubs for testing | `maxAPI.addHandler()`, `maxAPI.outlet()`, `maxAPI.getDict()`, `maxAPI.post()` -- framework creates mock/stub versions for offline test execution | MEDIUM |

### Testing and Validation

| Technology | Version | Purpose | Why | Confidence |
|------------|---------|---------|-----|------------|
| Python unittest/pytest | stdlib / latest | Hook validators, database tests, .maxpat structure validation | Matches Plugin Freedom System pattern; validators run as hook scripts via `python3 script.py`; direct integration with py2max test infrastructure | HIGH |
| Vitest | 4.0.x | TypeScript schema tests, Node for Max code tests | 17M weekly downloads; first-class ESM + TypeScript support; fast execution; use for Zod schema validation tests and N4M generated code tests | MEDIUM |
| Custom validators (Python) | N/A | Multi-layer patch validation | Pre-generation: object existence check, inlet/outlet compatibility; Post-generation: JSON structure, connection validity, layout sanity; Domain-specific: DSP signal flow, Gen~ syntax, RNBO object subset | HIGH |

### Patch Layout Engine

| Technology | Version | Purpose | Why | Confidence |
|------------|---------|---------|-----|------------|
| py2max layout strategies | Latest | Object positioning algorithms | 5 built-in strategies: grid, flow, columnar, matrix, horizontal/vertical; framework extends with domain-aware layout (DSP chains top-to-bottom, control left-to-right, UI objects in presentation view) | HIGH |
| Custom layout rules (Python) | N/A | MAX-idiomatic positioning | `patching_rect: [x, y, width, height]` per box; grid-snap to 5px or 15px; avoid overlaps; route patch cords to minimize crossings; group related objects; standard object sizes per maxclass | HIGH |

## Alternatives Considered

| Category | Recommended | Alternative | Why Not |
|----------|-------------|-------------|---------|
| Framework language | Python 3 (hooks/validators) | TypeScript/Node.js for everything | Plugin Freedom System proves Python hooks work; py2max is Python; XML parsing trivial in Python; no compilation step; TypeScript adds build complexity for hook scripts |
| .maxpat generation | py2max (Python) | Custom TypeScript .maxpat builder | py2max has 418+ tests, 1,157 documented objects, 5 layout strategies, round-trip support; building equivalent in TypeScript is months of work for no benefit |
| Schema validation | Zod 4.x | Ajv (JSON Schema) | Zod provides TypeScript type inference; more ergonomic API; 14x performance improvement in v4; JSON Schema import support if needed later |
| Schema validation | Zod 4.x | TypeBox | TypeBox is faster and JSON-Schema-native, but Zod has larger ecosystem, better documentation, and we need TypeScript types more than JSON Schema output |
| XML parsing | fast-xml-parser | xml2js | xml2js is callback-based, slower, heavier; fast-xml-parser is zero-dependency, TypeScript-native, actively maintained |
| External SDK | Min-DevKit primary | Max SDK only | Min-DevKit provides testing framework, auto-docs, modern C++; Max SDK alone requires more boilerplate; both use same base headers since 8.2 |
| Object database | SQLite | PostgreSQL, MongoDB | Overkill for a local framework; SQLite is zero-config, single-file, Python stdlib, fast enough for 2,000 objects |
| Testing | Vitest | Jest | Vitest is faster, ESM-native, 17M weekly downloads; Jest is legacy; Vitest 4.0 is the 2026 standard |
| Layout engine | py2max + custom | D3.js force-directed | Overkill; MAX patches use grid-based layouts, not force-directed graphs; simple algorithms sufficient |
| Hook scripts | Python | Bash | Python provides structured JSON parsing, error handling, file I/O; bash scripts become unmanageable at Plugin Freedom System scale |

## Stack Architecture Diagram

```
Claude Code Session
|
+-- CLAUDE.md (framework knowledge, object summaries, conventions)
|
+-- .claude/agents/ (domain-specialized subagents)
|   +-- patching-agent.md      (general MAX patching)
|   +-- dsp-agent.md           (MSP/audio/Gen~)
|   +-- rnbo-agent.md          (RNBO~ export patches)
|   +-- n4m-agent.md           (Node for Max / js)
|   +-- externals-agent.md     (C/C++ external development)
|   +-- ui-agent.md            (UI objects, presentation view)
|   +-- validation-agent.md    (multi-layer critic)
|
+-- .claude/skills/ (slash commands for workflow)
|   +-- patch-generate/        (create .maxpat from description)
|   +-- gen-codebox/            (generate Gen~ code)
|   +-- rnbo-export/            (generate RNBO~ patches)
|   +-- n4m-script/             (generate Node for Max JS)
|   +-- external-scaffold/      (scaffold Min-DevKit project)
|   +-- object-lookup/          (query object database)
|   +-- patch-validate/         (run validation suite)
|   +-- project-init/           (initialize MAX project)
|
+-- .claude/hooks/ (automated validation)
|   +-- PostToolUse.py          (validate written .maxpat files)
|   +-- Stop.py                 (end-of-turn validation summary)
|   +-- SessionStart.py         (load project context)
|   +-- validators/
|       +-- validate-patch-structure.py
|       +-- validate-connections.py
|       +-- validate-objects.py
|       +-- validate-gen-syntax.py
|       +-- validate-layout.py
|
+-- .claude/scripts/ (utilities)
|   +-- extract-maxref.py       (build object DB from XML)
|   +-- generate-patch.py       (py2max wrapper)
|   +-- validate-maxpat.py      (standalone validator)
|
+-- db/
|   +-- objects.sqlite          (object database)
|   +-- objects-summary.json    (for CLAUDE.md injection)
|   +-- objects-detail.json     (full reference data)
|
+-- templates/
|   +-- patches/                (template .maxpat files)
|   +-- gen/                    (Gen~ codebox templates)
|   +-- rnbo/                   (RNBO~ patch templates)
|   +-- n4m/                    (Node for Max script templates)
|   +-- externals/              (Min-DevKit project templates)
```

## Key Technology Details

### .maxpat JSON Format (Reverse-Engineered)

The .maxpat format is undocumented by Cycling '74. Based on examination of installed MAX patches:

```json
{
  "patcher": {
    "fileversion": 1,
    "appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
    "rect": [x, y, width, height],
    "default_fontsize": 12.0,
    "default_fontname": "Arial",
    "gridsize": [15.0, 15.0],
    "boxes": [
      {
        "box": {
          "id": "obj-1",
          "maxclass": "newobj|message|comment|number|flonum|toggle|button|...",
          "numinlets": N,
          "numoutlets": N,
          "outlettype": ["signal", "", "bang", ...],
          "patching_rect": [x, y, width, height],
          "text": "cycle~ 440"
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "source": ["obj-1", 0],
          "destination": ["obj-2", 0],
          "disabled": 0,
          "hidden": 0
        }
      }
    ]
  }
}
```

### maxref XML Schema (Object Database Source)

1,175 core objects + 189 Gen objects + 560 RNBO objects available at:
- `/Applications/Max.app/Contents/Resources/C74/docs/refpages/{max-ref,msp-ref,jit-ref,m4l-ref}/`
- `/Applications/Max.app/Contents/Resources/C74/packages/Gen/docs/refpages/`
- `/Applications/Max.app/Contents/Resources/C74/packages/RNBO/docs/refpages/`

XML structure per object:
```xml
<c74object name="cycle~" module="msp" category="MSP Synthesis">
  <digest>Sinusoidal oscillator</digest>
  <description>...</description>
  <metadatalist>
    <metadata name="tag">MSP</metadata>
  </metadatalist>
  <inletlist>
    <inlet id="0" type="signal/float">
      <digest>Frequency</digest>
    </inlet>
  </inletlist>
  <outletlist>
    <outlet id="0" type="signal">
      <digest>Output</digest>
    </outlet>
  </outletlist>
  <objarglist>
    <objarg name="frequency" optional="1" type="number" units="hz">
      <digest>Oscillator frequency</digest>
    </objarg>
  </objarglist>
  <attributelist>...</attributelist>
  <methodlist>...</methodlist>
  <seealsolist>...</seealsolist>
</c74object>
```

### GenExpr Language (Gen~ Codebox)

GenExpr is used in `gen~`, `gen`, `jit.gen`, `jit.pix`, `jit.gl.pix` codeboxes. Key syntax:
- C/JavaScript-like expression syntax
- `inN` / `outN` keywords for inlet/outlet binding (1-indexed)
- `in` and `out` shorthand for `in1` and `out1`
- `History` for single-sample delay (state)
- `Data` and `Buffer` for named data access
- `Param` for exposing parameters to parent patcher
- `Require` for importing GenExpr libraries
- All Gen operators available as functions: `cycle`, `phasor`, `noise`, `clip`, `scale`, `mix`, etc.
- Semicolons required for multi-statement expressions
- No official parser/validator exists -- must build custom

### Node for Max (max-api)

```javascript
const maxAPI = require("max-api");

// Message handlers
maxAPI.addHandler("bang", () => { ... });
maxAPI.addHandler("myMessage", (arg1, arg2) => { ... });
maxAPI.addHandlers({ bang: () => {}, list: (...args) => {} });

// Output to Max
maxAPI.outlet(value);
maxAPI.outletBang();

// Dictionary access
const dict = await maxAPI.getDict("myDict");
await maxAPI.setDict("myDict", { key: "value" });
await maxAPI.updateDict("myDict", { key: "newValue" });

// Logging
maxAPI.post("message to Max console");
```

### Claude Code Hook Events (Used by Framework)

| Hook Event | Framework Use | Script |
|------------|---------------|--------|
| `SessionStart` | Load project context, inject object DB summary into CLAUDE.md | `SessionStart.py` |
| `PreToolUse` (matcher: `Write`) | Pre-validate .maxpat before writing | `validate-patch-structure.py` |
| `PostToolUse` (matcher: `Write\|Edit`) | Validate written .maxpat files, check connections, verify objects exist in DB | `PostToolUse.py` |
| `Stop` | End-of-turn validation summary, update agent memory | `Stop.py` |
| `SubagentStop` | Merge subagent findings, write back memory | `SubagentStop.py` |
| `PreCompact` | Save critical context before compaction | `PreCompact.py` |

## Installation

### Python Dependencies

```bash
# Core .maxpat generation
pip install py2max

# Additional utilities (all stdlib or minimal)
# - sqlite3 (stdlib)
# - json (stdlib)
# - xml.etree.ElementTree (stdlib -- alternative to fast-xml-parser for Python-only path)
# - pathlib (stdlib)
```

### Node.js Dependencies (for TypeScript validation layer and N4M testing)

```bash
# Schema validation
npm install zod@^4.3

# XML parsing (for TypeScript-side object DB tools if needed)
npm install fast-xml-parser@^5.4

# Testing
npm install -D vitest@^4.0
npm install -D typescript@^5.9

# Node for Max API stubs (for offline testing of generated N4M scripts)
npm install -D max-api
```

### MAX SDK / External Development (Per-Project)

```bash
# Min-DevKit (clone into project packages directory)
git clone --recursive https://github.com/Cycling74/min-devkit.git

# Max SDK (alternative, for C externals)
git clone --recursive https://github.com/Cycling74/max-sdk.git

# CMake (required for both)
brew install cmake  # 3.19+ required
```

## Version Compatibility Matrix

| Component | Minimum | Recommended | Notes |
|-----------|---------|-------------|-------|
| MAX/MSP | 8.0 | 9.x | Object DB tracks version-specific availability |
| Python | 3.10 | 3.14+ | f-strings, match statements, stdlib improvements |
| Node.js | 20.x | 24.x | N4M uses Node 20+ in MAX 9 |
| TypeScript | 5.5 | 5.9+ | Required by Zod 4.x |
| CMake | 3.19 | 3.28+ | Required by Min-DevKit and Max SDK |
| Xcode | 14 | 16+ | Required for macOS external compilation |

## What NOT to Use

| Technology | Why Not |
|------------|---------|
| `xml2js` | Legacy callback-based XML parser; slower than fast-xml-parser; no TypeScript types |
| `Jest` | Legacy testing framework; slower than Vitest; no native ESM support |
| `Zod 3.x` | Superseded by Zod 4.x with 14x performance improvement; use v4 |
| PostgreSQL/MongoDB | Massive overkill for a local object database of ~2,000 entries |
| D3.js/Graphviz for layout | MAX patches use grid-based layouts, not graph visualizations |
| Docker | Unnecessary complexity; framework runs in local Claude Code sessions |
| electron/web UI | Framework is Claude Code-native; no web interface needed |
| Pure TypeScript hooks | Plugin Freedom System proves Python hooks work well at scale; py2max is Python; XML parsing trivial in Python |
| `node-gyp` | Use CMake for external compilation; both SDKs are CMake-based |
| PureData format conversion | Out of scope; .maxpat is the only target format |

## Sources

### Official Documentation
- [Max SDK GitHub](https://github.com/Cycling74/max-sdk) -- v8.2.0, CMake-based, Apple Silicon support
- [Min-DevKit GitHub](https://github.com/Cycling74/min-devkit) -- v0.6.0, modern C++ external development
- [py2max GitHub](https://github.com/shakfu/py2max) -- Python library for .maxpat generation
- [Claude Code Hooks Reference](https://code.claude.com/docs/en/hooks) -- 16 hook events, command/HTTP/prompt types
- [Claude Code Skills Documentation](https://code.claude.com/docs/en/skills) -- Skill creation, frontmatter, subagent delegation
- [Claude Code Plugins Documentation](https://code.claude.com/docs/en/plugins) -- Plugin structure, manifest, distribution
- [GenExpr Documentation (Max 8)](https://docs.cycling74.com/max8/vignettes/gen_genexpr) -- GenExpr syntax reference
- [Gen Overview](https://docs.cycling74.com/userguide/gen/_gen_overview/) -- Gen variants, codebox, operators
- [RNBO Documentation](https://docs.cycling74.com/userguide/rnbo/) -- RNBO patching, export targets
- [Node for Max API](https://docs.cycling74.com/nodeformax/api/module-max-api.html) -- max-api methods and types
- [Max 9 Release Notes](https://cycling74.com/releases/max/9.0.0) -- MAX 9 features including codebox variants

### Community / Ecosystem
- [Cycling '74 Forum: .maxpat JSON format](https://cycling74.com/forums/specification-for-maxpat-json-format) -- No official spec exists
- [Cycling '74 Forum: Min-DevKit purpose](https://cycling74.com/forums/what-is-the-purpose-of-the-min-devkit) -- Min vs SDK comparison
- [maxobjects.com](http://www.maxobjects.com/) -- Community object database
- [Zod v4 Release Notes](https://zod.dev/v4) -- Performance improvements, Zod Mini
- [Vitest 4.0 Announcement](https://vitest.dev/blog/vitest-4) -- Stable browser mode, visual regression
- [fast-xml-parser npm](https://www.npmjs.com/package/fast-xml-parser) -- v5.4.x, TypeScript, zero-dependency

### Local Resources (Verified on Machine)
- MAX Installation: `/Applications/Max.app/` -- confirmed present
- maxref XML files: 1,175 core + 189 Gen + 560 RNBO = 1,924 total object reference files
- Plugin Freedom System: `/Users/taylorbrook/Dev/VST-development/.claude/` -- 11 agents, 27 skills, Python hooks architecture
