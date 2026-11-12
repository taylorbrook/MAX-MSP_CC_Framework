"""quick-261021-olv: hermetic tests for tools/max_verify_live.py (/max-verify --live).

Nothing here reaches MAX or the real bridge port: every run passes an explicit
--port (a FakeBridge's, or a free port nobody listens on) and --reply-port 0,
``_max_running`` and ``bridge.cg_windows`` are faked, and the bridge's run
dirs go under tmp_path.
"""

from __future__ import annotations

import ast
import json
import sys
import time
from pathlib import Path

import pytest

import tools.max_bridge as bridge
import tools.max_verify_live as live
from src.maxpat.db_lookup import ObjectDatabase
from src.maxpat.patcher import Patcher
from tests.test_max_bridge import FakeBridge, _free_port, _install_virtual_time, _tone_patch

LIVE_PY = Path(live.__file__)


@pytest.fixture(scope="module")
def db():
    return ObjectDatabase()


@pytest.fixture(autouse=True)
def _virtual_bridge_time(monkeypatch):
    """Every bridge wait on a virtual clock (quick 261112-bve); no test here needs real time."""
    return _install_virtual_time(monkeypatch)


@pytest.fixture(autouse=True)
def _no_real_max(monkeypatch):
    monkeypatch.setattr(live, "_max_running", lambda: True)
    monkeypatch.setattr(bridge, "cg_windows", lambda: [])


@pytest.fixture(autouse=True)
def _run_dirs(tmp_path, monkeypatch):
    counter = {"n": 0}

    def make():
        counter["n"] += 1
        d = tmp_path / "runs" / f"run{counter['n']}"
        d.mkdir(parents=True)
        return d

    monkeypatch.setattr(bridge, "_make_run_dir", make)


def _run(port, *paths, extra=(), capsys):
    argv = [*map(str, paths), "--port", str(port), "--reply-port", "0", "--timeout", "1.0",
            "--settle", "0.1", "--load-timeout", "1.5", "--no-shot", "--json"]
    if "--record" not in extra:
        argv += ["--record", "0.2"]
    argv += list(extra)
    rc = live.main(argv)
    out = capsys.readouterr().out
    return rc, json.loads(out)


def _opts(*argv):
    return live.build_parser().parse_args(list(argv))


# ---------------------------------------------------------------------------
# Patch builders
# ---------------------------------------------------------------------------

def _write(p: Patcher, path: Path) -> Path:
    from src.maxpat.hooks import format_patch_text
    path.write_text(format_patch_text(p.to_dict()))
    return path


def _tone_with(path: Path, db, extra: str) -> Path:
    p = Patcher(db=db)
    osc = p.add_box("cycle~", ["440"], x=20, y=20)
    g = p.add_box("*~", ["0.2"], x=20, y=60)
    out = p.add_box("dac~", [], x=20, y=100)
    p.add_connection(osc, 0, g, 0)
    p.add_connection(g, 0, out, 0)
    p.add_connection(g, 0, out, 1)
    if extra == "notein":
        p.add_box("notein", [], x=200, y=20)
    elif extra == "kslider":
        p.add_box("kslider", [], x=200, y=20)
    return _write(p, path)


def _adc_patch(path: Path, db) -> Path:
    p = Patcher(db=db)
    adc = p.add_box("adc~", [], x=20, y=20)
    g = p.add_box("*~", ["0.2"], x=20, y=60)
    out = p.add_box("dac~", [], x=20, y=100)
    p.add_connection(adc, 0, g, 0)
    p.add_connection(g, 0, out, 0)
    p.add_connection(g, 0, out, 1)
    return _write(p, path)


def _nodac_patch(path: Path, db) -> Path:
    p = Patcher(db=db)
    osc = p.add_box("cycle~", ["440"], x=20, y=20)
    mute = p.add_box("*~", ["0."], x=20, y=60)
    p.add_connection(osc, 0, mute, 0)
    return _write(p, path)


def _raw_patch(boxes: list[dict]) -> dict:
    return {"patcher": {"fileversion": 1, "rect": [0, 0, 400, 300], "boxes":
                        [{"box": b} for b in boxes], "lines": []}}


def _newobj(i: int, text: str) -> dict:
    return {"id": f"obj-{i}", "maxclass": "newobj", "text": text, "numinlets": 1,
            "numoutlets": 1, "patching_rect": [20.0, 20.0 + 40 * i, 80.0, 22.0]}


def _no_copies(root: Path) -> bool:
    return not list(root.rglob(f"{bridge.COPY_PREFIX}*"))


# ---------------------------------------------------------------------------
# Module identity and constants
# ---------------------------------------------------------------------------

def test_import_identity():
    assert live.bridge is sys.modules["tools.max_bridge"]


def test_input_boxes_in_db(db):
    for name in live.INPUT_BOXES:
        entry = db.lookup(name)
        assert entry is not None, name
        assert entry["domain"].lower() not in ("rnbo", "gen"), name


def test_every_wording_has_a_suggestion():
    assert set(live.WORDING_SUGGESTIONS) == set(bridge.ERROR_WORDINGS)


