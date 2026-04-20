---
id: 260419-vy7
status: complete
description: Populate I/O schemas for 11 critical empty-schema objects in overrides.json
commit: e9ddfa8
date: 2026-04-20
---

# Quick Task 260419-vy7: Summary

## What Changed

`.claude/max-objects/overrides.json` — added 11 object entries and 7 new `variable_io_rules` entries, +595 lines.

## Objects Populated

| Object | Domain source | Inlets | Outlets | variable_io |
|--------|---------------|:------:|:-------:|:-----------:|
| bpatcher | max_docs | 1 (default) | 1 (default) | true (inherited_from_subpatch) |
| funnel | max_docs | 2 (first_arg) | 1 (fixed) | true |
| expr | max_docs | 1 ($N count) | 1 | true |
| waveform~ | max_docs | 5 | 6 | false |
| expr~ | rnbo_docs | 1 ($N count) | 1 signal | true |
| codebox | rnbo_docs | 1 (in decls) | 1 (out decls) | true |
| codebox~ | rnbo_docs | 1 signal (in decls) | 1 signal (out decls) | true |
| pan | rnbo_docs | 2 | 2 | false |
| pan~ | rnbo_docs | 2 signal | 2 signal | false |
| xfade | rnbo_docs | 3 | 1 | false |
| xfade~ | rnbo_docs | 3 signal | 1 signal | false |

## Validation Output

```
bpatcher 1 1
funnel 2 1
expr 1 1
expr~ 1 1
codebox 1 1
codebox~ 1 1
pan 2 2
pan~ 2 2
xfade 3 1
xfade~ 3 1
waveform~ 5 6
```

All 11 targets report non-zero inlet and outlet counts via `ObjectDatabase.lookup()`.

## Authoritative Sources

- **max_docs** — reference pages at `/Applications/Max.app/Contents/Resources/C74/docs/refpages/max-ref/` and `/msp-ref/` for `bpatcher`, `funnel`, `expr`, `waveform~`
- **rnbo_docs** — RNBO object specifications from task description (https://rnbo.cycling74.com/learn/); installed MAX app does not ship standalone RNBO refpage XMLs for these objects

## Key Decisions

- **pan / pan~** — task description flagged as `variable_io`, but factually they are fixed 2-inlet / 2-outlet. Set `variable_io: false` for accuracy; rule entries retained in `variable_io_rules` for documentation consistency.
- **bpatcher** — inlets/outlets are inherited from the contained subpatch and cannot be derived from arguments. Default entry is 1/1 with `io_rule: "inherited_from_subpatch"`.
- **waveform~** — refpage shows 5 inlets / 6 outlets, not 1 / 4 as the task's initial estimate suggested. Override reflects refpage ground truth.

## Commit

`e9ddfa8` — db: populate I/O for 11 critical empty-schema objects
