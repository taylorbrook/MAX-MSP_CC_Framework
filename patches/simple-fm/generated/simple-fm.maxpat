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
            59.0,
            106.0,
            900.0,
            620.0
        ],
        "openinpresentation": 1,
        "description": "Teaching patch: 2-op Chowning FM, dual MSP + gen~ implementations",
        "boxes": [
            {
                "box": {
                    "attr": "mode",
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 13.0,
                    "id": "obj-75",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        544.5,
                        38.5,
                        164.0,
                        23.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        484.0,
                        164.0,
                        23.0
                    ],
                    "text_width": 55.0
                }
            },
            {
                "box": {
                    "id": "obj-1",
                    "maxclass": "kslider",
                    "mode": 2,
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "int",
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        184.5,
                        8.0,
                        336.0,
                        53.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        368.0,
                        672.0,
                        98.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-2",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        30.0,
                        30.0,
                        58.0,
                        22.0
                    ],
                    "text": "notein"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-3",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "float",
                        "float"
                    ],
                    "patching_rect": [
                        30.0,
                        75.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger f f"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        9.0,
                        107.0,
                        79.0,
                        22.0
                    ],
                    "text": "stripnote"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-5",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [
                        "float",
                        "float"
                    ],
                    "patching_rect": [
                        184.5,
                        69.5,
                        85.0,
                        22.0
                    ],
                    "text": "makenote 100"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-6",
                    "maxclass": "newobj",
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
                    "text": "mtof"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-7",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        270.0,
                        285.0,
                        51.0,
                        22.0
                    ],
                    "text": "float"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-8",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "float",
                        "float",
                        "float",
                        "float"
                    ],
                    "patching_rect": [
                        225.0,
                        330.0,
                        121.0,
                        22.0
                    ],
                    "text": "trigger f f f f"
                }
            },
            {
                "box": {
                    "id": "obj-9",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        60.0,
                        150.0,
                        40.0,
                        40.0
                    ],
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
                    "id": "obj-10",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        345.0,
                        150.0,
                        40.0,
                        40.0
                    ],
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-11",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        61.0,
                        202.0,
                        149.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 12.7"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-12",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        330.0,
                        208.0,
                        149.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 12.7"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-13",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "bang",
                        "float",
                        "float",
                        "float"
                    ],
                    "patching_rect": [
                        75.0,
                        240.0,
                        121.0,
                        22.0
                    ],
                    "text": "trigger b f f f"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-14",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "bang",
                        "float",
                        "float",
                        "float"
                    ],
                    "patching_rect": [
                        330.0,
                        240.0,
                        121.0,
                        22.0
                    ],
                    "text": "trigger b f f f"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-15",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        195.0,
                        360.0,
                        44.0,
                        22.0
                    ],
                    "text": "* 2."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-16",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        330.0,
                        450.0,
                        44.0,
                        22.0
                    ],
                    "text": "* 3."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-17",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "float",
                        "float",
                        "float"
                    ],
                    "patching_rect": [
                        165.0,
                        405.0,
                        107.0,
                        22.0
                    ],
                    "text": "trigger f f f"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-18",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "float",
                        "float"
                    ],
                    "patching_rect": [
                        315.0,
                        495.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger f f"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-19",
                    "maxclass": "newobj",
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
                    "text": "prepend ratio"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-20",
                    "maxclass": "newobj",
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
                    "text": "prepend index"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-21",
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        195.0,
                        285.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        22.0,
                        168.0,
                        60.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-22",
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        446.0,
                        284.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        117.0,
                        168.0,
                        60.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-23",
                    "maxclass": "flonum",
                    "numdecimalplaces": 1,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        549.5,
                        360.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        512.0,
                        82.0,
                        72.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-24",
                    "maxclass": "flonum",
                    "numdecimalplaces": 1,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        180.0,
                        450.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        512.0,
                        112.0,
                        72.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-25",
                    "maxclass": "flonum",
                    "numdecimalplaces": 1,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        330.0,
                        540.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        512.0,
                        142.0,
                        72.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-26",
                    "maxclass": "newobj",
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
                    "text": "cycle~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-27",
                    "maxclass": "newobj",
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
                    "text": "sig~ 0."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-28",
                    "maxclass": "newobj",
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
                    "text": "*~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-29",
                    "maxclass": "newobj",
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
                    "text": "+~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-30",
                    "maxclass": "newobj",
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
                    "text": "cycle~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-31",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 2,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "dsp.gen",
                        "rect": [
                            100.0,
                            100.0,
                            600.0,
                            450.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-1",
                                    "maxclass": "newobj",
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
                                    "text": "in 1"
                                }
                            },
                            {
                                "box": {
                                    "code": "Param ratio(2., min=0., max=12.7);\nParam index(3., min=0., max=12.7);\n\n// same 2-op FM as the MSP chain, in GenExpr\n// carrier freq (Hz) comes in as a signal\ncf = in1;\n// modulator freq = carrier x ratio\nmodhz = cf * ratio;\n// deviation = mod freq x index\ndev = modhz * index;\nout1 = cycle(cf + cycle(modhz) * dev);\n",
                                    "fontface": 0,
                                    "fontname": "<Monospaced>",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "maxclass": "codebox",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        373.0,
                                        235.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        30.0,
                                        335.0,
                                        35.0,
                                        22.0
                                    ],
                                    "text": "out 1"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-2",
                                        0
                                    ],
                                    "midpoints": [
                                        45.0,
                                        63.5,
                                        216.5,
                                        63.5
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
                                        "obj-3",
                                        0
                                    ],
                                    "source": [
                                        "obj-2",
                                        0
                                    ],
                                    "midpoints": [
                                        216.5,
                                        322.5,
                                        47.5,
                                        322.5
                                    ]
                                }
                            }
                        ],
                        "bgcolor": [
                            0.9,
                            0.9,
                            0.9,
                            1.0
                        ]
                    },
                    "patching_rect": [
                        414.5,
                        360.0,
                        121.0,
                        22.0
                    ],
                    "text": "gen~"
                }
            },
            {
                "box": {
                    "id": "obj-32",
                    "items": [
                        "MSP chain",
                        ",",
                        "gen~ codebox"
                    ],
                    "maxclass": "umenu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        945.0,
                        165.0,
                        100.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        612.0,
                        82.0,
                        126.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-33",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "patching_rect": [
                        945.0,
                        195.0,
                        37.0,
                        22.0
                    ],
                    "text": "+ 1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-34",
                    "maxclass": "newobj",
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
                    "text": "selector~ 2"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-35",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "bang",
                        ""
                    ],
                    "patching_rect": [
                        120.0,
                        107.0,
                        72.0,
                        22.0
                    ],
                    "text": "select 0"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-36",
                    "maxclass": "message",
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
                    "text": "1. 10"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-37",
                    "maxclass": "message",
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
                    "text": "0. 200"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-38",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "bang"
                    ],
                    "patching_rect": [
                        225.0,
                        195.0,
                        72.0,
                        22.0
                    ],
                    "text": "line~ 0."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-39",
                    "maxclass": "newobj",
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
                    "text": "*~"
                }
            },
            {
                "box": {
                    "id": "obj-40",
                    "maxclass": "gain~",
                    "multichannelvariant": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        420.0,
                        780.0,
                        22.0,
                        140.0
                    ],
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
                    "bgcolor": [
                        0.92,
                        0.85,
                        0.85,
                        1.0
                    ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-41",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        405.0,
                        945.0,
                        44.0,
                        22.0
                    ],
                    "text": "dac~"
                }
            },
            {
                "box": {
                    "calccount": 8,
                    "id": "obj-42",
                    "maxclass": "scope~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        1450.0,
                        705.0,
                        130.0,
                        130.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        196.0,
                        335.0,
                        145.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-43",
                    "maxclass": "spectroscope~",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1125.0,
                        705.0,
                        300.0,
                        100.0
                    ],
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
                    "bgcolor": [
                        0.85,
                        0.92,
                        0.85,
                        1.0
                    ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-44",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        544.5,
                        69.5,
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
                    "id": "obj-45",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 5,
                    "outlettype": [
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        285.0,
                        75.0,
                        135.0,
                        22.0
                    ],
                    "text": "trigger b b b b b"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-46",
                    "maxclass": "message",
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
                    "text": "100"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-47",
                    "maxclass": "message",
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
                    "text": "0"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-48",
                    "maxclass": "message",
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
                    "text": "30"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-49",
                    "maxclass": "message",
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
                    "text": "20"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-50",
                    "maxclass": "message",
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
                    "text": "60"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-51",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        544.5,
                        14.5,
                        345.0,
                        20.0
                    ],
                    "text": "on-screen keys -> makenote adds timed note-offs",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-52",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20.0,
                        8.0,
                        492.0,
                        20.0
                    ],
                    "text": "MIDI keyboard in (optional)",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-53",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        513.0,
                        285.0,
                        492.0,
                        20.0
                    ],
                    "text": "stores carrier Hz -- ratio/index dials bang it to recompute the math",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-54",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        241.0,
                        360.0,
                        184.0,
                        20.0
                    ],
                    "text": "mod Hz = carrier x ratio",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-55",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        390.0,
                        450.0,
                        219.0,
                        20.0
                    ],
                    "text": "deviation Hz = mod Hz x index",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-56",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        330.0,
                        450.0,
                        156.0,
                        20.0
                    ],
                    "text": "modulator oscillator",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-57",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        360.0,
                        615.0,
                        289.0,
                        20.0
                    ],
                    "text": "carrier freq = base + (mod x deviation)",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-58",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        375.0,
                        660.0,
                        324.0,
                        20.0
                    ],
                    "text": "carrier oscillator -- the MSP implementation",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-59",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        612.0,
                        361.0,
                        443.0,
                        20.0
                    ],
                    "text": "the SAME FM algorithm in GenExpr -- A/B them: identical sound",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-60",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1125.0,
                        705.0,
                        268.0,
                        20.0
                    ],
                    "text": "A/B: 1 = MSP chain, 2 = gen~ codebox",
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-61",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        491.0,
                        209.0,
                        443.0,
                        20.0
                    ],
                    "text": "AR envelope: on = ramp to 1 in 10ms, off = ramp to 0 in 200ms",
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
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "id": "obj-63",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2100.0,
                        225.0,
                        402.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        8.0,
                        560.0,
                        24.0
                    ],
                    "text": "How FM Synthesis Works -- 2-Operator (Chowning) FM",
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
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-64",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2100.0,
                        285.0,
                        1094.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        36.0,
                        776.0,
                        19.0
                    ],
                    "text": "A modulator wiggles the carrier frequency. RATIO spaces the sidebands (integer = harmonic, fractional = inharmonic); INDEX adds more of them (brightness).",
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
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-65",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2100.0,
                        330.0,
                        51.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        30.0,
                        148.0,
                        50.0,
                        19.0
                    ],
                    "text": "ratio",
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
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-66",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        2100.0,
                        375.0,
                        51.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        124.0,
                        148.0,
                        50.0,
                        19.0
                    ],
                    "text": "index",
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
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-67",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3210.0,
                        30.0,
                        100.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        330.0,
                        84.0,
                        178.0,
                        19.0
                    ],
                    "text": "carrier (Hz)",
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
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-68",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3210.0,
                        75.0,
                        205.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        330.0,
                        114.0,
                        178.0,
                        19.0
                    ],
                    "text": "modulator = carrier x ratio",
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
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-69",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3210.0,
                        135.0,
                        219.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        330.0,
                        144.0,
                        178.0,
                        19.0
                    ],
                    "text": "deviation = modulator x index",
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
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-70",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3210.0,
                        180.0,
                        86.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        612.0,
                        106.0,
                        100.0,
                        19.0
                    ],
                    "text": "engine A/B",
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
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-71",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3210.0,
                        225.0,
                        40.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        708.0,
                        348.0,
                        32.0,
                        19.0
                    ],
                    "text": "vol",
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
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-72",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3210.0,
                        285.0,
                        72.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        343.0,
                        100.0,
                        19.0
                    ],
                    "text": "waveform",
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
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-73",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3210.0,
                        330.0,
                        72.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        360.0,
                        343.0,
                        100.0,
                        19.0
                    ],
                    "text": "spectrum",
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
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-74",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        3210.0,
                        375.0,
                        513.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        424.0,
                        560.0,
                        19.0
                    ],
                    "text": "click keys to play (click height = velocity) -- or play a MIDI keyboard",
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
                    "id": "obj-76",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        795.0,
                        75.0,
                        100.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "items": [
                        "Default",
                        ",",
                        "E-Piano",
                        ",",
                        "Bell",
                        ",",
                        "Bass",
                        ",",
                        "Brass",
                        ",",
                        "Marimba",
                        ",",
                        "Glass"
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        210.0,
                        82.0,
                        110.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-77",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        790.0,
                        48.0,
                        58.0,
                        20.0
                    ],
                    "text": "preset",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        215.0,
                        106.0,
                        100.0,
                        19.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-78",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        910.0,
                        110.0,
                        310.0,
                        20.0
                    ],
                    "text": "FM tone presets -> set ratio + index dials",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-79",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        790.0,
                        110.0,
                        86.0,
                        22.0
                    ],
                    "text": "p presets",
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
                                    "comment": "preset index (from umenu)"
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
                                        50.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "ratio dial value (0-127)"
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
                                        130.0,
                                        250.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "index dial value (0-127)"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-4",
                                    "numinlets": 1,
                                    "numoutlets": 8,
                                    "outlettype": [
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
                                        15.0,
                                        75.0,
                                        156.0,
                                        22.0
                                    ],
                                    "text": "select 0 1 2 3 4 5 6",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-5",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        15.0,
                                        165.0,
                                        116.0,
                                        22.0
                                    ],
                                    "text": "unpack 0 0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-6",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        15.0,
                                        115.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "20 30",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        95.0,
                                        115.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "10 15",
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
                                        175.0,
                                        115.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "35 80",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        255.0,
                                        115.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "10 30",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-10",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        335.0,
                                        115.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "10 50",
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
                                        415.0,
                                        115.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "40 15",
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
                                        495.0,
                                        115.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "14 60",
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
                                    ],
                                    "midpoints": [
                                        65.0,
                                        67.5,
                                        93.0,
                                        67.5
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
                                        "obj-6",
                                        0
                                    ],
                                    "destination": [
                                        "obj-5",
                                        0
                                    ],
                                    "midpoints": [
                                        40.5,
                                        151.0,
                                        73.0,
                                        151.0
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
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        42.285714285714285,
                                        107.0,
                                        74.0,
                                        107.0,
                                        74.0,
                                        145.0,
                                        102.0,
                                        145.0
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
                                        "obj-5",
                                        0
                                    ],
                                    "midpoints": [
                                        120.5,
                                        107.0,
                                        74.0,
                                        107.0,
                                        74.0,
                                        145.0,
                                        73.0,
                                        145.0
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
                                        "obj-8",
                                        0
                                    ],
                                    "midpoints": [
                                        62.57142857142857,
                                        107.0,
                                        74.0,
                                        107.0,
                                        74.0,
                                        145.0,
                                        74.0,
                                        107.0,
                                        154.0,
                                        107.0,
                                        154.0,
                                        145.0,
                                        182.0,
                                        145.0
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
                                        "obj-5",
                                        0
                                    ],
                                    "midpoints": [
                                        200.5,
                                        107.0,
                                        74.0,
                                        107.0,
                                        74.0,
                                        145.0,
                                        74.0,
                                        107.0,
                                        154.0,
                                        107.0,
                                        154.0,
                                        145.0,
                                        73.0,
                                        145.0
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
                                        "obj-9",
                                        0
                                    ],
                                    "midpoints": [
                                        82.85714285714286,
                                        107.0,
                                        154.0,
                                        107.0,
                                        154.0,
                                        145.0,
                                        154.0,
                                        107.0,
                                        167.0,
                                        107.0,
                                        167.0,
                                        145.0,
                                        262.0,
                                        145.0
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
                                        "obj-5",
                                        0
                                    ],
                                    "midpoints": [
                                        280.5,
                                        107.0,
                                        74.0,
                                        107.0,
                                        74.0,
                                        145.0,
                                        74.0,
                                        107.0,
                                        154.0,
                                        107.0,
                                        154.0,
                                        145.0,
                                        154.0,
                                        107.0,
                                        167.0,
                                        107.0,
                                        167.0,
                                        145.0,
                                        73.0,
                                        145.0
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
                                        "obj-10",
                                        0
                                    ],
                                    "midpoints": [
                                        103.14285714285714,
                                        107.0,
                                        154.0,
                                        107.0,
                                        154.0,
                                        145.0,
                                        154.0,
                                        107.0,
                                        234.0,
                                        107.0,
                                        234.0,
                                        145.0,
                                        234.0,
                                        107.0,
                                        247.0,
                                        107.0,
                                        247.0,
                                        145.0,
                                        342.0,
                                        145.0
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
                                        "obj-5",
                                        0
                                    ],
                                    "midpoints": [
                                        360.5,
                                        107.0,
                                        74.0,
                                        107.0,
                                        74.0,
                                        145.0,
                                        74.0,
                                        107.0,
                                        154.0,
                                        107.0,
                                        154.0,
                                        145.0,
                                        154.0,
                                        107.0,
                                        234.0,
                                        107.0,
                                        234.0,
                                        145.0,
                                        234.0,
                                        107.0,
                                        247.0,
                                        107.0,
                                        247.0,
                                        145.0,
                                        73.0,
                                        145.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-4",
                                        5
                                    ],
                                    "destination": [
                                        "obj-11",
                                        0
                                    ],
                                    "midpoints": [
                                        123.42857142857142,
                                        107.0,
                                        154.0,
                                        107.0,
                                        154.0,
                                        145.0,
                                        154.0,
                                        107.0,
                                        234.0,
                                        107.0,
                                        234.0,
                                        145.0,
                                        234.0,
                                        107.0,
                                        247.0,
                                        107.0,
                                        247.0,
                                        145.0,
                                        247.0,
                                        107.0,
                                        327.0,
                                        107.0,
                                        327.0,
                                        145.0,
                                        422.0,
                                        145.0
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
                                        "obj-5",
                                        0
                                    ],
                                    "midpoints": [
                                        440.5,
                                        107.0,
                                        74.0,
                                        107.0,
                                        74.0,
                                        145.0,
                                        74.0,
                                        107.0,
                                        154.0,
                                        107.0,
                                        154.0,
                                        145.0,
                                        154.0,
                                        107.0,
                                        234.0,
                                        107.0,
                                        234.0,
                                        145.0,
                                        234.0,
                                        107.0,
                                        247.0,
                                        107.0,
                                        247.0,
                                        145.0,
                                        247.0,
                                        107.0,
                                        327.0,
                                        107.0,
                                        327.0,
                                        145.0,
                                        73.0,
                                        145.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-4",
                                        6
                                    ],
                                    "destination": [
                                        "obj-12",
                                        0
                                    ],
                                    "midpoints": [
                                        143.71428571428572,
                                        107.0,
                                        154.0,
                                        107.0,
                                        154.0,
                                        145.0,
                                        154.0,
                                        107.0,
                                        234.0,
                                        107.0,
                                        234.0,
                                        145.0,
                                        234.0,
                                        107.0,
                                        314.0,
                                        107.0,
                                        314.0,
                                        145.0,
                                        314.0,
                                        107.0,
                                        327.0,
                                        107.0,
                                        327.0,
                                        145.0,
                                        327.0,
                                        107.0,
                                        407.0,
                                        107.0,
                                        407.0,
                                        145.0,
                                        502.0,
                                        145.0
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
                                        "obj-5",
                                        0
                                    ],
                                    "midpoints": [
                                        520.5,
                                        107.0,
                                        74.0,
                                        107.0,
                                        74.0,
                                        145.0,
                                        74.0,
                                        107.0,
                                        154.0,
                                        107.0,
                                        154.0,
                                        145.0,
                                        154.0,
                                        107.0,
                                        234.0,
                                        107.0,
                                        234.0,
                                        145.0,
                                        234.0,
                                        107.0,
                                        314.0,
                                        107.0,
                                        314.0,
                                        145.0,
                                        314.0,
                                        107.0,
                                        327.0,
                                        107.0,
                                        327.0,
                                        145.0,
                                        327.0,
                                        107.0,
                                        407.0,
                                        107.0,
                                        407.0,
                                        145.0,
                                        73.0,
                                        145.0
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
                                        "obj-2",
                                        0
                                    ],
                                    "midpoints": [
                                        22.0,
                                        218.5,
                                        57.0,
                                        218.5
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
                                        "obj-3",
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
                    "id": "obj-80",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        550.0,
                        10.0,
                        58.0,
                        20.0
                    ],
                    "text": "v0.0.1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-35",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "obj-1",
                        1
                    ],
                    "midpoints": [
                        513.5,
                        61.5,
                        277.5,
                        61.5,
                        277.5,
                        99.5,
                        277.5,
                        67.0,
                        131.0,
                        67.0,
                        131.0,
                        105.0,
                        131.0,
                        67.0,
                        277.0,
                        67.0,
                        277.0,
                        105.0,
                        127.0,
                        105.0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-5",
                        1
                    ],
                    "midpoints": [
                        513.5,
                        65.25,
                        227.0,
                        65.25
                    ],
                    "order": 0,
                    "source": [
                        "obj-1",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-5",
                        0
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
                        "obj-12",
                        0
                    ],
                    "midpoints": [
                        365.0,
                        199.0,
                        337.0,
                        199.0
                    ],
                    "source": [
                        "obj-10",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-13",
                        0
                    ],
                    "source": [
                        "obj-11",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-14",
                        0
                    ],
                    "source": [
                        "obj-12",
                        0
                    ]
                }
            },
            {
                "patchline": {
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
                        233.0,
                        352.0,
                        233.0,
                        388.0,
                        232.0,
                        388.0
                    ],
                    "source": [
                        "obj-13",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        153.33333333333331,
                        273.5,
                        128.5,
                        273.5
                    ],
                    "source": [
                        "obj-13",
                        2
                    ]
                }
            },
            {
                "patchline": {
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
                    ],
                    "source": [
                        "obj-13",
                        1
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
                    ],
                    "source": [
                        "obj-13",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-16",
                        1
                    ],
                    "midpoints": [
                        444.0,
                        276.0,
                        438.0,
                        276.0,
                        438.0,
                        314.0,
                        438.0,
                        277.0,
                        445.0,
                        277.0,
                        445.0,
                        315.0,
                        445.0,
                        352.0,
                        406.5,
                        352.0,
                        406.5,
                        390.0,
                        406.5,
                        352.0,
                        433.0,
                        352.0,
                        433.0,
                        388.0,
                        433.0,
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
                    ],
                    "source": [
                        "obj-14",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-20",
                        0
                    ],
                    "midpoints": [
                        408.3333333333333,
                        273.5,
                        383.5,
                        273.5
                    ],
                    "source": [
                        "obj-14",
                        2
                    ]
                }
            },
            {
                "patchline": {
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
                        471.0,
                        315.0
                    ],
                    "source": [
                        "obj-14",
                        1
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
                        337.0,
                        277.0,
                        322.0,
                        277.0,
                        322.0,
                        315.0,
                        277.0,
                        315.0
                    ],
                    "source": [
                        "obj-14",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-17",
                        0
                    ],
                    "source": [
                        "obj-15",
                        0
                    ]
                }
            },
            {
                "patchline": {
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
                    ],
                    "source": [
                        "obj-16",
                        0
                    ]
                }
            },
            {
                "patchline": {
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
                    ],
                    "source": [
                        "obj-17",
                        1
                    ]
                }
            },
            {
                "patchline": {
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
                    ],
                    "source": [
                        "obj-17",
                        2
                    ]
                }
            },
            {
                "patchline": {
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
                    ],
                    "source": [
                        "obj-17",
                        0
                    ]
                }
            },
            {
                "patchline": {
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
                    ],
                    "source": [
                        "obj-18",
                        1
                    ]
                }
            },
            {
                "patchline": {
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
                    ],
                    "source": [
                        "obj-18",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-31",
                        0
                    ],
                    "midpoints": [
                        128.5,
                        276.0,
                        438.0,
                        276.0,
                        438.0,
                        314.0,
                        438.0,
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
                        315.0,
                        322.0,
                        277.0,
                        253.0,
                        277.0,
                        253.0,
                        315.0,
                        253.0,
                        322.0,
                        354.0,
                        322.0,
                        354.0,
                        360.0,
                        354.0,
                        352.0,
                        247.0,
                        352.0,
                        247.0,
                        390.0,
                        247.0,
                        352.0,
                        233.0,
                        352.0,
                        233.0,
                        388.0,
                        475.0,
                        388.0
                    ],
                    "source": [
                        "obj-19",
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
                    "source": [
                        "obj-2",
                        1
                    ]
                }
            },
            {
                "patchline": {
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
                        16.0,
                        105.0
                    ],
                    "source": [
                        "obj-2",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-31",
                        0
                    ],
                    "midpoints": [
                        383.5,
                        276.0,
                        438.0,
                        276.0,
                        438.0,
                        314.0,
                        438.0,
                        352.0,
                        433.0,
                        352.0,
                        433.0,
                        388.0,
                        475.0,
                        388.0
                    ],
                    "source": [
                        "obj-20",
                        0
                    ]
                }
            },
            {
                "patchline": {
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
                    ],
                    "source": [
                        "obj-26",
                        0
                    ]
                }
            },
            {
                "patchline": {
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
                    ],
                    "source": [
                        "obj-27",
                        0
                    ]
                }
            },
            {
                "patchline": {
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
                    ],
                    "source": [
                        "obj-28",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-30",
                        0
                    ],
                    "midpoints": [
                        323.75,
                        648.5,
                        292.0,
                        648.5
                    ],
                    "source": [
                        "obj-29",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-35",
                        0
                    ],
                    "midpoints": [
                        37.0,
                        99.0,
                        96.0,
                        99.0,
                        96.0,
                        137.0,
                        127.0,
                        137.0
                    ],
                    "source": [
                        "obj-3",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-4",
                        1
                    ],
                    "midpoints": [
                        116.0,
                        99.0,
                        112.0,
                        99.0,
                        112.0,
                        137.0,
                        81.0,
                        137.0
                    ],
                    "source": [
                        "obj-3",
                        1
                    ]
                }
            },
            {
                "patchline": {
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
                    ],
                    "source": [
                        "obj-30",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-34",
                        2
                    ],
                    "midpoints": [
                        475.0,
                        352.0,
                        607.5,
                        352.0,
                        607.5,
                        390.0,
                        607.5,
                        353.0,
                        604.0,
                        353.0,
                        604.0,
                        389.0,
                        604.0,
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
                        607.0,
                        657.0,
                        607.0,
                        657.0,
                        643.0,
                        657.0,
                        652.0,
                        707.0,
                        652.0,
                        707.0,
                        688.0,
                        1113.0,
                        688.0
                    ],
                    "source": [
                        "obj-31",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-33",
                        0
                    ],
                    "source": [
                        "obj-32",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-34",
                        0
                    ],
                    "midpoints": [
                        963.5,
                        277.0,
                        1013.0,
                        277.0,
                        1013.0,
                        313.0,
                        1013.0,
                        353.0,
                        1063.0,
                        353.0,
                        1063.0,
                        389.0,
                        967.0,
                        389.0
                    ],
                    "source": [
                        "obj-33",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-39",
                        0
                    ],
                    "midpoints": [
                        1040.0,
                        738.5,
                        202.0,
                        738.5
                    ],
                    "order": 2,
                    "source": [
                        "obj-34",
                        0
                    ]
                }
            },
            {
                "patchline": {
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
                    ],
                    "order": 0,
                    "source": [
                        "obj-34",
                        0
                    ]
                }
            },
            {
                "patchline": {
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
                    ],
                    "order": 1,
                    "source": [
                        "obj-34",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-36",
                        0
                    ],
                    "midpoints": [
                        185.0,
                        142.0,
                        186.0,
                        142.0,
                        186.0,
                        180.0,
                        202.0,
                        180.0
                    ],
                    "source": [
                        "obj-35",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-37",
                        0
                    ],
                    "source": [
                        "obj-35",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-38",
                        0
                    ],
                    "source": [
                        "obj-36",
                        0
                    ]
                }
            },
            {
                "patchline": {
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
                        232.0,
                        180.0
                    ],
                    "source": [
                        "obj-37",
                        0
                    ]
                }
            },
            {
                "patchline": {
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
                        233.0,
                        352.0,
                        233.0,
                        388.0,
                        233.0,
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
                    ],
                    "source": [
                        "obj-38",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-40",
                        0
                    ],
                    "midpoints": [
                        216.0,
                        776.0,
                        431.0,
                        776.0
                    ],
                    "source": [
                        "obj-39",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        16.0,
                        99.0,
                        112.0,
                        99.0,
                        112.0,
                        137.0,
                        112.0,
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
                        "obj-41",
                        1
                    ],
                    "order": 0,
                    "source": [
                        "obj-40",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-41",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "obj-40",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-45",
                        0
                    ],
                    "midpoints": [
                        580.5,
                        83.25,
                        352.5,
                        83.25
                    ],
                    "source": [
                        "obj-44",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-46",
                        0
                    ],
                    "source": [
                        "obj-45",
                        4
                    ]
                }
            },
            {
                "patchline": {
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
                        472.0,
                        150.0
                    ],
                    "source": [
                        "obj-45",
                        3
                    ]
                }
            },
            {
                "patchline": {
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
                        532.0,
                        150.0
                    ],
                    "source": [
                        "obj-45",
                        2
                    ]
                }
            },
            {
                "patchline": {
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
                        592.0,
                        150.0
                    ],
                    "source": [
                        "obj-45",
                        1
                    ]
                }
            },
            {
                "patchline": {
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
                        637.0,
                        150.0
                    ],
                    "source": [
                        "obj-45",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-40",
                        0
                    ],
                    "midpoints": [
                        440.0,
                        200.0,
                        487.0,
                        200.0,
                        487.0,
                        238.0,
                        487.0,
                        232.0,
                        459.0,
                        232.0,
                        459.0,
                        270.0,
                        459.0,
                        276.0,
                        438.0,
                        276.0,
                        438.0,
                        314.0,
                        438.0,
                        277.0,
                        445.0,
                        277.0,
                        445.0,
                        315.0,
                        445.0,
                        352.0,
                        406.5,
                        352.0,
                        406.5,
                        390.0,
                        406.5,
                        352.0,
                        433.0,
                        352.0,
                        433.0,
                        388.0,
                        433.0,
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
                    ],
                    "source": [
                        "obj-46",
                        0
                    ]
                }
            },
            {
                "patchline": {
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
                        995.0,
                        150.0
                    ],
                    "source": [
                        "obj-47",
                        0
                    ]
                }
            },
            {
                "patchline": {
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
                        365.0,
                        150.0
                    ],
                    "source": [
                        "obj-48",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        605.0,
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
                    ],
                    "source": [
                        "obj-49",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        191.5,
                        67.0,
                        277.0,
                        67.0,
                        277.0,
                        105.0,
                        277.0,
                        99.0,
                        200.0,
                        99.0,
                        200.0,
                        137.0,
                        200.0,
                        142.0,
                        254.0,
                        142.0,
                        254.0,
                        180.0,
                        292.0,
                        180.0
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
                        142.0,
                        393.0,
                        142.0,
                        393.0,
                        198.0,
                        292.0,
                        198.0
                    ],
                    "source": [
                        "obj-50",
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
                        292.0,
                        187.0,
                        305.0,
                        187.0,
                        305.0,
                        225.0,
                        277.0,
                        225.0
                    ],
                    "source": [
                        "obj-6",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-8",
                        0
                    ],
                    "source": [
                        "obj-7",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        626.5,
                        0.0,
                        520.0,
                        0.0,
                        520.0,
                        36.0,
                        520.0,
                        6.5,
                        536.5,
                        6.5,
                        536.5,
                        42.5,
                        191.5,
                        42.5
                    ],
                    "source": [
                        "obj-75",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        232.0,
                        352.0,
                        233.0,
                        352.0,
                        233.0,
                        388.0,
                        202.0,
                        388.0
                    ],
                    "source": [
                        "obj-8",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        339.0,
                        352.0,
                        406.5,
                        352.0,
                        406.5,
                        390.0,
                        406.5,
                        352.0,
                        433.0,
                        352.0,
                        433.0,
                        388.0,
                        574.5,
                        388.0
                    ],
                    "source": [
                        "obj-8",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-29",
                        1
                    ],
                    "midpoints": [
                        267.6666666666667,
                        352.0,
                        233.0,
                        352.0,
                        233.0,
                        388.0,
                        233.0,
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
                    ],
                    "source": [
                        "obj-8",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-31",
                        0
                    ],
                    "midpoints": [
                        303.3333333333333,
                        352.0,
                        433.0,
                        352.0,
                        433.0,
                        388.0,
                        475.0,
                        388.0
                    ],
                    "source": [
                        "obj-8",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-11",
                        0
                    ],
                    "source": [
                        "obj-9",
                        0
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
                        "obj-79",
                        0
                    ],
                    "midpoints": [
                        802.0,
                        103.5,
                        833.0,
                        103.5
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
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        797.0,
                        99.0,
                        96.0,
                        99.0,
                        96.0,
                        137.0,
                        96.0,
                        99.0,
                        200.0,
                        99.0,
                        200.0,
                        137.0,
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
                        577.0,
                        112.0,
                        577.0,
                        150.0,
                        577.0,
                        112.0,
                        622.0,
                        112.0,
                        622.0,
                        150.0,
                        622.0,
                        142.0,
                        322.0,
                        142.0,
                        322.0,
                        180.0,
                        322.0,
                        142.0,
                        393.0,
                        142.0,
                        393.0,
                        198.0,
                        393.0,
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
                        "obj-79",
                        1
                    ],
                    "destination": [
                        "obj-10",
                        0
                    ],
                    "midpoints": [
                        869.0,
                        112.0,
                        468.0,
                        112.0,
                        468.0,
                        150.0,
                        468.0,
                        112.0,
                        513.0,
                        112.0,
                        513.0,
                        150.0,
                        513.0,
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
                        622.0,
                        112.0,
                        622.0,
                        150.0,
                        365.0,
                        150.0
                    ]
                }
            }
        ],
        "autosave": 0,
        "editing_bgcolor": [
            0.333,
            0.333,
            0.333,
            1.0
        ]
    }
}