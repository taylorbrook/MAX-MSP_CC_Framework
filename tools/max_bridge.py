#!/usr/bin/env python3
"""Drive a running MAX 9.2 from Python through a resident bridge patch (Q34 spike).

SPIKE STATUS: v0.1.0, v0.2.0 and v0.3.0 are all confirmed in MAX 9.2 through
their checklists (patches/max-bridge/test-results/v0.1.0-bridge-checklist.md,
v0.2.0-bridge-checklist.md and v0.3.0-verify-live-checklist.md; 2026-10-21,
commits dc0cde91 and f935e550). v0.3.0 added ``check --dsp-on-load`` and the
``/max-verify --live`` wrapper tools/max_verify_live.py.

Protocol. The bridge patch (tools/max_bridge/max-bridge.maxpat)
is a dumb UDP pass-through; this client owns all the sequencing:

    Python -> MAX  (OSC over UDP to 127.0.0.1:7400)
      /ping                 -> /pong reply (the ordering barrier)
      /open <abs path>      -> prepend load -> pcontrol
      /openfile <abs path>  -> ; max openfile maxbridge $1   (variant B)
      /closefile            -> ; max closefile maxbridge
      /sf <msg...>          -> sfrecord~ 2 (samptype, open, record, 0)
      /console <msg...>     -> console (write <file>, showonlyerrors 0|1)
      /listen 1|0           -> error on/off and the console gates
      /dsp 1|0              -> ; dsp start / ; dsp stop
      /close                -> ; __maxbridge_close bang  (the copy closes itself)
      /query                -> t b b b -> dspstate~, adstatus sr, adstatus switch
                               (any args become bangs: a query never changes a setting)
      /note <pitch> <vel> <ch> -> send __maxbridge_note (the temp copy's
                               receive -> unpack 0 0 0 drives its notein cords)

    MAX -> Python  (OSC over UDP to 127.0.0.1:7401)
      /err error <words...>     from error
      /con/obj, /con/msg, /con/type   from console outlets 0, 1, 2
      /state/dsp 0|1, /state/adsr <sr>, /state/sr <sr>
                                /query replies (adstatus switch, adstatus sr,
                                dspstate~ outlet 1) via send/receive __maxbridge_reply

The bridge's deferlow keeps commands in order, so the /pong after an /open
means "the load returned".

Kill switch (v0.2.0): a toggle in the bridge patch, OFF at every load
(loadbang -> 0), drives a gate 1 0 between udpreceive and deferlow. While it
is OFF every incoming command, /ping included, is dropped, so the client
times out (exit 2) with a hint naming the toggle. Turning it OFF also sends
/listen 0 into route, closing error and the console gates.

DSP restore (v0.2.0): check sends /query before /open and resolves the DSP
state it found (/state/dsp, else 1 when dspstate~ reported a rate, else
unknown). After the record block it sends /dsp 0 only when DSP was off before
(or unknown and this run switched it on: warning dsp_state_unknown); DSP that
was on stays on. --leave-dsp-on never sends /dsp 0. --dsp-on-load (v0.3.0)
sends /dsp 1 just before /open, so DSP-time errors (gen~ compiles) post during
the load settle; the same restore rule applies.

Subcommands:
    python3 tools/max_bridge.py ping
    python3 tools/max_bridge.py check PATCH.maxpat [--settle S] [--record N]
        [--shot [PNG]] [--open-mode pcontrol|openfile] [--console-all]
        [--leave-dsp-on] [--dsp-on-load] [--load-timeout S]
        [--note PITCH VEL [--note-ms MS]] [--dry-run]
    python3 tools/max_bridge.py analyze OUT.wav [--channels L,R] [--sr N]

Exit codes (house convention, tools/audit_db.py): 0 clean, 1 findings
(errors, analysis flags, unsupported outputs, shot failure, feedback cap),
2 bridge failure (MAX not answering, timeout, bad input).

LAN CAVEAT: udpreceive has no bind-host option, so the bridge patch listens
on UDP 7400 on ALL network interfaces. Any host on the network can send it
/open, and a patch with js or node.script is code execution. Close the
bridge patch when not in use and deny incoming connections if macOS asks.
This client binds 127.0.0.1 only.

Stdlib only plus the declared numpy and scipy; subprocesses use argv lists,
never a shell.
"""

from __future__ import annotations

import argparse
import socket
import struct
import sys
import time
from pathlib import Path

# Project root: this file is at tools/max_bridge.py
REPO_ROOT = Path(__file__).resolve().parent.parent

# Allow `from src.maxpat...` when run as a script
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

BRIDGE_PORT = 7400
REPLY_PORT = 7401
HOST = "127.0.0.1"
# route arguments of the bridge patch, in outlet order (TestBridgePatch pins it)
# (v0.2.0 appends /query and /note, so outlets 0-8 and their cords never move)
ROUTE_ADDRESSES = (
    "/ping", "/open", "/sf", "/console", "/dsp", "/listen",
    "/close", "/openfile", "/closefile", "/query", "/note",
)
TAP_L = "__maxbridge_L"
TAP_R = "__maxbridge_R"
CLOSE_RECEIVE = "__maxbridge_close"
# the bridge's /note branch -> the temp copy's receive -> unpack 0 0 0 (v0.2.0)
NOTE_RECEIVE = "__maxbridge_note"
# the bridge's /query replies -> receive -> udpsend (Rule #4: no cross-patch cords)
REPLY_RECEIVE = "__maxbridge_reply"
# /query reply addresses: adstatus switch, adstatus sr, dspstate~ outlet 1
STATE_ADDRESSES = ("/state/dsp", "/state/adsr", "/state/sr")
COPY_PREFIX = "__maxbridge_"
# Shipped with the tools (WR-01, quick 261022-ud6): /patches is export-ignored,
# and a patch under patches/ would show up as a user project in /max-switch.
BRIDGE_PATCH = REPO_ROOT / "tools" / "max_bridge" / "max-bridge.maxpat"

DEFAULT_TIMEOUT = 2.0
MAX_EVENTS = 1000
_RCVBUF = 1 << 20

# Test seams: every clock read, poll sleep and the Bridge socket in this module
# go through these, so tests can run the waits on a virtual clock. Production
# uses the real functions; nothing else ever rebinds them.
# the clock behind every deadline and Bridge.now
_monotonic = time.monotonic
# every poll sleep (window, file and wav-size waits)
_sleep = time.sleep


def _udp_socket() -> socket.socket:
    """A new IPv4 UDP socket: the one the Bridge binds, sends and receives on."""
    return socket.socket(socket.AF_INET, socket.SOCK_DGRAM)


# ---------------------------------------------------------------------------
# OSC codec (stdlib)
# ---------------------------------------------------------------------------

def _osc_string(s: str) -> bytes:
    """NUL-terminated UTF-8, padded to a multiple of 4 bytes."""
    b = s.encode("utf-8")
    return b + b"\0" * (4 - len(b) % 4)


def osc_encode(address: str, *args) -> bytes:
    """One OSC message: address, type tags, arguments.

    int -> ``i`` (big-endian int32), float -> ``f`` (float32), str -> ``s``.
    """
    tags = ","
    payload = b""
    for a in args:
        if isinstance(a, bool):
            a = int(a)
        if isinstance(a, int):
            tags += "i"
            payload += struct.pack(">i", a)
        elif isinstance(a, float):
            tags += "f"
            payload += struct.pack(">f", a)
        elif isinstance(a, str):
            tags += "s"
            payload += _osc_string(a)
        else:
            raise TypeError(f"OSC argument {a!r}: only int, float and str are encoded")
    return _osc_string(address) + _osc_string(tags) + payload


def _read_string(packet: bytes, pos: int) -> tuple[str, int]:
    end = packet.find(b"\0", pos)
    if end < 0:
        raise ValueError("OSC string is not NUL-terminated (truncated packet)")
    nxt = (end + 4) & ~3
    if nxt > len(packet):
        raise ValueError("OSC string padding runs past the packet end")
    return packet[pos:end].decode("utf-8", errors="replace"), nxt


