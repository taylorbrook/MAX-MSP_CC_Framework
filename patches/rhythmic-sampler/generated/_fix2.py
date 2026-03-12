#!/usr/bin/env python3
"""Fix remaining layout issues after cable cleanup."""

import json
import os

PATCH_PATH = os.path.join(os.path.dirname(__file__), 'slot.maxpat')

with open(PATCH_PATH, 'r') as f:
    patch = json.load(f)

patcher = patch['patcher']

# Build object lookup
objects = {}
for bw in patcher['boxes']:
    b = bw['box']
    objects[b['id']] = b

# ── FIX 1: Extend patcher width to fit right-side bus ──
patcher['rect'] = [85.0, 104.0, 1060.0, 960.0]
print("Extended patcher to 1060x960")

# ── FIX 2: Fix init message positions ──
# obj-62 (setbuffer #1) is at x=-24, move it on screen
# obj-73 (16 values) is very wide, needs special handling

# Get obj-52 info
t52 = objects['obj-52']
tx, ty, tw, th = t52['patching_rect']

# Calculate outlet X positions for obj-52 (12 outlets)
def outlet_x(box, idx):
    x, y, w, h = box['patching_rect']
    n = box.get('numoutlets', 1)
    if n <= 1:
        return x + w / 2
    return x + 4 + idx * (w - 8) / (n - 1)

# Position init messages in a clean row below obj-52
# Use left-alignment at outlet X, with minimum x=15
MSG_Y = ty + th + 15

# Init outlet -> message mapping
init_msgs = {
    0: 'obj-62',   # setbuffer #1 (wide ~107px)
    1: 'obj-61',   # 127
    2: 'obj-60',   # 127
    3: 'obj-59',   # 100
    4: 'obj-58',   # 0
    5: 'obj-57',   # 24.
    6: 'obj-56',   # 300
    7: 'obj-55',   # 5
    8: 'obj-54',   # 16
    9: 'obj-53',   # loop 1
    10: 'obj-72',  # 0
    11: 'obj-73',  # 127 x16 (very wide)
}

# Place messages in two rows to avoid overlap
# Row 1 (y=MSG_Y): outlets 0-5 (left side of trigger)
# Row 2 (y=MSG_Y+25): outlets 6-11 (right side of trigger)
# Actually, better: just place them left-aligned at their outlet X,
# using two staggered rows for narrow spacing

ROW1_Y = MSG_Y
ROW2_Y = MSG_Y + 28

for out_idx, msg_id in init_msgs.items():
    box = objects[msg_id]
    ox = outlet_x(t52, out_idx)
    msg_w = box['patching_rect'][2]
    msg_h = box['patching_rect'][3]

    # Alternate rows for even/odd outlets to prevent overlap
    row_y = ROW1_Y if out_idx % 2 == 0 else ROW2_Y

    # Left-align at outlet position, but clamp to minimum x=15
    new_x = max(15, round(ox - 5))

    # Special handling for wide messages
    if msg_id == 'obj-73':
        # Very wide (16 values) - place it below the others
        new_x = tx
        row_y = ROW2_Y + 28
    elif msg_id == 'obj-62':
        # "setbuffer #1" is ~107px wide, place at left edge
        new_x = max(15, round(ox - 5))

    box['patching_rect'] = [new_x, row_y, msg_w, msg_h]
    print(f"  {msg_id} ({box.get('text','')}) -> ({new_x}, {row_y})")

# ── FIX 3: Recalculate midpoints for init upward cables ──
# Now that messages moved, recalculate the bus routing

def outlet_pos(box, idx):
    x, y, w, h = box['patching_rect']
    n = box.get('numoutlets', 1)
    if n <= 1:
        return x + w / 2, y + h
    return x + 4 + idx * (w - 8) / (n - 1), y + h

def inlet_pos(box, idx):
    x, y, w, h = box['patching_rect']
    n = box.get('numinlets', 1)
    if n <= 1:
        return x + w / 2, y
    return x + 4 + idx * (w - 8) / (n - 1), y

# Identify init upward cables (message -> distant target)
# and assign bus X positions with proper spacing
init_upward = []
for lw in patcher['lines']:
    ln = lw['patchline']
    src_id = ln['source'][0]
    if src_id in init_msgs.values():
        dst_id = ln['destination'][0]
        dst_box = objects[dst_id]
        src_box = objects[src_id]
        dy = dst_box['patching_rect'][1]
        sy = src_box['patching_rect'][1] + src_box['patching_rect'][3]
        if dy < sy - 50:  # upward cable
            init_upward.append((src_id, ln))

# Sort by target Y (topmost targets get innermost bus position)
init_upward.sort(key=lambda t: objects[t[1]['patchline']['destination'][0]]['patching_rect'][1])

# Assign bus X: start at 920, increment by 8px
BUS_START = 920
BUS_STEP = 8

for i, (src_id, lw_ref) in enumerate(init_upward):
    ln = lw_ref['patchline']
    src_box = objects[src_id]
    dst_box = objects[ln['destination'][0]]

    sx, sy = outlet_pos(src_box, ln['source'][1])
    dx, dy = inlet_pos(dst_box, ln['destination'][1])

    bus_x = BUS_START + i * BUS_STEP

    # Route: right to bus, up along bus, left to target
    midpoints = [
        round(bus_x, 1), round(sy + 5, 1),
        round(bus_x, 1), round(dy - 8, 1),
        round(dx, 1), round(dy - 8, 1)
    ]
    ln['midpoints'] = midpoints
    print(f"  Bus {bus_x}: {src_id} -> {ln['destination'][0]}")

# ── FIX 4: Fix obj-52 -> message cables (short downward) ──
# These should be clean short cables, remove any midpoints
for lw in patcher['lines']:
    ln = lw['patchline']
    if ln['source'][0] == 'obj-52':
        src_box = objects['obj-52']
        dst_id = ln['destination'][0]
        dst_box = objects.get(dst_id)
        if dst_box:
            sx, sy = outlet_pos(src_box, ln['source'][1])
            dx, dy = inlet_pos(dst_box, ln['destination'][1])
            hdist = abs(dx - sx)
            if hdist < 10:
                if 'midpoints' in ln:
                    del ln['midpoints']
            else:
                # Need midpoints for horizontal offset
                mid_y = round(sy + 8)
                ln['midpoints'] = [round(sx, 1), mid_y, round(dx, 1), mid_y]

print(f"\nDone! Writing patch...")

with open(PATCH_PATH, 'w') as f:
    json.dump(patch, f, indent=2)

os.remove(__file__)
print("Complete.")
