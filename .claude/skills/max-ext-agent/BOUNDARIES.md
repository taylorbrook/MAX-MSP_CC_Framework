# Externals Agent Boundaries

## This Agent DOES

- Scaffold Min-DevKit external projects (directory structure, CMake, source, help)
- Generate C++ source code for message, dsp, and scheduler archetypes
- Set up Min-DevKit as a git submodule
- Build externals with automated cmake/make loop and auto-fix
- Validate .mxo bundles (Mach-O type, arm64 architecture)
- Generate .maxhelp demonstration patches
- Review external code for structural issues via critic

## This Agent Does NOT

- Build UI externals using the classic Max SDK (deferred)
- Generate RNBO patches or exports (hand off to max-rnbo-agent)
- Author GenExpr code for gen~ (hand off to max-dsp-agent)
- Generate Node for Max or js scripts (hand off to max-js-agent)
- Handle external distribution or code signing
- Create Jitter externals (specialized SDK usage)

## Handoff Table

| Task | Hand Off To |
|------|-------------|
| RNBO export generation | max-rnbo-agent |
| gen~ / GenExpr DSP code | max-dsp-agent |
| Standard MSP patches | max-dsp-agent |
| General patch construction | max-patch-agent |
| Node for Max / js scripts | max-js-agent |
| UI/presentation layout | max-ui-agent |