def _take(packet: bytes, pos: int, n: int) -> bytes:
    if pos + n > len(packet):
        raise ValueError("OSC argument runs past the packet end (truncated packet)")
    return packet[pos:pos + n]


def osc_decode(packet: bytes):
    """``(address, [args])`` for one OSC message, or None for a ``#bundle``.

    Accepts the tags ``i f d h s S T F N``. Raises ValueError on a truncated
    or malformed packet.
    """
    if packet.startswith(b"#bundle"):
        return None
    address, pos = _read_string(packet, 0)
    if not address.startswith("/"):
        raise ValueError(f"not an OSC address: {address!r}")
    if pos >= len(packet):
        return address, []
    tags, pos = _read_string(packet, pos)
    if not tags.startswith(","):
        raise ValueError(f"OSC type tag string must start with ',': {tags!r}")
    args: list = []
    for tag in tags[1:]:
        if tag == "i":
            args.append(struct.unpack(">i", _take(packet, pos, 4))[0])
            pos += 4
        elif tag == "f":
            args.append(struct.unpack(">f", _take(packet, pos, 4))[0])
            pos += 4
        elif tag == "d":
            args.append(struct.unpack(">d", _take(packet, pos, 8))[0])
            pos += 8
        elif tag == "h":
            args.append(struct.unpack(">q", _take(packet, pos, 8))[0])
            pos += 8
        elif tag in ("s", "S"):
            s, pos = _read_string(packet, pos)
            args.append(s)
        elif tag == "T":
            args.append(True)
        elif tag == "F":
            args.append(False)
        elif tag == "N":
            args.append(None)
        else:
            raise ValueError(f"unsupported OSC type tag {tag!r}")
    return address, args


# ---------------------------------------------------------------------------
# Bridge client
# ---------------------------------------------------------------------------

class BridgeError(RuntimeError):
    """The bridge cannot be reached or used (bind failure, socket error)."""


class BridgeTimeout(BridgeError):
    """No /pong arrived in time: MAX is not running or the bridge is closed."""


class Bridge:
    """UDP client of the bridge patch.

    Binds an unconnected socket on 127.0.0.1:reply_port (0 = ephemeral;
    ``self.reply_port`` is the bound port) and sends with sendto, so a closed
    bridge port times out instead of raising connection-refused. Every
    non-/pong packet received is appended to ``events`` as
    ``(t, address, args)`` (t in seconds since the Bridge was made) until
    MAX_EVENTS; then ``/listen 0`` is sent once, ``feedback_suspected`` is
    set and further events are dropped.
    """

    def __init__(self, host: str = HOST, port: int = BRIDGE_PORT,
                 reply_port: int = REPLY_PORT, timeout: float = DEFAULT_TIMEOUT,
                 max_events: int = MAX_EVENTS) -> None:
        self.host = host
        self.port = port
        self.timeout = timeout
        self.max_events = max_events
        self.events: list[tuple[float, str, list]] = []
        self.sent: list[tuple[str, tuple]] = []
        self.feedback_suspected = False
        self.t0 = _monotonic()
        self.sock = _udp_socket()
        try:
            self.sock.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, _RCVBUF)
        except OSError:
            pass
        try:
            self.sock.bind(("127.0.0.1", reply_port))
        except OSError as exc:
            self.sock.close()
            raise BridgeError(f"cannot bind reply port 127.0.0.1:{reply_port}: {exc}") from None
        self.reply_port = self.sock.getsockname()[1]

    def __enter__(self) -> "Bridge":
        return self

    def __exit__(self, *exc) -> None:
        self.close()

    def close(self) -> None:
        self.sock.close()

    def now(self) -> float:
        return _monotonic() - self.t0

    def send(self, address: str, *args) -> None:
        """Send one OSC message. /open and /openfile only take a COPY_PREFIX file."""
        if address in ("/open", "/openfile"):
            if not args or not Path(str(args[0])).name.startswith(COPY_PREFIX):
                raise ValueError(
                    f"{address} refused: only {COPY_PREFIX}* temp copies are opened, got {args!r}"
                )
        try:
            self.sock.sendto(osc_encode(address, *args), (self.host, self.port))
        except OSError as exc:
            raise BridgeError(f"send to {self.host}:{self.port} failed: {exc}") from None
        self.sent.append((address, tuple(args)))

    def _recv(self, deadline: float):
        """One decoded message before *deadline*, or None at the deadline."""
        while True:
            remaining = deadline - _monotonic()
            if remaining <= 0:
                return None
            self.sock.settimeout(remaining)
            try:
                data, _addr = self.sock.recvfrom(65536)
            except socket.timeout:
                return None
            except ConnectionRefusedError:
                continue  # an ICMP port-unreachable on some platforms: keep waiting
            except OSError as exc:
                raise BridgeError(f"receive on 127.0.0.1:{self.reply_port} failed: {exc}") from None
            try:
                msg = osc_decode(data)
            except ValueError:
                continue
            if msg is not None:
                return msg

    def _record(self, address: str, args: list) -> None:
        if self.feedback_suspected:
            return
        if len(self.events) >= self.max_events:
            self.feedback_suspected = True
            try:
                self.send("/listen", 0)
            except BridgeError:
                pass
            return
        self.events.append((round(self.now(), 4), address, list(args)))

    def collect(self, seconds: float) -> None:
        """Receive (and record) events for *seconds*."""
        deadline = _monotonic() + max(0.0, seconds)
        while True:
            msg = self._recv(deadline)
            if msg is None:
                return
            if msg[0] != "/pong":
                self._record(*msg)

    def ping(self, timeout: float | None = None) -> float:
        """Send /ping, wait for /pong; return the latency in seconds.

        Events arriving meanwhile are recorded. Raises BridgeTimeout.
        """
        timeout = self.timeout if timeout is None else timeout
        start = _monotonic()
        self.send("/ping")
        deadline = start + timeout
        while True:
            msg = self._recv(deadline)
            if msg is None:
                raise BridgeTimeout(
                    f"no /pong from {self.host}:{self.port} within {timeout:g} s"
                )
            if msg[0] == "/pong":
                return _monotonic() - start
            self._record(*msg)


# ---------------------------------------------------------------------------
# Temp-copy instrumentation
# ---------------------------------------------------------------------------

OUTPUT_BOXES = ("dac~", "ezdac~")
UNSUPPORTED_OUTPUTS = ("mc.dac~", "plugout~", "poly~", "pfft~")
_UNSUPPORTED_REASON = "external or multichannel output is not tapped in the spike"


def copy_path_for(src: Path) -> Path:
    """The sibling temp copy ``__maxbridge_<stem>.maxpat`` of *src*."""
    return src.parent / f"{COPY_PREFIX}{src.stem}.maxpat"


def _dac_channel(box, inlet: int) -> int | None:
    """The output channel a cord into *box* inlet *inlet* plays on."""
    if box.name == "ezdac~":
        return inlet + 1 if inlet in (0, 1) else None
    args = [a for a in box.text.split()[1:] if not a.startswith("@")]
    if not args:
        return inlet + 1
    if inlet >= len(args):
        return None
    try:
        return int(float(args[inlet]))
    except ValueError:
        return None


def _may_carry_audio(box, outlet: int) -> bool:
    """False only for an outlet known not to carry audio: typed non-signal
    (``int``, ``bang``, ...) or untyped on a box that cannot output signal."""
    types = getattr(box, "outlettype", None) or []
    kind = types[outlet] if 0 <= outlet < len(types) else ""
    if kind:
        return kind in ("signal", "multichannelsignal")
    return (box.name or "").endswith("~") or box.name in ("p", "patcher", "inlet")


