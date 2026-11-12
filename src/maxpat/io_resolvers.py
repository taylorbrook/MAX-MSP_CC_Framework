"""Per-object I/O resolvers and the quote-aware box tokenizer (Q10).

Review 2026-10-11 finding C1: argument-dependent inlet/outlet counts were
wrong for everyday objects (``r foo`` got an inlet, ``sel 0`` one inlet,
``t "a b"`` two outlets). Section 2 S6 of the same review asks for
per-object resolver callables, checked against the help-box oracle
(``tools/audit_db.py --help-io``), instead of growing the string-formula
mini-language in ``overrides.json`` ``variable_io_rules``.

This module holds:

* :func:`split_box_text` / :func:`box_args` / :func:`normalize_args`: the
  tokenizer MAX applies to box text. Double quotes group words into one
  argument, a backslash makes the next character literal, and positional
  arguments stop at the first ``@attribute`` token.
* :data:`IO_RESOLVERS`: canonical object name -> resolver. A resolver takes
  ``(args, (default_inlets, default_outlets))`` -- the normalized positional
  args and the DB array lengths -- and returns ``(inlets, outlets)``.

Rules of the registry:

* Keys are **canonical** DB names; aliases (``r``, ``sel``, ``t``, ``b``)
  resolve through ``aliases.json`` before dispatch.
* A resolver wins over ``variable_io_rules``. ``ObjectDatabase`` refuses to
  load when one name has both (no silent ambiguity).
* Every resolver docstring cites the MAX-saved help box(es) it reproduces.

This module never imports ``src.maxpat.db_lookup`` (db_lookup imports this
module; the reverse import would be a cycle).
"""

from __future__ import annotations

import functools
import re
from typing import Callable, Dict, List, Tuple

IoResolver = Callable[[List[str], Tuple[int, int]], Tuple[int, int]]


# ---------------------------------------------------------------------------
# Tokenizer
# ---------------------------------------------------------------------------


def split_box_text(text: str) -> list[str]:
    """Split box text into MAX tokens, respecting quotes and backslash escapes.

    * Whitespace (spaces, tabs, newlines) outside double quotes separates
      tokens.
    * A double quote toggles the quoted state and is kept in the token, so
      ``t "a b" c`` -> ``['t', '"a b"', 'c']``.
    * A backslash makes the next character literal and is kept in the token:
      ``\\"`` does not toggle quoting and ``\\ `` (escaped space) does not
      split. A trailing backslash is kept as-is.
    * An unbalanced quote runs to the end of the text as one token.
    * Empty or whitespace-only text returns ``[]``. Never raises: a
      non-string input is converted with ``str()`` (``None`` -> ``[]``).
    """
    if text is None:
        return []
    if not isinstance(text, str):
        text = str(text)
    # Memoized: critics and validation re-tokenize the same box text tens of
    # thousands of times per save. A fresh list per call keeps callers free
    # to mutate the result.
    return list(_split_box_text_cached(text))


@functools.lru_cache(maxsize=16384)
def _split_box_text_cached(text: str) -> tuple[str, ...]:
    tokens: list[str] = []
    cur: list[str] = []
    in_token = False
    quoted = False
    i = 0
    n = len(text)
    while i < n:
        ch = text[i]
        if ch == "\\":
            cur.append(ch)
            if i + 1 < n:
                cur.append(text[i + 1])
                i += 1
            in_token = True
        elif ch == '"':
            quoted = not quoted
            cur.append(ch)
            in_token = True
        elif ch.isspace() and not quoted:
            if in_token:
                tokens.append("".join(cur))
                cur = []
                in_token = False
        else:
            cur.append(ch)
            in_token = True
        i += 1
    if in_token:
        tokens.append("".join(cur))
    return tuple(tokens)


def _positional(tokens: list[str]) -> list[str]:
    """Tokens up to (not including) the first one starting with ``@``."""
    out: list[str] = []
    for tok in tokens:
        if tok.startswith("@"):
            break
        out.append(tok)
    return out


def box_args(text: str) -> tuple[str, list[str]]:
    """Split newobj text into ``(name, positional args)``.

    The name is token 0 of :func:`split_box_text`; the args are the following
    tokens up to the first ``@attribute`` token. Empty text -> ``("", [])``.
    """
    tokens = split_box_text(text)
    if not tokens:
        return ("", [])
    return (tokens[0], _positional(tokens[1:]))


