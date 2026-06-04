{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 2,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [
            85.0,
            104.0,
            993.0,
            300.0
        ],
        "boxes": [
            {
                "box": {
                    "comment": "mic channel (signal)",
                    "id": "obj-1",
                    "index": 0,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        30.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "comment": "post-insert channel (signal) — for analysis/record later",
                    "id": "obj-2",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        45.0,
                        120.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-3",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        195.0,
                        120.0,
                        44.0,
                        20.0
                    ],
                    "text": "mic #1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        150.0,
                        30.0,
                        72.0,
                        22.0
                    ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-5",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        180.0,
                        75.0,
                        86.0,
                        22.0
                    ],
                    "text": "set mic #1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-6",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        45.0,
                        75.0,
                        51.0,
                        22.0
                    ],
                    "text": "*~ 1."
                }
            },
            {
                "box": {
                    "id": "obj-7",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        90.0,
                        75.0,
                        15.0,
                        100.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-8",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        300.0,
                        30.0,
                        653.0,
                        20.0
                    ],
                    "text": "INSERT: *~ 1. = passthrough. Replace/extend for analysis (amp/onset/pitch/spectral) or DSP."
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-9",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        923.0,
                        8.0,
                        58.0,
                        20.0
                    ],
                    "text": "v0.1.2",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        90.5,
                        225.0,
                        90.5,
                        225.0
                    ],
                    "source": [
                        "obj-1",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        90.5,
                        156.0,
                        90.5,
                        156.0
                    ],
                    "source": [
                        "obj-4",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "midpoints": [
                        90.5,
                        186.0,
                        0.0,
                        186.0,
                        0.0,
                        3.0,
                        22.5,
                        3.0
                    ],
                    "source": [
                        "obj-5",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-2",
                        0
                    ],
                    "midpoints": [
                        90.5,
                        258.0,
                        90.5,
                        258.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-6",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        90.5,
                        258.0,
                        54.0,
                        258.0,
                        54.0,
                        27.0,
                        36.0,
                        27.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-6",
                        0
                    ]
                }
            }
        ],
        "autosave": 0
    }
}