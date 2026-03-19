# Distribution Strategy Research: MAX/MSP Claude Code Framework

## Executive Summary

This document evaluates five distribution strategies for the MAX/MSP Claude Code Framework, which currently requires `git clone` to set up. The framework consists of Claude Code skills/commands (~188KB), a Python library (~1MB), a 7.4MB object database (with 3.7MB of development-only audit data), and a root `CLAUDE.md` config file. The recommended approach is **npx create-\* scaffolding** backed by a GitHub release tarball, with the Python library remaining as vendored source (not a separate pip package).

---

## Framework Inventory (What Gets Distributed)

| Component | Size | Location | Required by Users |
|-----------|------|----------|-------------------|
| Object database (8 domains) | 3.5MB | `.claude/max-objects/*.json` + `*/objects.json` | Yes |
| Object DB audit data | 3.7MB | `.claude/max-objects/audit/` | No (dev only) |
| Object DB supplementary | 160KB | `.claude/max-objects/{overrides,aliases,...}.json` | Yes |
| Skills (10 agents) | 140KB | `.claude/skills/` | Yes |
| Commands (11 slash commands) | 48KB | `.claude/commands/` | Yes |
| Scripts | 8KB | `.claude/scripts/` | Yes |
| Python library (22 modules) | 1MB | `src/maxpat/` | Yes |
| CLAUDE.md | 12KB | project root | Yes |
| README.md | 12KB | project root | Yes |
| TECHNICAL.md | 28KB | project root | Optional |
| Tests (32 files, 1,141 tests) | 2.6MB | `tests/` | No (dev only) |
| Patches (example projects) | 2.1MB | `patches/` | Optional |
| **Total (user-essential)** | **~5MB** | | |
| **Total (with optional)** | **~8MB** | | |

---

## Option 1: npx create-\* Scaffolding (Primary Investigation)

### Concept

Publish an npm package `create-max-framework` that, when run via `npx create-max-framework my-project`, scaffolds a ready-to-use project directory with the framework installed.

### User Experience

```bash
npx create-max-framework my-project
cd my-project
claude
```

### How It Works

The npm package contains a `bin` script that:
1. Creates the target directory
2. Downloads the framework files (from GitHub release tarball or bundled in the package)
3. Sets up the directory structure: `.claude/`, `src/`, `CLAUDE.md`, `patches/`
4. Checks for Python 3.10+ and warns if missing
5. Prints getting-started instructions

### Package Structure

```
create-max-framework/
  package.json
  bin/
    create-max-framework.js    # CLI entry point (~200 lines)
  templates/
    claude.md                  # CLAUDE.md template
    settings.local.json        # .claude/settings.local.json
    active-project.json        # patches/.active-project.json
  README.md
```

#### package.json

```json
{
  "name": "create-max-framework",
  "version": "1.0.0",
  "description": "Scaffold a MAX/MSP Claude Code Framework project",
  "bin": {
    "create-max-framework": "./bin/create-max-framework.js"
  },
  "files": ["bin/", "templates/", "README.md"],
  "keywords": ["max", "msp", "maxmsp", "claude", "claude-code", "audio"],
  "license": "MIT"
}
```

#### bin/create-max-framework.js (sketch)

```js
#!/usr/bin/env node

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const https = require('https');

const projectName = process.argv[2];
if (!projectName) {
  console.error('Usage: npx create-max-framework <project-name>');
  process.exit(1);
}

const targetDir = path.resolve(projectName);
if (fs.existsSync(targetDir)) {
  console.error(`Directory ${projectName} already exists.`);
  process.exit(1);
}

console.log(`Creating MAX/MSP Claude Code Framework in ${projectName}...`);

// Option A: Download release tarball from GitHub
const RELEASE_URL = 'https://github.com/taylorbrook/MAX-MSP_CC_Framework/releases/latest/download/framework.tar.gz';
// Download, extract to targetDir, excluding tests/.planning/.git

// Option B: Clone without history (shallow)
// execSync(`git clone --depth 1 https://github.com/taylorbrook/MAX-MSP_CC_Framework.git ${targetDir}`);
// Clean up .git, .planning, tests (optional)

