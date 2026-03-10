# Phase 5: RNBO and External Development - Research

**Researched:** 2026-03-10
**Domain:** RNBO export-ready patch generation, C/C++ Min-DevKit external scaffolding and compilation
**Confidence:** HIGH

## Summary

Phase 5 upgrades two stub agents (max-rnbo-agent, max-ext-agent) from informational-only to full generation capabilities. The RNBO work involves generating rnbo~ container patches that use only RNBO-compatible objects, with validation that constrains patches based on export targets (VST3/AU, Web Audio, C++). The external development work involves scaffolding Min-DevKit C++ projects, generating functional skeleton code for three archetypes (message, DSP, scheduler), and invoking cmake/make to produce compiled .mxo bundles with post-compile Mach-O validation.

The project already has strong foundations: 560 RNBO objects in the database, rnbo_compatible flags on 334 objects across other domains, the Box.__new__ bypass pattern for structural objects (proven with gen~, node.script, js, subpatcher), a generate_patch() pipeline, and a critic loop infrastructure. The primary new work is: (1) an add_rnbo() method on Patcher analogous to add_gen(), (2) RNBO-specific validation layers for object compatibility and export target constraints, (3) C++ code generation templates for Min-DevKit externals, (4) subprocess-based cmake/make invocation with error parsing and auto-fix loop, and (5) .mxo Mach-O bundle validation.

**Primary recommendation:** Implement RNBO generation as a direct extension of the existing Patcher data model (add_rnbo method using Box.__new__ pattern), add RNBO validation as a new layer in the validation pipeline, and implement external scaffolding as file-based code generation with subprocess compilation -- all following established project patterns.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- Min-DevKit only -- modern C++17, CMake-based, header-only
- Classic Max SDK not in scope for Phase 5 (UI externals deferred to future phase)
- Min-DevKit included as git submodule per external project for always-latest access
- External source lives in `externals/` subdirectory inside the MAX project directory (`patches/my-project/externals/my-ext/`)
- Basic .maxhelp patch generated alongside every external
- Target-aware generation -- user specifies target (VST3/AU, Web Audio, C++) when generating RNBO patches
- Framework constrains the patch based on target (e.g., Web Audio has no MIDI, C++ embedded has limited param count)
- Validation warns about target-incompatible features
- Param-to-plugin-parameter mapping auto-generated from GenExpr Param declarations (name, range, default)
- Strict self-containedness enforced -- validation rejects RNBO patches referencing external files (samples, abstractions, buffer~ with file args)
- Full rnbo~ wrapper generated in parent .maxpat with inport/outport mapping, param exposure, and DAC/ADC connections -- ready to open and export
- Three archetypes supported via Min-DevKit: message/data, DSP/signal, and scheduler
- UI externals (custom paint/jbox) deferred -- requires classic Max SDK not in Phase 5 scope
- Functional skeleton output -- compiles and runs as no-op, includes inlet/outlet registration, message handlers with TODO bodies, DSP perform method (if audio), and help patch
- Intent-driven generation -- ext-agent understands what the external does and produces tailored code
- Generate + compile -- framework invokes cmake/make to produce a working .mxo bundle
- Auto-fix compile loop -- parse errors, attempt fix, recompile, iterate until clean or escalate
- Compiled .mxo placed in project externals directory (`patches/my-project/externals/my-ext/build/`)
- Post-compile validation: verify .mxo is valid Mach-O bundle with correct architecture (arm64). No MAX load testing

### Claude's Discretion
- RNBO validation rule specifics per export target (exact constraint lists)
- Min-DevKit submodule pinning strategy (tag vs main branch)
- CMakeLists.txt template structure and configuration
- Auto-fix strategies for compile errors
- RNBO param grouping and ordering in generated patches

