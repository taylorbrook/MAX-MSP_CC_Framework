"""Release-archive and CI regression tests (quick 261012-sam, fix-plan Q8).

Covers review findings:
- I2 / S10: the release tarball was built with ``tar`` + an unanchored
  ``.release-ignore``. It stripped ``.claude/scripts/``, nested a truncated copy
  of itself, shipped the tracked maintainer memory file, and masked tar's exit
  code. The release is now ``git archive`` of HEAD with anchored
  ``.gitattributes`` export-ignore rules, built by ``scripts/build_release.sh``
  -- the same script release.yml runs.
- A4: the only workflow published tags without running pytest. test.yml now
  runs the suite on every branch push and PR (Python 3.10 and 3.12), and
  release.yml's release job needs it. requirements-dev.txt must cover every
  third-party import.

The only git command these tests run against the checkout is the read-only
``git archive`` inside ``scripts/build_release.sh``, writing into pytest's
``tmp_path``. The archive is built from HEAD, so archive assertions reflect
committed state, not the working tree.
"""

from __future__ import annotations

import ast
import json
import os
import re
import shutil
import subprocess
import sys
import tarfile
from pathlib import Path

import pytest

REPO_ROOT = Path(__file__).resolve().parent.parent
PREFIX = "MAX-MSP_CC_Framework"
SCRIPT = REPO_ROOT / "scripts" / "build_release.sh"
GITATTRIBUTES = REPO_ROOT / ".gitattributes"

# Trees that must never ship (S2), relative to the archive prefix.
EXCLUDED_TREES = (
    "tests",
    "patches",
    ".planning",
    ".github",
    "scripts",
    "installer",
    ".claude/projects",
)
# Anchored export-ignore patterns .gitattributes must carry (S2).
# /pytest.ini: the maintainer config sets `-n auto` (pytest-xdist); a shipped copy
# would break the DSP pre-flight gate in installs without xdist (quick 261111-u3n).
EXPORT_IGNORE_PATTERNS = tuple("/" + t for t in EXCLUDED_TREES) + (
    "/.gitattributes", "/pytest.ini")
AUDIT_DIR = ".claude/max-objects/audit"
WIDTH_TABLE = AUDIT_DIR + "/width-overrides.json"  # OQ1-A: the only audit file shipped
RUNTIME_FILES = (
    ".claude/scripts/extract_objects.py",
    "CLAUDE.md",
    "src/maxpat/__init__.py",
    ".claude/max-objects/max/objects.json",
    "tools/sync_max_bundle.py",
    # WR-01 (quick 261022-ud6 WP6): /max-verify --live needs the bridge patch
    "tools/max_bridge.py",
    "tools/max_verify_live.py",
    "tools/max_bridge/max-bridge.maxpat",
    WIDTH_TABLE,
)
ARCHIVE_SUFFIXES = (".tar.gz", ".tgz", ".tar", ".zip")


def _git_worktree_ok() -> bool:
    if shutil.which("git") is None or shutil.which("bash") is None:
        return False
    r = subprocess.run(
        ["git", "rev-parse", "--is-inside-work-tree"],
        cwd=REPO_ROOT,
        capture_output=True,
        text=True,
        env=_clean_env(),
    )
    return r.returncode == 0 and r.stdout.strip() == "true"


def _clean_env() -> dict[str, str]:
    """Environment without git redirection variables or PYTHONPATH."""
    env = dict(os.environ)
    for key in ("GIT_DIR", "GIT_WORK_TREE", "GIT_INDEX_FILE", "PYTHONPATH"):
        env.pop(key, None)
    return env


requires_git = pytest.mark.skipif(
    not _git_worktree_ok(),
    reason="git and bash with a git checkout are required",
)


def _run_script(*args: str) -> subprocess.CompletedProcess:
    return subprocess.run(
        ["bash", str(SCRIPT), *args],
        cwd=REPO_ROOT,
        capture_output=True,
        text=True,
        env=_clean_env(),
        timeout=300,
    )