# ---------------------------------------------------------------------------
# Option rules (D-01 / D-02)
# ---------------------------------------------------------------------------

def _argv_for(path, *opt_argv):
    opts = _opts(*opt_argv)
    scan = live.scan_patch(path)
    argv, mode, reasons = live.check_argv(path, scan, opts)
    parsed = bridge.build_parser().parse_args(argv)
    return argv, mode, reasons, parsed


class TestOptionRules:

    def test_notein_records_with_note(self, tmp_path, db):
        argv, mode, _r, parsed = _argv_for(_tone_with(tmp_path / "t.maxpat", db, "notein"))
        assert mode == "record"
        i = argv.index("--record")
        assert argv[i + 1] == "3.0"
        j = argv.index("--note")
        assert argv[j + 1:j + 3] == ["60", "100"]
        assert "--dsp-on-load" not in argv and parsed.dsp_on_load is False
        assert parsed.note == [60, 100] and parsed.record == 3.0

    def test_kslider_gets_note(self, tmp_path, db):
        argv, mode, _r, _p = _argv_for(_tone_with(tmp_path / "t.maxpat", db, "kslider"))
        assert mode == "record" and "--note" in argv

    def test_tone_only_no_note(self, tmp_path, db):
        argv, mode, _r, _p = _argv_for(_tone_patch(tmp_path / "t.maxpat", db))
        assert mode == "record" and "--note" not in argv

    def test_adc_load_only_no_dsp(self, tmp_path, db):
        argv, mode, reasons, parsed = _argv_for(_adc_patch(tmp_path / "a.maxpat", db))
        assert mode == "load-only"
        assert "--record" not in argv and "--dsp-on-load" not in argv
        assert parsed.dsp_on_load is False and parsed.record is None
        assert any("audio-input" in r for r in reasons)

    def test_adc_live_inputs_records(self, tmp_path, db):
        argv, mode, _r, parsed = _argv_for(_adc_patch(tmp_path / "a.maxpat", db), "--live-inputs")
        assert mode == "record" and parsed.record == 3.0
        assert "--dsp-on-load" not in argv

    def test_nodac_load_only_dsp_on(self, tmp_path, db):
        argv, mode, reasons, parsed = _argv_for(_nodac_patch(tmp_path / "n.maxpat", db))
        assert mode == "load-only" and parsed.dsp_on_load is True
        assert any("output not tapped" in r for r in reasons)

    def test_record_zero(self, tmp_path, db):
        argv, mode, reasons, parsed = _argv_for(_tone_patch(tmp_path / "t.maxpat", db),
                                                "--record", "0")
        assert mode == "load-only" and parsed.dsp_on_load is True and parsed.record is None
        assert "record disabled (--record 0)" in reasons

    def test_custom_note(self, tmp_path, db):
        argv, _m, _r, parsed = _argv_for(_tone_with(tmp_path / "t.maxpat", db, "notein"),
                                         "--note", "64", "90")
        j = argv.index("--note")
        assert argv[j + 1:j + 3] == ["64", "90"]

    def test_shot_rules(self, tmp_path, db, monkeypatch):
        path = _tone_patch(tmp_path / "t.maxpat", db)
        argv, *_ = _argv_for(path, "--no-shot")
        assert "--shot" not in argv
        monkeypatch.setattr(live.sys, "platform", "darwin")
        argv, _m, _r, parsed = _argv_for(path)
        assert "--shot" in argv and parsed.shot == ""
        monkeypatch.setattr(live.sys, "platform", "linux")
        argv, *_ = _argv_for(path)
        assert "--shot" not in argv

    def test_net_flags_only_when_given(self, tmp_path, db):
        path = _tone_patch(tmp_path / "t.maxpat", db)
        argv, _m, _r, parsed = _argv_for(path)
        assert "--port" not in argv and "--settle" not in argv
        assert parsed.port == bridge.BRIDGE_PORT and parsed.settle == 3.0
        argv, _m, _r, parsed = _argv_for(path, "--port", "7409", "--settle", "0.5")
        assert parsed.port == 7409 and parsed.settle == 0.5


