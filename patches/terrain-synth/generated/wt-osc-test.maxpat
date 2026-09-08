{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 0,
            "revision": 0,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [
            85.0,
            104.0,
            1618.0,
            460.0
        ],
        "bglocked": 0,
        "openinpresentation": 0,
        "default_fontsize": 12.0,
        "default_fontface": 0,
        "default_fontname": "Arial",
        "gridonopen": 1,
        "gridsize": [
            15.0,
            15.0
        ],
        "gridsnaponopen": 1,
        "objectsnaponopen": 1,
        "statusbarvisible": 2,
        "toolbarvisible": 1,
        "lefttoolbarpinned": 0,
        "toptoolbarpinned": 0,
        "righttoolbarpinned": 0,
        "bottomtoolbarpinned": 0,
        "toolbars_unpinned_last_save": 0,
        "tallnewobj": 0,
        "boxanimatetime": 200,
        "enablehscroll": 1,
        "enablevscroll": 1,
        "devicewidth": 0.0,
        "description": "",
        "digest": "",
        "tags": "",
        "style": "",
        "subpatcher_template": "",
        "assistshowspatchername": 0,
        "boxes": [
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-1",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        720.0,
                        30.0,
                        514.0,
                        24.0
                    ],
                    "text": "wt-osc test harness  --  slice 1 (bake + oscillator)",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "fontface": 1,
                    "textcolor": [
                        0.2,
                        0.2,
                        0.25,
                        1.0
                    ],
                    "bgcolor": [
                        0.88,
                        0.9,
                        0.95,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-2",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        720.0,
                        90.0,
                        828.0,
                        20.0
                    ],
                    "text": "Turn on audio, set freq/position, pick a bank. Position sweeps torus-SDF orbit scale 0.3 -> 1.6 (frame 0 near-sine).",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-3",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        30.0,
                        107.0,
                        22.0
                    ],
                    "text": "loadmess 110.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-4",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        210.0,
                        30.0,
                        93.0,
                        22.0
                    ],
                    "text": "loadmess 0.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-5",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        45.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "minimum": 0.0,
                    "maximum": 20000.0,
                    "format": 6
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-6",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        45.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "format": 6
                }
            },
            {
                "box": {
                    "maxclass": "number",
                    "id": "obj-7",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        150.0,
                        30.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "minimum": 0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-8",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        90.0,
                        45.0,
                        65.0,
                        20.0
                    ],
                    "text": "freq Hz",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
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
                        90.0,
                        45.0,
                        100.0,
                        20.0
                    ],
                    "text": "position 0-1",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-10",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        210.0,
                        30.0,
                        44.0,
                        20.0
                    ],
                    "text": "bank",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "bpatcher",
                    "id": "obj-11",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        75.0,
                        520,
                        120
                    ],
                    "args": [],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "lockeddragscroll": 0,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "viewvisibility": 1,
                    "name": "wt-osc.maxpat"
                }
            },
            {
                "box": {
                    "maxclass": "gain~",
                    "id": "obj-12",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        285.0,
                        210.0,
                        22.0,
                        140.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-13",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        300.0,
                        210.0,
                        15.0,
                        100.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "scope~",
                    "id": "obj-14",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        555.0,
                        75.0,
                        130.0,
                        130.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "ezdac~",
                    "id": "obj-15",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        270.0,
                        375.0,
                        45.0,
                        45.0
                    ],
                    "parameter_enable": 0,
                    "bgcolor": [
                        0.92,
                        0.85,
                        0.85,
                        1.0
                    ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "obj-3",
                        0
                    ],
                    "destination": [
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        83.5,
                        37.0,
                        88.0,
                        37.0,
                        88.0,
                        75.0,
                        88.0,
                        37.0,
                        82.0,
                        37.0,
                        82.0,
                        73.0,
                        82.0,
                        37.0,
                        82.0,
                        37.0,
                        82.0,
                        73.0,
                        55.0,
                        73.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-4",
                        0
                    ],
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        256.5,
                        22.0,
                        145.0,
                        22.0,
                        145.0,
                        60.0,
                        145.0,
                        22.0,
                        142.0,
                        22.0,
                        142.0,
                        60.0,
                        142.0,
                        22.0,
                        202.0,
                        22.0,
                        202.0,
                        58.0,
                        202.0,
                        37.0,
                        88.0,
                        37.0,
                        88.0,
                        75.0,
                        88.0,
                        37.0,
                        163.0,
                        37.0,
                        163.0,
                        73.0,
                        163.0,
                        37.0,
                        198.0,
                        37.0,
                        198.0,
                        73.0,
                        55.0,
                        73.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-5",
                        0
                    ],
                    "destination": [
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        37.0,
                        37.0,
                        22.0,
                        37.0,
                        22.0,
                        75.0,
                        37.0,
                        75.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-6",
                        0
                    ],
                    "destination": [
                        "obj-11",
                        1
                    ],
                    "midpoints": [
                        37.0,
                        37.0,
                        88.0,
                        37.0,
                        88.0,
                        75.0,
                        88.0,
                        37.0,
                        163.0,
                        37.0,
                        163.0,
                        73.0,
                        163.0,
                        37.0,
                        198.0,
                        37.0,
                        198.0,
                        73.0,
                        290.0,
                        73.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-7",
                        0
                    ],
                    "destination": [
                        "obj-11",
                        2
                    ],
                    "midpoints": [
                        157.0,
                        22.0,
                        311.0,
                        22.0,
                        311.0,
                        60.0,
                        311.0,
                        22.0,
                        262.0,
                        22.0,
                        262.0,
                        58.0,
                        262.0,
                        37.0,
                        163.0,
                        37.0,
                        163.0,
                        73.0,
                        163.0,
                        37.0,
                        198.0,
                        37.0,
                        198.0,
                        73.0,
                        543.0,
                        73.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-11",
                        0
                    ],
                    "destination": [
                        "obj-12",
                        0
                    ],
                    "midpoints": [
                        290.0,
                        202.0,
                        292.0,
                        202.0,
                        292.0,
                        318.0,
                        296.0,
                        318.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-11",
                        0
                    ],
                    "destination": [
                        "obj-14",
                        0
                    ],
                    "midpoints": [
                        1578.0,
                        200.0,
                        1578.0,
                        67.0,
                        562.0,
                        67.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-12",
                        0
                    ],
                    "destination": [
                        "obj-13",
                        0
                    ],
                    "midpoints": [
                        322.0,
                        355.0,
                        322.0,
                        202.0,
                        307.5,
                        202.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-12",
                        0
                    ],
                    "destination": [
                        "obj-15",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-12",
                        0
                    ],
                    "destination": [
                        "obj-15",
                        1
                    ]
                }
            }
        ],
        "dependency_cache": [],
        "autosave": 0,
        "bgcolor": [
            0.333,
            0.333,
            0.333,
            1.0
        ],
        "editing_bgcolor": [
            0.333,
            0.333,
            0.333,
            1.0
        ],
        "locked_bgcolor": [
            0.333,
            0.333,
            0.333,
            1.0
        ]
    }
}