### Deferred Ideas (OUT OF SCOPE)
- UI externals (custom paint/jbox) -- requires classic Max SDK, future phase
- Classic Max SDK support -- deferred, Min-DevKit covers most use cases
- RNBO polyphony/multivoice configuration -- complex, not in initial scope
- External distribution packaging (signing, notarization) -- separate concern
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| CODE-06 | RNBO~ patch generation using only RNBO-compatible object subset | RNBO DB has 560 objects; rnbo_compatible flag exists on 334 cross-domain objects; add_rnbo() method using Box.__new__ pattern; RNBO validation layer rejects non-compatible objects |
| CODE-07 | RNBO~ export target awareness (VST3/AU, Web Audio, C++) | Target constraint model with per-target validation rules (MIDI, buffer, param limits); rnbo~ wrapper generation with target-specific I/O objects |
| EXT-01 | C/C++ MAX external project scaffolding (directory structure, CMake/build system) | Min-DevKit directory layout documented; CMakeLists.txt template pattern; git submodule strategy for min-api |
| EXT-02 | External development supports Min-DevKit (research determines choice -- decision: Min-DevKit only) | Min-DevKit confirmed: C++17, CMake 3.19+, header-only min-api, Catch unit tests; runs on Apple Silicon with cmake -G Xcode |
| EXT-03 | External inlet/outlet setup and message handling code generation | Min-DevKit inlet<>/outlet<> declarations, message<> with MIN_FUNCTION, attribute<> with range/setter; three archetypes mapped |
| EXT-04 | External DSP processing method generation for audio objects | sample_operator<N,M> and vector_operator<> patterns; operator() returns sample or samples<N>; dspsetup message for sample rate |
| EXT-05 | External build and compilation support for macOS (Apple Silicon) | cmake 4.2.1 and Xcode 26.2 available on build machine; arm64 architecture confirmed; post-compile validation via file/lipo commands |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Min-DevKit | latest (git submodule) | C++ external development framework | Official Cycling '74 modern C++ API for Max externals; C++17, header-only, CMake-based |
| min-api | latest (submodule of min-devkit) | Core C++ API headers for Max externals | Provides c74_min.h, inlet<>, outlet<>, message<>, attribute<>, MIN_EXTERNAL macros |
| CMake | 3.19+ (4.2.1 available) | Build system for externals | Required by Min-DevKit; generates Xcode projects on macOS |
| Catch2 | bundled with min-devkit | Unit testing for externals | Standard test framework included in Min-DevKit |
| Python subprocess | stdlib | cmake/make invocation and error parsing | No external dependency; established pattern in build tool chains |

### Supporting
| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| pathlib | stdlib | File/directory management for scaffolding | Always -- project uses pathlib throughout |
| json | stdlib | .maxpat and .maxhelp generation | Always -- patches are JSON files |
| re | stdlib | Compiler error parsing | Auto-fix loop: parse gcc/clang error output |
| shutil | stdlib | Directory operations for scaffolding | External project directory creation |

### Alternatives Considered
| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| Min-DevKit | Classic Max SDK | Classic SDK uses C, more verbose, no modern C++ features; required for UI externals but deferred |
| git submodule | Package manager / manual copy | Submodule ensures min-api version matches min-devkit; user decided on submodule approach |
| cmake -G Xcode | cmake -G "Unix Makefiles" | Xcode generator is macOS standard for Min-DevKit; Makefiles would also work but less common |

**Installation:**
```bash
# External project scaffolding creates a git submodule:
git submodule add https://github.com/Cycling74/min-devkit.git externals/my-ext/min-devkit
# Build:
cd externals/my-ext/build && cmake -G Xcode .. && cmake --build . --config Release
```

## Architecture Patterns

### Recommended Project Structure

#### RNBO Generation Module
```
src/maxpat/
  rnbo.py              # RNBO patch generation (add_rnbo on Patcher, rnbo~ wrapper)
  rnbo_validation.py   # RNBO-specific validation (object compat, target constraints, self-contained)
critics/
  rnbo_critic.py       # RNBO semantic critic (param naming, I/O mapping, target fitness)
```

#### External Scaffolding Module
```
src/maxpat/
  externals.py         # External project scaffolding, code generation, build invocation
  ext_templates.py     # C++ code templates for three archetypes
  ext_validation.py    # Post-compile .mxo validation (Mach-O check)
critics/
  ext_critic.py        # External code review (inlet/outlet consistency, missing handlers)
```

#### Generated External Project Layout
```
patches/my-project/externals/my-ext/
  CMakeLists.txt          # Top-level CMake (includes min-api)
  source/
    my-ext.cpp            # Object source code
    my-ext_test.cpp       # Optional Catch unit test
  help/
    my-ext.maxhelp        # Help patch (generated .maxpat)
  min-devkit/             # git submodule (or symlink for dev)
    min-api/              # Core headers (submodule of min-devkit)
  build/                  # CMake build output
    my-ext.mxo            # Compiled external bundle
```

### Pattern 1: RNBO Patch Generation (add_rnbo method)

**What:** Generate an rnbo~ container box with inner RNBO patcher, analogous to add_gen().
**When to use:** Whenever the user wants to generate an RNBO-exportable patch.

