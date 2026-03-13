"""Help patch audit package.

Provides tools for parsing MAX/MSP help patches (.maxhelp files), extracting
object instance metadata, and comparing extracted data against the object
database to identify discrepancies. This package is the data extraction
foundation -- downstream modules (analyzer, reporter, override generator)
consume the parser's output.
"""

from dataclasses import dataclass, field


@dataclass
class BoxInstance:
    """A single object instance extracted from a help patch.

    Represents one newobj box found during recursive traversal of a .maxhelp
    file's patcher hierarchy. Captures all metadata needed for downstream
    analysis: object identity, I/O counts, outlet types, position/size,
    connection status, and nesting depth.
    """

    name: str
    """Object name (first token of text, e.g., 'cycle~')."""

    text: str
    """Full object text (e.g., 'cycle~ 440')."""

    numinlets: int
    """Number of inlets as declared in the help patch."""

    numoutlets: int
    """Number of outlets as declared in the help patch."""

    outlettype: list[str]
    """Outlet type strings from the help patch (e.g., ['signal'], ['bang', 'int'])."""

    patching_rect: list[float]
    """Box position and size: [x, y, width, height]."""

    box_id: str
    """Box identifier within its patcher scope (e.g., 'obj-7')."""

    depth: int
    """Nesting depth: 0 = top-level patcher, 1 = inside one subpatcher, etc."""

    is_connected: bool
    """Whether this box appears in any patchline within its patcher scope."""

    connections: list[tuple] = field(default_factory=list)
    """Patchlines involving this box: [(src_id, src_outlet, dst_id, dst_inlet), ...]."""

    source_file: str = ""
    """Path to the .maxhelp file this instance was extracted from."""
