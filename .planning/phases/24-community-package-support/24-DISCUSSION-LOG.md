# Phase 24: Community Package Support - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md -- this log preserves the alternatives considered.

**Date:** 2026-04-15
**Phase:** 24-community-package-support
**Areas discussed:** Stub entry depth, Extraction UX, Install guidance, Package coverage

---

## Stub Entry Depth

| Option | Description | Selected |
|--------|-------------|----------|
| Curated object lists | Hand-curated JSON per package with object names, approximate I/O counts, signal types, and categories. Sourced from official docs/GitHub repos. | ✓ |
| Name-only stubs | Just object names and prefix per package. Enough for recognition but no I/O info. | |
| You decide | Claude picks the approach. | |

**User's choice:** Curated object lists
**Notes:** None

### Follow-up: Data source

| Option | Description | Selected |
|--------|-------------|----------|
| Official docs + GitHub | Scrape/transcribe from each package's official documentation and GitHub repos. | ✓ (combined) |
| Auto-extract from installed | Only curate for packages installed locally. Ship those curated JSONs. | ✓ (combined) |
| Crowdsource later | Ship name-only stubs now, add contribution workflow. | |

**User's choice:** Both 1 and 2 -- official docs as primary source, supplemented by local extraction
**Notes:** User explicitly wanted both approaches combined.

### Follow-up: Stub marking

| Option | Description | Selected |
|--------|-------------|----------|
| extracted: false flag | Keep existing field. Stubs have extracted: false. After extraction, upgrade to true. | ✓ |
| Separate stub schema | Lighter schema for stubs with just counts. Requires ObjectDatabase changes. | |
| No distinction | Stubs look identical to extracted entries. | |

**User's choice:** extracted: false flag
**Notes:** None

---

## Extraction UX

| Option | Description | Selected |
|--------|-------------|----------|
| CLI command | Add --package flag to extract_objects.py. Auto-detects install path. | ✓ |
| Integrated in /max-config | Extract during package selection in /max-config. | |
| Auto-detect on DB load | ObjectDatabase auto-extracts on init if package found installed. | |

**User's choice:** CLI command
**Notes:** None

### Follow-up: Path detection

| Option | Description | Selected |
|--------|-------------|----------|
| Auto-detect first, fallback to --path | Check standard paths, require --path if not found. | ✓ |
| Always require --path | User must always specify path. | |
| You decide | Claude picks. | |

**User's choice:** Auto-detect first, fallback to --path
**Notes:** None

### Follow-up: Extraction method

| Option | Description | Selected |
|--------|-------------|----------|
| XML pipeline + abstraction fallback | XML for compiled externals, abstraction parser for mixed packages. Auto-detect. | ✓ |
| XML only | Only XML refpage extraction. | |
| You decide | Claude picks. | |

**User's choice:** XML pipeline + abstraction fallback
**Notes:** None

---

## Install Guidance

| Option | Description | Selected |
|--------|-------------|----------|
| Generation-time warning | Non-blocking comment in output about missing package. | |
| Validation pipeline warning | Post-generation validation flags unextracted objects. | |
| Both generation + validation | Belt and suspenders. | |
| Block until installed | Refuse to generate with unextracted packages. | ✓ |

**User's choice:** Block until installed
**Notes:** None

### Follow-up: Block message content

| Option | Description | Selected |
|--------|-------------|----------|
| Install + extract instructions | Full unblock path with install and extraction commands. | ✓ |
| Just install instruction | Only install instruction, skip extraction step. | |
| You decide | Claude picks wording. | |

**User's choice:** Install + extract instructions
**Notes:** None

### Follow-up: Block check mechanism

| Option | Description | Selected |
|--------|-------------|----------|
| Check extracted flag | Block if extracted: false in package_info.json. Simple boolean. | ✓ |
| Check filesystem + extracted | Check install dir exists AND extracted flag. More helpful messages. | |
| You decide | Claude picks. | |

**User's choice:** Check extracted flag
**Notes:** None

---

## Package Coverage

| Option | Description | Selected |
|--------|-------------|----------|
| All 10 in package_info | All registered community packages including Cage, Dada, EARS, RTK. | ✓ |
| Roadmap 6 only | Just the 6 specified in roadmap. | |
| Prioritized tiers | Full stubs for top 3, name-only for rest. | |

**User's choice:** All 10 in package_info
**Notes:** None

### Follow-up: RNBO treatment

| Option | Description | Selected |
|--------|-------------|----------|
| Leave RNBO as-is | Already has full DB coverage. No community package treatment. | ✓ |
| Add RNBO to package gating | Register as tier: licensed, gate like community packages. | |
| You decide | Claude assesses risk/benefit. | |

**User's choice:** Leave RNBO as-is
**Notes:** None

---

## Claude's Discretion

- Exact object lists per community package (determined by documentation research)
- Pipeline auto-detection logic
- Exact wording of block messages per install method
- How extraction updates package_info.json fields

## Deferred Ideas

None -- discussion stayed within phase scope.
