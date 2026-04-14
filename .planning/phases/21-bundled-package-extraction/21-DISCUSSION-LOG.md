# Phase 21: Bundled Package Extraction (BEAP + Vizzie) - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md -- this log preserves the alternatives considered.

**Date:** 2026-04-13
**Phase:** 21-bundled-package-extraction
**Areas discussed:** Abstraction parsing strategy, DB entry format, Jitter Geometry+Tools extraction, Verification approach

---

## Abstraction Parsing Strategy

| Option | Description | Selected |
|--------|-------------|----------|
| Unified parser | Single extract_abstractions.py handling both BEAP (embedded bpatcher) and Vizzie (top-level I/O) patterns | ✓ |
| Separate parsers | Independent beap_extract.py and vizzie_extract.py scripts | |

**User's choice:** Unified parser
**Notes:** None

| Option | Description | Selected |
|--------|-------------|----------|
| Help patches | Parse .maxhelp files for digest/description text | ✓ |
| inlet/outlet comments only | Use comment attributes on inlet/outlet objects | |
| package-info.json + filenames | Minimal: derive from folder path and filename | |

**User's choice:** Help patches
**Notes:** None

| Option | Description | Selected |
|--------|-------------|----------|
| Auto from folders | Walk BEAP/clippings/BEAP/{Category}/ subdirs for categories | ✓ |
| Manual category map | Hardcode category lookup dict | |
| You decide | Claude picks best approach | |

**User's choice:** Auto from folders
**Notes:** None

| Option | Description | Selected |
|--------|-------------|----------|
| Yes, include all | Parse everything matching bp.*.maxpat -- clippings + misc (192 total) | ✓ |
| Clippings only | Stick to 168 official clipping modules | |

**User's choice:** Yes, include all
**Notes:** None

---

## DB Entry Format for Bpatcher Abstractions

| Option | Description | Selected |
|--------|-------------|----------|
| abstraction_file path | Relative path to .maxpat within MAX package | ✓ |
| bpatcher dimensions | Default width/height from .maxpat rect | ✓ |
| category tag | Oscillator, Filter, LFO, etc. from folder structure | ✓ |
| signal_convention | BEAP=0-5V CV, Vizzie=Jitter matrices | ✓ |

**User's choice:** All four extra fields
**Notes:** Multi-select question

| Option | Description | Selected |
|--------|-------------|----------|
| bpatcher | Matches how they're instantiated in MAX | ✓ |
| newobj | Simpler but doesn't reflect actual instantiation pattern | |

**User's choice:** bpatcher
**Notes:** None

| Option | Description | Selected |
|--------|-------------|----------|
| Bpatcher only | BEAP/Vizzie designed as bpatchers with presentation UIs | ✓ |
| Both modes | Add alt_maxclass for plain abstraction instantiation | |

**User's choice:** Bpatcher only
**Notes:** None

---

## Jitter Geometry + Tools Extraction

| Option | Description | Selected |
|--------|-------------|----------|
| Just run the pipeline | Add as new SOURCE_DIRS entries in extract_objects.py | ✓ |
| Merge into jitter domain | Merge into main jitter/objects.json | |
| You decide | Claude picks best approach | |

**User's choice:** Just run the pipeline
**Notes:** None

| Option | Description | Selected |
|--------|-------------|----------|
| XML for all | All 99 have XML refpages, use XML pipeline for everything | ✓ |
| Hybrid approach | XML for compiled, abstraction parser for .maxpat-based | |

**User's choice:** XML for all
**Notes:** None

---

## Verification Approach

| Option | Description | Selected |
|--------|-------------|----------|
| Automated cross-check | Compare extracted I/O against help patch bpatcher instances | ✓ |
| Manual spot-check | Open 10-20 modules in MAX to verify | |
| Both | Automated first, manual on flagged mismatches | |

**User's choice:** Automated cross-check
**Notes:** None

| Option | Description | Selected |
|--------|-------------|----------|
| Yes, add integration test | Load DB, look up every object, verify I/O counts | ✓ |
| No, trust extraction | Skip extra test | |

**User's choice:** Yes, add integration test
**Notes:** None

---

## Claude's Discretion

- Parser implementation details (JSON traversal, error handling, output format)
- How to handle edge cases (BEAP modules with 0 I/O, malformed patches)
- Test structure and organization

## Deferred Ideas

None -- discussion stayed within phase scope.
