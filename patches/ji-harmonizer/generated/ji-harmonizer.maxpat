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
            80.0,
            100.0,
            700.0,
            520.0
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
                    "maxclass": "newobj",
                    "id": "obj-1",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        30.0,
                        58.0,
                        22.0
                    ],
                    "text": "notein",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "kslider",
                    "id": "obj-2",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        135.0,
                        90.0,
                        336.0,
                        53.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        400.0,
                        656.0,
                        80.0
                    ],
                    "mode": 2
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-3",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        135.0,
                        150.0,
                        88.0,
                        22.0
                    ],
                    "text": "pack 0 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-4",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        120.0,
                        240.0,
                        135.0,
                        22.0
                    ],
                    "text": "js ji-engine.js",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "number",
                    "id": "obj-5",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        600.0,
                        165.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        64.0,
                        48.0,
                        22.0
                    ],
                    "minimum": 2,
                    "maximum": 12
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
                        2805.0,
                        30.0,
                        58.0,
                        20.0
                    ],
                    "text": "voices",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        42.0,
                        48.0,
                        17.0
                    ],
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
                    "id": "obj-7",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        600.0,
                        165.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        290.0,
                        64.0,
                        64.0,
                        22.0
                    ],
                    "minimum": 0.0,
                    "maximum": 1.0
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
                        2805.0,
                        75.0,
                        86.0,
                        20.0
                    ],
                    "text": "complexity",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        290.0,
                        42.0,
                        70.0,
                        17.0
                    ],
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
                    "maxclass": "number",
                    "id": "obj-9",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        600.0,
                        165.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        366.0,
                        64.0,
                        48.0,
                        22.0
                    ],
                    "minimum": 0,
                    "maximum": 11
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
                        2805.0,
                        135.0,
                        51.0,
                        20.0
                    ],
                    "text": "tonic",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        366.0,
                        42.0,
                        40.0,
                        17.0
                    ],
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
                    "id": "obj-11",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        600.0,
                        165.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        426.0,
                        64.0,
                        64.0,
                        22.0
                    ],
                    "minimum": 400.0,
                    "maximum": 480.0
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
                        2805.0,
                        180.0,
                        40.0,
                        20.0
                    ],
                    "text": "A4",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        426.0,
                        42.0,
                        40.0,
                        17.0
                    ],
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
                    "maxclass": "umenu",
                    "id": "obj-13",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        600.0,
                        165.0,
                        100.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        502.0,
                        64.0,
                        96.0,
                        22.0
                    ],
                    "items": [
                        "Free",
                        ",",
                        "Close",
                        ",",
                        "Open",
                        ",",
                        "Drop-2",
                        ",",
                        "Thirds",
                        ",",
                        "Quartal",
                        ",",
                        "Quintal"
                    ]
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
                        2805.0,
                        225.0,
                        65.0,
                        20.0
                    ],
                    "text": "voicing",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        502.0,
                        42.0,
                        60.0,
                        17.0
                    ],
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
                    "id": "obj-15",
                    "numinlets": 5,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        600.0,
                        195.0,
                        86.0,
                        22.0
                    ],
                    "text": "p params",
                    "fontname": "Arial",
                    "fontsize": 12.0,
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
                            100.0,
                            100.0,
                            400.0,
                            300.0
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
                                    "maxclass": "inlet",
                                    "id": "obj-1",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "voice count (2-12)"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-2",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        120.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "complexity (0-1)"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-3",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        75.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "tonic (0-11)"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-4",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "master tune A4 (Hz)"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-5",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        165.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "voicing mode (0-6)"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-6",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        390.0,
                                        120.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "tagged param messages to ji-engine"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-7",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        142.0,
                                        22.0
                                    ],
                                    "text": "prepend voicecount",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        315.0,
                                        75.0,
                                        142.0,
                                        22.0
                                    ],
                                    "text": "prepend complexity",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-9",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        180.0,
                                        75.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "prepend tonic",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-10",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        630.0,
                                        75.0,
                                        142.0,
                                        22.0
                                    ],
                                    "text": "prepend mastertune",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-11",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        465.0,
                                        75.0,
                                        149.0,
                                        22.0
                                    ],
                                    "text": "prepend voicingmode",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        45.0,
                                        22.0,
                                        67.0,
                                        22.0,
                                        67.0,
                                        68.0,
                                        101.0,
                                        68.0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        101.0,
                                        67.0,
                                        307.0,
                                        67.0,
                                        307.0,
                                        105.0,
                                        307.0,
                                        67.0,
                                        295.0,
                                        67.0,
                                        295.0,
                                        105.0,
                                        397.0,
                                        105.0
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
                                        "obj-8",
                                        0
                                    ],
                                    "midpoints": [
                                        135.0,
                                        22.0,
                                        248.0,
                                        22.0,
                                        248.0,
                                        68.0,
                                        248.0,
                                        22.0,
                                        203.0,
                                        22.0,
                                        203.0,
                                        68.0,
                                        203.0,
                                        67.0,
                                        180.0,
                                        67.0,
                                        180.0,
                                        105.0,
                                        180.0,
                                        67.0,
                                        295.0,
                                        67.0,
                                        295.0,
                                        105.0,
                                        386.0,
                                        105.0
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
                                        "obj-9",
                                        0
                                    ],
                                    "midpoints": [
                                        90.0,
                                        22.0,
                                        158.0,
                                        22.0,
                                        158.0,
                                        68.0,
                                        158.0,
                                        22.0,
                                        202.0,
                                        22.0,
                                        202.0,
                                        68.0,
                                        202.0,
                                        22.0,
                                        157.0,
                                        22.0,
                                        157.0,
                                        68.0,
                                        157.0,
                                        67.0,
                                        180.0,
                                        67.0,
                                        180.0,
                                        105.0,
                                        233.5,
                                        105.0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        233.5,
                                        67.0,
                                        307.0,
                                        67.0,
                                        307.0,
                                        105.0,
                                        397.0,
                                        105.0
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
                                        "obj-10",
                                        0
                                    ],
                                    "midpoints": [
                                        225.0,
                                        67.0,
                                        465.0,
                                        67.0,
                                        465.0,
                                        105.0,
                                        465.0,
                                        67.0,
                                        295.0,
                                        67.0,
                                        295.0,
                                        105.0,
                                        295.0,
                                        67.0,
                                        457.0,
                                        67.0,
                                        457.0,
                                        105.0,
                                        701.0,
                                        105.0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        701.0,
                                        67.0,
                                        465.0,
                                        67.0,
                                        465.0,
                                        105.0,
                                        465.0,
                                        67.0,
                                        622.0,
                                        67.0,
                                        622.0,
                                        105.0,
                                        397.0,
                                        105.0
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
                                        180.0,
                                        22.0,
                                        248.0,
                                        22.0,
                                        248.0,
                                        68.0,
                                        248.0,
                                        67.0,
                                        180.0,
                                        67.0,
                                        180.0,
                                        105.0,
                                        180.0,
                                        67.0,
                                        307.0,
                                        67.0,
                                        307.0,
                                        105.0,
                                        307.0,
                                        67.0,
                                        295.0,
                                        67.0,
                                        295.0,
                                        105.0,
                                        539.5,
                                        105.0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        539.5,
                                        67.0,
                                        465.0,
                                        67.0,
                                        465.0,
                                        105.0,
                                        397.0,
                                        105.0
                                    ]
                                }
                            }
                        ],
                        "dependency_cache": [],
                        "autosave": 0
                    },
                    "saved_object_attributes": {
                        "description": "",
                        "digest": "",
                        "globalpatchername": "",
                        "tags": ""
                    }
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
                        2805.0,
                        285.0,
                        51.0,
                        20.0
                    ],
                    "text": "ratio",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        42.0,
                        60.0,
                        17.0
                    ],
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
                    "id": "obj-17",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2805.0,
                        330.0,
                        51.0,
                        20.0
                    ],
                    "text": "cents",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        42.0,
                        60.0,
                        17.0
                    ],
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
                    "id": "obj-18",
                    "numinlets": 12,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1350.0,
                        150.0,
                        86.0,
                        22.0
                    ],
                    "text": "p ratios",
                    "fontname": "Arial",
                    "fontsize": 12.0,
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
                            100.0,
                            100.0,
                            400.0,
                            300.0
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
                                    "maxclass": "inlet",
                                    "id": "obj-1",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 0 ratio text"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-2",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        525.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 1 ratio text"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-3",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        120.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 2 ratio text"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-4",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        435.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 3 ratio text"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-5",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 4 ratio text"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-6",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        480.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 5 ratio text"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-7",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        75.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 6 ratio text"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-8",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        390.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 7 ratio text"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-9",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        255.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 8 ratio text"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-10",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        300.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 9 ratio text"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-11",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        165.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 10 ratio text"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-12",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        345.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 11 ratio text"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-13",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        840.0,
                                        120.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "ratio <deg> <n/d> messages to ji-engine"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-14",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-15",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1545.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-16",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        300.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-17",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1275.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 3",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-18",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        585.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 4",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-19",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1410.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 5",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-20",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        165.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 6",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-21",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1125.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 7",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-22",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        720.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 8",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-23",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        855.0,
                                        75.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 9",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-24",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        435.0,
                                        75.0,
                                        128.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 10",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-25",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        990.0,
                                        75.0,
                                        128.0,
                                        22.0
                                    ],
                                    "text": "prepend ratio 11",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        "obj-14",
                                        0
                                    ],
                                    "midpoints": [
                                        45.0,
                                        22.0,
                                        67.0,
                                        22.0,
                                        67.0,
                                        68.0,
                                        90.5,
                                        68.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-14",
                                        0
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        90.5,
                                        67.0,
                                        429.0,
                                        67.0,
                                        429.0,
                                        105.0,
                                        429.0,
                                        67.0,
                                        577.0,
                                        67.0,
                                        577.0,
                                        105.0,
                                        577.0,
                                        67.0,
                                        294.0,
                                        67.0,
                                        294.0,
                                        105.0,
                                        294.0,
                                        67.0,
                                        712.0,
                                        67.0,
                                        712.0,
                                        105.0,
                                        712.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        847.0,
                                        67.0,
                                        427.0,
                                        67.0,
                                        427.0,
                                        105.0,
                                        847.0,
                                        105.0
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
                                        "obj-15",
                                        0
                                    ],
                                    "midpoints": [
                                        540.0,
                                        67.0,
                                        1267.0,
                                        67.0,
                                        1267.0,
                                        105.0,
                                        1267.0,
                                        67.0,
                                        714.0,
                                        67.0,
                                        714.0,
                                        105.0,
                                        714.0,
                                        67.0,
                                        1402.0,
                                        67.0,
                                        1402.0,
                                        105.0,
                                        1402.0,
                                        67.0,
                                        1117.0,
                                        67.0,
                                        1117.0,
                                        105.0,
                                        1117.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        984.0,
                                        67.0,
                                        984.0,
                                        105.0,
                                        984.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        571.0,
                                        67.0,
                                        1126.0,
                                        67.0,
                                        1126.0,
                                        105.0,
                                        1605.5,
                                        105.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-15",
                                        0
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        1605.5,
                                        67.0,
                                        1267.0,
                                        67.0,
                                        1267.0,
                                        105.0,
                                        1267.0,
                                        67.0,
                                        1402.0,
                                        67.0,
                                        1402.0,
                                        105.0,
                                        1402.0,
                                        67.0,
                                        1254.0,
                                        67.0,
                                        1254.0,
                                        105.0,
                                        1254.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        984.0,
                                        67.0,
                                        984.0,
                                        105.0,
                                        984.0,
                                        67.0,
                                        1126.0,
                                        67.0,
                                        1126.0,
                                        105.0,
                                        847.0,
                                        105.0
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
                                        "obj-16",
                                        0
                                    ],
                                    "midpoints": [
                                        135.0,
                                        22.0,
                                        248.0,
                                        22.0,
                                        248.0,
                                        68.0,
                                        248.0,
                                        22.0,
                                        247.0,
                                        22.0,
                                        247.0,
                                        68.0,
                                        247.0,
                                        22.0,
                                        292.0,
                                        22.0,
                                        292.0,
                                        68.0,
                                        292.0,
                                        22.0,
                                        203.0,
                                        22.0,
                                        203.0,
                                        68.0,
                                        203.0,
                                        22.0,
                                        337.0,
                                        22.0,
                                        337.0,
                                        68.0,
                                        337.0,
                                        67.0,
                                        159.0,
                                        67.0,
                                        159.0,
                                        105.0,
                                        159.0,
                                        67.0,
                                        294.0,
                                        67.0,
                                        294.0,
                                        105.0,
                                        360.5,
                                        105.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-16",
                                        0
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        360.5,
                                        67.0,
                                        577.0,
                                        67.0,
                                        577.0,
                                        105.0,
                                        577.0,
                                        67.0,
                                        712.0,
                                        67.0,
                                        712.0,
                                        105.0,
                                        712.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        847.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        847.0,
                                        105.0
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
                                        "obj-17",
                                        0
                                    ],
                                    "midpoints": [
                                        450.0,
                                        22.0,
                                        563.0,
                                        22.0,
                                        563.0,
                                        68.0,
                                        563.0,
                                        22.0,
                                        518.0,
                                        22.0,
                                        518.0,
                                        68.0,
                                        518.0,
                                        67.0,
                                        714.0,
                                        67.0,
                                        714.0,
                                        105.0,
                                        714.0,
                                        67.0,
                                        1117.0,
                                        67.0,
                                        1117.0,
                                        105.0,
                                        1117.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        847.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        571.0,
                                        67.0,
                                        982.0,
                                        67.0,
                                        982.0,
                                        105.0,
                                        1335.5,
                                        105.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-17",
                                        0
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        1335.5,
                                        67.0,
                                        1117.0,
                                        67.0,
                                        1117.0,
                                        105.0,
                                        1117.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        984.0,
                                        67.0,
                                        984.0,
                                        105.0,
                                        984.0,
                                        67.0,
                                        1126.0,
                                        67.0,
                                        1126.0,
                                        105.0,
                                        847.0,
                                        105.0
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
                                        "obj-18",
                                        0
                                    ],
                                    "midpoints": [
                                        225.0,
                                        22.0,
                                        517.0,
                                        22.0,
                                        517.0,
                                        68.0,
                                        517.0,
                                        22.0,
                                        427.0,
                                        22.0,
                                        427.0,
                                        68.0,
                                        427.0,
                                        22.0,
                                        472.0,
                                        22.0,
                                        472.0,
                                        68.0,
                                        472.0,
                                        22.0,
                                        428.0,
                                        22.0,
                                        428.0,
                                        68.0,
                                        428.0,
                                        22.0,
                                        293.0,
                                        22.0,
                                        293.0,
                                        68.0,
                                        293.0,
                                        22.0,
                                        338.0,
                                        22.0,
                                        338.0,
                                        68.0,
                                        338.0,
                                        22.0,
                                        383.0,
                                        22.0,
                                        383.0,
                                        68.0,
                                        383.0,
                                        67.0,
                                        429.0,
                                        67.0,
                                        429.0,
                                        105.0,
                                        429.0,
                                        67.0,
                                        294.0,
                                        67.0,
                                        294.0,
                                        105.0,
                                        294.0,
                                        67.0,
                                        427.0,
                                        67.0,
                                        427.0,
                                        105.0,
                                        645.5,
                                        105.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        645.5,
                                        67.0,
                                        712.0,
                                        67.0,
                                        712.0,
                                        105.0,
                                        712.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        847.0,
                                        105.0
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
                                        "obj-19",
                                        0
                                    ],
                                    "midpoints": [
                                        495.0,
                                        22.0,
                                        563.0,
                                        22.0,
                                        563.0,
                                        68.0,
                                        563.0,
                                        67.0,
                                        1267.0,
                                        67.0,
                                        1267.0,
                                        105.0,
                                        1267.0,
                                        67.0,
                                        714.0,
                                        67.0,
                                        714.0,
                                        105.0,
                                        714.0,
                                        67.0,
                                        1117.0,
                                        67.0,
                                        1117.0,
                                        105.0,
                                        1117.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        984.0,
                                        67.0,
                                        984.0,
                                        105.0,
                                        984.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        571.0,
                                        67.0,
                                        982.0,
                                        67.0,
                                        982.0,
                                        105.0,
                                        1470.5,
                                        105.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-19",
                                        0
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        1470.5,
                                        67.0,
                                        1267.0,
                                        67.0,
                                        1267.0,
                                        105.0,
                                        1267.0,
                                        67.0,
                                        1117.0,
                                        67.0,
                                        1117.0,
                                        105.0,
                                        1117.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        984.0,
                                        67.0,
                                        984.0,
                                        105.0,
                                        984.0,
                                        67.0,
                                        1126.0,
                                        67.0,
                                        1126.0,
                                        105.0,
                                        847.0,
                                        105.0
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
                                        "obj-20",
                                        0
                                    ],
                                    "midpoints": [
                                        90.0,
                                        22.0,
                                        158.0,
                                        22.0,
                                        158.0,
                                        68.0,
                                        158.0,
                                        22.0,
                                        202.0,
                                        22.0,
                                        202.0,
                                        68.0,
                                        202.0,
                                        22.0,
                                        157.0,
                                        22.0,
                                        157.0,
                                        68.0,
                                        157.0,
                                        67.0,
                                        159.0,
                                        67.0,
                                        159.0,
                                        105.0,
                                        225.5,
                                        105.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-20",
                                        0
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        225.5,
                                        67.0,
                                        429.0,
                                        67.0,
                                        429.0,
                                        105.0,
                                        429.0,
                                        67.0,
                                        577.0,
                                        67.0,
                                        577.0,
                                        105.0,
                                        577.0,
                                        67.0,
                                        712.0,
                                        67.0,
                                        712.0,
                                        105.0,
                                        712.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        847.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        847.0,
                                        105.0
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
                                        "obj-21",
                                        0
                                    ],
                                    "midpoints": [
                                        405.0,
                                        22.0,
                                        563.0,
                                        22.0,
                                        563.0,
                                        68.0,
                                        563.0,
                                        22.0,
                                        473.0,
                                        22.0,
                                        473.0,
                                        68.0,
                                        473.0,
                                        22.0,
                                        518.0,
                                        22.0,
                                        518.0,
                                        68.0,
                                        518.0,
                                        67.0,
                                        429.0,
                                        67.0,
                                        429.0,
                                        105.0,
                                        429.0,
                                        67.0,
                                        714.0,
                                        67.0,
                                        714.0,
                                        105.0,
                                        714.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        847.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        571.0,
                                        67.0,
                                        982.0,
                                        67.0,
                                        982.0,
                                        105.0,
                                        1185.5,
                                        105.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-21",
                                        0
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        1185.5,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        984.0,
                                        67.0,
                                        984.0,
                                        105.0,
                                        984.0,
                                        67.0,
                                        982.0,
                                        67.0,
                                        982.0,
                                        105.0,
                                        847.0,
                                        105.0
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
                                        "obj-22",
                                        0
                                    ],
                                    "midpoints": [
                                        270.0,
                                        22.0,
                                        517.0,
                                        22.0,
                                        517.0,
                                        68.0,
                                        517.0,
                                        22.0,
                                        473.0,
                                        22.0,
                                        473.0,
                                        68.0,
                                        473.0,
                                        22.0,
                                        518.0,
                                        22.0,
                                        518.0,
                                        68.0,
                                        518.0,
                                        22.0,
                                        428.0,
                                        22.0,
                                        428.0,
                                        68.0,
                                        428.0,
                                        22.0,
                                        338.0,
                                        22.0,
                                        338.0,
                                        68.0,
                                        338.0,
                                        22.0,
                                        383.0,
                                        22.0,
                                        383.0,
                                        68.0,
                                        383.0,
                                        67.0,
                                        429.0,
                                        67.0,
                                        429.0,
                                        105.0,
                                        429.0,
                                        67.0,
                                        577.0,
                                        67.0,
                                        577.0,
                                        105.0,
                                        577.0,
                                        67.0,
                                        294.0,
                                        67.0,
                                        294.0,
                                        105.0,
                                        294.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        780.5,
                                        105.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-22",
                                        0
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        780.5,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        847.0,
                                        105.0
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
                                        "obj-23",
                                        0
                                    ],
                                    "midpoints": [
                                        315.0,
                                        22.0,
                                        563.0,
                                        22.0,
                                        563.0,
                                        68.0,
                                        563.0,
                                        22.0,
                                        473.0,
                                        22.0,
                                        473.0,
                                        68.0,
                                        473.0,
                                        22.0,
                                        518.0,
                                        22.0,
                                        518.0,
                                        68.0,
                                        518.0,
                                        22.0,
                                        428.0,
                                        22.0,
                                        428.0,
                                        68.0,
                                        428.0,
                                        22.0,
                                        383.0,
                                        22.0,
                                        383.0,
                                        68.0,
                                        383.0,
                                        67.0,
                                        429.0,
                                        67.0,
                                        429.0,
                                        105.0,
                                        429.0,
                                        67.0,
                                        577.0,
                                        67.0,
                                        577.0,
                                        105.0,
                                        577.0,
                                        67.0,
                                        712.0,
                                        67.0,
                                        712.0,
                                        105.0,
                                        712.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        915.5,
                                        105.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-23",
                                        0
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        915.5,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        847.0,
                                        105.0
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
                                        "obj-24",
                                        0
                                    ],
                                    "midpoints": [
                                        180.0,
                                        22.0,
                                        427.0,
                                        22.0,
                                        427.0,
                                        68.0,
                                        427.0,
                                        22.0,
                                        248.0,
                                        22.0,
                                        248.0,
                                        68.0,
                                        248.0,
                                        22.0,
                                        472.0,
                                        22.0,
                                        472.0,
                                        68.0,
                                        472.0,
                                        22.0,
                                        382.0,
                                        22.0,
                                        382.0,
                                        68.0,
                                        382.0,
                                        22.0,
                                        293.0,
                                        22.0,
                                        293.0,
                                        68.0,
                                        293.0,
                                        22.0,
                                        338.0,
                                        22.0,
                                        338.0,
                                        68.0,
                                        338.0,
                                        22.0,
                                        337.0,
                                        22.0,
                                        337.0,
                                        68.0,
                                        337.0,
                                        67.0,
                                        292.0,
                                        67.0,
                                        292.0,
                                        105.0,
                                        292.0,
                                        67.0,
                                        294.0,
                                        67.0,
                                        294.0,
                                        105.0,
                                        499.0,
                                        105.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-24",
                                        0
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        499.0,
                                        67.0,
                                        714.0,
                                        67.0,
                                        714.0,
                                        105.0,
                                        714.0,
                                        67.0,
                                        712.0,
                                        67.0,
                                        712.0,
                                        105.0,
                                        712.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        847.0,
                                        105.0
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
                                        "obj-25",
                                        0
                                    ],
                                    "midpoints": [
                                        360.0,
                                        22.0,
                                        563.0,
                                        22.0,
                                        563.0,
                                        68.0,
                                        563.0,
                                        22.0,
                                        473.0,
                                        22.0,
                                        473.0,
                                        68.0,
                                        473.0,
                                        22.0,
                                        518.0,
                                        22.0,
                                        518.0,
                                        68.0,
                                        518.0,
                                        22.0,
                                        428.0,
                                        22.0,
                                        428.0,
                                        68.0,
                                        428.0,
                                        67.0,
                                        429.0,
                                        67.0,
                                        429.0,
                                        105.0,
                                        429.0,
                                        67.0,
                                        714.0,
                                        67.0,
                                        714.0,
                                        105.0,
                                        714.0,
                                        67.0,
                                        712.0,
                                        67.0,
                                        712.0,
                                        105.0,
                                        712.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        847.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        1054.0,
                                        105.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-25",
                                        0
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        1054.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        984.0,
                                        67.0,
                                        984.0,
                                        105.0,
                                        847.0,
                                        105.0
                                    ]
                                }
                            }
                        ],
                        "dependency_cache": [],
                        "autosave": 0
                    },
                    "saved_object_attributes": {
                        "description": "",
                        "digest": "",
                        "globalpatchername": "",
                        "tags": ""
                    }
                }
            },
            {
                "box": {
                    "maxclass": "textedit",
                    "id": "obj-19",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        2565.0,
                        30.0,
                        200.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        64.0,
                        76.0,
                        22.0
                    ],
                    "text": "1/1",
                    "fontsize": 11.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-20",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2805.0,
                        375.0,
                        40.0,
                        20.0
                    ],
                    "text": "0",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        67.0,
                        26.0,
                        17.0
                    ],
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
                    "maxclass": "textedit",
                    "id": "obj-21",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1920.0,
                        30.0,
                        200.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        90.0,
                        76.0,
                        22.0
                    ],
                    "text": "17/16",
                    "fontsize": 11.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-22",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2910.0,
                        30.0,
                        40.0,
                        20.0
                    ],
                    "text": "1",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        93.0,
                        26.0,
                        17.0
                    ],
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
                    "maxclass": "textedit",
                    "id": "obj-23",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1065.0,
                        30.0,
                        200.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        116.0,
                        76.0,
                        22.0
                    ],
                    "text": "9/8",
                    "fontsize": 11.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-24",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2910.0,
                        75.0,
                        40.0,
                        20.0
                    ],
                    "text": "2",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        119.0,
                        26.0,
                        17.0
                    ],
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
                    "maxclass": "textedit",
                    "id": "obj-25",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1275.0,
                        30.0,
                        200.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        142.0,
                        76.0,
                        22.0
                    ],
                    "text": "19/16",
                    "fontsize": 11.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-26",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2910.0,
                        135.0,
                        40.0,
                        20.0
                    ],
                    "text": "3",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        145.0,
                        26.0,
                        17.0
                    ],
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
                    "maxclass": "textedit",
                    "id": "obj-27",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        2355.0,
                        30.0,
                        200.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        168.0,
                        76.0,
                        22.0
                    ],
                    "text": "5/4",
                    "fontsize": 11.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-28",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2910.0,
                        180.0,
                        40.0,
                        20.0
                    ],
                    "text": "4",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        171.0,
                        26.0,
                        17.0
                    ],
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
                    "maxclass": "textedit",
                    "id": "obj-29",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1500.0,
                        30.0,
                        200.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        194.0,
                        76.0,
                        22.0
                    ],
                    "text": "21/16",
                    "fontsize": 11.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-30",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2910.0,
                        225.0,
                        40.0,
                        20.0
                    ],
                    "text": "5",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        197.0,
                        26.0,
                        17.0
                    ],
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
                    "maxclass": "textedit",
                    "id": "obj-31",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        2145.0,
                        30.0,
                        200.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        220.0,
                        76.0,
                        22.0
                    ],
                    "text": "11/8",
                    "fontsize": 11.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-32",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2910.0,
                        285.0,
                        40.0,
                        20.0
                    ],
                    "text": "6",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        223.0,
                        26.0,
                        17.0
                    ],
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
                    "maxclass": "textedit",
                    "id": "obj-33",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        630.0,
                        30.0,
                        200.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        246.0,
                        76.0,
                        22.0
                    ],
                    "text": "23/16",
                    "fontsize": 11.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-34",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2910.0,
                        330.0,
                        40.0,
                        20.0
                    ],
                    "text": "7",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        249.0,
                        26.0,
                        17.0
                    ],
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
                    "maxclass": "textedit",
                    "id": "obj-35",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        420.0,
                        30.0,
                        200.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        272.0,
                        76.0,
                        22.0
                    ],
                    "text": "3/2",
                    "fontsize": 11.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-36",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2910.0,
                        375.0,
                        40.0,
                        20.0
                    ],
                    "text": "8",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        275.0,
                        26.0,
                        17.0
                    ],
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
                    "maxclass": "textedit",
                    "id": "obj-37",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        210.0,
                        30.0,
                        200.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        298.0,
                        76.0,
                        22.0
                    ],
                    "text": "13/8",
                    "fontsize": 11.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-38",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2970.0,
                        30.0,
                        40.0,
                        20.0
                    ],
                    "text": "9",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        301.0,
                        26.0,
                        17.0
                    ],
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
                    "maxclass": "textedit",
                    "id": "obj-39",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1710.0,
                        30.0,
                        200.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        324.0,
                        76.0,
                        22.0
                    ],
                    "text": "7/4",
                    "fontsize": 11.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-40",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2970.0,
                        75.0,
                        40.0,
                        20.0
                    ],
                    "text": "10",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        327.0,
                        26.0,
                        17.0
                    ],
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
                    "maxclass": "textedit",
                    "id": "obj-41",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        855.0,
                        30.0,
                        200.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        46.0,
                        350.0,
                        76.0,
                        22.0
                    ],
                    "text": "15/8",
                    "fontsize": 11.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-42",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2970.0,
                        135.0,
                        40.0,
                        20.0
                    ],
                    "text": "11",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        16.0,
                        353.0,
                        26.0,
                        17.0
                    ],
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
                    "id": "obj-43",
                    "numinlets": 1,
                    "numoutlets": 13,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        120.0,
                        270.0,
                        233.0,
                        22.0
                    ],
                    "text": "route 0 1 2 3 4 5 6 7 8 9 10 11",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-44",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        105.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        64.0,
                        64.0,
                        22.0
                    ],
                    "ignoreclick": 1,
                    "numdecimalplaces": 2
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-45",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        180.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        90.0,
                        64.0,
                        22.0
                    ],
                    "ignoreclick": 1,
                    "numdecimalplaces": 2
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-46",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        240.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        116.0,
                        64.0,
                        22.0
                    ],
                    "ignoreclick": 1,
                    "numdecimalplaces": 2
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-47",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        300.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        142.0,
                        64.0,
                        22.0
                    ],
                    "ignoreclick": 1,
                    "numdecimalplaces": 2
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-48",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        375.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        168.0,
                        64.0,
                        22.0
                    ],
                    "ignoreclick": 1,
                    "numdecimalplaces": 2
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-49",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        435.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        194.0,
                        64.0,
                        22.0
                    ],
                    "ignoreclick": 1,
                    "numdecimalplaces": 2
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-50",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        495.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        220.0,
                        64.0,
                        22.0
                    ],
                    "ignoreclick": 1,
                    "numdecimalplaces": 2
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-51",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        570.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        246.0,
                        64.0,
                        22.0
                    ],
                    "ignoreclick": 1,
                    "numdecimalplaces": 2
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-52",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        630.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        272.0,
                        64.0,
                        22.0
                    ],
                    "ignoreclick": 1,
                    "numdecimalplaces": 2
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-53",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        690.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        298.0,
                        64.0,
                        22.0
                    ],
                    "ignoreclick": 1,
                    "numdecimalplaces": 2
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-54",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        765.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        324.0,
                        64.0,
                        22.0
                    ],
                    "ignoreclick": 1,
                    "numdecimalplaces": 2
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-55",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        825.0,
                        315.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        350.0,
                        64.0,
                        22.0
                    ],
                    "ignoreclick": 1,
                    "numdecimalplaces": 2
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-56",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        375.0,
                        270.0,
                        135.0,
                        22.0
                    ],
                    "text": "mc.sig~ @chans 12",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-57",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        525.0,
                        270.0,
                        135.0,
                        22.0
                    ],
                    "text": "mc.sig~ @chans 12",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-58",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        885.0,
                        315.0,
                        142.5,
                        22.0
                    ],
                    "text": "mc.cycle~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-59",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1050.0,
                        315.0,
                        184.0,
                        22.0
                    ],
                    "text": "mc.rampsmooth~ 2205 2205",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-60",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1020.0,
                        360.0,
                        51.0,
                        22.0
                    ],
                    "text": "mc.*~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-61",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1035.0,
                        405.0,
                        164.0,
                        22.0
                    ],
                    "text": "mc.mixdown~ 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-62",
                    "numinlets": 5,
                    "numoutlets": 4,
                    "outlettype": [
                        "signal",
                        "signal",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        675.0,
                        270.0,
                        177.0,
                        22.0
                    ],
                    "text": "adsr~ 10. 150. 0.7 400.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-63",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        885.0,
                        450.0,
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
                    "maxclass": "newobj",
                    "id": "obj-64",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        900.0,
                        480.0,
                        58.0,
                        22.0
                    ],
                    "text": "*~ 0.1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "gain~",
                    "id": "obj-65",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        540.0,
                        525.0,
                        22.0,
                        140.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        620.0,
                        110.0,
                        30.0,
                        150.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-66",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        570.0,
                        525.0,
                        15.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        655.0,
                        110.0,
                        15.0,
                        150.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "ezdac~",
                    "id": "obj-67",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        525.0,
                        690.0,
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
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-68",
                    "numinlets": 1,
                    "numoutlets": 7,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        105.0,
                        30.0,
                        86.0,
                        22.0
                    ],
                    "text": "p init",
                    "fontname": "Arial",
                    "fontsize": 12.0,
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
                            100.0,
                            100.0,
                            400.0,
                            300.0
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
                                    "maxclass": "inlet",
                                    "id": "obj-1",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "unused (re-init bang)"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-2",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        135.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "voices init"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-3",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        210.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "complexity init"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-4",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        300.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "tonic init"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-5",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        375.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "A4 init"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-6",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        450.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "voicing init"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-7",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        540.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "gain init"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-8",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        60.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "dump cents"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-9",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        75.0,
                                        30.0,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "loadbang",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-10",
                                    "numinlets": 1,
                                    "numoutlets": 7,
                                    "outlettype": [
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        163.0,
                                        22.0
                                    ],
                                    "text": "trigger b b b b b b b",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-11",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        120.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "dump",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-12",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        105.0,
                                        120.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "5",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-13",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        195.0,
                                        120.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "0.5",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-14",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        120.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-15",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        345.0,
                                        120.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "440.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-16",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        435.0,
                                        120.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-17",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        510.0,
                                        120.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "120",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "source": [
                                        "obj-9",
                                        0
                                    ],
                                    "destination": [
                                        "obj-10",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-1",
                                        0
                                    ],
                                    "destination": [
                                        "obj-10",
                                        0
                                    ],
                                    "midpoints": [
                                        45.0,
                                        67.5,
                                        111.5,
                                        67.5
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
                                        0
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
                                        "obj-8",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-10",
                                        1
                                    ],
                                    "destination": [
                                        "obj-12",
                                        0
                                    ],
                                    "midpoints": [
                                        61.83333333333333,
                                        112.0,
                                        103.0,
                                        112.0,
                                        103.0,
                                        150.0,
                                        112.0,
                                        150.0
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
                                        "obj-2",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-10",
                                        2
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        86.66666666666666,
                                        112.0,
                                        103.0,
                                        112.0,
                                        103.0,
                                        150.0,
                                        103.0,
                                        112.0,
                                        178.0,
                                        112.0,
                                        178.0,
                                        150.0,
                                        202.0,
                                        150.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-13",
                                        0
                                    ],
                                    "destination": [
                                        "obj-3",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-10",
                                        3
                                    ],
                                    "destination": [
                                        "obj-14",
                                        0
                                    ],
                                    "midpoints": [
                                        111.5,
                                        112.0,
                                        178.0,
                                        112.0,
                                        178.0,
                                        150.0,
                                        178.0,
                                        112.0,
                                        187.0,
                                        112.0,
                                        187.0,
                                        150.0,
                                        277.0,
                                        150.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-14",
                                        0
                                    ],
                                    "destination": [
                                        "obj-4",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-10",
                                        4
                                    ],
                                    "destination": [
                                        "obj-15",
                                        0
                                    ],
                                    "midpoints": [
                                        136.33333333333331,
                                        112.0,
                                        178.0,
                                        112.0,
                                        178.0,
                                        150.0,
                                        178.0,
                                        112.0,
                                        268.0,
                                        112.0,
                                        268.0,
                                        150.0,
                                        268.0,
                                        112.0,
                                        262.0,
                                        112.0,
                                        262.0,
                                        150.0,
                                        352.0,
                                        150.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-15",
                                        0
                                    ],
                                    "destination": [
                                        "obj-5",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-10",
                                        5
                                    ],
                                    "destination": [
                                        "obj-16",
                                        0
                                    ],
                                    "midpoints": [
                                        161.16666666666666,
                                        112.0,
                                        178.0,
                                        112.0,
                                        178.0,
                                        150.0,
                                        178.0,
                                        112.0,
                                        268.0,
                                        112.0,
                                        268.0,
                                        150.0,
                                        268.0,
                                        112.0,
                                        262.0,
                                        112.0,
                                        262.0,
                                        150.0,
                                        262.0,
                                        112.0,
                                        337.0,
                                        112.0,
                                        337.0,
                                        150.0,
                                        442.0,
                                        150.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-16",
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
                                        "obj-10",
                                        6
                                    ],
                                    "destination": [
                                        "obj-17",
                                        0
                                    ],
                                    "midpoints": [
                                        186.0,
                                        112.0,
                                        268.0,
                                        112.0,
                                        268.0,
                                        150.0,
                                        268.0,
                                        112.0,
                                        343.0,
                                        112.0,
                                        343.0,
                                        150.0,
                                        343.0,
                                        112.0,
                                        337.0,
                                        112.0,
                                        337.0,
                                        150.0,
                                        337.0,
                                        112.0,
                                        427.0,
                                        112.0,
                                        427.0,
                                        150.0,
                                        517.0,
                                        150.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-17",
                                        0
                                    ],
                                    "destination": [
                                        "obj-7",
                                        0
                                    ]
                                }
                            }
                        ],
                        "dependency_cache": [],
                        "autosave": 0
                    },
                    "saved_object_attributes": {
                        "description": "",
                        "digest": "",
                        "globalpatchername": "",
                        "tags": ""
                    }
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-69",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2970.0,
                        180.0,
                        275.0,
                        20.0
                    ],
                    "text": "JI HARMONIZER — tuning + chord engine",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        10.0,
                        320.0,
                        24.0
                    ],
                    "fontface": 1,
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
                    "id": "obj-70",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2970.0,
                        225.0,
                        65.0,
                        20.0
                    ],
                    "text": "vv0.0.1",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
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
                        37.0,
                        22.0,
                        97.0,
                        22.0,
                        97.0,
                        60.0,
                        97.0,
                        82.0,
                        127.0,
                        82.0,
                        127.0,
                        151.0,
                        142.0,
                        151.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-1",
                        1
                    ],
                    "destination": [
                        "obj-3",
                        1
                    ],
                    "midpoints": [
                        59.0,
                        22.0,
                        202.0,
                        22.0,
                        202.0,
                        138.0,
                        202.0,
                        22.0,
                        97.0,
                        22.0,
                        97.0,
                        60.0,
                        97.0,
                        82.0,
                        127.0,
                        82.0,
                        127.0,
                        151.0,
                        216.0,
                        151.0
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
                        "obj-3",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-2",
                        1
                    ],
                    "destination": [
                        "obj-3",
                        1
                    ],
                    "midpoints": [
                        464.0,
                        146.5,
                        216.0,
                        146.5
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
                        "obj-4",
                        0
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        607.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        607.0,
                        195.0
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
                        "obj-15",
                        1
                    ],
                    "midpoints": [
                        607.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        625.0,
                        195.0
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
                        "obj-15",
                        2
                    ],
                    "midpoints": [
                        607.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        643.0,
                        195.0
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
                        "obj-15",
                        3
                    ],
                    "midpoints": [
                        607.0,
                        157.0,
                        658.0,
                        157.0,
                        658.0,
                        195.0,
                        658.0,
                        157.0,
                        658.0,
                        157.0,
                        658.0,
                        195.0,
                        658.0,
                        157.0,
                        658.0,
                        157.0,
                        658.0,
                        195.0,
                        658.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        661.0,
                        195.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-13",
                        0
                    ],
                    "destination": [
                        "obj-15",
                        4
                    ],
                    "midpoints": [
                        607.0,
                        157.0,
                        658.0,
                        157.0,
                        658.0,
                        195.0,
                        658.0,
                        157.0,
                        658.0,
                        157.0,
                        658.0,
                        195.0,
                        658.0,
                        157.0,
                        658.0,
                        157.0,
                        658.0,
                        195.0,
                        658.0,
                        157.0,
                        658.0,
                        157.0,
                        658.0,
                        195.0,
                        679.0,
                        195.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-15",
                        0
                    ],
                    "destination": [
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        643.0,
                        228.5,
                        187.5,
                        228.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-19",
                        0
                    ],
                    "destination": [
                        "obj-18",
                        0
                    ],
                    "midpoints": [
                        2572.0,
                        22.0,
                        1912.0,
                        22.0,
                        1912.0,
                        138.0,
                        1912.0,
                        22.0,
                        1483.0,
                        22.0,
                        1483.0,
                        138.0,
                        1483.0,
                        22.0,
                        2347.0,
                        22.0,
                        2347.0,
                        138.0,
                        2347.0,
                        22.0,
                        1708.0,
                        22.0,
                        1708.0,
                        138.0,
                        1708.0,
                        22.0,
                        2137.0,
                        22.0,
                        2137.0,
                        138.0,
                        2137.0,
                        22.0,
                        1918.0,
                        22.0,
                        1918.0,
                        138.0,
                        1357.0,
                        138.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-21",
                        0
                    ],
                    "destination": [
                        "obj-18",
                        1
                    ],
                    "midpoints": [
                        1927.0,
                        22.0,
                        1483.0,
                        22.0,
                        1483.0,
                        138.0,
                        1483.0,
                        22.0,
                        1708.0,
                        22.0,
                        1708.0,
                        138.0,
                        1708.0,
                        22.0,
                        1702.0,
                        22.0,
                        1702.0,
                        138.0,
                        1363.5454545454545,
                        138.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-23",
                        0
                    ],
                    "destination": [
                        "obj-18",
                        2
                    ],
                    "midpoints": [
                        1072.0,
                        22.0,
                        1267.0,
                        22.0,
                        1267.0,
                        138.0,
                        1370.090909090909,
                        138.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-25",
                        0
                    ],
                    "destination": [
                        "obj-18",
                        3
                    ],
                    "midpoints": [
                        1282.0,
                        140.0,
                        1376.6363636363637,
                        140.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-27",
                        0
                    ],
                    "destination": [
                        "obj-18",
                        4
                    ],
                    "midpoints": [
                        2362.0,
                        22.0,
                        1912.0,
                        22.0,
                        1912.0,
                        138.0,
                        1912.0,
                        22.0,
                        1483.0,
                        22.0,
                        1483.0,
                        138.0,
                        1483.0,
                        22.0,
                        1708.0,
                        22.0,
                        1708.0,
                        138.0,
                        1708.0,
                        22.0,
                        2137.0,
                        22.0,
                        2137.0,
                        138.0,
                        2137.0,
                        22.0,
                        1918.0,
                        22.0,
                        1918.0,
                        138.0,
                        1383.1818181818182,
                        138.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-29",
                        0
                    ],
                    "destination": [
                        "obj-18",
                        5
                    ],
                    "midpoints": [
                        1507.0,
                        22.0,
                        1483.0,
                        22.0,
                        1483.0,
                        138.0,
                        1389.7272727272727,
                        138.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-31",
                        0
                    ],
                    "destination": [
                        "obj-18",
                        6
                    ],
                    "midpoints": [
                        2152.0,
                        22.0,
                        1912.0,
                        22.0,
                        1912.0,
                        138.0,
                        1912.0,
                        22.0,
                        1483.0,
                        22.0,
                        1483.0,
                        138.0,
                        1483.0,
                        22.0,
                        1708.0,
                        22.0,
                        1708.0,
                        138.0,
                        1708.0,
                        22.0,
                        1702.0,
                        22.0,
                        1702.0,
                        138.0,
                        1396.2727272727273,
                        138.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-33",
                        0
                    ],
                    "destination": [
                        "obj-18",
                        7
                    ],
                    "midpoints": [
                        637.0,
                        22.0,
                        1057.0,
                        22.0,
                        1057.0,
                        138.0,
                        1057.0,
                        22.0,
                        1267.0,
                        22.0,
                        1267.0,
                        138.0,
                        1267.0,
                        22.0,
                        1063.0,
                        22.0,
                        1063.0,
                        138.0,
                        1402.8181818181818,
                        138.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-35",
                        0
                    ],
                    "destination": [
                        "obj-18",
                        8
                    ],
                    "midpoints": [
                        427.0,
                        22.0,
                        1057.0,
                        22.0,
                        1057.0,
                        138.0,
                        1057.0,
                        22.0,
                        1267.0,
                        22.0,
                        1267.0,
                        138.0,
                        1267.0,
                        22.0,
                        838.0,
                        22.0,
                        838.0,
                        138.0,
                        838.0,
                        22.0,
                        847.0,
                        22.0,
                        847.0,
                        138.0,
                        847.0,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        1409.3636363636363,
                        151.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-37",
                        0
                    ],
                    "destination": [
                        "obj-18",
                        9
                    ],
                    "midpoints": [
                        217.0,
                        22.0,
                        1057.0,
                        22.0,
                        1057.0,
                        138.0,
                        1057.0,
                        22.0,
                        1267.0,
                        22.0,
                        1267.0,
                        138.0,
                        1267.0,
                        22.0,
                        838.0,
                        22.0,
                        838.0,
                        138.0,
                        838.0,
                        22.0,
                        628.0,
                        22.0,
                        628.0,
                        138.0,
                        628.0,
                        22.0,
                        847.0,
                        22.0,
                        847.0,
                        138.0,
                        847.0,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        479.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        1415.909090909091,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-39",
                        0
                    ],
                    "destination": [
                        "obj-18",
                        10
                    ],
                    "midpoints": [
                        1717.0,
                        22.0,
                        1483.0,
                        22.0,
                        1483.0,
                        138.0,
                        1483.0,
                        22.0,
                        1492.0,
                        22.0,
                        1492.0,
                        138.0,
                        1422.4545454545455,
                        138.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-41",
                        0
                    ],
                    "destination": [
                        "obj-18",
                        11
                    ],
                    "midpoints": [
                        862.0,
                        22.0,
                        1057.0,
                        22.0,
                        1057.0,
                        138.0,
                        1057.0,
                        22.0,
                        1267.0,
                        22.0,
                        1267.0,
                        138.0,
                        1429.0,
                        138.0
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
                        0
                    ],
                    "midpoints": [
                        1393.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        157.0,
                        658.0,
                        157.0,
                        658.0,
                        195.0,
                        658.0,
                        157.0,
                        658.0,
                        157.0,
                        658.0,
                        195.0,
                        658.0,
                        157.0,
                        658.0,
                        157.0,
                        658.0,
                        195.0,
                        658.0,
                        157.0,
                        658.0,
                        157.0,
                        658.0,
                        195.0,
                        658.0,
                        157.0,
                        708.0,
                        157.0,
                        708.0,
                        195.0,
                        708.0,
                        187.0,
                        694.0,
                        187.0,
                        694.0,
                        225.0,
                        187.5,
                        225.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-4",
                        3
                    ],
                    "destination": [
                        "obj-43",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-43",
                        0
                    ],
                    "destination": [
                        "obj-44",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-43",
                        1
                    ],
                    "destination": [
                        "obj-45",
                        0
                    ],
                    "midpoints": [
                        145.25,
                        307.0,
                        163.0,
                        307.0,
                        163.0,
                        345.0,
                        205.0,
                        345.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-43",
                        2
                    ],
                    "destination": [
                        "obj-46",
                        0
                    ],
                    "midpoints": [
                        163.5,
                        307.0,
                        163.0,
                        307.0,
                        163.0,
                        345.0,
                        163.0,
                        307.0,
                        238.0,
                        307.0,
                        238.0,
                        345.0,
                        265.0,
                        345.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-43",
                        3
                    ],
                    "destination": [
                        "obj-47",
                        0
                    ],
                    "midpoints": [
                        181.75,
                        307.0,
                        238.0,
                        307.0,
                        238.0,
                        345.0,
                        238.0,
                        307.0,
                        232.0,
                        307.0,
                        232.0,
                        345.0,
                        325.0,
                        345.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-43",
                        4
                    ],
                    "destination": [
                        "obj-48",
                        0
                    ],
                    "midpoints": [
                        200.0,
                        262.0,
                        367.0,
                        262.0,
                        367.0,
                        300.0,
                        367.0,
                        307.0,
                        238.0,
                        307.0,
                        238.0,
                        345.0,
                        238.0,
                        307.0,
                        298.0,
                        307.0,
                        298.0,
                        345.0,
                        298.0,
                        307.0,
                        292.0,
                        307.0,
                        292.0,
                        345.0,
                        400.0,
                        345.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-43",
                        5
                    ],
                    "destination": [
                        "obj-49",
                        0
                    ],
                    "midpoints": [
                        218.25,
                        262.0,
                        367.0,
                        262.0,
                        367.0,
                        300.0,
                        367.0,
                        307.0,
                        238.0,
                        307.0,
                        238.0,
                        345.0,
                        238.0,
                        307.0,
                        298.0,
                        307.0,
                        298.0,
                        345.0,
                        298.0,
                        307.0,
                        358.0,
                        307.0,
                        358.0,
                        345.0,
                        358.0,
                        307.0,
                        367.0,
                        307.0,
                        367.0,
                        345.0,
                        460.0,
                        345.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-43",
                        6
                    ],
                    "destination": [
                        "obj-50",
                        0
                    ],
                    "midpoints": [
                        236.5,
                        262.0,
                        367.0,
                        262.0,
                        367.0,
                        300.0,
                        367.0,
                        262.0,
                        517.0,
                        262.0,
                        517.0,
                        300.0,
                        517.0,
                        307.0,
                        238.0,
                        307.0,
                        238.0,
                        345.0,
                        238.0,
                        307.0,
                        298.0,
                        307.0,
                        298.0,
                        345.0,
                        298.0,
                        307.0,
                        358.0,
                        307.0,
                        358.0,
                        345.0,
                        358.0,
                        307.0,
                        367.0,
                        307.0,
                        367.0,
                        345.0,
                        367.0,
                        307.0,
                        427.0,
                        307.0,
                        427.0,
                        345.0,
                        520.0,
                        345.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-43",
                        7
                    ],
                    "destination": [
                        "obj-51",
                        0
                    ],
                    "midpoints": [
                        254.75,
                        262.0,
                        367.0,
                        262.0,
                        367.0,
                        300.0,
                        367.0,
                        262.0,
                        517.0,
                        262.0,
                        517.0,
                        300.0,
                        517.0,
                        307.0,
                        298.0,
                        307.0,
                        298.0,
                        345.0,
                        298.0,
                        307.0,
                        358.0,
                        307.0,
                        358.0,
                        345.0,
                        358.0,
                        307.0,
                        433.0,
                        307.0,
                        433.0,
                        345.0,
                        433.0,
                        307.0,
                        427.0,
                        307.0,
                        427.0,
                        345.0,
                        427.0,
                        307.0,
                        487.0,
                        307.0,
                        487.0,
                        345.0,
                        595.0,
                        345.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-43",
                        8
                    ],
                    "destination": [
                        "obj-52",
                        0
                    ],
                    "midpoints": [
                        273.0,
                        262.0,
                        518.0,
                        262.0,
                        518.0,
                        300.0,
                        518.0,
                        262.0,
                        517.0,
                        262.0,
                        517.0,
                        300.0,
                        517.0,
                        307.0,
                        298.0,
                        307.0,
                        298.0,
                        345.0,
                        298.0,
                        307.0,
                        358.0,
                        307.0,
                        358.0,
                        345.0,
                        358.0,
                        307.0,
                        433.0,
                        307.0,
                        433.0,
                        345.0,
                        433.0,
                        307.0,
                        493.0,
                        307.0,
                        493.0,
                        345.0,
                        493.0,
                        307.0,
                        487.0,
                        307.0,
                        487.0,
                        345.0,
                        487.0,
                        307.0,
                        562.0,
                        307.0,
                        562.0,
                        345.0,
                        655.0,
                        345.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-43",
                        9
                    ],
                    "destination": [
                        "obj-53",
                        0
                    ],
                    "midpoints": [
                        291.25,
                        262.0,
                        518.0,
                        262.0,
                        518.0,
                        300.0,
                        518.0,
                        262.0,
                        517.0,
                        262.0,
                        517.0,
                        300.0,
                        517.0,
                        262.0,
                        667.0,
                        262.0,
                        667.0,
                        300.0,
                        667.0,
                        307.0,
                        298.0,
                        307.0,
                        298.0,
                        345.0,
                        298.0,
                        307.0,
                        358.0,
                        307.0,
                        358.0,
                        345.0,
                        358.0,
                        307.0,
                        433.0,
                        307.0,
                        433.0,
                        345.0,
                        433.0,
                        307.0,
                        493.0,
                        307.0,
                        493.0,
                        345.0,
                        493.0,
                        307.0,
                        487.0,
                        307.0,
                        487.0,
                        345.0,
                        487.0,
                        307.0,
                        562.0,
                        307.0,
                        562.0,
                        345.0,
                        562.0,
                        307.0,
                        622.0,
                        307.0,
                        622.0,
                        345.0,
                        715.0,
                        345.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-43",
                        10
                    ],
                    "destination": [
                        "obj-54",
                        0
                    ],
                    "midpoints": [
                        309.5,
                        262.0,
                        518.0,
                        262.0,
                        518.0,
                        300.0,
                        518.0,
                        262.0,
                        517.0,
                        262.0,
                        517.0,
                        300.0,
                        517.0,
                        262.0,
                        667.0,
                        262.0,
                        667.0,
                        300.0,
                        667.0,
                        307.0,
                        358.0,
                        307.0,
                        358.0,
                        345.0,
                        358.0,
                        307.0,
                        433.0,
                        307.0,
                        433.0,
                        345.0,
                        433.0,
                        307.0,
                        493.0,
                        307.0,
                        493.0,
                        345.0,
                        493.0,
                        307.0,
                        553.0,
                        307.0,
                        553.0,
                        345.0,
                        553.0,
                        307.0,
                        562.0,
                        307.0,
                        562.0,
                        345.0,
                        562.0,
                        307.0,
                        622.0,
                        307.0,
                        622.0,
                        345.0,
                        622.0,
                        307.0,
                        682.0,
                        307.0,
                        682.0,
                        345.0,
                        790.0,
                        345.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-43",
                        11
                    ],
                    "destination": [
                        "obj-55",
                        0
                    ],
                    "midpoints": [
                        327.75,
                        262.0,
                        518.0,
                        262.0,
                        518.0,
                        300.0,
                        518.0,
                        262.0,
                        517.0,
                        262.0,
                        517.0,
                        300.0,
                        517.0,
                        262.0,
                        667.0,
                        262.0,
                        667.0,
                        300.0,
                        667.0,
                        307.0,
                        358.0,
                        307.0,
                        358.0,
                        345.0,
                        358.0,
                        307.0,
                        433.0,
                        307.0,
                        433.0,
                        345.0,
                        433.0,
                        307.0,
                        493.0,
                        307.0,
                        493.0,
                        345.0,
                        493.0,
                        307.0,
                        553.0,
                        307.0,
                        553.0,
                        345.0,
                        553.0,
                        307.0,
                        562.0,
                        307.0,
                        562.0,
                        345.0,
                        562.0,
                        307.0,
                        622.0,
                        307.0,
                        622.0,
                        345.0,
                        622.0,
                        307.0,
                        682.0,
                        307.0,
                        682.0,
                        345.0,
                        682.0,
                        307.0,
                        757.0,
                        307.0,
                        757.0,
                        345.0,
                        850.0,
                        345.0
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
                        "obj-56",
                        0
                    ],
                    "midpoints": [
                        127.0,
                        262.0,
                        361.0,
                        262.0,
                        361.0,
                        300.0,
                        442.5,
                        300.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-4",
                        1
                    ],
                    "destination": [
                        "obj-57",
                        0
                    ],
                    "midpoints": [
                        167.33333333333334,
                        262.0,
                        361.0,
                        262.0,
                        361.0,
                        300.0,
                        361.0,
                        262.0,
                        367.0,
                        262.0,
                        367.0,
                        300.0,
                        592.5,
                        300.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-56",
                        0
                    ],
                    "destination": [
                        "obj-58",
                        0
                    ],
                    "midpoints": [
                        442.5,
                        262.0,
                        668.0,
                        262.0,
                        668.0,
                        300.0,
                        668.0,
                        262.0,
                        667.0,
                        262.0,
                        667.0,
                        300.0,
                        667.0,
                        307.0,
                        493.0,
                        307.0,
                        493.0,
                        345.0,
                        493.0,
                        307.0,
                        553.0,
                        307.0,
                        553.0,
                        345.0,
                        553.0,
                        307.0,
                        628.0,
                        307.0,
                        628.0,
                        345.0,
                        628.0,
                        307.0,
                        688.0,
                        307.0,
                        688.0,
                        345.0,
                        688.0,
                        307.0,
                        682.0,
                        307.0,
                        682.0,
                        345.0,
                        682.0,
                        307.0,
                        757.0,
                        307.0,
                        757.0,
                        345.0,
                        757.0,
                        307.0,
                        817.0,
                        307.0,
                        817.0,
                        345.0,
                        892.0,
                        345.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-57",
                        0
                    ],
                    "destination": [
                        "obj-59",
                        0
                    ],
                    "midpoints": [
                        592.5,
                        262.0,
                        860.0,
                        262.0,
                        860.0,
                        300.0,
                        860.0,
                        307.0,
                        628.0,
                        307.0,
                        628.0,
                        345.0,
                        628.0,
                        307.0,
                        688.0,
                        307.0,
                        688.0,
                        345.0,
                        688.0,
                        307.0,
                        748.0,
                        307.0,
                        748.0,
                        345.0,
                        748.0,
                        307.0,
                        823.0,
                        307.0,
                        823.0,
                        345.0,
                        823.0,
                        307.0,
                        817.0,
                        307.0,
                        817.0,
                        345.0,
                        817.0,
                        307.0,
                        877.0,
                        307.0,
                        877.0,
                        345.0,
                        1057.0,
                        345.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-58",
                        0
                    ],
                    "destination": [
                        "obj-60",
                        0
                    ],
                    "midpoints": [
                        956.25,
                        348.5,
                        1027.0,
                        348.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-59",
                        0
                    ],
                    "destination": [
                        "obj-60",
                        1
                    ],
                    "midpoints": [
                        1142.0,
                        348.5,
                        1064.0,
                        348.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-60",
                        0
                    ],
                    "destination": [
                        "obj-61",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-4",
                        2
                    ],
                    "destination": [
                        "obj-62",
                        0
                    ],
                    "midpoints": [
                        207.66666666666669,
                        262.0,
                        361.0,
                        262.0,
                        361.0,
                        300.0,
                        361.0,
                        262.0,
                        518.0,
                        262.0,
                        518.0,
                        300.0,
                        518.0,
                        262.0,
                        517.0,
                        262.0,
                        517.0,
                        300.0,
                        682.0,
                        300.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-61",
                        0
                    ],
                    "destination": [
                        "obj-63",
                        0
                    ],
                    "midpoints": [
                        1117.0,
                        438.5,
                        892.0,
                        438.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-62",
                        0
                    ],
                    "destination": [
                        "obj-63",
                        1
                    ],
                    "midpoints": [
                        682.0,
                        307.0,
                        688.0,
                        307.0,
                        688.0,
                        345.0,
                        688.0,
                        307.0,
                        748.0,
                        307.0,
                        748.0,
                        345.0,
                        748.0,
                        307.0,
                        823.0,
                        307.0,
                        823.0,
                        345.0,
                        823.0,
                        307.0,
                        817.0,
                        307.0,
                        817.0,
                        345.0,
                        817.0,
                        307.0,
                        877.0,
                        307.0,
                        877.0,
                        345.0,
                        920.0,
                        345.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-63",
                        0
                    ],
                    "destination": [
                        "obj-64",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-64",
                        0
                    ],
                    "destination": [
                        "obj-65",
                        0
                    ],
                    "midpoints": [
                        929.0,
                        517.0,
                        593.0,
                        517.0,
                        593.0,
                        633.0,
                        551.0,
                        633.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-65",
                        0
                    ],
                    "destination": [
                        "obj-66",
                        0
                    ],
                    "midpoints": [
                        592.0,
                        670.0,
                        592.0,
                        517.0,
                        577.5,
                        517.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-65",
                        0
                    ],
                    "destination": [
                        "obj-67",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-65",
                        0
                    ],
                    "destination": [
                        "obj-67",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-68",
                        0
                    ],
                    "destination": [
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        112.0,
                        22.0,
                        622.0,
                        22.0,
                        622.0,
                        138.0,
                        622.0,
                        22.0,
                        412.0,
                        22.0,
                        412.0,
                        138.0,
                        412.0,
                        22.0,
                        418.0,
                        22.0,
                        418.0,
                        138.0,
                        418.0,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        479.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        625.0,
                        195.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-68",
                        1
                    ],
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        124.0,
                        22.0,
                        622.0,
                        22.0,
                        622.0,
                        138.0,
                        622.0,
                        22.0,
                        412.0,
                        22.0,
                        412.0,
                        138.0,
                        412.0,
                        22.0,
                        418.0,
                        22.0,
                        418.0,
                        138.0,
                        418.0,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        479.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        625.0,
                        195.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-68",
                        2
                    ],
                    "destination": [
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        136.0,
                        22.0,
                        622.0,
                        22.0,
                        622.0,
                        138.0,
                        622.0,
                        22.0,
                        412.0,
                        22.0,
                        412.0,
                        138.0,
                        412.0,
                        22.0,
                        418.0,
                        22.0,
                        418.0,
                        138.0,
                        418.0,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        479.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        625.0,
                        195.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-68",
                        3
                    ],
                    "destination": [
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        148.0,
                        22.0,
                        622.0,
                        22.0,
                        622.0,
                        138.0,
                        622.0,
                        22.0,
                        412.0,
                        22.0,
                        412.0,
                        138.0,
                        412.0,
                        22.0,
                        418.0,
                        22.0,
                        418.0,
                        138.0,
                        418.0,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        479.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        625.0,
                        195.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-68",
                        4
                    ],
                    "destination": [
                        "obj-13",
                        0
                    ],
                    "midpoints": [
                        160.0,
                        22.0,
                        622.0,
                        22.0,
                        622.0,
                        138.0,
                        622.0,
                        22.0,
                        412.0,
                        22.0,
                        412.0,
                        138.0,
                        412.0,
                        22.0,
                        418.0,
                        22.0,
                        418.0,
                        138.0,
                        418.0,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        479.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        592.0,
                        157.0,
                        592.0,
                        157.0,
                        592.0,
                        195.0,
                        650.0,
                        195.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-68",
                        5
                    ],
                    "destination": [
                        "obj-65",
                        0
                    ],
                    "midpoints": [
                        172.0,
                        22.0,
                        412.0,
                        22.0,
                        412.0,
                        138.0,
                        412.0,
                        22.0,
                        418.0,
                        22.0,
                        418.0,
                        138.0,
                        418.0,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        479.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        232.0,
                        263.0,
                        232.0,
                        263.0,
                        270.0,
                        263.0,
                        262.0,
                        361.0,
                        262.0,
                        361.0,
                        300.0,
                        361.0,
                        262.0,
                        367.0,
                        262.0,
                        367.0,
                        300.0,
                        367.0,
                        262.0,
                        517.0,
                        262.0,
                        517.0,
                        300.0,
                        517.0,
                        307.0,
                        238.0,
                        307.0,
                        238.0,
                        345.0,
                        238.0,
                        307.0,
                        298.0,
                        307.0,
                        298.0,
                        345.0,
                        298.0,
                        307.0,
                        358.0,
                        307.0,
                        358.0,
                        345.0,
                        358.0,
                        307.0,
                        367.0,
                        307.0,
                        367.0,
                        345.0,
                        367.0,
                        307.0,
                        427.0,
                        307.0,
                        427.0,
                        345.0,
                        427.0,
                        307.0,
                        487.0,
                        307.0,
                        487.0,
                        345.0,
                        551.0,
                        345.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-68",
                        6
                    ],
                    "destination": [
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        184.0,
                        82.0,
                        127.0,
                        82.0,
                        127.0,
                        151.0,
                        127.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        187.5,
                        180.0
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