```python
# Pattern: Patcher.add_rnbo() following established add_gen() pattern
def add_rnbo(
    self,
    objects: list[dict],      # [{name, args, connections}]
    params: list[dict],       # [{name, default, min, max}]
    target: str = "plugin",   # "plugin", "web", "cpp"
    audio_ins: int = 2,
    audio_outs: int = 2,
) -> tuple[Box, Patcher]:
    """Add an rnbo~ object with inner RNBO patcher.

    Creates:
    - Parent rnbo~ box (Box.__new__ bypass, variable I/O)
    - Inner RNBO patcher with in~/out~ for audio, param objects, user objects
    - Full rnbo~ wrapper in parent .maxpat (dac~/adc~ connections, param exposure)

    Returns:
        (parent_box, inner_patcher) tuple.
    """
    # 1. Validate all objects are RNBO-compatible
    # 2. Validate against target constraints
    # 3. Build inner patcher with in~/out~/param/inport/outport
    # 4. Create parent rnbo~ box via Box.__new__
    # 5. Return for further modification/connection
```

### Pattern 2: Export Target Constraint Model

**What:** Per-target validation rules that constrain RNBO patches.
**When to use:** During RNBO patch generation and validation.

```python
# Target constraint definitions
RNBO_TARGET_CONSTRAINTS = {
    "plugin": {  # VST3/AU
        "requires_audio_io": True,     # Must have in~/out~
        "midi_supported": True,        # midiin/noteout allowed
        "max_params": None,            # No hard limit
        "buffer_allowed": True,        # buffer~ with @file bundled
        "self_contained": True,        # No external file deps at runtime
    },
    "web": {  # Web Audio / WASM
        "requires_audio_io": True,
        "midi_supported": True,        # Web MIDI API available
        "max_params": None,
        "buffer_allowed": True,        # Audio loaded as data dependencies
        "self_contained": True,
        "audio_format_warning": "aif", # Chrome cannot decode .aif
    },
    "cpp": {  # C++ embedded
        "requires_audio_io": True,
        "midi_supported": True,        # Platform-dependent
        "max_params": 128,             # Practical limit for embedded
        "buffer_allowed": False,       # No file system on bare metal
        "self_contained": True,
    },
}
```

### Pattern 3: Min-DevKit External Code Generation

**What:** Generate C++ source files following Min-DevKit patterns for three archetypes.
**When to use:** When scaffolding a new external.

```cpp
// Message/data archetype template (simplified)
#include "c74_min.h"

using namespace c74::min;

class {object_name} : public object<{object_name}> {{
public:
    MIN_DESCRIPTION {{ "{description}" }};
    MIN_TAGS {{ "utility" }};
    MIN_AUTHOR {{ "Generated by MAX Framework" }};

    inlet<>  m_input  {{ this, "(anything) input" }};
    outlet<> m_output {{ this, "(anything) output" }};

    // Message handlers
    message<> m_bang {{ this, "bang",
        MIN_FUNCTION {{
            // TODO: implement bang handler
            return {{}};
        }}
    }};

    message<> m_number {{ this, "number",
        MIN_FUNCTION {{
            // TODO: implement number handler
            return {{}};
        }}
    }};
}};

MIN_EXTERNAL({object_name});
```

```cpp
// DSP/signal archetype template (simplified)
#include "c74_min.h"

using namespace c74::min;

class {object_name} : public object<{object_name}>, public sample_operator<{num_inputs}, {num_outputs}> {{
public:
    MIN_DESCRIPTION {{ "{description}" }};
    MIN_TAGS {{ "audio" }};
    MIN_AUTHOR {{ "Generated by MAX Framework" }};

    inlet<>  m_input  {{ this, "(signal) audio input" }};
    outlet<> m_output {{ this, "(signal) audio output", "signal" }};

    // DSP perform method
    samples<{num_outputs}> operator()(sample input) {{
        // TODO: implement DSP processing
        return {{ input }};
    }};

    // Optional: dspsetup for sample rate
    message<> dspsetup {{ this, "dspsetup",
        MIN_FUNCTION {{
            m_samplerate = args[0];
            return {{}};
        }}
    }};

private:
    double m_samplerate {{ 44100.0 }};
}};

MIN_EXTERNAL({object_name});
```

```cpp
// Scheduler archetype template (simplified)
#include "c74_min.h"

using namespace c74::min;

class {object_name} : public object<{object_name}> {{
public:
    MIN_DESCRIPTION {{ "{description}" }};
    MIN_TAGS {{ "time" }};
    MIN_AUTHOR {{ "Generated by MAX Framework" }};

    inlet<>  m_input    {{ this, "(toggle) on/off" }};
    outlet<> m_bang_out  {{ this, "(bang) tick output" }};

    timer<> m_timer {{ this,
        MIN_FUNCTION {{
            m_bang_out.send("bang");
            m_timer.delay(m_interval);
            return {{}};
        }}
    }};

    attribute<double> m_interval {{ this, "interval", 500.0,
        range {{ 1.0, 60000.0 }}
    }};

    message<> m_toggle {{ this, "int",
        MIN_FUNCTION {{
            if (args[0] > 0)
                m_timer.delay(0);
            else
                m_timer.stop();
            return {{}};
        }}
    }};
}};

MIN_EXTERNAL({object_name});
```

