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
            640.0,
            480.0
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
                        15,
                        15,
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
                        15.0,
                        48.0,
                        640.0,
                        34.0
                    ],
                    "text": "Turn audio on, set freq / position, pick a bank. Position sweeps the torus-SDF orbit scale 0.3 -> 1.6 (frame 0 near-sine, 255 hardest).",
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
                        15.0,
                        105.0,
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
                        135.0,
                        105.0,
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
                    "maxclass": "comment",
                    "id": "obj-5",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        15,
                        130,
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
                    "id": "obj-6",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        140,
                        130,
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
                    "id": "obj-7",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        265,
                        130,
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
                    "maxclass": "flonum",
                    "id": "obj-8",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        15.0,
                        152.0,
                        70.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "minimum": 0.0,
                    "maximum": 20000.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-9",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        140.0,
                        152.0,
                        70.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "minimum": 0.0,
                    "maximum": 1.0
                }
            },
            {
                "box": {
                    "maxclass": "number",
                    "id": "obj-10",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        265.0,
                        152.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "minimum": 0
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
                        15,
                        200,
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
                        15.0,
                        345.0,
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
                        45.0,
                        495.0,
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
                        195.0,
                        345.0,
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
                        15.0,
                        615.0,
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
                        "obj-8",
                        0
                    ],
                    "midpoints": [
                        68.5,
                        122.0,
                        88.0,
                        122.0,
                        88.0,
                        158.0,
                        50.0,
                        158.0
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
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        181.5,
                        122.0,
                        132.0,
                        122.0,
                        132.0,
                        158.0,
                        175.0,
                        158.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        0
                    ],
                    "destination": [
                        "obj-11",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-9",
                        0
                    ],
                    "destination": [
                        "obj-11",
                        1
                    ],
                    "midpoints": [
                        147.0,
                        144.0,
                        257.0,
                        144.0,
                        257.0,
                        182.0,
                        275.0,
                        182.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-10",
                        0
                    ],
                    "destination": [
                        "obj-11",
                        2
                    ],
                    "midpoints": [
                        272.0,
                        187.0,
                        528.0,
                        187.0
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
                        275.0,
                        337.0,
                        187.0,
                        337.0,
                        187.0,
                        483.0,
                        26.0,
                        483.0
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
                        22.0,
                        490.0,
                        52.5,
                        490.0
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
                        "obj-14",
                        0
                    ],
                    "midpoints": [
                        685.0,
                        490.0,
                        685.0,
                        337.0,
                        202.0,
                        337.0
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
                    ],
                    "midpoints": [
                        22.0,
                        487.0,
                        37.0,
                        487.0,
                        37.0,
                        603.0,
                        53.0,
                        603.0
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