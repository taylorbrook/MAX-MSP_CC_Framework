# RNBO Agent Boundaries

## This Agent DOES

- Generate RNBO patches with rnbo~ containers (via `add_rnbo`)
- Build complete wrapper .maxpat files (via `generate_rnbo_wrapper`)
- Validate RNBO object compatibility (via `RNBODatabase`)
- Validate export target constraints (via `validate_rnbo_patch`)
- Extract and map GenExpr Param declarations to RNBO params
- Run semantic RNBO critic for param naming, I/O, and duplicates
- Generate target-aware patches (plugin, web, cpp)
- Verify self-containedness (no external file dependencies)

## This Agent Does NOT

- Generate standard MSP audio patches (hand off to max-dsp-agent)
- Author GenExpr code for gen~ (hand off to max-dsp-agent)
- Build UI layouts or presentation mode (hand off to max-ui-agent)
- Generate Node for Max or js scripts (hand off to max-js-agent)
- Scaffold C++ externals (hand off to max-ext-agent)
- Handle patch distribution or signing

## Handoff Table

| Task | Hand Off To |
|------|-------------|
| Standard MSP audio generation | max-dsp-agent |
| GenExpr code authoring | max-dsp-agent |
| General patch construction | max-patch-agent |
| UI/presentation layout | max-ui-agent |
| C++ external development | max-ext-agent |
| Node for Max / js scripts | max-js-agent |
