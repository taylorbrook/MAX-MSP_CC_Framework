# FluCoMa Max Package Object Database - Gap Analysis

**Researched:** 2026-04-16
**Domain:** FluCoMa object database integration
**Confidence:** HIGH

## Summary

The FluCoMa object database at `.claude/max-objects/packages/FluCoMa/objects.json` has 53 entries but the actual FluCoMa Max package ships **77 objects** (verified from help patches in `flucoma/flucoma-max` GitHub repo, release 1.0.9, 2025-08-31). Three systemic issues account for most gaps:

1. **Missing tilde suffixes** -- 34 objects have wrong names (e.g., `fluid.dataset` in DB vs `fluid.dataset~` as actually shipped). In FluCoMa's Max implementation, nearly ALL objects use the `~` suffix, including non-audio data objects like dataset, labelset, kdtree, normalize, etc.
2. **Missing buf* variants** -- 24 buffer-processing objects are entirely absent (e.g., `fluid.bufhpss~`, `fluid.bufpitch~`, `fluid.bufloudness~`). Every real-time analysis/transform object has a corresponding `buf*` variant.
3. **Wrong maxclass** -- All entries use the object name as `maxclass` (e.g., `"maxclass": "fluid.hpss~"`). Should be `"maxclass": "newobj"` like all other Max externals.

Additionally, `package_info.json` still shows `"object_count": 0, "extracted": false` despite the objects.json file existing.

**Primary recommendation:** Fix naming (add `~` suffixes), add 24 missing buf* objects and 3 missing utility objects, and change all maxclass values to `"newobj"`.

## Gap Analysis Detail

### Category 1: Wrong Names (34 objects)

These objects exist in the DB but without the required `~` suffix. The DB entry name, maxclass, and all references need the `~` appended.

| DB Name (WRONG) | Correct Name | Notes |
|------------------|-------------|-------|
| `fluid.bufcompose` | `fluid.bufcompose~` | |
| `fluid.buffflatten` | `fluid.bufflatten~` | Also triple-f typo |
| `fluid.bufnmf` | `fluid.bufnmf~` | |
| `fluid.bufnmfcross` | `fluid.bufnmfcross~` | |
| `fluid.bufnmfseed` | `fluid.bufnmfseed~` | |
| `fluid.bufscale` | `fluid.bufscale~` | |
| `fluid.bufselect` | `fluid.bufselect~` | |
| `fluid.bufselectevery` | `fluid.bufselectevery~` | |
| `fluid.bufstats` | `fluid.bufstats~` | |
| `fluid.bufstft` | `fluid.bufstft~` | |
| `fluid.bufthreaddemo` | `fluid.bufthreaddemo~` | |
| `fluid.bufthresh` | `fluid.bufthresh~` | |
| `fluid.chroma` | `fluid.chroma~` | |
| `fluid.dataset` | `fluid.dataset~` | |
| `fluid.datasetquery` | `fluid.datasetquery~` | |
| `fluid.grid` | `fluid.grid~` | |
| `fluid.kdtree` | `fluid.kdtree~` | |
| `fluid.kmeans` | `fluid.kmeans~` | |
| `fluid.knnclassifier` | `fluid.knnclassifier~` | |
| `fluid.knnregressor` | `fluid.knnregressor~` | |
| `fluid.labelset` | `fluid.labelset~` | |
| `fluid.loudness` | `fluid.loudness~` | |
| `fluid.mds` | `fluid.mds~` | |
| `fluid.melbands` | `fluid.melbands~` | |
| `fluid.mfcc` | `fluid.mfcc~` | |
| `fluid.mlpclassifier` | `fluid.mlpclassifier~` | |
| `fluid.mlpregressor` | `fluid.mlpregressor~` | |
| `fluid.nmfmatch` | `fluid.nmfmatch~` | |
| `fluid.normalize` | `fluid.normalize~` | |
| `fluid.pca` | `fluid.pca~` | |
| `fluid.pitch` | `fluid.pitch~` | |
| `fluid.robustscale` | `fluid.robustscale~` | |
| `fluid.spectralshape` | `fluid.spectralshape~` | |
| `fluid.standardize` | `fluid.standardize~` | |
| `fluid.umap` | `fluid.umap~` | |

