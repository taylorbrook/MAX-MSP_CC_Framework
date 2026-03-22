# Quick Task: Bulk-Correct MSP Outlet Types - Research

**Researched:** 2026-03-22
**Domain:** MAX/MSP object database outlet type accuracy
**Confidence:** HIGH

## Summary

The MSP extraction marked ALL outlets as `signal: true`, but many MSP objects have mixed signal/control outlets. Of 248 MSP objects, 81 have 2+ outlets. Of those 81, **51 had all outlets marked signal** (the "problem set"). 24 of 51 already have corrected overrides. Of the remaining 27, **25 are correctly all-signal** (verified via official docs) and only **2 actually need new overrides**: `gain~` and `index~`.

The original task assumed a large bulk correction was needed. The research shows most of the work was already done, and the remaining objects are mostly genuinely all-signal (FFT objects, filters, coordinate converters, audio-rate step sequencers).

**Primary recommendation:** Add overrides for `gain~` (outlet 1 is control) and `index~` (outlet 1 is an extraction error -- inlet digest duplicated as outlet). Everything else in the "all-signal" set is correct.

## Current State Analysis

### MSP Outlet Statistics
| Category | Count |
|----------|-------|
| Total MSP objects | 248 |
| No outlets | 17 |
| Single outlet | 150 (141 signal, 9 control) |
| Multi-outlet, all marked signal | 51 (the problem set) |
| Multi-outlet, already mixed in DB | 18 |
| Multi-outlet, all control | 12 |

### Problem Set Breakdown (51 objects, all outlets marked signal)
| Status | Count | Objects |
|--------|-------|---------|
| Already overridden | 24 | adc~, buffer~, curve~, dspstate~, fffb~, info~, line~, mcs.amxd~, mcs.play~, mcs.vst~, pitchshift~, play~, polybuffer~, ramp~, sfinfo~, sfizz~, sfplay~, stash~, stretch~, sync~, thispoly~, train~, vst~, zigzag~ |
| Correctly all-signal (no override needed) | 25 | See next section |
| Need new override | 2 | gain~, index~ |

### Correctly All-Signal Objects (verified, NO override needed)

| Object | Outlet Count | Verification |
|--------|-------------|-------------|
| adoutput~ | 2 | Audio channel outputs |
| cartopol~ | 2 | Cartesian-to-polar signal conversion |
| chucker~ | 3 | Audio L/R + step number (audio-rate sequencing) |
| cross~ | 2 | LP/HP filter signal outputs |
| ezadc~ | 2 | Audio input channels |
| fbinshift~ | 2 | FFT real/imaginary (inside pfft~) |
| fftin~ | 3 | FFT real/imaginary/bin-index (inside pfft~) |
| fft~ | 3 | FFT real/imaginary/ramp (all signal) |
| filtercoeff~ | 5 | All filter coefficient signals |
| freqshift~ | 2 | Positive/negative sideband signals |
| gizmo~ | 2 | FFT pitch-shift real/imaginary |
| groove~ | 2 | Audio + sync ramp (sync IS signal, 0-1 ramp) |
| hilbert~ | 2 | Cos/sin (real/imag) signal outputs |
| ifft~ | 3 | Inverse FFT real/imaginary/ramp |
| mcs.groove~ | 2 | MC audio + sync ramp (signal) |
| plugin~ | 2 | Live audio input channels |
| plugout~ | 2 | Live audio test pass-through channels |
| poltocar~ | 2 | Polar-to-cartesian signal conversion |
| stepcounter~ | 4 | All impulse/index outputs are signal-rate (Max 9 audio-rate sequencing) |
| stepdiv~ | 2 | Signal output + step number (signal-rate) |
| stepfun~ | 2 | Signal output + step number (signal-rate) |
| svf~ | 4 | LP/HP/BP/Notch filter signal outputs |
| techno~ | 3 | Freq/amplitude/step position (all signal, confirmed by tutorial) |
| where~ | 2 | Elapsed time + predicted time (both signal, confirmed by docs) |
| zerox~ | 2 | Zero-crossing count + click impulse (both signal, confirmed by docs) |

### Objects Needing New Overrides