### Pattern 4: Build Loop (cmake/make with auto-fix)

**What:** Invoke cmake and make, parse errors, attempt fixes, recompile.
**When to use:** After generating external source code.

```python
def build_external(ext_dir: Path, max_attempts: int = 5) -> BuildResult:
    """Build a Min-DevKit external, attempting auto-fix on errors.

    Steps:
    1. cmake -G Xcode .. (or Unix Makefiles for headless)
    2. cmake --build . --config Release
    3. Parse stderr for compiler errors
    4. Attempt auto-fix (missing includes, type mismatches, syntax)
    5. Repeat until clean or max_attempts exceeded
    6. Post-compile: validate .mxo bundle (Mach-O, arm64)
    """
    build_dir = ext_dir / "build"
    build_dir.mkdir(exist_ok=True)

    for attempt in range(max_attempts):
        # Configure
        result = subprocess.run(
            ["cmake", "-G", "Unix Makefiles", ".."],
            cwd=build_dir, capture_output=True, text=True
        )
        if result.returncode != 0:
            # Parse cmake errors, attempt fix
            continue

        # Build
        result = subprocess.run(
            ["cmake", "--build", ".", "--config", "Release"],
            cwd=build_dir, capture_output=True, text=True
        )
        if result.returncode == 0:
            # Success -- validate .mxo
            return validate_mxo(build_dir)

        # Parse and fix compiler errors
        errors = parse_compiler_errors(result.stderr)
        if not auto_fix(errors, ext_dir):
            break  # Unfixable -- escalate

    return BuildResult(success=False, errors=errors)
```

### Pattern 5: Post-Compile .mxo Validation

**What:** Verify compiled .mxo is a valid Mach-O bundle with correct architecture.
**When to use:** After successful cmake build.

```python
def validate_mxo(build_dir: Path) -> bool:
    """Validate that the built .mxo is a valid arm64 Mach-O bundle.

    Uses macOS 'file' command to check Mach-O type and 'lipo' to verify
    architecture. Does NOT attempt to load in MAX (manual test step).
    """
    mxo_files = list(build_dir.rglob("*.mxo"))
    if not mxo_files:
        return False

    mxo = mxo_files[0]
    # .mxo is a macOS bundle -- check the binary inside
    binary = mxo / "Contents" / "MacOS" / mxo.stem

    # Check Mach-O type
    result = subprocess.run(["file", str(binary)], capture_output=True, text=True)
    if "Mach-O" not in result.stdout:
        return False

    # Check architecture (arm64 for Apple Silicon)
    result = subprocess.run(["lipo", "-info", str(binary)], capture_output=True, text=True)
    return "arm64" in result.stdout
```

### Anti-Patterns to Avoid

- **Using non-RNBO objects in RNBO patches:** The validation MUST reject any object not in the RNBO domain or not marked rnbo_compatible. No exceptions, no permissive fallback.
- **buffer~ with @file in RNBO patches:** Self-containedness validation must flag buffer~ objects that reference external files. The exported code bundles files, but the patch itself must explicitly declare dependencies.
- **Classic Max SDK patterns in Min-DevKit code:** Do not generate C-style class_new/class_addmethod code. Min-DevKit uses declarative C++ patterns exclusively.
- **Xcode-dependent builds in automated pipeline:** Use `cmake -G "Unix Makefiles"` for headless builds in the auto-fix loop, not `-G Xcode` which requires GUI. Xcode generator is for user-facing builds only.
- **Guessing .mxo bundle structure:** The bundle layout is platform-specific. Always verify with `file` and `lipo` commands, never assume.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| RNBO object compatibility check | Custom object whitelist | Database rnbo_compatible flag + rnbo/objects.json | 560 RNBO objects already catalogued; rnbo_compatible flag on 334 cross-domain objects |
| CMake build system | Custom Makefile | Min-DevKit CMakeLists.txt pattern with min-api submodule | Min-DevKit provides working CMake infrastructure; reinventing loses compatibility |
| Mach-O validation | Python struct parsing | macOS `file` + `lipo` commands via subprocess | System tools are authoritative for Mach-O inspection |
| C++ template rendering | Custom string builder | Python f-string templates with proper escaping | Templates are small (< 100 lines each); Jinja2 would be overkill |
| RNBO param extraction from GenExpr | Custom parser | Existing parse_genexpr_io + regex for Param declarations | GenExpr parser already exists in codegen.py; extend it |

**Key insight:** Most "new" code in this phase is extension of existing patterns (Box.__new__, generate_patch, validation layers, critic modules). The risk comes from RNBO target constraints and build system integration -- areas where existing project patterns don't fully apply.