def normalize_args(args) -> list[str]:
    """Re-tokenize an args list the way MAX reads the box text.

    The elements are joined with single spaces (each through ``str()``) and
    split again with :func:`split_box_text`, then truncated at the first
    ``@`` token. Pre-split quoted words (``['"LCD', 'Text', '(Inactive)"']``)
    and the single quoted token give the same one-element list, so callers
    may pass either form. ``None`` -> ``[]``.
    """
    if args is None:
        return []
    if isinstance(args, str):
        joined = args
    else:
        joined = " ".join(str(a) for a in args)
    return _positional(split_box_text(joined))


# ---------------------------------------------------------------------------
# Resolvers
# ---------------------------------------------------------------------------


def _receive(args: list[str], defaults: tuple[int, int]) -> tuple[int, int]:
    """receive / r: a named receive has no inlet; bare receive keeps one.

    MAX-saved boxes: ``r todrive`` = (0,1) (C74/help/jitter/
    jit.anim.drive.maxhelp), ``receive bem`` = (0,1) (C74/help/max/
    forward.maxhelp), ``receive`` = (1,1) (C74/help/max/receive.maxhelp;
    the inlet takes ``set <name>``).
    """
    if args:
        return (0, 1)
    return defaults


def _selector(args: list[str], defaults: tuple[int, int]) -> tuple[int, int]:
    """select / sel, route, routepass: N args -> (N+1, N+1).

    Each matched argument gets an outlet plus an inlet that replaces it; the
    last outlet passes unmatched input. MAX-saved boxes:

    * ``sel`` = (2,2) (C74/help/jitter/jit.playlist.maxhelp), ``sel 0 1`` =
      (3,3) (C74/extras/JitterTester.maxpat), ``select 1 2 3 4 5 6 7`` = (8,8)
      (C74/packages/Vizzie/help/vz.1easemappr.maxhelp).
    * ``route point`` = (2,2) (C74/help/jitter/jit.anim.path.maxhelp),
      ``route time transport`` = (3,3) (C74/help/jitter/jit.avc.maxhelp),
      ``route "Control Border" "Text / Icon" "Slider Range Value"`` = (4,4)
      (C74/help/m4l/live.colors.maxhelp).
    * ``routepass 0 1`` = (3,3) (C74/help/jitter/jit.displays.maxhelp).

    Bare ``route`` / ``routepass`` = (2,2) is **refpage-derived** (no
    MAX-saved box): route.maxref.xml / routepass.maxref.xml say "If there is
    no argument, there is one other outlet, which is assigned the number 0".
    Replaces the variable_io_rules formulas (fixed:1 inlet, arg_count+1
    outlets) that predated the help-box oracle.
    """
    n = max(len(args), 1)
    return (n + 1, n + 1)


_DOLLAR = re.compile(r"\$[ifs](\d+)")


def _dollar_inlets(args: list[str]) -> int:
    """Highest ``$iN`` / ``$fN`` / ``$sN`` index in the joined args, else 1."""
    found = [int(m) for m in _DOLLAR.findall(" ".join(args))]
    return max(found) if found else 1


def _expr(args: list[str], defaults: tuple[int, int]) -> tuple[int, int]:
    """expr / vexpr: inlets = highest ``$iN``/``$fN``/``$sN`` index, 1 outlet.

    Counting tokens was wrong both ways (``expr $i1 + $i2 + $i3`` got 5
    inlets). MAX-saved boxes: ``expr $i3 * $i1 + $i2`` = (3,1)
    (C74/help/max/expr.maxhelp), ``expr $i2 + 11`` = (2,1)
    (FluidCorpusManipulation/help/fluid.bufnmf~.maxhelp),
    ``expr sin (2. * 3.141593 * $f1)`` = (1,1) (bundle), ``vexpr
    $f1*($f3-$f2)+$f2 @scalarmode 1`` = (3,1) (C74/packages/BEAP/Examples/
    Synthesis Examples/Resynthesis.maxpat), ``vexpr int($f1 * 255)`` = (1,1)
    (C74/help/m4l/live.colors.maxhelp). The vexpr reading ("highest
    $iN/$fN/$sN index") was refpage-verified 2026-09-27 in the retired
    variable_io_rules entry.
    """
    return (_dollar_inlets(args), 1)


