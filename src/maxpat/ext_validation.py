"""Post-compile external validation and build result types.

Provides:
- BuildResult: Dataclass capturing build attempt outcome (success/failure,
  path to .mxo, errors, attempt count).
- validate_mxo: Checks that a .mxo bundle contains a valid arm64 Mach-O
  binary using macOS file and lipo commands.
- parse_compiler_errors: Extracts structured error info from gcc/clang
  compiler output for auto-fix processing.
"""

from __future__ import annotations

import re
import subprocess
from dataclasses import dataclass
from pathlib import Path


@dataclass
class BuildResult:
    """Result of an external build attempt.

    Attributes:
        success: Whether the build produced a valid .mxo.
        mxo_path: Path to the .mxo bundle if successful, None otherwise.
        errors: List of compiler error messages if failed.
        attempts: How many build attempts were made.
        message: Human-readable summary of the outcome.
    """

    success: bool
    mxo_path: Path | None
    errors: list[str]
    attempts: int
    message: str


def validate_mxo(mxo_path: Path) -> tuple[bool, str]:
    """Post-compile validation of a .mxo bundle.

    Checks:
    1. .mxo path exists and has .mxo suffix.
    2. Binary exists at Contents/MacOS/{stem}.
    3. macOS `file` command confirms Mach-O type.
    4. macOS `lipo -info` confirms arm64 architecture.

    Args:
        mxo_path: Path to the .mxo bundle directory.

    Returns:
        Tuple of (is_valid, message). On failure, message explains
        the specific reason.
    """
    # Check existence and suffix
    if not mxo_path.exists():
        return False, f"Not a .mxo bundle: {mxo_path} does not exist"

    if mxo_path.suffix != ".mxo":
        return False, f"Not a .mxo bundle: expected .mxo suffix, got '{mxo_path.suffix}'"

    # Find binary inside the bundle
    stem = mxo_path.stem
    binary = mxo_path / "Contents" / "MacOS" / stem
    if not binary.exists():
        return False, f"No binary found at Contents/MacOS/{stem}"

    # Check Mach-O type via file command
    try:
        result = subprocess.run(
            ["file", str(binary)],
            capture_output=True,
            text=True,
            timeout=10,
        )
        if "Mach-O" not in result.stdout:
            return False, f"Not a Mach-O binary: {result.stdout.strip()}"
    except (FileNotFoundError, subprocess.TimeoutExpired) as exc:
        return False, f"Cannot verify Mach-O type: {exc}"

    # Check arm64 architecture via lipo
    try:
        result = subprocess.run(
            ["lipo", "-info", str(binary)],
            capture_output=True,
            text=True,
            timeout=10,
        )
        if "arm64" not in result.stdout:
            return False, f"Not arm64 architecture: {result.stdout.strip()}"
    except (FileNotFoundError, subprocess.TimeoutExpired) as exc:
        return False, f"Cannot verify architecture: {exc}"

    return True, f"Valid arm64 Mach-O: {mxo_path.name}"


# Regex matching gcc/clang error format: file:line:col: severity: message
_COMPILER_ERROR_RE = re.compile(
    r"^(?P<file>[^:\s]+):(?P<line>\d+):(?P<column>\d+):\s+"
    r"(?P<severity>fatal error|error|warning):\s+"
    r"(?P<message>.+)$",
    re.MULTILINE,
)


def parse_compiler_errors(stderr: str) -> list[dict]:
    """Parse gcc/clang compiler output into structured error records.

    Extracts file path, line number, column, severity, and message from
    standard compiler error format (``file:line:col: error: msg``).

    Args:
        stderr: Raw stderr output from a compiler invocation.

    Returns:
        List of dicts with keys: file, line, column, severity, message.
        Empty list if no errors/warnings found.
    """
    errors: list[dict] = []
    for match in _COMPILER_ERROR_RE.finditer(stderr):
        errors.append({
            "file": match.group("file"),
            "line": int(match.group("line")),
            "column": int(match.group("column")),
            "severity": match.group("severity"),
            "message": match.group("message").strip(),
        })
    return errors
