"""Persistent memory system for learned MAX/MSP patterns.

Stores structured entries as markdown files with dual-scope support:
  - Global: ~/.claude/max-memory/{domain}/patterns.md
  - Project: {project_dir}/.max-memory/patterns.md

Entries are structured sections with date, domain, context, and actionable rule.
Deduplication prevents duplicate entries by domain + pattern name (case-insensitive).
"""

from __future__ import annotations

import re
from dataclasses import dataclass
from pathlib import Path


@dataclass
class MemoryEntry:
    """A single learned pattern entry.

    Attributes:
        pattern: Short descriptive name (e.g., "prefer line~ for gain").
        domain: MAX domain this applies to (e.g., "dsp", "ui", "midi").
        observed: ISO date string when the pattern was observed.
        context: How/where the pattern was observed.
        rule: Actionable rule to follow in future generations.
    """

    pattern: str
    domain: str
    observed: str
    context: str
    rule: str


_ENTRY_TEMPLATE = """## Pattern: {pattern}
- **Observed:** {observed}
- **Domain:** {domain}
- **Context:** {context}
- **Rule:** {rule}
"""

# Regex to split file into entry sections by ## Pattern: header
_PATTERN_HEADER_RE = re.compile(r"^## Pattern:\s*(.+)$", re.MULTILINE)
# Regex to extract field values from markdown bullet lines
_FIELD_RE = re.compile(r"^- \*\*(\w+):\*\*\s*(.+)$", re.MULTILINE)


def _parse_entries(text: str) -> list[MemoryEntry]:
    """Parse markdown text into a list of MemoryEntry objects.

    Splits on ``## Pattern:`` headers, then extracts fields from
    ``- **Key:** value`` lines within each section.
    """
    entries: list[MemoryEntry] = []
    # Split by ## Pattern: headers keeping the header text
    parts = _PATTERN_HEADER_RE.split(text)
    # parts looks like: [preamble, name1, body1, name2, body2, ...]
    if len(parts) < 3:
        return entries

    for i in range(1, len(parts), 2):
        pattern_name = parts[i].strip()
        body = parts[i + 1] if i + 1 < len(parts) else ""

        fields: dict[str, str] = {}
        for match in _FIELD_RE.finditer(body):
            fields[match.group(1).lower()] = match.group(2).strip()

        entries.append(
            MemoryEntry(
                pattern=pattern_name,
                domain=fields.get("domain", ""),
                observed=fields.get("observed", ""),
                context=fields.get("context", ""),
                rule=fields.get("rule", ""),
            )
        )

    return entries


