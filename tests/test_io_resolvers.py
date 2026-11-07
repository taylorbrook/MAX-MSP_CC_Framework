"""quick-261013-cyg (Q10): argument-dependent I/O counts match MAX (C1, S6).

Every ``MAX_SAVED`` row is a box MAX itself serialized -- a help patch or
example shipped in the Max 9.2.0 bundle or an installed package -- with the
``(numinlets, numoutlets)`` MAX saved. The citation names the file and the
box text. Rows whose citation says "refpage" have no MAX-saved box and come
from the object's maxref XML; SUMMARY flags them for confirmation in MAX.

Test hygiene:

* Everything except ``TestOracleTargets`` uses only the repo DB (runs in CI
  without Max on Python 3.10 and 3.12).
* ``TestOracleTargets`` (``requires_max``) runs the live help-io oracle and
  asserts every name in :data:`Q10_TARGETS` has 0 count mismatches in the
  bundle.
* Tests never write to the repo; tmp_path only.
"""

from __future__ import annotations

import json
import warnings
from pathlib import Path

import pytest

import tools.audit_db as audit_db
from src.maxpat.db_lookup import SUPPORTED_IO_FORMULAS, ObjectDatabase
from src.maxpat.io_resolvers import (
    IO_RESOLVERS,
    box_args,
    normalize_args,
    split_box_text,
)
from src.maxpat.patcher import Patcher
from tests.conftest import MAX_APP_PATH
from tools import help_io

REPO_ROOT = Path(__file__).resolve().parent.parent
BASELINE = REPO_ROOT / "tests" / "fixtures" / "help_io_baseline.json"

# Names (literal box names, as the oracle keys them) that Q10 fixes. The live
# oracle must report 0 count mismatches for each of them in the bundle.
Q10_TARGETS = (
    "r", "receive", "t",
    "sel", "select", "route", "routepass", "expr", "vexpr", "if", "sprintf",
    "pipe", "notein", "ctlin",
    "pack", "pak", "unpack", "trigger", "combine", "switch", "unjoin", "gate~",
    "bucket", "buddy", "b", "bangbang", "groove~", "tapout~", "record~",
    "jit.pack", "jit.unpack", "mc.route", "matrix~", "mc.matrix~", "play~",
)

LCD = '"LCD Text / Icon (Inactive)"'
LCD_PRESPLIT = ['"LCD', "Text", "/", "Icon", '(Inactive)"']


@pytest.fixture(scope="module")
def db() -> ObjectDatabase:
    with warnings.catch_warnings():
        warnings.simplefilter("ignore")
        return ObjectDatabase()


# ── Tokenizer ─────────────────────────────────────────────────────


class TestSplitBoxText:
    def test_quotes_group_and_are_kept(self) -> None:
        assert split_box_text('t "a b" c') == ["t", '"a b"', "c"]

    def test_escaped_space_does_not_split(self) -> None:
        assert split_box_text("x\\ y z") == ["x\\ y", "z"]

    def test_escaped_commas_stay_in_one_token(self) -> None:
        assert split_box_text("expr store(tab3[-1]\\,$i1\\,$i2)") == [
            "expr", "store(tab3[-1]\\,$i1\\,$i2)",
        ]

    def test_escaped_quote_does_not_toggle(self) -> None:
        assert split_box_text('a \\"b c') == ["a", '\\"b', "c"]

    def test_unbalanced_quote_runs_to_end(self) -> None:
        assert split_box_text('"unclosed a b') == ['"unclosed a b']

    def test_trailing_backslash_kept(self) -> None:
        assert split_box_text("a b\\") == ["a", "b\\"]

    @pytest.mark.parametrize("text", ["", "   ", "\t\n"])
    def test_empty(self, text: str) -> None:
        assert split_box_text(text) == []

    def test_tabs_and_newlines_split(self) -> None:
        assert split_box_text("a\tb\nc  d") == ["a", "b", "c", "d"]

    def test_never_raises_on_odd_input(self) -> None:
        assert split_box_text(None) == []  # type: ignore[arg-type]
        assert split_box_text('"' * 7 + "\\") == ['"' * 7 + "\\"]
        assert len(split_box_text("a " * 10000)) == 10000


