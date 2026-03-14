---
phase: quick-7
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/project.py
  - examples/FDNVerb/FDNVerb.maxpat
  - examples/FDNVerb/FDNverb.gendsp
  - examples/granularsynthtest/granularsynthtest.maxpat
  - examples/granularsynthtest/granular-engine.gendsp
  - examples/performancepatchtest/performancepatchtest.maxpat
  - examples/performancepatchtest/comp-band.maxpat
  - examples/performancepatchtest/comp-engine.gendsp
  - examples/performancepatchtest/crossover-4band.gendsp
  - examples/rhythmic-sampler/rhythmic-sampler.maxpat
  - examples/rhythmic-sampler/slot.maxpat
  - examples/rhythmic-sampler/slot-engine.js
  - examples/scala-synth/scala-synth.maxpat
  - examples/scala-synth/scala-synth-voice.maxpat
  - examples/scala-synth/scala-parser.js
  - examples/scala-synth/partial-display.js
  - PATCHES.md
  - tests/test_project.py
autonomous: true
requirements: [QUICK-7]

must_haves:
  truths:
    - "examples/ directory contains copies of all generated .maxpat, .gendsp, and .js files organized by project name"
    - "PATCHES.md lists every project with its name, description, version, and generated files"
    - "A Python function exists to regenerate both the examples/ directory and PATCHES.md from current patches/ state"
  artifacts:
    - path: "src/maxpat/project.py"
      provides: "build_examples_catalog() function"
      contains: "def build_examples_catalog"
    - path: "PATCHES.md"
      provides: "Human-readable catalog of all patches"
      contains: "FDNVerb"
    - path: "examples/FDNVerb/FDNVerb.maxpat"
      provides: "Copied example patch"
    - path: "examples/scala-synth/scala-synth.maxpat"
      provides: "Copied example patch"
  key_links:
    - from: "src/maxpat/project.py"
      to: "patches/*/versions.json"
      via: "get_version() reads version data"
      pattern: "get_version"
    - from: "src/maxpat/project.py"
      to: "patches/*/context.md"
      via: "reads first line for project description"
      pattern: "context\\.md"
---

<objective>
Add all generated patches (.maxpat, .gendsp, .js) to an examples/ directory organized by project name, and create a PATCHES.md catalog listing every project with its name, version, description, and files.

Purpose: Give users a single browsable directory of example patches and a markdown index they can scan to find what they need.
Output: examples/ directory with patch copies, PATCHES.md catalog, and a reusable Python function to regenerate both.
</objective>

<execution_context>
@/Users/taylorbrook/.claude/get-shit-done/workflows/execute-plan.md
@/Users/taylorbrook/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@src/maxpat/project.py
@patches/FDNVerb/context.md
@patches/granularsynthtest/context.md
@patches/performancepatchtest/context.md
@patches/rhythmic-sampler/context.md
@patches/scala-synth/context.md

<interfaces>
From src/maxpat/project.py:
```python
def list_projects(base_dir: Path) -> list[str]:
    """List all project names (directories under patches/ excluding hidden files)."""

def get_version(project_dir: Path) -> str | None:
    """Get the current (latest) version string for a project."""
```
</interfaces>
</context>

<tasks>

<task type="auto" tdd="true">
  <name>Task 1: Add build_examples_catalog() to project.py with tests</name>
  <files>src/maxpat/project.py, tests/test_project.py</files>
  <behavior>
    - Test 1: build_examples_catalog() creates examples/{project}/ directories for each project
    - Test 2: Only .maxpat, .gendsp, and .js files are copied (not .py, .txt, or other files)
    - Test 3: Copied files are byte-identical to originals (shutil.copy2)
    - Test 4: PATCHES.md is created at base_dir root with project names, versions, descriptions, and file lists
    - Test 5: PATCHES.md contains a table row for each project with version from versions.json
    - Test 6: Running build_examples_catalog() twice is idempotent (cleans and rebuilds)
    - Test 7: Project description is extracted from first non-empty, non-heading line of context.md
  </behavior>
  <action>
    Add a `build_examples_catalog(base_dir: Path) -> Path` function to `src/maxpat/project.py`.

    The function should:
    1. Use `list_projects(base_dir)` to get all project names
    2. For each project, scan `patches/{name}/generated/` for .maxpat, .gendsp, and .js files
    3. Copy those files to `examples/{name}/` (create directory, clean existing first with shutil.rmtree if it exists)
    4. Read the project description from `patches/{name}/context.md` -- take the first non-empty line that is not a markdown heading (i.e., does not start with `#`). Strip leading/trailing whitespace. If no such line exists, use "No description".
    5. Read version via `get_version(base_dir / "patches" / name)`
    6. Generate `PATCHES.md` at `base_dir / "PATCHES.md"` with this format:

    ```
    # Patch Catalog

    Generated patch examples from the MAX project.

    | Project | Version | Description |
    |---------|---------|-------------|
    | [FDNVerb](examples/FDNVerb/) | 0.0.0 | Advanced digital reverb built directly in gen~ for use inside MAX. |
    | ... | ... | ... |

    ## FDNVerb

    **Version:** 0.0.0
    **Description:** Advanced digital reverb built directly in gen~ for use inside MAX.

    Files:
    - FDNVerb.maxpat
    - FDNverb.gendsp

    ---

    ## granularsynthtest
    ...
    ```

    7. Return the path to the PATCHES.md file

    Import `shutil` at the top of the file. Projects should be listed alphabetically (they already are from list_projects).

    Write tests in `tests/test_project.py` in a new `TestBuildExamplesCatalog` class. Use tmp_path fixtures that create a minimal patches directory structure with a fake .maxpat file (just some JSON content), a .py file (should be excluded), and a versions.json + context.md. Assert the function creates the right files and excludes the wrong ones.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_project.py::TestBuildExamplesCatalog -xvs</automated>
  </verify>
  <done>build_examples_catalog() function exists in project.py, all tests pass, function correctly copies patch files and generates PATCHES.md</done>