class TestInputScan:

    def test_bpatcher_child_with_adc(self, tmp_path):
        child = _raw_patch([_newobj(1, "adc~ 1 2")])
        (tmp_path / "child.maxpat").write_text(json.dumps(child))
        parent = _raw_patch([{"id": "obj-1", "maxclass": "bpatcher", "name": "child.maxpat",
                              "numinlets": 0, "numoutlets": 0,
                              "patching_rect": [20.0, 20.0, 200.0, 100.0]}])
        (tmp_path / "parent.maxpat").write_text(json.dumps(parent))
        scan = live.scan_patch(tmp_path / "parent.maxpat")
        assert scan["inputs"] is True
        assert scan["input_where"] == ["child.maxpat:obj-1"]

    def test_comment_does_not_count(self, tmp_path):
        patch = _raw_patch([{"id": "obj-1", "maxclass": "comment", "text": "adc~",
                             "numinlets": 1, "numoutlets": 0,
                             "patching_rect": [20.0, 20.0, 80.0, 20.0]}])
        (tmp_path / "c.maxpat").write_text(json.dumps(patch))
        assert live.scan_patch(tmp_path / "c.maxpat")["inputs"] is False

    def test_ezadc_maxclass_and_nested(self, tmp_path):
        inner = {"id": "obj-9", "maxclass": "ezadc~", "numinlets": 1, "numoutlets": 2,
                 "patching_rect": [20.0, 20.0, 45.0, 45.0]}
        sub = _newobj(1, "p inputs")
        sub["patcher"] = _raw_patch([inner])["patcher"]
        (tmp_path / "e.maxpat").write_text(json.dumps(_raw_patch([sub])))
        scan = live.scan_patch(tmp_path / "e.maxpat")
        assert scan["inputs"] is True and scan["input_where"] == ["e.maxpat:obj-9"]


# ---------------------------------------------------------------------------
# map_findings (severity-contract.md section 7)
# ---------------------------------------------------------------------------

def _report(**kw) -> dict:
    rep = {
        "patch": "/x/t.maxpat", "copy": "/x/__maxbridge_t.maxpat", "run_dir": "/tmp/r",
        "taps": {"L": 1, "R": 1}, "tap_boxes": [], "unsupported": [], "warnings": [],
        "load": {"open_s": 0.1, "pong_s": 0.2}, "errors": [], "events_raw": [],
        "record": None, "shot": None, "closed": None, "feedback_suspected": False,
        "console_write": {"status": "ok", "new_lines": []}, "errors_distinct": [],
        "max_sr": 44100, "note": None, "note_target": None, "dsp_before": 0,
        "dsp_stop_sent": True, "verdict": "clean", "exit_code": 0,
    }
    rep.update(kw)
    return rep


def _distinct(key: str, n: int = 1) -> dict:
    return {"key": key, "sources": {"error": n, "console": 0, "console_write": 0},
            "occurrences": n, "first_t": 0.1}


def _rec(flags, warnings=()) -> dict:
    return {"wav": "/tmp/r/out.wav", "seconds": 3.0, "sample_rate": 44100,
            "header_sample_rate": 44100, "channels": {}, "flags": list(flags),
            "warnings": list(warnings)}


def _sev(rows):
    return [r["severity"] for r in rows]


class TestMapFindings:

    @pytest.mark.parametrize("wording", bridge.ERROR_WORDINGS)
    def test_wordings_are_blockers(self, wording):
        rows = live.map_findings(_report(errors_distinct=[_distinct(f"obj: {wording} x", 2)],
                                         verdict="findings", exit_code=1))
        assert _sev(rows) == ["blocker"]
        assert rows[0]["finding"] == f"MAX console: obj: {wording} x (x2)"
        assert rows[0]["suggestion"]

    def test_wording_suggestions(self):
        rows = live.map_findings(_report(errors_distinct=[
            _distinct("osc~: No such object"), _distinct("gen~: failed to compile patcher")]))
        assert "Rule #1" in rows[0]["suggestion"]
        assert "genexpr-rules.md" in rows[1]["suggestion"]

    def test_other_error_is_warning(self):
        rows = live.map_findings(_report(errors_distinct=[_distinct("sfplay~: can't open file")]))
        assert _sev(rows) == ["warning"]

    @pytest.mark.parametrize("flag,sev", [
        ("nonfinite", "blocker"), ("runaway", "blocker"), ("clipping", "warning"),
        ("dc_offset", "warning"), ("silent", "warning"), ("something_new", "warning"),
    ])
    def test_record_flags(self, flag, sev):
        rows = live.map_findings(_report(record=_rec([flag])))
        assert _sev(rows) == [sev]

    @pytest.mark.parametrize("trigger", live.UNRELIABLE_FLAGS)
    def test_unreliable_demotes_every_flag(self, trigger):
        rows = live.map_findings(_report(record=_rec(
            ["nonfinite", "clipping", trigger], [f"{trigger}: measures unreliable"])))
        assert _sev(rows) == ["note", "note", "note"]
        assert all("measures unreliable" in r["finding"] for r in rows)

    def test_record_and_report_warnings_are_notes(self):
        rows = live.map_findings(_report(
            record=_rec([], ["sr_header_mismatch: header 48000, MAX 44100"]),
            warnings=[bridge.DSP_UNKNOWN_WARNING, "--note: no notein or kslider to drive"]))
        assert _sev(rows) == ["note", "note", "note"]

    def test_unsupported_is_note_despite_exit_code(self):
        rows = live.map_findings(_report(
            unsupported=[{"box_id": "obj-3", "path": "top", "name": "mc.dac~", "reason": "x"}],
            verdict="findings", exit_code=1))
        assert _sev(rows) == ["note"]
        assert rows[0]["finding"] == "not tapped: mc.dac~ at top"

    def test_shot_error_is_note(self):
        rows = live.map_findings(_report(shot={"error": "no window", "png": "/tmp/s.png"},
                                         verdict="findings", exit_code=1))
        assert _sev(rows) == ["note"] and "Screen Recording" in rows[0]["suggestion"]

    def test_closed_false_is_warning(self):
        rows = live.map_findings(_report(closed=False))
        assert _sev(rows) == ["warning"] and "WITHOUT saving" in rows[0]["suggestion"]

    def test_feedback_is_warning(self):
        rows = live.map_findings(_report(feedback_suspected=True))
        assert _sev(rows) == ["warning"]

    def test_clean_report_is_empty(self):
        assert live.map_findings(_report(record=_rec([]), closed=True,
                                         shot={"png": "/tmp/s.png", "window_id": 1})) == []

    def test_every_row_is_live(self):
        rows = live.map_findings(_report(
            errors_distinct=[_distinct("osc~: No such object"), _distinct("other")],
            record=_rec(["clipping"], ["sr_header_mismatch: x"]), warnings=["w"],
            unsupported=[{"name": "plugout~", "path": "top"}], shot={"error": "e"},
            closed=False, feedback_suspected=True))
        assert len(rows) == 9
        assert all(r["source"] == "live" for r in rows)