// Check Python
try {
  const pyVersion = execSync('python3 --version', { encoding: 'utf8' });
  const match = pyVersion.match(/(\d+)\.(\d+)/);
  if (match && (parseInt(match[1]) < 3 || parseInt(match[2]) < 10)) {
    console.warn('WARNING: Python 3.10+ required. Found:', pyVersion.trim());
  }
} catch {
  console.warn('WARNING: Python 3 not found. The framework requires Python 3.10+.');
}

// Create patches directory with .active-project.json
fs.mkdirSync(path.join(targetDir, 'patches'), { recursive: true });
fs.writeFileSync(
  path.join(targetDir, 'patches', '.active-project.json'),
  JSON.stringify({ active_project: null }, null, 2)
);

console.log(`
Done! Next steps:
  cd ${projectName}
  claude
  /max-new my-first-patch
`);
```

### Download Strategy: GitHub Release Tarball vs Bundled

**Option A: GitHub release tarball (recommended)**
- The npm package is tiny (~5KB) -- just the CLI script
- On `npx`, it downloads a pre-built tarball from GitHub Releases
- Tarball excludes: `.git/`, `.planning/`, `tests/`, `.claude/max-objects/audit/`
- Tarball size: ~5MB (framework essentials only)
- Updates: new GitHub release + bump npm package version

**Option B: Bundle everything in the npm package**
- Package size: ~5MB (all framework files embedded in `templates/`)
- Simpler (no download step), but every update requires npm publish
- npm's unpacked size limit is 2GB; 5MB is fine

**Option A is better** because the npm package stays small and framework updates can be released independently (just push a new GitHub release tarball).

### npm Size Limits and Best Practices

- npm has no hard package size limit, but packages over 50MB trigger warnings
- The framework at ~5MB (excluding dev assets) is well within bounds
- Best practice: use `.npmignore` or `"files"` in package.json to control what ships
- Large static JSON assets (7.4MB object DB) are common in npm packages (e.g., `caniuse-lite` is 4MB)

### Python Dependency Handling

The framework needs Python 3.10+ but `src/maxpat/` is not a pip package -- it's used as a local library by Claude Code. The installer should:
1. Check `python3 --version` and warn if < 3.10 or missing
2. NOT attempt to `pip install` anything -- the Python code is vendored in the project
3. Mention Python 3.10+ in the post-install instructions

### Update Story

- `npx create-max-framework@latest my-new-project` gets the latest version
- For existing projects: no built-in update mechanism (see Recommendation section for ideas)
- Could add `npx create-max-framework --update` flag that replaces `.claude/` and `src/` while preserving `patches/`

### Complexity to Implement

**Low-medium.** Requires:
- Writing the bin script (~200 lines of Node.js)
- Setting up npm account and publishing
- Creating a GitHub Actions workflow to build release tarballs on tag
- Total: ~2-4 hours

### Gotchas

- `.claude/` directory must be at project root (Claude Code looks for it there)
- `CLAUDE.md` must be at project root
- `settings.local.json` in `.claude/` configures Claude Code behavior
- Python path: `src/maxpat/` is imported as `from src.maxpat import ...` -- relative to project root

---

## Option 2: degit / tiged Pattern

### Concept

Use `npx degit` (or its maintained fork `tiged`) to scaffold from the GitHub repo without cloning history.

### User Experience

```bash
npx degit taylorbrook/MAX-MSP_CC_Framework my-project
cd my-project
claude
```

### What It Does

- Downloads a tarball of the repo's latest commit (no `.git/` directory)
- Extracts to the target directory
- That's it -- no post-processing

### Pros

- Zero implementation effort (degit already exists)
- Gets the full repo contents instantly
- No npm package to maintain

### Cons

- Includes everything: `.planning/`, `tests/`, audit data (3.7MB extra)
- No Python version check or post-setup guidance
- No way to exclude directories (degit doesn't support `.degitignore`)
- User gets development artifacts they don't need
- No custom post-install messaging
- `degit` is unmaintained; `tiged` is a community fork but less well-known

### Update Story

- `npx degit taylorbrook/MAX-MSP_CC_Framework my-project --force` would overwrite everything
- Destructive -- no way to preserve `patches/`
- No versioning -- always gets latest commit (could be mid-development)

### Complexity to Implement

**None.** Already works out of the box if the repo is public.

### Gotchas

- Development files clutter the user's project
- No Python dependency check
- tiged/degit reliability concerns for production use

---

## Option 3: Claude Code Native Installation

### Research Findings

As of March 2026, Claude Code does **not** have a native skill/command marketplace or installation mechanism. Specifically:

- **No `claude install` command** -- there is no built-in way to install third-party skills or commands
- **No skills marketplace** -- Anthropic has not shipped a shared skills registry
- **No skill packaging format** -- `.claude/` directories are project-local; there is no way to install skills globally or share them across projects
- **No plugin system** -- Claude Code skills are just markdown files in `.claude/skills/`; there is no dependency resolution or versioning
- **Settings import** exists (`claude settings import`) but only for JSON settings, not full skill trees

### What Claude Code Does Support

- `.claude/` directory at project root for project-specific skills and commands
- `~/.claude/` for user-global settings (but not skill distribution)
- `CLAUDE.md` at project root for project-specific instructions
- `settings.local.json` for local configuration

### Implication

There is no native path for distributing this framework through Claude Code itself. The framework must be distributed as files that land in the right directory structure. Any of the other four options accomplish this.

### Future Possibility

Anthropic may add skill sharing or marketplace features. If they do, the framework's `.claude/skills/` and `.claude/commands/` structure would likely be compatible with minimal changes. Worth monitoring but not worth waiting for.

---

## Option 4: Shell Script Installer

### Concept

A shell script (hosted on GitHub, run via `curl | bash`) that downloads and sets up the framework.

### User Experience

```bash
curl -fsSL https://raw.githubusercontent.com/taylorbrook/MAX-MSP_CC_Framework/main/install.sh | bash -s my-project
cd my-project
claude
```

Or download and run:

```bash
curl -fsSL -o install.sh https://raw.githubusercontent.com/taylorbrook/MAX-MSP_CC_Framework/main/install.sh
chmod +x install.sh
./install.sh my-project
```

### install.sh (sketch)

```bash
#!/usr/bin/env bash
set -euo pipefail

