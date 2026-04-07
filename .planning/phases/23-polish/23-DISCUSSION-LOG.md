# Phase 23: Polish - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md -- this log preserves the alternatives considered.

**Date:** 2026-04-06
**Phase:** 23-polish
**Areas discussed:** Naming derivation, Push bank layout, Info text content, Pipeline integration

---

## Naming Derivation

### Shortname Abbreviation
| Option | Description | Selected |
|--------|-------------|----------|
| Last word | Take last meaningful word: "Filter Cutoff" -> "Cutoff" | |
| Smart truncate | Abbreviation table + truncate to 8 chars | ✓ |
| Initials + last | First letters of prefix + last word | |

**User's choice:** Smart truncate
**Notes:** None

### Longname Source
| Option | Description | Selected |
|--------|-------------|----------|
| Box text | Derive from varname/box text, prettified | ✓ |
| Comment label | Look for nearby comment objects | |
| Varname only | Use varname directly, no prettification | |

**User's choice:** Box text (derive from varname)
**Notes:** None

### Varname Auto-Generation
| Option | Description | Selected |
|--------|-------------|----------|
| From longname | snake_case lowercase from longname | ✓ |
| Sequential | param_1, param_2, param_3 | |
| Leave empty | Let MAX assign UUID-style varname | |

**User's choice:** From longname
**Notes:** None

### Post-Process Behavior
| Option | Description | Selected |
|--------|-------------|----------|
| Fill gaps only | Only populate missing names | ✓ |
| Normalize all | Enforce conventions on all parameters | |

**User's choice:** Fill gaps only
**Notes:** None

---

## Push Bank Layout

### Grouping Strategy
| Option | Description | Selected |
|--------|-------------|----------|
| By function | Semantic clusters auto-detected from names | ✓ |
| By position | Presentation order (left-to-right, top-to-bottom) | |
| Manual only | Only when agents explicitly specify | |

**User's choice:** By function
**Notes:** None

### Bank Naming
| Option | Description | Selected |
|--------|-------------|----------|
| Auto from content | Derive from parameter group content | ✓ |
| Generic numbered | Bank 1, Bank 2, Bank 3 | |
| Agent decides | Claude's discretion | |

**User's choice:** Auto from content
**Notes:** None

### Partial Banks
| Option | Description | Selected |
|--------|-------------|----------|
| Pad with empty | Leave remaining slots empty | ✓ |
| Merge small groups | Merge groups with <=3 params | |

**User's choice:** Pad with empty
**Notes:** Standard Push behavior

---

## Info Text Content

### Info Text Style
| Option | Description | Selected |
|--------|-------------|----------|
| Functional + range | Describes what it does + shows range | |
| Minimal label | Just the longname restated | |
| Contextual | Deeper descriptions based on DSP context | ✓ |

**User's choice:** Contextual
**Notes:** Agents generate contextual text during build since they understand DSP context. Post-process provides generic fallbacks.

### Unit Info
| Option | Description | Selected |
|--------|-------------|----------|
| Yes, from UnitStyle | Append unit from parameter_unitstyle | ✓ |
| No units | Just the description | |

**User's choice:** Yes, from UnitStyle
**Notes:** None

---

## Pipeline Integration

### Module Location
| Option | Description | Selected |
|--------|-------------|----------|
| New m4l_polish.py | Standalone src/maxpat/m4l_polish.py | ✓ |
| In m4l_export.py | Pre-export step in write_amxd() | |
| In project.py | Post-scaffold step | |

**User's choice:** New m4l_polish.py
**Notes:** None

### Trigger
| Option | Description | Selected |
|--------|-------------|----------|
| Explicit call | Agents call after build, before export | ✓ |
| Auto in hooks | Wire into finalize_patch hook | |
| Pre-export only | Only runs as part of write_amxd() | |

**User's choice:** Explicit call
**Notes:** None

### Critic Integration
| Option | Description | Selected |
|--------|-------------|----------|
| Yes, warnings | Flag missing info text and no live.banks | ✓ |
| No critic checks | Polish is optional UX only | |

**User's choice:** Yes, warnings
**Notes:** None

---

## Claude's Discretion

- Abbreviation table contents
- Semantic clustering algorithm for Push banks
- Generic fallback info text templates
- Function signatures and internal structure of m4l_polish.py

## Deferred Ideas

None