# ---------------------------------------------------------------------------
# Skip paths: no copy is ever written
# ---------------------------------------------------------------------------

class TestSkip:

    def test_nothing_listening(self, tmp_path, db, monkeypatch, capsys):
        calls = []
        monkeypatch.setattr(bridge, "run_check", lambda a: calls.append(a))
        src = _tone_patch(tmp_path / "tone.maxpat", db)
        rc = live.main([str(src), "--port", str(_free_port()), "--reply-port", "0",
                        "--timeout", "0.05", "--json"])
        res = json.loads(capsys.readouterr().out)
        assert rc == 2 and res["status"] == "skipped" and res["exit_code"] == 2
        assert "toggle" in res["hint"] and res["patches"] == []
        assert calls == [] and _no_copies(tmp_path)

    def test_max_not_running(self, tmp_path, db, monkeypatch, capsys):
        monkeypatch.setattr(live, "_max_running", lambda: False)
        src = _tone_patch(tmp_path / "tone.maxpat", db)
        with FakeBridge() as fb:
            rc, res = _run(fb.port, src, capsys=capsys)
            time.sleep(0.1)
        assert rc == 2 and res["hint"].startswith("MAX is not running")
        assert fb.received == [] and _no_copies(tmp_path)

    def test_no_bridge_patch(self, tmp_path, db, monkeypatch, capsys):
        monkeypatch.setattr(bridge, "BRIDGE_PATCH", tmp_path / "missing.maxpat")
        src = _tone_patch(tmp_path / "tone.maxpat", db)
        rc, res = _run(_free_port(), src, capsys=capsys)
        assert rc == 2 and "not available in this install" in res["hint"]

    def test_unknown_max_state_still_pings(self, tmp_path, db, monkeypatch, capsys):
        monkeypatch.setattr(live, "_max_running", lambda: None)
        src = _tone_patch(tmp_path / "tone.maxpat", db)
        with FakeBridge() as fb:
            rc, res = _run(fb.port, src, capsys=capsys)
        assert rc == 0 and res["status"] == "ran", res

    def test_no_patches(self, tmp_path, capsys):
        rc, res = _run(_free_port(), tmp_path / "__maxbridge_x.maxpat", tmp_path / "y.txt",
                       capsys=capsys)
        assert rc == 2 and res["status"] == "skipped"
        assert {e["reason"] for e in res["excluded"]} == {"bridge temp copy", "not a .maxpat"}


# ---------------------------------------------------------------------------
# Runs on FakeBridge
# ---------------------------------------------------------------------------

class TestRun:

    def test_error_run_blocker(self, tmp_path, db, capsys):
        src = _tone_patch(tmp_path / "tone.maxpat", db)
        before = src.read_bytes()
        with FakeBridge(errors=True) as fb:
            rc, res = _run(fb.port, src, capsys=capsys)
        assert rc == 1 and res["status"] == "ran", res
        (entry,) = res["patches"]
        blockers = [f for f in entry["findings"] if f["severity"] == "blocker"]
        assert len(blockers) == 1 and "No such object" in blockers[0]["finding"]
        assert res["counts"]["blocker"] == 1
        assert src.read_bytes() == before and _no_copies(tmp_path)

    def test_clean_run(self, tmp_path, db, capsys):
        src = _tone_patch(tmp_path / "tone.maxpat", db)
        with FakeBridge() as fb:
            rc, res = _run(fb.port, src, capsys=capsys)
        assert rc == 0, res
        (entry,) = res["patches"]
        assert entry["status"] == "checked" and entry["mode"] == "record"
        assert entry["record"] is not None and entry["verdict"] == "clean"
        assert res["reminder"] == live.REMINDER and _no_copies(tmp_path)

    def test_refused(self, tmp_path, db, monkeypatch, capsys):
        src = _tone_patch(tmp_path / "tone.maxpat", db)
        monkeypatch.setattr(bridge, "_allowed_roots", lambda: [tmp_path / "elsewhere"])
        with FakeBridge() as fb:
            rc, res = _run(fb.port, src, capsys=capsys)
        assert res["patches"][0]["status"] == "refused"
        assert "/open" not in fb.addresses and rc == 0