class TestBoxArgs:
    def test_attributes_stop_args(self) -> None:
        assert box_args("gate~ 3 @ramptime 100") == ("gate~", ["3"])

    def test_quoted_arg_is_one_token(self) -> None:
        assert box_args('route "A B" c') == ("route", ['"A B"', "c"])

    def test_empty(self) -> None:
        assert box_args("") == ("", [])
        assert box_args("   ") == ("", [])

    def test_help_io_delegates(self) -> None:
        for text in ('t "a b" c', "gate~ 3 @ramptime 100", "", "x\\ y z"):
            assert help_io.box_args(text) == box_args(text)
        assert help_io.box_args(f"t {LCD}") == ("t", [LCD])


class TestNormalizeArgs:
    def test_presplit_and_quoted_agree(self) -> None:
        assert normalize_args(LCD_PRESPLIT) == [LCD]
        assert normalize_args([LCD]) == [LCD]

    def test_attributes_dropped(self) -> None:
        assert normalize_args(["sound", "74", "@triggers", "1"]) == ["sound", "74"]

    def test_non_str_elements(self) -> None:
        assert normalize_args([1, 2.5, "x"]) == ["1", "2.5", "x"]

    def test_none(self) -> None:
        assert normalize_args(None) == []
        assert normalize_args([]) == []


# ── MAX-saved counts ──────────────────────────────────────────────