## Common Pitfalls

### Pitfall 1: RNBO Object Namespace Collision
**What goes wrong:** Objects like `cycle~` exist in both MSP (1 outlet) and RNBO (2 outlets) domains with different I/O counts. Using the wrong variant produces invalid patches.
**Why it happens:** ObjectDatabase loads core domains last for priority (MSP cycle~ overwrites RNBO cycle~). RNBO generation needs RNBO-specific object data.
**How to avoid:** RNBO generation must explicitly load objects from the `rnbo/objects.json` domain, NOT from the general ObjectDatabase which prioritizes core domains. Create an RNBO-specific lookup method or a dedicated RNBODatabase that loads only `rnbo/objects.json`.
**Warning signs:** Outlet count mismatches in generated RNBO patches.

### Pitfall 2: rnbo~ is a Container, Not a Regular Object
**What goes wrong:** Treating rnbo~ like gen~ where you just add a codebox inside. RNBO patchers have different structural requirements: they need in~/out~ for audio I/O, param objects for parameters, inport/outport for messages, and the inner patcher must use RNBO-compatible objects exclusively.
**Why it happens:** The gen~ pattern (add_gen) is similar but simpler -- gen~ only has codebox + in/out. RNBO has a full patcher environment inside.
**How to avoid:** The add_rnbo() method must build a complete inner patcher with proper I/O objects (in~/out~ for audio, param for parameters, inport/outport for messages), not just a codebox.
**Warning signs:** RNBO patches that open but cannot be exported due to missing I/O objects.

### Pitfall 3: Self-Containedness Enforcement
**What goes wrong:** Generated RNBO patches reference external files (buffer~ with @file, abstractions, external samples) that don't exist in the export target.
**Why it happens:** Regular MAX patches freely reference external files. RNBO export requires all dependencies to be bundled or inline.
**How to avoid:** RNBO validation must scan for: (1) buffer~ objects with @file attributes, (2) references to external .maxpat abstractions, (3) any file-path attributes. Report these as blockers.
**Warning signs:** "Export failed: missing dependency" errors in RNBO export panel.

### Pitfall 4: Min-DevKit Submodule Depth
**What goes wrong:** Min-DevKit itself has submodules (min-api, min-lib). A shallow clone or non-recursive submodule add will fail to build because min-api headers are missing.
**Why it happens:** Git submodule add without --recursive only clones the top-level repository.
**How to avoid:** Use `git submodule add --recursive` or `git clone --recursive` when initializing the min-devkit submodule. The scaffolding must check that min-api exists after submodule init.
**Warning signs:** CMake error "Could not find c74_min.h" or similar include-not-found errors.

### Pitfall 5: CMake Generator Choice for Headless Builds
**What goes wrong:** Using `cmake -G Xcode` in the automated build loop. Xcode generator creates .xcodeproj files that require `xcodebuild` to build, which is slower and may prompt for code signing.
**Why it happens:** Min-DevKit docs recommend Xcode generator for macOS.
**How to avoid:** Use `cmake -G "Unix Makefiles"` for the automated build loop (faster, no signing prompts). The Xcode generator is for when users want to open the project in Xcode IDE.
**Warning signs:** Build loop hangs on code signing dialog or takes excessively long.

### Pitfall 6: Compiler Error Parsing Fragility
**What goes wrong:** Auto-fix loop misparses compiler output, applies wrong fix, creates infinite loop of different errors.
**Why it happens:** gcc/clang error output is complex and varies by error type.
**How to avoid:** Limit auto-fix to well-known patterns: missing includes, simple type mismatches, missing semicolons. Escalate anything else after 1-2 attempts. Track error signatures to detect loops (same error recurring).
**Warning signs:** Build loop exceeding 3 iterations.

## Code Examples

Verified patterns from existing codebase and official documentation:

### RNBO Object Lookup (RNBO-specific database)
```python
# Pattern: Dedicated RNBO object lookup that reads rnbo/objects.json directly
# Avoids the core-domain-priority issue in ObjectDatabase
import json
from pathlib import Path

class RNBODatabase:
    """RNBO-specific object database for generation and validation."""

    def __init__(self, db_root: Path | None = None):
        if db_root is None:
            db_root = Path(__file__).resolve().parents[2] / ".claude" / "max-objects"
        self._rnbo_objects = json.loads((db_root / "rnbo" / "objects.json").read_text())
        # Also load rnbo_compatible flags from other domains
        self._compat_objects: set[str] = set(self._rnbo_objects.keys())
        for domain in ["max", "msp", "gen", "mc", "jitter"]:
            domain_path = db_root / domain / "objects.json"
            if domain_path.exists():
                data = json.loads(domain_path.read_text())
                for name, obj in data.items():
                    if obj.get("rnbo_compatible"):
                        self._compat_objects.add(name)

    def is_rnbo_compatible(self, name: str) -> bool:
        """Check if an object can be used in RNBO patches."""
        return name in self._compat_objects

    def lookup(self, name: str) -> dict | None:
        """Look up RNBO object data (uses RNBO-specific I/O counts)."""
        return self._rnbo_objects.get(name)
```