class TestDspOnLoadEndToEnd:

    def test_nodac_dsp_off(self, tmp_path, db, capsys):
        src = _nodac_patch(tmp_path / "n.maxpat", db)
        with FakeBridge(dsp_on=0) as fb:
            rc, res = _run(fb.port, src, capsys=capsys)
        assert rc == 0, res
        assert res["patches"][0]["mode"] == "load-only"
        i_open = fb.addresses.index("/open")
        assert fb.received.index(("/dsp", [1])) < i_open < fb.received.index(("/dsp", [0]))
        assert fb.dsp_on == 0

    def test_nodac_dsp_on(self, tmp_path, db, capsys):
        src = _nodac_patch(tmp_path / "n.maxpat", db)
        with FakeBridge(dsp_on=1) as fb:
            rc, res = _run(fb.port, src, capsys=capsys)
        assert rc == 0, res
        assert ("/dsp", [0]) not in fb.received and fb.dsp_on == 1

    def test_adc_dsp_off_never_on(self, tmp_path, db, capsys):
        src = _adc_patch(tmp_path / "a.maxpat", db)
        with FakeBridge(dsp_on=0) as fb:
            rc, res = _run(fb.port, src, capsys=capsys)
        assert rc == 0, res
        assert ("/dsp", [1]) not in fb.received and "/sf" not in fb.addresses
        assert fb.dsp_on == 0

    def test_adc_dsp_already_on_note(self, tmp_path, db, capsys):
        src = _adc_patch(tmp_path / "a.maxpat", db)
        with FakeBridge(dsp_on=1) as fb:
            rc, res = _run(fb.port, src, capsys=capsys)
        notes = [f["finding"] for f in res["patches"][0]["findings"] if f["severity"] == "note"]
        assert any(n.startswith("DSP was already on") for n in notes), res
        assert rc == 0 and ("/dsp", [1]) not in fb.received


class TestBatch:

    def test_abort_on_first_bridge_failed(self, tmp_path, db, capsys):
        a = _tone_patch(tmp_path / "a.maxpat", db)
        b = _tone_patch(tmp_path / "b.maxpat", db)
        with FakeBridge(mute_after_open=True) as fb:
            rc, res = _run(fb.port, a, b, capsys=capsys)
        assert rc == 2 and res["status"] == "aborted"
        assert "MAX stopped answering during a.maxpat" in res["hint"]
        assert "close __maxbridge_a WITHOUT saving" in res["hint"] and "check DSP" in res["hint"]
        assert res["patches"][1]["status"] == "not checked"
        assert fb.addresses.count("/open") == 1
        assert _no_copies(tmp_path)

    def test_crash_is_a_warning(self, tmp_path, db, monkeypatch, capsys):
        a = _tone_patch(tmp_path / "a.maxpat", db)
        b = _tone_patch(tmp_path / "b.maxpat", db)
        real = bridge.run_check
        calls = {"n": 0}

        def flaky(args):
            calls["n"] += 1
            if calls["n"] == 1:
                raise RuntimeError("boom")
            return real(args)

        monkeypatch.setattr(bridge, "run_check", flaky)
        with FakeBridge() as fb:
            rc, res = _run(fb.port, a, b, capsys=capsys)
        first, second = res["patches"]
        assert first["status"] == "failed"
        assert first["findings"][0]["severity"] == "warning"
        assert "live check crashed" in first["findings"][0]["finding"]
        assert second["status"] == "checked" and rc == 1


# ---------------------------------------------------------------------------
# D-04: the wrapper never toggles the kill switch or opens the bridge patch
# ---------------------------------------------------------------------------

def test_d04_ast_guard():
    tree = ast.parse(LIVE_PY.read_text())
    for node in ast.walk(tree):
        if isinstance(node, ast.Call) and isinstance(node.func, ast.Attribute):
            assert node.func.attr != "send", ast.dump(node)
        if isinstance(node, ast.Constant) and isinstance(node.value, str):
            assert node.value not in ("open", "osascript", "/dsp", "/listen"), node.value


# ---------------------------------------------------------------------------
# Task 2: top-level selection
# ---------------------------------------------------------------------------

def _bpatcher(i: int, name: str) -> dict:
    return {"id": f"obj-{i}", "maxclass": "bpatcher", "name": name, "numinlets": 0,
            "numoutlets": 0, "patching_rect": [20.0, 20.0 + 120 * i, 200.0, 100.0]}


def _comment(i: int, text: str) -> dict:
    return {"id": f"obj-{i}", "maxclass": "comment", "text": text, "numinlets": 1,
            "numoutlets": 0, "patching_rect": [300.0, 20.0 + 40 * i, 120.0, 20.0]}