def _instrument_patcher(p, path: str, report: dict) -> None:
    import warnings

    from src.maxpat.patcher import BoxMovedWarning

    by_id = {b.id: b for b in p.boxes}
    for box in list(p.boxes):
        if box.name in UNSUPPORTED_OUTPUTS or box.maxclass == "bpatcher":
            report["unsupported"].append({
                "box_id": box.id, "path": path,
                "name": "bpatcher" if box.maxclass == "bpatcher" else box.name,
                "reason": _UNSUPPORTED_REASON,
            })
        elif box.name in ("p", "patcher") and box._inner_patcher is not None:
            _instrument_patcher(box._inner_patcher, f"{path}/{box.id}", report)

    if not p.boxes:
        return
    # collect first, then place: each dac~/ezdac~ gets its own send~ pair
    # directly below it (D-04). Several send~ with one name sum, so the
    # recording is the same as one tap per side.
    tapped: list[tuple] = []
    warned: set = set()
    for line in list(p.lines):
        dst = by_id.get(line.dest_id)
        src = by_id.get(line.source_id)
        if dst is None or src is None or dst.name not in OUTPUT_BOXES:
            continue
        # a control cord into dac~ (toggle -> dac~ start/stop) carries no
        # audio, and MAX refuses it on send~ ("error connecting outlet 1 to
        # send~ inlet 1", gen-eq-test, MAX 9.2 2026-10-21). An untyped
        # outlet is audio only for a ~ object, a p subpatcher or an inlet.
        if not _may_carry_audio(src, line.source_outlet):
            continue
        ch = _dac_channel(dst, line.dest_inlet)
        side = {1: "L", 2: "R"}.get(ch)
        if side is None:
            if (dst.id, ch) not in warned:
                warned.add((dst.id, ch))
                report["warnings"].append(
                    f"{path}/{dst.id} {dst.text!r} inlet {line.dest_inlet} plays channel "
                    f"{ch}: only channels 1 and 2 are recorded, not tapped")
            continue
        tapped.append((src, line.source_outlet, dst, side))

    sends: dict[tuple, object] = {}
    for dst in [d for d in p.boxes if any(t[2] is d for t in tapped)]:
        sides = {t[3] for t in tapped if t[2] is dst}
        x0, y0 = dst.patching_rect[0], dst.bottom_edge + 20.0
        for side in ("L", "R"):
            if side not in sides:
                continue
            if side == "R" and (dst.id, "L") in sends:
                left = sends[(dst.id, "L")]
                x, y = left.right_edge + 15.0, left.patching_rect[1]
            else:
                x, y = x0, y0
            with warnings.catch_warnings():
                warnings.simplefilter("ignore", BoxMovedWarning)
                box = p.add_box("send~", [TAP_L if side == "L" else TAP_R], x=x, y=y,
                                skip_overlap_check=False)
            sends[(dst.id, side)] = box
            report["tap_boxes"].append({"path": path, "dac_id": dst.id, "side": side,
                                        "rect": list(box.patching_rect)})
    for src, outlet, dst, side in tapped:
        p.add_connection(src, outlet, sends[(dst.id, side)], 0)
        report["taps"][side] += 1


def _walk_patchers(p, path: str):
    """``(patcher, path)`` depth-first, top first, through embedded p/patcher
    subpatchers (bpatchers are skipped, as for the taps)."""
    yield p, path
    for box in p.boxes:
        if box.maxclass == "bpatcher":
            continue
        if box.name in ("p", "patcher") and box._inner_patcher is not None:
            yield from _walk_patchers(box._inner_patcher, f"{path}/{box.id}")


def _add_note_pair(p, x: float, y: float):
    """``receive __maxbridge_note`` -> ``unpack 0 0 0`` at (x, y), nudged off overlaps."""
    import warnings

    from src.maxpat.patcher import BoxMovedWarning

    with warnings.catch_warnings():
        warnings.simplefilter("ignore", BoxMovedWarning)
        rcv = p.add_box("receive", [NOTE_RECEIVE], x=x, y=y, skip_overlap_check=False)
        up = p.add_box("unpack", ["0", "0", "0"], x=rcv.patching_rect[0],
                       y=rcv.patching_rect[1] + 40.0, skip_overlap_check=False)
    p.add_connection(rcv, 0, up, 0)
    return rcv, up


def _inject_note(p, report: dict) -> None:
    """D-06: let the bridge's ``/note p v ch`` play the copy.

    In every patcher holding a notein, ``receive __maxbridge_note`` ->
    ``unpack 0 0 0`` mirrors each notein cord (outlet k -> the same dest and
    inlet, k < 3). unpack fires right to left (channel, velocity, pitch)
    like notein, so cold-before-hot holds (Rule #3). Only when no notein
    exists anywhere does it drive the first kslider instead (velocity into
    the cold inlet 1, then pitch into the hot inlet 0; kslider has no list
    method). Never both: that would be a double note-on.
    """
    tree = list(_walk_patchers(p, "top"))
    targets = []
    for q, path in tree:
        noteins = [b for b in q.boxes if b.name == "notein"]
        if noteins:
            targets.append((q, path, noteins))
    if targets:
        names = []
        for q, path, noteins in targets:
            n0 = noteins[0]
            _rcv, up = _add_note_pair(q, n0.right_edge + 15.0, n0.patching_rect[1])
            by_id = {b.id: b for b in q.boxes}
            ids = {n.id: n for n in noteins}
            seen: set = set()
            for line in list(q.lines):
                n = ids.get(line.source_id)
                if n is None or line.source_outlet >= min(3, n.numoutlets):
                    continue
                key = (line.source_outlet, line.dest_id, line.dest_inlet)
                dst = by_id.get(line.dest_id)
                if key in seen or dst is None:
                    continue
                seen.add(key)
                q.add_connection(up, line.source_outlet, dst, line.dest_inlet)
            names += [f"{path}/{n.id}" for n in noteins]
        report["note_target"] = {"kind": "notein", "boxes": names}
        return
    for q, path in tree:
        ks = next((b for b in q.boxes if b.maxclass == "kslider"), None)
        if ks is None:
            continue
        _rcv, up = _add_note_pair(q, ks.right_edge + 15.0, ks.patching_rect[1])
        q.add_connection(up, 1, ks, 1)  # velocity: cold, sets without output
        q.add_connection(up, 0, ks, 0)  # pitch: hot, plays
        report["note_target"] = {"kind": "kslider", "box": f"{path}/{ks.id}"}
        return
    report["warnings"].append("--note: no notein or kslider to drive")
    report["note_target"] = None


def _load_patch(src: Path):
    """Parse *src*: (Patcher, file text); every malformed-input failure is ValueError.

    (OSError for an unreadable file passes through.) run_check maps both to
    exit 2, bad input (WR-04, quick 261022-ud6): a truncated or non-patch
    file must never surface as a traceback with exit 1 ("findings").
    """
    import json

    from src.maxpat.patcher import Patcher

    text = src.read_text(encoding="utf-8")  # UnicodeDecodeError is a ValueError
    data = json.loads(text)  # JSONDecodeError is a ValueError
    if not isinstance(data, dict) or not isinstance(data.get("patcher"), dict):
        raise ValueError("not a MAX patch (no top-level \"patcher\" object)")
    try:
        return Patcher.from_dict(data), text
    except (KeyError, TypeError, AttributeError, IndexError) as exc:
        raise ValueError(f"not a MAX patch ({type(exc).__name__}: {exc})") from exc


