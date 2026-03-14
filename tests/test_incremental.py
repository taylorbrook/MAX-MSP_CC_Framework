"""Tests for incremental patching: idempotency, user preservation, stale removal.

Covers the Manifest class for tracking generator-owned objects and the
merge_and_write function for merging generator changes into existing .maxpat
files while preserving user-added objects.
"""

import json

import pytest

from src.maxpat.patcher import Patcher, Box, Patchline
from src.maxpat.incremental import Manifest, load_existing_patch, merge_and_write


class TestManifestSidecarPath:
    """Manifest.sidecar_path() derives path from .maxpat path."""

    def test_sidecar_path_same_dir_same_stem(self, tmp_path):
        """Sidecar is same directory and stem + '.manifest.json'."""
        maxpat = tmp_path / "mypatch.maxpat"
        result = Manifest.sidecar_path(maxpat)
        assert result == tmp_path / "mypatch.manifest.json"

    def test_sidecar_path_nested_dir(self, tmp_path):
        """Works with nested directories."""
        maxpat = tmp_path / "sub" / "dir" / "patch.maxpat"
        result = Manifest.sidecar_path(maxpat)
        assert result == tmp_path / "sub" / "dir" / "patch.manifest.json"


class TestManifestSaveLoad:
    """Manifest.save() and Manifest.load() round-trip correctly."""

    def test_save_writes_json(self, tmp_path):
        """save() writes JSON with box_ids and connections."""
        path = tmp_path / "test.manifest.json"
        m = Manifest(
            box_ids=["obj-1", "obj-2"],
            connections=[("obj-1", 0, "obj-2", 0)],
        )
        m.save(path)
        data = json.loads(path.read_text())
        assert data["box_ids"] == ["obj-1", "obj-2"]
        assert data["connections"] == [["obj-1", 0, "obj-2", 0]]

    def test_load_reads_json(self, tmp_path):
        """load() reads saved manifest back."""
        path = tmp_path / "test.manifest.json"
        m = Manifest(
            box_ids=["obj-1", "obj-3"],
            connections=[("obj-1", 0, "obj-3", 1)],
        )
        m.save(path)
        loaded = Manifest.load(path)
        assert loaded.box_ids == ["obj-1", "obj-3"]
        assert loaded.connections == [("obj-1", 0, "obj-3", 1)]

    def test_load_missing_file_returns_empty(self, tmp_path):
        """load() returns empty manifest if file missing."""
        path = tmp_path / "nonexistent.manifest.json"
        loaded = Manifest.load(path)
        assert loaded.box_ids == []
        assert loaded.connections == []


class TestManifestFromPatcher:
    """Manifest.from_patcher() extracts IDs and connections from Patcher."""

    def test_from_patcher_box_ids(self):
        """Extracts all box IDs."""
        p = Patcher()
        b1 = p.add_box("cycle~")
        b2 = p.add_box("ezdac~")
        m = Manifest.from_patcher(p)
        assert b1.id in m.box_ids
        assert b2.id in m.box_ids

    def test_from_patcher_connections(self):
        """Extracts connection tuples."""
        p = Patcher()
        b1 = p.add_box("cycle~")
        b2 = p.add_box("ezdac~")
        p.add_connection(b1, 0, b2, 0)
        m = Manifest.from_patcher(p)
        assert (b1.id, 0, b2.id, 0) in m.connections


class TestLoadExistingPatch:
    """load_existing_patch() reads .maxpat JSON or returns None."""

    def test_load_returns_dict(self, tmp_path):
        """Returns parsed JSON dict for existing file."""
        path = tmp_path / "test.maxpat"
        data = {"patcher": {"boxes": [], "lines": []}}
        path.write_text(json.dumps(data))
        result = load_existing_patch(path)
        assert result == data

    def test_load_missing_returns_none(self, tmp_path):
        """Returns None for missing file."""
        path = tmp_path / "nonexistent.maxpat"
        result = load_existing_patch(path)
        assert result is None