# (name, args, expected (numinlets, numoutlets), citation)
MAX_SAVED = [
    # Task 1: receive, quote-aware trigger
    ("r", ["todrive"], (0, 1), "C74/help/jitter/jit.anim.drive.maxhelp `r todrive`"),
    ("receive", ["bem"], (0, 1), "C74/help/max/forward.maxhelp `receive bem`"),
    ("receive", [], (1, 1), "C74/help/max/receive.maxhelp `receive`"),
    ("t", [LCD], (1, 1), f"C74/help/m4l/live.routing.maxhelp `t {LCD}`"),
    ("t", LCD_PRESPLIT, (1, 1), f"C74/help/m4l/live.routing.maxhelp `t {LCD}` (pre-split)"),
    # Task 2: select family (N args -> N+1 inlets and outlets)
    ("sel", [], (2, 2), "C74/help/jitter/jit.playlist.maxhelp `sel`"),
    ("sel", ["0", "1"], (3, 3), "C74/extras/JitterTester.maxpat `sel 0 1`"),
    ("select", list("1234567"), (8, 8),
     "C74/packages/Vizzie/help/vz.1easemappr.maxhelp `select 1 2 3 4 5 6 7`"),
    ("route", ["point"], (2, 2), "C74/help/jitter/jit.anim.path.maxhelp `route point`"),
    ("route", ["time", "transport"], (3, 3), "C74/help/jitter/jit.avc.maxhelp `route time transport`"),
    ("route", ['"Control Border"', '"Text / Icon"', '"Slider Range Value"'], (4, 4),
     'C74/help/m4l/live.colors.maxhelp `route "Control Border" "Text / Icon" "Slider Range Value"`'),
    ("route", '"Control Border" "Text / Icon" "Slider Range Value"'.split(), (4, 4),
     "C74/help/m4l/live.colors.maxhelp (pre-split)"),
    ("routepass", ["0", "1"], (3, 3), "C74/help/jitter/jit.displays.maxhelp `routepass 0 1`"),
    ("route", [], (2, 2), "refpage route.maxref.xml: no argument -> one other outlet (0)"),
    ("routepass", [], (2, 2), "refpage routepass.maxref.xml: no argument -> one other outlet (0)"),
    # Task 2: expr / vexpr (highest $ index)
    ("expr", ["$i3", "*", "$i1", "+", "$i2"], (3, 1), "C74/help/max/expr.maxhelp `expr $i3 * $i1 + $i2`"),
    ("expr", ["$i2", "+", "11"], (2, 1), "FluidCorpusManipulation/help/fluid.bufnmf~.maxhelp `expr $i2 + 11`"),
    ("expr", ["sin", "(2.", "*", "3.141593", "*", "$f1)"], (1, 1), "bundle `expr sin (2. * 3.141593 * $f1)`"),
    ("expr", ["$i1", "+", "$i2", "+", "$i3"], (3, 1), "review C1: `expr $i1 + $i2 + $i3` (was 5 inlets)"),
    ("vexpr", ["$f1*($f3-$f2)+$f2", "@scalarmode", "1"], (3, 1),
     "C74/packages/BEAP/Examples/Synthesis Examples/Resynthesis.maxpat `vexpr $f1*($f3-$f2)+$f2 @scalarmode 1`"),
    ("vexpr", ["int($f1", "*", "255)"], (1, 1), "C74/help/m4l/live.colors.maxhelp `vexpr int($f1 * 255)`"),
    ("expr", ['"no dollars here"'], (1, 1), "edge: no $ index -> 1 inlet"),
    # Task 2: if
    ("if", "$i1 < 8 then bang else out2 bang".split(), (1, 2),
     "C74/help/jitter/jit.avc.maxhelp `if $i1 < 8 then bang else out2 bang`"),
    ("if", "$i3 == 1 then $f1 $f2 else out2 bang".split(), (3, 2),
     "C74/help/max/nodes.maxhelp `if $i3 == 1 then $f1 $f2 else out2 bang`"),
    ("if", "$i2 == 1 then $i1".split(), (2, 1), "C74/help/jitter/jit.displays.maxhelp `if $i2 == 1 then $i1`"),
    # Task 2: sprintf (one inlet per changeable specifier)
    ("sprintf", "%d - %d x %d\\, %d bit\\, %dHz %s".split(), (6, 1),
     "C74/help/jitter/jit.displays.maxhelp `sprintf %d - %d x %d\\, %d bit\\, %dHz %s`"),
    ("sprintf", ["symout", "%s%s"], (2, 1), "C74/help/max/sprintf.maxhelp `sprintf symout %s%s`"),
    ("sprintf", ["%ld", "34", "%ld", "555"], (2, 1), "C74/help/max/sprintf.maxhelp `sprintf %ld 34 %ld 555`"),
    ("sprintf", ["%c%c%c%c"], (4, 1), "C74/help/max/sprintf.maxhelp `sprintf %c%c%c%c`"),
    ("sprintf", [], (1, 1), "edge: no format -> 1 inlet"),
    ("sprintf", ["100%%"], (1, 1), "edge: literal %% is not a specifier"),
    # Task 2: pipe (final arg is the delay time)
    ("pipe", ["0", "0", "1000"], (3, 2), "C74/help/max/pipe.maxhelp `pipe 0 0 1000`"),
    ("pipe", ["0.", "0.", "0.", "2000"], (4, 3), "C74/help/max/pipe.maxhelp `pipe 0. 0. 0. 2000`"),
    ("pipe", ["500"], (2, 1), "C74/help/max/pipe.maxhelp `pipe 500`"),
    ("pipe", ["0"] * 12 + ["500"], (13, 12), "bundle `pipe 0 0 0 0 0 0 0 0 0 0 0 0 500`"),
    ("pipe", [], (2, 1), "edge: bare pipe = DB default"),
    # Task 2: notein (a channel arg drops the channel outlet)
    ("notein", [], (1, 3), "C74/extras/MIDItester.maxpat `notein`"),
    ("notein", ["a"], (1, 3), "C74/help/max/bendin.maxhelp `notein a`"),
    ("notein", ["17"], (1, 2), "C74/help/max/bendin.maxhelp `notein 17`"),
    ("notein", ["b", "6"], (1, 2), "C74/help/max/bendin.maxhelp `notein b 6`"),
    ("notein", ['"Sensel Morph"'], (1, 3), "edge: a quoted port name is not a channel"),
    # Task 2: ctlin (a controller arg and a channel arg each drop an outlet)
    ("ctlin", [], (1, 3), "C74/extras/MIDItester.maxpat `ctlin`"),
    ("ctlin", ["7"], (1, 2), "C74/help/max/linedrive.maxhelp `ctlin 7`"),
    ("ctlin", ["33", "1"], (1, 1), "C74/help/max/ctlin.maxhelp `ctlin 33 1`"),
    ("ctlin", ["-1", "4"], (1, 2), "C74/help/max/ctlin.maxhelp `ctlin -1 4`"),
    ("ctlin", ["a", "1"], (1, 2), "C74/help/max/ctlin.maxhelp `ctlin a 1`"),
    ("ctlin", ["none"], (1, 3), "edge: a non-numeric port name only"),
    # Task 3: bare pack/pak/unpack/trigger/combine use the defaults
    ("pack", [], (2, 1), "C74/extras/KeyMidi.maxpat `pack`"),
    ("pak", [], (2, 1), "C74/help/m4l/live.push.maxhelp `pak`"),
    ("pak", ["0", "0", "0"], (3, 1), "C74/help/max/jit.cellblock.maxhelp `pak 0 0 0`"),
    ("unpack", [], (1, 2), "C74/extras/GlobalTransport.maxpat `unpack`"),
    ("trigger", [], (1, 2), "refpage trigger.maxref.xml: no arguments -> two outlets"),
    ("t", [], (1, 2), "refpage trigger.maxref.xml: no arguments -> two outlets"),
    ("combine", ["sound", "74", "@triggers", "1"], (2, 2),
     "C74/help/max/combine.maxhelp `combine sound 74 @triggers 1`"),
    ("combine", [], (1, 2), "dada/help/dada.machines.maxhelp `combine`"),
    ("combine", ["e", "i"], (2, 2), "abclib help `combine e i`"),
    # Task 3: switch / unjoin
    ("switch", [], (3, 1), "C74/help/max/switch.maxhelp `switch`"),
    ("switch", ["3"], (4, 1), "C74/help/jitter/jit.keyscreen.maxhelp `switch 3`"),
    ("unjoin", [], (1, 3), "C74/help/jitter/jit.playlist.maxhelp `unjoin`"),
    ("unjoin", ["4"], (1, 5), "C74/help/msp/plot~.maxhelp `unjoin 4`"),
    # Task 3: one port per argument
    ("gate~", ["3", "@ramptime", "100"], (2, 3), "C74/help/msp/gate~.maxhelp `gate~ 3 @ramptime 100`"),
    ("gate~", ["5", "2"], (2, 5), "C74/help/max/crosspatch.maxhelp `gate~ 5 2`"),
    ("gate~", [], (2, 1), "C74/help/msp/freqshift~.maxhelp `gate~`"),
    ("bucket", [], (1, 1), "C74/help/max/anal.maxhelp `bucket`"),
    ("bucket", ["4", "1"], (1, 4), "C74/help/max/bucket.maxhelp `bucket 4 1`"),
    ("buddy", ["4"], (4, 4), "C74/help/max/buddy.maxhelp `buddy 4`"),
    ("buddy", [], (2, 2), "C74/help/max/buddy.maxhelp `buddy`"),
    ("b", [], (1, 2), "C74/extras/GlobalTransport.maxpat `b`"),
    ("b", ["1"], (1, 1), "C74/help/max/cpuclock.maxhelp `b 1`"),
    ("bangbang", [], (1, 2),
     "C74/packages/Node for Max/patchers/debug-monitor/n4m.monitor.maxpat `bangbang`"),
    ("b", ["17"], (1, 17), "bundle `b 17`"),
    # Task 3: groove~ / tapout~ / record~
    ("groove~", ["audio", "2"], (3, 3), "C74/help/m4l/chucker~.maxhelp `groove~ audio 2`"),
    ("groove~", ["helpgroove02", "4", "@loop", "1"], (3, 5),
     "C74/help/msp/groove~.maxhelp `groove~ helpgroove02 4 @loop 1`"),
    ("tapout~", ["0", "0"], (2, 2),
     "C74/patchers/m4l/Lessons resources/M4L.dl.vdelay~.maxpat `tapout~ 0 0`"),
    ("tapout~", ["100"], (1, 1), "C74/help/msp/plugin~.maxhelp `tapout~ 100`"),
    ("record~", ["this", "2"], (4, 1),
     "C74/media/legacy-tutorials/msp-tut/mypvoc2~.maxpat `record~ this 2`"),
    ("record~", ["foo"], (3, 1), "C74/help/msp/plugphasor~.maxhelp `record~ foo`"),
    # Task 3: jit.pack / jit.unpack / mc.route
    ("jit.pack", ["2"], (2, 2), "C74/help/jitter/jit.fft.maxhelp `jit.pack 2`"),
    ("jit.unpack", ["2"], (1, 3), "C74/help/jitter/jit.fft.maxhelp `jit.unpack 2`"),
    ("jit.pack", ["3", "float32"], (3, 2), "C74/help/jitter/jit.p.shiva.maxhelp `jit.pack 3 float32`"),
    ("jit.unpack", ["5", "float32"], (1, 6), "C74/help/jitter/jit.p.shiva.maxhelp `jit.unpack 5 float32`"),
    ("mc.route", ["4"], (2, 4), "C74/help/msp/mc.pack~.maxhelp `mc.route 4`"),
]


