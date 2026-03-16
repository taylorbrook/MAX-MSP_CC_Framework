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


class TestMergePreservesUserPositions:
    """Bug 1 fix: attribute-level merge preserves user-owned presentation attrs."""

    def test_user_patching_rect_preserved(self, tmp_path):
        """User moves a generator-owned box -> regenerate -> user position kept."""
        path = tmp_path / "test.maxpat"

        # Step 1: Initial generation
        p1 = Patcher()
        b1 = p1.add_box("cycle~", ["440"])
        merge_and_write(p1, path, validate=False)

        # Step 2: User moves the box to a new position in the .maxpat
        data = json.loads(path.read_text())
        gen_box = data["patcher"]["boxes"][0]["box"]
        user_position = [500.0, 300.0, gen_box["patching_rect"][2], gen_box["patching_rect"][3]]
        gen_box["patching_rect"] = user_position
        path.write_text(json.dumps(data, indent=2))

        # Step 3: Regenerate with updated text (cycle~ 880)
        p2 = Patcher()
        p2.add_box("cycle~", ["880"])
        merge_and_write(p2, path, validate=False)

        # Verify: user position preserved, text updated
        result = json.loads(path.read_text())
        result_box = result["patcher"]["boxes"][0]["box"]
        assert result_box["patching_rect"][0] == 500.0, "User's x position should be preserved"
        assert result_box["patching_rect"][1] == 300.0, "User's y position should be preserved"
        assert result_box["text"] == "cycle~ 880", "Generator text should be updated"

    def test_user_extra_attrs_preserved(self, tmp_path):
        """User sets bgcolor on a generator box -> regenerate -> bgcolor preserved."""
        path = tmp_path / "test.maxpat"

        # Step 1: Initial generation
        p1 = Patcher()
        p1.add_box("cycle~")
        merge_and_write(p1, path, validate=False)

        # Step 2: User adds bgcolor to the box
        data = json.loads(path.read_text())
        gen_box = data["patcher"]["boxes"][0]["box"]
        gen_box["bgcolor"] = [1.0, 0.0, 0.0, 1.0]
        path.write_text(json.dumps(data, indent=2))

        # Step 3: Regenerate
        p2 = Patcher()
        p2.add_box("cycle~")
        merge_and_write(p2, path, validate=False)

        # Verify: user's bgcolor preserved
        result = json.loads(path.read_text())
        result_box = result["patcher"]["boxes"][0]["box"]
        assert result_box.get("bgcolor") == [1.0, 0.0, 0.0, 1.0], "User's bgcolor should be preserved"

    def test_generator_text_updates_propagate(self, tmp_path):
        """Generator changes text -> text updated despite position preservation."""
        path = tmp_path / "test.maxpat"

        # Step 1: Initial generation
        p1 = Patcher()
        p1.add_box("cycle~", ["440"])
        merge_and_write(p1, path, validate=False)

        # Step 2: Regenerate with different text
        p2 = Patcher()
        p2.add_box("cycle~", ["880"])
        merge_and_write(p2, path, validate=False)

        result = json.loads(path.read_text())
        result_box = result["patcher"]["boxes"][0]["box"]
        assert result_box["text"] == "cycle~ 880"


