"""Base types for the critic system.

CriticResult is the unit of output -- a single finding from a critic
with severity, description, and suggestion for how to fix it.
"""

from __future__ import annotations


class CriticResult:
    """A single critic finding.

    Attributes:
        severity: "blocker", "warning", or "note".
        finding: Human-readable description of the issue.
        suggestion: Recommended fix or improvement.
    """

    __slots__ = ("severity", "finding", "suggestion")

    def __init__(self, severity: str, finding: str, suggestion: str):
        self.severity = severity
        self.finding = finding
        self.suggestion = suggestion

    def __repr__(self) -> str:
        return f"[{self.severity}] {self.finding}"