class TestMergeAndWriteFresh:
    """merge_and_write() with no existing file produces same output as write_patch."""

    def test_fresh_write_creates_maxpat(self, tmp_path):
        """Fresh merge creates .maxpat file."""
        path = tmp_path / "test.maxpat"
        p = Patcher()
        p.add_box("cycle~")
        merge_and_write(p, path, validate=False)
        assert path.exists()

    def test_fresh_write_creates_manifest(self, tmp_path):
        """Fresh merge creates manifest sidecar."""
        path = tmp_path / "test.maxpat"
        p = Patcher()
        p.add_box("cycle~")
        merge_and_write(p, path, validate=False)
        manifest_path = Manifest.sidecar_path(path)
        assert manifest_path.exists()

    def test_fresh_write_matches_write_patch(self, tmp_path):
        """Fresh merge output matches what write_patch would produce."""
        from src.maxpat.hooks import write_patch

        path_merge = tmp_path / "merge.maxpat"
        path_write = tmp_path / "write.maxpat"

        p1 = Patcher()
        b1 = p1.add_box("cycle~")
        b2 = p1.add_box("ezdac~")
        p1.add_connection(b1, 0, b2, 0)

        p2 = Patcher()
        b3 = p2.add_box("cycle~")
        b4 = p2.add_box("ezdac~")
        p2.add_connection(b3, 0, b4, 0)

        merge_and_write(p1, path_merge, validate=False)
        write_patch(p2, path_write, validate=False)

        merge_data = json.loads(path_merge.read_text())
        write_data = json.loads(path_write.read_text())

        # Box count should match
        assert len(merge_data["patcher"]["boxes"]) == len(write_data["patcher"]["boxes"])
        # Line count should match
        assert len(merge_data["patcher"]["lines"]) == len(write_data["patcher"]["lines"])


class TestMergePreservesUserBoxes:
    """merge_and_write() preserves user-added boxes from existing patch."""

    def test_user_boxes_preserved(self, tmp_path):
        """User-added boxes survive regeneration."""
        path = tmp_path / "test.maxpat"

        # Step 1: Initial generation
        p1 = Patcher()
        b1 = p1.add_box("cycle~")
        merge_and_write(p1, path, validate=False)

        # Step 2: Simulate user adding a box by editing the .maxpat directly
        data = json.loads(path.read_text())
        user_box = {
            "box": {
                "maxclass": "comment",
                "text": "I added this",
                "id": "user-obj-99",
                "numinlets": 1,
                "numoutlets": 0,
                "outlettype": [],
                "patching_rect": [300.0, 300.0, 100.0, 22.0],
            }
        }
        data["patcher"]["boxes"].append(user_box)
        path.write_text(json.dumps(data, indent=2))

        # Step 3: Regenerate with same patcher
        p2 = Patcher()
        p2.add_box("cycle~")
        merge_and_write(p2, path, validate=False)

        # Verify user box is still there
        result = json.loads(path.read_text())
        box_ids = [b["box"]["id"] for b in result["patcher"]["boxes"]]
        assert "user-obj-99" in box_ids


class TestMergeRemovesStalBoxes:
    """merge_and_write() removes boxes deleted from generator."""

    def test_stale_boxes_removed(self, tmp_path):
        """Boxes removed from generator are removed from .maxpat."""
        path = tmp_path / "test.maxpat"

        # Step 1: Generate with 2 boxes
        p1 = Patcher()
        b1 = p1.add_box("cycle~")
        b2 = p1.add_box("ezdac~")
        p1.add_connection(b1, 0, b2, 0)
        merge_and_write(p1, path, validate=False)

        # Capture box IDs from first gen
        first_data = json.loads(path.read_text())
        first_ids = [b["box"]["id"] for b in first_data["patcher"]["boxes"]]
        assert len(first_ids) == 2

        # Step 2: Regenerate with only 1 box (removed ezdac~)
        p2 = Patcher()
        p2.add_box("cycle~")
        merge_and_write(p2, path, validate=False)

        # Verify only 1 box remains
        result = json.loads(path.read_text())
        result_ids = [b["box"]["id"] for b in result["patcher"]["boxes"]]
        assert len(result_ids) == 1