#### 1. gain~ (HIGH confidence)
- **Outlet 0:** Signal (scaled audio output)
- **Outlet 1:** Control (slider value as int -- for UI feedback)
- **Source:** [gain~ reference docs](https://docs.cycling74.com/max7/refpages/gain~) -- "Out right outlet: The current slider value"

#### 2. index~ (HIGH confidence -- extraction error)
- **Outlet 0:** Signal (sample value at index)
- **Outlet 1:** DOES NOT EXIST -- extraction duplicated inlet 1 digest ("Audio Channel In buffer~") as outlet 1
- **Source:** [index~ docs](https://docs.cycling74.com/max8/refpages/index~) confirm single outlet only
- **Override action:** Set outlets array to single outlet only

## Override Format

Existing override pattern (from overrides.json):
```json
{
  "gain~": {
    "outlets": [
      {"id": 0, "type": "signal", "signal": true, "digest": "Scaled audio output (signal)"},
      {"id": 1, "type": "", "signal": false, "digest": "Slider value (int)"}
    ],
    "_audit": {
      "confidence": "HIGH",
      "source": "outlet_type_correction",
      "note": "Outlet 1 is control (slider value), not signal"
    }
  },
  "index~": {
    "outlets": [
      {"id": 0, "type": "signal", "signal": true, "digest": "Sample value at index"}
    ],
    "_audit": {
      "confidence": "HIGH",
      "source": "outlet_count_correction",
      "note": "Only 1 outlet per official docs. Outlet 1 was extraction error (inlet digest duplicated)"
    }
  }
}
```

## Common Pitfalls

### Pitfall 1: Assuming tilde objects have control outlets
MSP objects (ending in `~`) operate at signal rate. Even "step number" or "index" outlets from objects like stepcounter~, chucker~, where~ are signal-rate, not control. The extraction was actually correct for most objects -- the "all signal" marking was accurate.

### Pitfall 2: groove~ sync output confusion
The groove~ sync output (outlet 1) is commonly mistaken for control, but it's a signal-rate 0-to-1 ramp synchronized to loop playback. Confirmed by official docs.

### Pitfall 3: index~ extraction error
The index~ object has 2 inlets and 1 outlet. The extraction duplicated inlet 1's digest as outlet 1. This is the only outlet COUNT error found in the problem set.

## Open Questions

1. **18 objects with mixed outlets already in DB** -- are these all correct? Quick spot-check shows reasonable patterns (adsr~ has signal envelope + control dump/mute, matrix~ has signal outputs + control gain dump). Full audit deferred.

2. **9 single-outlet MSP objects marked control** -- not investigated. These are outside the stated scope (2+ outlets all signal).

## Sources

### Primary (HIGH confidence)
- [gain~ Reference](https://docs.cycling74.com/max7/refpages/gain~) - outlet types
- [groove~ Reference](https://docs.cycling74.com/max8/refpages/groove~) - sync output is signal
- [index~ Reference](https://docs.cycling74.com/max8/refpages/index~) - single outlet
- [where~ Reference](https://docs.cycling74.com/max8/refpages/where~) - both outlets signal
- [zerox~ Reference](https://docs.cycling74.com/max8/refpages/zerox~) - both outlets signal
- [MSP Sequencing Tutorial](https://docs.cycling74.com/learn/articles/12_sequencingchapter01/) - techno~ all signal

### Secondary (MEDIUM confidence)
- [Cycling '74 forums](https://cycling74.com/forums/looking-for-help-getting-timing-signal-from-chucker~) - chucker~ step number outlet behavior
- [New in Max](https://cycling74.com/products/new-in-max) - stepcounter~/stepdiv~/stepfun~ are audio-rate sequencing objects

## Metadata

**Confidence breakdown:**
- gain~ override: HIGH - official docs confirm right outlet is control
- index~ override: HIGH - official docs confirm 1 outlet, DB shows clear extraction error
- "No override needed" classification: HIGH for most (docs-verified), MEDIUM for chucker~/stepcounter~/stepdiv~/stepfun~ (inferred from tilde convention + audio-rate sequencing context)

**Research date:** 2026-03-22
**Valid until:** Indefinite (MSP object outlet types don't change)
