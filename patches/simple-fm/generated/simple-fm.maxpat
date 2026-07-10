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
            59.0,
            106.0,
            900.0,
            620.0
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
        "description": "Teaching patch: 2-op Chowning FM, dual MSP + gen~ implementations",
        "digest": "",
        "tags": "",
        "style": "",
        "subpatcher_template": "",
        "assistshowspatchername": 0,
        "boxes": [
            {
                "box": {
                    "maxclass": "kslider",
                    "id": "obj-1",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        150.0,
                        15.0,
                        336.0,
                        53.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        368.0,
                        678.0,
                        53.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-2",
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
                    "maxclass": "newobj",
                    "id": "obj-3",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        75.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger f f",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-4",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        120.0,
                        79.0,
                        22.0
                    ],
                    "text": "stripnote",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-5",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        150.0,
                        75.0,
                        128.0,
                        22.0
                    ],
                    "text": "makenote 100 800",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-6",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        270.0,
                        150.0,
                        44.0,
                        22.0
                    ],
                    "text": "mtof",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-7",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        270.0,
                        285.0,
                        51.0,
                        22.0
                    ],
                    "text": "float",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-8",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        225.0,
                        330.0,
                        121.0,
                        22.0
                    ],
                    "text": "trigger f f f f",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-9",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        60.0,
                        150.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        82.0,
                        64.0,
                        64.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-10",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        345.0,
                        150.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        115.0,
                        82.0,
                        64.0,
                        64.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-11",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        60.0,
                        195.0,
                        149.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 12.7",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-12",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        315.0,
                        195.0,
                        149.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 12.7",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-13",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        75.0,
                        240.0,
                        121.0,
                        22.0
                    ],
                    "text": "trigger b f f f",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-14",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        330.0,
                        240.0,
                        121.0,
                        22.0
                    ],
                    "text": "trigger b f f f",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-15",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        195.0,
                        360.0,
                        44.0,
                        22.0
                    ],
                    "text": "* 2.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-16",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        330.0,
                        450.0,
                        44.0,
                        22.0
                    ],
                    "text": "* 3.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-17",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        165.0,
                        405.0,
                        107.0,
                        22.0
                    ],
                    "text": "trigger f f f",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-18",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        315.0,
                        495.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger f f",
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
                        75.0,
                        285.0,
                        107.0,
                        22.0
                    ],
                    "text": "prepend ratio",
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
                        330.0,
                        285.0,
                        107.0,
                        22.0
                    ],
                    "text": "prepend index",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-21",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        195.0,
                        285.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        22.0,
                        168.0,
                        60.0,
                        22.0
                    ],
                    "numdecimalplaces": 2
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-22",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        450.0,
                        285.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        117.0,
                        168.0,
                        60.0,
                        22.0
                    ],
                    "numdecimalplaces": 2
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-23",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        390.0,
                        360.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        512.0,
                        82.0,
                        72.0,
                        22.0
                    ],
                    "numdecimalplaces": 1
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-24",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        180.0,
                        450.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        512.0,
                        112.0,
                        72.0,
                        22.0
                    ],
                    "numdecimalplaces": 1
                }
            },
            {
                "box": {
                    "maxclass": "flonum",
                    "id": "obj-25",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        330.0,
                        540.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        512.0,
                        142.0,
                        72.0,
                        22.0
                    ],
                    "numdecimalplaces": 1
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-26",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        255.0,
                        450.0,
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
                    "id": "obj-27",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        390.0,
                        540.0,
                        65.0,
                        22.0
                    ],
                    "text": "sig~ 0.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-28",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        330.0,
                        570.0,
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
                    "id": "obj-29",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        300.0,
                        615.0,
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
                    "id": "obj-30",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        285.0,
                        660.0,
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
                    "id": "obj-31",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        255.0,
                        360.0,
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
                                        30.0,
                                        30.0,
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
                                    "maxclass": "codebox",
                                    "id": "obj-2",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        400.0,
                                        200.0
                                    ],
                                    "parameter_enable": 0,
                                    "code": "Param ratio(2., min=0., max=12.7);\nParam index(3., min=0., max=12.7);\n\n// same 2-op FM as the MSP chain, in GenExpr\n// carrier freq (Hz) comes in as a signal\ncf = in1;\n// modulator freq = carrier x ratio\nmodhz = cf * ratio;\n// deviation = mod freq x index\ndev = modhz * index;\nout1 = cycle(cf + cycle(modhz) * dev);\n",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-3",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        210.0,
                                        300.0,
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
                                        "obj-2",
                                        0
                                    ],
                                    "midpoints": [
                                        45.0,
                                        63.5,
                                        230.0,
                                        63.5
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
                    "maxclass": "umenu",
                    "id": "obj-32",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        945.0,
                        165.0,
                        100.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        612.0,
                        82.0,
                        126.0,
                        22.0
                    ],
                    "items": [
                        "MSP chain",
                        ",",
                        "gen~ codebox"
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-33",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        945.0,
                        195.0,
                        37.0,
                        22.0
                    ],
                    "text": "+ 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-34",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        960.0,
                        705.0,
                        160.0,
                        22.0
                    ],
                    "text": "selector~ 2",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-35",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        120.0,
                        120.0,
                        72.0,
                        22.0
                    ],
                    "text": "select 0",
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
                        195.0,
                        150.0,
                        51.0,
                        22.0
                    ],
                    "text": "1. 10",
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
                        120.0,
                        150.0,
                        58.0,
                        22.0
                    ],
                    "text": "0. 200",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-38",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        225.0,
                        195.0,
                        72.0,
                        22.0
                    ],
                    "text": "line~ 0.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-39",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        195.0,
                        750.0,
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
                    "maxclass": "gain~",
                    "id": "obj-40",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        420.0,
                        780.0,
                        22.0,
                        140.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        712.0,
                        196.0,
                        24.0,
                        150.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-41",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        405.0,
                        945.0,
                        44.0,
                        22.0
                    ],
                    "text": "dac~",
                    "fontname": "Arial",
                    "fontsize": 12.0,
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
                    "maxclass": "scope~",
                    "id": "obj-42",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1450.0,
                        705.0,
                        130.0,
                        130.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        196.0,
                        335.0,
                        145.0
                    ],
                    "calccount": 8
                }
            },
            {
                "box": {
                    "maxclass": "spectroscope~",
                    "id": "obj-43",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1125.0,
                        705.0,
                        300.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        360.0,
                        196.0,
                        335.0,
                        145.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-44",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        655.0,
                        70.0,
                        72.0,
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
                    "maxclass": "newobj",
                    "id": "obj-45",
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
                        285.0,
                        75.0,
                        135.0,
                        22.0
                    ],
                    "text": "trigger b b b b b",
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
                        420.0,
                        120.0,
                        40.0,
                        22.0
                    ],
                    "text": "100",
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
                        465.0,
                        120.0,
                        40.0,
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
                    "id": "obj-48",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        525.0,
                        120.0,
                        40.0,
                        22.0
                    ],
                    "text": "30",
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
                        585.0,
                        120.0,
                        40.0,
                        22.0
                    ],
                    "text": "20",
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
                        630.0,
                        120.0,
                        40.0,
                        22.0
                    ],
                    "text": "60",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-51",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        495.0,
                        15.0,
                        345.0,
                        20.0
                    ],
                    "text": "on-screen keys -> makenote adds timed note-offs",
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
                    "id": "obj-52",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        120.0,
                        120.0,
                        492.0,
                        20.0
                    ],
                    "text": "MIDI keyboard in (optional); stripnote keeps note-offs from retuning",
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
                    "id": "obj-53",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        330.0,
                        285.0,
                        492.0,
                        20.0
                    ],
                    "text": "stores carrier Hz -- ratio/index dials bang it to recompute the math",
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
                    "id": "obj-54",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        240.0,
                        360.0,
                        184.0,
                        20.0
                    ],
                    "text": "mod Hz = carrier x ratio",
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
                    "id": "obj-55",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        390.0,
                        450.0,
                        219.0,
                        20.0
                    ],
                    "text": "deviation Hz = mod Hz x index",
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
                    "id": "obj-56",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        330.0,
                        450.0,
                        156.0,
                        20.0
                    ],
                    "text": "modulator oscillator",
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
                    "id": "obj-57",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        360.0,
                        615.0,
                        289.0,
                        20.0
                    ],
                    "text": "carrier freq = base + (mod x deviation)",
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
                    "id": "obj-58",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        375.0,
                        660.0,
                        324.0,
                        20.0
                    ],
                    "text": "carrier oscillator -- the MSP implementation",
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
                    "id": "obj-59",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        375.0,
                        360.0,
                        443.0,
                        20.0
                    ],
                    "text": "the SAME FM algorithm in GenExpr -- A/B them: identical sound",
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
                    "id": "obj-60",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1125.0,
                        705.0,
                        268.0,
                        20.0
                    ],
                    "text": "A/B: 1 = MSP chain, 2 = gen~ codebox",
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
                    "id": "obj-61",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        300.0,
                        195.0,
                        443.0,
                        20.0
                    ],
                    "text": "AR envelope: on = ramp to 1 in 10ms, off = ramp to 0 in 200ms",
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
                    "id": "obj-62",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        210.0,
                        120.0,
                        373.0,
                        20.0
                    ],
                    "text": "velocity 0 = note-off -> release; nonzero -> attack",
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
                    "id": "obj-63",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2100.0,
                        225.0,
                        366.0,
                        20.0
                    ],
                    "text": "How FM Synthesis Works -- 2-Operator (Chowning) FM",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        8.0,
                        560.0,
                        27.0
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
                    "id": "obj-64",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2100.0,
                        285.0,
                        1094.0,
                        20.0
                    ],
                    "text": "A modulator wiggles the carrier frequency. RATIO spaces the sidebands (integer = harmonic, fractional = inharmonic); INDEX adds more of them (brightness).",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        36.0,
                        725.0,
                        32.0
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
                    "id": "obj-65",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2100.0,
                        330.0,
                        51.0,
                        20.0
                    ],
                    "text": "ratio",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [
                        30.0,
                        148.0,
                        50.0,
                        18.0
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
                    "id": "obj-66",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        2100.0,
                        375.0,
                        51.0,
                        20.0
                    ],
                    "text": "index",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [
                        124.0,
                        148.0,
                        50.0,
                        18.0
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
                    "id": "obj-67",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3210.0,
                        30.0,
                        100.0,
                        20.0
                    ],
                    "text": "carrier (Hz)",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [
                        330.0,
                        84.0,
                        178.0,
                        18.0
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
                    "id": "obj-68",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3210.0,
                        75.0,
                        205.0,
                        20.0
                    ],
                    "text": "modulator = carrier x ratio",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [
                        330.0,
                        114.0,
                        178.0,
                        18.0
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
                    "id": "obj-69",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3210.0,
                        135.0,
                        219.0,
                        20.0
                    ],
                    "text": "deviation = modulator x index",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [
                        330.0,
                        144.0,
                        178.0,
                        18.0
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
                    "id": "obj-70",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3210.0,
                        180.0,
                        86.0,
                        20.0
                    ],
                    "text": "engine A/B",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [
                        612.0,
                        106.0,
                        100.0,
                        18.0
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
                    "id": "obj-71",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3210.0,
                        225.0,
                        40.0,
                        20.0
                    ],
                    "text": "vol",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [
                        708.0,
                        348.0,
                        32.0,
                        16.0
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
                    "id": "obj-72",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3210.0,
                        285.0,
                        72.0,
                        20.0
                    ],
                    "text": "waveform",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        343.0,
                        100.0,
                        16.0
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
                    "id": "obj-73",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3210.0,
                        330.0,
                        72.0,
                        20.0
                    ],
                    "text": "spectrum",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [
                        360.0,
                        343.0,
                        100.0,
                        16.0
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
                    "id": "obj-74",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        3210.0,
                        375.0,
                        513.0,
                        20.0
                    ],
                    "text": "click keys to play (click height = velocity) -- or play a MIDI keyboard",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        424.0,
                        560.0,
                        18.0
                    ],
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
                        "obj-5",
                        0
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
                        "obj-5",
                        1
                    ],
                    "midpoints": [
                        479.0,
                        67.0,
                        277.0,
                        67.0,
                        277.0,
                        105.0,
                        214.0,
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
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        37.0,
                        67.0,
                        22.0,
                        67.0,
                        22.0,
                        105.0,
                        37.0,
                        105.0
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
                        0
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
                        "obj-4",
                        1
                    ],
                    "midpoints": [
                        116.0,
                        112.0,
                        112.0,
                        112.0,
                        112.0,
                        150.0,
                        112.0,
                        112.0,
                        112.0,
                        112.0,
                        112.0,
                        148.0,
                        102.0,
                        148.0
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
                        "obj-35",
                        0
                    ],
                    "midpoints": [
                        37.0,
                        67.0,
                        142.0,
                        67.0,
                        142.0,
                        105.0,
                        142.0,
                        112.0,
                        117.0,
                        112.0,
                        117.0,
                        150.0,
                        117.0,
                        112.0,
                        112.0,
                        112.0,
                        112.0,
                        148.0,
                        156.0,
                        148.0
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
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        157.0,
                        67.0,
                        277.0,
                        67.0,
                        277.0,
                        105.0,
                        277.0,
                        112.0,
                        200.0,
                        112.0,
                        200.0,
                        150.0,
                        200.0,
                        112.0,
                        112.0,
                        112.0,
                        112.0,
                        148.0,
                        112.0,
                        112.0,
                        202.0,
                        112.0,
                        202.0,
                        148.0,
                        202.0,
                        142.0,
                        254.0,
                        142.0,
                        254.0,
                        180.0,
                        254.0,
                        142.0,
                        186.0,
                        142.0,
                        186.0,
                        180.0,
                        292.0,
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
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        37.0,
                        112.0,
                        200.0,
                        112.0,
                        200.0,
                        150.0,
                        200.0,
                        112.0,
                        112.0,
                        112.0,
                        112.0,
                        148.0,
                        112.0,
                        112.0,
                        202.0,
                        112.0,
                        202.0,
                        148.0,
                        202.0,
                        142.0,
                        108.0,
                        142.0,
                        108.0,
                        198.0,
                        108.0,
                        142.0,
                        187.0,
                        142.0,
                        187.0,
                        180.0,
                        187.0,
                        142.0,
                        186.0,
                        142.0,
                        186.0,
                        180.0,
                        292.0,
                        180.0
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        292.0,
                        187.0,
                        305.0,
                        187.0,
                        305.0,
                        225.0,
                        305.0,
                        187.0,
                        292.0,
                        187.0,
                        292.0,
                        223.0,
                        277.0,
                        223.0
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
                        "obj-8",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        3
                    ],
                    "destination": [
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        339.0,
                        352.0,
                        384.0,
                        352.0,
                        384.0,
                        390.0,
                        384.0,
                        352.0,
                        432.0,
                        352.0,
                        432.0,
                        388.0,
                        432.0,
                        352.0,
                        367.0,
                        352.0,
                        367.0,
                        388.0,
                        415.0,
                        388.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        2
                    ],
                    "destination": [
                        "obj-31",
                        0
                    ],
                    "midpoints": [
                        303.3333333333333,
                        352.0,
                        232.0,
                        352.0,
                        232.0,
                        388.0,
                        315.5,
                        388.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        1
                    ],
                    "destination": [
                        "obj-29",
                        1
                    ],
                    "midpoints": [
                        267.6666666666667,
                        352.0,
                        247.0,
                        352.0,
                        247.0,
                        390.0,
                        247.0,
                        352.0,
                        232.0,
                        352.0,
                        232.0,
                        388.0,
                        232.0,
                        397.0,
                        280.0,
                        397.0,
                        280.0,
                        435.0,
                        280.0,
                        442.0,
                        322.0,
                        442.0,
                        322.0,
                        480.0,
                        322.0,
                        442.0,
                        331.0,
                        442.0,
                        331.0,
                        480.0,
                        331.0,
                        442.0,
                        322.0,
                        442.0,
                        322.0,
                        478.0,
                        322.0,
                        487.0,
                        307.0,
                        487.0,
                        307.0,
                        525.0,
                        307.0,
                        532.0,
                        322.0,
                        532.0,
                        322.0,
                        570.0,
                        322.0,
                        562.0,
                        322.0,
                        562.0,
                        322.0,
                        600.0,
                        340.5,
                        600.0
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        232.0,
                        352.0,
                        232.0,
                        352.0,
                        232.0,
                        388.0,
                        202.0,
                        388.0
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
                        "obj-13",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-13",
                        3
                    ],
                    "destination": [
                        "obj-15",
                        1
                    ],
                    "midpoints": [
                        189.0,
                        277.0,
                        190.0,
                        277.0,
                        190.0,
                        315.0,
                        190.0,
                        277.0,
                        187.0,
                        277.0,
                        187.0,
                        315.0,
                        187.0,
                        322.0,
                        217.0,
                        322.0,
                        217.0,
                        360.0,
                        217.0,
                        352.0,
                        232.0,
                        352.0,
                        232.0,
                        388.0,
                        232.0,
                        388.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-13",
                        2
                    ],
                    "destination": [
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        153.33333333333331,
                        273.5,
                        128.5,
                        273.5
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
                        "obj-31",
                        0
                    ],
                    "midpoints": [
                        128.5,
                        277.0,
                        262.0,
                        277.0,
                        262.0,
                        315.0,
                        262.0,
                        277.0,
                        253.0,
                        277.0,
                        253.0,
                        315.0,
                        253.0,
                        322.0,
                        217.0,
                        322.0,
                        217.0,
                        360.0,
                        217.0,
                        352.0,
                        247.0,
                        352.0,
                        247.0,
                        390.0,
                        247.0,
                        352.0,
                        232.0,
                        352.0,
                        232.0,
                        388.0,
                        315.5,
                        388.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-13",
                        1
                    ],
                    "destination": [
                        "obj-21",
                        0
                    ],
                    "midpoints": [
                        117.66666666666666,
                        277.0,
                        190.0,
                        277.0,
                        190.0,
                        315.0,
                        220.0,
                        315.0
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        82.0,
                        277.0,
                        190.0,
                        277.0,
                        190.0,
                        315.0,
                        190.0,
                        277.0,
                        187.0,
                        277.0,
                        187.0,
                        315.0,
                        277.0,
                        315.0
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
                        2
                    ],
                    "destination": [
                        "obj-24",
                        0
                    ],
                    "midpoints": [
                        265.0,
                        442.0,
                        247.0,
                        442.0,
                        247.0,
                        480.0,
                        205.0,
                        480.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-17",
                        1
                    ],
                    "destination": [
                        "obj-16",
                        0
                    ],
                    "midpoints": [
                        218.5,
                        442.0,
                        238.0,
                        442.0,
                        238.0,
                        480.0,
                        238.0,
                        442.0,
                        247.0,
                        442.0,
                        247.0,
                        480.0,
                        247.0,
                        442.0,
                        322.0,
                        442.0,
                        322.0,
                        478.0,
                        337.0,
                        478.0
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
                        "obj-26",
                        0
                    ],
                    "midpoints": [
                        172.0,
                        442.0,
                        238.0,
                        442.0,
                        238.0,
                        480.0,
                        262.0,
                        480.0
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
                        "obj-12",
                        0
                    ],
                    "midpoints": [
                        365.0,
                        187.0,
                        292.0,
                        187.0,
                        292.0,
                        223.0,
                        322.0,
                        223.0
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
                        389.5,
                        187.0,
                        292.0,
                        187.0,
                        292.0,
                        223.0,
                        390.5,
                        223.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-14",
                        3
                    ],
                    "destination": [
                        "obj-16",
                        1
                    ],
                    "midpoints": [
                        444.0,
                        277.0,
                        445.0,
                        277.0,
                        445.0,
                        315.0,
                        445.0,
                        277.0,
                        442.0,
                        277.0,
                        442.0,
                        315.0,
                        442.0,
                        277.0,
                        322.0,
                        277.0,
                        322.0,
                        313.0,
                        322.0,
                        352.0,
                        382.0,
                        352.0,
                        382.0,
                        390.0,
                        382.0,
                        352.0,
                        384.0,
                        352.0,
                        384.0,
                        390.0,
                        384.0,
                        352.0,
                        432.0,
                        352.0,
                        432.0,
                        388.0,
                        432.0,
                        352.0,
                        367.0,
                        352.0,
                        367.0,
                        388.0,
                        367.0,
                        442.0,
                        382.0,
                        442.0,
                        382.0,
                        478.0,
                        382.0,
                        442.0,
                        322.0,
                        442.0,
                        322.0,
                        478.0,
                        367.0,
                        478.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-14",
                        2
                    ],
                    "destination": [
                        "obj-20",
                        0
                    ],
                    "midpoints": [
                        408.3333333333333,
                        277.0,
                        322.0,
                        277.0,
                        322.0,
                        313.0,
                        383.5,
                        313.0
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
                        "obj-31",
                        0
                    ],
                    "midpoints": [
                        383.5,
                        277.0,
                        329.0,
                        277.0,
                        329.0,
                        315.0,
                        329.0,
                        277.0,
                        322.0,
                        277.0,
                        322.0,
                        313.0,
                        322.0,
                        322.0,
                        354.0,
                        322.0,
                        354.0,
                        360.0,
                        354.0,
                        352.0,
                        382.0,
                        352.0,
                        382.0,
                        390.0,
                        382.0,
                        352.0,
                        432.0,
                        352.0,
                        432.0,
                        388.0,
                        432.0,
                        352.0,
                        367.0,
                        352.0,
                        367.0,
                        388.0,
                        315.5,
                        388.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-14",
                        1
                    ],
                    "destination": [
                        "obj-22",
                        0
                    ],
                    "midpoints": [
                        372.6666666666667,
                        277.0,
                        445.0,
                        277.0,
                        445.0,
                        315.0,
                        445.0,
                        277.0,
                        322.0,
                        277.0,
                        322.0,
                        313.0,
                        475.0,
                        313.0
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        337.0,
                        277.0,
                        322.0,
                        277.0,
                        322.0,
                        315.0,
                        322.0,
                        277.0,
                        322.0,
                        277.0,
                        322.0,
                        313.0,
                        277.0,
                        313.0
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
                        0
                    ],
                    "midpoints": [
                        352.0,
                        442.0,
                        322.0,
                        442.0,
                        322.0,
                        478.0,
                        361.5,
                        478.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-18",
                        1
                    ],
                    "destination": [
                        "obj-25",
                        0
                    ],
                    "midpoints": [
                        401.0,
                        532.0,
                        382.0,
                        532.0,
                        382.0,
                        570.0,
                        355.0,
                        570.0
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
                        "obj-27",
                        0
                    ],
                    "midpoints": [
                        322.0,
                        532.0,
                        388.0,
                        532.0,
                        388.0,
                        570.0,
                        422.5,
                        570.0
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
                        "obj-28",
                        1
                    ],
                    "midpoints": [
                        422.5,
                        532.0,
                        388.0,
                        532.0,
                        388.0,
                        570.0,
                        365.0,
                        570.0
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
                        "obj-28",
                        0
                    ],
                    "midpoints": [
                        289.0,
                        442.0,
                        322.0,
                        442.0,
                        322.0,
                        480.0,
                        322.0,
                        442.0,
                        322.0,
                        442.0,
                        322.0,
                        478.0,
                        322.0,
                        487.0,
                        307.0,
                        487.0,
                        307.0,
                        525.0,
                        307.0,
                        532.0,
                        322.0,
                        532.0,
                        322.0,
                        570.0,
                        337.0,
                        570.0
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
                        "obj-29",
                        0
                    ],
                    "midpoints": [
                        351.0,
                        607.0,
                        352.0,
                        607.0,
                        352.0,
                        643.0,
                        307.0,
                        643.0
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
                        "obj-30",
                        0
                    ],
                    "midpoints": [
                        323.75,
                        648.5,
                        292.0,
                        648.5
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
                        "obj-34",
                        1
                    ],
                    "midpoints": [
                        319.0,
                        652.0,
                        707.0,
                        652.0,
                        707.0,
                        688.0,
                        1040.0,
                        688.0
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
                        "obj-34",
                        2
                    ],
                    "midpoints": [
                        315.5,
                        352.0,
                        448.0,
                        352.0,
                        448.0,
                        390.0,
                        448.0,
                        352.0,
                        432.0,
                        352.0,
                        432.0,
                        388.0,
                        432.0,
                        352.0,
                        826.0,
                        352.0,
                        826.0,
                        388.0,
                        826.0,
                        442.0,
                        382.0,
                        442.0,
                        382.0,
                        480.0,
                        382.0,
                        442.0,
                        331.0,
                        442.0,
                        331.0,
                        480.0,
                        331.0,
                        442.0,
                        617.0,
                        442.0,
                        617.0,
                        478.0,
                        617.0,
                        442.0,
                        494.0,
                        442.0,
                        494.0,
                        478.0,
                        494.0,
                        487.0,
                        416.0,
                        487.0,
                        416.0,
                        525.0,
                        416.0,
                        532.0,
                        388.0,
                        532.0,
                        388.0,
                        570.0,
                        388.0,
                        532.0,
                        463.0,
                        532.0,
                        463.0,
                        570.0,
                        463.0,
                        562.0,
                        380.0,
                        562.0,
                        380.0,
                        600.0,
                        380.0,
                        607.0,
                        355.5,
                        607.0,
                        355.5,
                        645.0,
                        355.5,
                        607.0,
                        657.0,
                        607.0,
                        657.0,
                        643.0,
                        657.0,
                        652.0,
                        361.0,
                        652.0,
                        361.0,
                        690.0,
                        361.0,
                        652.0,
                        707.0,
                        652.0,
                        707.0,
                        688.0,
                        1113.0,
                        688.0
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
                        "obj-33",
                        0
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
                        "obj-34",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-5",
                        1
                    ],
                    "destination": [
                        "obj-35",
                        0
                    ],
                    "midpoints": [
                        271.0,
                        112.0,
                        112.0,
                        112.0,
                        112.0,
                        148.0,
                        112.0,
                        112.0,
                        202.0,
                        112.0,
                        202.0,
                        148.0,
                        156.0,
                        148.0
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
                        "obj-37",
                        0
                    ],
                    "midpoints": [
                        127.0,
                        112.0,
                        112.0,
                        112.0,
                        112.0,
                        148.0,
                        127.0,
                        148.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-35",
                        1
                    ],
                    "destination": [
                        "obj-36",
                        0
                    ],
                    "midpoints": [
                        185.0,
                        112.0,
                        112.0,
                        112.0,
                        112.0,
                        148.0,
                        112.0,
                        112.0,
                        202.0,
                        112.0,
                        202.0,
                        148.0,
                        202.0,
                        142.0,
                        186.0,
                        142.0,
                        186.0,
                        180.0,
                        202.0,
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
                        "obj-38",
                        0
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
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        149.0,
                        142.0,
                        187.0,
                        142.0,
                        187.0,
                        180.0,
                        187.0,
                        187.0,
                        217.0,
                        187.0,
                        217.0,
                        225.0,
                        232.0,
                        225.0
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
                        "obj-39",
                        0
                    ],
                    "midpoints": [
                        1040.0,
                        738.5,
                        202.0,
                        738.5
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
                        1
                    ],
                    "midpoints": [
                        232.0,
                        277.0,
                        253.0,
                        277.0,
                        253.0,
                        315.0,
                        253.0,
                        322.0,
                        217.0,
                        322.0,
                        217.0,
                        360.0,
                        217.0,
                        352.0,
                        247.0,
                        352.0,
                        247.0,
                        390.0,
                        247.0,
                        352.0,
                        232.0,
                        352.0,
                        232.0,
                        388.0,
                        232.0,
                        397.0,
                        280.0,
                        397.0,
                        280.0,
                        435.0,
                        280.0,
                        442.0,
                        238.0,
                        442.0,
                        238.0,
                        480.0,
                        230.0,
                        480.0
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
                    ],
                    "midpoints": [
                        216.0,
                        776.0,
                        431.0,
                        776.0
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
                        "obj-41",
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
                        "obj-41",
                        1
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
                        "obj-42",
                        0
                    ],
                    "midpoints": [
                        1040.0,
                        697.0,
                        1117.0,
                        697.0,
                        1117.0,
                        813.0,
                        1117.0,
                        697.0,
                        1117.0,
                        697.0,
                        1117.0,
                        733.0,
                        1457.0,
                        733.0
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
                        "obj-43",
                        0
                    ],
                    "midpoints": [
                        1040.0,
                        697.0,
                        1117.0,
                        697.0,
                        1117.0,
                        733.0,
                        1132.0,
                        733.0
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
                        "obj-45",
                        0
                    ],
                    "midpoints": [
                        691.0,
                        83.5,
                        352.5,
                        83.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-45",
                        4
                    ],
                    "destination": [
                        "obj-46",
                        0
                    ],
                    "midpoints": [
                        413.0,
                        112.0,
                        620.0,
                        112.0,
                        620.0,
                        148.0,
                        620.0,
                        112.0,
                        591.0,
                        112.0,
                        591.0,
                        148.0,
                        427.0,
                        148.0
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
                        "obj-40",
                        0
                    ],
                    "midpoints": [
                        440.0,
                        112.0,
                        620.0,
                        112.0,
                        620.0,
                        148.0,
                        620.0,
                        112.0,
                        591.0,
                        112.0,
                        591.0,
                        148.0,
                        591.0,
                        187.0,
                        472.0,
                        187.0,
                        472.0,
                        225.0,
                        472.0,
                        187.0,
                        292.0,
                        187.0,
                        292.0,
                        223.0,
                        292.0,
                        232.0,
                        459.0,
                        232.0,
                        459.0,
                        270.0,
                        459.0,
                        277.0,
                        445.0,
                        277.0,
                        445.0,
                        315.0,
                        445.0,
                        277.0,
                        322.0,
                        277.0,
                        322.0,
                        313.0,
                        322.0,
                        352.0,
                        448.0,
                        352.0,
                        448.0,
                        390.0,
                        448.0,
                        352.0,
                        432.0,
                        352.0,
                        432.0,
                        388.0,
                        432.0,
                        352.0,
                        367.0,
                        352.0,
                        367.0,
                        388.0,
                        367.0,
                        442.0,
                        382.0,
                        442.0,
                        382.0,
                        478.0,
                        382.0,
                        442.0,
                        494.0,
                        442.0,
                        494.0,
                        478.0,
                        494.0,
                        532.0,
                        463.0,
                        532.0,
                        463.0,
                        570.0,
                        463.0,
                        607.0,
                        352.0,
                        607.0,
                        352.0,
                        643.0,
                        352.0,
                        652.0,
                        367.0,
                        652.0,
                        367.0,
                        688.0,
                        431.0,
                        688.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-45",
                        3
                    ],
                    "destination": [
                        "obj-47",
                        0
                    ],
                    "midpoints": [
                        382.75,
                        112.0,
                        412.0,
                        112.0,
                        412.0,
                        150.0,
                        412.0,
                        112.0,
                        620.0,
                        112.0,
                        620.0,
                        148.0,
                        620.0,
                        112.0,
                        591.0,
                        112.0,
                        591.0,
                        148.0,
                        472.0,
                        148.0
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
                        "obj-32",
                        0
                    ],
                    "midpoints": [
                        485.0,
                        112.0,
                        573.0,
                        112.0,
                        573.0,
                        150.0,
                        573.0,
                        112.0,
                        633.0,
                        112.0,
                        633.0,
                        150.0,
                        633.0,
                        112.0,
                        678.0,
                        112.0,
                        678.0,
                        150.0,
                        678.0,
                        112.0,
                        620.0,
                        112.0,
                        620.0,
                        148.0,
                        620.0,
                        112.0,
                        591.0,
                        112.0,
                        591.0,
                        148.0,
                        995.0,
                        148.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-45",
                        2
                    ],
                    "destination": [
                        "obj-48",
                        0
                    ],
                    "midpoints": [
                        352.5,
                        112.0,
                        468.0,
                        112.0,
                        468.0,
                        150.0,
                        468.0,
                        112.0,
                        457.0,
                        112.0,
                        457.0,
                        150.0,
                        457.0,
                        112.0,
                        620.0,
                        112.0,
                        620.0,
                        148.0,
                        620.0,
                        112.0,
                        591.0,
                        112.0,
                        591.0,
                        148.0,
                        532.0,
                        148.0
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
                        "obj-10",
                        0
                    ],
                    "midpoints": [
                        545.0,
                        112.0,
                        468.0,
                        112.0,
                        468.0,
                        150.0,
                        468.0,
                        112.0,
                        457.0,
                        112.0,
                        457.0,
                        150.0,
                        457.0,
                        112.0,
                        620.0,
                        112.0,
                        620.0,
                        148.0,
                        620.0,
                        112.0,
                        591.0,
                        112.0,
                        591.0,
                        148.0,
                        365.0,
                        148.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-45",
                        1
                    ],
                    "destination": [
                        "obj-49",
                        0
                    ],
                    "midpoints": [
                        322.25,
                        112.0,
                        468.0,
                        112.0,
                        468.0,
                        150.0,
                        468.0,
                        112.0,
                        457.0,
                        112.0,
                        457.0,
                        150.0,
                        457.0,
                        112.0,
                        517.0,
                        112.0,
                        517.0,
                        150.0,
                        517.0,
                        112.0,
                        620.0,
                        112.0,
                        620.0,
                        148.0,
                        620.0,
                        112.0,
                        591.0,
                        112.0,
                        591.0,
                        148.0,
                        592.0,
                        148.0
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
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        605.0,
                        112.0,
                        117.0,
                        112.0,
                        117.0,
                        150.0,
                        117.0,
                        112.0,
                        200.0,
                        112.0,
                        200.0,
                        150.0,
                        200.0,
                        112.0,
                        412.0,
                        112.0,
                        412.0,
                        150.0,
                        412.0,
                        112.0,
                        457.0,
                        112.0,
                        457.0,
                        150.0,
                        457.0,
                        112.0,
                        517.0,
                        112.0,
                        517.0,
                        150.0,
                        517.0,
                        112.0,
                        112.0,
                        112.0,
                        112.0,
                        148.0,
                        112.0,
                        112.0,
                        202.0,
                        112.0,
                        202.0,
                        148.0,
                        202.0,
                        142.0,
                        322.0,
                        142.0,
                        322.0,
                        180.0,
                        322.0,
                        142.0,
                        337.0,
                        142.0,
                        337.0,
                        198.0,
                        337.0,
                        142.0,
                        254.0,
                        142.0,
                        254.0,
                        180.0,
                        254.0,
                        142.0,
                        186.0,
                        142.0,
                        186.0,
                        180.0,
                        80.0,
                        180.0
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
                        "obj-50",
                        0
                    ],
                    "midpoints": [
                        292.0,
                        112.0,
                        468.0,
                        112.0,
                        468.0,
                        150.0,
                        468.0,
                        112.0,
                        457.0,
                        112.0,
                        457.0,
                        150.0,
                        457.0,
                        112.0,
                        517.0,
                        112.0,
                        517.0,
                        150.0,
                        517.0,
                        112.0,
                        577.0,
                        112.0,
                        577.0,
                        150.0,
                        577.0,
                        112.0,
                        620.0,
                        112.0,
                        620.0,
                        148.0,
                        620.0,
                        112.0,
                        591.0,
                        112.0,
                        591.0,
                        148.0,
                        637.0,
                        148.0
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
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        650.0,
                        112.0,
                        468.0,
                        112.0,
                        468.0,
                        150.0,
                        468.0,
                        112.0,
                        457.0,
                        112.0,
                        457.0,
                        150.0,
                        457.0,
                        112.0,
                        517.0,
                        112.0,
                        517.0,
                        150.0,
                        517.0,
                        112.0,
                        577.0,
                        112.0,
                        577.0,
                        150.0,
                        577.0,
                        112.0,
                        620.0,
                        112.0,
                        620.0,
                        148.0,
                        620.0,
                        112.0,
                        591.0,
                        112.0,
                        591.0,
                        148.0,
                        591.0,
                        142.0,
                        393.0,
                        142.0,
                        393.0,
                        198.0,
                        292.0,
                        198.0
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