def _write_raw(d: Path, name: str, boxes: list[dict]) -> Path:
    path = d / f"{name}.maxpat"
    path.write_text(json.dumps(_raw_patch(boxes)))
    return path


class TestTopLevel:

    def test_children_are_excluded(self, tmp_path):
        g = tmp_path / "generated"
        g.mkdir()
        _write_raw(g, "parent", [
            _bpatcher(1, "kid-bp.maxpat"), _newobj(2, "poly~ kid-poly 4"),
            _newobj(3, "mc.poly~ kid-mcpoly.maxpat 8"), _newobj(4, "pfft~ kid-fft 1024 4"),
            _newobj(5, "kid-abs 1 2"), _comment(6, "see lonely for details"),
        ])
        for kid in ("kid-bp", "kid-poly", "kid-mcpoly", "kid-fft", "kid-abs"):
            _write_raw(g, kid, [_newobj(1, "cycle~ 440")])
        _write_raw(g, "lonely", [_newobj(1, "cycle~ 220")])
        _write_raw(g, "selfref", [_newobj(1, "selfref 1"), _newobj(2, "poly~ selfref")])
        _write_raw(g, "__maxbridge_x", [_newobj(1, "cycle~ 1")])
        tops, excluded = live.find_top_level_patches(g)
        assert [p.name for p in tops] == ["lonely.maxpat", "parent.maxpat", "selfref.maxpat"]
        reasons = {e["patch"]: e["reason"] for e in excluded}
        assert reasons == {
            "__maxbridge_x.maxpat": "bridge temp copy",
            "kid-abs.maxpat": "abstraction of parent",
            "kid-bp.maxpat": "abstraction of parent",
            "kid-fft.maxpat": "abstraction of parent",
            "kid-mcpoly.maxpat": "abstraction of parent",
            "kid-poly.maxpat": "abstraction of parent",
        }

    def test_several_parents_and_unreadable(self, tmp_path):
        g = tmp_path / "generated"
        g.mkdir()
        _write_raw(g, "a", [_newobj(1, "shared")])
        _write_raw(g, "b", [_bpatcher(1, "shared.maxpat")])
        _write_raw(g, "shared", [_newobj(1, "cycle~ 440")])
        (g / "broken.maxpat").write_text("{not json")
        tops, excluded = live.find_top_level_patches(g)
        assert [p.name for p in tops] == ["a.maxpat", "b.maxpat", "broken.maxpat"]
        assert excluded == [{"patch": "shared.maxpat", "reason": "abstraction of a, b"}]

    def test_terrain_synth_real_repo(self):
        gen = live.REPO_ROOT / "patches" / "terrain-synth" / "generated"
        if not gen.is_dir():
            pytest.skip("terrain-synth not in this checkout")
        tops, excluded = live.find_top_level_patches(gen)
        assert [p.name for p in tops] == ["terrain-synth.maxpat"]
        assert {e["patch"] for e in excluded} == {
            "terrain-voice.maxpat", "terrain-osc.maxpat", "terrain-osc-b.maxpat",
            "terrain-lfo.maxpat", "terrain-cheby.maxpat"}


# ---------------------------------------------------------------------------
# Task 2: project resolution
# ---------------------------------------------------------------------------

def _opened(fb) -> list[str]:
    return [args[0] for a, args in fb.received if a == "/open"]


class TestResolution:

    def test_no_active_project(self, monkeypatch, capsys):
        monkeypatch.setattr(live, "get_active_project", lambda base: None)
        rc = live.main(["--port", str(_free_port()), "--reply-port", "0", "--json"])
        res = json.loads(capsys.readouterr().out)
        assert rc == 2 and res["status"] == "skipped"
        assert "no active project" in res["hint"]

    @pytest.mark.parametrize("bad", ["../x", "a/b", "a\\b", "..", "."])
    def test_bad_project_name(self, bad, capsys):
        rc = live.main(["--project", bad, "--port", str(_free_port()), "--reply-port", "0",
                        "--json"])
        res = json.loads(capsys.readouterr().out)
        assert rc == 2 and res["status"] == "skipped"

    def test_missing_project_dir(self, tmp_path, monkeypatch, capsys):
        monkeypatch.setattr(live, "REPO_ROOT", tmp_path)
        rc = live.main(["--project", "nope", "--port", str(_free_port()), "--reply-port", "0",
                        "--json"])
        assert rc == 2 and "nope" in json.loads(capsys.readouterr().out)["hint"]

    def test_project_and_path_exclusive(self, tmp_path, db):
        src = _tone_patch(tmp_path / "tone.maxpat", db)
        with pytest.raises(SystemExit) as exc:
            live.main(["--project", "demo", str(src)])
        assert exc.value.code == 2

    def _demo(self, root: Path) -> Path:
        g = root / "patches" / "demo" / "generated"
        g.mkdir(parents=True)
        _write_raw(g, "parent", [_bpatcher(1, "child.maxpat")])
        _write_raw(g, "child", [_newobj(1, "cycle~ 440")])
        return g

    def test_project_runs_top_level_only(self, tmp_path, monkeypatch, capsys):
        root = tmp_path / "repo"
        self._demo(root)
        monkeypatch.setattr(live, "REPO_ROOT", root)
        with FakeBridge() as fb:
            rc, res = _run(fb.port, extra=("--project", "demo"), capsys=capsys)
        opened = _opened(fb)
        assert len(opened) == 1 and opened[0].endswith("__maxbridge_parent.maxpat")
        assert res["project"] == "demo"
        assert [e["patch"] for e in res["excluded"]] == ["child.maxpat"]
        assert [p["name"] for p in res["patches"]] == ["parent.maxpat"]
        assert rc in (0, 1)

    def test_active_project_pointer_is_used(self, tmp_path, monkeypatch, capsys):
        root = tmp_path / "repo"
        self._demo(root)
        monkeypatch.setattr(live, "REPO_ROOT", root)
        seen = []
        monkeypatch.setattr(live, "get_active_project",
                            lambda base: seen.append(base) or {"name": "demo"})
        with FakeBridge() as fb:
            _rc, res = _run(fb.port, capsys=capsys)
        assert seen == [root] and res["project"] == "demo"
        assert len(_opened(fb)) == 1

    def test_every_file_referenced(self, tmp_path, monkeypatch, capsys):
        root = tmp_path / "repo"
        g = root / "patches" / "loop" / "generated"
        g.mkdir(parents=True)
        _write_raw(g, "a", [_newobj(1, "b")])
        _write_raw(g, "b", [_newobj(1, "a")])
        monkeypatch.setattr(live, "REPO_ROOT", root)
        rc, res = _run(_free_port(), extra=("--project", "loop"), capsys=capsys)
        assert rc == 2 and "referenced by a sibling" in res["hint"]