### rnbo~ Box Creation (Box.__new__ pattern)
```python
# Pattern: Create rnbo~ parent box following gen~/subpatcher precedent
# Source: Existing patcher.py add_gen() method

parent_box = Box.__new__(Box)
parent_box.name = "rnbo~"
parent_box.args = []
parent_box.id = box_id
parent_box.maxclass = "rnbo~"
parent_box.text = "rnbo~"
parent_box.numinlets = num_audio_ins + 1   # audio inputs + message inlet
parent_box.numoutlets = num_audio_outs + 1  # audio outputs + message outlet
parent_box.outlettype = ["signal"] * num_audio_outs + [""]
parent_box.patching_rect = [x, y, w, h]
parent_box.fontname = FONT_NAME
parent_box.fontsize = FONT_SIZE
parent_box.presentation = False
parent_box.presentation_rect = None
parent_box.extra_attrs = {}
parent_box._inner_patcher = inner_rnbo_patcher  # RNBO patcher inside
parent_box._saved_object_attributes = None
parent_box._bpatcher_attrs = None
```

### RNBO Param Extraction from GenExpr
```python
# Pattern: Extract Param declarations from GenExpr code for RNBO param mapping
# Source: Extend existing codegen.py parse_genexpr_io()

import re

def parse_genexpr_params(code: str) -> list[dict]:
    """Extract Param declarations from GenExpr code.

    Matches: Param name(default, min=min_val, max=max_val);
    Returns list of {name, default, min, max} dicts.
    """
    pattern = r'Param\s+(\w+)\(([^)]+)\);'
    params = []
    for match in re.finditer(pattern, code):
        name = match.group(1)
        args_str = match.group(2)
        # Parse default, min=, max=
        parts = [p.strip() for p in args_str.split(",")]
        default = float(parts[0]) if parts else 0.0
        min_val = 0.0
        max_val = 1.0
        for part in parts[1:]:
            if part.startswith("min="):
                min_val = float(part[4:])
            elif part.startswith("max="):
                max_val = float(part[4:])
        params.append({"name": name, "default": default, "min": min_val, "max": max_val})
    return params
```

### CMakeLists.txt Template for External
```cmake
# Pattern: Min-DevKit external CMakeLists.txt
# Source: Cycling74/min-devkit standard convention

cmake_minimum_required(VERSION 3.19)

# Set project name from directory
get_filename_component(PROJECT_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME)
project(${PROJECT_NAME})

# Find min-api
set(MIN_API_DIR "${CMAKE_CURRENT_SOURCE_DIR}/min-devkit/source/min-api")
if(NOT EXISTS "${MIN_API_DIR}")
    message(FATAL_ERROR "min-api not found. Run: git submodule update --init --recursive")
endif()

# Include min-api CMake scripts
include("${MIN_API_DIR}/script/min-pretarget.cmake")

# Define source files
set(SOURCE_FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/source/${PROJECT_NAME}.cpp
)

# Create the external
add_library(${PROJECT_NAME} MODULE ${SOURCE_FILES})

# Apply min-api post-target configuration
include("${MIN_API_DIR}/script/min-posttarget.cmake")
```

