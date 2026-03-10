"""Tests for persistent memory system -- MemoryStore read/write/list/delete operations."""

from __future__ import annotations

from pathlib import Path

import pytest

from src.maxpat.memory import MemoryEntry, MemoryStore


# --- Task 1: Basic CRUD operations ---


class TestMemoryEntryFields:
    """MemoryEntry has all required fields."""

    def test_fields_present(self):
        entry = MemoryEntry(
            pattern="prefer line~ for gain",
            domain="dsp",
            observed="2026-03-10",
            context="User corrected *~ to line~ -> *~",
            rule="Use line~ for smooth gain transitions",
        )
        assert entry.pattern == "prefer line~ for gain"
        assert entry.domain == "dsp"
        assert entry.observed == "2026-03-10"
        assert entry.context == "User corrected *~ to line~ -> *~"
        assert entry.rule == "Use line~ for smooth gain transitions"


class TestGlobalStoreWrite:
    """Global store writes to ~/.claude/max-memory/{domain}/patterns.md."""

    def test_write_creates_file(self, tmp_path: Path):
        store = MemoryStore(scope="global", base_dir=tmp_path)
        entry = MemoryEntry(
            pattern="prefer line~ for gain",
            domain="dsp",
            observed="2026-03-10",
            context="Multiple patches used line~",
            rule="Use line~ for smooth gain transitions",
        )
        result = store.write(entry)
        assert result is True
        file_path = tmp_path / "dsp" / "patterns.md"
        assert file_path.exists()
        content = file_path.read_text()
        assert "## Pattern: prefer line~ for gain" in content
        assert "**Observed:** 2026-03-10" in content
        assert "**Domain:** dsp" in content
        assert "**Context:** Multiple patches used line~" in content
        assert "**Rule:** Use line~ for smooth gain transitions" in content

    def test_write_appends_to_existing(self, tmp_path: Path):
        store = MemoryStore(scope="global", base_dir=tmp_path)
        entry_a = MemoryEntry(
            pattern="prefer line~ for gain",
            domain="dsp",
            observed="2026-03-10",
            context="Context A",
            rule="Rule A",
        )
        entry_b = MemoryEntry(
            pattern="always include meter~",
            domain="dsp",
            observed="2026-03-10",
            context="Context B",
            rule="Rule B",
        )
        store.write(entry_a)
        store.write(entry_b)
        file_path = tmp_path / "dsp" / "patterns.md"
        content = file_path.read_text()
        assert "## Pattern: prefer line~ for gain" in content
        assert "## Pattern: always include meter~" in content


class TestProjectStoreWrite:
    """Project store writes to {project_dir}/.max-memory/patterns.md."""

    def test_write_creates_file_in_project(self, tmp_path: Path):
        project_dir = tmp_path / "my-synth"
        project_dir.mkdir()
        store = MemoryStore(scope="project", project_dir=project_dir)
        entry = MemoryEntry(
            pattern="use filter envelope",
            domain="dsp",
            observed="2026-03-10",
            context="Project-specific pattern",
            rule="Apply filter env to all subtractive patches",
        )
        result = store.write(entry)
        assert result is True
        file_path = project_dir / ".max-memory" / "patterns.md"
        assert file_path.exists()
        content = file_path.read_text()
        assert "## Pattern: use filter envelope" in content