class TestMergeOverwritesManifestBoxes:
    """merge_and_write() overwrites generator-owned boxes with new versions."""

    def test_manifest_boxes_overwritten(self, tmp_path):
        """Generator-owned boxes are replaced by new patcher's version."""
        path = tmp_path / "test.maxpat"

        # Step 1: Generate with cycle~ 440
        p1 = Patcher()
        b1 = p1.add_box("cycle~", ["440"])
        merge_and_write(p1, path, validate=False)

        # Step 2: Regenerate with cycle~ 880 (updated args)
        p2 = Patcher()
        b2 = p2.add_box("cycle~", ["880"])
        merge_and_write(p2, path, validate=False)

        result = json.loads(path.read_text())
        texts = [b["box"].get("text", "") for b in result["patcher"]["boxes"]]
        assert "cycle~ 880" in texts
        assert "cycle~ 440" not in texts


class TestMergePreservesUserConnections:
    """merge_and_write() preserves user-added connections."""

    def test_user_connections_preserved(self, tmp_path):
        """User connections survive regeneration."""
        path = tmp_path / "test.maxpat"

        # Step 1: Initial generation
        p1 = Patcher()
        b1 = p1.add_box("cycle~")
        b2 = p1.add_box("ezdac~")
        p1.add_connection(b1, 0, b2, 0)
        merge_and_write(p1, path, validate=False)

        # Step 2: Simulate user adding a connection
        data = json.loads(path.read_text())
        # Add a user box and connection
        user_box = {
            "box": {
                "maxclass": "newobj",
                "text": "*~ 0.5",
                "id": "user-obj-50",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["signal"],
                "patching_rect": [200.0, 200.0, 50.0, 22.0],
            }
        }
        user_conn = {
            "patchline": {
                "source": ["user-obj-50", 0],
                "destination": [b2.id, 1],
                "order": 0,
            }
        }
        data["patcher"]["boxes"].append(user_box)
        data["patcher"]["lines"].append(user_conn)
        path.write_text(json.dumps(data, indent=2))

        # Step 3: Regenerate
        p2 = Patcher()
        c1 = p2.add_box("cycle~")
        c2 = p2.add_box("ezdac~")
        p2.add_connection(c1, 0, c2, 0)
        merge_and_write(p2, path, validate=False)

        # Verify user connection and box are still there
        result = json.loads(path.read_text())
        box_ids = [b["box"]["id"] for b in result["patcher"]["boxes"]]
        assert "user-obj-50" in box_ids

        conn_sources = [
            (l["patchline"]["source"][0], l["patchline"]["source"][1])
            for l in result["patcher"]["lines"]
        ]
        assert ("user-obj-50", 0) in conn_sources


class TestMergeIdempotency:
    """merge_and_write() is idempotent (running twice = same output)."""

    def test_idempotent_output(self, tmp_path):
        """Running merge_and_write twice produces same .maxpat."""
        path = tmp_path / "test.maxpat"

        # Run 1
        p1 = Patcher()
        b1 = p1.add_box("cycle~", ["440"])
        b2 = p1.add_box("ezdac~")
        p1.add_connection(b1, 0, b2, 0)
        merge_and_write(p1, path, validate=False)
        run1 = path.read_text()

        # Run 2
        p2 = Patcher()
        b3 = p2.add_box("cycle~", ["440"])
        b4 = p2.add_box("ezdac~")
        p2.add_connection(b3, 0, b4, 0)
        merge_and_write(p2, path, validate=False)
        run2 = path.read_text()

        assert run1 == run2

    def test_idempotent_manifest(self, tmp_path):
        """Running merge_and_write twice produces same manifest."""
        path = tmp_path / "test.maxpat"
        manifest_path = Manifest.sidecar_path(path)

        # Run 1
        p1 = Patcher()
        p1.add_box("cycle~")
        merge_and_write(p1, path, validate=False)
        run1_manifest = manifest_path.read_text()

        # Run 2
        p2 = Patcher()
        p2.add_box("cycle~")
        merge_and_write(p2, path, validate=False)
        run2_manifest = manifest_path.read_text()

        assert run1_manifest == run2_manifest