### Post-Compile .mxo Validation
```python
# Pattern: Verify .mxo is valid Mach-O arm64 bundle
# Source: macOS system tools (file, lipo)

import subprocess
from pathlib import Path

def validate_mxo(mxo_path: Path) -> tuple[bool, str]:
    """Validate that a .mxo bundle contains a valid arm64 Mach-O binary.

    Returns (is_valid, message).
    """
    if not mxo_path.exists() or not mxo_path.suffix == ".mxo":
        return False, f"Not a .mxo bundle: {mxo_path}"

    # Find the binary inside the bundle
    binary = mxo_path / "Contents" / "MacOS" / mxo_path.stem
    if not binary.exists():
        return False, f"No binary found at {binary}"

    # Check Mach-O type
    result = subprocess.run(
        ["file", str(binary)], capture_output=True, text=True
    )
    if "Mach-O" not in result.stdout:
        return False, f"Not a Mach-O binary: {result.stdout.strip()}"

    # Check architecture
    result = subprocess.run(
        ["lipo", "-info", str(binary)], capture_output=True, text=True
    )
    if "arm64" not in result.stdout:
        return False, f"Not arm64 architecture: {result.stdout.strip()}"

    return True, f"Valid arm64 Mach-O: {mxo_path.name}"
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Classic Max SDK (C) | Min-DevKit (C++17) | 2018+ (Min-DevKit mature) | Modern C++, declarative API, header-only, no boilerplate |
| Max SDK class_new/class_addmethod | Min object<> + inlet<>/outlet<>/message<> | Min-DevKit adoption | Type-safe, self-documenting, Catch-testable |
| Manual Makefile for externals | CMake with min-api scripts | Min-DevKit standard | Cross-platform, automatic Xcode/VS project generation |
| Intel-only .mxo | Universal Binary / arm64 .mxo | 2020+ (Apple Silicon) | Must target arm64; universal binaries optional |
| RNBO local compilation | RNBO Cloud Compiler | 2022+ (RNBO launch) | VST3/AU/Web exports compiled in cloud; C++ export is local |

**Deprecated/outdated:**
- Classic Max SDK C patterns (class_new, class_addmethod, object_alloc) -- still works but not recommended for new code
- Intel-only .mxo bundles -- Apple Silicon requires arm64 or universal
- Manual Xcode projects for externals -- CMake is the standard

## Open Questions

1. **Min-DevKit submodule pinning strategy**
   - What we know: User decided "always-latest" via git submodule. Min-DevKit main branch is generally stable.
   - What's unclear: Whether to pin to a specific tag (e.g., v1.0.0) or track main branch. Tags provide reproducibility; main provides latest fixes.
   - Recommendation: Use main branch with no tag pin. The scaffolding can record the commit hash in a generated README for reproducibility. If users want to pin, they can do so manually.

2. **RNBO param count limit for C++ embedded target**
   - What we know: VST3/AU has no practical limit. Web Audio has no documented limit. C++ embedded depends on target hardware.
   - What's unclear: Exact param limit for C++ target. 128 is a conservative practical limit used in embedded audio (MIDI CC count).
   - Recommendation: Use 128 as default C++ target param limit. Make it configurable. Emit warning, not blocker, if exceeded.

3. **Web Audio MIDI support status**
   - What we know: RNBO Web Export supports MIDI as a configurable option ("Enable MIDI"). Web MIDI API exists in modern browsers.
   - What's unclear: Whether all RNBO MIDI objects work in Web Audio export or if some have limitations.
   - Recommendation: Allow MIDI objects in web target but emit a note/warning that Web MIDI API browser support varies. Do not block.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | none -- pytest discovers tests/ automatically |
| Quick run command | `python3 -m pytest tests/ -x -q` |
| Full suite command | `python3 -m pytest tests/ -v` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| CODE-06 | RNBO patches use only RNBO-compatible objects | unit | `python3 -m pytest tests/test_rnbo.py::test_rnbo_object_validation -x` | Wave 0 |
| CODE-06 | RNBO generation produces valid .maxpat with rnbo~ wrapper | unit | `python3 -m pytest tests/test_rnbo.py::test_rnbo_generation -x` | Wave 0 |
| CODE-07 | Target-aware validation (plugin/web/cpp constraints) | unit | `python3 -m pytest tests/test_rnbo.py::test_target_constraints -x` | Wave 0 |
| CODE-07 | Self-containedness check (no external file refs) | unit | `python3 -m pytest tests/test_rnbo.py::test_self_contained -x` | Wave 0 |
| CODE-07 | Param extraction from GenExpr for RNBO mapping | unit | `python3 -m pytest tests/test_rnbo.py::test_param_extraction -x` | Wave 0 |
| EXT-01 | External scaffolding creates correct directory structure | unit | `python3 -m pytest tests/test_externals.py::test_scaffold_structure -x` | Wave 0 |
| EXT-01 | CMakeLists.txt generated with correct min-api paths | unit | `python3 -m pytest tests/test_externals.py::test_cmake_generation -x` | Wave 0 |
| EXT-02 | Min-DevKit submodule setup | integration | `python3 -m pytest tests/test_externals.py::test_mindevkit_setup -x` | Wave 0 |
| EXT-03 | Message archetype generates correct inlet/outlet/handler code | unit | `python3 -m pytest tests/test_externals.py::test_message_archetype -x` | Wave 0 |
| EXT-03 | Scheduler archetype generates timer and attribute code | unit | `python3 -m pytest tests/test_externals.py::test_scheduler_archetype -x` | Wave 0 |
| EXT-04 | DSP archetype generates sample_operator with perform method | unit | `python3 -m pytest tests/test_externals.py::test_dsp_archetype -x` | Wave 0 |
| EXT-04 | Generated .maxhelp patch is valid JSON | unit | `python3 -m pytest tests/test_externals.py::test_help_patch -x` | Wave 0 |
| EXT-05 | cmake invocation produces build artifacts | integration | `python3 -m pytest tests/test_externals.py::test_build_invocation -x` | Wave 0 |
| EXT-05 | .mxo validation checks Mach-O arm64 | unit | `python3 -m pytest tests/test_externals.py::test_mxo_validation -x` | Wave 0 |
| -- | RNBO critic catches semantic issues | unit | `python3 -m pytest tests/test_critics.py::test_rnbo_critic -x` | Wave 0 |
| -- | External critic catches code issues | unit | `python3 -m pytest tests/test_critics.py::test_ext_critic -x` | Wave 0 |
| -- | RNBO agent skill upgraded from stub | unit | `python3 -m pytest tests/test_agent_skills.py -x -k rnbo` | Wave 0 |
| -- | External agent skill upgraded from stub | unit | `python3 -m pytest tests/test_agent_skills.py -x -k ext` | Wave 0 |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/ -x -q`
- **Per wave merge:** `python3 -m pytest tests/ -v`
- **Phase gate:** Full suite green (516 existing + new tests) before `/gsd:verify-work`