</task>

<task type="auto">
  <name>Task 2: Run build_examples_catalog() to populate examples/ and PATCHES.md</name>
  <files>examples/FDNVerb/FDNVerb.maxpat, examples/FDNVerb/FDNverb.gendsp, examples/granularsynthtest/granularsynthtest.maxpat, examples/granularsynthtest/granular-engine.gendsp, examples/performancepatchtest/performancepatchtest.maxpat, examples/performancepatchtest/comp-band.maxpat, examples/performancepatchtest/comp-engine.gendsp, examples/performancepatchtest/crossover-4band.gendsp, examples/rhythmic-sampler/rhythmic-sampler.maxpat, examples/rhythmic-sampler/slot.maxpat, examples/rhythmic-sampler/slot-engine.js, examples/scala-synth/scala-synth.maxpat, examples/scala-synth/scala-synth-voice.maxpat, examples/scala-synth/scala-parser.js, examples/scala-synth/partial-display.js, PATCHES.md</files>
  <action>
    Run the function against the real project directory to populate examples/ and generate PATCHES.md:

    ```bash
    cd /Users/taylorbrook/Dev/MAX && python -c "
    from pathlib import Path
    from src.maxpat.project import build_examples_catalog
    result = build_examples_catalog(Path('.'))
    print(f'Catalog written to: {result}')
    "
    ```

    After running, verify the output:
    1. Check that examples/ has 5 subdirectories (one per project)
    2. Check that PATCHES.md exists and contains all 5 projects
    3. Verify file counts match: FDNVerb (2), granularsynthtest (2), performancepatchtest (4), rhythmic-sampler (3), scala-synth (4) = 15 total files
    4. Spot-check one copied file is identical to its source using diff
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -c "
from pathlib import Path
examples = Path('examples')
assert examples.is_dir(), 'examples/ missing'
projects = sorted(d.name for d in examples.iterdir() if d.is_dir())
assert projects == ['FDNVerb', 'granularsynthtest', 'performancepatchtest', 'rhythmic-sampler', 'scala-synth'], f'Wrong projects: {projects}'
patches_md = Path('PATCHES.md')
assert patches_md.is_file(), 'PATCHES.md missing'
content = patches_md.read_text()
for p in projects:
    assert p in content, f'{p} missing from PATCHES.md'
total_files = sum(len(list(d.iterdir())) for d in examples.iterdir() if d.is_dir())
assert total_files == 15, f'Expected 15 files, got {total_files}'
print('All checks passed: 5 projects, 15 files, PATCHES.md complete')
"</automated>
  </verify>
  <done>examples/ directory contains 15 patch/gendsp/js files across 5 project subdirectories, PATCHES.md contains a complete catalog with names, versions, descriptions, and file listings for all 5 projects</done>
</task>

</tasks>

<verification>
- examples/ directory exists with 5 subdirectories matching project names
- Each subdirectory contains only .maxpat, .gendsp, and .js files (no .py or .txt)
- PATCHES.md exists at project root with summary table and per-project detail sections
- All 15 generated patch files are present in examples/
- build_examples_catalog() is importable and can regenerate everything from scratch
</verification>

<success_criteria>
- examples/ directory populated with 15 files across 5 projects
- PATCHES.md contains name, version, and description for all 5 projects
- build_examples_catalog() function is tested and reusable
- Running the function again produces identical output (idempotent)
</success_criteria>

<output>
After completion, create `.planning/quick/7-add-generated-patches-to-example-project/7-SUMMARY.md`
</output>
