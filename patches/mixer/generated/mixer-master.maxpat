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
            400.0,
            475.0
        ],
        "bglocked": 0,
        "openinpresentation": 1,
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
                    "maxclass": "panel",
                    "id": "obj-10",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        0,
                        0,
                        110,
                        430
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        0.0,
                        110.0,
                        430.0
                    ],
                    "background": 1,
                    "ignoreclick": 1,
                    "border": 0,
                    "rounded": 7,
                    "mode": 0,
                    "bgfillcolor": {
                        "type": "gradient",
                        "color1": [
                            0.94,
                            0.94,
                            0.96,
                            1.0
                        ],
                        "color2": [
                            0.88,
                            0.89,
                            0.92,
                            1.0
                        ],
                        "color": [
                            0.94,
                            0.94,
                            0.96,
                            1.0
                        ],
                        "angle": 270.0,
                        "proportion": 0.39,
                        "autogradient": 0
                    }
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-1",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        30,
                        20,
                        94.0,
                        22.0
                    ],
                    "text": "receive~ master-L",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-2",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        100,
                        20,
                        94.0,
                        22.0
                    ],
                    "text": "receive~ master-R",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "gain~",
                    "id": "obj-3",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        200.0,
                        60.0,
                        44.0,
                        160.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        35.0,
                        30.0,
                        40.0,
                        260.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-4",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        100,
                        120,
                        42.0,
                        22.0
                    ],
                    "text": "*~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-5",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        260.0,
                        28.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        10.0,
                        300.0,
                        35.0,
                        90.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-6",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        100.0,
                        260.0,
                        28.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        65.0,
                        300.0,
                        35.0,
                        90.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "ezdac~",
                    "id": "obj-7",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        50,
                        390,
                        45.0,
                        45.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        30.0,
                        398.0,
                        50.0,
                        25.0
                    ],
                    "bgcolor": [
                        0.92,
                        0.85,
                        0.85,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-8",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        260,
                        20,
                        62.0,
                        22.0
                    ],
                    "text": "loadbang",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "bgcolor": [
                        0.85,
                        0.92,
                        0.85,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-9",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        260,
                        50,
                        40.0,
                        22.0
                    ],
                    "text": "128",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-11",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        0.0,
                        0.0,
                        58.0,
                        20.0
                    ],
                    "text": "Master",
                    "fontname": "Arial",
                    "fontsize": 13,
                    "presentation": 1,
                    "presentation_rect": [
                        5.0,
                        5.0,
                        100.0,
                        20.0
                    ],
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 1,
                    "fontface": 1
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-12",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        0.0,
                        0.0,
                        40.0,
                        20.0
                    ],
                    "text": "+6",
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "presentation": 1,
                    "presentation_rect": [
                        13.0,
                        25.0,
                        20.0,
                        12.0
                    ],
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-13",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        0.0,
                        0.0,
                        40.0,
                        20.0
                    ],
                    "text": "0",
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "presentation": 1,
                    "presentation_rect": [
                        13.0,
                        73.02547770700636,
                        20.0,
                        12.0
                    ],
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-14",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        0.0,
                        0.0,
                        40.0,
                        20.0
                    ],
                    "text": "-6",
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "presentation": 1,
                    "presentation_rect": [
                        13.0,
                        119.39490445859873,
                        20.0,
                        12.0
                    ],
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-15",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        0.0,
                        0.0,
                        40.0,
                        20.0
                    ],
                    "text": "-12",
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "presentation": 1,
                    "presentation_rect": [
                        13.0,
                        145.89171974522293,
                        20.0,
                        12.0
                    ],
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-16",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        0.0,
                        0.0,
                        40.0,
                        20.0
                    ],
                    "text": "-24",
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "presentation": 1,
                    "presentation_rect": [
                        13.0,
                        192.26114649681531,
                        20.0,
                        12.0
                    ],
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-17",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        0.0,
                        0.0,
                        40.0,
                        20.0
                    ],
                    "text": "-48",
                    "fontname": "Arial",
                    "fontsize": 8.0,
                    "presentation": 1,
                    "presentation_rect": [
                        13.0,
                        261.81528662420385,
                        20.0,
                        12.0
                    ],
                    "textcolor": [
                        0.0,
                        0.0,
                        0.0,
                        1.0
                    ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-18",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        200.0,
                        230.0,
                        44.0,
                        22.0
                    ],
                    "text": "/ 128."
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "obj-1",
                        0
                    ],
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "midpoints": [
                        77.0,
                        51.0,
                        222.0,
                        51.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-2",
                        0
                    ],
                    "destination": [
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        147.0,
                        81.0,
                        107.0,
                        81.0
                    ]
                }
            },
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
                        207.0,
                        240.0,
                        44.0,
                        240.0
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
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-3",
                        0
                    ],
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        207.0,
                        305.0,
                        57.0,
                        305.0
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
                        "obj-7",
                        1
                    ],
                    "midpoints": [
                        121.0,
                        266.0,
                        88.0,
                        266.0
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
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        291.0,
                        46.0,
                        267.0,
                        46.0
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
                        "obj-3",
                        0
                    ],
                    "midpoints": [
                        280.0,
                        66.0,
                        222.0,
                        66.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-3",
                        1
                    ],
                    "destination": [
                        "obj-18",
                        0
                    ],
                    "midpoints": [
                        352.0,
                        225.0,
                        209.0,
                        225.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-18",
                        0
                    ],
                    "destination": [
                        "obj-4",
                        1
                    ],
                    "midpoints": [
                        209.0,
                        255.0,
                        352.0,
                        255.0,
                        352.0,
                        112.0,
                        135.0,
                        112.0
                    ]
                }
            }
        ],
        "dependency_cache": [],
        "autosave": 0,
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