### Wave 0 Gaps
- [ ] `tests/test_rnbo.py` -- covers CODE-06, CODE-07 (RNBO generation, validation, target constraints)
- [ ] `tests/test_externals.py` -- covers EXT-01 through EXT-05 (scaffolding, code gen, build, mxo validation)
- [ ] Extended `tests/test_critics.py` -- RNBO critic and external critic test cases
- [ ] Extended `tests/test_agent_skills.py` -- RNBO and external agent skill validation

*(Existing test infrastructure (conftest.py fixtures, pytest config) covers shared needs.)*

## Sources

### Primary (HIGH confidence)
- `.claude/max-objects/rnbo/objects.json` -- 560 RNBO objects with full metadata (inlets, outlets, arguments, rnbo_options)
- `src/maxpat/patcher.py` -- Existing Patcher/Box data model with add_gen(), add_subpatcher(), Box.__new__ pattern
- `src/maxpat/validation.py` -- Four-layer validation pipeline (JSON, objects, connections, domain)
- `src/maxpat/critics/` -- Existing critic system (base.py, dsp_critic.py, structure_critic.py)
- [Cycling74/min-api GuideToWritingObjects.md](https://github.com/Cycling74/min-api/blob/main/doc/GuideToWritingObjects.md) -- Official Min-DevKit C++ API reference
- [Cycling74 Min-DevKit audio guide](https://cycling74.github.io/min-devkit/guide/audio) -- sample_operator and vector_operator patterns
- [Cycling74 Min-DevKit writing objects](https://cycling74.github.io/min-devkit/guide/writingobjects) -- inlet<>, outlet<>, message<>, attribute<> patterns

### Secondary (MEDIUM confidence)
- [RNBO Export Targets Overview](https://rnbo.cycling74.com/learn/export-targets-overview) -- Export target types and configuration options
- [RNBO Audio Plugin Target](https://rnbo.cycling74.com/learn/audio-plugin-target-export-overview) -- VST3/AU export configuration and restrictions
- [RNBO Web Export Target](https://rnbo.cycling74.com/learn/the-web-export-target) -- Web Audio/WASM export details
- [RNBO Audio Files](https://rnbo.cycling74.com/learn/audio-files-in-rnbo) -- buffer~/file dependency handling in exports
- [Min-DevKit README](https://github.com/Cycling74/min-devkit) -- Build instructions, CMake version, prerequisites
- [Min-DevKit HowTo-NewObject](https://github.com/Cycling74/min-devkit/blob/main/HowTo-NewObject.md) -- Object creation workflow

### Tertiary (LOW confidence)
- C++ embedded param limit of 128 -- practical estimate based on MIDI CC count, not officially documented by Cycling '74
- Web Audio MIDI support completeness -- Web MIDI API exists but browser coverage varies; no RNBO-specific documentation on limitations

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- Min-DevKit is well-documented, project has mature codebase to extend
- Architecture: HIGH -- Direct extension of existing patterns (Box.__new__, validation layers, critics)
- RNBO generation: HIGH -- 560 objects in DB, rnbo_compatible flags, gen~ pattern to follow
- External scaffolding: HIGH -- Min-DevKit API thoroughly documented, C++ templates are straightforward
- Build system: MEDIUM -- cmake/make invocation is standard but auto-fix loop has some unknowns
- Export target constraints: MEDIUM -- VST3/AU well-documented, C++ embedded constraints partially estimated
- Pitfalls: HIGH -- All pitfalls derived from actual codebase analysis and documented behavior

**Research date:** 2026-03-10
**Valid until:** 2026-04-10 (stable domain -- Min-DevKit and RNBO APIs change slowly)