def instrument(src: Path, note: bool = False) -> tuple[Path, dict]:
    """Write the instrumented sibling copy of *src*; return (copy_path, report).

    The copy adds ``send~ __maxbridge_L/R`` taps fed from every dac~/ezdac~
    input source (channel 1 -> L, 2 -> R; existing cords untouched), placed
    directly below each dac~ (L at its x, R 15 px right of L; nudged down
    only on a real overlap; v0.2.0), in the
    top patcher and every embedded ``p`` subpatcher, plus a cordless close
    hook (``receive __maxbridge_close`` -> ``clean, wclose`` ->
    ``thispatcher``) at the top level. It is built with the Patcher API and
    written with format_patch_text + atomic_write_bytes, never
    save_patch_roundtrip: the copy is ephemeral, gitignored and deleted by
    the caller (research A6). The source file is only read.

    With *note* (check --note), ``receive __maxbridge_note`` ->
    ``unpack 0 0 0`` is added to drive the notein cords (kslider fallback;
    see _inject_note).

    Report keys: taps {L, R} (cords tapped), tap_boxes ([{path, dac_id,
    side, rect}] per send~), note_target (None, or {kind: notein, boxes}
    / {kind: kslider, box}), unsupported (mc.dac~, plugout~,
    poly~, pfft~, bpatcher boxes), warnings (channels above 2),
    no_output_tap, close_hook.
    """
    from src.maxpat.atomic_io import atomic_write_bytes
    from src.maxpat.hooks import format_patch_text

    src = Path(src)
    p, text = _load_patch(src)
    report: dict = {"taps": {"L": 0, "R": 0}, "tap_boxes": [], "unsupported": [],
                    "warnings": [], "no_output_tap": False, "close_hook": False,
                    "note_target": None}
    _instrument_patcher(p, "top", report)
    if note:
        _inject_note(p, report)

    right = (max(b.right_edge for b in p.boxes) if p.boxes else 0.0) + 30.0
    top = min((b.patching_rect[1] for b in p.boxes), default=20.0) + 70.0
    rcv = p.add_box("receive", [CLOSE_RECEIVE], x=right, y=top, skip_overlap_check=True)
    msg = p.add_message("clean, wclose", x=right, y=top + 40)
    tp = p.add_box("thispatcher", x=right, y=top + 80, skip_overlap_check=True)
    p.add_connection(rcv, 0, msg, 0)
    p.add_connection(msg, 0, tp, 0)
    report["close_hook"] = True
    report["no_output_tap"] = report["taps"]["L"] + report["taps"]["R"] == 0

    copy = copy_path_for(src)
    atomic_write_bytes(copy, format_patch_text(p.to_dict(), text).encode("utf-8"))
    return copy, report


# ---------------------------------------------------------------------------
# Analysis
# ---------------------------------------------------------------------------

DC_OFFSET_LIMIT = 0.01  # [ASSUMED] research A5: tune after real runs
END_TRIM_MS = 50  # sfrecord~ endramp default is undocumented (research pitfall 6)


def analyze(wav: Path, channels: list[str] | None = None, max_sr: float | None = None,
            expected_seconds: float | None = None) -> dict:
    """dsp_sim measures of a recorded wav, per channel (index 0 = L, 1 = R).

    *max_sr* is MAX's own DSP rate (D-03). When it differs from the wav
    header by 1 Hz or more, every rate-dependent step (trims, pitch,
    seconds) uses it, ``header_sample_rate`` keeps the header's rate and a
    ``sr_header_mismatch`` warning (never a flag) is added. ``sample_rate``
    is the rate actually used.

    Either side can be the wrong one (MAX 9.2): with MAX at 44.1k on a 48k
    interface sfrecord~ stamped 48k on 44.1k audio, and later adstatus
    reported 44.1k while the audio ran at 48k. sfrecord~'s ``record <ms>``
    counts samples at the rate the audio really runs, so with
    *expected_seconds* (the requested length) the mismatch is settled by the
    frame count: the rate whose duration is closer to it is used.

    NaN and inf are counted on the whole channel; the metrics come from the
    finite samples left after trimming ClassifierThresholds().settle_ms from
    the start and END_TRIM_MS from the end. Flags: nonfinite, runaway
    (peak > runaway_amplitude), clipping (peak > 1.0), silent (ac_rms <
    amplitude_floor), dc_offset (|dc| > DC_OFFSET_LIMIT).
    """
    import numpy as np
    from scipy.io import wavfile

    from src.maxpat.dsp_sim.measure import (
        ClassifierThresholds, measure_ac_rms, measure_fundamental, measure_peak, measure_rms,
    )

    th = ClassifierThresholds()
    header_sr, x = wavfile.read(str(wav))
    header_sr = int(header_sr)
    sr = header_sr
    x = np.asarray(x)
    if x.ndim == 1:
        x = x[:, None]
    warnings_out: list[str] = []
    if max_sr and abs(float(max_sr) - header_sr) >= 1:
        dsp_sr = int(round(float(max_sr)))
        sr = dsp_sr
        why = ""
        if expected_seconds:
            n_frames = x.shape[0]
            if abs(n_frames / header_sr - expected_seconds) < abs(n_frames / dsp_sr - expected_seconds):
                sr = header_sr
            why = f" (the frame count matches {float(expected_seconds):g} s at {sr} Hz)"
        warnings_out.append(f"sr_header_mismatch: header {header_sr} Hz, MAX DSP {dsp_sr} Hz; "
                            f"analyzed at {sr} Hz{why}")
    if x.dtype.kind == "u":
        half = float(2 ** (8 * x.dtype.itemsize - 1))
        x = (x.astype(np.float64) - half) / half
        warnings_out.append(f"integer wav ({x.dtype}): scaled to float; NaN is undetectable")
    elif x.dtype.kind == "i":
        scale = float(2 ** (8 * x.dtype.itemsize - 1))
        warnings_out.append(f"integer wav ({x.dtype}): scaled to float; NaN is undetectable")
        x = x.astype(np.float64) / scale
    else:
        x = x.astype(np.float64)

    names = ["L", "R"] + [f"ch{i + 1}" for i in range(2, x.shape[1])]
    names = names[:x.shape[1]]
    wanted = names if channels is None else [c for c in names if c in channels]
    n = x.shape[0]
    start = int(sr * th.settle_ms / 1000)
    end = max(start, n - int(sr * END_TRIM_MS / 1000))
    out: dict = {}
    for i, name in enumerate(names):
        if name not in wanted:
            continue
        col = x[:, i]
        nan = int(np.isnan(col).sum())
        inf = int(np.isinf(col).sum())
        seg = col[start:end]
        seg = seg[np.isfinite(seg)]
        m = {
            "nan": nan,
            "inf": inf,
            "peak": measure_peak(seg),
            "rms": measure_rms(seg),
            "ac_rms": measure_ac_rms(seg),
            "dc": float(np.mean(seg)) if seg.size else 0.0,
            "pitch_hz": measure_fundamental(seg, sr),
        }
        flags = []
        if nan or inf:
            flags.append("nonfinite")
        if m["peak"] > th.runaway_amplitude:
            flags.append("runaway")
        if m["peak"] > 1.0:
            flags.append("clipping")
        if m["ac_rms"] < th.amplitude_floor:
            flags.append("silent")
        if abs(m["dc"]) > DC_OFFSET_LIMIT:
            flags.append("dc_offset")
        m["flags"] = flags
        out[name] = m
    return {
        "wav": str(wav),
        "sample_rate": int(sr),
        "header_sample_rate": header_sr,
        "seconds": round(n / float(sr), 4) if sr else 0.0,
        "channels": out,
        "flags": sorted({f for m in out.values() for f in m["flags"]}),
        "warnings": warnings_out,
    }


# ---------------------------------------------------------------------------
# Screenshot
# ported from MUSC320 tools/patch_shot.py @ 1009e5c (_CG_WINDOWS_JXA, _osascript,
# cg_windows, _find_window, _wait_window, _wait_gone, _capture); the
# presentation keystroke and the AX close button are deliberately not ported.
# ---------------------------------------------------------------------------

APP = "Max"
SHOT_LOAD_SETTLE = 1.0
SHOT_POLL = 0.5
SHOT_TITLE_TIMEOUT = 10.0
OSA_TIMEOUT = 15

