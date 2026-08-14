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
                    "numoutlets": 5,
                    "outlettype": [
                        "",
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
                        480.0,
                        150.0,
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
                        542.0,
                        150.0,
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
                        604.0,
                        150.0,
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
                        666.0,
                        150.0,
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
                        728.0,
                        150.0,
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
                    "numinlets": 8,
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
                                        75.0,
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
                                        120.0,
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
                                        165.0,
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
                                        210.0,
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
                                        405.0,
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
                                        345.0,
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
                                        660.0,
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
                                        180.0,
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
                                        495.0,
                                        75.0,
                                        149.0,
                                        22.0
                                    ],
                                    "text": "prepend voicingmode",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        255.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "data to prepend stereospread"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-13",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        810.0,
                                        75.0,
                                        156.0,
                                        22.0
                                    ],
                                    "text": "prepend stereospread",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-14",
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
                                    "comment": "data to prepend detunerandom"
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
                                        960.0,
                                        120.0,
                                        156.0,
                                        22.0
                                    ],
                                    "text": "prepend detunerandom",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-16",
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
                                    "comment": "data to prepend timingrandom"
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
                                        1110.0,
                                        75.0,
                                        156.0,
                                        22.0
                                    ],
                                    "text": "prepend timingrandom",
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
                                        337.0,
                                        67.0,
                                        337.0,
                                        105.0,
                                        337.0,
                                        67.0,
                                        330.0,
                                        67.0,
                                        330.0,
                                        105.0,
                                        412.0,
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
                                        90.0,
                                        22.0,
                                        158.0,
                                        22.0,
                                        158.0,
                                        68.0,
                                        158.0,
                                        22.0,
                                        203.0,
                                        22.0,
                                        203.0,
                                        68.0,
                                        203.0,
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
                                        337.0,
                                        22.0,
                                        337.0,
                                        68.0,
                                        337.0,
                                        67.0,
                                        180.0,
                                        67.0,
                                        180.0,
                                        105.0,
                                        180.0,
                                        67.0,
                                        330.0,
                                        67.0,
                                        330.0,
                                        105.0,
                                        416.0,
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
                                        135.0,
                                        22.0,
                                        203.0,
                                        22.0,
                                        203.0,
                                        68.0,
                                        203.0,
                                        22.0,
                                        248.0,
                                        22.0,
                                        248.0,
                                        68.0,
                                        248.0,
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
                                        180.0,
                                        67.0,
                                        180.0,
                                        105.0,
                                        180.0,
                                        67.0,
                                        495.0,
                                        67.0,
                                        495.0,
                                        105.0,
                                        495.0,
                                        67.0,
                                        330.0,
                                        67.0,
                                        330.0,
                                        105.0,
                                        330.0,
                                        67.0,
                                        487.0,
                                        67.0,
                                        487.0,
                                        105.0,
                                        713.5,
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
                                        713.5,
                                        67.0,
                                        495.0,
                                        67.0,
                                        495.0,
                                        105.0,
                                        495.0,
                                        67.0,
                                        487.0,
                                        67.0,
                                        487.0,
                                        105.0,
                                        412.0,
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
                                        180.0,
                                        22.0,
                                        202.0,
                                        22.0,
                                        202.0,
                                        68.0,
                                        202.0,
                                        22.0,
                                        247.0,
                                        22.0,
                                        247.0,
                                        68.0,
                                        247.0,
                                        67.0,
                                        180.0,
                                        67.0,
                                        180.0,
                                        105.0,
                                        251.0,
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
                                        251.0,
                                        67.0,
                                        337.0,
                                        67.0,
                                        337.0,
                                        105.0,
                                        412.0,
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
                                        225.0,
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
                                        337.0,
                                        67.0,
                                        337.0,
                                        105.0,
                                        337.0,
                                        67.0,
                                        330.0,
                                        67.0,
                                        330.0,
                                        105.0,
                                        569.5,
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
                                        569.5,
                                        67.0,
                                        495.0,
                                        67.0,
                                        495.0,
                                        105.0,
                                        412.0,
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        270.0,
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
                                        495.0,
                                        67.0,
                                        495.0,
                                        105.0,
                                        495.0,
                                        67.0,
                                        652.0,
                                        67.0,
                                        652.0,
                                        105.0,
                                        652.0,
                                        67.0,
                                        330.0,
                                        67.0,
                                        330.0,
                                        105.0,
                                        330.0,
                                        67.0,
                                        652.0,
                                        67.0,
                                        652.0,
                                        105.0,
                                        888.0,
                                        105.0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        888.0,
                                        67.0,
                                        495.0,
                                        67.0,
                                        495.0,
                                        105.0,
                                        495.0,
                                        67.0,
                                        652.0,
                                        67.0,
                                        652.0,
                                        105.0,
                                        652.0,
                                        67.0,
                                        652.0,
                                        67.0,
                                        652.0,
                                        105.0,
                                        412.0,
                                        105.0
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
                                        "obj-15",
                                        0
                                    ],
                                    "midpoints": [
                                        315.0,
                                        22.0,
                                        383.0,
                                        22.0,
                                        383.0,
                                        68.0,
                                        383.0,
                                        67.0,
                                        495.0,
                                        67.0,
                                        495.0,
                                        105.0,
                                        495.0,
                                        67.0,
                                        652.0,
                                        67.0,
                                        652.0,
                                        105.0,
                                        652.0,
                                        67.0,
                                        330.0,
                                        67.0,
                                        330.0,
                                        105.0,
                                        330.0,
                                        67.0,
                                        652.0,
                                        67.0,
                                        652.0,
                                        105.0,
                                        652.0,
                                        67.0,
                                        802.0,
                                        67.0,
                                        802.0,
                                        105.0,
                                        802.0,
                                        112.0,
                                        443.0,
                                        112.0,
                                        443.0,
                                        158.0,
                                        1038.0,
                                        158.0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        1038.0,
                                        131.0,
                                        412.0,
                                        131.0
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
                                        "obj-17",
                                        0
                                    ],
                                    "midpoints": [
                                        360.0,
                                        67.0,
                                        495.0,
                                        67.0,
                                        495.0,
                                        105.0,
                                        495.0,
                                        67.0,
                                        775.0,
                                        67.0,
                                        775.0,
                                        105.0,
                                        775.0,
                                        67.0,
                                        652.0,
                                        67.0,
                                        652.0,
                                        105.0,
                                        652.0,
                                        67.0,
                                        802.0,
                                        67.0,
                                        802.0,
                                        105.0,
                                        1188.0,
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        1188.0,
                                        67.0,
                                        495.0,
                                        67.0,
                                        495.0,
                                        105.0,
                                        495.0,
                                        67.0,
                                        775.0,
                                        67.0,
                                        775.0,
                                        105.0,
                                        775.0,
                                        67.0,
                                        652.0,
                                        67.0,
                                        652.0,
                                        105.0,
                                        652.0,
                                        67.0,
                                        802.0,
                                        67.0,
                                        802.0,
                                        105.0,
                                        802.0,
                                        112.0,
                                        952.0,
                                        112.0,
                                        952.0,
                                        150.0,
                                        412.0,
                                        150.0
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
                                        75.0,
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
                                        165.0,
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
                                        255.0,
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
                                        300.0,
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
                                        345.0,
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
                                        390.0,
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
                                        435.0,
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
                                        480.0,
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
                                        525.0,
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
                                        990.0,
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
                                        1545.0,
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
                                        165.0,
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
                                        1125.0,
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
                                        300.0,
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
                                        585.0,
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
                                        1275.0,
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
                                        720.0,
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
                                        855.0,
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
                                        294.0,
                                        67.0,
                                        294.0,
                                        105.0,
                                        294.0,
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
                                        427.0,
                                        67.0,
                                        427.0,
                                        105.0,
                                        427.0,
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
                                        "obj-2",
                                        0
                                    ],
                                    "destination": [
                                        "obj-15",
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
                                        203.0,
                                        22.0,
                                        203.0,
                                        68.0,
                                        203.0,
                                        22.0,
                                        248.0,
                                        22.0,
                                        248.0,
                                        68.0,
                                        248.0,
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
                                        22.0,
                                        428.0,
                                        22.0,
                                        428.0,
                                        68.0,
                                        428.0,
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
                                        563.0,
                                        22.0,
                                        563.0,
                                        68.0,
                                        563.0,
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
                                        294.0,
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
                                        571.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        1050.5,
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
                                        1050.5,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        991.0,
                                        67.0,
                                        991.0,
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
                                        203.0,
                                        22.0,
                                        203.0,
                                        68.0,
                                        203.0,
                                        22.0,
                                        248.0,
                                        22.0,
                                        248.0,
                                        68.0,
                                        248.0,
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
                                        22.0,
                                        428.0,
                                        22.0,
                                        428.0,
                                        68.0,
                                        428.0,
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
                                        563.0,
                                        22.0,
                                        563.0,
                                        68.0,
                                        563.0,
                                        67.0,
                                        159.0,
                                        67.0,
                                        159.0,
                                        105.0,
                                        159.0,
                                        67.0,
                                        982.0,
                                        67.0,
                                        982.0,
                                        105.0,
                                        982.0,
                                        67.0,
                                        294.0,
                                        67.0,
                                        294.0,
                                        105.0,
                                        294.0,
                                        67.0,
                                        1117.0,
                                        67.0,
                                        1117.0,
                                        105.0,
                                        1117.0,
                                        67.0,
                                        1402.0,
                                        67.0,
                                        1402.0,
                                        105.0,
                                        1402.0,
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
                                        1267.0,
                                        67.0,
                                        1267.0,
                                        105.0,
                                        1267.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        571.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        1605.5,
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
                                        1605.5,
                                        67.0,
                                        1119.0,
                                        67.0,
                                        1119.0,
                                        105.0,
                                        1119.0,
                                        67.0,
                                        1254.0,
                                        67.0,
                                        1254.0,
                                        105.0,
                                        1254.0,
                                        67.0,
                                        1402.0,
                                        67.0,
                                        1402.0,
                                        105.0,
                                        1402.0,
                                        67.0,
                                        1267.0,
                                        67.0,
                                        1267.0,
                                        105.0,
                                        1267.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        991.0,
                                        67.0,
                                        991.0,
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
                                        180.0,
                                        22.0,
                                        202.0,
                                        22.0,
                                        202.0,
                                        68.0,
                                        225.5,
                                        68.0
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
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        571.0,
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
                                        22.0,
                                        428.0,
                                        22.0,
                                        428.0,
                                        68.0,
                                        428.0,
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
                                        563.0,
                                        22.0,
                                        563.0,
                                        68.0,
                                        563.0,
                                        67.0,
                                        982.0,
                                        67.0,
                                        982.0,
                                        105.0,
                                        982.0,
                                        67.0,
                                        294.0,
                                        67.0,
                                        294.0,
                                        105.0,
                                        294.0,
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
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        571.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        1185.5,
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
                                        1185.5,
                                        67.0,
                                        982.0,
                                        67.0,
                                        982.0,
                                        105.0,
                                        982.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        991.0,
                                        67.0,
                                        991.0,
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
                                        270.0,
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
                                        22.0,
                                        428.0,
                                        22.0,
                                        428.0,
                                        68.0,
                                        428.0,
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
                                        563.0,
                                        22.0,
                                        563.0,
                                        68.0,
                                        563.0,
                                        67.0,
                                        982.0,
                                        67.0,
                                        982.0,
                                        105.0,
                                        982.0,
                                        67.0,
                                        294.0,
                                        67.0,
                                        294.0,
                                        105.0,
                                        294.0,
                                        67.0,
                                        1117.0,
                                        67.0,
                                        1117.0,
                                        105.0,
                                        1117.0,
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
                                        1267.0,
                                        67.0,
                                        1267.0,
                                        105.0,
                                        1267.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        571.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
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
                                        1119.0,
                                        67.0,
                                        1119.0,
                                        105.0,
                                        1119.0,
                                        67.0,
                                        1117.0,
                                        67.0,
                                        1117.0,
                                        105.0,
                                        1117.0,
                                        67.0,
                                        1267.0,
                                        67.0,
                                        1267.0,
                                        105.0,
                                        1267.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
                                        105.0,
                                        849.0,
                                        67.0,
                                        991.0,
                                        67.0,
                                        991.0,
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
                                        315.0,
                                        22.0,
                                        337.0,
                                        22.0,
                                        337.0,
                                        68.0,
                                        360.5,
                                        68.0
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
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        571.0,
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
                                        "obj-8",
                                        0
                                    ],
                                    "destination": [
                                        "obj-21",
                                        0
                                    ],
                                    "midpoints": [
                                        360.0,
                                        22.0,
                                        428.0,
                                        22.0,
                                        428.0,
                                        68.0,
                                        428.0,
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
                                        517.0,
                                        22.0,
                                        517.0,
                                        68.0,
                                        517.0,
                                        67.0,
                                        429.0,
                                        67.0,
                                        429.0,
                                        105.0,
                                        429.0,
                                        67.0,
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        645.5,
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
                                        "obj-9",
                                        0
                                    ],
                                    "destination": [
                                        "obj-22",
                                        0
                                    ],
                                    "midpoints": [
                                        405.0,
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
                                        563.0,
                                        22.0,
                                        563.0,
                                        68.0,
                                        563.0,
                                        67.0,
                                        982.0,
                                        67.0,
                                        982.0,
                                        105.0,
                                        982.0,
                                        67.0,
                                        1117.0,
                                        67.0,
                                        1117.0,
                                        105.0,
                                        1117.0,
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
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        571.0,
                                        67.0,
                                        847.0,
                                        67.0,
                                        847.0,
                                        105.0,
                                        1335.5,
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
                                        1335.5,
                                        67.0,
                                        1119.0,
                                        67.0,
                                        1119.0,
                                        105.0,
                                        1119.0,
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
                                        991.0,
                                        67.0,
                                        991.0,
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
                                        450.0,
                                        22.0,
                                        518.0,
                                        22.0,
                                        518.0,
                                        68.0,
                                        518.0,
                                        22.0,
                                        563.0,
                                        22.0,
                                        563.0,
                                        68.0,
                                        563.0,
                                        67.0,
                                        577.0,
                                        67.0,
                                        577.0,
                                        105.0,
                                        577.0,
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
                                        "obj-23",
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
                                        "obj-11",
                                        0
                                    ],
                                    "destination": [
                                        "obj-24",
                                        0
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
                                        540.0,
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
                                        571.0,
                                        67.0,
                                        571.0,
                                        105.0,
                                        919.0,
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
                                        919.0,
                                        67.0,
                                        849.0,
                                        67.0,
                                        849.0,
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
                        1065.0,
                        30.0,
                        76.0,
                        22.0
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
                        1155.0,
                        30.0,
                        76.0,
                        22.0
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
                        1245.0,
                        30.0,
                        76.0,
                        22.0
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
                        1335.0,
                        30.0,
                        76.0,
                        22.0
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
                        1425.0,
                        30.0,
                        76.0,
                        22.0
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
                        1515.0,
                        30.0,
                        76.0,
                        22.0
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
                        1065.0,
                        75.0,
                        76.0,
                        22.0
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
                        1155.0,
                        75.0,
                        76.0,
                        22.0
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
                        1245.0,
                        75.0,
                        76.0,
                        22.0
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
                        1335.0,
                        75.0,
                        76.0,
                        22.0
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
                        1425.0,
                        75.0,
                        76.0,
                        22.0
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
                        1515.0,
                        75.0,
                        76.0,
                        22.0
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
                    "numoutlets": 10,
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
                                        60.0,
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
                                        135.0,
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
                                        210.0,
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
                                        300.0,
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
                                        375.0,
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
                                        450.0,
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
                                        540.0,
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
                                    "numoutlets": 10,
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
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        205.0,
                                        22.0
                                    ],
                                    "text": "trigger b b b b b b b b b b",
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
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-18",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        585.0,
                                        120.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "0.5",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-19",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        615.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "data from 0.5"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-20",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        660.0,
                                        120.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "5.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-21",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        690.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "data from 5."
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-22",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        735.0,
                                        120.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "10.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-23",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        765.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "data from 10."
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
                                    ],
                                    "midpoints": [
                                        111.0,
                                        63.5,
                                        132.5,
                                        63.5
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
                                        132.5,
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
                                    ],
                                    "midpoints": [
                                        62.5,
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
                                        427.0,
                                        112.0,
                                        502.0,
                                        112.0,
                                        502.0,
                                        150.0,
                                        502.0,
                                        157.0,
                                        98.0,
                                        157.0,
                                        98.0,
                                        203.0,
                                        98.0,
                                        157.0,
                                        173.0,
                                        157.0,
                                        173.0,
                                        203.0,
                                        173.0,
                                        157.0,
                                        248.0,
                                        157.0,
                                        248.0,
                                        203.0,
                                        248.0,
                                        157.0,
                                        292.0,
                                        157.0,
                                        292.0,
                                        203.0,
                                        292.0,
                                        157.0,
                                        367.0,
                                        157.0,
                                        367.0,
                                        203.0,
                                        367.0,
                                        157.0,
                                        442.0,
                                        157.0,
                                        442.0,
                                        203.0,
                                        547.0,
                                        203.0
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
                                        58.22222222222222,
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
                                    ],
                                    "midpoints": [
                                        137.5,
                                        112.0,
                                        103.0,
                                        112.0,
                                        103.0,
                                        150.0,
                                        103.0,
                                        157.0,
                                        127.0,
                                        157.0,
                                        127.0,
                                        203.0,
                                        67.0,
                                        203.0
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
                                        79.44444444444444,
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
                                    ],
                                    "midpoints": [
                                        227.5,
                                        112.0,
                                        178.0,
                                        112.0,
                                        178.0,
                                        150.0,
                                        178.0,
                                        157.0,
                                        202.0,
                                        157.0,
                                        202.0,
                                        203.0,
                                        142.0,
                                        203.0
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
                                        100.66666666666666,
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
                                    ],
                                    "midpoints": [
                                        302.5,
                                        112.0,
                                        268.0,
                                        112.0,
                                        268.0,
                                        150.0,
                                        268.0,
                                        157.0,
                                        292.0,
                                        157.0,
                                        292.0,
                                        203.0,
                                        217.0,
                                        203.0
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
                                        121.88888888888889,
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
                                    ],
                                    "midpoints": [
                                        377.5,
                                        112.0,
                                        343.0,
                                        112.0,
                                        343.0,
                                        150.0,
                                        343.0,
                                        157.0,
                                        367.0,
                                        157.0,
                                        367.0,
                                        203.0,
                                        307.0,
                                        203.0
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
                                        143.11111111111111,
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
                                    ],
                                    "midpoints": [
                                        467.5,
                                        112.0,
                                        418.0,
                                        112.0,
                                        418.0,
                                        150.0,
                                        418.0,
                                        157.0,
                                        442.0,
                                        157.0,
                                        442.0,
                                        203.0,
                                        382.0,
                                        203.0
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
                                        164.33333333333331,
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
                                    ],
                                    "midpoints": [
                                        542.5,
                                        112.0,
                                        508.0,
                                        112.0,
                                        508.0,
                                        150.0,
                                        508.0,
                                        157.0,
                                        532.0,
                                        157.0,
                                        532.0,
                                        203.0,
                                        457.0,
                                        203.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-10",
                                        7
                                    ],
                                    "destination": [
                                        "obj-18",
                                        0
                                    ],
                                    "midpoints": [
                                        185.55555555555554,
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
                                        418.0,
                                        112.0,
                                        418.0,
                                        150.0,
                                        418.0,
                                        112.0,
                                        427.0,
                                        112.0,
                                        427.0,
                                        150.0,
                                        427.0,
                                        112.0,
                                        502.0,
                                        112.0,
                                        502.0,
                                        150.0,
                                        592.0,
                                        150.0
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
                                        "obj-19",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-10",
                                        8
                                    ],
                                    "destination": [
                                        "obj-20",
                                        0
                                    ],
                                    "midpoints": [
                                        206.77777777777777,
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
                                        418.0,
                                        112.0,
                                        418.0,
                                        150.0,
                                        418.0,
                                        112.0,
                                        427.0,
                                        112.0,
                                        427.0,
                                        150.0,
                                        427.0,
                                        112.0,
                                        502.0,
                                        112.0,
                                        502.0,
                                        150.0,
                                        502.0,
                                        112.0,
                                        577.0,
                                        112.0,
                                        577.0,
                                        150.0,
                                        667.0,
                                        150.0
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
                                        "obj-21",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-10",
                                        9
                                    ],
                                    "destination": [
                                        "obj-22",
                                        0
                                    ],
                                    "midpoints": [
                                        228.0,
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
                                        418.0,
                                        112.0,
                                        418.0,
                                        150.0,
                                        418.0,
                                        112.0,
                                        508.0,
                                        112.0,
                                        508.0,
                                        150.0,
                                        508.0,
                                        112.0,
                                        502.0,
                                        112.0,
                                        502.0,
                                        150.0,
                                        502.0,
                                        112.0,
                                        577.0,
                                        112.0,
                                        577.0,
                                        150.0,
                                        577.0,
                                        112.0,
                                        652.0,
                                        112.0,
                                        652.0,
                                        150.0,
                                        742.0,
                                        150.0
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
                                        "obj-23",
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
                        58.0,
                        20.0
                    ],
                    "text": "v0.4.0",
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
                    "id": "obj-71",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        120.0,
                        360.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend applyvalues",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-72",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        120.0,
                        405.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend applyvalues",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-73",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1094.0,
                        5.0,
                        18.0,
                        18.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        66.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-74",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1184.0,
                        5.0,
                        18.0,
                        18.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        92.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-75",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1274.0,
                        5.0,
                        18.0,
                        18.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        118.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-76",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1364.0,
                        5.0,
                        18.0,
                        18.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        144.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-77",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1454.0,
                        5.0,
                        18.0,
                        18.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        170.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-78",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1544.0,
                        5.0,
                        18.0,
                        18.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        196.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-79",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1094.0,
                        103.0,
                        18.0,
                        18.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        222.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-80",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1184.0,
                        103.0,
                        18.0,
                        18.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        248.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-81",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1274.0,
                        103.0,
                        18.0,
                        18.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        274.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-82",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1364.0,
                        103.0,
                        18.0,
                        18.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        300.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-83",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1454.0,
                        103.0,
                        18.0,
                        18.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        326.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-84",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1544.0,
                        103.0,
                        18.0,
                        18.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        203.0,
                        352.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-85",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        955,
                        103,
                        107.0,
                        20.0
                    ],
                    "text": "degree enable",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-86",
                    "numinlets": 12,
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
                        1065,
                        131,
                        86.0,
                        22.0
                    ],
                    "text": "p degrees",
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
                                        50.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 0 toggle"
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
                                        130.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 1 toggle"
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
                                        210.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 2 toggle"
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
                                        290.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 3 toggle"
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
                                        370.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 4 toggle"
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
                                        450.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 5 toggle"
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
                                        530.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 6 toggle"
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
                                        610.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 7 toggle"
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
                                        690.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 8 toggle"
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
                                        770.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 9 toggle"
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
                                        850.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 10 toggle"
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
                                        930.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree 11 toggle"
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
                                        50.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "degree messages to ji-engine"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-14",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        130.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "set toggle 0"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-15",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        210.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "set toggle 1"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-16",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        290.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "set toggle 2"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-17",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        370.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "set toggle 3"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-18",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        450.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "set toggle 4"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-19",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        530.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "set toggle 5"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-20",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        610.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "set toggle 6"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-21",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        690.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "set toggle 7"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-22",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        770.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "set toggle 8"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-23",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        850.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "set toggle 9"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-24",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        930.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "set toggle 10"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-25",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1010.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "set toggle 11"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-26",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        150,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 0 $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-27",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        130.0,
                                        150,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 1 $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-28",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        150,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 2 $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-29",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        290.0,
                                        150,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 3 $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-30",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        370.0,
                                        150,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 4 $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-31",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        150,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 5 $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-32",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        530.0,
                                        150,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 6 $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-33",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        610.0,
                                        150,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 7 $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-34",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        690.0,
                                        150,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 8 $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-35",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        770.0,
                                        150,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "degree 9 $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-36",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        850.0,
                                        150,
                                        100.0,
                                        22.0
                                    ],
                                    "text": "degree 10 $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-37",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        930.0,
                                        150,
                                        100.0,
                                        22.0
                                    ],
                                    "text": "degree 11 $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-38",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30,
                                        210,
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
                                    "id": "obj-39",
                                    "numinlets": 1,
                                    "numoutlets": 12,
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
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        300.0,
                                        233.0,
                                        22.0
                                    ],
                                    "text": "trigger b b b b b b b b b b b b",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-40",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30,
                                        290,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-41",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        110,
                                        290,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-42",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        190,
                                        290,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-43",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        270,
                                        290,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-44",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        350,
                                        290,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-45",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        430,
                                        290,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-46",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        510,
                                        290,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-47",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        590,
                                        290,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-48",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        670,
                                        290,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-49",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        750,
                                        290,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-50",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        830,
                                        290,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-51",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        910,
                                        290,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "set 1",
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
                                        "obj-26",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-26",
                                        0
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        96.5,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        57.0,
                                        240.0
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
                                        "obj-27",
                                        0
                                    ],
                                    "midpoints": [
                                        145.0,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        137.0,
                                        180.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        176.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        122.0,
                                        242.0,
                                        122.0,
                                        288.0,
                                        57.0,
                                        288.0
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
                                        "obj-28",
                                        0
                                    ],
                                    "midpoints": [
                                        225.0,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        217.0,
                                        180.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-28",
                                        0
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        256.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        122.0,
                                        142.0,
                                        122.0,
                                        180.0,
                                        122.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        202.0,
                                        242.0,
                                        202.0,
                                        288.0,
                                        57.0,
                                        288.0
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
                                        "obj-29",
                                        0
                                    ],
                                    "midpoints": [
                                        305.0,
                                        142.0,
                                        311.0,
                                        142.0,
                                        311.0,
                                        180.0,
                                        297.0,
                                        180.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        336.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        231.0,
                                        142.0,
                                        202.0,
                                        142.0,
                                        202.0,
                                        180.0,
                                        202.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        202.0,
                                        242.0,
                                        202.0,
                                        288.0,
                                        202.0,
                                        242.0,
                                        282.0,
                                        242.0,
                                        282.0,
                                        288.0,
                                        57.0,
                                        288.0
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
                                        "obj-30",
                                        0
                                    ],
                                    "midpoints": [
                                        385.0,
                                        142.0,
                                        391.0,
                                        142.0,
                                        391.0,
                                        180.0,
                                        377.0,
                                        180.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-30",
                                        0
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        416.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        231.0,
                                        142.0,
                                        202.0,
                                        142.0,
                                        202.0,
                                        180.0,
                                        202.0,
                                        142.0,
                                        282.0,
                                        142.0,
                                        282.0,
                                        180.0,
                                        282.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        248.0,
                                        242.0,
                                        248.0,
                                        288.0,
                                        248.0,
                                        242.0,
                                        282.0,
                                        242.0,
                                        282.0,
                                        288.0,
                                        282.0,
                                        242.0,
                                        362.0,
                                        242.0,
                                        362.0,
                                        288.0,
                                        57.0,
                                        288.0
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
                                        "obj-31",
                                        0
                                    ],
                                    "midpoints": [
                                        465.0,
                                        142.0,
                                        471.0,
                                        142.0,
                                        471.0,
                                        180.0,
                                        457.0,
                                        180.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        496.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        231.0,
                                        142.0,
                                        311.0,
                                        142.0,
                                        311.0,
                                        180.0,
                                        311.0,
                                        142.0,
                                        282.0,
                                        142.0,
                                        282.0,
                                        180.0,
                                        282.0,
                                        142.0,
                                        362.0,
                                        142.0,
                                        362.0,
                                        180.0,
                                        362.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        248.0,
                                        242.0,
                                        248.0,
                                        288.0,
                                        248.0,
                                        242.0,
                                        282.0,
                                        242.0,
                                        282.0,
                                        288.0,
                                        282.0,
                                        242.0,
                                        362.0,
                                        242.0,
                                        362.0,
                                        288.0,
                                        362.0,
                                        242.0,
                                        442.0,
                                        242.0,
                                        442.0,
                                        288.0,
                                        57.0,
                                        288.0
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
                                        "obj-32",
                                        0
                                    ],
                                    "midpoints": [
                                        545.0,
                                        142.0,
                                        551.0,
                                        142.0,
                                        551.0,
                                        180.0,
                                        537.0,
                                        180.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-32",
                                        0
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        576.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        231.0,
                                        142.0,
                                        311.0,
                                        142.0,
                                        311.0,
                                        180.0,
                                        311.0,
                                        142.0,
                                        282.0,
                                        142.0,
                                        282.0,
                                        180.0,
                                        282.0,
                                        142.0,
                                        362.0,
                                        142.0,
                                        362.0,
                                        180.0,
                                        362.0,
                                        142.0,
                                        442.0,
                                        142.0,
                                        442.0,
                                        180.0,
                                        442.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        248.0,
                                        242.0,
                                        248.0,
                                        288.0,
                                        248.0,
                                        242.0,
                                        328.0,
                                        242.0,
                                        328.0,
                                        288.0,
                                        328.0,
                                        242.0,
                                        362.0,
                                        242.0,
                                        362.0,
                                        288.0,
                                        362.0,
                                        242.0,
                                        442.0,
                                        242.0,
                                        442.0,
                                        288.0,
                                        442.0,
                                        242.0,
                                        522.0,
                                        242.0,
                                        522.0,
                                        288.0,
                                        57.0,
                                        288.0
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
                                        "obj-33",
                                        0
                                    ],
                                    "midpoints": [
                                        625.0,
                                        142.0,
                                        631.0,
                                        142.0,
                                        631.0,
                                        180.0,
                                        617.0,
                                        180.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        656.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        231.0,
                                        142.0,
                                        311.0,
                                        142.0,
                                        311.0,
                                        180.0,
                                        311.0,
                                        142.0,
                                        391.0,
                                        142.0,
                                        391.0,
                                        180.0,
                                        391.0,
                                        142.0,
                                        362.0,
                                        142.0,
                                        362.0,
                                        180.0,
                                        362.0,
                                        142.0,
                                        442.0,
                                        142.0,
                                        442.0,
                                        180.0,
                                        442.0,
                                        142.0,
                                        522.0,
                                        142.0,
                                        522.0,
                                        180.0,
                                        522.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        248.0,
                                        242.0,
                                        248.0,
                                        288.0,
                                        248.0,
                                        242.0,
                                        328.0,
                                        242.0,
                                        328.0,
                                        288.0,
                                        328.0,
                                        242.0,
                                        362.0,
                                        242.0,
                                        362.0,
                                        288.0,
                                        362.0,
                                        242.0,
                                        442.0,
                                        242.0,
                                        442.0,
                                        288.0,
                                        442.0,
                                        242.0,
                                        522.0,
                                        242.0,
                                        522.0,
                                        288.0,
                                        522.0,
                                        242.0,
                                        602.0,
                                        242.0,
                                        602.0,
                                        288.0,
                                        57.0,
                                        288.0
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
                                        "obj-34",
                                        0
                                    ],
                                    "midpoints": [
                                        705.0,
                                        142.0,
                                        711.0,
                                        142.0,
                                        711.0,
                                        180.0,
                                        697.0,
                                        180.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-34",
                                        0
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        736.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        231.0,
                                        142.0,
                                        311.0,
                                        142.0,
                                        311.0,
                                        180.0,
                                        311.0,
                                        142.0,
                                        391.0,
                                        142.0,
                                        391.0,
                                        180.0,
                                        391.0,
                                        142.0,
                                        362.0,
                                        142.0,
                                        362.0,
                                        180.0,
                                        362.0,
                                        142.0,
                                        442.0,
                                        142.0,
                                        442.0,
                                        180.0,
                                        442.0,
                                        142.0,
                                        522.0,
                                        142.0,
                                        522.0,
                                        180.0,
                                        522.0,
                                        142.0,
                                        602.0,
                                        142.0,
                                        602.0,
                                        180.0,
                                        602.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        248.0,
                                        242.0,
                                        248.0,
                                        288.0,
                                        248.0,
                                        242.0,
                                        328.0,
                                        242.0,
                                        328.0,
                                        288.0,
                                        328.0,
                                        242.0,
                                        408.0,
                                        242.0,
                                        408.0,
                                        288.0,
                                        408.0,
                                        242.0,
                                        442.0,
                                        242.0,
                                        442.0,
                                        288.0,
                                        442.0,
                                        242.0,
                                        522.0,
                                        242.0,
                                        522.0,
                                        288.0,
                                        522.0,
                                        242.0,
                                        602.0,
                                        242.0,
                                        602.0,
                                        288.0,
                                        602.0,
                                        242.0,
                                        682.0,
                                        242.0,
                                        682.0,
                                        288.0,
                                        57.0,
                                        288.0
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
                                        "obj-35",
                                        0
                                    ],
                                    "midpoints": [
                                        785.0,
                                        142.0,
                                        791.0,
                                        142.0,
                                        791.0,
                                        180.0,
                                        777.0,
                                        180.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        816.5,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        231.0,
                                        142.0,
                                        311.0,
                                        142.0,
                                        311.0,
                                        180.0,
                                        311.0,
                                        142.0,
                                        391.0,
                                        142.0,
                                        391.0,
                                        180.0,
                                        391.0,
                                        142.0,
                                        471.0,
                                        142.0,
                                        471.0,
                                        180.0,
                                        471.0,
                                        142.0,
                                        442.0,
                                        142.0,
                                        442.0,
                                        180.0,
                                        442.0,
                                        142.0,
                                        522.0,
                                        142.0,
                                        522.0,
                                        180.0,
                                        522.0,
                                        142.0,
                                        602.0,
                                        142.0,
                                        602.0,
                                        180.0,
                                        602.0,
                                        142.0,
                                        682.0,
                                        142.0,
                                        682.0,
                                        180.0,
                                        682.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        248.0,
                                        242.0,
                                        248.0,
                                        288.0,
                                        248.0,
                                        242.0,
                                        328.0,
                                        242.0,
                                        328.0,
                                        288.0,
                                        328.0,
                                        242.0,
                                        408.0,
                                        242.0,
                                        408.0,
                                        288.0,
                                        408.0,
                                        242.0,
                                        442.0,
                                        242.0,
                                        442.0,
                                        288.0,
                                        442.0,
                                        242.0,
                                        522.0,
                                        242.0,
                                        522.0,
                                        288.0,
                                        522.0,
                                        242.0,
                                        602.0,
                                        242.0,
                                        602.0,
                                        288.0,
                                        602.0,
                                        242.0,
                                        682.0,
                                        242.0,
                                        682.0,
                                        288.0,
                                        682.0,
                                        242.0,
                                        762.0,
                                        242.0,
                                        762.0,
                                        288.0,
                                        57.0,
                                        288.0
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
                                        "obj-36",
                                        0
                                    ],
                                    "midpoints": [
                                        865.0,
                                        142.0,
                                        871.0,
                                        142.0,
                                        871.0,
                                        180.0,
                                        857.0,
                                        180.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-36",
                                        0
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        900.0,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        231.0,
                                        142.0,
                                        311.0,
                                        142.0,
                                        311.0,
                                        180.0,
                                        311.0,
                                        142.0,
                                        391.0,
                                        142.0,
                                        391.0,
                                        180.0,
                                        391.0,
                                        142.0,
                                        471.0,
                                        142.0,
                                        471.0,
                                        180.0,
                                        471.0,
                                        142.0,
                                        442.0,
                                        142.0,
                                        442.0,
                                        180.0,
                                        442.0,
                                        142.0,
                                        522.0,
                                        142.0,
                                        522.0,
                                        180.0,
                                        522.0,
                                        142.0,
                                        602.0,
                                        142.0,
                                        602.0,
                                        180.0,
                                        602.0,
                                        142.0,
                                        682.0,
                                        142.0,
                                        682.0,
                                        180.0,
                                        682.0,
                                        142.0,
                                        762.0,
                                        142.0,
                                        762.0,
                                        180.0,
                                        762.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        248.0,
                                        242.0,
                                        248.0,
                                        288.0,
                                        248.0,
                                        242.0,
                                        328.0,
                                        242.0,
                                        328.0,
                                        288.0,
                                        328.0,
                                        242.0,
                                        408.0,
                                        242.0,
                                        408.0,
                                        288.0,
                                        408.0,
                                        242.0,
                                        488.0,
                                        242.0,
                                        488.0,
                                        288.0,
                                        488.0,
                                        242.0,
                                        522.0,
                                        242.0,
                                        522.0,
                                        288.0,
                                        522.0,
                                        242.0,
                                        602.0,
                                        242.0,
                                        602.0,
                                        288.0,
                                        602.0,
                                        242.0,
                                        682.0,
                                        242.0,
                                        682.0,
                                        288.0,
                                        682.0,
                                        242.0,
                                        762.0,
                                        242.0,
                                        762.0,
                                        288.0,
                                        762.0,
                                        242.0,
                                        842.0,
                                        242.0,
                                        842.0,
                                        288.0,
                                        57.0,
                                        288.0
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
                                        "obj-37",
                                        0
                                    ],
                                    "midpoints": [
                                        945.0,
                                        142.0,
                                        958.0,
                                        142.0,
                                        958.0,
                                        180.0,
                                        937.0,
                                        180.0
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        980.0,
                                        142.0,
                                        151.0,
                                        142.0,
                                        151.0,
                                        180.0,
                                        151.0,
                                        142.0,
                                        231.0,
                                        142.0,
                                        231.0,
                                        180.0,
                                        231.0,
                                        142.0,
                                        311.0,
                                        142.0,
                                        311.0,
                                        180.0,
                                        311.0,
                                        142.0,
                                        391.0,
                                        142.0,
                                        391.0,
                                        180.0,
                                        391.0,
                                        142.0,
                                        471.0,
                                        142.0,
                                        471.0,
                                        180.0,
                                        471.0,
                                        142.0,
                                        551.0,
                                        142.0,
                                        551.0,
                                        180.0,
                                        551.0,
                                        142.0,
                                        522.0,
                                        142.0,
                                        522.0,
                                        180.0,
                                        522.0,
                                        142.0,
                                        602.0,
                                        142.0,
                                        602.0,
                                        180.0,
                                        602.0,
                                        142.0,
                                        682.0,
                                        142.0,
                                        682.0,
                                        180.0,
                                        682.0,
                                        142.0,
                                        762.0,
                                        142.0,
                                        762.0,
                                        180.0,
                                        762.0,
                                        142.0,
                                        842.0,
                                        142.0,
                                        842.0,
                                        180.0,
                                        842.0,
                                        202.0,
                                        110.0,
                                        202.0,
                                        110.0,
                                        240.0,
                                        110.0,
                                        242.0,
                                        168.0,
                                        242.0,
                                        168.0,
                                        288.0,
                                        168.0,
                                        242.0,
                                        248.0,
                                        242.0,
                                        248.0,
                                        288.0,
                                        248.0,
                                        242.0,
                                        328.0,
                                        242.0,
                                        328.0,
                                        288.0,
                                        328.0,
                                        242.0,
                                        408.0,
                                        242.0,
                                        408.0,
                                        288.0,
                                        408.0,
                                        242.0,
                                        488.0,
                                        242.0,
                                        488.0,
                                        288.0,
                                        488.0,
                                        242.0,
                                        522.0,
                                        242.0,
                                        522.0,
                                        288.0,
                                        522.0,
                                        242.0,
                                        602.0,
                                        242.0,
                                        602.0,
                                        288.0,
                                        602.0,
                                        242.0,
                                        682.0,
                                        242.0,
                                        682.0,
                                        288.0,
                                        682.0,
                                        242.0,
                                        762.0,
                                        242.0,
                                        762.0,
                                        288.0,
                                        762.0,
                                        242.0,
                                        842.0,
                                        242.0,
                                        842.0,
                                        288.0,
                                        842.0,
                                        242.0,
                                        922.0,
                                        242.0,
                                        922.0,
                                        288.0,
                                        57.0,
                                        288.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-38",
                                        0
                                    ],
                                    "destination": [
                                        "obj-39",
                                        0
                                    ],
                                    "midpoints": [
                                        66.0,
                                        242.0,
                                        88.0,
                                        242.0,
                                        88.0,
                                        288.0,
                                        88.0,
                                        242.0,
                                        122.0,
                                        242.0,
                                        122.0,
                                        288.0,
                                        122.0,
                                        282.0,
                                        89.0,
                                        282.0,
                                        89.0,
                                        320.0,
                                        89.0,
                                        282.0,
                                        102.0,
                                        282.0,
                                        102.0,
                                        320.0,
                                        146.5,
                                        320.0
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
                                        "obj-40",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-40",
                                        0
                                    ],
                                    "destination": [
                                        "obj-14",
                                        0
                                    ],
                                    "midpoints": [
                                        1070.0,
                                        317.0,
                                        1070.0,
                                        242.0,
                                        137.0,
                                        242.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-39",
                                        1
                                    ],
                                    "destination": [
                                        "obj-41",
                                        0
                                    ],
                                    "midpoints": [
                                        56.90909090909091,
                                        282.0,
                                        89.0,
                                        282.0,
                                        89.0,
                                        320.0,
                                        117.0,
                                        320.0
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
                                        "obj-15",
                                        0
                                    ],
                                    "midpoints": [
                                        1078.0,
                                        317.0,
                                        1078.0,
                                        242.0,
                                        217.0,
                                        242.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-39",
                                        2
                                    ],
                                    "destination": [
                                        "obj-42",
                                        0
                                    ],
                                    "midpoints": [
                                        76.81818181818181,
                                        282.0,
                                        89.0,
                                        282.0,
                                        89.0,
                                        320.0,
                                        89.0,
                                        282.0,
                                        169.0,
                                        282.0,
                                        169.0,
                                        320.0,
                                        197.0,
                                        320.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-42",
                                        0
                                    ],
                                    "destination": [
                                        "obj-16",
                                        0
                                    ],
                                    "midpoints": [
                                        1086.0,
                                        317.0,
                                        1086.0,
                                        242.0,
                                        297.0,
                                        242.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-39",
                                        3
                                    ],
                                    "destination": [
                                        "obj-43",
                                        0
                                    ],
                                    "midpoints": [
                                        96.72727272727273,
                                        282.0,
                                        169.0,
                                        282.0,
                                        169.0,
                                        320.0,
                                        169.0,
                                        282.0,
                                        182.0,
                                        282.0,
                                        182.0,
                                        320.0,
                                        277.0,
                                        320.0
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
                                        "obj-17",
                                        0
                                    ],
                                    "midpoints": [
                                        1094.0,
                                        317.0,
                                        1094.0,
                                        242.0,
                                        377.0,
                                        242.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-39",
                                        4
                                    ],
                                    "destination": [
                                        "obj-44",
                                        0
                                    ],
                                    "midpoints": [
                                        116.63636363636364,
                                        282.0,
                                        169.0,
                                        282.0,
                                        169.0,
                                        320.0,
                                        169.0,
                                        282.0,
                                        249.0,
                                        282.0,
                                        249.0,
                                        320.0,
                                        249.0,
                                        282.0,
                                        262.0,
                                        282.0,
                                        262.0,
                                        320.0,
                                        357.0,
                                        320.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-44",
                                        0
                                    ],
                                    "destination": [
                                        "obj-18",
                                        0
                                    ],
                                    "midpoints": [
                                        1102.0,
                                        317.0,
                                        1102.0,
                                        242.0,
                                        457.0,
                                        242.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-39",
                                        5
                                    ],
                                    "destination": [
                                        "obj-45",
                                        0
                                    ],
                                    "midpoints": [
                                        136.54545454545456,
                                        282.0,
                                        169.0,
                                        282.0,
                                        169.0,
                                        320.0,
                                        169.0,
                                        282.0,
                                        249.0,
                                        282.0,
                                        249.0,
                                        320.0,
                                        249.0,
                                        282.0,
                                        262.0,
                                        282.0,
                                        262.0,
                                        320.0,
                                        262.0,
                                        282.0,
                                        342.0,
                                        282.0,
                                        342.0,
                                        320.0,
                                        437.0,
                                        320.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-45",
                                        0
                                    ],
                                    "destination": [
                                        "obj-19",
                                        0
                                    ],
                                    "midpoints": [
                                        1110.0,
                                        317.0,
                                        1110.0,
                                        242.0,
                                        537.0,
                                        242.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-39",
                                        6
                                    ],
                                    "destination": [
                                        "obj-46",
                                        0
                                    ],
                                    "midpoints": [
                                        156.45454545454547,
                                        282.0,
                                        169.0,
                                        282.0,
                                        169.0,
                                        320.0,
                                        169.0,
                                        282.0,
                                        249.0,
                                        282.0,
                                        249.0,
                                        320.0,
                                        249.0,
                                        282.0,
                                        329.0,
                                        282.0,
                                        329.0,
                                        320.0,
                                        329.0,
                                        282.0,
                                        342.0,
                                        282.0,
                                        342.0,
                                        320.0,
                                        342.0,
                                        282.0,
                                        422.0,
                                        282.0,
                                        422.0,
                                        320.0,
                                        517.0,
                                        320.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-46",
                                        0
                                    ],
                                    "destination": [
                                        "obj-20",
                                        0
                                    ],
                                    "midpoints": [
                                        1118.0,
                                        317.0,
                                        1118.0,
                                        242.0,
                                        617.0,
                                        242.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-39",
                                        7
                                    ],
                                    "destination": [
                                        "obj-47",
                                        0
                                    ],
                                    "midpoints": [
                                        176.36363636363637,
                                        282.0,
                                        249.0,
                                        282.0,
                                        249.0,
                                        320.0,
                                        249.0,
                                        282.0,
                                        329.0,
                                        282.0,
                                        329.0,
                                        320.0,
                                        329.0,
                                        282.0,
                                        409.0,
                                        282.0,
                                        409.0,
                                        320.0,
                                        409.0,
                                        282.0,
                                        422.0,
                                        282.0,
                                        422.0,
                                        320.0,
                                        422.0,
                                        282.0,
                                        502.0,
                                        282.0,
                                        502.0,
                                        320.0,
                                        597.0,
                                        320.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-47",
                                        0
                                    ],
                                    "destination": [
                                        "obj-21",
                                        0
                                    ],
                                    "midpoints": [
                                        1126.0,
                                        317.0,
                                        1126.0,
                                        242.0,
                                        697.0,
                                        242.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-39",
                                        8
                                    ],
                                    "destination": [
                                        "obj-48",
                                        0
                                    ],
                                    "midpoints": [
                                        196.27272727272728,
                                        282.0,
                                        249.0,
                                        282.0,
                                        249.0,
                                        320.0,
                                        249.0,
                                        282.0,
                                        329.0,
                                        282.0,
                                        329.0,
                                        320.0,
                                        329.0,
                                        282.0,
                                        409.0,
                                        282.0,
                                        409.0,
                                        320.0,
                                        409.0,
                                        282.0,
                                        422.0,
                                        282.0,
                                        422.0,
                                        320.0,
                                        422.0,
                                        282.0,
                                        502.0,
                                        282.0,
                                        502.0,
                                        320.0,
                                        502.0,
                                        282.0,
                                        582.0,
                                        282.0,
                                        582.0,
                                        320.0,
                                        677.0,
                                        320.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-48",
                                        0
                                    ],
                                    "destination": [
                                        "obj-22",
                                        0
                                    ],
                                    "midpoints": [
                                        1134.0,
                                        317.0,
                                        1134.0,
                                        242.0,
                                        777.0,
                                        242.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-39",
                                        9
                                    ],
                                    "destination": [
                                        "obj-49",
                                        0
                                    ],
                                    "midpoints": [
                                        216.1818181818182,
                                        282.0,
                                        249.0,
                                        282.0,
                                        249.0,
                                        320.0,
                                        249.0,
                                        282.0,
                                        329.0,
                                        282.0,
                                        329.0,
                                        320.0,
                                        329.0,
                                        282.0,
                                        409.0,
                                        282.0,
                                        409.0,
                                        320.0,
                                        409.0,
                                        282.0,
                                        489.0,
                                        282.0,
                                        489.0,
                                        320.0,
                                        489.0,
                                        282.0,
                                        502.0,
                                        282.0,
                                        502.0,
                                        320.0,
                                        502.0,
                                        282.0,
                                        582.0,
                                        282.0,
                                        582.0,
                                        320.0,
                                        582.0,
                                        282.0,
                                        662.0,
                                        282.0,
                                        662.0,
                                        320.0,
                                        757.0,
                                        320.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-49",
                                        0
                                    ],
                                    "destination": [
                                        "obj-23",
                                        0
                                    ],
                                    "midpoints": [
                                        1142.0,
                                        317.0,
                                        1142.0,
                                        242.0,
                                        857.0,
                                        242.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-39",
                                        10
                                    ],
                                    "destination": [
                                        "obj-50",
                                        0
                                    ],
                                    "midpoints": [
                                        236.0909090909091,
                                        282.0,
                                        249.0,
                                        282.0,
                                        249.0,
                                        320.0,
                                        249.0,
                                        282.0,
                                        329.0,
                                        282.0,
                                        329.0,
                                        320.0,
                                        329.0,
                                        282.0,
                                        409.0,
                                        282.0,
                                        409.0,
                                        320.0,
                                        409.0,
                                        282.0,
                                        489.0,
                                        282.0,
                                        489.0,
                                        320.0,
                                        489.0,
                                        282.0,
                                        569.0,
                                        282.0,
                                        569.0,
                                        320.0,
                                        569.0,
                                        282.0,
                                        582.0,
                                        282.0,
                                        582.0,
                                        320.0,
                                        582.0,
                                        282.0,
                                        662.0,
                                        282.0,
                                        662.0,
                                        320.0,
                                        662.0,
                                        282.0,
                                        742.0,
                                        282.0,
                                        742.0,
                                        320.0,
                                        837.0,
                                        320.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-50",
                                        0
                                    ],
                                    "destination": [
                                        "obj-24",
                                        0
                                    ],
                                    "midpoints": [
                                        1150.0,
                                        317.0,
                                        1150.0,
                                        242.0,
                                        937.0,
                                        242.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-39",
                                        11
                                    ],
                                    "destination": [
                                        "obj-51",
                                        0
                                    ],
                                    "midpoints": [
                                        256.0,
                                        282.0,
                                        329.0,
                                        282.0,
                                        329.0,
                                        320.0,
                                        329.0,
                                        282.0,
                                        409.0,
                                        282.0,
                                        409.0,
                                        320.0,
                                        409.0,
                                        282.0,
                                        489.0,
                                        282.0,
                                        489.0,
                                        320.0,
                                        489.0,
                                        282.0,
                                        569.0,
                                        282.0,
                                        569.0,
                                        320.0,
                                        569.0,
                                        282.0,
                                        582.0,
                                        282.0,
                                        582.0,
                                        320.0,
                                        582.0,
                                        282.0,
                                        662.0,
                                        282.0,
                                        662.0,
                                        320.0,
                                        662.0,
                                        282.0,
                                        742.0,
                                        282.0,
                                        742.0,
                                        320.0,
                                        742.0,
                                        282.0,
                                        822.0,
                                        282.0,
                                        822.0,
                                        320.0,
                                        917.0,
                                        320.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-51",
                                        0
                                    ],
                                    "destination": [
                                        "obj-25",
                                        0
                                    ],
                                    "midpoints": [
                                        1158.0,
                                        317.0,
                                        1158.0,
                                        242.0,
                                        1017.0,
                                        242.0
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
                    "id": "obj-87",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        955,
                        128,
                        40.0,
                        20.0
                    ],
                    "text": "on",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        199.0,
                        42.0,
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
                    "id": "obj-88",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        885.0,
                        315.0,
                        121.0,
                        22.0
                    ],
                    "text": "mc.gen~",
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
                            600.0,
                            450.0
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
                                    "maxclass": "newobj",
                                    "id": "obj-1",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        20.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-2",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        130.0,
                                        20.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-3",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        20.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 3",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "codebox",
                                    "id": "obj-4",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        80.0,
                                        400.0,
                                        200.0
                                    ],
                                    "parameter_enable": 0,
                                    "code": "Param gaina(1.0, min=0, max=1);\nParam gainb(0.0, min=0, max=1);\nHistory phs(0);\nHistory sga(1.0);\nHistory sgb(0.0);\nBuffer wta(\"jiharmA\");\nBuffer wtb(\"jiharmB\");\n\n// dual morphing wavetable oscillator — verbatim port of WavetableOscillator.h\n// buffer layout: idx = mip*524288 + frame*2048 + sample (11 mips, 256 frames)\nf = max(in1, 0.);\nposa = clamp(in2, 0., 1.);\nposb = clamp(in3, 0., 1.);\n\n// shared phase: VST osc A/B share baseFreq and both reset to 0 per note\ninc = f / samplerate;\nph = wrap(phs + inc, 0., 1.);\nphs = ph;\n\n// mipmap level = VST getMipmapLevel (octave boundaries from 20 Hz)\nlevel = clamp(floor(log2(max(f, 1.) / 20.)), 0., 10.);\nbase = level * 524288.;\n\nsp = ph * 2048.;\ns0 = floor(sp);\nsf = sp - s0;\ns1 = wrap(s0 + 1., 0., 2048.);\n\n// osc A: bilinear read (sample interp within frame, morph between frames)\nfpa = posa * 255.;\nfa0 = floor(fpa);\nfa1 = min(fa0 + 1., 255.);\nffa = fpa - fa0;\na00 = peek(wta, base + fa0 * 2048. + s0, 0);\na01 = peek(wta, base + fa0 * 2048. + s1, 0);\na10 = peek(wta, base + fa1 * 2048. + s0, 0);\na11 = peek(wta, base + fa1 * 2048. + s1, 0);\nla0 = a00 + sf * (a01 - a00);\nla1 = a10 + sf * (a11 - a10);\noa = la0 + ffa * (la1 - la0);\n\n// osc B: independent position, same phase\nfpb = posb * 255.;\nfb0 = floor(fpb);\nfb1 = min(fb0 + 1., 255.);\nffb = fpb - fb0;\nb00 = peek(wtb, base + fb0 * 2048. + s0, 0);\nb01 = peek(wtb, base + fb0 * 2048. + s1, 0);\nb10 = peek(wtb, base + fb1 * 2048. + s0, 0);\nb11 = peek(wtb, base + fb1 * 2048. + s1, 0);\nlb0 = b00 + sf * (b01 - b00);\nlb1 = b10 + sf * (b11 - b10);\nob = lb0 + ffb * (lb1 - lb0);\n\n// one-pole gain smoothing (~20 ms) mirrors VST block-rate smoothing\nga = sga + (gaina - sga) * 0.001;\nsga = ga;\ngb = sgb + (gainb - sgb) * 0.001;\nsgb = gb;\n\nout1 = oa * ga + ob * gb;\n",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-5",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        50.0,
                                        320.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 1",
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
                                        "obj-4",
                                        0
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
                                        1
                                    ],
                                    "midpoints": [
                                        145.0,
                                        12.0,
                                        202.0,
                                        12.0,
                                        202.0,
                                        50.0,
                                        250.0,
                                        50.0
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
                                        2
                                    ],
                                    "midpoints": [
                                        225.0,
                                        61.0,
                                        443.0,
                                        61.0
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
                                        "obj-5",
                                        0
                                    ],
                                    "midpoints": [
                                        250.0,
                                        300.0,
                                        65.0,
                                        300.0
                                    ]
                                }
                            }
                        ],
                        "dependency_cache": [],
                        "autosave": 0,
                        "bgcolor": [
                            0.9,
                            0.9,
                            0.9,
                            1.0
                        ]
                    }
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-89",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1305.0,
                        240.0,
                        282.0,
                        22.0
                    ],
                    "text": "buffer~ jiharmA bank00-ji-harmonic.wav",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-90",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1300.0,
                        213.0,
                        380.0,
                        20.0
                    ],
                    "text": "per-osc banks: 20 rendered WAVs (11 mipmaps x 256 frames x 2048)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-91",
                    "numinlets": 6,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        1350.0,
                        315.0,
                        86.0,
                        22.0
                    ],
                    "text": "p wtctl",
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
                                        50.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Position A (0-1)"
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
                                        130.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Position B (0-1)"
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
                                        210.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "LFO Rate (Hz)"
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
                                        290.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "LFO Depth (0-1)"
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
                                        50.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Position A signal"
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
                                        130.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Position B signal"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-7",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        100.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 20",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-8",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        100.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 20",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-9",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        45.0,
                                        135.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "line~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-10",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        135.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "line~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-11",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        255.0,
                                        105.0,
                                        68.0,
                                        22.0
                                    ],
                                    "text": "cycle~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-12",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        255.0,
                                        150.0,
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
                                    "id": "obj-13",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        45.0,
                                        180.0,
                                        47.5,
                                        22.0
                                    ],
                                    "text": "+~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-14",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        180.0,
                                        47.5,
                                        22.0
                                    ],
                                    "text": "+~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-15",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        370.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "signal to cycle~"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-16",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "signal to *~"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-17",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        370.0,
                                        105.0,
                                        68.0,
                                        22.0
                                    ],
                                    "text": "cycle~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-18",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        370.0,
                                        150.0,
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
                                    "maxclass": "outlet",
                                    "id": "obj-19",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        210.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "signal from cycle~"
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
                                        "obj-11",
                                        0
                                    ],
                                    "midpoints": [
                                        225.0,
                                        82.5,
                                        262.0,
                                        82.5
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
                                        "obj-12",
                                        1
                                    ],
                                    "midpoints": [
                                        305.0,
                                        97.0,
                                        331.0,
                                        97.0,
                                        331.0,
                                        135.0,
                                        290.0,
                                        135.0
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
                                        "obj-9",
                                        0
                                    ],
                                    "midpoints": [
                                        75.5,
                                        128.5,
                                        52.0,
                                        128.5
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
                                        "obj-10",
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
                                        "obj-12",
                                        0
                                    ],
                                    "midpoints": [
                                        289.0,
                                        138.5,
                                        262.0,
                                        138.5
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
                                        "obj-13",
                                        0
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
                                        "obj-14",
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
                                        "obj-13",
                                        1
                                    ],
                                    "midpoints": [
                                        276.0,
                                        172.0,
                                        205.5,
                                        172.0,
                                        205.5,
                                        210.0,
                                        85.5,
                                        210.0
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
                                        "obj-5",
                                        0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        173.75,
                                        226.0,
                                        137.0,
                                        226.0
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
                                        "obj-17",
                                        0
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
                                        "obj-18",
                                        0
                                    ],
                                    "midpoints": [
                                        404.0,
                                        138.5,
                                        377.0,
                                        138.5
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
                                        "obj-18",
                                        1
                                    ],
                                    "midpoints": [
                                        465.0,
                                        22.0,
                                        408.0,
                                        22.0,
                                        408.0,
                                        68.0,
                                        408.0,
                                        97.0,
                                        446.0,
                                        97.0,
                                        446.0,
                                        135.0,
                                        405.0,
                                        135.0
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
                                        "obj-14",
                                        1
                                    ],
                                    "midpoints": [
                                        391.0,
                                        142.0,
                                        305.0,
                                        142.0,
                                        305.0,
                                        180.0,
                                        190.5,
                                        180.0
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
                                        "obj-19",
                                        0
                                    ],
                                    "midpoints": [
                                        289.0,
                                        142.0,
                                        247.0,
                                        142.0,
                                        247.0,
                                        180.0,
                                        217.0,
                                        180.0
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
                    "id": "obj-92",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1300.0,
                        350.0,
                        72.0,
                        20.0
                    ],
                    "text": "wt pos A",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        130.0,
                        72.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-93",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1395.0,
                        360.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        152.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-94",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1300.0,
                        380.0,
                        72.0,
                        20.0
                    ],
                    "text": "wt pos B",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        390.0,
                        130.0,
                        72.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-95",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1395.0,
                        405.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "presentation": 1,
                    "presentation_rect": [
                        390.0,
                        152.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-96",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1300.0,
                        410.0,
                        72.0,
                        20.0
                    ],
                    "text": "lfo A rate",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        186.0,
                        72.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-97",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1395.0,
                        450.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "minimum": 0.01,
                    "maximum": 20.0,
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        208.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-98",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1300.0,
                        440.0,
                        79.0,
                        20.0
                    ],
                    "text": "lfo A depth",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        310.0,
                        186.0,
                        72.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-99",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1395.0,
                        495.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "presentation": 1,
                    "presentation_rect": [
                        310.0,
                        208.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-100",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1300.0,
                        470.0,
                        86.0,
                        20.0
                    ],
                    "text": "osc gain A",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        310.0,
                        130.0,
                        72.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-101",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1395.0,
                        540.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "presentation": 1,
                    "presentation_rect": [
                        310.0,
                        152.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-102",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1300.0,
                        500.0,
                        86.0,
                        20.0
                    ],
                    "text": "osc gain B",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        470.0,
                        130.0,
                        72.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-103",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1395.0,
                        585.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "presentation": 1,
                    "presentation_rect": [
                        470.0,
                        152.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-104",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1480.0,
                        470.0,
                        72.0,
                        22.0
                    ],
                    "text": "gaina $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-105",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1480.0,
                        500.0,
                        72.0,
                        22.0
                    ],
                    "text": "gainb $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-106",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1650.0,
                        315.0,
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
                    "id": "obj-107",
                    "numinlets": 1,
                    "numoutlets": 12,
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
                        ""
                    ],
                    "patching_rect": [
                        1650.0,
                        360.0,
                        233.0,
                        22.0
                    ],
                    "text": "trigger b b b b b b b b b b b b",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-108",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1650.0,
                        410.0,
                        40.0,
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
                    "id": "obj-109",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1710.0,
                        410.0,
                        40.0,
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
                    "id": "obj-110",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1770.0,
                        410.0,
                        40.0,
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
                    "id": "obj-111",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1830.0,
                        410.0,
                        44.0,
                        22.0
                    ],
                    "text": "0.25",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-112",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1890.0,
                        410.0,
                        40.0,
                        22.0
                    ],
                    "text": "1.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-113",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1950.0,
                        410.0,
                        40.0,
                        22.0
                    ],
                    "text": "0.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-114",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1300.0,
                        185.0,
                        261.0,
                        20.0
                    ],
                    "text": "WAVETABLE ENGINE (dual osc, 20 banks)",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        106.0,
                        260.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-115",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        120.0,
                        450.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend applyvalues",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-116",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1245.0,
                        540.0,
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
                    "id": "obj-117",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1245.0,
                        630.0,
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
                    "id": "obj-118",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1245.0,
                        585.0,
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
                    "id": "obj-119",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1245.0,
                        675.0,
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
                    "id": "obj-120",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1095.0,
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
                    "id": "obj-121",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1095.0,
                        495.0,
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
                    "id": "obj-122",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        600.0,
                        525.0,
                        22.0,
                        140.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-123",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        630.0,
                        525.0,
                        15.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        672.0,
                        110.0,
                        15.0,
                        150.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-124",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        840.0,
                        150.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        290.0,
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
                    "id": "obj-125",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        840.0,
                        120.0,
                        58.0,
                        20.0
                    ],
                    "text": "spread",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        268.0,
                        72.0,
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
                    "id": "obj-126",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        900.0,
                        165.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        310.0,
                        290.0,
                        64.0,
                        22.0
                    ],
                    "minimum": 0.0,
                    "maximum": 50.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-127",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        902.0,
                        120.0,
                        79.0,
                        20.0
                    ],
                    "text": "detune ct",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        310.0,
                        268.0,
                        72.0,
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
                    "id": "obj-128",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        960.0,
                        165.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        390.0,
                        290.0,
                        64.0,
                        22.0
                    ],
                    "minimum": 0.0,
                    "maximum": 100.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-129",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        964.0,
                        120.0,
                        79.0,
                        20.0
                    ],
                    "text": "timing ms",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        390.0,
                        268.0,
                        72.0,
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
                    "id": "obj-130",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        840.0,
                        95.0,
                        275.0,
                        20.0
                    ],
                    "text": "CHORD FEEL (spread / detune / timing)",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        244.0,
                        260.0,
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
                    "id": "obj-131",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1305.0,
                        720.0,
                        282.0,
                        22.0
                    ],
                    "text": "buffer~ jiharmB bank00-ji-harmonic.wav",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-132",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1620.0,
                        218.0,
                        114.0,
                        20.0
                    ],
                    "text": "bank A (osc A)",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        322.0,
                        100.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-133",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1815.0,
                        218.0,
                        114.0,
                        20.0
                    ],
                    "text": "bank B (osc B)",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        410.0,
                        322.0,
                        100.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "umenu",
                    "id": "obj-134",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1620.0,
                        255.0,
                        185.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "items": [
                        "bank00-ji-harmonic.wav",
                        ",",
                        "bank01-warm-analog.wav",
                        ",",
                        "bank02-choir.wav",
                        ",",
                        "bank03-strings.wav",
                        ",",
                        "bank04-glass.wav",
                        ",",
                        "bank05-evolving.wav",
                        ",",
                        "bank06-organ.wav",
                        ",",
                        "bank07-ethereal.wav",
                        ",",
                        "bank08-dark-matter.wav",
                        ",",
                        "bank09-sine.wav",
                        ",",
                        "bank10-square.wav",
                        ",",
                        "bank11-triangle.wav",
                        ",",
                        "bank12-spectral-cloud.wav",
                        ",",
                        "bank13-metallic-resonance.wav",
                        ",",
                        "bank14-formant-vowel.wav",
                        ",",
                        "bank15-warm-sub.wav",
                        ",",
                        "bank16-soft-flute.wav",
                        ",",
                        "bank17-velvet-pad.wav",
                        ",",
                        "bank18-whisper.wav",
                        ",",
                        "bank19-deep-haze.wav"
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        344.0,
                        170.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "umenu",
                    "id": "obj-135",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1815.0,
                        255.0,
                        185.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "items": [
                        "bank00-ji-harmonic.wav",
                        ",",
                        "bank01-warm-analog.wav",
                        ",",
                        "bank02-choir.wav",
                        ",",
                        "bank03-strings.wav",
                        ",",
                        "bank04-glass.wav",
                        ",",
                        "bank05-evolving.wav",
                        ",",
                        "bank06-organ.wav",
                        ",",
                        "bank07-ethereal.wav",
                        ",",
                        "bank08-dark-matter.wav",
                        ",",
                        "bank09-sine.wav",
                        ",",
                        "bank10-square.wav",
                        ",",
                        "bank11-triangle.wav",
                        ",",
                        "bank12-spectral-cloud.wav",
                        ",",
                        "bank13-metallic-resonance.wav",
                        ",",
                        "bank14-formant-vowel.wav",
                        ",",
                        "bank15-warm-sub.wav",
                        ",",
                        "bank16-soft-flute.wav",
                        ",",
                        "bank17-velvet-pad.wav",
                        ",",
                        "bank18-whisper.wav",
                        ",",
                        "bank19-deep-haze.wav"
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        410.0,
                        344.0,
                        170.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-136",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1620.0,
                        450.0,
                        121.0,
                        22.0
                    ],
                    "text": "prepend replace",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-137",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1815.0,
                        300.0,
                        121.0,
                        22.0
                    ],
                    "text": "prepend replace",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-138",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        1480.0,
                        640.0,
                        121.0,
                        22.0
                    ],
                    "text": "gen~",
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
                            600.0,
                            450.0
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
                                    "maxclass": "newobj",
                                    "id": "obj-1",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        20.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-2",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        130.0,
                                        20.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-3",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        20.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 3",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "codebox",
                                    "id": "obj-4",
                                    "numinlets": 3,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        80.0,
                                        400.0,
                                        200.0
                                    ],
                                    "parameter_enable": 0,
                                    "code": "Param cutoff(8000., min=20., max=20000.);\nParam res(0.707, min=0.5, max=10.);\nParam lfodepth(0., min=0., max=1.);\nParam veltofilt(0., min=0., max=1.);\nParam vel(1., min=0., max=1.);\nHistory smoothcut(8000.);\nHistory s1l(0.);\nHistory s2l(0.);\nHistory s1r(0.);\nHistory s2r(0.);\n\n// master TPT SVF lowpass -- verbatim port of the VST master-bus filter\n// (JUCE StateVariableTPTFilter, Zavalishin TPT structure)\n// in1/in2 = L/R post-envelope, in3 = LFO A signal (sin of phase A)\n\n// velocity mod (VST v2.2.0): cutoff * (1 - veltofilt * (1 - lastNoteVelocity))\n// then ~20 ms one-pole smoothing (VST uses a 20 ms linear ramp)\ntarget = cutoff * (1. - veltofilt * (1. - vel));\nsc = smoothcut + (target - smoothcut) * 0.001;\nsmoothcut = sc;\n\n// filter LFO (VST v2.2.0): cutoff * 2^(sin(phaseA) * depth * 2), clamped\nfc = clamp(sc * pow(2., in3 * lfodepth * 2.), 20., 20000.);\n\ng = tan(3.14159265358979 * fc / samplerate);\nr2 = 1. / res;\nh = 1. / (1. + r2 * g + g * g);\n\nhpl = h * (in1 - s1l * (g + r2) - s2l);\nbpl = hpl * g + s1l;\ns1l = hpl * g + bpl;\nlpl = bpl * g + s2l;\ns2l = bpl * g + lpl;\n\nhpr = h * (in2 - s1r * (g + r2) - s2r);\nbpr = hpr * g + s1r;\ns1r = hpr * g + bpr;\nlpr = bpr * g + s2r;\ns2r = bpr * g + lpr;\n\nout1 = lpl;\nout2 = lpr;\n",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-5",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        50.0,
                                        320.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-6",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        130.0,
                                        320.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 2",
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
                                        "obj-4",
                                        0
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
                                        1
                                    ],
                                    "midpoints": [
                                        145.0,
                                        12.0,
                                        202.0,
                                        12.0,
                                        202.0,
                                        50.0,
                                        250.0,
                                        50.0
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
                                        2
                                    ],
                                    "midpoints": [
                                        225.0,
                                        61.0,
                                        443.0,
                                        61.0
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
                                        "obj-5",
                                        0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        443.0,
                                        300.0,
                                        145.0,
                                        300.0
                                    ]
                                }
                            }
                        ],
                        "dependency_cache": [],
                        "autosave": 0,
                        "bgcolor": [
                            0.9,
                            0.9,
                            0.9,
                            1.0
                        ]
                    }
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-139",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        885.0,
                        520.0,
                        100.0,
                        22.0
                    ],
                    "text": "send~ jhFinL",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-140",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1095.0,
                        520.0,
                        100.0,
                        22.0
                    ],
                    "text": "send~ jhFinR",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-141",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1480.0,
                        590.0,
                        121.0,
                        22.0
                    ],
                    "text": "receive~ jhFinL",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-142",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1600.0,
                        590.0,
                        121.0,
                        22.0
                    ],
                    "text": "receive~ jhFinR",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-143",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1480.0,
                        720.0,
                        107.0,
                        22.0
                    ],
                    "text": "send~ jhFoutL",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-144",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1600.0,
                        720.0,
                        107.0,
                        22.0
                    ],
                    "text": "send~ jhFoutR",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-145",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        960.0,
                        445.0,
                        128.0,
                        22.0
                    ],
                    "text": "receive~ jhFoutL",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-146",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1160.0,
                        460.0,
                        128.0,
                        22.0
                    ],
                    "text": "receive~ jhFoutR",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-147",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        675.0,
                        360.0,
                        121.0,
                        22.0
                    ],
                    "text": "split 0.0001 1.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-148",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        675.0,
                        395.0,
                        58.0,
                        22.0
                    ],
                    "text": "vel $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-149",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1480.0,
                        540.0,
                        240.0,
                        20.0
                    ],
                    "text": "FILTER (master TPT LP, post-env)",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        496.0,
                        200.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-150",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1720.0,
                        570.0,
                        79.0,
                        20.0
                    ],
                    "text": "cutoff Hz",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        520.0,
                        76.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-151",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1815.0,
                        570.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        542.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-152",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1880.0,
                        570.0,
                        79.0,
                        22.0
                    ],
                    "text": "cutoff $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-153",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1720.0,
                        615.0,
                        79.0,
                        20.0
                    ],
                    "text": "resonance",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        95.0,
                        520.0,
                        76.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-154",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1815.0,
                        615.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        95.0,
                        542.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-155",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1880.0,
                        615.0,
                        58.0,
                        22.0
                    ],
                    "text": "res $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-156",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1720.0,
                        660.0,
                        114.0,
                        20.0
                    ],
                    "text": "filter lfo (A)",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        175.0,
                        520.0,
                        76.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-157",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1815.0,
                        660.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        175.0,
                        542.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-158",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1880.0,
                        660.0,
                        93.0,
                        22.0
                    ],
                    "text": "lfodepth $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-159",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1720.0,
                        705.0,
                        100.0,
                        20.0
                    ],
                    "text": "vel > filter",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        255.0,
                        520.0,
                        76.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-160",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1815.0,
                        705.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        255.0,
                        542.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-161",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1880.0,
                        705.0,
                        100.0,
                        22.0
                    ],
                    "text": "veltofilt $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-162",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1720.0,
                        750.0,
                        86.0,
                        20.0
                    ],
                    "text": "lfo B rate",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        335.0,
                        520.0,
                        76.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-163",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1815.0,
                        750.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        335.0,
                        542.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-164",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1720.0,
                        795.0,
                        93.0,
                        20.0
                    ],
                    "text": "lfo B depth",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        415.0,
                        520.0,
                        76.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-165",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1815.0,
                        795.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        415.0,
                        542.0,
                        64.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-166",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2010.0,
                        410.0,
                        40.0,
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
                    "id": "obj-167",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2070.0,
                        410.0,
                        40.0,
                        22.0
                    ],
                    "text": "0.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-168",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2130.0,
                        410.0,
                        51.0,
                        22.0
                    ],
                    "text": "8000.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-169",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2190.0,
                        410.0,
                        51.0,
                        22.0
                    ],
                    "text": "0.707",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-170",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2250.0,
                        410.0,
                        40.0,
                        22.0
                    ],
                    "text": "0.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-171",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2310.0,
                        410.0,
                        40.0,
                        22.0
                    ],
                    "text": "0.",
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
                        487.0,
                        142.0,
                        534.0,
                        142.0,
                        534.0,
                        180.0,
                        534.0,
                        142.0,
                        596.0,
                        142.0,
                        596.0,
                        180.0,
                        607.0,
                        180.0
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
                        549.0,
                        142.0,
                        596.0,
                        142.0,
                        596.0,
                        180.0,
                        617.2857142857143,
                        180.0
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
                        673.0,
                        142.0,
                        662.0,
                        142.0,
                        662.0,
                        180.0,
                        637.8571428571429,
                        180.0
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
                        735.0,
                        142.0,
                        662.0,
                        142.0,
                        662.0,
                        180.0,
                        662.0,
                        142.0,
                        724.0,
                        142.0,
                        724.0,
                        180.0,
                        648.1428571428571,
                        180.0
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
                        1072.0,
                        22.0,
                        1239.0,
                        22.0,
                        1239.0,
                        60.0,
                        1239.0,
                        22.0,
                        1237.0,
                        22.0,
                        1237.0,
                        60.0,
                        1237.0,
                        22.0,
                        1327.0,
                        22.0,
                        1327.0,
                        60.0,
                        1327.0,
                        67.0,
                        1149.0,
                        67.0,
                        1149.0,
                        105.0,
                        1149.0,
                        67.0,
                        1239.0,
                        67.0,
                        1239.0,
                        105.0,
                        1239.0,
                        67.0,
                        1237.0,
                        67.0,
                        1237.0,
                        105.0,
                        1237.0,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1123.0,
                        95.0,
                        1120.0,
                        95.0,
                        1120.0,
                        129.0,
                        1120.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1266.0,
                        95.0,
                        1266.0,
                        129.0,
                        1266.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1356.0,
                        123.0,
                        1159.0,
                        123.0,
                        1159.0,
                        161.0,
                        1357.0,
                        161.0
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
                        1162.0,
                        22.0,
                        1237.0,
                        22.0,
                        1237.0,
                        60.0,
                        1237.0,
                        22.0,
                        1327.0,
                        22.0,
                        1327.0,
                        60.0,
                        1327.0,
                        67.0,
                        1239.0,
                        67.0,
                        1239.0,
                        105.0,
                        1239.0,
                        67.0,
                        1237.0,
                        67.0,
                        1237.0,
                        105.0,
                        1237.0,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1266.0,
                        95.0,
                        1266.0,
                        129.0,
                        1266.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1363.5454545454545,
                        129.0
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
                        1252.0,
                        22.0,
                        1327.0,
                        22.0,
                        1327.0,
                        60.0,
                        1327.0,
                        67.0,
                        1329.0,
                        67.0,
                        1329.0,
                        105.0,
                        1329.0,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        95.0,
                        1300.0,
                        95.0,
                        1300.0,
                        129.0,
                        1300.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1370.090909090909,
                        129.0
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
                        1342.0,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1376.6363636363637,
                        129.0
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
                        1432.0,
                        22.0,
                        1419.0,
                        22.0,
                        1419.0,
                        60.0,
                        1419.0,
                        67.0,
                        1419.0,
                        67.0,
                        1419.0,
                        105.0,
                        1419.0,
                        67.0,
                        1417.0,
                        67.0,
                        1417.0,
                        105.0,
                        1417.0,
                        95.0,
                        1390.0,
                        95.0,
                        1390.0,
                        129.0,
                        1383.1818181818182,
                        129.0
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
                        1522.0,
                        22.0,
                        1419.0,
                        22.0,
                        1419.0,
                        60.0,
                        1419.0,
                        22.0,
                        1417.0,
                        22.0,
                        1417.0,
                        60.0,
                        1417.0,
                        67.0,
                        1419.0,
                        67.0,
                        1419.0,
                        105.0,
                        1419.0,
                        67.0,
                        1417.0,
                        67.0,
                        1417.0,
                        105.0,
                        1417.0,
                        67.0,
                        1507.0,
                        67.0,
                        1507.0,
                        105.0,
                        1507.0,
                        95.0,
                        1390.0,
                        95.0,
                        1390.0,
                        129.0,
                        1390.0,
                        95.0,
                        1446.0,
                        95.0,
                        1446.0,
                        129.0,
                        1389.7272727272727,
                        129.0
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
                        1072.0,
                        67.0,
                        1239.0,
                        67.0,
                        1239.0,
                        105.0,
                        1239.0,
                        67.0,
                        1237.0,
                        67.0,
                        1237.0,
                        105.0,
                        1237.0,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1123.0,
                        95.0,
                        1120.0,
                        95.0,
                        1120.0,
                        129.0,
                        1120.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1266.0,
                        95.0,
                        1266.0,
                        129.0,
                        1266.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1356.0,
                        123.0,
                        1159.0,
                        123.0,
                        1159.0,
                        161.0,
                        1396.2727272727273,
                        161.0
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
                        1162.0,
                        67.0,
                        1237.0,
                        67.0,
                        1237.0,
                        105.0,
                        1237.0,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1266.0,
                        95.0,
                        1266.0,
                        129.0,
                        1266.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1402.8181818181818,
                        129.0
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
                        1252.0,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        95.0,
                        1300.0,
                        95.0,
                        1300.0,
                        129.0,
                        1300.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1409.3636363636363,
                        129.0
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
                        1342.0,
                        67.0,
                        1417.0,
                        67.0,
                        1417.0,
                        105.0,
                        1417.0,
                        95.0,
                        1390.0,
                        95.0,
                        1390.0,
                        129.0,
                        1415.909090909091,
                        129.0
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
                        1522.0,
                        67.0,
                        1509.0,
                        67.0,
                        1509.0,
                        105.0,
                        1509.0,
                        95.0,
                        1480.0,
                        95.0,
                        1480.0,
                        129.0,
                        1429.0,
                        129.0
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
                        142.0,
                        538.0,
                        142.0,
                        538.0,
                        180.0,
                        538.0,
                        142.0,
                        600.0,
                        142.0,
                        600.0,
                        180.0,
                        600.0,
                        142.0,
                        662.0,
                        142.0,
                        662.0,
                        180.0,
                        662.0,
                        142.0,
                        724.0,
                        142.0,
                        724.0,
                        180.0,
                        724.0,
                        142.0,
                        836.0,
                        142.0,
                        836.0,
                        180.0,
                        836.0,
                        142.0,
                        832.0,
                        142.0,
                        832.0,
                        180.0,
                        832.0,
                        157.0,
                        892.0,
                        157.0,
                        892.0,
                        195.0,
                        892.0,
                        157.0,
                        952.0,
                        157.0,
                        952.0,
                        195.0,
                        952.0,
                        177.0,
                        1292.0,
                        177.0,
                        1292.0,
                        213.0,
                        1292.0,
                        187.0,
                        694.0,
                        187.0,
                        694.0,
                        225.0,
                        694.0,
                        205.0,
                        1292.0,
                        205.0,
                        1292.0,
                        241.0,
                        1292.0,
                        232.0,
                        1297.0,
                        232.0,
                        1297.0,
                        270.0,
                        187.5,
                        270.0
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
                        187.5,
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
                        437.0,
                        952.0,
                        437.0,
                        952.0,
                        475.0,
                        952.0,
                        442.0,
                        1087.0,
                        442.0,
                        1087.0,
                        480.0,
                        892.0,
                        480.0
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
                        877.0,
                        352.0,
                        804.0,
                        352.0,
                        804.0,
                        390.0,
                        804.0,
                        387.0,
                        741.0,
                        387.0,
                        741.0,
                        425.0,
                        920.0,
                        425.0
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
                        512.0,
                        877.0,
                        512.0,
                        877.0,
                        550.0,
                        877.0,
                        517.0,
                        593.0,
                        517.0,
                        593.0,
                        633.0,
                        593.0,
                        517.0,
                        630.0,
                        517.0,
                        630.0,
                        673.0,
                        630.0,
                        517.0,
                        653.0,
                        517.0,
                        653.0,
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
                        "obj-68",
                        0
                    ],
                    "destination": [
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        112.0,
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
                        505.0,
                        180.0
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
                        120.0,
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
                        142.0,
                        472.0,
                        142.0,
                        472.0,
                        180.0,
                        567.0,
                        180.0
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
                        128.0,
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
                        142.0,
                        472.0,
                        142.0,
                        472.0,
                        180.0,
                        472.0,
                        142.0,
                        534.0,
                        142.0,
                        534.0,
                        180.0,
                        629.0,
                        180.0
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
                        136.0,
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
                        142.0,
                        472.0,
                        142.0,
                        472.0,
                        180.0,
                        472.0,
                        142.0,
                        534.0,
                        142.0,
                        534.0,
                        180.0,
                        534.0,
                        142.0,
                        596.0,
                        142.0,
                        596.0,
                        180.0,
                        691.0,
                        180.0
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
                        144.0,
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
                        142.0,
                        472.0,
                        142.0,
                        472.0,
                        180.0,
                        472.0,
                        142.0,
                        534.0,
                        142.0,
                        534.0,
                        180.0,
                        534.0,
                        142.0,
                        596.0,
                        142.0,
                        596.0,
                        180.0,
                        596.0,
                        142.0,
                        658.0,
                        142.0,
                        658.0,
                        180.0,
                        778.0,
                        180.0
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
                        152.0,
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
                        142.0,
                        472.0,
                        142.0,
                        472.0,
                        180.0,
                        472.0,
                        142.0,
                        534.0,
                        142.0,
                        534.0,
                        180.0,
                        534.0,
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
                        487.0,
                        352.0,
                        277.0,
                        352.0,
                        277.0,
                        390.0,
                        277.0,
                        397.0,
                        277.0,
                        397.0,
                        277.0,
                        435.0,
                        277.0,
                        442.0,
                        277.0,
                        442.0,
                        277.0,
                        480.0,
                        551.0,
                        480.0
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
                        160.0,
                        82.0,
                        127.0,
                        82.0,
                        127.0,
                        151.0,
                        127.0,
                        142.0,
                        127.0,
                        142.0,
                        127.0,
                        180.0,
                        187.5,
                        180.0
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
                        "obj-71",
                        0
                    ],
                    "midpoints": [
                        127.0,
                        262.0,
                        112.0,
                        262.0,
                        112.0,
                        300.0,
                        112.0,
                        307.0,
                        163.0,
                        307.0,
                        163.0,
                        345.0,
                        163.0,
                        307.0,
                        172.0,
                        307.0,
                        172.0,
                        345.0,
                        194.5,
                        345.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-71",
                        0
                    ],
                    "destination": [
                        "obj-56",
                        0
                    ],
                    "midpoints": [
                        3331.0,
                        387.0,
                        3331.0,
                        262.0,
                        442.5,
                        262.0
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
                        "obj-72",
                        0
                    ],
                    "midpoints": [
                        157.25,
                        262.0,
                        112.0,
                        262.0,
                        112.0,
                        300.0,
                        112.0,
                        307.0,
                        163.0,
                        307.0,
                        163.0,
                        345.0,
                        163.0,
                        307.0,
                        172.0,
                        307.0,
                        172.0,
                        345.0,
                        172.0,
                        352.0,
                        112.0,
                        352.0,
                        112.0,
                        390.0,
                        194.5,
                        390.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-72",
                        0
                    ],
                    "destination": [
                        "obj-57",
                        0
                    ],
                    "midpoints": [
                        3339.0,
                        432.0,
                        3339.0,
                        262.0,
                        592.5,
                        262.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-73",
                        0
                    ],
                    "destination": [
                        "obj-86",
                        0
                    ],
                    "midpoints": [
                        1103.0,
                        22.0,
                        1057.0,
                        22.0,
                        1057.0,
                        60.0,
                        1057.0,
                        67.0,
                        1057.0,
                        67.0,
                        1057.0,
                        105.0,
                        1057.0,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1123.0,
                        95.0,
                        1086.0,
                        95.0,
                        1086.0,
                        129.0,
                        1072.0,
                        129.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-86",
                        1
                    ],
                    "destination": [
                        "obj-73",
                        0
                    ],
                    "midpoints": [
                        3275.0,
                        158.0,
                        3275.0,
                        -3.0,
                        1103.0,
                        -3.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-74",
                        0
                    ],
                    "destination": [
                        "obj-86",
                        1
                    ],
                    "midpoints": [
                        1193.0,
                        -3.0,
                        1120.0,
                        -3.0,
                        1120.0,
                        31.0,
                        1120.0,
                        22.0,
                        1149.0,
                        22.0,
                        1149.0,
                        60.0,
                        1149.0,
                        22.0,
                        1147.0,
                        22.0,
                        1147.0,
                        60.0,
                        1147.0,
                        67.0,
                        1149.0,
                        67.0,
                        1149.0,
                        105.0,
                        1149.0,
                        67.0,
                        1147.0,
                        67.0,
                        1147.0,
                        105.0,
                        1147.0,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1123.0,
                        95.0,
                        1120.0,
                        95.0,
                        1120.0,
                        129.0,
                        1120.0,
                        95.0,
                        1176.0,
                        95.0,
                        1176.0,
                        129.0,
                        1078.5454545454545,
                        129.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-86",
                        2
                    ],
                    "destination": [
                        "obj-74",
                        0
                    ],
                    "midpoints": [
                        3283.0,
                        158.0,
                        3283.0,
                        -3.0,
                        1193.0,
                        -3.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-75",
                        0
                    ],
                    "destination": [
                        "obj-86",
                        2
                    ],
                    "midpoints": [
                        1283.0,
                        -3.0,
                        1120.0,
                        -3.0,
                        1120.0,
                        31.0,
                        1120.0,
                        -3.0,
                        1176.0,
                        -3.0,
                        1176.0,
                        31.0,
                        1176.0,
                        22.0,
                        1149.0,
                        22.0,
                        1149.0,
                        60.0,
                        1149.0,
                        22.0,
                        1147.0,
                        22.0,
                        1147.0,
                        60.0,
                        1147.0,
                        22.0,
                        1237.0,
                        22.0,
                        1237.0,
                        60.0,
                        1237.0,
                        67.0,
                        1149.0,
                        67.0,
                        1149.0,
                        105.0,
                        1149.0,
                        67.0,
                        1147.0,
                        67.0,
                        1147.0,
                        105.0,
                        1147.0,
                        67.0,
                        1237.0,
                        67.0,
                        1237.0,
                        105.0,
                        1237.0,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1123.0,
                        95.0,
                        1120.0,
                        95.0,
                        1120.0,
                        129.0,
                        1120.0,
                        95.0,
                        1176.0,
                        95.0,
                        1176.0,
                        129.0,
                        1176.0,
                        95.0,
                        1266.0,
                        95.0,
                        1266.0,
                        129.0,
                        1085.090909090909,
                        129.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-86",
                        3
                    ],
                    "destination": [
                        "obj-75",
                        0
                    ],
                    "midpoints": [
                        3291.0,
                        158.0,
                        3291.0,
                        -3.0,
                        1283.0,
                        -3.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-76",
                        0
                    ],
                    "destination": [
                        "obj-86",
                        3
                    ],
                    "midpoints": [
                        1373.0,
                        -3.0,
                        1120.0,
                        -3.0,
                        1120.0,
                        31.0,
                        1120.0,
                        -3.0,
                        1210.0,
                        -3.0,
                        1210.0,
                        31.0,
                        1210.0,
                        -3.0,
                        1266.0,
                        -3.0,
                        1266.0,
                        31.0,
                        1266.0,
                        22.0,
                        1149.0,
                        22.0,
                        1149.0,
                        60.0,
                        1149.0,
                        22.0,
                        1239.0,
                        22.0,
                        1239.0,
                        60.0,
                        1239.0,
                        22.0,
                        1237.0,
                        22.0,
                        1237.0,
                        60.0,
                        1237.0,
                        22.0,
                        1327.0,
                        22.0,
                        1327.0,
                        60.0,
                        1327.0,
                        67.0,
                        1149.0,
                        67.0,
                        1149.0,
                        105.0,
                        1149.0,
                        67.0,
                        1239.0,
                        67.0,
                        1239.0,
                        105.0,
                        1239.0,
                        67.0,
                        1237.0,
                        67.0,
                        1237.0,
                        105.0,
                        1237.0,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1123.0,
                        95.0,
                        1120.0,
                        95.0,
                        1120.0,
                        129.0,
                        1120.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1266.0,
                        95.0,
                        1266.0,
                        129.0,
                        1266.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1091.6363636363637,
                        129.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-86",
                        4
                    ],
                    "destination": [
                        "obj-76",
                        0
                    ],
                    "midpoints": [
                        3299.0,
                        158.0,
                        3299.0,
                        -3.0,
                        1373.0,
                        -3.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-77",
                        0
                    ],
                    "destination": [
                        "obj-86",
                        4
                    ],
                    "midpoints": [
                        1463.0,
                        -3.0,
                        1120.0,
                        -3.0,
                        1120.0,
                        31.0,
                        1120.0,
                        -3.0,
                        1210.0,
                        -3.0,
                        1210.0,
                        31.0,
                        1210.0,
                        -3.0,
                        1266.0,
                        -3.0,
                        1266.0,
                        31.0,
                        1266.0,
                        -3.0,
                        1356.0,
                        -3.0,
                        1356.0,
                        31.0,
                        1356.0,
                        22.0,
                        1149.0,
                        22.0,
                        1149.0,
                        60.0,
                        1149.0,
                        22.0,
                        1239.0,
                        22.0,
                        1239.0,
                        60.0,
                        1239.0,
                        22.0,
                        1237.0,
                        22.0,
                        1237.0,
                        60.0,
                        1237.0,
                        22.0,
                        1327.0,
                        22.0,
                        1327.0,
                        60.0,
                        1327.0,
                        22.0,
                        1417.0,
                        22.0,
                        1417.0,
                        60.0,
                        1417.0,
                        67.0,
                        1149.0,
                        67.0,
                        1149.0,
                        105.0,
                        1149.0,
                        67.0,
                        1239.0,
                        67.0,
                        1239.0,
                        105.0,
                        1239.0,
                        67.0,
                        1237.0,
                        67.0,
                        1237.0,
                        105.0,
                        1237.0,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        67.0,
                        1417.0,
                        67.0,
                        1417.0,
                        105.0,
                        1417.0,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1123.0,
                        95.0,
                        1120.0,
                        95.0,
                        1120.0,
                        129.0,
                        1120.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1266.0,
                        95.0,
                        1266.0,
                        129.0,
                        1266.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1356.0,
                        95.0,
                        1446.0,
                        95.0,
                        1446.0,
                        129.0,
                        1098.1818181818182,
                        129.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-86",
                        5
                    ],
                    "destination": [
                        "obj-77",
                        0
                    ],
                    "midpoints": [
                        3307.0,
                        158.0,
                        3307.0,
                        -3.0,
                        1463.0,
                        -3.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-78",
                        0
                    ],
                    "destination": [
                        "obj-86",
                        5
                    ],
                    "midpoints": [
                        1553.0,
                        -3.0,
                        1120.0,
                        -3.0,
                        1120.0,
                        31.0,
                        1120.0,
                        -3.0,
                        1210.0,
                        -3.0,
                        1210.0,
                        31.0,
                        1210.0,
                        -3.0,
                        1300.0,
                        -3.0,
                        1300.0,
                        31.0,
                        1300.0,
                        -3.0,
                        1356.0,
                        -3.0,
                        1356.0,
                        31.0,
                        1356.0,
                        -3.0,
                        1446.0,
                        -3.0,
                        1446.0,
                        31.0,
                        1446.0,
                        22.0,
                        1149.0,
                        22.0,
                        1149.0,
                        60.0,
                        1149.0,
                        22.0,
                        1239.0,
                        22.0,
                        1239.0,
                        60.0,
                        1239.0,
                        22.0,
                        1329.0,
                        22.0,
                        1329.0,
                        60.0,
                        1329.0,
                        22.0,
                        1327.0,
                        22.0,
                        1327.0,
                        60.0,
                        1327.0,
                        22.0,
                        1417.0,
                        22.0,
                        1417.0,
                        60.0,
                        1417.0,
                        22.0,
                        1507.0,
                        22.0,
                        1507.0,
                        60.0,
                        1507.0,
                        67.0,
                        1149.0,
                        67.0,
                        1149.0,
                        105.0,
                        1149.0,
                        67.0,
                        1239.0,
                        67.0,
                        1239.0,
                        105.0,
                        1239.0,
                        67.0,
                        1329.0,
                        67.0,
                        1329.0,
                        105.0,
                        1329.0,
                        67.0,
                        1327.0,
                        67.0,
                        1327.0,
                        105.0,
                        1327.0,
                        67.0,
                        1417.0,
                        67.0,
                        1417.0,
                        105.0,
                        1417.0,
                        67.0,
                        1507.0,
                        67.0,
                        1507.0,
                        105.0,
                        1507.0,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1123.0,
                        95.0,
                        1120.0,
                        95.0,
                        1120.0,
                        129.0,
                        1120.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1300.0,
                        95.0,
                        1300.0,
                        129.0,
                        1300.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1356.0,
                        95.0,
                        1446.0,
                        95.0,
                        1446.0,
                        129.0,
                        1446.0,
                        95.0,
                        1536.0,
                        95.0,
                        1536.0,
                        129.0,
                        1104.7272727272727,
                        129.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-86",
                        6
                    ],
                    "destination": [
                        "obj-78",
                        0
                    ],
                    "midpoints": [
                        3315.0,
                        158.0,
                        3315.0,
                        -3.0,
                        1553.0,
                        -3.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-79",
                        0
                    ],
                    "destination": [
                        "obj-86",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-86",
                        7
                    ],
                    "destination": [
                        "obj-79",
                        0
                    ],
                    "midpoints": [
                        1114.0,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1103.0,
                        123.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-80",
                        0
                    ],
                    "destination": [
                        "obj-86",
                        7
                    ],
                    "midpoints": [
                        1193.0,
                        95.0,
                        1120.0,
                        95.0,
                        1120.0,
                        129.0,
                        1117.8181818181818,
                        129.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-86",
                        8
                    ],
                    "destination": [
                        "obj-80",
                        0
                    ],
                    "midpoints": [
                        1120.0,
                        87.0,
                        1123.0,
                        87.0,
                        1123.0,
                        123.0,
                        1123.0,
                        95.0,
                        1120.0,
                        95.0,
                        1120.0,
                        129.0,
                        1193.0,
                        129.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-81",
                        0
                    ],
                    "destination": [
                        "obj-86",
                        8
                    ],
                    "midpoints": [
                        1283.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1124.3636363636363,
                        129.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-86",
                        9
                    ],
                    "destination": [
                        "obj-81",
                        0
                    ],
                    "midpoints": [
                        1126.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1283.0,
                        129.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-82",
                        0
                    ],
                    "destination": [
                        "obj-86",
                        9
                    ],
                    "midpoints": [
                        1373.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1266.0,
                        95.0,
                        1266.0,
                        129.0,
                        1130.909090909091,
                        129.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-86",
                        10
                    ],
                    "destination": [
                        "obj-82",
                        0
                    ],
                    "midpoints": [
                        1132.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1266.0,
                        95.0,
                        1266.0,
                        129.0,
                        1266.0,
                        142.0,
                        1342.0,
                        142.0,
                        1342.0,
                        180.0,
                        1373.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-83",
                        0
                    ],
                    "destination": [
                        "obj-86",
                        10
                    ],
                    "midpoints": [
                        1463.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1300.0,
                        95.0,
                        1300.0,
                        129.0,
                        1300.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1137.4545454545455,
                        129.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-86",
                        11
                    ],
                    "destination": [
                        "obj-83",
                        0
                    ],
                    "midpoints": [
                        1138.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1300.0,
                        95.0,
                        1300.0,
                        129.0,
                        1300.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1356.0,
                        142.0,
                        1342.0,
                        142.0,
                        1342.0,
                        180.0,
                        1463.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-84",
                        0
                    ],
                    "destination": [
                        "obj-86",
                        11
                    ],
                    "midpoints": [
                        1553.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1300.0,
                        95.0,
                        1300.0,
                        129.0,
                        1300.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1356.0,
                        95.0,
                        1446.0,
                        95.0,
                        1446.0,
                        129.0,
                        1144.0,
                        129.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-86",
                        12
                    ],
                    "destination": [
                        "obj-84",
                        0
                    ],
                    "midpoints": [
                        1144.0,
                        95.0,
                        1210.0,
                        95.0,
                        1210.0,
                        129.0,
                        1210.0,
                        95.0,
                        1300.0,
                        95.0,
                        1300.0,
                        129.0,
                        1300.0,
                        95.0,
                        1356.0,
                        95.0,
                        1356.0,
                        129.0,
                        1356.0,
                        95.0,
                        1446.0,
                        95.0,
                        1446.0,
                        129.0,
                        1446.0,
                        142.0,
                        1342.0,
                        142.0,
                        1342.0,
                        180.0,
                        1553.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-86",
                        0
                    ],
                    "destination": [
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        1072.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        142.0,
                        538.0,
                        142.0,
                        538.0,
                        180.0,
                        538.0,
                        142.0,
                        600.0,
                        142.0,
                        600.0,
                        180.0,
                        600.0,
                        142.0,
                        662.0,
                        142.0,
                        662.0,
                        180.0,
                        662.0,
                        142.0,
                        658.0,
                        142.0,
                        658.0,
                        180.0,
                        658.0,
                        142.0,
                        720.0,
                        142.0,
                        720.0,
                        180.0,
                        720.0,
                        142.0,
                        832.0,
                        142.0,
                        832.0,
                        180.0,
                        832.0,
                        157.0,
                        892.0,
                        157.0,
                        892.0,
                        195.0,
                        892.0,
                        157.0,
                        952.0,
                        157.0,
                        952.0,
                        195.0,
                        952.0,
                        187.0,
                        592.0,
                        187.0,
                        592.0,
                        225.0,
                        187.5,
                        225.0
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
                        "obj-88",
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
                        "obj-88",
                        0
                    ],
                    "destination": [
                        "obj-60",
                        0
                    ],
                    "midpoints": [
                        945.5,
                        348.5,
                        1027.0,
                        348.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-91",
                        0
                    ],
                    "destination": [
                        "obj-88",
                        1
                    ],
                    "midpoints": [
                        1357.0,
                        307.0,
                        1242.0,
                        307.0,
                        1242.0,
                        345.0,
                        945.5,
                        345.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-91",
                        1
                    ],
                    "destination": [
                        "obj-88",
                        2
                    ],
                    "midpoints": [
                        1393.0,
                        307.0,
                        1242.0,
                        307.0,
                        1242.0,
                        345.0,
                        999.0,
                        345.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-93",
                        0
                    ],
                    "destination": [
                        "obj-91",
                        0
                    ],
                    "midpoints": [
                        3347.0,
                        387.0,
                        3347.0,
                        307.0,
                        1357.0,
                        307.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-95",
                        0
                    ],
                    "destination": [
                        "obj-91",
                        1
                    ],
                    "midpoints": [
                        3355.0,
                        432.0,
                        3355.0,
                        307.0,
                        1371.4,
                        307.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-97",
                        0
                    ],
                    "destination": [
                        "obj-91",
                        2
                    ],
                    "midpoints": [
                        1402.0,
                        352.0,
                        1387.0,
                        352.0,
                        1387.0,
                        390.0,
                        1387.0,
                        397.0,
                        1387.0,
                        397.0,
                        1387.0,
                        435.0,
                        1387.0,
                        432.0,
                        1387.0,
                        432.0,
                        1387.0,
                        468.0,
                        1387.0,
                        462.0,
                        1394.0,
                        462.0,
                        1394.0,
                        498.0,
                        1385.8,
                        498.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-99",
                        0
                    ],
                    "destination": [
                        "obj-91",
                        3
                    ],
                    "midpoints": [
                        1402.0,
                        352.0,
                        1387.0,
                        352.0,
                        1387.0,
                        390.0,
                        1387.0,
                        397.0,
                        1387.0,
                        397.0,
                        1387.0,
                        435.0,
                        1387.0,
                        442.0,
                        1387.0,
                        442.0,
                        1387.0,
                        480.0,
                        1400.2,
                        480.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-101",
                        0
                    ],
                    "destination": [
                        "obj-104",
                        0
                    ],
                    "midpoints": [
                        3411.0,
                        567.0,
                        3411.0,
                        462.0,
                        1487.0,
                        462.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-103",
                        0
                    ],
                    "destination": [
                        "obj-105",
                        0
                    ],
                    "midpoints": [
                        3419.0,
                        612.0,
                        3419.0,
                        492.0,
                        1487.0,
                        492.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-104",
                        0
                    ],
                    "destination": [
                        "obj-88",
                        0
                    ],
                    "midpoints": [
                        3363.0,
                        497.0,
                        3363.0,
                        307.0,
                        892.0,
                        307.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-105",
                        0
                    ],
                    "destination": [
                        "obj-88",
                        0
                    ],
                    "midpoints": [
                        3371.0,
                        527.0,
                        3371.0,
                        307.0,
                        892.0,
                        307.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-106",
                        0
                    ],
                    "destination": [
                        "obj-107",
                        0
                    ],
                    "midpoints": [
                        1686.0,
                        348.5,
                        1766.5,
                        348.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-107",
                        0
                    ],
                    "destination": [
                        "obj-108",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-108",
                        0
                    ],
                    "destination": [
                        "obj-93",
                        0
                    ],
                    "midpoints": [
                        3395.0,
                        437.0,
                        3395.0,
                        352.0,
                        1420.0,
                        352.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-107",
                        1
                    ],
                    "destination": [
                        "obj-109",
                        0
                    ],
                    "midpoints": [
                        1676.909090909091,
                        402.0,
                        1698.0,
                        402.0,
                        1698.0,
                        440.0,
                        1717.0,
                        440.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-109",
                        0
                    ],
                    "destination": [
                        "obj-95",
                        0
                    ],
                    "midpoints": [
                        1730.0,
                        402.0,
                        1642.0,
                        402.0,
                        1642.0,
                        440.0,
                        1420.0,
                        440.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-107",
                        2
                    ],
                    "destination": [
                        "obj-110",
                        0
                    ],
                    "midpoints": [
                        1696.8181818181818,
                        402.0,
                        1698.0,
                        402.0,
                        1698.0,
                        440.0,
                        1698.0,
                        402.0,
                        1758.0,
                        402.0,
                        1758.0,
                        440.0,
                        1777.0,
                        440.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-110",
                        0
                    ],
                    "destination": [
                        "obj-97",
                        0
                    ],
                    "midpoints": [
                        1790.0,
                        402.0,
                        1642.0,
                        402.0,
                        1642.0,
                        440.0,
                        1642.0,
                        402.0,
                        1702.0,
                        402.0,
                        1702.0,
                        440.0,
                        1702.0,
                        442.0,
                        1612.0,
                        442.0,
                        1612.0,
                        480.0,
                        1420.0,
                        480.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-107",
                        3
                    ],
                    "destination": [
                        "obj-111",
                        0
                    ],
                    "midpoints": [
                        1716.7272727272727,
                        402.0,
                        1758.0,
                        402.0,
                        1758.0,
                        440.0,
                        1758.0,
                        402.0,
                        1762.0,
                        402.0,
                        1762.0,
                        440.0,
                        1837.0,
                        440.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-111",
                        0
                    ],
                    "destination": [
                        "obj-99",
                        0
                    ],
                    "midpoints": [
                        1852.0,
                        402.0,
                        1642.0,
                        402.0,
                        1642.0,
                        440.0,
                        1642.0,
                        402.0,
                        1702.0,
                        402.0,
                        1702.0,
                        440.0,
                        1702.0,
                        402.0,
                        1762.0,
                        402.0,
                        1762.0,
                        440.0,
                        1762.0,
                        442.0,
                        1453.0,
                        442.0,
                        1453.0,
                        480.0,
                        1453.0,
                        442.0,
                        1612.0,
                        442.0,
                        1612.0,
                        480.0,
                        1612.0,
                        462.0,
                        1560.0,
                        462.0,
                        1560.0,
                        500.0,
                        1420.0,
                        500.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-107",
                        4
                    ],
                    "destination": [
                        "obj-112",
                        0
                    ],
                    "midpoints": [
                        1736.6363636363637,
                        402.0,
                        1758.0,
                        402.0,
                        1758.0,
                        440.0,
                        1758.0,
                        402.0,
                        1818.0,
                        402.0,
                        1818.0,
                        440.0,
                        1818.0,
                        402.0,
                        1822.0,
                        402.0,
                        1822.0,
                        440.0,
                        1897.0,
                        440.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-112",
                        0
                    ],
                    "destination": [
                        "obj-101",
                        0
                    ],
                    "midpoints": [
                        1910.0,
                        402.0,
                        1642.0,
                        402.0,
                        1642.0,
                        440.0,
                        1642.0,
                        402.0,
                        1702.0,
                        402.0,
                        1702.0,
                        440.0,
                        1702.0,
                        402.0,
                        1762.0,
                        402.0,
                        1762.0,
                        440.0,
                        1762.0,
                        402.0,
                        1822.0,
                        402.0,
                        1822.0,
                        440.0,
                        1822.0,
                        442.0,
                        1453.0,
                        442.0,
                        1453.0,
                        480.0,
                        1453.0,
                        442.0,
                        1612.0,
                        442.0,
                        1612.0,
                        480.0,
                        1612.0,
                        462.0,
                        1560.0,
                        462.0,
                        1560.0,
                        500.0,
                        1560.0,
                        487.0,
                        1453.0,
                        487.0,
                        1453.0,
                        525.0,
                        1453.0,
                        492.0,
                        1560.0,
                        492.0,
                        1560.0,
                        530.0,
                        1560.0,
                        532.0,
                        1728.0,
                        532.0,
                        1728.0,
                        568.0,
                        1420.0,
                        568.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-107",
                        5
                    ],
                    "destination": [
                        "obj-113",
                        0
                    ],
                    "midpoints": [
                        1756.5454545454545,
                        402.0,
                        1758.0,
                        402.0,
                        1758.0,
                        440.0,
                        1758.0,
                        402.0,
                        1818.0,
                        402.0,
                        1818.0,
                        440.0,
                        1818.0,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1957.0,
                        440.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-113",
                        0
                    ],
                    "destination": [
                        "obj-103",
                        0
                    ],
                    "midpoints": [
                        1970.0,
                        402.0,
                        1698.0,
                        402.0,
                        1698.0,
                        440.0,
                        1698.0,
                        402.0,
                        1702.0,
                        402.0,
                        1702.0,
                        440.0,
                        1702.0,
                        402.0,
                        1762.0,
                        402.0,
                        1762.0,
                        440.0,
                        1762.0,
                        402.0,
                        1822.0,
                        402.0,
                        1822.0,
                        440.0,
                        1822.0,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        442.0,
                        1453.0,
                        442.0,
                        1453.0,
                        480.0,
                        1453.0,
                        442.0,
                        1749.0,
                        442.0,
                        1749.0,
                        480.0,
                        1749.0,
                        462.0,
                        1560.0,
                        462.0,
                        1560.0,
                        500.0,
                        1560.0,
                        487.0,
                        1453.0,
                        487.0,
                        1453.0,
                        525.0,
                        1453.0,
                        492.0,
                        1560.0,
                        492.0,
                        1560.0,
                        530.0,
                        1560.0,
                        532.0,
                        1453.0,
                        532.0,
                        1453.0,
                        570.0,
                        1453.0,
                        532.0,
                        1728.0,
                        532.0,
                        1728.0,
                        568.0,
                        1728.0,
                        562.0,
                        1712.0,
                        562.0,
                        1712.0,
                        598.0,
                        1712.0,
                        562.0,
                        1807.0,
                        562.0,
                        1807.0,
                        600.0,
                        1807.0,
                        562.0,
                        1872.0,
                        562.0,
                        1872.0,
                        600.0,
                        1420.0,
                        600.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-4",
                        4
                    ],
                    "destination": [
                        "obj-115",
                        0
                    ],
                    "midpoints": [
                        248.0,
                        262.0,
                        112.0,
                        262.0,
                        112.0,
                        300.0,
                        112.0,
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
                        232.0,
                        352.0,
                        277.0,
                        352.0,
                        277.0,
                        390.0,
                        277.0,
                        397.0,
                        277.0,
                        397.0,
                        277.0,
                        435.0,
                        194.5,
                        435.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-115",
                        0
                    ],
                    "destination": [
                        "obj-116",
                        0
                    ],
                    "midpoints": [
                        194.5,
                        442.0,
                        877.0,
                        442.0,
                        877.0,
                        480.0,
                        877.0,
                        442.0,
                        1087.0,
                        442.0,
                        1087.0,
                        480.0,
                        1087.0,
                        452.0,
                        1152.0,
                        452.0,
                        1152.0,
                        490.0,
                        1152.0,
                        462.0,
                        1292.0,
                        462.0,
                        1292.0,
                        498.0,
                        1292.0,
                        472.0,
                        892.0,
                        472.0,
                        892.0,
                        510.0,
                        892.0,
                        487.0,
                        1087.0,
                        487.0,
                        1087.0,
                        525.0,
                        1087.0,
                        492.0,
                        1292.0,
                        492.0,
                        1292.0,
                        528.0,
                        1292.0,
                        512.0,
                        877.0,
                        512.0,
                        877.0,
                        550.0,
                        877.0,
                        512.0,
                        1087.0,
                        512.0,
                        1087.0,
                        550.0,
                        1087.0,
                        517.0,
                        570.0,
                        517.0,
                        570.0,
                        673.0,
                        570.0,
                        517.0,
                        593.0,
                        517.0,
                        593.0,
                        633.0,
                        593.0,
                        517.0,
                        630.0,
                        517.0,
                        630.0,
                        673.0,
                        630.0,
                        517.0,
                        653.0,
                        517.0,
                        653.0,
                        633.0,
                        1312.5,
                        633.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-116",
                        0
                    ],
                    "destination": [
                        "obj-117",
                        0
                    ],
                    "midpoints": [
                        1312.5,
                        577.0,
                        1304.0,
                        577.0,
                        1304.0,
                        615.0,
                        1252.0,
                        615.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-88",
                        0
                    ],
                    "destination": [
                        "obj-118",
                        0
                    ],
                    "midpoints": [
                        945.5,
                        307.0,
                        1042.0,
                        307.0,
                        1042.0,
                        345.0,
                        1042.0,
                        352.0,
                        1079.0,
                        352.0,
                        1079.0,
                        390.0,
                        1079.0,
                        397.0,
                        1027.0,
                        397.0,
                        1027.0,
                        435.0,
                        1027.0,
                        437.0,
                        1096.0,
                        437.0,
                        1096.0,
                        475.0,
                        1096.0,
                        442.0,
                        1087.0,
                        442.0,
                        1087.0,
                        480.0,
                        1087.0,
                        452.0,
                        1152.0,
                        452.0,
                        1152.0,
                        490.0,
                        1152.0,
                        472.0,
                        966.0,
                        472.0,
                        966.0,
                        510.0,
                        966.0,
                        487.0,
                        1087.0,
                        487.0,
                        1087.0,
                        525.0,
                        1087.0,
                        512.0,
                        993.0,
                        512.0,
                        993.0,
                        550.0,
                        993.0,
                        512.0,
                        1087.0,
                        512.0,
                        1087.0,
                        550.0,
                        1087.0,
                        532.0,
                        1237.0,
                        532.0,
                        1237.0,
                        570.0,
                        1252.0,
                        570.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-117",
                        0
                    ],
                    "destination": [
                        "obj-118",
                        1
                    ],
                    "midpoints": [
                        3427.0,
                        657.0,
                        3427.0,
                        577.0,
                        1289.0,
                        577.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-118",
                        0
                    ],
                    "destination": [
                        "obj-119",
                        0
                    ],
                    "midpoints": [
                        1270.5,
                        622.0,
                        1237.0,
                        622.0,
                        1237.0,
                        660.0,
                        1252.0,
                        660.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-119",
                        0
                    ],
                    "destination": [
                        "obj-120",
                        0
                    ],
                    "midpoints": [
                        3403.0,
                        702.0,
                        3403.0,
                        442.0,
                        1102.0,
                        442.0
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
                        "obj-120",
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
                        883.0,
                        307.0,
                        883.0,
                        345.0,
                        883.0,
                        307.0,
                        1042.0,
                        307.0,
                        1042.0,
                        345.0,
                        1042.0,
                        307.0,
                        877.0,
                        307.0,
                        877.0,
                        345.0,
                        877.0,
                        352.0,
                        1012.0,
                        352.0,
                        1012.0,
                        390.0,
                        1012.0,
                        352.0,
                        804.0,
                        352.0,
                        804.0,
                        390.0,
                        804.0,
                        387.0,
                        741.0,
                        387.0,
                        741.0,
                        425.0,
                        741.0,
                        397.0,
                        1027.0,
                        397.0,
                        1027.0,
                        435.0,
                        1027.0,
                        437.0,
                        952.0,
                        437.0,
                        952.0,
                        475.0,
                        952.0,
                        442.0,
                        877.0,
                        442.0,
                        877.0,
                        480.0,
                        1130.0,
                        480.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-121",
                        0
                    ],
                    "destination": [
                        "obj-122",
                        0
                    ],
                    "midpoints": [
                        1124.0,
                        512.0,
                        877.0,
                        512.0,
                        877.0,
                        550.0,
                        877.0,
                        512.0,
                        1087.0,
                        512.0,
                        1087.0,
                        550.0,
                        1087.0,
                        517.0,
                        653.0,
                        517.0,
                        653.0,
                        633.0,
                        611.0,
                        633.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-122",
                        0
                    ],
                    "destination": [
                        "obj-123",
                        0
                    ],
                    "midpoints": [
                        652.0,
                        670.0,
                        652.0,
                        517.0,
                        637.5,
                        517.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-122",
                        0
                    ],
                    "destination": [
                        "obj-67",
                        1
                    ],
                    "midpoints": [
                        607.0,
                        517.0,
                        570.0,
                        517.0,
                        570.0,
                        673.0,
                        563.0,
                        673.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-65",
                        1
                    ],
                    "destination": [
                        "obj-122",
                        0
                    ],
                    "midpoints": [
                        629.0,
                        670.0,
                        629.0,
                        517.0,
                        611.0,
                        517.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-124",
                        0
                    ],
                    "destination": [
                        "obj-15",
                        5
                    ],
                    "midpoints": [
                        847.0,
                        142.0,
                        662.0,
                        142.0,
                        662.0,
                        180.0,
                        662.0,
                        142.0,
                        724.0,
                        142.0,
                        724.0,
                        180.0,
                        724.0,
                        142.0,
                        720.0,
                        142.0,
                        720.0,
                        180.0,
                        658.4285714285714,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-126",
                        0
                    ],
                    "destination": [
                        "obj-15",
                        6
                    ],
                    "midpoints": [
                        907.0,
                        191.0,
                        668.7142857142858,
                        191.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-128",
                        0
                    ],
                    "destination": [
                        "obj-15",
                        7
                    ],
                    "midpoints": [
                        967.0,
                        157.0,
                        892.0,
                        157.0,
                        892.0,
                        195.0,
                        679.0,
                        195.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-68",
                        7
                    ],
                    "destination": [
                        "obj-124",
                        0
                    ],
                    "midpoints": [
                        168.0,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        479.0,
                        87.0,
                        832.0,
                        87.0,
                        832.0,
                        123.0,
                        832.0,
                        112.0,
                        832.0,
                        112.0,
                        832.0,
                        148.0,
                        832.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        142.0,
                        538.0,
                        142.0,
                        538.0,
                        180.0,
                        538.0,
                        142.0,
                        534.0,
                        142.0,
                        534.0,
                        180.0,
                        534.0,
                        142.0,
                        596.0,
                        142.0,
                        596.0,
                        180.0,
                        596.0,
                        142.0,
                        658.0,
                        142.0,
                        658.0,
                        180.0,
                        658.0,
                        142.0,
                        720.0,
                        142.0,
                        720.0,
                        180.0,
                        865.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-68",
                        8
                    ],
                    "destination": [
                        "obj-126",
                        0
                    ],
                    "midpoints": [
                        176.0,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        479.0,
                        87.0,
                        832.0,
                        87.0,
                        832.0,
                        123.0,
                        832.0,
                        112.0,
                        832.0,
                        112.0,
                        832.0,
                        148.0,
                        832.0,
                        112.0,
                        894.0,
                        112.0,
                        894.0,
                        148.0,
                        894.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        142.0,
                        538.0,
                        142.0,
                        538.0,
                        180.0,
                        538.0,
                        142.0,
                        534.0,
                        142.0,
                        534.0,
                        180.0,
                        534.0,
                        142.0,
                        596.0,
                        142.0,
                        596.0,
                        180.0,
                        596.0,
                        142.0,
                        658.0,
                        142.0,
                        658.0,
                        180.0,
                        658.0,
                        142.0,
                        720.0,
                        142.0,
                        720.0,
                        180.0,
                        720.0,
                        142.0,
                        832.0,
                        142.0,
                        832.0,
                        180.0,
                        925.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-68",
                        9
                    ],
                    "destination": [
                        "obj-128",
                        0
                    ],
                    "midpoints": [
                        184.0,
                        82.0,
                        479.0,
                        82.0,
                        479.0,
                        151.0,
                        479.0,
                        87.0,
                        832.0,
                        87.0,
                        832.0,
                        123.0,
                        832.0,
                        95.0,
                        947.0,
                        95.0,
                        947.0,
                        131.0,
                        947.0,
                        112.0,
                        832.0,
                        112.0,
                        832.0,
                        148.0,
                        832.0,
                        112.0,
                        894.0,
                        112.0,
                        894.0,
                        148.0,
                        894.0,
                        112.0,
                        956.0,
                        112.0,
                        956.0,
                        148.0,
                        956.0,
                        120.0,
                        947.0,
                        120.0,
                        947.0,
                        156.0,
                        947.0,
                        142.0,
                        231.0,
                        142.0,
                        231.0,
                        180.0,
                        231.0,
                        142.0,
                        538.0,
                        142.0,
                        538.0,
                        180.0,
                        538.0,
                        142.0,
                        600.0,
                        142.0,
                        600.0,
                        180.0,
                        600.0,
                        142.0,
                        596.0,
                        142.0,
                        596.0,
                        180.0,
                        596.0,
                        142.0,
                        658.0,
                        142.0,
                        658.0,
                        180.0,
                        658.0,
                        142.0,
                        720.0,
                        142.0,
                        720.0,
                        180.0,
                        720.0,
                        142.0,
                        832.0,
                        142.0,
                        832.0,
                        180.0,
                        832.0,
                        157.0,
                        892.0,
                        157.0,
                        892.0,
                        195.0,
                        985.0,
                        195.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-134",
                        1
                    ],
                    "destination": [
                        "obj-136",
                        0
                    ],
                    "midpoints": [
                        1712.5,
                        307.0,
                        1730.0,
                        307.0,
                        1730.0,
                        345.0,
                        1730.0,
                        352.0,
                        1642.0,
                        352.0,
                        1642.0,
                        390.0,
                        1642.0,
                        402.0,
                        1698.0,
                        402.0,
                        1698.0,
                        440.0,
                        1698.0,
                        402.0,
                        1702.0,
                        402.0,
                        1702.0,
                        440.0,
                        1680.5,
                        440.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-136",
                        0
                    ],
                    "destination": [
                        "obj-89",
                        0
                    ],
                    "midpoints": [
                        3323.0,
                        477.0,
                        3323.0,
                        232.0,
                        1446.0,
                        232.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-135",
                        1
                    ],
                    "destination": [
                        "obj-137",
                        0
                    ],
                    "midpoints": [
                        1907.5,
                        288.5,
                        1875.5,
                        288.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-137",
                        0
                    ],
                    "destination": [
                        "obj-131",
                        0
                    ],
                    "midpoints": [
                        1875.5,
                        307.0,
                        1642.0,
                        307.0,
                        1642.0,
                        345.0,
                        1642.0,
                        352.0,
                        1453.0,
                        352.0,
                        1453.0,
                        390.0,
                        1453.0,
                        352.0,
                        1642.0,
                        352.0,
                        1642.0,
                        390.0,
                        1642.0,
                        397.0,
                        1453.0,
                        397.0,
                        1453.0,
                        435.0,
                        1453.0,
                        402.0,
                        1642.0,
                        402.0,
                        1642.0,
                        440.0,
                        1642.0,
                        402.0,
                        1702.0,
                        402.0,
                        1702.0,
                        440.0,
                        1702.0,
                        402.0,
                        1762.0,
                        402.0,
                        1762.0,
                        440.0,
                        1762.0,
                        402.0,
                        1822.0,
                        402.0,
                        1822.0,
                        440.0,
                        1822.0,
                        442.0,
                        1453.0,
                        442.0,
                        1453.0,
                        480.0,
                        1453.0,
                        442.0,
                        1612.0,
                        442.0,
                        1612.0,
                        480.0,
                        1612.0,
                        462.0,
                        1560.0,
                        462.0,
                        1560.0,
                        500.0,
                        1560.0,
                        487.0,
                        1453.0,
                        487.0,
                        1453.0,
                        525.0,
                        1453.0,
                        492.0,
                        1560.0,
                        492.0,
                        1560.0,
                        530.0,
                        1560.0,
                        532.0,
                        1453.0,
                        532.0,
                        1453.0,
                        570.0,
                        1453.0,
                        532.0,
                        1728.0,
                        532.0,
                        1728.0,
                        568.0,
                        1728.0,
                        562.0,
                        1712.0,
                        562.0,
                        1712.0,
                        598.0,
                        1712.0,
                        562.0,
                        1807.0,
                        562.0,
                        1807.0,
                        600.0,
                        1807.0,
                        562.0,
                        1872.0,
                        562.0,
                        1872.0,
                        600.0,
                        1872.0,
                        577.0,
                        1453.0,
                        577.0,
                        1453.0,
                        615.0,
                        1453.0,
                        582.0,
                        1609.0,
                        582.0,
                        1609.0,
                        620.0,
                        1609.0,
                        582.0,
                        1729.0,
                        582.0,
                        1729.0,
                        620.0,
                        1729.0,
                        607.0,
                        1712.0,
                        607.0,
                        1712.0,
                        643.0,
                        1712.0,
                        607.0,
                        1807.0,
                        607.0,
                        1807.0,
                        645.0,
                        1807.0,
                        607.0,
                        1872.0,
                        607.0,
                        1872.0,
                        645.0,
                        1872.0,
                        632.0,
                        1609.0,
                        632.0,
                        1609.0,
                        670.0,
                        1609.0,
                        652.0,
                        1712.0,
                        652.0,
                        1712.0,
                        688.0,
                        1712.0,
                        652.0,
                        1807.0,
                        652.0,
                        1807.0,
                        690.0,
                        1807.0,
                        652.0,
                        1872.0,
                        652.0,
                        1872.0,
                        690.0,
                        1872.0,
                        697.0,
                        1712.0,
                        697.0,
                        1712.0,
                        733.0,
                        1712.0,
                        697.0,
                        1807.0,
                        697.0,
                        1807.0,
                        735.0,
                        1807.0,
                        697.0,
                        1872.0,
                        697.0,
                        1872.0,
                        735.0,
                        1872.0,
                        712.0,
                        1595.0,
                        712.0,
                        1595.0,
                        750.0,
                        1595.0,
                        712.0,
                        1715.0,
                        712.0,
                        1715.0,
                        750.0,
                        1446.0,
                        750.0
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
                        "obj-139",
                        0
                    ],
                    "midpoints": [
                        906.0,
                        472.0,
                        892.0,
                        472.0,
                        892.0,
                        510.0,
                        935.0,
                        510.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-120",
                        0
                    ],
                    "destination": [
                        "obj-140",
                        0
                    ],
                    "midpoints": [
                        1116.0,
                        487.0,
                        1161.0,
                        487.0,
                        1161.0,
                        525.0,
                        1145.0,
                        525.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-141",
                        0
                    ],
                    "destination": [
                        "obj-138",
                        0
                    ],
                    "midpoints": [
                        1540.5,
                        626.0,
                        1487.0,
                        626.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-142",
                        0
                    ],
                    "destination": [
                        "obj-138",
                        1
                    ],
                    "midpoints": [
                        1660.5,
                        582.0,
                        1609.0,
                        582.0,
                        1609.0,
                        620.0,
                        1540.5,
                        620.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-91",
                        2
                    ],
                    "destination": [
                        "obj-138",
                        2
                    ],
                    "midpoints": [
                        1429.0,
                        352.0,
                        1453.0,
                        352.0,
                        1453.0,
                        390.0,
                        1453.0,
                        397.0,
                        1453.0,
                        397.0,
                        1453.0,
                        435.0,
                        1453.0,
                        442.0,
                        1453.0,
                        442.0,
                        1453.0,
                        480.0,
                        1453.0,
                        462.0,
                        1472.0,
                        462.0,
                        1472.0,
                        500.0,
                        1472.0,
                        487.0,
                        1453.0,
                        487.0,
                        1453.0,
                        525.0,
                        1453.0,
                        492.0,
                        1472.0,
                        492.0,
                        1472.0,
                        530.0,
                        1472.0,
                        532.0,
                        1453.0,
                        532.0,
                        1453.0,
                        570.0,
                        1453.0,
                        532.0,
                        1472.0,
                        532.0,
                        1472.0,
                        568.0,
                        1472.0,
                        577.0,
                        1453.0,
                        577.0,
                        1453.0,
                        615.0,
                        1453.0,
                        582.0,
                        1472.0,
                        582.0,
                        1472.0,
                        620.0,
                        1472.0,
                        582.0,
                        1592.0,
                        582.0,
                        1592.0,
                        620.0,
                        1592.0,
                        622.0,
                        1437.0,
                        622.0,
                        1437.0,
                        660.0,
                        1594.0,
                        660.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-138",
                        0
                    ],
                    "destination": [
                        "obj-143",
                        0
                    ],
                    "midpoints": [
                        1487.0,
                        712.0,
                        1595.0,
                        712.0,
                        1595.0,
                        750.0,
                        1533.5,
                        750.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-138",
                        1
                    ],
                    "destination": [
                        "obj-144",
                        0
                    ],
                    "midpoints": [
                        1594.0,
                        712.0,
                        1595.0,
                        712.0,
                        1595.0,
                        750.0,
                        1595.0,
                        712.0,
                        1595.0,
                        712.0,
                        1595.0,
                        750.0,
                        1653.5,
                        750.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-145",
                        0
                    ],
                    "destination": [
                        "obj-64",
                        0
                    ],
                    "midpoints": [
                        1024.0,
                        442.0,
                        935.0,
                        442.0,
                        935.0,
                        480.0,
                        907.0,
                        480.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-146",
                        0
                    ],
                    "destination": [
                        "obj-121",
                        0
                    ],
                    "midpoints": [
                        1224.0,
                        488.5,
                        1102.0,
                        488.5
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
                        "obj-147",
                        0
                    ],
                    "midpoints": [
                        187.5,
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
                        262.0,
                        667.0,
                        262.0,
                        667.0,
                        300.0,
                        667.0,
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
                        622.0,
                        307.0,
                        682.0,
                        307.0,
                        682.0,
                        345.0,
                        682.0,
                        352.0,
                        277.0,
                        352.0,
                        277.0,
                        390.0,
                        682.0,
                        390.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-147",
                        0
                    ],
                    "destination": [
                        "obj-148",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-148",
                        0
                    ],
                    "destination": [
                        "obj-138",
                        0
                    ],
                    "midpoints": [
                        704.0,
                        397.0,
                        1027.0,
                        397.0,
                        1027.0,
                        435.0,
                        1027.0,
                        397.0,
                        1387.0,
                        397.0,
                        1387.0,
                        435.0,
                        1387.0,
                        402.0,
                        1292.0,
                        402.0,
                        1292.0,
                        438.0,
                        1292.0,
                        432.0,
                        1292.0,
                        432.0,
                        1292.0,
                        468.0,
                        1292.0,
                        437.0,
                        1096.0,
                        437.0,
                        1096.0,
                        475.0,
                        1096.0,
                        442.0,
                        935.0,
                        442.0,
                        935.0,
                        480.0,
                        935.0,
                        442.0,
                        1387.0,
                        442.0,
                        1387.0,
                        480.0,
                        1387.0,
                        442.0,
                        1087.0,
                        442.0,
                        1087.0,
                        480.0,
                        1087.0,
                        452.0,
                        1152.0,
                        452.0,
                        1152.0,
                        490.0,
                        1152.0,
                        462.0,
                        1292.0,
                        462.0,
                        1292.0,
                        498.0,
                        1292.0,
                        462.0,
                        1472.0,
                        462.0,
                        1472.0,
                        500.0,
                        1472.0,
                        472.0,
                        966.0,
                        472.0,
                        966.0,
                        510.0,
                        966.0,
                        487.0,
                        1387.0,
                        487.0,
                        1387.0,
                        525.0,
                        1387.0,
                        487.0,
                        1087.0,
                        487.0,
                        1087.0,
                        525.0,
                        1087.0,
                        492.0,
                        1292.0,
                        492.0,
                        1292.0,
                        528.0,
                        1292.0,
                        492.0,
                        1472.0,
                        492.0,
                        1472.0,
                        530.0,
                        1472.0,
                        512.0,
                        993.0,
                        512.0,
                        993.0,
                        550.0,
                        993.0,
                        512.0,
                        1087.0,
                        512.0,
                        1087.0,
                        550.0,
                        1087.0,
                        532.0,
                        1387.0,
                        532.0,
                        1387.0,
                        570.0,
                        1387.0,
                        532.0,
                        1237.0,
                        532.0,
                        1237.0,
                        570.0,
                        1237.0,
                        532.0,
                        1472.0,
                        532.0,
                        1472.0,
                        568.0,
                        1472.0,
                        577.0,
                        1387.0,
                        577.0,
                        1387.0,
                        615.0,
                        1387.0,
                        577.0,
                        1237.0,
                        577.0,
                        1237.0,
                        615.0,
                        1237.0,
                        582.0,
                        1472.0,
                        582.0,
                        1472.0,
                        620.0,
                        1472.0,
                        622.0,
                        1237.0,
                        622.0,
                        1237.0,
                        660.0,
                        1487.0,
                        660.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-151",
                        0
                    ],
                    "destination": [
                        "obj-152",
                        0
                    ],
                    "midpoints": [
                        1966.0,
                        597.0,
                        1966.0,
                        562.0,
                        1887.0,
                        562.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-152",
                        0
                    ],
                    "destination": [
                        "obj-138",
                        0
                    ],
                    "midpoints": [
                        1919.5,
                        562.0,
                        1712.0,
                        562.0,
                        1712.0,
                        598.0,
                        1712.0,
                        562.0,
                        1807.0,
                        562.0,
                        1807.0,
                        600.0,
                        1807.0,
                        582.0,
                        1609.0,
                        582.0,
                        1609.0,
                        620.0,
                        1609.0,
                        582.0,
                        1729.0,
                        582.0,
                        1729.0,
                        620.0,
                        1729.0,
                        607.0,
                        1712.0,
                        607.0,
                        1712.0,
                        643.0,
                        1712.0,
                        607.0,
                        1807.0,
                        607.0,
                        1807.0,
                        645.0,
                        1807.0,
                        607.0,
                        1872.0,
                        607.0,
                        1872.0,
                        645.0,
                        1487.0,
                        645.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-154",
                        0
                    ],
                    "destination": [
                        "obj-155",
                        0
                    ],
                    "midpoints": [
                        1945.0,
                        642.0,
                        1945.0,
                        607.0,
                        1887.0,
                        607.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-155",
                        0
                    ],
                    "destination": [
                        "obj-138",
                        0
                    ],
                    "midpoints": [
                        1909.0,
                        607.0,
                        1712.0,
                        607.0,
                        1712.0,
                        643.0,
                        1712.0,
                        607.0,
                        1807.0,
                        607.0,
                        1807.0,
                        645.0,
                        1487.0,
                        645.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-157",
                        0
                    ],
                    "destination": [
                        "obj-158",
                        0
                    ],
                    "midpoints": [
                        1980.0,
                        687.0,
                        1980.0,
                        652.0,
                        1887.0,
                        652.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-158",
                        0
                    ],
                    "destination": [
                        "obj-138",
                        0
                    ],
                    "midpoints": [
                        1926.5,
                        607.0,
                        1807.0,
                        607.0,
                        1807.0,
                        645.0,
                        1807.0,
                        607.0,
                        1872.0,
                        607.0,
                        1872.0,
                        645.0,
                        1872.0,
                        652.0,
                        1712.0,
                        652.0,
                        1712.0,
                        688.0,
                        1712.0,
                        652.0,
                        1807.0,
                        652.0,
                        1807.0,
                        690.0,
                        1487.0,
                        690.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-160",
                        0
                    ],
                    "destination": [
                        "obj-161",
                        0
                    ],
                    "midpoints": [
                        1987.0,
                        732.0,
                        1987.0,
                        697.0,
                        1887.0,
                        697.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-161",
                        0
                    ],
                    "destination": [
                        "obj-138",
                        0
                    ],
                    "midpoints": [
                        3435.0,
                        732.0,
                        3435.0,
                        632.0,
                        1487.0,
                        632.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-163",
                        0
                    ],
                    "destination": [
                        "obj-91",
                        4
                    ],
                    "midpoints": [
                        3379.0,
                        777.0,
                        3379.0,
                        307.0,
                        1414.6,
                        307.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-165",
                        0
                    ],
                    "destination": [
                        "obj-91",
                        5
                    ],
                    "midpoints": [
                        3387.0,
                        822.0,
                        3387.0,
                        307.0,
                        1429.0,
                        307.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-107",
                        6
                    ],
                    "destination": [
                        "obj-166",
                        0
                    ],
                    "midpoints": [
                        1776.4545454545455,
                        402.0,
                        1818.0,
                        402.0,
                        1818.0,
                        440.0,
                        1818.0,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1942.0,
                        402.0,
                        1942.0,
                        440.0,
                        2017.0,
                        440.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-166",
                        0
                    ],
                    "destination": [
                        "obj-163",
                        0
                    ],
                    "midpoints": [
                        2030.0,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1942.0,
                        402.0,
                        1942.0,
                        440.0,
                        1942.0,
                        562.0,
                        1873.0,
                        562.0,
                        1873.0,
                        600.0,
                        1873.0,
                        562.0,
                        1967.0,
                        562.0,
                        1967.0,
                        600.0,
                        1967.0,
                        607.0,
                        1873.0,
                        607.0,
                        1873.0,
                        645.0,
                        1873.0,
                        607.0,
                        1946.0,
                        607.0,
                        1946.0,
                        645.0,
                        1946.0,
                        652.0,
                        1842.0,
                        652.0,
                        1842.0,
                        688.0,
                        1842.0,
                        652.0,
                        1873.0,
                        652.0,
                        1873.0,
                        690.0,
                        1873.0,
                        652.0,
                        1981.0,
                        652.0,
                        1981.0,
                        690.0,
                        1981.0,
                        697.0,
                        1873.0,
                        697.0,
                        1873.0,
                        735.0,
                        1873.0,
                        697.0,
                        1988.0,
                        697.0,
                        1988.0,
                        735.0,
                        1840.0,
                        735.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-107",
                        7
                    ],
                    "destination": [
                        "obj-167",
                        0
                    ],
                    "midpoints": [
                        1796.3636363636365,
                        402.0,
                        1818.0,
                        402.0,
                        1818.0,
                        440.0,
                        1818.0,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1942.0,
                        402.0,
                        1942.0,
                        440.0,
                        1942.0,
                        402.0,
                        2002.0,
                        402.0,
                        2002.0,
                        440.0,
                        2077.0,
                        440.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-167",
                        0
                    ],
                    "destination": [
                        "obj-165",
                        0
                    ],
                    "midpoints": [
                        2090.0,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1942.0,
                        402.0,
                        1942.0,
                        440.0,
                        1942.0,
                        402.0,
                        2002.0,
                        402.0,
                        2002.0,
                        440.0,
                        2002.0,
                        562.0,
                        1873.0,
                        562.0,
                        1873.0,
                        600.0,
                        1873.0,
                        562.0,
                        1967.0,
                        562.0,
                        1967.0,
                        600.0,
                        1967.0,
                        607.0,
                        1873.0,
                        607.0,
                        1873.0,
                        645.0,
                        1873.0,
                        607.0,
                        1946.0,
                        607.0,
                        1946.0,
                        645.0,
                        1946.0,
                        652.0,
                        1842.0,
                        652.0,
                        1842.0,
                        688.0,
                        1842.0,
                        652.0,
                        1873.0,
                        652.0,
                        1873.0,
                        690.0,
                        1873.0,
                        652.0,
                        1981.0,
                        652.0,
                        1981.0,
                        690.0,
                        1981.0,
                        697.0,
                        1873.0,
                        697.0,
                        1873.0,
                        735.0,
                        1873.0,
                        697.0,
                        1988.0,
                        697.0,
                        1988.0,
                        735.0,
                        1988.0,
                        742.0,
                        1873.0,
                        742.0,
                        1873.0,
                        780.0,
                        1840.0,
                        780.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-107",
                        8
                    ],
                    "destination": [
                        "obj-168",
                        0
                    ],
                    "midpoints": [
                        1816.2727272727273,
                        402.0,
                        1818.0,
                        402.0,
                        1818.0,
                        440.0,
                        1818.0,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2002.0,
                        402.0,
                        2002.0,
                        440.0,
                        2002.0,
                        402.0,
                        2062.0,
                        402.0,
                        2062.0,
                        440.0,
                        2137.0,
                        440.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-168",
                        0
                    ],
                    "destination": [
                        "obj-151",
                        0
                    ],
                    "midpoints": [
                        2155.5,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2002.0,
                        402.0,
                        2002.0,
                        440.0,
                        2002.0,
                        402.0,
                        2062.0,
                        402.0,
                        2062.0,
                        440.0,
                        2062.0,
                        562.0,
                        1967.0,
                        562.0,
                        1967.0,
                        600.0,
                        1840.0,
                        600.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-107",
                        9
                    ],
                    "destination": [
                        "obj-169",
                        0
                    ],
                    "midpoints": [
                        1836.1818181818182,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2002.0,
                        402.0,
                        2002.0,
                        440.0,
                        2002.0,
                        402.0,
                        2062.0,
                        402.0,
                        2062.0,
                        440.0,
                        2062.0,
                        402.0,
                        2122.0,
                        402.0,
                        2122.0,
                        440.0,
                        2197.0,
                        440.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-169",
                        0
                    ],
                    "destination": [
                        "obj-154",
                        0
                    ],
                    "midpoints": [
                        2215.5,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2002.0,
                        402.0,
                        2002.0,
                        440.0,
                        2002.0,
                        402.0,
                        2062.0,
                        402.0,
                        2062.0,
                        440.0,
                        2062.0,
                        402.0,
                        2122.0,
                        402.0,
                        2122.0,
                        440.0,
                        2122.0,
                        562.0,
                        1873.0,
                        562.0,
                        1873.0,
                        600.0,
                        1873.0,
                        562.0,
                        1967.0,
                        562.0,
                        1967.0,
                        600.0,
                        1967.0,
                        607.0,
                        1946.0,
                        607.0,
                        1946.0,
                        645.0,
                        1840.0,
                        645.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-107",
                        10
                    ],
                    "destination": [
                        "obj-170",
                        0
                    ],
                    "midpoints": [
                        1856.090909090909,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2058.0,
                        402.0,
                        2058.0,
                        440.0,
                        2058.0,
                        402.0,
                        2062.0,
                        402.0,
                        2062.0,
                        440.0,
                        2062.0,
                        402.0,
                        2122.0,
                        402.0,
                        2122.0,
                        440.0,
                        2122.0,
                        402.0,
                        2182.0,
                        402.0,
                        2182.0,
                        440.0,
                        2257.0,
                        440.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-170",
                        0
                    ],
                    "destination": [
                        "obj-157",
                        0
                    ],
                    "midpoints": [
                        2270.0,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2058.0,
                        402.0,
                        2058.0,
                        440.0,
                        2058.0,
                        402.0,
                        2062.0,
                        402.0,
                        2062.0,
                        440.0,
                        2062.0,
                        402.0,
                        2122.0,
                        402.0,
                        2122.0,
                        440.0,
                        2122.0,
                        402.0,
                        2182.0,
                        402.0,
                        2182.0,
                        440.0,
                        2182.0,
                        562.0,
                        1873.0,
                        562.0,
                        1873.0,
                        600.0,
                        1873.0,
                        562.0,
                        1967.0,
                        562.0,
                        1967.0,
                        600.0,
                        1967.0,
                        607.0,
                        1873.0,
                        607.0,
                        1873.0,
                        645.0,
                        1873.0,
                        607.0,
                        1946.0,
                        607.0,
                        1946.0,
                        645.0,
                        1946.0,
                        652.0,
                        1842.0,
                        652.0,
                        1842.0,
                        688.0,
                        1842.0,
                        652.0,
                        1981.0,
                        652.0,
                        1981.0,
                        690.0,
                        1840.0,
                        690.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-107",
                        11
                    ],
                    "destination": [
                        "obj-171",
                        0
                    ],
                    "midpoints": [
                        1876.0,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2058.0,
                        402.0,
                        2058.0,
                        440.0,
                        2058.0,
                        402.0,
                        2118.0,
                        402.0,
                        2118.0,
                        440.0,
                        2118.0,
                        402.0,
                        2122.0,
                        402.0,
                        2122.0,
                        440.0,
                        2122.0,
                        402.0,
                        2182.0,
                        402.0,
                        2182.0,
                        440.0,
                        2182.0,
                        402.0,
                        2242.0,
                        402.0,
                        2242.0,
                        440.0,
                        2317.0,
                        440.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-171",
                        0
                    ],
                    "destination": [
                        "obj-160",
                        0
                    ],
                    "midpoints": [
                        2330.0,
                        402.0,
                        1882.0,
                        402.0,
                        1882.0,
                        440.0,
                        1882.0,
                        402.0,
                        1938.0,
                        402.0,
                        1938.0,
                        440.0,
                        1938.0,
                        402.0,
                        1998.0,
                        402.0,
                        1998.0,
                        440.0,
                        1998.0,
                        402.0,
                        2058.0,
                        402.0,
                        2058.0,
                        440.0,
                        2058.0,
                        402.0,
                        2062.0,
                        402.0,
                        2062.0,
                        440.0,
                        2062.0,
                        402.0,
                        2122.0,
                        402.0,
                        2122.0,
                        440.0,
                        2122.0,
                        402.0,
                        2182.0,
                        402.0,
                        2182.0,
                        440.0,
                        2182.0,
                        402.0,
                        2242.0,
                        402.0,
                        2242.0,
                        440.0,
                        2242.0,
                        562.0,
                        1873.0,
                        562.0,
                        1873.0,
                        600.0,
                        1873.0,
                        562.0,
                        1967.0,
                        562.0,
                        1967.0,
                        600.0,
                        1967.0,
                        607.0,
                        1873.0,
                        607.0,
                        1873.0,
                        645.0,
                        1873.0,
                        607.0,
                        1946.0,
                        607.0,
                        1946.0,
                        645.0,
                        1946.0,
                        652.0,
                        1842.0,
                        652.0,
                        1842.0,
                        688.0,
                        1842.0,
                        652.0,
                        1873.0,
                        652.0,
                        1873.0,
                        690.0,
                        1873.0,
                        652.0,
                        1981.0,
                        652.0,
                        1981.0,
                        690.0,
                        1981.0,
                        697.0,
                        1988.0,
                        697.0,
                        1988.0,
                        735.0,
                        1840.0,
                        735.0
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