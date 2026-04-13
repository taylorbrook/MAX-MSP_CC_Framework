# Requirements: MaxSystem

**Defined:** 2026-04-13
**Core Value:** Claude can generate valid, well-structured MAX/MSP patches and code that an expert user opens in MAX and they work — with as much automated validation as possible before manual testing.

## v4.0 Requirements

Requirements for v4.0 Package Integration milestone. Each maps to roadmap phases.

### DB Schema & Infrastructure

- [ ] **DBSI-01**: Every package object in the DB is tagged with its source package name
- [ ] **DBSI-02**: Package registry (`package_info.json`) tracks name, tier, version, install method, prefix, and description per package
- [ ] **DBSI-03**: ObjectDatabase supports `allowed_packages` filter parameter for package-scoped lookups
- [ ] **DBSI-04**: ObjectDatabase provides `list_packages()` and `get_package_objects(pkg)` methods
- [ ] **DBSI-05**: Package objects stored in per-package subdirectories (`packages/beap/objects.json`, `packages/vizzie/objects.json`, etc.)
- [ ] **DBSI-06**: Existing 87 `abl.*`/`mira.*` package objects migrated to per-package subdirectories with package tags

### Extraction Pipeline

- [ ] **EXTR-01**: Abstraction extractor parses bpatcher-based packages (embedded and file-referenced) to produce DB entries
- [ ] **EXTR-02**: BEAP modules (~168) extracted with correct inlet/outlet counts and types
- [ ] **EXTR-03**: Vizzie modules (~110) extracted with correct inlet/outlet counts
- [ ] **EXTR-04**: Jitter Geometry objects (~27) extracted via existing XML pipeline
- [ ] **EXTR-05**: Jitter Tools objects (~99) extracted via existing XML/hybrid pipeline
- [ ] **EXTR-06**: Signal type inference detects signal vs control inlets/outlets from connection topology
- [ ] **EXTR-07**: Inlet/outlet descriptions extracted from help patches or presentation-mode comment boxes
- [ ] **EXTR-08**: Extraction commands available for user-installed community packages

### Generation & Gating

- [ ] **GENG-01**: `add_box()` auto-routes to `add_bpatcher()` when DB entry has `maxclass: "bpatcher"`
- [ ] **GENG-02**: `/max-build` prompts user for per-patch package permission before using package objects
- [ ] **GENG-03**: `/max-iterate` prompts user before introducing package objects not previously used in the patch
- [ ] **GENG-04**: Validation Layer 2 warns on package objects not approved for the current patch
- [ ] **GENG-05**: `add_bpatcher()` auto-populates outlet types and dimensions from DB metadata

### Agent Intelligence

- [ ] **AGNT-01**: Agent router dispatches to correct specialist based on package keywords (BEAP, Vizzie, FluCoMa, etc.)
- [ ] **AGNT-02**: Package-specific companion rules in `relationships.json` (BEAP module pairs, Vizzie chains)
- [ ] **AGNT-03**: Agent SKILL.md files updated with package-specific guidance sections
- [ ] **AGNT-04**: BEAP domain rules suppress +/-5V false positives in DSP critic
- [ ] **AGNT-05**: Layout overrides for bpatcher modules (larger dimensions than standard newobj boxes)

### Community & Licensed Packages

- [ ] **COMM-01**: Stub DB entries for all 11 community/licensed packages (FluCoMa, CNMAT, Bach, Odot, ml.*, IRCAM Spat, RNBO, Cage, Dada, EARS, Rhythmic & Time Toolkit)
- [ ] **COMM-02**: Stub entries include package name, prefix, install instructions, and `extracted: false` flag
- [ ] **COMM-03**: Extraction commands populate full DB entries from installed community packages
- [ ] **COMM-04**: Agent prompts surface install guidance when stub objects are referenced

### Templates & Critics

- [ ] **TMPL-01**: Starter templates for common package workflows (BEAP subtractive synth, Vizzie VJ chain, FluCoMa analysis)
- [ ] **TMPL-02**: Package-aware critics: BEAP signal convention checker, Bach llll type mismatch detection
- [ ] **TMPL-03**: BEAP silent-patch detection critic (missing audio output)
- [ ] **TMPL-04**: Template integration with `/max-new` project scaffolding

## Future Requirements

### Deep Package Support

- **DEEP-01**: Per-package version tracking with extraction re-run on update
- **DEEP-02**: Package dependency graph (Bach -> Cage -> Dada -> EARS chain)
- **DEEP-03**: Auto-discovery of user-installed packages via MAX packages folder scan

## Out of Scope

| Feature | Reason |
|---------|--------|
| Runtime MAX package installation | Cannot control MAX from Claude |
| Package object auto-fix/update | User decides, framework reports |
| Real-time package availability checking | No MAX automation — offline validation only |
| Custom user object extraction | Separate feature, not package scope |

## Traceability

Which phases cover which requirements. Updated during roadmap creation.

| Requirement | Phase | Status |
|-------------|-------|--------|
| DBSI-01 | — | Pending |
| DBSI-02 | — | Pending |
| DBSI-03 | — | Pending |
| DBSI-04 | — | Pending |
| DBSI-05 | — | Pending |
| DBSI-06 | — | Pending |
| EXTR-01 | — | Pending |
| EXTR-02 | — | Pending |
| EXTR-03 | — | Pending |
| EXTR-04 | — | Pending |
| EXTR-05 | — | Pending |
| EXTR-06 | — | Pending |
| EXTR-07 | — | Pending |
| EXTR-08 | — | Pending |
| GENG-01 | — | Pending |
| GENG-02 | — | Pending |
| GENG-03 | — | Pending |
| GENG-04 | — | Pending |
| GENG-05 | — | Pending |
| AGNT-01 | — | Pending |
| AGNT-02 | — | Pending |
| AGNT-03 | — | Pending |
| AGNT-04 | — | Pending |
| AGNT-05 | — | Pending |
| COMM-01 | — | Pending |
| COMM-02 | — | Pending |
| COMM-03 | — | Pending |
| COMM-04 | — | Pending |
| TMPL-01 | — | Pending |
| TMPL-02 | — | Pending |
| TMPL-03 | — | Pending |
| TMPL-04 | — | Pending |

**Coverage:**
- v4.0 requirements: 32 total
- Mapped to phases: 0
- Unmapped: 32

---
*Requirements defined: 2026-04-13*
*Last updated: 2026-04-13 after initial definition*