def _run_in_archive(root: Path, code: str) -> dict:
    """Run ``code`` in a fresh interpreter rooted at the extracted archive.

    ``code`` must print one JSON object on its last stdout line.
    """
    r = subprocess.run(
        [sys.executable, "-c", code, str(root)],
        cwd=str(root),
        capture_output=True,
        text=True,
        env=_clean_env(),
        timeout=300,
    )
    assert r.returncode == 0, f"subprocess failed:\n{r.stdout}\n{r.stderr}"
    lines = [ln for ln in r.stdout.splitlines() if ln.strip()]
    assert lines, f"no output:\n{r.stderr}"
    return json.loads(lines[-1])


@pytest.fixture(scope="module")
def release_archive(tmp_path_factory):
    """Build the release exactly as release.yml does, validate and extract it."""
    if not _git_worktree_ok():
        pytest.skip("git and bash with a git checkout are required")
    tmp = tmp_path_factory.mktemp("release")
    out = tmp / "framework.tar.gz"
    r = _run_script(str(out))
    if r.returncode != 0:
        pytest.fail(f"build_release.sh failed ({r.returncode}):\n{r.stderr}")
    dest = tmp / "extract"
    dest.mkdir()
    rels: set[str] = set()
    with tarfile.open(out, "r:gz") as tf:
        members = tf.getmembers()
        for m in members:
            name = m.name.rstrip("/")
            assert name == PREFIX or name.startswith(PREFIX + "/"), m.name
            assert not name.startswith("/"), m.name
            assert ".." not in Path(name).parts, m.name
            assert m.isfile() or m.isdir(), f"{m.name}: not a regular file or dir"
            if name != PREFIX:
                rels.add(name[len(PREFIX) + 1:])
        if hasattr(tarfile, "data_filter"):
            tf.extractall(dest, filter="data")
        else:  # pragma: no cover - Python without extraction filters
            tf.extractall(dest)
    root = dest / PREFIX
    assert root.is_dir()
    yield rels, root, out