@pytest.mark.parametrize(
    "name,args,expected,citation", MAX_SAVED,
    ids=[f"{r[0]}-{i}" for i, r in enumerate(MAX_SAVED)],
)
def test_max_saved_counts(db, name, args, expected, citation) -> None:
    assert db.compute_io_counts(name, args) == expected, citation


class TestResolverOutletTypes:
    """Expansion past the DB outlets inherits the last DB outlet (control)."""

    def test_sel_two_args(self, db) -> None:
        assert db.get_outlet_types("sel", ["0", "1"]) == ["", "", ""]

    def test_if_out2(self, db) -> None:
        assert db.get_outlet_types(
            "if", "$i1 < 8 then bang else out2 bang".split()
        ) == ["", ""]


class TestTrailingOutletLayouts:
    """Rule-driven outlet types follow the DB layout (trailing_outlets)."""

    def test_groove_four_channels(self, db) -> None:
        assert db.get_outlet_types("groove~", ["a", "4"]) == ["signal"] * 5
        sync_role = db.get_signal_role("groove~", len(db.lookup("groove~")["outlets"]) - 1)
        assert db.get_signal_role("groove~", 4, ["a", "4"]) == sync_role

    def test_unjoin_four(self, db) -> None:
        assert db.get_outlet_types("unjoin", ["4"]) == [""] * 5

    def test_jit_unpack_two(self, db) -> None:
        assert db.get_outlet_types("jit.unpack", ["2"]) == [""] * 3

    def test_gate_three(self, db) -> None:
        assert db.get_outlet_types("gate~", ["3"]) == ["signal"] * 3

    def test_tapout_two_taps(self, db) -> None:
        assert db.get_outlet_types("tapout~", ["0", "0"]) == ["signal"] * 2