# ---------------------------------------------------------------------------
# Task 2: an original open in MAX is skipped, never closed
# ---------------------------------------------------------------------------

class TestOpenOriginal:

    # "(unlocked presentation)": MAX 9.2 title of an unlocked presentation window, 2026-10-21
    @pytest.mark.parametrize("title", ["tone", "tone (presentation)", "tone*", "tone.maxpat",
                                       " tone* ", "tone (unlocked presentation)",
                                       "tone* (unlocked)", "tone (presentation)*"])
    def test_open_original_skipped(self, title, tmp_path, db, monkeypatch, capsys):
        monkeypatch.setattr(live.sys, "platform", "darwin")
        monkeypatch.setattr(bridge, "cg_windows", lambda: [(5, title, 0, 0, 100, 100)])
        src = _tone_patch(tmp_path / "tone.maxpat", db)
        with FakeBridge() as fb:
            rc, res = _run(fb.port, src, capsys=capsys)
        (entry,) = res["patches"]
        assert entry["status"] == "skipped"
        assert entry["findings"][0]["severity"] == "note"
        assert entry["findings"][0]["finding"].startswith("original is open in MAX")
        assert "/open" not in fb.addresses and rc == 0

    def test_norm_title_keeps_a_name_with_its_own_group(self):
        assert live._norm_title("mix (v2)") == "mix (v2)"
        assert live._norm_title("mix (v2) (unlocked presentation)") == "mix (v2)"
        assert live._norm_title("mix (old copy)") == "mix"  # _open_titles keeps the raw title too

    def test_other_titles_run(self, tmp_path, db, monkeypatch, capsys):
        monkeypatch.setattr(live.sys, "platform", "darwin")
        monkeypatch.setattr(bridge, "cg_windows",
                            lambda: [(5, "tone-2", 0, 0, 1, 1), (6, "max-bridge", 0, 0, 1, 1)])
        src = _tone_patch(tmp_path / "tone.maxpat", db)
        with FakeBridge() as fb:
            rc, res = _run(fb.port, src, capsys=capsys)
        assert res["patches"][0]["status"] == "checked" and rc == 0

    def test_window_list_failure_is_a_note(self, tmp_path, db, monkeypatch, capsys):
        monkeypatch.setattr(live.sys, "platform", "darwin")

        def boom():
            raise bridge.ShotError("osascript exited 1")

        monkeypatch.setattr(bridge, "cg_windows", boom)
        src = _tone_patch(tmp_path / "tone.maxpat", db)
        with FakeBridge() as fb:
            _rc, res = _run(fb.port, src, capsys=capsys)
        assert any(n.startswith("could not list MAX windows") for n in res["notes"])
        assert res["patches"][0]["status"] == "checked" and "/open" in fb.addresses


# ---------------------------------------------------------------------------
# Task 2: the human report
# ---------------------------------------------------------------------------