@pytest.mark.slow
class TestReleaseArchive:
    """I2: the archive built by scripts/build_release.sh has the right contents."""

    def test_runtime_files_ship(self, release_archive):
        rels, root, _ = release_archive
        missing = [f for f in RUNTIME_FILES if f not in rels]
        assert not missing, f"runtime files missing from the release: {missing}"
        for f in RUNTIME_FILES:
            assert (root / f).is_file(), f

    def test_maintainer_trees_excluded(self, release_archive):
        rels, _, _ = release_archive
        leaked = sorted(
            r for r in rels for x in EXCLUDED_TREES if r == x or r.startswith(x + "/")
        )
        assert not leaked, f"maintainer trees shipped: {leaked[:20]}"
        assert ".gitattributes" not in rels
        assert "pytest.ini" not in rels
        audit_extra = sorted(
            r
            for r in rels
            if r.startswith(AUDIT_DIR + "/") and r != WIDTH_TABLE
        )
        assert not audit_extra, f"audit reports shipped: {audit_extra}"

    def test_no_nested_archive(self, release_archive):
        rels, _, _ = release_archive
        nested = sorted(r for r in rels if r.endswith(ARCHIVE_SUFFIXES))
        assert not nested, f"nested archives: {nested}"

    def test_every_src_module_imports_from_archive(self, release_archive):
        rels, root, _ = release_archive
        code = r"""
import importlib, json, pkgutil, sys
root = sys.argv[1]
sys.path.insert(0, root)
errors, files = {}, {}
import src
def onerror(name):
    errors[name] = repr(sys.exc_info()[1])
names = [m.name for m in pkgutil.walk_packages(src.__path__, "src.", onerror=onerror)]
for name in names:
    try:
        mod = importlib.import_module(name)
        files[name] = getattr(mod, "__file__", None)
    except BaseException as exc:
        errors[name] = repr(exc)
cycle = None
widths = None
try:
    from src.maxpat.db_lookup import ObjectDatabase
    cycle = ObjectDatabase().lookup("cycle~") is not None
    import src.maxpat.sizing as sizing
    widths = len(sizing._WIDTH_OVERRIDES)
except BaseException as exc:
    errors["<checks>"] = repr(exc)
print(json.dumps({"names": names, "errors": errors, "files": files,
                  "cycle": cycle, "widths": widths}))
"""
        res = _run_in_archive(root, code)
        assert not res["errors"], res["errors"]
        root_res = root.resolve()
        for name, f in res["files"].items():
            assert f, f"{name} has no __file__"
            assert Path(f).resolve().is_relative_to(root_res), f"{name}: {f}"

        expected = set()
        for r in rels:
            if not (r.startswith("src/") and r.endswith(".py")):
                continue
            parts = r[: -len(".py")].split("/")
            if parts[-1] == "__init__":
                parts = parts[:-1]
            name = ".".join(parts)
            if name != "src":
                expected.add(name)
        assert set(res["names"]) == expected
        assert res["cycle"] is True, "ObjectDatabase in the archive cannot resolve cycle~"
        assert res["widths"] and res["widths"] > 0, "width-override table empty in the archive"

    def test_fresh_layout_has_no_active_project(self, release_archive):
        _, root, _ = release_archive
        code = r"""
import json, sys
from pathlib import Path
root = Path(sys.argv[1])
sys.path.insert(0, str(root))
from src.maxpat.project import get_active_project
first = get_active_project(root)
(root / "patches").mkdir(exist_ok=True)
second = get_active_project(root)
print(json.dumps({"first": first, "second": second}))
"""
        patches = root / "patches"
        assert not patches.exists(), "patches/ shipped in the release"
        res = _run_in_archive(root, code)
        assert res == {"first": None, "second": None}

    def test_live_check_bridge_patch_available(self, release_archive):
        """WR-01 (quick 261022-ud6 WP6): /max-verify --live can find its bridge
        patch in a release install (patches/ is not shipped)."""
        _, root, _ = release_archive
        code = r"""
import json, sys
from pathlib import Path
root = Path(sys.argv[1])
sys.path.insert(0, str(root))
import tools.max_bridge as bridge
print(json.dumps({
    "file": bridge.BRIDGE_PATCH.is_file(),
    "inside": str(bridge.BRIDGE_PATCH.resolve()).startswith(str(root.resolve())),
    "hint": bridge._bridge_hint(bridge.HOST, bridge.BRIDGE_PORT),
}))
"""
        res = _run_in_archive(root, code)
        assert res["file"] and res["inside"], res
        assert "tools/max_bridge/max-bridge.maxpat" in res["hint"]


class TestGitattributes:
    """I2: export-ignore patterns are anchored and cover the S2 exclusions."""

    def _rules(self) -> list[tuple[str, list[str]]]:
        assert GITATTRIBUTES.is_file(), ".gitattributes is missing"
        rules = []
        for line in GITATTRIBUTES.read_text().splitlines():
            s = line.strip()
            if not s or s.startswith("#"):
                continue
            pattern, *attrs = s.split()
            rules.append((pattern, attrs))
        return rules

    def test_export_ignore_patterns_anchored(self):
        bad = [
            p
            for p, attrs in self._rules()
            if any(a in ("export-ignore", "-export-ignore") for a in attrs)
            and not p.startswith("/")
        ]
        assert not bad, f"unanchored export-ignore patterns: {bad}"

    def test_required_exclusions_present(self):
        ignored = {p for p, attrs in self._rules() if "export-ignore" in attrs}
        missing = [p for p in EXPORT_IGNORE_PATTERNS if p not in ignored]
        assert not missing, f"missing export-ignore patterns: {missing}"

    def test_claude_scripts_never_named(self):
        named = [p for p, _ in self._rules() if p.rstrip("/*").startswith("/.claude/scripts")]
        assert not named, named