class TestMergePreservesSubpatcherContent:
    """Bug 2 fix: recursive subpatcher content preservation."""

    def test_user_inner_objects_survive(self, tmp_path):
        """User adds objects inside a subpatcher -> regenerate -> objects survive."""
        path = tmp_path / "test.maxpat"

        # Step 1: Generate with a subpatcher
        p1 = Patcher()
        sp_box, sp = p1.add_subpatcher("mysub", inlets=1, outlets=1)
        merge_and_write(p1, path, validate=False)

        # Step 2: User adds an object inside the subpatcher in the .maxpat
        data = json.loads(path.read_text())
        sp_entry = None
        for b in data["patcher"]["boxes"]:
            if b["box"].get("id") == sp_box.id:
                sp_entry = b
                break
        assert sp_entry is not None, "Subpatcher box must exist"
        assert "patcher" in sp_entry["box"], "Subpatcher must have inner patcher"

        # Add a user object inside the subpatcher
        user_inner_box = {
            "box": {
                "maxclass": "newobj",
                "text": "print user-added",
                "id": "user-inner-1",
                "numinlets": 1,
                "numoutlets": 0,
                "outlettype": [],
                "patching_rect": [100.0, 150.0, 80.0, 22.0],
            }
        }
        sp_entry["box"]["patcher"]["boxes"].append(user_inner_box)
        path.write_text(json.dumps(data, indent=2))

        # Step 3: Regenerate
        p2 = Patcher()
        p2.add_subpatcher("mysub", inlets=1, outlets=1)
        merge_and_write(p2, path, validate=False)

        # Verify: user inner object survives
        result = json.loads(path.read_text())
        sp_result = None
        for b in result["patcher"]["boxes"]:
            if b["box"].get("id") == sp_box.id:
                sp_result = b
                break
        assert sp_result is not None
        inner_ids = [ib["box"]["id"] for ib in sp_result["box"]["patcher"]["boxes"]]
        assert "user-inner-1" in inner_ids, "User's inner object should survive regeneration"

    def test_existing_inner_patcher_preserved(self, tmp_path):
        """Subpatcher inner content from existing file preserved on regeneration."""
        path = tmp_path / "test.maxpat"

        # Step 1: Generate with subpatcher
        p1 = Patcher()
        sp_box, sp = p1.add_subpatcher("mysub", inlets=1, outlets=1)
        merge_and_write(p1, path, validate=False)

        # Step 2: User modifies a position inside the subpatcher
        data = json.loads(path.read_text())
        sp_entry = None
        for b in data["patcher"]["boxes"]:
            if b["box"].get("id") == sp_box.id:
                sp_entry = b
                break
        assert sp_entry is not None
        inner_boxes = sp_entry["box"]["patcher"]["boxes"]
        # Move the first inner box (inlet) to a new position
        if inner_boxes:
            inner_boxes[0]["box"]["patching_rect"] = [999.0, 888.0, 30.0, 22.0]
        path.write_text(json.dumps(data, indent=2))

        # Step 3: Regenerate
        p2 = Patcher()
        p2.add_subpatcher("mysub", inlets=1, outlets=1)
        merge_and_write(p2, path, validate=False)

        # Verify: inner positions preserved
        result = json.loads(path.read_text())
        sp_result = None
        for b in result["patcher"]["boxes"]:
            if b["box"].get("id") == sp_box.id:
                sp_result = b
                break
        assert sp_result is not None
        inner_first = sp_result["box"]["patcher"]["boxes"][0]["box"]
        assert inner_first["patching_rect"][0] == 999.0, "Inner box position should be preserved"


class TestMergeLayoutSkippedOnMerge:
    """Bug 3 fix: layout engine only runs on fresh writes, not merge runs."""

    def test_existing_positions_not_recomputed(self, tmp_path):
        """Merge runs preserve existing box positions (layout not recomputed)."""
        path = tmp_path / "test.maxpat"

        # Step 1: Initial generation
        p1 = Patcher()
        b1 = p1.add_box("cycle~", ["440"])
        b2 = p1.add_box("ezdac~")
        p1.add_connection(b1, 0, b2, 0)
        merge_and_write(p1, path, validate=False)

        # Step 2: Manually set known positions in the .maxpat
        data = json.loads(path.read_text())
        for box_entry in data["patcher"]["boxes"]:
            box_entry["box"]["patching_rect"] = [123.0, 456.0, 80.0, 22.0]
        path.write_text(json.dumps(data, indent=2))

        # Step 3: Regenerate (same content)
        p2 = Patcher()
        c1 = p2.add_box("cycle~", ["440"])
        c2 = p2.add_box("ezdac~")
        p2.add_connection(c1, 0, c2, 0)
        merge_and_write(p2, path, validate=False)

        # Verify: positions from step 2 are preserved, not recomputed
        result = json.loads(path.read_text())
        for box_entry in result["patcher"]["boxes"]:
            rect = box_entry["box"]["patching_rect"]
            assert rect[0] == 123.0, f"X should be preserved (got {rect[0]})"
            assert rect[1] == 456.0, f"Y should be preserved (got {rect[1]})"


class TestMergeFreshWriteStillLayouts:
    """Fresh write (no existing file) still calls apply_layout for proper positioning."""

    def test_fresh_write_positions_nonzero(self, tmp_path):
        """Fresh write produces laid-out positions (not all at 0,0)."""
        path = tmp_path / "test.maxpat"

        p = Patcher()
        b1 = p.add_box("cycle~", ["440"])
        b2 = p.add_box("ezdac~")
        p.add_connection(b1, 0, b2, 0)
        merge_and_write(p, path, validate=False)

        result = json.loads(path.read_text())
        boxes = result["patcher"]["boxes"]
        # At least one box should have non-zero position (layout was applied)
        positions = [b["box"]["patching_rect"][:2] for b in boxes]
        has_layout = any(x > 0 or y > 0 for x, y in positions)
        assert has_layout, "Fresh write should produce laid-out positions"