# CoreGraphics window list: every onscreen layer-0 (document) window owned by
# Max, with its window id and bounds. kCGWindowListOptionAll = 0,
# kCGNullWindowID = 0. A closed patcher's window lingers offscreen
# (kCGWindowIsOnscreen false), so offscreen windows are skipped: otherwise
# wait_gone never sees the close and a stale window can be captured
# (confirmed in MAX 9.2, 2026-10-21).
_CG_WINDOWS_JXA = '''
ObjC.import("CoreGraphics");
var arr = ObjC.castRefToObject($.CGWindowListCopyWindowInfo(0, 0));
var info = ObjC.deepUnwrap(arr) || [];
var out = [];
for (var i = 0; i < info.length; i++) {
  var w = info[i];
  if (w.kCGWindowOwnerName === "{app}" && w.kCGWindowLayer === 0 && w.kCGWindowIsOnscreen) {
    var b = w.kCGWindowBounds;
    out.push([w.kCGWindowNumber, w.kCGWindowName || "", b.X, b.Y, b.Width, b.Height].join("\\t"));
  }
}
out.join("\\n");
'''


class ShotError(RuntimeError):
    """A screenshot step failed; the message says which."""


def _run(cmd: list[str], timeout: float):
    """subprocess.run with an argv list (never a shell); tests replace it."""
    import subprocess

    return subprocess.run(cmd, capture_output=True, text=True, timeout=timeout)


def _osascript(script: str, timeout: float = OSA_TIMEOUT, language: str | None = None) -> str:
    import subprocess

    cmd = ["osascript"]
    if language:
        cmd += ["-l", language]
    cmd += ["-e", script]
    try:
        proc = _run(cmd, timeout)
    except (OSError, subprocess.TimeoutExpired) as exc:
        raise ShotError(f"osascript did not run: {exc}") from None
    if proc.returncode != 0:
        tail = " | ".join((proc.stderr or "").strip().splitlines()[-3:])
        raise ShotError(f"osascript exited {proc.returncode}: {tail}")
    return (proc.stdout or "").strip()


def cg_windows() -> list[tuple]:
    """``[(window_id, name, x, y, w, h)]`` for every Max document window."""
    text = _osascript(_CG_WINDOWS_JXA.replace("{app}", APP), language="JavaScript")
    rows = []
    for line in text.splitlines():
        parts = line.split("\t")
        if len(parts) != 6:
            continue
        try:
            rows.append((int(parts[0]), parts[1], *(int(float(v)) for v in parts[2:])))
        except ValueError:
            continue
    return rows


def _find_window(prefix: str):
    for row in cg_windows():
        if row[1].startswith(prefix):
            return row
    return None


def _wait_window(prefix: str, timeout: float):
    """The window row once it exists and its title has held still."""
    deadline = _monotonic() + timeout
    while True:
        row = _find_window(prefix)
        if row is not None:
            break
        if _monotonic() >= deadline:
            raise ShotError(f"no Max window named {prefix!r} within {timeout:g} s "
                            "(Screen Recording permission missing?)")
        _sleep(SHOT_POLL)
    _sleep(SHOT_LOAD_SETTLE)
    stable_deadline = _monotonic() + SHOT_TITLE_TIMEOUT
    last = None
    while _monotonic() < stable_deadline:
        row = _find_window(prefix)
        if row is None:
            raise ShotError(f"window for {prefix!r} vanished while loading")
        if last is not None and row[1] == last[1]:
            return row
        last = row
        _sleep(SHOT_POLL)
    raise ShotError(f"title of the {prefix!r} window kept changing")


def wait_gone(window_id: int, timeout: float = 5.0) -> bool:
    """True once *window_id* is no longer in the window list."""
    deadline = _monotonic() + timeout
    while True:
        if all(row[0] != window_id for row in cg_windows()):
            return True
        if _monotonic() >= deadline:
            return False
        _sleep(min(0.25, SHOT_POLL))


def _capture(window_id: int, png: Path) -> None:
    import subprocess

    cmd = ["screencapture", "-x", "-o", "-l", str(window_id), str(png)]
    try:
        proc = _run(cmd, OSA_TIMEOUT)
    except (OSError, subprocess.TimeoutExpired) as exc:
        raise ShotError(f"screencapture did not run: {exc}") from None
    if proc.returncode != 0:
        raise ShotError(f"screencapture exited {proc.returncode}: {(proc.stderr or '').strip()}")
    if not png.is_file() or png.stat().st_size == 0:
        raise ShotError("screencapture wrote no image (Screen Recording permission missing?)")


def shoot(title_prefix: str, png: Path, timeout: float = 10.0) -> dict:
    """Capture the Max window whose title starts with *title_prefix* (by window id).

    A presentation-mode patch is captured as shown (title ``<stem>
    (presentation)``); no keystroke is sent. Raises ShotError.
    """
    png = Path(png)
    png.parent.mkdir(parents=True, exist_ok=True)
    window_id, title, _x, _y, w, h = _wait_window(title_prefix, timeout)
    _capture(window_id, png)
    return {"window_id": window_id, "title": title, "width": w, "height": h}


# ---------------------------------------------------------------------------
# check: the full sequence
# ---------------------------------------------------------------------------

ERROR_WORDINGS = ("no such object", "bad argument", "failed to compile", "can't assign")
WAV_STABLE_TIMEOUT = 5.0
CONSOLE_FILE_TIMEOUT = 2.0


class InputRefused(ValueError):
    """The check input failed the path guard."""


def _allowed_roots() -> list[Path]:
    import tempfile

    return [REPO_ROOT, Path(tempfile.gettempdir())]


def _make_run_dir() -> Path:
    import tempfile

    return Path(tempfile.mkdtemp(prefix="maxbridge-"))


def guard_input(path: Path) -> Path:
    """The resolved input; InputRefused unless it is an existing .maxpat
    under REPO_ROOT or the system temp dir (after realpath)."""
    import os

    p = Path(path)
    if p.suffix != ".maxpat":
        raise InputRefused(f"refused: {path} is not a .maxpat")
    if not p.is_file():
        raise InputRefused(f"refused: {path} does not exist")
    real = Path(os.path.realpath(p))
    for root in _allowed_roots():
        r = Path(os.path.realpath(root))
        if real == r or r in real.parents:
            break
    else:
        raise InputRefused(f"refused: {real} is outside the repo and the temp dir")
    if real.name.startswith(COPY_PREFIX):
        raise InputRefused(f"refused: {real.name} is itself a bridge temp copy")
    return real


def _resolve_note_ms(record_s: float, note_ms: int | None) -> int:
    """The note-on length in ms (D-06): *note_ms*, else 75% of the record,
    clamped to [1, record length]."""
    total = max(1, int(round(record_s * 1000)))
    ms = int(round(total * 0.75)) if note_ms is None else int(note_ms)
    return max(1, min(ms, total))


RESTORE_DSP = ("/dsp", (0,))  # the single restore slot (D-02); sent only when DSP was off before


def plan_messages(copy: Path, run_dir: Path, opts, tapped: bool = True) -> list[tuple]:
    """Every message check sends, in order (research Architecture).

    /ping (existence), /query, /ping (barrier: the /state replies precede
    the /pong) come before /open, so a patch that starts DSP at load cannot
    hide the prior state. The ``("/dsp", (0,))`` restore slot follows the
    record block whether or not --record was given (absent with
    --leave-dsp-on); _execute decides whether to send it.
    """
    run_dir = Path(run_dir)
    openfile = getattr(opts, "open_mode", "pcontrol") == "openfile"
    plan: list[tuple] = [("/ping", ()), ("/query", ()), ("/ping", ())]
    plan.append(("/console", ("write", str(run_dir / "before.txt"))))
    if opts.console_all:
        plan.append(("/console", ("showonlyerrors", 0)))
    plan.append(("/listen", (1,)))
    if getattr(opts, "dsp_on_load", False):
        # v0.3.0: right before the opener, never between it and its /ping
        # (_execute keys the load wait on prev in openers)
        plan.append(("/dsp", (1,)))
    plan.append(("/openfile" if openfile else "/open", (str(copy),)))
    plan.append(("/ping", ()))
    if opts.record and tapped:
        plan += [
            ("/dsp", (1,)),
            ("/sf", ("samptype", "float32")),
            ("/sf", ("open", str(run_dir / "out.wav"))),
            ("/sf", ("record", int(round(opts.record * 1000)))),
            ("/query", ()),  # DSP is surely on: dspstate~ reports the rate
        ]
        note = getattr(opts, "note", None)
        if note:
            plan += [("/note", (int(note[0]), int(note[1]), 1)),
                     ("/note", (int(note[0]), 0, 1))]
        plan += [
            ("/sf", (0,)),
            ("/ping", ()),
        ]
    if not opts.leave_dsp_on:
        plan.append(RESTORE_DSP)
    plan.append(("/console", ("write", str(run_dir / "after.txt"))))
    plan.append(("/listen", (0,)))
    if opts.console_all:
        plan.append(("/console", ("showonlyerrors", 1)))
    plan.append(("/closefile", ()) if openfile else ("/close", ()))
    plan.append(("/ping", ()))
    return plan