class TestFormatReport:

    def _ran(self):
        result = live._new_result(project="demo",
                                  excluded=[{"patch": "child.maxpat",
                                             "reason": "abstraction of parent"}])
        result["notes"].append("could not list MAX windows (x): close any open original by hand")
        entry = live._entry(Path("/x/parent.maxpat"))
        entry.update(status="checked", mode="record", shot_png="/tmp/r/shot.png",
                     run_dir="/tmp/r", verdict="findings",
                     reasons=["record 3 s", "note 60 100 into the notein"],
                     findings=[
                         live._row("blocker", "MAX console: osc~: No such object (x1)", "use the DB"),
                         live._row("warning", "record flag clipping", "reduce the gain"),
                         live._row("note", "not tapped: plugout~ at top", "gap"),
                     ])
        result["patches"] = [entry]
        return live._finish(result)

    def test_ran(self):
        text = live.format_report(self._ran())
        lines = text.splitlines()
        assert lines[0] == "Live check (MAX 9.2): demo"
        assert set(lines[1]) == {"="} and len(lines[1]) == len(lines[0])
        assert "parent.maxpat  [checked; record: record 3 s; note 60 100 into the notein]" in text
        assert "  LIVE BLOCKER: MAX console: osc~: No such object (x1) -- Fix: use the DB" in text
        assert "  LIVE WARNING: record flag clipping -- reduce the gain" in text
        assert "  LIVE NOTE: not tapped: plugout~ at top" in text
        assert "  shot: /tmp/r/shot.png" in text and "  run dir: /tmp/r" in text
        assert "Excluded: child.maxpat (abstraction of parent)" in text
        assert "could not list MAX windows" in text
        assert "Live: 1 blockers, 1 warnings, 1 notes (1 checked, 0 not run)" in text
        assert lines[-1] == live.REMINDER

    def test_skipped(self):
        res = live._finish(live._new_result(), "skipped", "MAX bridge did not answer")
        text = live.format_report(res)
        assert text.splitlines()[0].startswith("Live check (MAX 9.2)")
        assert "Live check skipped: MAX bridge did not answer" in text
        assert text.splitlines()[-1] == live.REMINDER

    def test_aborted_lists_not_checked(self):
        res = live._new_result()
        res["patches"] = [live._entry(Path("/x/a.maxpat")), live._entry(Path("/x/b.maxpat"))]
        res["patches"][0]["status"] = "failed"
        text = live.format_report(live._finish(res, "aborted", "MAX stopped answering during a"))
        assert "Live check aborted: MAX stopped answering during a" in text
        assert "Not checked: b.maxpat" in text

    def test_main_prints_human_report(self, tmp_path, db, capsys):
        src = _tone_patch(tmp_path / "tone.maxpat", db)
        rc = live.main([str(src), "--port", str(_free_port()), "--reply-port", "0",
                        "--timeout", "0.05"])
        out = capsys.readouterr().out
        assert rc == 2
        assert out.startswith("Live check (MAX 9.2)") and "Live check skipped:" in out


# ---------------------------------------------------------------------------
# Task 3: doc guards
# ---------------------------------------------------------------------------

MAX_VERIFY_MD = live.REPO_ROOT / ".claude" / "commands" / "max-verify.md"
SEVERITY_MD = live.REPO_ROOT / ".claude" / "skills" / "references" / "severity-contract.md"
CHECKLIST_V030 = (live.REPO_ROOT / "patches" / "max-bridge" / "test-results"
                  / "v0.3.0-verify-live-checklist.md")


class TestDocGuards:

    def test_max_verify_doc(self):
        text = MAX_VERIFY_MD.read_text()
        for needle in ("from src.maxpat import", "review_patch", "--live", "tools/max_verify_live.py",
                       "--live-inputs", "(live:", "live check skipped", "LIVE BLOCKER",
                       "Live check (MAX 9.2)"):
            assert needle in text, needle

    def test_severity_contract_section_7(self):
        text = SEVERITY_MD.read_text()
        assert "## 7. Live findings" in text and "max_verify_live" in text
        section = text[text.index("## 7. Live findings"):]
        for wording in bridge.ERROR_WORDINGS:
            assert wording in section, wording
        for flag in ("nonfinite", "runaway", "clipping", "dc_offset", "silent",
                     *live.UNRELIABLE_FLAGS):
            assert flag in section, flag
        for name in (*bridge.UNSUPPORTED_OUTPUTS, "bpatcher"):
            assert name in section, name

    def test_v030_checklist(self):
        import re
        assert CHECKLIST_V030.is_file()
        text = CHECKLIST_V030.read_text()
        for needle in ("fx-genfail", "--live-inputs", "aborted",
                       "find patches -name '__maxbridge_*'"):
            assert needle in text, needle
        steps = {int(n) for n in re.findall(r"^(\d+)\. \[[^]]*\]", text, re.M)}
        assert steps == set(range(9))
        entries = [e for e in re.split(r"\n(?=W\d+\. )", text) if re.match(r"W\d+\. ", e)]
        assert len(entries) == 4
        for e in entries:
            m = re.search(r"Answered by: step (\d+)", e)
            assert m and int(m.group(1)) in steps, e[:60]

    def test_report_title_matches_doc(self):
        res = live._finish(live._new_result(project="demo"), "skipped", "x")
        first = live.format_report(res).splitlines()[0]
        assert first.startswith("Live check (MAX 9.2)")
        assert "Live check (MAX 9.2)" in MAX_VERIFY_MD.read_text()