class TestModifyBoxRecomputesNewlyVariable:
    """Assumption delta: gate~ is now variable_io, so an args edit recomputes."""

    def test_gate_three_to_two_orphans_outlet_two(self, db) -> None:
        boxes = [{"box": {
            "id": "obj-1", "maxclass": "newobj", "text": "gate~ 3",
            "numinlets": 2, "numoutlets": 3,
            "outlettype": ["signal", "signal", "signal"],
            "patching_rect": [200.0, 200.0, 60.0, 22.0],
        }}]
        lines = []
        for o in range(3):
            boxes.append({"box": {
                "id": f"obj-out{o}", "maxclass": "newobj", "text": "print",
                "numinlets": 1, "numoutlets": 0, "outlettype": [],
                "patching_rect": [100.0 + o * 90, 300.0, 40.0, 22.0],
            }})
            lines.append({"patchline": {
                "source": ["obj-1", o], "destination": [f"obj-out{o}", 0],
            }})
        p = Patcher.from_dict({"patcher": {"boxes": boxes, "lines": lines}}, db=db)
        gate = next(b for b in p.boxes if b.id == "obj-1")
        assert p._io_is_content_defined(gate) is False

        result = p.modify_box(gate, args=["2"])

        assert (gate.numinlets, gate.numoutlets) == (2, 2)
        assert [
            (o["source_id"], o["source_outlet"], o["dest_id"], o["dest_inlet"])
            for o in result.orphaned
        ] == [("obj-1", 2, "obj-out2", 0)]
        assert sorted(
            (l.source_outlet, l.dest_id) for l in p.lines if l.source_id == "obj-1"
        ) == [(0, "obj-out0"), (1, "obj-out1")]