Plus one misspelling: `fluid.skeans` should be `fluid.skmeans~` [VERIFIED: GitHub flucoma-docs/doc/SKMeans.rst]

### Category 2: Missing Objects (27 total)

**Missing buf* variants (24):** Every real-time analysis/decomposition object has a buffer-processing counterpart. These are entirely absent from the DB:

| Object | Category | Description |
|--------|----------|-------------|
| `fluid.bufampfeature~` | Analyse | Buffer amplitude feature extraction |
| `fluid.bufampgate~` | Slice | Buffer amplitude gating |
| `fluid.bufampslice~` | Slice | Buffer amplitude slicing |
| `fluid.bufaudiotransport~` | Transform | Buffer audio transport |
| `fluid.bufchroma~` | Analyse | Buffer chroma analysis |
| `fluid.bufhpss~` | Decompose | Buffer HPSS |
| `fluid.bufloudness~` | Analyse | Buffer loudness analysis |
| `fluid.bufmelbands~` | Analyse | Buffer mel band analysis |
| `fluid.bufmfcc~` | Analyse | Buffer MFCC analysis |
| `fluid.bufnoveltyfeature~` | Analyse | Buffer novelty feature |
| `fluid.bufnoveltyslice~` | Slice | Buffer novelty slicing |
| `fluid.bufonsetfeature~` | Analyse | Buffer onset feature |
| `fluid.bufonsetslice~` | Slice | Buffer onset slicing |
| `fluid.bufpitch~` | Analyse | Buffer pitch analysis |
| `fluid.bufsinefeature~` | Analyse | Buffer sine feature |
| `fluid.bufsines~` | Decompose | Buffer sinusoidal modelling |
| `fluid.bufspectralshape~` | Analyse | Buffer spectral shape |
| `fluid.buftransients~` | Decompose | Buffer transient extraction |
| `fluid.buftransientslice~` | Slice | Buffer transient slicing |

**Missing utility objects (3):**

| Object | Type | Description |
|--------|------|-------------|
| `fluid.buf2list` | Max-specific | Convert buffer contents to Max list [VERIFIED: source/projects/fluid.buf2list] |
| `fluid.list2buf` | Max-specific | Convert Max list to buffer contents [VERIFIED: source/projects/fluid.list2buf] |
| `fluid.jit.plotter` | Max-specific | Jitter-based plotter (JSUI abstraction) [VERIFIED: javascript/fluid.jit.plotter.*.js in repo] |

**Missing miscellaneous (3):**

| Object | Type | Description |
|--------|------|-------------|
| `fluid.audiofilesin` | Utility | Audio file input helper [VERIFIED: help/fluid.audiofilesin.maxhelp] |
| `fluid.concataudiofiles` | Utility | Concatenate audio files [VERIFIED: help/fluid.concataudiofiles.maxhelp] |
| `fluid.gain~` | Utility | Gain object (documented in flucoma-core rt/GainClient.hpp) |

**NOT in package (do not add):**

| Object | Why Not |
|--------|---------|
| `fluid.waveform~` | Separate JSUI abstraction in its own repo (github.com/flucoma/fluid.waveform), not part of main package [VERIFIED: separate repo] |

### Category 3: Incorrect maxclass (ALL 53 entries)

Every entry in the DB uses the object name as `maxclass`:
```json
"maxclass": "fluid.hpss~"
```

Should be:
```json
"maxclass": "newobj"
```

[VERIFIED: help/fluid.hpss~.maxhelp shows `maxclass=newobj` for all FluCoMa objects]

### Category 4: I/O Count Errors

Spot-checked against official flucoma-docs .rst files:

