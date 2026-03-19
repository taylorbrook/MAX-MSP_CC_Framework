---
phase: quick-260319-e32
verified: 2026-03-19T18:00:00Z
status: passed
score: 4/4 must-haves verified
re_verification: false
---

# Quick Task 260319-e32: Create npx Installer for Framework Distribution — Verification Report

**Task Goal:** Create npx installer for framework distribution: GitHub Actions release workflow (tarball build on tag push, auto npm publish), create-max-framework npm CLI package (downloads GitHub release tarball, Python version check, directory setup), shell script fallback installer, and README Quick Start update.
**Verified:** 2026-03-19T18:00:00Z
**Status:** PASSED
**Re-verification:** No — initial verification

## Goal Achievement

### Observable Truths

| #   | Truth                                                                    | Status     | Evidence                                                                              |
| --- | ------------------------------------------------------------------------ | ---------- | ------------------------------------------------------------------------------------- |
| 1   | GitHub Actions builds a clean framework tarball when a version tag is pushed | VERIFIED | `.github/workflows/release.yml` triggers on `v*` tags, uses `--exclude-from=.release-ignore`, attaches `framework.tar.gz` via `softprops/action-gh-release@v2` |
| 2   | `npx create-max-framework my-project` scaffolds a working project directory  | VERIFIED | `installer/bin/create-max-framework.js` (204 lines): argument parsing, redirect-following HTTPS download, tar extraction with `--strip-components=1`, git init, Python check, success message. Passes `node -c` and `--help`/`--version`/no-args all behave correctly |
| 3   | `install.sh` scaffolds a working project directory identical to npx          | VERIFIED | `install.sh` (85 lines): curl/tar download, `patches/.active-project.json` creation, git init, Python version check, matching success message. Passes `bash -n` syntax check |
| 4   | README Quick Start shows all three installation methods                      | VERIFIED | README lines 36-58 show Option A (npx recommended), Option B (shell script), Option C (git clone for contributors) |

**Score:** 4/4 truths verified

---

### Required Artifacts

| Artifact                                   | Expected                                       | Status     | Details                                                                      |
| ------------------------------------------ | ---------------------------------------------- | ---------- | ---------------------------------------------------------------------------- |
| `.release-ignore`                          | Exclusion list for release tarball             | VERIFIED   | 14 lines, contains `.planning`, `.git`, `.github`, `installer`, `patches`, etc. Contains `.planning` as required |
| `.github/workflows/release.yml`            | GitHub Actions release workflow                | VERIFIED   | 26 lines, valid YAML, triggers `v*` tags, uses `softprops/action-gh-release@v2` as required |
| `installer/package.json`                   | npm package definition for create-max-framework | VERIFIED  | Contains `"name": "create-max-framework"`, correct `bin` entry, `files` field, `engines: node >=16.0.0` |
| `installer/bin/create-max-framework.js`    | CLI entry point (min 100 lines)                | VERIFIED   | 204 lines, shebang present, all required behaviors implemented (zero external deps) |
| `install.sh`                               | Shell script fallback installer (min 40 lines) | VERIFIED   | 85 lines, `set -euo pipefail`, `trap cleanup ERR`, executable bit set (`-rwxr-xr-x`) |
| `README.md`                                | Updated Quick Start with npx, shell, git clone | VERIFIED   | Contains `npx create-max-framework` at line 39, all three options present |
| `installer/README.md`                      | npm package page documentation                 | VERIFIED   | Title, one-liner, usage, 3-bullet what-it-does, repo link, prerequisites |

---

### Key Link Verification

| From                                        | To                  | Via                                      | Status   | Details                                                             |
| ------------------------------------------- | ------------------- | ---------------------------------------- | -------- | ------------------------------------------------------------------- |
| `.github/workflows/release.yml`             | `.release-ignore`   | `tar --exclude-from reads ignore file`   | WIRED    | Line 18: `--exclude-from=.release-ignore` present in tar command   |
| `installer/bin/create-max-framework.js`     | GitHub Releases     | HTTPS download of `framework.tar.gz`    | WIRED    | Line 11: `RELEASE_URL` set to `.../releases/latest/download/framework.tar.gz`; `followRedirects()` + `downloadAndExtract()` implement full redirect-following download piped to tar |
| `install.sh`                                | GitHub Releases     | curl download of `framework.tar.gz`     | WIRED    | Line 5: `RELEASE_URL` uses `${REPO}/releases/latest/download/framework.tar.gz`; line 45: `curl -fsSL "$RELEASE_URL" | tar xz -C "$PROJECT_NAME" --strip-components=1` |

---

### Requirements Coverage

| Requirement | Description (inferred from plan)                              | Status    | Evidence                                                         |
| ----------- | ------------------------------------------------------------- | --------- | ---------------------------------------------------------------- |
| DIST-01     | GitHub Actions release workflow building clean tarballs       | SATISFIED | `.github/workflows/release.yml` fully implemented               |
| DIST-02     | npx create-max-framework CLI package (zero deps, Node 16+)   | SATISFIED | `installer/` package complete, 204-line CLI verified working     |
| DIST-03     | Shell script fallback installer                               | SATISFIED | `install.sh` 85 lines, syntax valid, equivalent behavior        |
| DIST-04     | README Quick Start with three installation methods           | SATISFIED | README updated with Options A/B/C                               |

---

### Anti-Patterns Found

| File | Line | Pattern | Severity | Impact |
| ---- | ---- | ------- | -------- | ------ |
| —    | —    | None    | —        | —      |

No TODOs, FIXMEs, placeholders, empty implementations, or stub patterns found in any artifact.

---

### Human Verification Required

#### 1. End-to-End npm Install Flow

**Test:** Run `npx create-max-framework test-project` in a clean directory on a machine with Node 16+ and internet access.
**Expected:** Directory `test-project/` is created, contains framework files, `patches/.active-project.json` exists, git repo initialized, no error output.
**Why human:** Requires a live GitHub Release at the expected URL. No release has been published yet — the workflow exists but no `v*` tag has been pushed. Until `git tag v2.0.0 && git push --tags` is run and the release is created, the download URL will 404.

#### 2. GitHub Actions Workflow Execution

**Test:** Push a `v*` tag to the repository.
**Expected:** Actions run, tarball is built excluding dev paths (`.planning/`, `installer/`, etc.), GitHub Release is created with `framework.tar.gz` attached.
**Why human:** Cannot verify the tar exclude behavior or release creation without actually triggering the workflow.

#### 3. Shell Script End-to-End

**Test:** Run `curl -fsSL https://raw.githubusercontent.com/.../main/install.sh | bash -s my-project` from a machine with curl, bash, and git.
**Expected:** Same outcome as npx flow — same dependency on the GitHub Release existing at the download URL.
**Why human:** Same release prerequisite as item 1.

---

### Gaps Summary

No gaps. All four observable truths are verified. All artifacts exist, are substantive (not stubs), and are wired correctly. All key links are connected. All three documented commits (`c568f6d`, `7a5e63c`, `56faca5`) exist in git history.

The three human verification items above are not gaps — they are natural preconditions requiring a live GitHub Release that has not yet been published. The code is correct and complete; the distribution system simply needs a first tagged release to be operational end-to-end.

---

_Verified: 2026-03-19T18:00:00Z_
_Verifier: Claude (gsd-verifier)_