def _wait_file(path: Path, timeout: float) -> bool:
    deadline = _monotonic() + timeout
    while True:
        if path.is_file():
            return True
        if _monotonic() >= deadline:
            return False
        _sleep(0.05)


def _wait_stable(path: Path, timeout: float = WAV_STABLE_TIMEOUT) -> bool:
    """True once *path* exists and its size holds for 3 reads 100 ms apart."""
    deadline = _monotonic() + timeout
    sizes: list[int] = []
    while _monotonic() < deadline:
        size = path.stat().st_size if path.is_file() else -1
        sizes = (sizes + [size])[-3:]
        if len(sizes) == 3 and size > 0 and len(set(sizes)) == 1:
            return True
        _sleep(0.1)
    return False


def _is_error_text(text: str) -> bool:
    low = text.lower()
    return any(w in low for w in ERROR_WORDINGS)


def _error_lines(events: list, console_all: bool, console_new: list[str]) -> list[dict]:
    """Error lines from the /err stream, the console stream and the console-write diff."""
    errors: list[dict] = []
    for t, address, args in events:
        if address == "/err":
            words = [str(a) for a in args]
            if words and words[0] == "error":
                words = words[1:]
            errors.append({"source": "error", "text": " ".join(words), "t": t})
    for k, (t, address, args) in enumerate(events):
        if address != "/con/msg":
            continue
        text = " ".join(str(a) for a in args)
        if console_all and not _is_error_text(text):
            continue
        # console's outlets fire type -> msg -> obj for one message (MAX 9.2,
        # 2026-10-21), so the type is the nearest /con/type BEFORE this msg
        # and the obj the nearest /con/obj AFTER it, never crossing another
        # /con/msg (a burst of messages otherwise takes its neighbour's obj)
        near = {}
        for j in range(k - 1, -1, -1):
            tj, aj, argsj = events[j]
            if aj == "/con/msg" or abs(tj - t) > 0.05:
                break
            if aj == "/con/type":
                near[aj] = argsj
                break
        for j in range(k + 1, len(events)):
            tj, aj, argsj = events[j]
            if aj == "/con/msg" or abs(tj - t) > 0.05:
                break
            if aj == "/con/obj":
                near[aj] = argsj
                break
        errors.append({"source": "console", "text": text, "t": t,
                       "obj": near.get("/con/obj"), "type": near.get("/con/type")})
    for line in console_new:
        if _is_error_text(line):
            errors.append({"source": "console_write", "text": line, "t": None})
    return errors


def _error_key(entry: dict) -> str:
    """The canonical text of one raw error entry (D-05).

    Console entries with an object name become ``"{obj}: {msg}"`` (the obj
    words joined, a trailing ':' stripped); every other entry is its text.
    Double quotes are dropped and whitespace is collapsed, then a doubled leading ``"X: X: "`` collapses
    to ``"X: "`` (repeatedly), so ``osc~: osc~: No such object`` on the
    error and console_write channels meets the console's ``osc~`` +
    ``No such object``.
    """
    import re

    text = str(entry.get("text") or "")
    obj = entry.get("obj")
    if entry.get("source") == "console" and obj:
        name = " ".join(str(a) for a in obj).strip().rstrip(":").strip()
        if name:
            text = f"{name}: {text}"
    # the console file keeps double quotes that the UDP stream drops
    # (`[string "-- main2.lua..."]` vs `[string -- main2.lua...]`)
    key = " ".join(text.replace('"', "").split())
    while True:
        new = re.sub(r"^(\S+): \1: ", r"\1: ", key)
        if new == key:
            return key
        key = new


_ERROR_SOURCES = ("error", "console", "console_write")


def _distinct_errors(errors: list[dict]) -> list[dict]:
    """One entry per canonical error key, in first-seen order (D-05).

    Each entry: ``key``, ``sources`` (counts per channel: error, console,
    console_write), ``occurrences`` (the max over channels: every channel
    sees every posting) and ``first_t`` (the earliest non-None t). A key
    equal to another with one leading ``"word: "`` removed merges into that
    longer key. *errors* is never modified.
    """
    import re

    groups: dict[str, dict] = {}
    for i, e in enumerate(errors):
        key = _error_key(e)
        g = groups.setdefault(key, {"key": key, "sources": dict.fromkeys(_ERROR_SOURCES, 0),
                                    "ts": [], "first": i})
        src = e.get("source")
        g["sources"][src] = g["sources"].get(src, 0) + 1
        if e.get("t") is not None:
            g["ts"].append(e["t"])
    merged = True
    while merged:
        merged = False
        for key in list(groups):
            short = re.sub(r"^\S+: ", "", key, count=1)
            if short != key and short in groups:
                long_g, short_g = groups[key], groups.pop(short)
                for src, n in short_g["sources"].items():
                    long_g["sources"][src] = long_g["sources"].get(src, 0) + n
                long_g["ts"] += short_g["ts"]
                long_g["first"] = min(long_g["first"], short_g["first"])
                merged = True
                break
    return [
        {
            "key": g["key"],
            "sources": g["sources"],
            "occurrences": max(g["sources"].values()),
            "first_t": min(g["ts"]) if g["ts"] else None,
        }
        for g in sorted(groups.values(), key=lambda g: g["first"])
    ]


def _console_diff(run_dir: Path) -> tuple[str, list[str]]:
    from collections import Counter

    before, after = run_dir / "before.txt", run_dir / "after.txt"
    if not (_wait_file(before, CONSOLE_FILE_TIMEOUT) and _wait_file(after, CONSOLE_FILE_TIMEOUT)):
        return "unavailable", []
    seen = Counter(before.read_text(errors="replace").splitlines())
    new = []
    for line in after.read_text(errors="replace").splitlines():
        if seen[line] > 0:
            seen[line] -= 1
        elif line.strip():
            new.append(line)
    return "ok", new


def _dsp_before(events: list):
    """The DSP state found before /open, from /query replies (D-02).

    The first ``/state/dsp`` value (adstatus switch); else 1 when a
    ``/state/sr`` arrived (dspstate~ is silent while DSP is off); else None
    (an older bridge patch that ignores /query).
    """
    for e in events:
        address, args = e[-2], e[-1]
        if address == "/state/dsp" and args:
            try:
                return int(args[0])
            except (TypeError, ValueError):
                continue
    return 1 if any(e[-2] == "/state/sr" for e in events) else None


DSP_UNKNOWN_WARNING = ("dsp_state_unknown: the bridge did not answer /query (an older bridge "
                       "patch?); DSP is switched off after --record as in v0.1.0")


