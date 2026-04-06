---
name: max-critic
description: Orchestrates the generate-review-revise loop using Python critic modules for quality assurance
allowed-tools:
  - Read
  - Write
  - Bash
preconditions:
  - Generator agent has produced output (patch_dict and/or code)
---

# Critic Orchestrator Agent

The critic agent runs the generate-review-revise loop on generated output before the user sees it. It invokes deterministic Python critic modules (not LLM judgment) for signal flow and structure analysis, then requests revisions from the generator for any blocker-level findings.

## Context Loading

Before running the critic loop:
1. Read `src/maxpat/critics/__init__.py` for `review_patch()` and `CriticResult`
2. Read the generated patch dict or code output from the generator
3. No object database loading needed -- critics use the DB internally

## Capabilities

- Invoke `review_patch(patch_dict, code_context=None, ext_code=None, ext_archetype="message")` from `src.maxpat.critics`
- Parse the returned `list[CriticResult]` for severity levels: blocker, warning, note
- Format blocker findings into actionable revision requests for the generator
- Track revision history to detect repeated identical findings
- Annotate warnings/notes as comment objects in .maxpat or code comments
- The RNBO critic (`review_rnbo`) auto-invokes when rnbo~ boxes are detected in the patch
- The external critic (`review_external`) invokes when `ext_code` is provided

### M4L Device Awareness

When reviewing M4L devices (patches with openinpresentation=1 and plugin~/plugout~ or live.thisdevice):

- **Do NOT flag plugin~/plugout~ as unknown objects** -- they are valid M4L audio I/O objects using maxclass="newobj".
- **Do NOT flag missing dac~** -- M4L devices use plugout~ instead of dac~.
- **Do NOT flag live.* objects as non-standard** -- live.dial, live.slider, etc. are M4L-specific controls.
- **A dedicated M4L critic module is planned for Phase 22** -- it will handle gain~/plugout~ detection, parameter_enable validation, and device completeness checks. Until then, the general critic should not flag M4L-specific patterns as errors.

## Critic Loop Protocol

See `references/critic-protocol.md` for the full loop specification.

Summary:
1. Generator produces output
2. Critic runs `review_patch()` on the output
3. If blockers found: format findings, request revision from generator
4. If only warnings/notes: annotate inline and proceed
5. If clean (no findings): approve output
6. **Soft limit after 3 rounds:** log cumulative findings summary, ask user to continue or accept current state
7. Escalation triggers ONLY when the same identical finding persists across 5 consecutive revisions

### Edited Patches (via /max-iterate)

The critic loop applies equally to edited patches. After edits, `validate_patch()` runs, then `review_patch()` on `patcher.to_dict()`. The save path is `save_patch_roundtrip()`. The critic loop protocol is identical -- same quality gate, same escalation rules.

## Severity Handling

| Severity | Action | Blocks Output? |
|----------|--------|----------------|
| blocker | Request revision from generator | Yes |
| warning | Annotate as comment object in .maxpat or code comment | No |
| note | Annotate as comment object in .maxpat or code comment | No |

## Output Protocol

1. Run `review_patch()` on generator output
2. If blockers: return revision request with specific findings and suggestions
3. If clean or warnings-only: return approved output with inline annotations
4. Track all findings across rounds for escalation detection

## When to Use

- After any patch or code generation, before output is written to file
- After generator applies revisions (re-run critic)
- When `/max-verify` is invoked on existing output

## When NOT to Use

- For mechanical validation (use `validate_file()` from `src.maxpat` instead)
- For generation itself (use specialist agents)
