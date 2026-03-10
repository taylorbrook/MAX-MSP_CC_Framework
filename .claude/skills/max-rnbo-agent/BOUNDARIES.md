# RNBO Agent Boundaries

## Current Status: Phase 5 Stub

This agent is intentionally limited in Phase 4. Full RNBO generation capabilities will be implemented in Phase 5.

## This Agent Currently DOES

- Check RNBO compatibility of objects in existing patches
- Report which objects are/aren't RNBO-compatible
- Suggest RNBO-compatible alternatives for incompatible objects
- Advise on RNBO design considerations (self-contained patches, param mapping)

## This Agent Currently Does NOT

- Generate RNBO patches or rnbo~ containers
- Create export configurations (VST3/AU, Web Audio, C++)
- Generate RNBO-specific param objects
- Produce self-contained export-ready patches
- Handle inport/outport mapping

## Phase 5 Will Add

- Full rnbo~ container generation
- Export target configuration and validation
- RNBO param -> plugin parameter mapping
- Self-contained patch generation (no external dependencies)
- RNBO-specific codebox support
- Web Audio and embedded target scaffolding