def _execute(b: Bridge, plan: list[tuple], args, run_dir: Path, copy: Path, report: dict) -> None:
    """Send *plan* with the barrier waits; fill *report* in place."""
    openers = ("/open", "/openfile")
    closers = ("/close", "/closefile")
    window_id = None
    dsp_resolved = False
    t_rec = None  # when /sf record was sent: the note-off and /sf 0 are timed from it
    note_ms = (_resolve_note_ms(args.record, getattr(args, "note_ms", None))
               if getattr(args, "note", None) and args.record else None)
    try:
        for i, (address, margs) in enumerate(plan):
            prev = plan[i - 1][0] if i else None
            if address == "/note" and len(margs) > 1 and margs[1] == 0 and t_rec is not None:
                b.collect(max(0.0, note_ms / 1000.0 - (b.now() - t_rec)))
            if address == "/sf" and margs == (0,):
                elapsed = b.now() - t_rec if t_rec is not None else 0.0
                b.collect(max(0.0, args.record + 0.5 - elapsed))
            if (address, margs) == RESTORE_DSP:
                before = report.get("dsp_before")
                if before == 0 or (before is None and report.get("_dsp_on")):
                    b.send(address, *margs)
                    report["_dsp_on"] = False
                    report["dsp_stop_sent"] = True
                continue
            if address in closers and args.shot is not None:
                png = Path(args.shot) if args.shot else run_dir / "shot.png"
                try:
                    report["shot"] = shoot(COPY_PREFIX + Path(args.patch).stem, png)
                    report["shot"]["png"] = str(png)
                    window_id = report["shot"]["window_id"]
                except ShotError as exc:
                    report["shot"] = {"error": str(exc), "png": str(png)}
            if address != "/ping":
                b.send(address, *margs)
                if address == "/sf" and margs[:1] == ("record",):
                    t_rec = b.now()
                    report["_t_rec"] = t_rec
                if address in openers:
                    report["load"]["open_s"] = round(b.now(), 4)
                elif address == "/dsp":
                    report["_dsp_on"] = margs == (1,)
                elif address in closers:
                    report["_closed_sent"] = True
                continue
            if prev == "/query" and not dsp_resolved:
                b.ping(args.timeout)
                dsp_resolved = True
                report["dsp_before"] = _dsp_before(b.events)
                if report["dsp_before"] is None:
                    report["warnings"].append(DSP_UNKNOWN_WARNING)
            elif prev in openers:
                b.ping(args.load_timeout)
                report["load"]["pong_s"] = round(b.now(), 4)
                b.collect(args.settle)
            elif prev == "/sf":
                b.ping(args.timeout)
                wav = run_dir / "out.wav"
                if not _wait_stable(wav):
                    raise BridgeError(f"{wav} never appeared or never stopped growing")
                report["_wav"] = wav
            else:
                b.ping(args.timeout)
                if prev in closers and args.shot is not None:
                    if window_id is not None:
                        report["closed"] = bool(wait_gone(window_id, 5.0))
                    else:
                        try:
                            report["closed"] = _find_window(COPY_PREFIX + Path(args.patch).stem) is None
                        except ShotError:
                            report["closed"] = False
    except BridgeError:
        # best effort: leave MAX as we found it, without waiting for answers
        cleanup: list[tuple] = [("/listen", (0,))]
        if report.get("_dsp_on") and report.get("dsp_before") != 1 and not args.leave_dsp_on:
            cleanup.append(("/dsp", (0,)))
        if any(a in openers for a, _ in b.sent) and not report.get("_closed_sent"):
            cleanup.append(("/closefile", ()) if args.open_mode == "openfile" else ("/close", ()))
        for address, margs in cleanup:
            try:
                b.send(address, *margs)
            except BridgeError:
                pass
        raise


def _max_sr(events: list) -> int | None:
    """MAX's own DSP rate from the /query replies (D-03): the last
    ``/state/sr`` (dspstate~ outlet 1, the rate the oscillators run at),
    else the last ``/state/adsr``; None when neither arrived."""
    for address in ("/state/sr", "/state/adsr"):
        for e in reversed(events):
            if e[-2] != address or not e[-1]:
                continue
            try:
                value = int(round(float(e[-1][0])))
            except (TypeError, ValueError):
                continue
            if value > 0:
                return value
    return None


SHORT_RECORDING_RATIO = 0.9  # a wav shorter than this share of --record is cut short


def _sr_timeline(events: list) -> list[tuple[float, int]]:
    """``[(t, rate)]`` from every positive ``/state/sr`` and ``/state/adsr``.

    adstatus and dspstate~ also report unprompted when the driver changes
    rate, so this is a timeline, not just the /query answers (confirmed in
    MAX 9.2, 2026-10-21: 44100 -> 48000 -> 44100 while DSP started)."""
    out = []
    for e in events:
        if e[-2] not in ("/state/sr", "/state/adsr") or not e[-1]:
            continue
        try:
            value = int(round(float(e[-1][0])))
        except (TypeError, ValueError):
            continue
        if value > 0:
            out.append((float(e[0]), value))
    return out


def _record_sr(events: list, t0: float, t1: float) -> tuple[int | None, list[int]]:
    """MAX's rate for a recording from *t0* to *t1*: ``(rate at t1, distinct
    rates in effect over the window)``. The rate in effect at *t0* is the
    last report at or before it. ``(None, [])`` when no rate was reported."""
    timeline = _sr_timeline(events)
    if not timeline:
        return None, []
    before = [r for t, r in timeline if t <= t0]
    inside = [r for t, r in timeline if t0 < t <= t1]
    seen = before[-1:] + inside
    if not seen:
        seen = [timeline[0][1]]
    return seen[-1], sorted(set(seen))


def run_check(args) -> dict:
    """Run one check; return the JSON report (``exit_code`` included)."""
    report: dict = {
        "patch": str(args.patch), "copy": None, "run_dir": None, "taps": None,
        "unsupported": [], "warnings": [], "load": {"open_s": None, "pong_s": None},
        "errors": [], "events_raw": [], "record": None, "shot": None, "closed": None,
        "feedback_suspected": False, "console_write": None,
        "errors_distinct": [], "max_sr": None, "note": None, "note_target": None,
        "dsp_before": None, "dsp_stop_sent": False,
        "verdict": "bridge_failed", "exit_code": 2,
    }
    try:
        src = guard_input(Path(args.patch))
    except InputRefused as exc:
        report["error"] = str(exc)
        return report
    report["patch"] = str(src)
    note = getattr(args, "note", None)
    try:
        copy, inst = instrument(src, note=bool(note))
    except (OSError, ValueError) as exc:  # JSONDecodeError is a ValueError (WR-04)
        report["error"] = f"cannot read {src}: {exc}"
        return report  # verdict bridge_failed, exit_code 2, copy None
    report.update(copy=str(copy), taps=inst["taps"], tap_boxes=inst["tap_boxes"],
                  unsupported=inst["unsupported"], warnings=inst["warnings"],
                  note_target=inst["note_target"])
    if note:
        report["note"] = {"pitch": int(note[0]), "vel": int(note[1]),
                          "ms": _resolve_note_ms(args.record, getattr(args, "note_ms", None))}
    try:
        run_dir = Path(_make_run_dir())
        report["run_dir"] = str(run_dir)
        plan = plan_messages(copy, run_dir, args, tapped=not inst["no_output_tap"])
        if args.dry_run:
            report["plan"] = [
                " ".join([a, *(str(x) for x in m)])
                + ("  (restore: only if DSP was off before the check)" if (a, m) == RESTORE_DSP else "")
                for a, m in plan
            ]
            report["verdict"], report["exit_code"] = "dry_run", 0
            try:
                run_dir.rmdir()  # nothing was written there
            except OSError:
                pass
            return report
        try:
            with Bridge(HOST, args.port, args.reply_port, args.timeout,
                        max_events=MAX_EVENTS) as b:
                try:
                    _execute(b, plan, args, run_dir, copy, report)
                finally:
                    report["events_raw"] = [list(e) for e in b.events]
                    report["feedback_suspected"] = b.feedback_suspected
        except BridgeError as exc:
            report["error"] = str(exc)
            return report
    finally:
        copy.unlink(missing_ok=True)
        report.pop("_dsp_on", None)
        report.pop("_closed_sent", None)

    status, new_lines = _console_diff(run_dir)
    report["console_write"] = {"status": status, "new_lines": new_lines}
    report["errors"] = _error_lines(b.events, args.console_all, new_lines)
    report["errors_distinct"] = _distinct_errors(report["errors"])
    report["max_sr"] = _max_sr(b.events)
    t_rec = report.pop("_t_rec", None)
    rec_rates: list[int] = []
    if t_rec is not None and args.record:
        rec_sr, rec_rates = _record_sr(b.events, t_rec, t_rec + float(args.record) + 0.5)
        if rec_sr is not None:
            report["max_sr"] = rec_sr
    wav = report.pop("_wav", None)
    if wav is not None:
        a = analyze(wav, max_sr=report["max_sr"],
                    expected_seconds=float(args.record) if args.record else None)
        flags = list(a["flags"])
        warnings_out = list(a["warnings"])
        if len(rec_rates) > 1:
            flags.append("sr_changed_during_run")
            warnings_out.append(
                "sr_changed_during_run: MAX's sample rate changed while recording (rates seen: "
                + ", ".join(str(r) for r in rec_rates)
                + f" Hz); analyzed at {a['sample_rate']} Hz, measures unreliable")
        if args.record and a["seconds"] < SHORT_RECORDING_RATIO * float(args.record):
            flags.append("short_recording")
            warnings_out.append(
                f"short_recording: {a['seconds']} s recorded of {float(args.record):g} s requested "
                "(the audio driver restarted, or DSP stopped, mid-recording)")
        report["record"] = {"wav": str(wav), "seconds": a["seconds"],
                            "sample_rate": a["sample_rate"],
                            "header_sample_rate": a["header_sample_rate"],
                            "channels": a["channels"],
                            "flags": sorted(set(flags)), "warnings": warnings_out}
    findings = (
        bool(report["errors"])
        or bool(report["record"] and report["record"]["flags"])
        or bool(report["unsupported"])
        or bool(args.record and inst["no_output_tap"])
        or bool(report["shot"] and "error" in report["shot"])
        or report["feedback_suspected"]
    )
    report["verdict"], report["exit_code"] = ("findings", 1) if findings else ("clean", 0)
    return report