| Object | DB Says | Actual | Source |
|--------|---------|--------|--------|
| `fluid.hpss~` | 2 outlets (signal, signal) | 3 outlets (harmonic, percussive, residual) | [VERIFIED: doc/HPSS.rst ":output: An array of three audio streams"] |
| `fluid.sines~` | 2 outlets (signal, signal) | 2 outlets (sines, residual) -- CORRECT | [VERIFIED: doc/Sines.rst] |
| `fluid.transients~` | 2 outlets (signal, signal) | 2 outlets (transients, residual) -- CORRECT | [VERIFIED: doc/Transients.rst] |

**Not spot-checked:** Most objects have generic 2-inlet/2-outlet stubs. The data objects (dataset, labelset, kdtree, etc.) likely have more nuanced I/O since they handle messages. All entries have `verified: false`, confirming these are stubs needing validation.

### Category 5: Metadata Issues

| Issue | Details |
|-------|---------|
| `package_info.json` stale | Shows `"object_count": 0, "extracted": false"` despite objects.json having 53 entries [VERIFIED: package_info.json] |
| All entries `verified: false` | No entries have been validated against help patches |
| Empty `arguments`, `messages`, `attributes` | All entries are minimal stubs with no parameter documentation |
| Missing `seealso` links | No cross-references between related objects (e.g., fluid.hpss~ <-> fluid.bufhpss~) |

## Objects That ARE Correct (17)

These objects have the right name (including `~` suffix where needed):

```
fluid.ampfeature~     fluid.nmffilter~       fluid.plotter
fluid.ampgate~        fluid.nmfmorph~        fluid.sinefeature~
fluid.ampslice~       fluid.noveltyfeature~  fluid.sines~
fluid.audiotransport~ fluid.noveltyslice~    fluid.stats
fluid.hpss~           fluid.onsetfeature~    fluid.transientslice~
                      fluid.onsetslice~      fluid.transients~
```

Note: even these still have `maxclass` wrong (should be `newobj`) and `verified: false`.

## Correctly Named Objects Without ~ (3)

These objects genuinely do NOT have the `~` suffix in Max:

- `fluid.plotter` -- JSUI-based plotter [VERIFIED: help/fluid.plotter.maxhelp]
- `fluid.stats` -- Statistics object [VERIFIED: help/fluid.stats.maxhelp]
- `fluid.buf2list` / `fluid.list2buf` -- Max-specific utilities [VERIFIED: source/projects/]

## Summary Statistics

| Metric | Count |
|--------|-------|
| Shipped objects (from help patches) | 77 |
| Objects in DB | 53 |
| Correctly named in DB | 17 |
| Wrong name (missing ~) | 34 + 1 misspelling |
| Entirely missing | 27 |
| Wrong maxclass | 53 (all) |
| Verified I/O errors | 1 (fluid.hpss~ should have 3 outlets) |

## Sources

### Primary (HIGH confidence)
- [flucoma/flucoma-max help/ directory](https://github.com/flucoma/flucoma-max/tree/main/help) -- authoritative list of 77 shipped objects
- [flucoma/flucoma-docs doc/ directory](https://github.com/flucoma/flucoma-docs/tree/main/doc) -- I/O specifications per object
- [flucoma/flucoma-core clients/](https://github.com/flucoma/flucoma-core/tree/main/include/flucoma/clients) -- rt/ and nrt/ client headers confirming object variants
- [flucoma-max releases](https://github.com/flucoma/flucoma-max/releases) -- latest release 1.0.9 (2025-08-31)

### Secondary (MEDIUM confidence)
- [learn.flucoma.org/reference/](https://learn.flucoma.org/reference/) -- object categories and descriptions
- [fluid.waveform repo](https://github.com/flucoma/fluid.waveform) -- confirms waveform~ is a separate JSUI build, not part of main package

**Research date:** 2026-04-16
**Valid until:** 2026-07-16 (stable -- FluCoMa release cadence is slow)
