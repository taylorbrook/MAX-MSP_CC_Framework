# Requirements: MaxSystem v3.0 M4L Device Creation

**Defined:** 2026-04-05
**Core Value:** Claude can generate valid, well-structured MAX/MSP patches and code that an expert user opens in MAX and they work -- with as much automated validation as possible before manual testing.

## v3.0 Requirements

Requirements for M4L device creation milestone. Each maps to roadmap phases.

### Scaffold

- [ ] **SCAFFOLD-01**: Framework scaffolds audio_effect devices with plugin~/plugout~, live.thisdevice, openinpresentation, and devicewidth
- [ ] **SCAFFOLD-02**: Framework scaffolds instrument devices with midiin/midiout passthrough, plugout~, live.thisdevice
- [ ] **SCAFFOLD-03**: Framework scaffolds midi_effect devices with midiin/midiout, live.thisdevice (no audio I/O)
- [ ] **SCAFFOLD-04**: Framework auto-sets parameter_enable=1 with saved_attribute_attributes on all live.* UI controls in M4L context
- [ ] **SCAFFOLD-05**: Framework auto-prefixes named objects (buffer~, coll, dict, send, receive, send~, receive~, value) with `---` in M4L context
- [ ] **SCAFFOLD-06**: Framework sets presentation=1 and presentation_rect on all user-facing objects in M4L devices

### Routing

- [ ] **ROUTING-01**: Router recognizes M4L keywords and dispatches with M4L-specific context
- [x] **ROUTING-02**: CLAUDE.md has M4L domain-specific rules section
- [ ] **ROUTING-03**: Agent SKILL.md files have M4L-specific instruction sections

### Validation

- [x] **VALID-01**: M4L critic detects gain~ connected to plugout~ and flags as error
- [x] **VALID-02**: M4L critic validates device completeness (required objects per device type)
- [x] **VALID-03**: M4L critic validates unique parameter_longname across device
- [x] **VALID-04**: Device type detection identifies audio_effect/instrument/midi_effect from patch structure
- [x] **VALID-05**: plugout~ added to _TERMINAL_NAMES in validation.py and dsp_critic.py

### Database

- [x] **DB-01**: live.adsrui and live.adsr~ added to m4l/objects.json with verified I/O
- [x] **DB-02**: live.scope~ domain corrected to M4L
- [x] **DB-03**: M4L relationship entries added (plugin~/plugout~, live.path/live.object, midiin/midiout)
- [x] **DB-04**: m4l_constants.py created with IntEnum classes for parameter_type, parameter_unitstyle, parameter_modmode

### Layout

- [ ] **LAYOUT-01**: M4L presentation layout engine groups controls by function within 169px height constraint
- [ ] **LAYOUT-02**: Layout supports tabbed, single-page, and overlay patterns
- [ ] **LAYOUT-03**: All presentation coordinates enforced as whole pixels

### Export

- [ ] **EXPORT-01**: write_amxd() produces valid .amxd files with correct binary header per device type

### Polish

- [ ] **POLISH-01**: Parameter naming intelligence auto-derives longname, shortname, and varname from context
- [ ] **POLISH-02**: Push controller bank organization via live.banks
- [ ] **POLISH-03**: Info text / annotations auto-populated on live.* controls

### Testing

- [ ] **TEST-01**: End-to-end tests create M4L devices of each type and validate all required components

## Future Requirements

Deferred to future release. Not in current roadmap.

### Export Extensions

- **EXPORT-02**: .amxd export supports frozen device bundles
- **EXPORT-03**: Parameter metadata (automation ranges, parameter types) auto-populated from m4l_constants

### Advanced Features

- **ADV-01**: Live API path string generation for live.path/live.object chains
- **ADV-02**: Modulator device type support (LFO, Envelope Follower)
- **ADV-03**: Automatic latency compensation declaration

## Out of Scope

| Feature | Reason |
|---------|--------|
| Live API automation (path string generation) | Too complex and contextual; paths require deep Ableton object model knowledge |
| Modulator device type | Unique "Map" button paradigm with undocumented internal APIs; insufficient demand |
| Frozen device export | Requires Live's internal freeze process; not available to external tooling |
| Cross-platform testing | Framework generates platform-agnostic JSON; platform issues require Live on each OS |
| Automatic latency compensation | Depends on DSP algorithms used; incorrect values worse than none |

## Traceability

Which phases cover which requirements. Updated during roadmap creation.

| Requirement | Phase | Status |
|-------------|-------|--------|
| DB-01 | Phase 26 | Complete |
| DB-02 | Phase 26 | Complete |
| DB-03 | Phase 26 | Complete |
| DB-04 | Phase 26 | Complete |
| VALID-04 | Phase 26 | Complete |
| VALID-05 | Phase 26 | Complete |
| ROUTING-02 | Phase 26 | Complete |
| SCAFFOLD-01 | Phase 21 | Pending |
| SCAFFOLD-02 | Phase 21 | Pending |
| SCAFFOLD-03 | Phase 21 | Pending |
| SCAFFOLD-04 | Phase 27 | Pending |
| SCAFFOLD-05 | Phase 27 | Pending |
| SCAFFOLD-06 | Phase 21 | Pending |
| ROUTING-01 | Phase 21 | Pending |
| ROUTING-03 | Phase 21 | Pending |
| VALID-01 | Phase 22 | Complete |
| VALID-02 | Phase 22 | Complete |
| VALID-03 | Phase 22 | Complete |
| EXPORT-01 | Phase 22 | Pending |
| POLISH-01 | Phase 28 | Pending |
| POLISH-02 | Phase 28 | Pending |
| POLISH-03 | Phase 28 | Pending |
| LAYOUT-01 | Phase 24 | Pending |
| LAYOUT-02 | Phase 24 | Pending |
| LAYOUT-03 | Phase 24 | Pending |
| TEST-01 | Phase 28 | Pending |

**Coverage:**
- v3.0 requirements: 26 total
- Mapped to phases: 26
- Unmapped: 0

---
*Requirements defined: 2026-04-05*
*Last updated: 2026-04-07 after gap closure phases 26-28 added (26/26 mapped, 13 reassigned)*