PROJECT_NAME="${1:?Usage: install.sh <project-name>}"
REPO="taylorbrook/MAX-MSP_CC_Framework"
RELEASE_URL="https://github.com/${REPO}/releases/latest/download/framework.tar.gz"

if [ -d "$PROJECT_NAME" ]; then
  echo "Error: Directory $PROJECT_NAME already exists." >&2
  exit 1
fi

echo "Creating MAX/MSP Claude Code Framework in $PROJECT_NAME..."

mkdir -p "$PROJECT_NAME"
curl -fsSL "$RELEASE_URL" | tar -xz -C "$PROJECT_NAME" --strip-components=1

# Check Python
if command -v python3 &>/dev/null; then
  PY_VERSION=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
  PY_MAJOR=$(echo "$PY_VERSION" | cut -d. -f1)
  PY_MINOR=$(echo "$PY_VERSION" | cut -d. -f2)
  if [ "$PY_MAJOR" -lt 3 ] || [ "$PY_MINOR" -lt 10 ]; then
    echo "WARNING: Python 3.10+ required. Found Python $PY_VERSION"
  fi
else
  echo "WARNING: Python 3 not found. Install Python 3.10+ before using the framework."
fi

# Initialize patches directory
mkdir -p "$PROJECT_NAME/patches"
echo '{"active_project": null}' > "$PROJECT_NAME/patches/.active-project.json"

