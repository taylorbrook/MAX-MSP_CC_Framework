"""Smoke tests for src/maxpat/ext_validation.py.

Only exercises early-return branches of validate_mxo (nonexistent path,
wrong suffix, missing binary) so no `file`/`lipo` subprocess ever runs.
"""

from pathlib import Path

from src.maxpat.ext_validation import (
    BuildResult,
    parse_compiler_errors,
    validate_mxo,
)


class TestValidateMxo:
    def test_nonexistent_path(self):
        ok, msg = validate_mxo(Path("/nonexistent/dir/thing.mxo"))
        assert ok is False
        assert "does not exist" in msg

    def test_existing_dir_without_mxo_suffix(self, tmp_path):
        ok, msg = validate_mxo(tmp_path)
        assert ok is False
        assert "suffix" in msg

    def test_mxo_dir_missing_binary(self, tmp_path):
        bundle = tmp_path / "myext.mxo"
        bundle.mkdir()
        ok, msg = validate_mxo(bundle)
        assert ok is False
        assert "Contents/MacOS/myext" in msg


class TestParseCompilerErrors:
    def test_extracts_structured_records(self):
        stderr = (
            "source/myext.cpp:42:13: error: use of undeclared identifier 'foo'\n"
            "source/myext.cpp:50:5: warning: unused variable 'bar'\n"
            "2 errors generated.\n"
        )
        records = parse_compiler_errors(stderr)
        assert len(records) == 2
        first = records[0]
        assert first["file"] == "source/myext.cpp"
        assert first["line"] == 42
        assert first["column"] == 13
        assert first["severity"] == "error"
        assert "undeclared identifier" in first["message"]
        assert records[1]["severity"] == "warning"

    def test_empty_stderr_returns_empty_list(self):
        assert parse_compiler_errors("") == []


class TestBuildResult:
    def test_instantiates(self):
        result = BuildResult(
            success=False,
            mxo_path=None,
            errors=["boom"],
            attempts=2,
            message="build failed",
        )
        assert result.success is False
        assert result.mxo_path is None
        assert result.errors == ["boom"]
        assert result.attempts == 2