class TestStoreRead:
    """store.read() returns written entries as MemoryEntry objects."""

    def test_read_returns_entries(self, tmp_path: Path):
        store = MemoryStore(scope="global", base_dir=tmp_path)
        entry = MemoryEntry(
            pattern="prefer line~ for gain",
            domain="dsp",
            observed="2026-03-10",
            context="Multiple patches",
            rule="Use line~ for smooth transitions",
        )
        store.write(entry)
        entries = store.read(domain="dsp")
        assert len(entries) == 1
        assert entries[0].pattern == "prefer line~ for gain"
        assert entries[0].domain == "dsp"
        assert entries[0].observed == "2026-03-10"
        assert entries[0].context == "Multiple patches"
        assert entries[0].rule == "Use line~ for smooth transitions"

    def test_read_with_domain_filter(self, tmp_path: Path):
        store = MemoryStore(scope="global", base_dir=tmp_path)
        dsp_entry = MemoryEntry(
            pattern="dsp pattern",
            domain="dsp",
            observed="2026-03-10",
            context="DSP context",
            rule="DSP rule",
        )
        ui_entry = MemoryEntry(
            pattern="ui pattern",
            domain="ui",
            observed="2026-03-10",
            context="UI context",
            rule="UI rule",
        )
        store.write(dsp_entry)
        store.write(ui_entry)
        dsp_entries = store.read(domain="dsp")
        assert len(dsp_entries) == 1
        assert dsp_entries[0].pattern == "dsp pattern"
        ui_entries = store.read(domain="ui")
        assert len(ui_entries) == 1
        assert ui_entries[0].pattern == "ui pattern"

    def test_read_all_domains(self, tmp_path: Path):
        store = MemoryStore(scope="global", base_dir=tmp_path)
        store.write(MemoryEntry("p1", "dsp", "2026-03-10", "c1", "r1"))
        store.write(MemoryEntry("p2", "ui", "2026-03-10", "c2", "r2"))
        all_entries = store.read()
        assert len(all_entries) == 2

    def test_read_empty_returns_empty_list(self, tmp_path: Path):
        store = MemoryStore(scope="global", base_dir=tmp_path)
        entries = store.read(domain="nonexistent")
        assert entries == []

    def test_read_project_store(self, tmp_path: Path):
        project_dir = tmp_path / "proj"
        project_dir.mkdir()
        store = MemoryStore(scope="project", project_dir=project_dir)
        store.write(MemoryEntry("p1", "dsp", "2026-03-10", "c1", "r1"))
        store.write(MemoryEntry("p2", "ui", "2026-03-10", "c2", "r2"))
        # Project store is flat -- all entries in one file
        all_entries = store.read()
        assert len(all_entries) == 2
        # Domain filter still works
        dsp_entries = store.read(domain="dsp")
        assert len(dsp_entries) == 1


class TestListDomains:
    """store.list_domains() returns unique domain names."""

    def test_list_domains(self, tmp_path: Path):
        store = MemoryStore(scope="global", base_dir=tmp_path)
        store.write(MemoryEntry("p1", "dsp", "2026-03-10", "c1", "r1"))
        store.write(MemoryEntry("p2", "ui", "2026-03-10", "c2", "r2"))
        store.write(MemoryEntry("p3", "dsp", "2026-03-10", "c3", "r3"))
        domains = store.list_domains()
        assert sorted(domains) == ["dsp", "ui"]

    def test_list_domains_empty(self, tmp_path: Path):
        store = MemoryStore(scope="global", base_dir=tmp_path)
        domains = store.list_domains()
        assert domains == []

    def test_list_domains_project(self, tmp_path: Path):
        project_dir = tmp_path / "proj"
        project_dir.mkdir()
        store = MemoryStore(scope="project", project_dir=project_dir)
        store.write(MemoryEntry("p1", "dsp", "2026-03-10", "c1", "r1"))
        store.write(MemoryEntry("p2", "ui", "2026-03-10", "c2", "r2"))
        domains = store.list_domains()
        assert sorted(domains) == ["dsp", "ui"]


class TestDelete:
    """store.delete() removes a specific entry by pattern name."""

    def test_delete_removes_entry(self, tmp_path: Path):
        store = MemoryStore(scope="global", base_dir=tmp_path)
        store.write(MemoryEntry("p1", "dsp", "2026-03-10", "c1", "r1"))
        store.write(MemoryEntry("p2", "dsp", "2026-03-10", "c2", "r2"))
        result = store.delete("p1", domain="dsp")
        assert result is True
        entries = store.read(domain="dsp")
        assert len(entries) == 1
        assert entries[0].pattern == "p2"

    def test_delete_nonexistent_returns_false(self, tmp_path: Path):
        store = MemoryStore(scope="global", base_dir=tmp_path)
        result = store.delete("nonexistent", domain="dsp")
        assert result is False

    def test_delete_project_store(self, tmp_path: Path):
        project_dir = tmp_path / "proj"
        project_dir.mkdir()
        store = MemoryStore(scope="project", project_dir=project_dir)
        store.write(MemoryEntry("p1", "dsp", "2026-03-10", "c1", "r1"))
        store.write(MemoryEntry("p2", "ui", "2026-03-10", "c2", "r2"))
        result = store.delete("p1", domain="dsp")
        assert result is True
        entries = store.read()
        assert len(entries) == 1
        assert entries[0].pattern == "p2"