class MemoryStore:
    """Read/write persistent memory entries at global or project scope.

    Global scope: entries organized by domain in separate directories.
    Project scope: all entries in a single flat file regardless of domain.

    Args:
        scope: "global" or "project".
        project_dir: Required when scope is "project". Path to the project root.
        base_dir: Override for global base directory (default ~/.claude/max-memory/).
                  Used by tests to avoid touching the real filesystem.
    """

    def __init__(
        self,
        scope: str = "global",
        project_dir: Path | None = None,
        base_dir: Path | None = None,
    ) -> None:
        self.scope = scope
        if scope == "project":
            if project_dir is None:
                raise ValueError("project_dir is required for project scope")
            self._base = project_dir / ".max-memory"
        elif scope == "global":
            self._base = base_dir if base_dir is not None else Path.home() / ".claude" / "max-memory"
        else:
            raise ValueError(f"Unknown scope: {scope!r}. Use 'global' or 'project'.")

    def _file_path(self, domain: str) -> Path:
        """Return the markdown file path for a given domain.

        Global: {base}/{domain}/patterns.md  (one file per domain)
        Project: {base}/patterns.md           (flat, single file)
        """
        if self.scope == "global":
            return self._base / domain / "patterns.md"
        return self._base / "patterns.md"

    def _domain_dirs(self) -> list[Path]:
        """Return all domain directories (global) or the single base dir (project)."""
        if self.scope == "global":
            if not self._base.exists():
                return []
            return [d for d in sorted(self._base.iterdir()) if d.is_dir()]
        return [self._base]

    def write(self, entry: MemoryEntry) -> bool:
        """Append a memory entry as a markdown section.

        Creates directories and file if they don't exist.
        Returns True if written, False if entry was a duplicate (dedup).
        """
        # Check for duplicate (case-insensitive on pattern name within same domain)
        existing = self.read(domain=entry.domain)
        for e in existing:
            if e.pattern.lower() == entry.pattern.lower():
                return False

        file_path = self._file_path(entry.domain)
        file_path.parent.mkdir(parents=True, exist_ok=True)

        section = _ENTRY_TEMPLATE.format(
            pattern=entry.pattern,
            observed=entry.observed,
            domain=entry.domain,
            context=entry.context,
            rule=entry.rule,
        )

        with open(file_path, "a", encoding="utf-8") as f:
            f.write(section)
            f.write("\n")

        return True

    def read(self, domain: str | None = None) -> list[MemoryEntry]:
        """Read memory entries, optionally filtered by domain.

        Args:
            domain: If specified, return only entries matching this domain.
                    For global scope, reads only the domain's file.
                    For project scope, reads the flat file and filters.

        Returns:
            List of MemoryEntry objects.
        """
        entries: list[MemoryEntry] = []

        if self.scope == "global":
            if domain is not None:
                # Read single domain file
                fp = self._file_path(domain)
                if fp.exists():
                    entries.extend(_parse_entries(fp.read_text(encoding="utf-8")))
            else:
                # Read all domain files
                for domain_dir in self._domain_dirs():
                    fp = domain_dir / "patterns.md"
                    if fp.exists():
                        entries.extend(_parse_entries(fp.read_text(encoding="utf-8")))
        else:
            # Project scope: single flat file
            fp = self._file_path("")
            if fp.exists():
                all_entries = _parse_entries(fp.read_text(encoding="utf-8"))
                if domain is not None:
                    entries = [e for e in all_entries if e.domain == domain]
                else:
                    entries = all_entries

        return entries

    def list_domains(self) -> list[str]:
        """Return unique domain names from all stored entries."""
        entries = self.read()
        domains = sorted({e.domain for e in entries})
        return domains

    def delete(self, pattern: str, domain: str | None = None) -> bool:
        """Remove an entry by pattern name.

        Args:
            pattern: The pattern name to delete.
            domain: The domain to search in. Required for global scope to
                    identify the correct file. For project scope, searches
                    the flat file.

        Returns:
            True if the entry was found and removed, False otherwise.
        """
        if self.scope == "global":
            if domain is None:
                # Search all domains
                for domain_dir in self._domain_dirs():
                    fp = domain_dir / "patterns.md"
                    if fp.exists():
                        if self._delete_from_file(fp, pattern):
                            return True
                return False
            else:
                fp = self._file_path(domain)
                if not fp.exists():
                    return False
                return self._delete_from_file(fp, pattern)
        else:
            fp = self._file_path("")
            if not fp.exists():
                return False
            return self._delete_from_file(fp, pattern)

    def _delete_from_file(self, file_path: Path, pattern: str) -> bool:
        """Remove a pattern entry from a specific file.

        Returns True if found and removed.
        """
        text = file_path.read_text(encoding="utf-8")
        entries = _parse_entries(text)

        found = False
        remaining: list[MemoryEntry] = []
        for e in entries:
            if e.pattern.lower() == pattern.lower() and not found:
                found = True
            else:
                remaining.append(e)

        if not found:
            return False

        # Rewrite file with remaining entries
        with open(file_path, "w", encoding="utf-8") as f:
            for e in remaining:
                section = _ENTRY_TEMPLATE.format(
                    pattern=e.pattern,
                    observed=e.observed,
                    domain=e.domain,
                    context=e.context,
                    rule=e.rule,
                )
                f.write(section)
                f.write("\n")

        return True