echo ""
echo "Done! Next steps:"
echo "  cd $PROJECT_NAME"
echo "  claude"
echo "  /max-new my-first-patch"
```

### Pros

- No npm dependency -- works on any system with `curl` and `bash`
- Full control over setup logic
- Easy to understand and modify
- Can do Python version checking, directory setup, etc.

### Cons

- `curl | bash` pattern has trust/security concerns (though common in dev tools)
- No discoverability (not on npm, not searchable)
- Shell scripts are harder to make cross-platform (Windows users need WSL or Git Bash)
- No version management or update mechanism beyond re-running

### Update Story

- Re-run `install.sh --update` to refresh `.claude/` and `src/` (would need to implement)
- Or simply re-run the full install to a new directory
- No automatic update notifications

### Complexity to Implement

**Very low.** ~50-100 lines of bash. Requires:
- Writing the install script
- Adding it to the repo
- Setting up GitHub release tarballs (same as Option 1)
- Total: ~1-2 hours

### Gotchas

- Windows compatibility (would need a PowerShell equivalent or WSL instruction)
- No npm discoverability
- Users must trust `curl | bash` from your repo

---

## Option 5: Hybrid npm + pip Package

### Concept

Distribute the Claude Code framework via npx (as in Option 1) AND publish `src/maxpat/` as a standalone pip package (`pip install max-patcher` or similar).

### How It Would Work

1. `npx create-max-framework my-project` scaffolds the project (same as Option 1)
2. `pip install max-patcher` installs the Python library system-wide or in a venv
3. The framework `CLAUDE.md` and agents reference `import maxpat` (pip-installed) instead of `from src.maxpat import ...`

### What pyproject.toml Would Look Like

```toml
[build-system]
requires = ["setuptools>=68.0"]
build-backend = "setuptools.backends._legacy:_Backend"

[project]
name = "max-patcher"
version = "2.0.0"
description = "Python library for reading, editing, and writing MAX/MSP .maxpat files"
readme = "README.md"
license = {text = "MIT"}
requires-python = ">=3.10"
keywords = ["max", "msp", "maxmsp", "audio", "patcher"]

[project.urls]
Homepage = "https://github.com/taylorbrook/MAX-MSP_CC_Framework"