class TestDirectoryCreation:
    """Files created automatically if directories don't exist."""

    def test_write_creates_nested_dirs(self, tmp_path: Path):
        base = tmp_path / "deep" / "nested"
        store = MemoryStore(scope="global", base_dir=base)
        entry = MemoryEntry("p1", "dsp", "2026-03-10", "c1", "r1")
        store.write(entry)
        assert (base / "dsp" / "patterns.md").exists()


# --- Task 2: Deduplication on write ---


class TestDeduplication:
    """Writing duplicate entries is prevented by domain + pattern name (case-insensitive)."""

    def test_exact_duplicate_returns_false(self, tmp_path: Path):
        """Writing same pattern+domain twice returns False on second write."""
        store = MemoryStore(scope="global", base_dir=tmp_path)
        entry = MemoryEntry(
            pattern="prefer line~ for gain",
            domain="dsp",
            observed="2026-03-10",
            context="Context A",
            rule="Rule A",
        )
        result1 = store.write(entry)
        result2 = store.write(entry)
        assert result1 is True
        assert result2 is False
        # File should have only one entry
        entries = store.read(domain="dsp")
        assert len(entries) == 1

    def test_different_pattern_same_domain_succeeds(self, tmp_path: Path):
        """Different pattern name in same domain succeeds."""
        store = MemoryStore(scope="global", base_dir=tmp_path)
        entry_a = MemoryEntry("prefer line~ for gain", "dsp", "2026-03-10", "c1", "r1")
        entry_b = MemoryEntry("always include meter~", "dsp", "2026-03-10", "c2", "r2")
        assert store.write(entry_a) is True
        assert store.write(entry_b) is True
        entries = store.read(domain="dsp")
        assert len(entries) == 2

    def test_same_pattern_different_domain_succeeds(self, tmp_path: Path):
        """Same pattern name in different domain succeeds (different scope)."""
        store = MemoryStore(scope="global", base_dir=tmp_path)
        entry_dsp = MemoryEntry("prefer line~ for gain", "dsp", "2026-03-10", "c1", "r1")
        entry_ui = MemoryEntry("prefer line~ for gain", "ui", "2026-03-10", "c2", "r2")
        assert store.write(entry_dsp) is True
        assert store.write(entry_ui) is True
        assert len(store.read(domain="dsp")) == 1
        assert len(store.read(domain="ui")) == 1

    def test_case_insensitive_dedup(self, tmp_path: Path):
        """Dedup is case-insensitive on pattern name."""
        store = MemoryStore(scope="global", base_dir=tmp_path)
        entry1 = MemoryEntry("Prefer Line~", "dsp", "2026-03-10", "c1", "r1")
        entry2 = MemoryEntry("prefer line~", "dsp", "2026-03-10", "c2", "r2")
        assert store.write(entry1) is True
        assert store.write(entry2) is False
        entries = store.read(domain="dsp")
        assert len(entries) == 1
        # Original casing preserved
        assert entries[0].pattern == "Prefer Line~"

    def test_after_dedup_read_returns_unique(self, tmp_path: Path):
        """After dedup write attempts, read() returns only unique entries."""
        store = MemoryStore(scope="global", base_dir=tmp_path)
        store.write(MemoryEntry("p1", "dsp", "2026-03-10", "c1", "r1"))
        store.write(MemoryEntry("p1", "dsp", "2026-03-10", "c2", "r2"))  # dedup
        store.write(MemoryEntry("p2", "dsp", "2026-03-10", "c3", "r3"))
        store.write(MemoryEntry("p2", "dsp", "2026-03-10", "c4", "r4"))  # dedup
        entries = store.read(domain="dsp")
        assert len(entries) == 2
        patterns = [e.pattern for e in entries]
        assert "p1" in patterns
        assert "p2" in patterns

    def test_dedup_project_scope(self, tmp_path: Path):
        """Dedup works in project scope too."""
        project_dir = tmp_path / "proj"
        project_dir.mkdir()
        store = MemoryStore(scope="project", project_dir=project_dir)
        assert store.write(MemoryEntry("p1", "dsp", "2026-03-10", "c1", "r1")) is True
        assert store.write(MemoryEntry("p1", "dsp", "2026-03-10", "c2", "r2")) is False
        entries = store.read()
        assert len(entries) == 1