def bridge_patch_display() -> str:
    """BRIDGE_PATCH relative to the repo root (absolute when it lies outside)."""
    try:
        return str(BRIDGE_PATCH.relative_to(REPO_ROOT))
    except ValueError:
        return str(BRIDGE_PATCH)


def _bridge_hint(host: str, port: int) -> str:
    rel = bridge_patch_display()
    return (f"MAX bridge at {host}:{port} did not answer: open {rel} in MAX "
            f"(MAX 9.2 must be running) and turn ON its enable toggle "
            f"(the kill switch is OFF whenever the bridge patch opens)")


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def _add_net_args(sp: argparse.ArgumentParser) -> None:
    sp.add_argument("--port", type=int, default=BRIDGE_PORT,
                    help=f"bridge UDP port (default {BRIDGE_PORT})")
    sp.add_argument("--reply-port", type=int, default=REPLY_PORT,
                    help=f"local reply port on 127.0.0.1 (default {REPLY_PORT}; 0 = ephemeral, "
                         "only useful against a fake bridge)")
    sp.add_argument("--timeout", type=float, default=DEFAULT_TIMEOUT,
                    help=f"seconds to wait for a /pong (default {DEFAULT_TIMEOUT:g})")


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="max_bridge.py",
        description="Drive a running MAX 9.2 through the resident bridge patch (Q34 spike).",
    )
    sub = parser.add_subparsers(dest="cmd", required=True)

    sp = sub.add_parser("ping", help="check that the bridge answers")
    _add_net_args(sp)

    sc = sub.add_parser("check", help="open a patch copy, collect errors, record, screenshot, close")
    sc.add_argument("patch", help="the .maxpat to check (under the repo or the temp dir)")
    sc.add_argument("--settle", type=float, default=3.0,
                    help="seconds to keep listening after the load /pong (gen~ compiles late)")
    sc.add_argument("--record", type=float, default=None, metavar="SECONDS",
                    help="record this many seconds of the dac~ taps and analyze them")
    sc.add_argument("--shot", nargs="?", const="", default=None, metavar="PNG",
                    help="screenshot the window (default <run_dir>/shot.png)")
    sc.add_argument("--open-mode", choices=("pcontrol", "openfile"), default="pcontrol",
                    help="pcontrol load (default) or ; max openfile (variant B)")
    sc.add_argument("--console-all", action="store_true",
                    help="console shows every line, not only errors, during the run")
    sc.add_argument("--leave-dsp-on", action="store_true",
                    help="do not switch DSP off after recording")
    sc.add_argument("--dsp-on-load", action="store_true",
                    help="switch DSP on just before the /open so DSP-time errors (gen~ compiles) "
                         "post during the settle; the prior DSP state is restored as after --record")
    sc.add_argument("--load-timeout", type=float, default=30.0,
                    help="seconds to wait for the /pong after the open (default 30)")
    sc.add_argument("--note", nargs=2, type=int, default=None, metavar=("PITCH", "VEL"),
                    help="play this note into the copy's notein (kslider fallback) while "
                         "recording; needs --record")
    sc.add_argument("--note-ms", type=int, default=None, metavar="MS",
                    help="note-on length in ms (default 75%% of --record, clamped to it)")
    sc.add_argument("--dry-run", action="store_true",
                    help="print the message sequence; open no socket")
    _add_net_args(sc)

    sa = sub.add_parser("analyze", help="dsp_sim measures of a recorded wav")
    sa.add_argument("wav")
    sa.add_argument("--channels", default=None, help="comma list, e.g. L or L,R")
    sa.add_argument("--sr", type=float, default=None,
                    help="MAX's DSP rate: analyze at it when the wav header disagrees")
    return parser


def _cmd_ping(args) -> int:
    try:
        with Bridge(HOST, args.port, args.reply_port, args.timeout) as b:
            latency = b.ping(args.timeout)
    except BridgeError as exc:
        print(f"{_bridge_hint(HOST, args.port)} ({exc})", file=sys.stderr)
        return 2
    print(f"PONG {latency * 1000:.1f} ms")
    return 0


def _cmd_check(args) -> int:
    import json

    report = run_check(args)
    if report.get("verdict") == "dry_run":
        for line in report["plan"]:
            print(line)
        return 0
    if "error" in report and report["copy"] is None:
        print(report["error"], file=sys.stderr)
        return 2
    print(json.dumps(report, indent=2, default=str))
    distinct = report.get("errors_distinct") or []
    occurrences = sum(d["occurrences"] for d in distinct)
    summary = (f"{report['verdict']}: {len(distinct)} distinct error(s) "
               f"({occurrences} occurrence(s)), "
               f"record flags {report['record']['flags'] if report['record'] else None}, "
               f"unsupported {len(report['unsupported'])}, run dir {report['run_dir']}")
    if report["verdict"] == "bridge_failed":
        summary += f" -- {_bridge_hint(HOST, args.port)} ({report.get('error')})"
    print(summary, file=sys.stderr)
    return report["exit_code"]


def _cmd_analyze(args) -> int:
    import json

    channels = args.channels.split(",") if args.channels else None
    result = analyze(Path(args.wav), channels, max_sr=args.sr)
    print(json.dumps(result, indent=2))
    return 1 if result["flags"] else 0


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    if args.cmd == "check" and args.note is not None:
        pitch, vel = args.note
        if args.record is None:
            parser.error("--note needs --record (the note plays while recording)")
        if not 0 <= pitch <= 127:
            parser.error(f"--note pitch {pitch} is outside 0-127")
        if not 1 <= vel <= 127:
            parser.error(f"--note velocity {vel} is outside 1-127")
    if args.cmd == "ping":
        return _cmd_ping(args)
    if args.cmd == "check":
        return _cmd_check(args)
    if args.cmd == "analyze":
        return _cmd_analyze(args)
    return 2


if __name__ == "__main__":
    sys.exit(main())