@requires_git
class TestBuildScript:
    """I2: the build script fails loudly (no exit-code masking)."""

    def test_no_arguments_fails(self):
        assert SCRIPT.is_file(), "scripts/build_release.sh is missing"
        assert _run_script().returncode != 0

    def test_bad_treeish_fails(self, tmp_path):
        assert SCRIPT.is_file(), "scripts/build_release.sh is missing"
        r = _run_script(str(tmp_path / "out.tar.gz"), "no-such-ref-q8")
        assert r.returncode != 0, r.stdout


WORKFLOWS = REPO_ROOT / ".github" / "workflows"
REQUIREMENTS_DEV = REPO_ROOT / "requirements-dev.txt"


class TestCiConfig:
    """A4: CI runs the suite; the release is gated on it and uses the build script."""

    def test_test_workflow(self):
        path = WORKFLOWS / "test.yml"
        assert path.is_file(), ".github/workflows/test.yml is missing"
        text = path.read_text()
        for needle in (
            "workflow_call",
            "pull_request",
            "branches:",
            "ubuntu-latest",
            "python -m pip install -r requirements-dev.txt",
            "python -m pytest -q",
            "'3.10'",
            "'3.12'",
        ):
            assert needle in text, f"test.yml lacks {needle!r}"

    def test_release_workflow_gated_and_uses_build_script(self):
        text = (WORKFLOWS / "release.yml").read_text()
        assert "uses: ./.github/workflows/test.yml" in text
        assert re.search(r"needs:\s*\[?\s*test\b", text), "release job does not need test"
        assert 'bash scripts/build_release.sh "$RUNNER_TEMP/framework.tar.gz"' in text
        assert "${{ runner.temp }}/framework.tar.gz" in text

    def test_release_workflow_drops_tar_build(self):
        text = (WORKFLOWS / "release.yml").read_text()
        assert "--exclude-from" not in text
        assert "|| [[" not in text, "release.yml masks an exit code"
        assert "tar czf" not in text

    def test_test_workflow_checks_python_310_syntax_and_apis(self):
        """BL-01 follow-up (quick 261022-ud6 WP6): math.exp2 (3.11+) passed CI
        because no test reached it; vermin flags any 3.11+ API statically."""
        text = (WORKFLOWS / "test.yml").read_text()
        assert re.search(r"vermin -t=3\.10- --violations\b.*\bsrc tools tests scripts "
                         r"\.claude/scripts", text), text
        assert 'python -m pip install "vermin>=1.6,<2"' in text

    # WR-05 / IN-07 (quick 261022-ud6 WP6): npm trusted publishing (OIDC), no
    # long-lived token, publish verified before the GitHub release goes public,
    # and only full semver tags trigger a release.

    @staticmethod
    def _release_steps(text: str) -> list[str]:
        return re.findall(r"^\s+- (?:name|uses): (.+)$", text, re.M)

    def test_release_uses_trusted_publishing(self):
        text = (WORKFLOWS / "release.yml").read_text()
        assert "NODE_AUTH_TOKEN" not in text and "NPM_TOKEN" not in text
        assert "secrets." not in text
        assert re.search(r"^\s+id-token: write\b", text, re.M)
        assert "npm publish --provenance --access public" in text
        assert "node-version: '24'" in text
        assert "npm install -g npm@^11.5.1" in text

    def test_publish_checked_before_github_release(self):
        text = (WORKFLOWS / "release.yml").read_text()
        steps = self._release_steps(text)
        idx = {s: i for i, s in enumerate(steps)}
        dry = next(i for s, i in idx.items() if "dry run" in s.lower())
        pub = next(i for s, i in idx.items() if s.startswith("Publish to npm"))
        gh = next(i for s, i in idx.items() if s.startswith("Create GitHub Release"))
        assert dry < pub < gh, steps
        assert "npm publish --dry-run" in text
        # a re-run after a GitHub-release failure must not fail on "version exists"
        assert "npm view" in text

    def test_tag_filter_is_full_semver(self):
        text = (WORKFLOWS / "release.yml").read_text()
        m = re.search(r"^\s*tags:\s*\[(.*)\]\s*$", text, re.M)
        assert m, "release.yml has no inline tags filter"
        patterns = [p.strip().strip("'\"") for p in m.group(1).split(",")]
        assert patterns == ["v[0-9]+.[0-9]+.[0-9]+"]

    # quick 261022-ud6 WP8: the GitHub release body is the tag's CHANGELOG.md
    # section, extracted by scripts/release_notes.sh before anything publishes.

    def test_release_body_from_changelog_before_publish(self):
        text = (WORKFLOWS / "release.yml").read_text()
        assert 'bash scripts/release_notes.sh "$GITHUB_REF_NAME"' in text
        assert "body_path: ${{ runner.temp }}/release-notes.md" in text
        steps = self._release_steps(text)
        notes = next(i for i, s in enumerate(steps) if s.startswith("Extract release notes"))
        pub = next(i for i, s in enumerate(steps) if s.startswith("Publish to npm"))
        assert notes < pub, steps

    @pytest.mark.parametrize("tag", ["v6.0.0", "6.0.0"])
    def test_release_notes_extract_the_version_section(self, tag):
        out = subprocess.run(
            ["bash", str(REPO_ROOT / "scripts" / "release_notes.sh"), tag],
            capture_output=True, text=True, check=True,
        ).stdout
        assert "### Breaking changes" in out and "### Migration notes" in out
        assert "## [" not in out, "the section must stop at the next version heading"

    def test_release_notes_missing_version_fails(self, tmp_path):
        log = tmp_path / "CHANGELOG.md"
        log.write_text("# Changelog\n\n## [1.0.0] - 2026-01-01\n\n- one\n")
        script = str(REPO_ROOT / "scripts" / "release_notes.sh")
        ok = subprocess.run(["bash", script, "1.0.0", str(log)], capture_output=True, text=True)
        assert ok.returncode == 0 and ok.stdout.strip() == "- one"
        missing = subprocess.run(["bash", script, "9.9.9", str(log)], capture_output=True, text=True)
        assert missing.returncode == 1

    def test_release_ignore_removed(self):
        assert not (REPO_ROOT / ".release-ignore").exists()


