# Quick Task 260408-wm1: Replace dial+scale+readout combos with live.dial objects

## Result: Already Complete

The gong-model patch (`patches/gong-model/generated/gong-model.maxpat`) already has all 10 parameter controls implemented as `live.dial` objects with full configuration. No code changes were needed.

## Verified State

### 10 live.dial objects (obj-300 through obj-309):

| VarName | Shortname | Range | Type | Exponent | Initial | Prepend Target |
|---------|-----------|-------|------|----------|---------|----------------|
| d_structure | Struct | 0-1 | float | 1.0 | 0.5 | structure |
| d_brightness | Bright | 0-1 | float | 1.0 | 0.5 | brightness |
| d_decay | Decay | 0.1-30 | float | 3.0 | 8.0 | decay_time |
| d_position | Pos | 0-1 | float | 1.0 | 0.5 | position |
| d_nonlinearity | Nonlin | 0-1 | float | 1.0 | 0.1 | nonlinearity |
| d_hardness | Hard | 0-1 | float | 1.0 | 0.5 | mallet_hardness |
| d_bloom | Bloom | 0-1 | float | 1.0 | 0.1 | bloom_amount |
| d_bloom_speed | BlmSpd | 0.1-5 | float | 2.0 | 1.0 | bloom_speed |
| d_modes | Modes | 4-32 | int | 1.0 | 16 | num_modes |
| d_gain | Gain | 0-1 | float | 1.0 | 0.5 | output_gain |

### What was removed (previously):
- 10 `dial` objects (0-127 output)
- 10 `scale` objects (range mapping)
- 10 `flonum` readout objects
- 10 `comment` label objects
- All associated connections

### What replaced them:
- 10 `live.dial` objects with `saved_attribute_attributes.valueof` containing full parameter config
- Direct connections from each `live.dial` outlet 0 → corresponding `prepend` → `send gong-ctrl`
- autopattr restore values updated to actual parameter ranges

## Commits

No new commits — work was already committed.