def _if(args: list[str], defaults: tuple[int, int]) -> tuple[int, int]:
    """if: inlets as for expr; a second outlet when the text uses ``out2``.

    MAX-saved boxes: ``if $i1 < 8 then bang else out2 bang`` = (1,2)
    (C74/help/jitter/jit.avc.maxhelp), ``if $i3 == 1 then $f1 $f2 else out2
    bang`` = (3,2) (C74/help/max/nodes.maxhelp), ``if $i2 == 1 then $i1`` =
    (2,1) (C74/help/jitter/jit.displays.maxhelp).
    """
    outlets = 2 if any(tok == "out2" for tok in args) else 1
    return (_dollar_inlets(args), outlets)


_PRINTF_SPEC = re.compile(
    r"%[-+ #0]*\d*(?:\.\d+)?(?:hh|h|ll|l|L|q|j|z|t)?[diouxXeEfFgGaAcs]"
)


def _sprintf(args: list[str], defaults: tuple[int, int]) -> tuple[int, int]:
    """sprintf: one inlet per changeable format specifier (min 1), 1 outlet.

    The refpage: "number of inlets is determined by the number of changeable
    arguments". Literal ``%%`` is not a specifier; the ``symout`` keyword has
    none. MAX-saved boxes: ``sprintf %d - %d x %d\\, %d bit\\, %dHz %s`` =
    (6,1) (C74/help/jitter/jit.displays.maxhelp), ``sprintf symout %s%s`` =
    (2,1), ``sprintf %ld 34 %ld 555`` = (2,1), ``sprintf %c%c%c%c`` = (4,1)
    (all C74/help/max/sprintf.maxhelp).
    """
    text = " ".join(args).replace("%%", "")
    return (max(len(_PRINTF_SPEC.findall(text)), 1), 1)


def _pipe(args: list[str], defaults: tuple[int, int]) -> tuple[int, int]:
    """pipe: the final arg is the delay time; each earlier arg is a lane.

    k = max(len(args) - 1, 1) lanes -> (k+1, k): one inlet per lane plus the
    delay-time inlet. MAX-saved boxes: ``pipe 0 0 1000`` = (3,2), ``pipe 0.
    0. 0. 2000`` = (4,3), ``pipe 500`` = (2,1) (C74/help/max/pipe.maxhelp),
    ``pipe 0 0 0 0 0 0 0 0 0 0 0 0 500`` = (13,12) (bundle).
    """
    k = max(len(args) - 1, 1)
    return (k + 1, k)


def _is_int(tok: str) -> bool:
    try:
        int(tok)
    except ValueError:
        return False
    return True


def _notein(args: list[str], defaults: tuple[int, int]) -> tuple[int, int]:
    """notein: a channel argument drops the channel outlet (3 -> 2).

    The refpage: "a number alone can be used in place of a letter" (the
    channel); a port letter or name alone keeps all three outlets.
    MAX-saved boxes: ``notein`` = (1,3) (C74/extras/MIDItester.maxpat),
    ``notein a`` = (1,3), ``notein 17`` = (1,2), ``notein b 6`` = (1,2)
    (C74/help/max/bendin.maxhelp).
    """
    return (1, 2 if any(_is_int(a) for a in args) else 3)


def _ctlin(args: list[str], defaults: tuple[int, int]) -> tuple[int, int]:
    """ctlin: a specific controller drops one outlet, a channel another.

    The first integer arg is the controller number (negative = all
    controllers, refpage: "negative number recognizes all controller
    numbers", so it keeps the controller outlet); a second integer is the
    channel. MAX-saved boxes: ``ctlin`` = (1,3) (C74/extras/MIDItester.maxpat),
    ``ctlin 7`` = (1,2) (C74/help/max/linedrive.maxhelp), ``ctlin 33 1`` =
    (1,1), ``ctlin -1 4`` = (1,2), ``ctlin a 1`` = (1,2)
    (C74/help/max/ctlin.maxhelp).
    """
    ints = [int(a) for a in args if _is_int(a)]
    outlets = 3
    if ints and ints[0] >= 0:
        outlets -= 1
    if len(ints) >= 2:
        outlets -= 1
    return (1, outlets)


IO_RESOLVERS: Dict[str, IoResolver] = {
    "receive": _receive,
    "select": _selector,
    "route": _selector,
    "routepass": _selector,
    "expr": _expr,
    "vexpr": _expr,
    "if": _if,
    "sprintf": _sprintf,
    "pipe": _pipe,
    "notein": _notein,
    "ctlin": _ctlin,
}