def _requirement_names() -> set[str]:
    names = set()
    for line in REQUIREMENTS_DEV.read_text().splitlines():
        line = line.split("#", 1)[0].strip()
        if not line:
            continue
        names.add(re.split(r"[<>=!~\[; ]", line, maxsplit=1)[0].strip().lower())
    return names


class TestDevRequirements:
    """A4: requirements-dev.txt installs every third-party package the code imports."""

    SCAN_DIRS = ("src", "tests", "tools", "scripts", ".claude/scripts")

    def test_core_requirements_listed(self):
        assert REQUIREMENTS_DEV.is_file(), "requirements-dev.txt is missing"
        assert {"numpy", "scipy", "pytest"} <= _requirement_names()

    def test_third_party_imports_covered(self):
        assert REQUIREMENTS_DEV.is_file(), "requirements-dev.txt is missing"
        files = []
        for d in self.SCAN_DIRS:
            base = REPO_ROOT / d
            if base.is_dir():
                files.extend(
                    f for f in base.rglob("*.py") if "__pycache__" not in f.parts
                )
        local = {"src", "tests", "tools", "scripts"}
        for f in files:
            local.add(f.stem)
            for parent in f.relative_to(REPO_ROOT).parts[:-1]:
                local.add(parent)
        imported = set()
        for f in files:
            tree = ast.parse(f.read_text(encoding="utf-8"), filename=str(f))
            for node in ast.walk(tree):
                if isinstance(node, ast.Import):
                    imported.update(a.name.split(".")[0] for a in node.names)
                elif isinstance(node, ast.ImportFrom) and node.level == 0 and node.module:
                    imported.add(node.module.split(".")[0])
        third_party = imported - set(sys.stdlib_module_names) - local
        missing = {n for n in third_party if n.lower() not in _requirement_names()}
        assert not missing, f"third-party imports missing from requirements-dev.txt: {sorted(missing)}"
