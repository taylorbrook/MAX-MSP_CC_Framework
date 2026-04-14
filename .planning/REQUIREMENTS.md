# Requirements: MaxSystem v4.0

**Defined:** 2026-04-13
**Core Value:** Claude can generate valid, well-structured MAX/MSP patches and code that an expert user opens in MAX and they work -- with as much automated validation as possible before manual testing.

## v4.0 Requirements

Requirements for v4.0 Package Integration milestone. Each maps to roadmap phases.

### DB Schema (Phase 20) -- COMPLETE

- [x] **PKG-01**: All package objects tagged with source package field
- [x] **PKG-02**: Package registry tracks name, version, install method per package
- [x] **PKG-03**: ObjectDatabase supports package-aware filtering (allowed_packages parameter)
- [x] **PKG-04**: Validation warns on package objects not in project's allowed packages

### Extraction (Phase 21)

- [ ] **PKG-05**: Abstraction extraction pipeline handles bpatcher-based packages (BEAP, Vizzie)
- [ ] **PKG-06**: BEAP modules extracted with correct I/O counts and signal types
- [ ] **PKG-07**: Vizzie modules extracted with correct I/O counts
- [ ] **PKG-08**: All bundled packages represented in DB (including Jitter Geometry, Jitter Tools)

### Generation Gating (Phase 22)

- [ ] **PKG-09**: `/max-new` asks user which packages to use for the project
- [ ] **PKG-10**: `/max-build` prompts before generating with package objects if not decided
- [ ] **PKG-11**: Package selection stored in project config
- [ ] **PKG-12**: Object usage gated on project-level package selection
- [ ] **PKG-13**: No silent generation with unavailable packages

### Agent Intelligence (Phase 23)

- [ ] **PKG-14**: Agent-specific guidance per package in SKILL.md files
- [ ] **PKG-15**: BEAP modular patching patterns documented for agents
- [ ] **PKG-16**: Package-specific relationships.json entries
- [ ] **PKG-17**: Layout overrides for bpatcher-based package objects
- [ ] **PKG-18**: Full parity with core domains (not just DB entries)

### Community (Phase 24)

- [ ] **PKG-19**: Stub DB entries for uninstalled community packages
- [ ] **PKG-20**: Extraction commands for installed community packages
- [ ] **PKG-21**: Install guidance in agent prompts for community packages
- [ ] **PKG-22**: FluCoMa, CNMAT, Bach, Odot, ml.*, IRCAM Spat all have DB presence

### Templates/Critics (Phase 25)

- [ ] **PKG-23**: Starter templates for common package workflows
- [ ] **PKG-24**: Package-aware critics (signal conventions, data type checking)
- [ ] **PKG-25**: Template integration with `/max-new` project scaffolding
- [ ] **PKG-26**: Dedicated critics for BEAP signal conventions and Bach llll handling

---
*Requirements created: 2026-04-13*
*Source: .planning/milestones/v4.0-package-integration-PROPOSAL.md*