# ── Invariants ────────────────────────────────────────────────────


class TestInvariants:
    def test_formula_vocabulary_frozen(self) -> None:
        assert SUPPORTED_IO_FORMULAS == frozenset({
            "", "arg_count", "arg_count+1", "arg_count_or_default",
            "first_arg", "first_arg+1", "second_arg", "second_arg+1",
            "second_arg+2", "sfplay_outlets", "inherited_from_subpatch",
        })

    def test_sfplay_outlets_formula(self, db) -> None:
        # sfplay_outlets stays a formula (not a resolver) so the rule keeps
        # trailing_outlets typing: the done-bang is always the last outlet.
        assert db.compute_io_counts("sfplay~", []) == (2, 2)
        assert db.compute_io_counts("sfplay~", ["2"]) == (2, 3)
        assert db.compute_io_counts("sfplay~", ["sf.cues", "2"]) == (2, 3)
        assert db.compute_io_counts("sfplay~", ["sf.cues", "2", "0", "1"]) == (2, 4)
        assert db.compute_io_counts("sfplay~", ["2", "0", "2", "ref"]) == (2, 5)
        assert db.get_outlet_types("sfplay~", ["sf.cues", "2", "0", "1"]) == [
            "signal", "signal", "signal", ""]

    def test_resolver_keys_are_canonical_db_names(self, db) -> None:
        for name in IO_RESOLVERS:
            assert name not in db._aliases, name
            assert db.lookup(name) is not None, name
            assert name not in db._variable_io_rules, name

    def test_resolver_and_rule_objects_report_variable_io(self, db) -> None:
        for name in list(IO_RESOLVERS) + [
            n for n in db._variable_io_rules if not n.startswith("_")
        ]:
            assert db.lookup(name)["variable_io"] is True, name

    def test_resolver_rule_conflict_raises(self, tmp_path: Path) -> None:
        root = tmp_path / "db"
        (root / "max").mkdir(parents=True)
        port = {"id": 0, "type": "anything", "signal": False}
        (root / "max" / "objects.json").write_text(json.dumps({
            "receive": {"name": "receive", "inlets": [port], "outlets": [port]},
        }))
        (root / "overrides.json").write_text(json.dumps({
            "objects": {},
            "variable_io_rules": {
                "receive": {"inlet_count": "fixed:0", "outlet_count": "fixed:1"},
            },
        }))
        with pytest.raises(ValueError, match="receive"):
            ObjectDatabase(root)


class TestPatcherBoxes:
    def test_add_box_named_receive_has_no_inlet(self) -> None:
        p = Patcher()
        b = p.add_box("r", ["foo"])
        assert (b.numinlets, b.numoutlets) == (0, 1)

    def test_receive_box_is_not_content_defined(self) -> None:
        p = Patcher()
        b = p.add_box("r", ["foo"])
        assert p.db.lookup("receive")["variable_io"] is True
        assert p._io_is_content_defined(b) is False


# ── Live oracle ───────────────────────────────────────────────────


@pytest.fixture(scope="module")
def live_section() -> dict:
    envelope = audit_db.run_help_io(max_app=MAX_APP_PATH)
    section = envelope["help_io"]
    assert section["available"], section.get("reason")
    return help_io.build_baseline(section)


@pytest.mark.requires_max
class TestOracleTargets:
    """Every Q10 target has 0 count mismatches against MAX-saved bundle boxes."""

    def test_targets_clean_in_bundle(self, live_section: dict) -> None:
        committed = json.loads(BASELINE.read_text())
        diff = help_io.diff_baselines(committed, live_section)
        stale = diff["stale_sources"].get("bundle")
        if stale is not None:
            pytest.skip(
                f"help-io baseline recorded against Max {stale['baseline']}, "
                f"installed {stale['live']}"
            )
        bundle = live_section["names"].get("bundle", {})
        bad = {
            name: bundle[name]["signatures"]
            for name in Q10_TARGETS
            if bundle.get(name, {}).get("count_mismatches", 0)
        }
        assert not bad, bad
