# Merge Protocol

When multiple specialist agents contribute to a single task, their outputs must be merged into a coherent result. This document defines conflict resolution rules.

## Principles

1. **Single file ownership:** Each output file is owned by exactly one agent. No two agents write to the same file.
2. **Lead agent decides structure:** The lead agent determines the overall patch structure (box count, subpatcher organization, signal flow topology).
3. **Inlet/outlet counts must match:** When one agent produces code (gen~, js) and another produces the wrapper patch, I/O counts must agree.
4. **Connections are additive:** Each agent's connections are merged into the final patch. Duplicate connections are deduplicated.

## File Ownership Rules

| File Type | Owner Agent | Other Agents May... |
|-----------|------------|-------------------|
| `.maxpat` (main patch) | Lead agent (usually Patch or DSP) | Request boxes/connections to be added |
| `.gendsp` | DSP agent | N/A -- only DSP generates gen~ files |
| `.js` (N4M) | js agent | N/A -- only js generates Node scripts |
| `.js` (V8) | js agent | N/A -- only js generates V8 scripts |
| Layout/presentation | UI agent | Other agents provide box list, UI positions them |

## Merge Sequence

For a multi-agent task with agents A (lead) and B (secondary):

1. **Lead agent (A) generates first:** Produces the main patch structure with placeholder boxes where B's output connects.
2. **Secondary agent (B) generates:** Produces its domain-specific output (code, layout, etc.) matching the interface points A defined.
3. **I/O verification:** Check that B's output matches A's interface expectations:
   - gen~ codebox inputs/outputs match the gen~ box inlet/outlet count in A's patch
   - js script inlets/outlets match the js/node.script box in A's patch
   - UI agent's box positions match A's box list
4. **Merge:** Combine A's patch structure with B's domain output. Resolve any remaining conflicts.
5. **Critic review:** Run the merged output through the critic loop.

## Conflict Resolution

### I/O Count Mismatch

**Situation:** DSP agent produces GenExpr with 3 inputs, but Patch agent created gen~ box with 2 inlets.

**Resolution:** Lead agent's structure wins. Secondary agent adjusts its output to match the lead's interface. If the secondary agent's output cannot be adjusted (e.g., the algorithm genuinely requires 3 inputs), escalate to the lead agent to update the structure.

### Duplicate Connections

**Situation:** Both agents create a connection between the same source and destination.

**Resolution:** Deduplicate. Keep one connection, discard the duplicate.

### Conflicting Box Positions

**Situation:** Patch agent positioned a box at (100, 200) but UI agent wants it at (150, 300) for presentation layout.

**Resolution:** UI agent wins for `presentation_rect` (presentation mode position). Lead agent wins for `patching_rect` (patching mode position). These are independent -- a box can have different positions in patching vs presentation mode.

### Conflicting Object Choices

**Situation:** Two agents specify different objects for the same role (e.g., one uses `onepole~`, another uses `biquad~` for filtering).

**Resolution:** The domain expert wins. DSP agent decides audio objects. Patch agent decides control objects. js agent decides script architecture. If both agents are domain experts for their respective claims, lead agent makes the final call.

## Multi-Agent Output Format

Each agent returns its output as a structured dict:

```python
{
    "agent": "max-dsp-agent",
    "role": "secondary",
    "files": {
        "filter-env.gendsp": { ... },  # gendsp dict
    },
    "patch_contributions": {
        "boxes": [ ... ],       # Box dicts to add to main patch
        "connections": [ ... ], # Connection dicts to add
    },
    "interface": {
        "gen_box_id": "obj-5",
        "expected_inlets": 3,
        "expected_outlets": 1,
    }
}
```

The lead agent collects all contributions and assembles the final output.

## Merge Validation Checklist

Before returning merged output:

- [ ] Every file has exactly one owner agent
- [ ] All I/O counts match between code and wrapper boxes
- [ ] No duplicate connections exist
- [ ] Presentation mode positions (if any) come from UI agent
- [ ] Patching mode positions come from lead agent or layout engine
- [ ] All inter-agent interface points are connected
- [ ] Output passes validation pipeline (validation.py)