[tool.setuptools.packages.find]
where = ["src"]
```

### Pros

- Python library usable independently (without Claude Code)
- Standard Python packaging (`pip install`, `import maxpat`)
- Version pinning, dependency resolution via pip
- Could attract Python-only users who want to script .maxpat editing

### Cons

- **Significant maintenance burden**: two package ecosystems (npm + pip) to publish, version, and support
- **Import path change**: all agents reference `from src.maxpat import ...` -- would need to change to `import maxpat` or handle both paths
- **Version sync**: npm package and pip package must be kept in sync
- **Complexity**: users now need to run two install commands, or the npx script must also run `pip install`
- **Python environment management**: venv vs system Python vs conda -- adds friction
- **The Python lib is not useful without the Claude Code agents** -- there's no standalone use case today

### Update Story

- npm and pip updated independently (version drift risk)
- `pip install --upgrade max-patcher` for Python updates
- `npx create-max-framework@latest` for framework updates

### Complexity to Implement

**Medium-high.** Requires:
- Creating `pyproject.toml` and Python package structure
- Setting up PyPI account and publishing workflow
- Modifying all agent import paths (10+ files)
- Testing both vendored and installed import paths
- Maintaining two CI/CD pipelines
- Total: ~6-10 hours initial, ongoing maintenance

### Gotchas

- Import path migration across all 10 agents
- PyPI name availability (`max-patcher` may be taken)
- Users who `pip install` in a venv must activate it before running Claude Code
- No real standalone use case for the Python library without the agents

---

## Comparison Matrix

| Criteria | npx create-\* | degit | Claude Native | Shell Script | Hybrid npm+pip |
|----------|---------------|-------|---------------|--------------|----------------|
| **User command** | `npx create-max-framework my-proj` | `npx degit user/repo my-proj` | N/A | `curl \| bash` | `npx` + `pip install` |
| **Setup steps** | 1 | 1 | N/A | 1 | 2 |
| **Discoverability** | npm search | None | N/A | None | npm + PyPI |
| **Custom post-install** | Yes | No | N/A | Yes | Yes |
| **Python check** | Yes | No | N/A | Yes | Implicit |
| **Excludes dev files** | Yes | No | N/A | Yes | Yes |
| **Cross-platform** | Yes (Node) | Yes (Node) | N/A | macOS/Linux | Partial |
| **Implementation effort** | 2-4 hours | 0 | N/A | 1-2 hours | 6-10 hours |
| **Maintenance burden** | Low | None | N/A | Low | High |
| **Update mechanism** | `--update` flag | Destructive | N/A | `--update` flag | Two systems |
| **npm package size** | ~5KB (downloader) | N/A | N/A | N/A | ~5KB + pip |
| **Versioning** | npm semver | Git HEAD | N/A | Git tags | npm + pip |

---

## Recommendation

### Primary: npx create-\* scaffolding with GitHub release tarballs

**Why this approach:**

1. **Familiar pattern.** `npx create-xxx` is the de facto standard for scaffolding JS/dev tool projects. Claude Code users (who already have Node.js) will recognize it immediately.

2. **Clean separation.** The npm package is tiny (~5KB CLI script). The framework content comes from a GitHub release tarball, which can be curated to exclude development-only files (audit data, tests, .planning).

3. **Right level of control.** Custom post-install logic (Python version check, directory setup, getting-started message) without the overhead of maintaining a full Python package.

4. **Low maintenance.** One npm publish per version. GitHub Actions builds the release tarball automatically on git tag.

5. **Good update story.** Can add `npx create-max-framework --update` that refreshes `.claude/` and `src/` while preserving `patches/`.

### Secondary: Also provide the shell script

For users who prefer not to use npm (rare for Claude Code users, but possible), host `install.sh` in the repo. This takes ~1 hour extra and covers the remaining audience.

### Do NOT pursue hybrid npm+pip

The Python library has no standalone use case without the Claude Code agents. The maintenance burden of two package ecosystems is not justified. Keep `src/maxpat/` as vendored source.

### Do NOT wait for Claude Code native distribution

No timeline exists. The framework's structure (`.claude/` directory with skills/commands) would likely be compatible with a future native mechanism anyway.

---

## Implementation Steps (if proceeding)

### Phase 1: GitHub Release Tarball (~1 hour)

1. Create `.release-ignore` file listing paths to exclude from distribution:
   ```
   .planning/
   .git/
   .pytest_cache/
   tests/
   .claude/max-objects/audit/
   src/maxpat/__pycache__/
   patches/
   .DS_Store
   ```

2. Create GitHub Actions workflow `.github/workflows/release.yml`:
   ```yaml
   name: Release
   on:
     push:
       tags: ['v*']
   jobs:
     release:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v4
         - name: Build tarball
           run: |
             tar czf framework.tar.gz \
               --exclude-from=.release-ignore \
               -s '/^\./MAX-MSP_CC_Framework/' \
               .
         - name: Create GitHub Release
           uses: softprops/action-gh-release@v2
           with:
             files: framework.tar.gz
   ```

3. Tag and push: `git tag v2.0.0 && git push --tags`

### Phase 2: npm Package (~2 hours)

1. Create `installer/` directory (not distributed to users):
   ```
   installer/
     package.json
     bin/create-max-framework.js
     README.md
   ```

2. Implement the CLI script (based on sketch in Option 1 above):
   - Argument parsing (project name, `--update` flag, `--version`)
   - Download and extract GitHub release tarball
   - Python version check
   - Directory initialization (patches/, .active-project.json)
   - Post-install instructions

3. Test locally: `node installer/bin/create-max-framework.js test-project`

4. Publish: `cd installer && npm publish`

### Phase 3: Shell Script Fallback (~30 minutes)

1. Create `install.sh` at repo root (based on sketch in Option 4)
2. Test on macOS
3. Add to README.md as alternative installation method

### Phase 4: README Updates (~30 minutes)

1. Update Quick Start section:
   ```markdown
   ### Option A: npx (recommended)
   npx create-max-framework my-project

   ### Option B: Shell script
   curl -fsSL https://raw.githubusercontent.com/.../install.sh | bash -s my-project

   ### Option C: Git clone (for contributors)
   git clone ...
   ```

2. Add "Updating" section explaining `--update` flag

### Estimated Total: 4-5 hours

---

## Open Questions

1. **npm package name**: Is `create-max-framework` available? Alternatives: `create-max-claude`, `create-maxmsp-framework`, `create-max-patcher`
2. **Include example patches in distribution?** Currently 2.1MB. Could be optional (`--with-examples` flag).
3. **Git init the scaffolded project?** The `create-*` pattern usually does `git init` in the new directory. Worth doing here.
4. **Scope of `--update` flag**: Replace `.claude/` and `src/` only? Or also update `CLAUDE.md`, `README.md`, `TECHNICAL.md`?
5. **Monorepo vs separate repo for installer**: Could keep `installer/` in this repo (simpler) or create a separate `create-max-framework` repo (cleaner npm publishing).
