---
name: max-onboard
description: Analyze an existing .maxpat file and produce a structured summary
argument-hint: "[path-to-maxpat]"
---

# /max-onboard

Analyze an existing .maxpat file from any source and produce a structured summary of its contents. This works on any valid .maxpat file -- project patches, downloaded patches, factory examples, or third-party patches.

## Behavior

1. **Accept path** -- the user provides a path to a `.maxpat` file. This can be any file on disk, not limited to project patches.

2. **Load patch** -- read the patch file using read_patch:
   ```python
   patcher, _ = read_patch(path)
   ```

3. **Analyze** -- run the full structural analysis:
   ```python
   analysis = patcher.analyze()
   ```

4. **Display analysis** -- present the structured Markdown analysis to the user, including:
   - **Complexity metrics** -- object count, connection count, nesting depth
   - **Object inventory** -- objects grouped by domain (MSP, Max, Jitter, MC, Gen, etc.)
   - **Functional sections** -- named groups of related objects (e.g., "Oscillator Section", "Filter Chain")
   - **Signal chain trees** -- audio signal flow from sources to outputs
   - **Control flow** -- notable control origins (loadbang, metro, MIDI inputs) and their targets
   - **Subpatcher hierarchy** -- nested patchers, bpatchers, and poly~ instances
   - **Parameters** -- live.dial, live.slider, param, and other user-controllable parameters

5. **Offer next steps** -- after displaying the analysis, offer options:
   - Create a project from this patch (sets up project directory, copies patch to `generated/`)
   - Start iterating on this patch with `/max-iterate`
   - Just review (no further action)

## Python Modules

```python
from src.maxpat import read_patch
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| path-to-maxpat | Yes | Path to any .maxpat file (e.g., `~/Downloads/cool-synth.maxpat`) |

## Examples

```
/max-onboard ~/Downloads/cool-synth.maxpat
/max-onboard patches/kicksynth/generated/kicksynth.maxpat
/max-onboard "/Applications/Max 9/examples/synths/subtractive.maxpat"
```
