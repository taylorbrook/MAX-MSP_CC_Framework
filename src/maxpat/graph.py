"""Graph traversal mixin for Patcher.

Provides BFS-based graph traversal methods that operate on Patcher's boxes
and lines, supporting downstream/upstream queries, signal path tracing,
and connected component detection. Extracted from patcher.py for
maintainability.
"""

from __future__ import annotations

from collections import deque
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from src.maxpat.patcher import Box, Patchline


class GraphMixin:
    """Graph traversal methods mixed into Patcher.

    Expects ``self.boxes``, ``self.lines``, and ``self.db`` to be provided
    by the host class (Patcher).
    """

    def _build_adj(
        self, signal_only: bool = False
    ) -> tuple[dict[str, list[tuple[str, int]]], dict[str, list[tuple[str, int]]], "dict[str, Box]"]:
        """Build forward and reverse adjacency dicts from self.lines.

        Args:
            signal_only: If True, skip connections where either source or
                destination box name does not end with ``~``.

        Returns:
            (forward, reverse, box_map) where:
            - forward[source_id] = sorted list of (dest_id, source_outlet) tuples
            - reverse[dest_id] = sorted list of (source_id, dest_inlet) tuples
            - box_map maps id -> Box for fast lookups
        """
        box_map: dict[str, Box] = {b.id: b for b in self.boxes}
        forward: dict[str, list[tuple[str, int]]] = {}
        reverse: dict[str, list[tuple[str, int]]] = {}

        for line in self.lines:
            src_id = line.source_id
            dst_id = line.dest_id
            if src_id not in box_map or dst_id not in box_map:
                continue
            if signal_only:
                src_box = box_map[src_id]
                dst_box = box_map[dst_id]
                if not src_box.name.endswith("~") or not dst_box.name.endswith("~"):
                    continue
            forward.setdefault(src_id, []).append((dst_id, line.source_outlet))
            reverse.setdefault(dst_id, []).append((src_id, line.dest_inlet))

        # Sort by outlet/inlet index for left-to-right ordering
        for v in forward.values():
            v.sort(key=lambda t: t[1])
        for v in reverse.values():
            v.sort(key=lambda t: t[1])

        return forward, reverse, box_map

    def downstream(self, box: "Box", *, signal_only: bool = False) -> "list[Box]":
        """Return all boxes reachable downstream from *box* (BFS, full chain).

        Results are ordered by outlet index (left to right) for natural
        signal-flow reading. The starting box is NOT included.

        Traversal crosses subpatcher boundaries: when a downstream neighbor
        has ``_inner_patcher``, the traversal follows through inlet objects
        inside the subpatcher and continues out through outlet objects.

        Args:
            box: Starting box.
            signal_only: If True, only follow connections where both source
                and destination box names end with ``~``.

        Returns:
            List of downstream Box objects.

        Raises:
            ValueError: If *box* is not in this patcher.
        """
        if box not in self.boxes:
            raise ValueError(
                f"Box '{box.id}' ({box.name}) is not in this patcher"
            )
        return self._traverse(box, direction="downstream", signal_only=signal_only)

    def upstream(self, box: "Box", *, signal_only: bool = False) -> "list[Box]":
        """Return all boxes reachable upstream from *box* (BFS, full chain).

        Results are ordered by inlet index (left to right). The starting
        box is NOT included.

        Traversal crosses subpatcher boundaries by following outlet objects
        inside subpatchers back to their sources.

        Args:
            box: Starting box.
            signal_only: If True, only follow connections where both source
                and destination box names end with ``~``.

        Returns:
            List of upstream Box objects.

        Raises:
            ValueError: If *box* is not in this patcher.
        """
        if box not in self.boxes:
            raise ValueError(
                f"Box '{box.id}' ({box.name}) is not in this patcher"
            )
        return self._traverse(box, direction="upstream", signal_only=signal_only)

    def _traverse(
        self,
        start: "Box",
        *,
        direction: str,
        signal_only: bool = False,
    ) -> "list[Box]":
        """BFS traversal in given direction, crossing subpatcher boundaries.

        Args:
            start: The starting box.
            direction: ``"downstream"`` or ``"upstream"``.
            signal_only: Filter to signal-only connections.

        Returns:
            Ordered list of reachable Box objects (starting box excluded).
        """
        result: list[Box] = []
        # visited tracks (id(patcher), box_id) to handle cross-patcher traversal
        visited: set[tuple[int, str]] = set()
        visited.add((id(self), start.id))

        # Queue items: (patcher, box_id) -- the patcher that owns the box
        queue: deque[tuple[GraphMixin, str]] = deque()

        # Seed the queue with immediate neighbors in this patcher
        self._enqueue_neighbors(
            queue, visited, result, self, start, direction, signal_only
        )

        while queue:
            patcher, box_id = queue.popleft()
            box_map = {b.id: b for b in patcher.boxes}
            current_box = box_map.get(box_id)
            if current_box is None:
                continue

            # If this box has an inner patcher, cross the boundary
            if current_box._inner_patcher is not None:
                self._cross_subpatcher(
                    queue, visited, result, patcher, current_box,
                    direction, signal_only
                )

            # Enqueue neighbors of current_box within its own patcher
            self._enqueue_neighbors(
                queue, visited, result, patcher, current_box, direction, signal_only
            )

        return result

    def _enqueue_neighbors(
        self,
        queue: "deque[tuple[GraphMixin, str]]",
        visited: set[tuple[int, str]],
        result: "list[Box]",
        patcher: "GraphMixin",
        box: "Box",
        direction: str,
        signal_only: bool,
    ) -> None:
        """Add unvisited neighbors of *box* to the BFS queue and result."""
        forward, reverse, box_map = patcher._build_adj(signal_only=signal_only)

        if direction == "downstream":
            neighbors = forward.get(box.id, [])
        else:
            neighbors = reverse.get(box.id, [])

        for neighbor_id, _index in neighbors:
            key = (id(patcher), neighbor_id)
            if key in visited:
                continue
            visited.add(key)
            neighbor_box = box_map.get(neighbor_id)
            if neighbor_box is not None:
                result.append(neighbor_box)
                queue.append((patcher, neighbor_id))

    def _cross_subpatcher(
        self,
        queue: "deque[tuple[GraphMixin, str]]",
        visited: set[tuple[int, str]],
        result: "list[Box]",
        parent_patcher: "GraphMixin",
        sub_box: "Box",
        direction: str,
        signal_only: bool,
    ) -> None:
        """Cross into a subpatcher boundary during traversal.

        For downstream: find inlet/inlet~ objects inside and continue from them.
        For upstream: find outlet/outlet~ objects inside and trace back from them.
        """
        inner = sub_box._inner_patcher
        if inner is None:
            return

        if direction == "downstream":
            # Find connections entering sub_box in parent, map to inner inlet objects
            # Then find outlet/outlet~ objects in inner, map back to parent connections
            # Step 1: find inlet objects inside
            for inner_box in inner.boxes:
                if inner_box.name in ("inlet", "inlet~"):
                    key = (id(inner), inner_box.id)
                    if key not in visited:
                        visited.add(key)
                        result.append(inner_box)
                        queue.append((inner, inner_box.id))

            # Step 2: find outlet objects that lead back to parent
            for inner_box in inner.boxes:
                if inner_box.name in ("outlet", "outlet~"):
                    key = (id(inner), inner_box.id)
                    if key not in visited:
                        visited.add(key)
                        result.append(inner_box)
                        # Outlet objects map back to parent's sub_box outlets
                        # Enqueue sub_box's downstream in parent (already handled
                        # by normal traversal since sub_box is in the result path)
        else:
            # upstream: find outlet objects inside and trace backwards
            for inner_box in inner.boxes:
                if inner_box.name in ("outlet", "outlet~"):
                    key = (id(inner), inner_box.id)
                    if key not in visited:
                        visited.add(key)
                        result.append(inner_box)
                        queue.append((inner, inner_box.id))

            # Also expose inlet objects (they connect back to parent upstream)
            for inner_box in inner.boxes:
                if inner_box.name in ("inlet", "inlet~"):
                    key = (id(inner), inner_box.id)
                    if key not in visited:
                        visited.add(key)
                        result.append(inner_box)

    def signal_path(self, box: "Box") -> "list[Box]":
        """Return the full signal chain passing through *box* (~ objects only).

        Combines upstream signal sources (reversed) + box + downstream signal
        sinks. Only includes boxes whose name ends with ``~``.

        Args:
            box: The box to trace the signal path through.

        Returns:
            Ordered list of ~ boxes from source to sink.

        Raises:
            ValueError: If *box* is not in this patcher.
        """
        if box not in self.boxes:
            raise ValueError(
                f"Box '{box.id}' ({box.name}) is not in this patcher"
            )
        upstream_signal = self.upstream(box, signal_only=True)
        downstream_signal = self.downstream(box, signal_only=True)
        # Reverse upstream so sources come first
        upstream_signal = list(reversed(upstream_signal))
        is_signal = box.name.endswith("~")
        if is_signal:
            return upstream_signal + [box] + downstream_signal
        else:
            return upstream_signal + downstream_signal

    def connected_components(self) -> "list[list[Box]]":
        """Return groups of interconnected boxes.

        Uses undirected BFS. Disconnected objects (no connections) are
        returned as single-element groups. Components are sorted by size
        (largest first).

        Returns:
            List of Box lists, each list is a connected component.
        """
        if not self.boxes:
            return []

        # Build undirected adjacency from lines
        undirected: dict[str, set[str]] = {}
        box_map: dict[str, Box] = {b.id: b for b in self.boxes}

        for line in self.lines:
            src = line.source_id
            dst = line.dest_id
            if src in box_map and dst in box_map:
                undirected.setdefault(src, set()).add(dst)
                undirected.setdefault(dst, set()).add(src)

        visited: set[str] = set()
        components: list[list[Box]] = []

        for box in self.boxes:
            if box.id in visited:
                continue
            visited.add(box.id)

            if box.id not in undirected:
                # Disconnected box -> single-element group
                components.append([box])
                continue

            # BFS to find connected component
            component: list[Box] = [box]
            queue: deque[str] = deque()
            for neighbor in undirected.get(box.id, set()):
                if neighbor not in visited:
                    queue.append(neighbor)

            while queue:
                node_id = queue.popleft()
                if node_id in visited:
                    continue
                visited.add(node_id)
                node_box = box_map.get(node_id)
                if node_box is not None:
                    component.append(node_box)
                for neighbor in undirected.get(node_id, set()):
                    if neighbor not in visited:
                        queue.append(neighbor)

            components.append(component)

        # Sort largest first
        components.sort(key=lambda c: len(c), reverse=True)
        return components
