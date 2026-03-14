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
            34.0,
            104.0,
            1660.0,
            617.0
        ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-1",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1095.0,
                        30.0,
                        144.0,
                        20.0
                    ],
                    "text": "PERFORMANCE PATCH"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-2",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1095.0,
                        75.0,
                        436.0,
                        20.0
                    ],
                    "text": "Audio buses via send~/receive~ \u2014 see subpatchers for details"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-3",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        600.0,
                        30.0,
                        64.0,
                        22.0
                    ],
                    "text": "adc~ 1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        600.0,
                        75.0,
                        93.0,
                        22.0
                    ],
                    "text": "send~ live-input"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-5",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
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
                            100.0,
                            100.0,
                            945.0,
                            560.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-1",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        30.0,
                                        149.0,
                                        22.0
                                    ],
                                    "text": "receive~ live-input"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        300.0,
                                        30.0,
                                        163.0,
                                        20.0
                                    ],
                                    "text": "--- PARAMETRIC EQ ---"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 0,
                                    "id": "obj-3",
                                    "maxclass": "filtergraph~",
                                    "nfilters": 1,
                                    "numinlets": 8,
                                    "numoutlets": 7,
                                    "outlettype": [
                                        "list",
                                        "float",
                                        "float",
                                        "float",
                                        "float",
                                        "list",
                                        "int"
                                    ],
                                    "parameter_enable": 0,
                                    "patching_rect": [
                                        200.0,
                                        30.0,
                                        256.0,
                                        128.0
                                    ],
                                    "setfilter": [
                                        0,
                                        5,
                                        1,
                                        0,
                                        0,
                                        40.0,
                                        1.0,
                                        2.5,
                                        0.0,
                                        0.0,
                                        0.0,
                                        0.0,
                                        0.0,
                                        0.0
                                    ],
                                    "varname": "filtergraph~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        69.0,
                                        22.0
                                    ],
                                    "text": "cascade~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        300.0,
                                        75.0,
                                        280.0,
                                        20.0
                                    ],
                                    "text": "--- 4-BAND MULTIBAND COMPRESSOR ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-6",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "signal",
                                        "signal",
                                        "signal",
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        120.0,
                                        260.0,
                                        22.0
                                    ],
                                    "text": "gen~ @gen crossover-4band.gendsp"
                                }
                            },
                            {
                                "box": {
                                    "args": [
                                        "Low"
                                    ],
                                    "bgmode": 0,
                                    "border": 0,
                                    "clickthrough": 0,
                                    "embed": 1,
                                    "enablehscroll": 0,
                                    "enablevscroll": 0,
                                    "id": "obj-9",
                                    "lockeddragscroll": 0,
                                    "lockedsize": 0,
                                    "maxclass": "bpatcher",
                                    "name": "comp-band.maxpat",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "offset": [
                                        0.0,
                                        0.0
                                    ],
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
                                        "classnamespace": "box",
                                        "rect": [
                                            100.0,
                                            100.0,
                                            550.0,
                                            600.0
                                        ],
                                        "openinpresentation": 1,
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "Signal Input",
                                                    "id": "obj-1",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "signal"
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
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-2",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "signal"
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        70.0,
                                                        200.0,
                                                        22.0
                                                    ],
                                                    "text": "gen~ @gen comp-engine.gendsp"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "Signal Output",
                                                    "id": "obj-3",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        460.0,
                                                        30.0,
                                                        30.0
                                                    ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-4",
                                                    "maxclass": "meter~",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "patching_rect": [
                                                        200.0,
                                                        70.0,
                                                        80.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        164.0,
                                                        140.0,
                                                        16.0
                                                    ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-10",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        200.0,
                                                        30.0,
                                                        100.0,
                                                        20.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        2.0,
                                                        140.0,
                                                        20.0
                                                    ],
                                                    "text": "#1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-30",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "bang"
                                                    ],
                                                    "patching_rect": [
                                                        300.0,
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
                                                    "id": "obj-31",
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
                                                        300.0,
                                                        60.0,
                                                        100.0,
                                                        22.0
                                                    ],
                                                    "text": "trigger b b b b b"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-32",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        300.0,
                                                        95.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "127"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-33",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        350.0,
                                                        95.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "0"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-34",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        400.0,
                                                        95.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "64"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-35",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        300.0,
                                                        130.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "13"
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
                                                        350.0,
                                                        130.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "12"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-45",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 4,
                                                    "outlettype": [
                                                        "",
                                                        "",
                                                        "",
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        300.0,
                                                        170.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "restore": {
                                                        "atk": [
                                                            13
                                                        ],
                                                        "gain": [
                                                            64
                                                        ],
                                                        "number": [
                                                            103.54330708661418
                                                        ],
                                                        "number[1]": [
                                                            10.325984251968505
                                                        ],
                                                        "number[2]": [
                                                            0.09448818897637778
                                                        ],
                                                        "number[3]": [
                                                            2.047244094488189
                                                        ],
                                                        "number[4]": [
                                                            -10.393700787401576
                                                        ],
                                                        "ratio": [
                                                            7
                                                        ],
                                                        "rel": [
                                                            12
                                                        ],
                                                        "thresh": [
                                                            105
                                                        ]
                                                    },
                                                    "text": "autopattr @autoname 1",
                                                    "varname": "u408006803"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-5-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        200.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        20.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Thresh"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-5",
                                                    "maxclass": "dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        218.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        34.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "thresh"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-16",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        265.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 -60. 0."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-40",
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
                                                        80.0,
                                                        265.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        76.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number[4]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-17",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        295.0,
                                                        110.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend range"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-6-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        150.0,
                                                        200.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        20.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Ratio"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-6",
                                                    "maxclass": "dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [
                                                        150.0,
                                                        218.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        34.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "ratio"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-18",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        150.0,
                                                        265.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 1. 20."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-41",
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
                                                        200.0,
                                                        265.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        76.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number[3]"
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
                                                        150.0,
                                                        295.0,
                                                        110.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend ratio"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-7-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        270.0,
                                                        200.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        99.0,
                                                        20.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Gain"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-7",
                                                    "maxclass": "dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [
                                                        270.0,
                                                        218.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        99.0,
                                                        34.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "gain"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-24",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        270.0,
                                                        265.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 -12. 12."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-42",
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
                                                        320.0,
                                                        265.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        99.0,
                                                        76.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number[2]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-25",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        270.0,
                                                        295.0,
                                                        121.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend smoothGain"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-8-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        360.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        94.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Atk"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-8",
                                                    "maxclass": "dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        378.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        108.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "atk"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-20",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        425.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 0.1 100."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-43",
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
                                                        80.0,
                                                        425.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        150.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number[1]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-21",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        455.0,
                                                        110.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend attack"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-9-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        150.0,
                                                        360.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        94.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Rel"
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
                                                        150.0,
                                                        378.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        108.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "rel"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-22",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        150.0,
                                                        425.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 10. 1000."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-44",
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
                                                        200.0,
                                                        425.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        150.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-23",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        150.0,
                                                        455.0,
                                                        110.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend release"
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
                                                    "source": [
                                                        "obj-1",
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
                                                    "order": 1,
                                                    "source": [
                                                        "obj-16",
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
                                                    "order": 0,
                                                    "source": [
                                                        "obj-16",
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
                                                    "source": [
                                                        "obj-17",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-19",
                                                        0
                                                    ],
                                                    "order": 1,
                                                    "source": [
                                                        "obj-18",
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
                                                    "order": 0,
                                                    "source": [
                                                        "obj-18",
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
                                                    "order": 1,
                                                    "source": [
                                                        "obj-2",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-4",
                                                        0
                                                    ],
                                                    "order": 0,
                                                    "source": [
                                                        "obj-2",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-21",
                                                        0
                                                    ],
                                                    "order": 1,
                                                    "source": [
                                                        "obj-20",
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
                                                    "order": 0,
                                                    "source": [
                                                        "obj-20",
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
                                                    "source": [
                                                        "obj-21",
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
                                                    "order": 1,
                                                    "source": [
                                                        "obj-22",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-44",
                                                        0
                                                    ],
                                                    "order": 0,
                                                    "source": [
                                                        "obj-22",
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
                                                    "source": [
                                                        "obj-23",
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
                                                    "order": 1,
                                                    "source": [
                                                        "obj-24",
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
                                                    "order": 0,
                                                    "source": [
                                                        "obj-24",
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
                                                    "source": [
                                                        "obj-25",
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
                                                    "source": [
                                                        "obj-30",
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
                                                    "source": [
                                                        "obj-31",
                                                        4
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
                                                        "obj-31",
                                                        3
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-34",
                                                        0
                                                    ],
                                                    "source": [
                                                        "obj-31",
                                                        2
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-35",
                                                        0
                                                    ],
                                                    "source": [
                                                        "obj-31",
                                                        1
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-36",
                                                        0
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
                                                        "obj-5",
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
                                                        "obj-6",
                                                        0
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
                                                        "obj-7",
                                                        0
                                                    ],
                                                    "source": [
                                                        "obj-34",
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
                                                        "obj-35",
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
                                                    "source": [
                                                        "obj-36",
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
                                                    "source": [
                                                        "obj-5",
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
                                                    "source": [
                                                        "obj-6",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-24",
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
                                                        "obj-20",
                                                        0
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
                                                        "obj-22",
                                                        0
                                                    ],
                                                    "source": [
                                                        "obj-9",
                                                        0
                                                    ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [
                                        30.0,
                                        185.0,
                                        155.0,
                                        185.0
                                    ],
                                    "varname": "comp-band[3]",
                                    "viewvisibility": 1
                                }
                            },
                            {
                                "box": {
                                    "args": [
                                        "Lo-Mid"
                                    ],
                                    "bgmode": 0,
                                    "border": 0,
                                    "clickthrough": 0,
                                    "embed": 1,
                                    "enablehscroll": 0,
                                    "enablevscroll": 0,
                                    "id": "obj-10",
                                    "lockeddragscroll": 0,
                                    "lockedsize": 0,
                                    "maxclass": "bpatcher",
                                    "name": "comp-band.maxpat",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "offset": [
                                        0.0,
                                        0.0
                                    ],
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
                                        "classnamespace": "box",
                                        "rect": [
                                            100.0,
                                            100.0,
                                            550.0,
                                            600.0
                                        ],
                                        "openinpresentation": 1,
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "Signal Input",
                                                    "id": "obj-1",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "signal"
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
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-2",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "signal"
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        70.0,
                                                        200.0,
                                                        22.0
                                                    ],
                                                    "text": "gen~ @gen comp-engine.gendsp"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "Signal Output",
                                                    "id": "obj-3",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        460.0,
                                                        30.0,
                                                        30.0
                                                    ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-4",
                                                    "maxclass": "meter~",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "patching_rect": [
                                                        200.0,
                                                        70.0,
                                                        80.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        164.0,
                                                        140.0,
                                                        16.0
                                                    ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-10",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        200.0,
                                                        30.0,
                                                        100.0,
                                                        20.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        2.0,
                                                        140.0,
                                                        20.0
                                                    ],
                                                    "text": "#1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-30",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "bang"
                                                    ],
                                                    "patching_rect": [
                                                        300.0,
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
                                                    "id": "obj-31",
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
                                                        300.0,
                                                        60.0,
                                                        100.0,
                                                        22.0
                                                    ],
                                                    "text": "trigger b b b b b"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-32",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        300.0,
                                                        95.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "127"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-33",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        350.0,
                                                        95.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "0"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-34",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        400.0,
                                                        95.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "64"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-35",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        300.0,
                                                        130.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "13"
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
                                                        350.0,
                                                        130.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "12"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-45",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 4,
                                                    "outlettype": [
                                                        "",
                                                        "",
                                                        "",
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        300.0,
                                                        170.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "restore": {
                                                        "atk": [
                                                            13
                                                        ],
                                                        "gain": [
                                                            64
                                                        ],
                                                        "number": [
                                                            103.54330708661418
                                                        ],
                                                        "number[1]": [
                                                            10.325984251968505
                                                        ],
                                                        "number[2]": [
                                                            0.09448818897637778
                                                        ],
                                                        "number[3]": [
                                                            2.9448818897637796
                                                        ],
                                                        "number[4]": [
                                                            -3.307086614173229
                                                        ],
                                                        "ratio": [
                                                            13
                                                        ],
                                                        "rel": [
                                                            12
                                                        ],
                                                        "thresh": [
                                                            120
                                                        ]
                                                    },
                                                    "text": "autopattr @autoname 1",
                                                    "varname": "u602006802"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-5-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        200.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        20.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Thresh"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-5",
                                                    "maxclass": "dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        218.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        34.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "thresh"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-16",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        265.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 -60. 0."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-40",
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
                                                        80.0,
                                                        265.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        76.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number[4]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-17",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        295.0,
                                                        110.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend range"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-6-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        150.0,
                                                        200.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        20.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Ratio"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-6",
                                                    "maxclass": "dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [
                                                        150.0,
                                                        218.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        34.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "ratio"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-18",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        150.0,
                                                        265.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 1. 20."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-41",
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
                                                        200.0,
                                                        265.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        76.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number[3]"
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
                                                        150.0,
                                                        295.0,
                                                        110.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend ratio"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-7-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        270.0,
                                                        200.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        99.0,
                                                        20.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Gain"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-7",
                                                    "maxclass": "dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [
                                                        270.0,
                                                        218.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        99.0,
                                                        34.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "gain"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-24",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        270.0,
                                                        265.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 -12. 12."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-42",
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
                                                        320.0,
                                                        265.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        99.0,
                                                        76.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number[2]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-25",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        270.0,
                                                        295.0,
                                                        121.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend smoothGain"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-8-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        360.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        94.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Atk"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-8",
                                                    "maxclass": "dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        378.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        108.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "atk"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-20",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        425.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 0.1 100."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-43",
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
                                                        80.0,
                                                        425.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        150.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number[1]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-21",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        455.0,
                                                        110.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend attack"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-9-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        150.0,
                                                        360.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        94.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Rel"
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
                                                        150.0,
                                                        378.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        108.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "rel"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-22",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        150.0,
                                                        425.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 10. 1000."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-44",
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
                                                        200.0,
                                                        425.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        150.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-23",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        150.0,
                                                        455.0,
                                                        110.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend release"
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
                                                    "source": [
                                                        "obj-1",
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
                                                    "order": 1,
                                                    "source": [
                                                        "obj-16",
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
                                                    "order": 0,
                                                    "source": [
                                                        "obj-16",
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
                                                    "source": [
                                                        "obj-17",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-19",
                                                        0
                                                    ],
                                                    "order": 1,
                                                    "source": [
                                                        "obj-18",
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
                                                    "order": 0,
                                                    "source": [
                                                        "obj-18",
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
                                                    "order": 1,
                                                    "source": [
                                                        "obj-2",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-4",
                                                        0
                                                    ],
                                                    "order": 0,
                                                    "source": [
                                                        "obj-2",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-21",
                                                        0
                                                    ],
                                                    "order": 1,
                                                    "source": [
                                                        "obj-20",
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
                                                    "order": 0,
                                                    "source": [
                                                        "obj-20",
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
                                                    "source": [
                                                        "obj-21",
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
                                                    "order": 1,
                                                    "source": [
                                                        "obj-22",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-44",
                                                        0
                                                    ],
                                                    "order": 0,
                                                    "source": [
                                                        "obj-22",
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
                                                    "source": [
                                                        "obj-23",
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
                                                    "order": 1,
                                                    "source": [
                                                        "obj-24",
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
                                                    "order": 0,
                                                    "source": [
                                                        "obj-24",
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
                                                    "source": [
                                                        "obj-25",
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
                                                    "source": [
                                                        "obj-30",
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
                                                    "source": [
                                                        "obj-31",
                                                        4
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
                                                        "obj-31",
                                                        3
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-34",
                                                        0
                                                    ],
                                                    "source": [
                                                        "obj-31",
                                                        2
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-35",
                                                        0
                                                    ],
                                                    "source": [
                                                        "obj-31",
                                                        1
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-36",
                                                        0
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
                                                        "obj-5",
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
                                                        "obj-6",
                                                        0
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
                                                        "obj-7",
                                                        0
                                                    ],
                                                    "source": [
                                                        "obj-34",
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
                                                        "obj-35",
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
                                                    "source": [
                                                        "obj-36",
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
                                                    "source": [
                                                        "obj-5",
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
                                                    "source": [
                                                        "obj-6",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-24",
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
                                                        "obj-20",
                                                        0
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
                                                        "obj-22",
                                                        0
                                                    ],
                                                    "source": [
                                                        "obj-9",
                                                        0
                                                    ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [
                                        200.0,
                                        185.0,
                                        155.0,
                                        185.0
                                    ],
                                    "varname": "comp-band[2]",
                                    "viewvisibility": 1
                                }
                            },
                            {
                                "box": {
                                    "args": [
                                        "Hi-Mid"
                                    ],
                                    "bgmode": 0,
                                    "border": 0,
                                    "clickthrough": 0,
                                    "embed": 1,
                                    "enablehscroll": 0,
                                    "enablevscroll": 0,
                                    "id": "obj-11",
                                    "lockeddragscroll": 0,
                                    "lockedsize": 0,
                                    "maxclass": "bpatcher",
                                    "name": "comp-band.maxpat",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "offset": [
                                        0.0,
                                        0.0
                                    ],
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
                                        "classnamespace": "box",
                                        "rect": [
                                            100.0,
                                            100.0,
                                            550.0,
                                            600.0
                                        ],
                                        "openinpresentation": 1,
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "Signal Input",
                                                    "id": "obj-1",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "signal"
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
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-2",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "signal"
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        70.0,
                                                        200.0,
                                                        22.0
                                                    ],
                                                    "text": "gen~ @gen comp-engine.gendsp"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "Signal Output",
                                                    "id": "obj-3",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        460.0,
                                                        30.0,
                                                        30.0
                                                    ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-4",
                                                    "maxclass": "meter~",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "patching_rect": [
                                                        200.0,
                                                        70.0,
                                                        80.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        164.0,
                                                        140.0,
                                                        16.0
                                                    ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-10",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        200.0,
                                                        30.0,
                                                        100.0,
                                                        20.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        2.0,
                                                        140.0,
                                                        20.0
                                                    ],
                                                    "text": "#1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-30",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "bang"
                                                    ],
                                                    "patching_rect": [
                                                        300.0,
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
                                                    "id": "obj-31",
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
                                                        300.0,
                                                        60.0,
                                                        100.0,
                                                        22.0
                                                    ],
                                                    "text": "trigger b b b b b"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-32",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        300.0,
                                                        95.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "127"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-33",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        350.0,
                                                        95.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "0"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-34",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        400.0,
                                                        95.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "64"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-35",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        300.0,
                                                        130.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "13"
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
                                                        350.0,
                                                        130.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "12"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-45",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 4,
                                                    "outlettype": [
                                                        "",
                                                        "",
                                                        "",
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        300.0,
                                                        170.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "restore": {
                                                        "atk": [
                                                            13
                                                        ],
                                                        "gain": [
                                                            64
                                                        ],
                                                        "number": [
                                                            103.54330708661418
                                                        ],
                                                        "number[1]": [
                                                            10.325984251968505
                                                        ],
                                                        "number[2]": [
                                                            0.09448818897637778
                                                        ],
                                                        "number[3]": [
                                                            1.1496062992125984
                                                        ],
                                                        "number[4]": [
                                                            -4.251968503937007
                                                        ],
                                                        "ratio": [
                                                            1
                                                        ],
                                                        "rel": [
                                                            12
                                                        ],
                                                        "thresh": [
                                                            118
                                                        ]
                                                    },
                                                    "text": "autopattr @autoname 1",
                                                    "varname": "u763006801"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-5-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        200.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        20.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Thresh"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-5",
                                                    "maxclass": "dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        218.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        34.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "thresh"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-16",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        265.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 -60. 0."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-40",
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
                                                        80.0,
                                                        265.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        76.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number[4]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-17",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        295.0,
                                                        110.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend range"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-6-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        150.0,
                                                        200.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        20.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Ratio"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-6",
                                                    "maxclass": "dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [
                                                        150.0,
                                                        218.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        34.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "ratio"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-18",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        150.0,
                                                        265.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 1. 20."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-41",
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
                                                        200.0,
                                                        265.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        76.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number[3]"
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
                                                        150.0,
                                                        295.0,
                                                        110.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend ratio"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-7-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        270.0,
                                                        200.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        99.0,
                                                        20.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Gain"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-7",
                                                    "maxclass": "dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [
                                                        270.0,
                                                        218.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        99.0,
                                                        34.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "gain"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-24",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        270.0,
                                                        265.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 -12. 12."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-42",
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
                                                        320.0,
                                                        265.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        99.0,
                                                        76.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number[2]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-25",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        270.0,
                                                        295.0,
                                                        121.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend smoothGain"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-8-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        360.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        94.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Atk"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-8",
                                                    "maxclass": "dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        378.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        108.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "atk"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-20",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        425.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 0.1 100."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-43",
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
                                                        80.0,
                                                        425.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        150.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number[1]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-21",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        455.0,
                                                        110.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend attack"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-9-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        150.0,
                                                        360.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        94.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Rel"
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
                                                        150.0,
                                                        378.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        108.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "rel"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-22",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        150.0,
                                                        425.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 10. 1000."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-44",
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
                                                        200.0,
                                                        425.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        150.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-23",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        150.0,
                                                        455.0,
                                                        110.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend release"
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
                                                    "source": [
                                                        "obj-1",
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
                                                    "order": 1,
                                                    "source": [
                                                        "obj-16",
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
                                                    "order": 0,
                                                    "source": [
                                                        "obj-16",
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
                                                    "source": [
                                                        "obj-17",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-19",
                                                        0
                                                    ],
                                                    "order": 1,
                                                    "source": [
                                                        "obj-18",
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
                                                    "order": 0,
                                                    "source": [
                                                        "obj-18",
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
                                                    "order": 1,
                                                    "source": [
                                                        "obj-2",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-4",
                                                        0
                                                    ],
                                                    "order": 0,
                                                    "source": [
                                                        "obj-2",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-21",
                                                        0
                                                    ],
                                                    "order": 1,
                                                    "source": [
                                                        "obj-20",
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
                                                    "order": 0,
                                                    "source": [
                                                        "obj-20",
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
                                                    "source": [
                                                        "obj-21",
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
                                                    "order": 1,
                                                    "source": [
                                                        "obj-22",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-44",
                                                        0
                                                    ],
                                                    "order": 0,
                                                    "source": [
                                                        "obj-22",
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
                                                    "source": [
                                                        "obj-23",
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
                                                    "order": 1,
                                                    "source": [
                                                        "obj-24",
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
                                                    "order": 0,
                                                    "source": [
                                                        "obj-24",
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
                                                    "source": [
                                                        "obj-25",
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
                                                    "source": [
                                                        "obj-30",
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
                                                    "source": [
                                                        "obj-31",
                                                        4
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
                                                        "obj-31",
                                                        3
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-34",
                                                        0
                                                    ],
                                                    "source": [
                                                        "obj-31",
                                                        2
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-35",
                                                        0
                                                    ],
                                                    "source": [
                                                        "obj-31",
                                                        1
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-36",
                                                        0
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
                                                        "obj-5",
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
                                                        "obj-6",
                                                        0
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
                                                        "obj-7",
                                                        0
                                                    ],
                                                    "source": [
                                                        "obj-34",
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
                                                        "obj-35",
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
                                                    "source": [
                                                        "obj-36",
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
                                                    "source": [
                                                        "obj-5",
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
                                                    "source": [
                                                        "obj-6",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-24",
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
                                                        "obj-20",
                                                        0
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
                                                        "obj-22",
                                                        0
                                                    ],
                                                    "source": [
                                                        "obj-9",
                                                        0
                                                    ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [
                                        370.0,
                                        185.0,
                                        155.0,
                                        185.0
                                    ],
                                    "varname": "comp-band[1]",
                                    "viewvisibility": 1
                                }
                            },
                            {
                                "box": {
                                    "args": [
                                        "High"
                                    ],
                                    "bgmode": 0,
                                    "border": 0,
                                    "clickthrough": 0,
                                    "embed": 1,
                                    "enablehscroll": 0,
                                    "enablevscroll": 0,
                                    "id": "obj-12",
                                    "lockeddragscroll": 0,
                                    "lockedsize": 0,
                                    "maxclass": "bpatcher",
                                    "name": "comp-band.maxpat",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "offset": [
                                        0.0,
                                        0.0
                                    ],
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
                                        "classnamespace": "box",
                                        "rect": [
                                            100.0,
                                            100.0,
                                            550.0,
                                            600.0
                                        ],
                                        "openinpresentation": 1,
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "Signal Input",
                                                    "id": "obj-1",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "signal"
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
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-2",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "signal"
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        70.0,
                                                        200.0,
                                                        22.0
                                                    ],
                                                    "text": "gen~ @gen comp-engine.gendsp"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "Signal Output",
                                                    "id": "obj-3",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        460.0,
                                                        30.0,
                                                        30.0
                                                    ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-4",
                                                    "maxclass": "meter~",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "patching_rect": [
                                                        200.0,
                                                        70.0,
                                                        80.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        164.0,
                                                        140.0,
                                                        16.0
                                                    ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-10",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        200.0,
                                                        30.0,
                                                        100.0,
                                                        20.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        2.0,
                                                        140.0,
                                                        20.0
                                                    ],
                                                    "text": "#1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-30",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "bang"
                                                    ],
                                                    "patching_rect": [
                                                        300.0,
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
                                                    "id": "obj-31",
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
                                                        300.0,
                                                        60.0,
                                                        100.0,
                                                        22.0
                                                    ],
                                                    "text": "trigger b b b b b"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-32",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        300.0,
                                                        95.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "127"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-33",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        350.0,
                                                        95.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "0"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-34",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        400.0,
                                                        95.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "64"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-35",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        300.0,
                                                        130.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "13"
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
                                                        350.0,
                                                        130.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "12"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-45",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 4,
                                                    "outlettype": [
                                                        "",
                                                        "",
                                                        "",
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        359.0,
                                                        218.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "restore": {
                                                        "atk": [
                                                            13
                                                        ],
                                                        "gain": [
                                                            64
                                                        ],
                                                        "number": [
                                                            103.54330708661418
                                                        ],
                                                        "number[1]": [
                                                            10.325984251968505
                                                        ],
                                                        "number[2]": [
                                                            0.09448818897637778
                                                        ],
                                                        "number[3]": [
                                                            1.7480314960629921
                                                        ],
                                                        "number[4]": [
                                                            -1.4173228346456668
                                                        ],
                                                        "ratio": [
                                                            5
                                                        ],
                                                        "rel": [
                                                            12
                                                        ],
                                                        "thresh": [
                                                            124
                                                        ]
                                                    },
                                                    "text": "autopattr @autoname 1",
                                                    "varname": "u766006800"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-5-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        200.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        20.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Thresh"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-5",
                                                    "maxclass": "dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        218.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        34.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "thresh"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-16",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        265.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 -60. 0."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-40",
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
                                                        80.0,
                                                        265.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        76.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number[4]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-17",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        295.0,
                                                        110.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend range"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-6-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        150.0,
                                                        200.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        20.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Ratio"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-6",
                                                    "maxclass": "dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [
                                                        150.0,
                                                        218.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        34.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "ratio"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-18",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        150.0,
                                                        265.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 1. 20."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-41",
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
                                                        200.0,
                                                        265.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        76.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number[3]"
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
                                                        150.0,
                                                        295.0,
                                                        110.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend ratio"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-7-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        270.0,
                                                        200.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        99.0,
                                                        20.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Gain"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-7",
                                                    "maxclass": "dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [
                                                        270.0,
                                                        218.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        99.0,
                                                        34.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "gain"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-24",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        270.0,
                                                        265.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 -12. 12."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-42",
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
                                                        320.0,
                                                        265.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        99.0,
                                                        76.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number[2]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-25",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        270.0,
                                                        295.0,
                                                        121.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend smoothGain"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-8-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        360.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        94.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Atk"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-8",
                                                    "maxclass": "dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        "float"
                                                    ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [
                                                        30.0,
                                                        378.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        108.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "atk"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-20",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        425.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 0.1 100."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-43",
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
                                                        80.0,
                                                        425.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        5.0,
                                                        150.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number[1]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-21",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        30.0,
                                                        455.0,
                                                        110.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend attack"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 10.0,
                                                    "id": "obj-9-lbl",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [
                                                        150.0,
                                                        360.0,
                                                        50.0,
                                                        18.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        94.0,
                                                        42.0,
                                                        18.0
                                                    ],
                                                    "text": "Rel"
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
                                                        150.0,
                                                        378.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        108.0,
                                                        40.0,
                                                        40.0
                                                    ],
                                                    "varname": "rel"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-22",
                                                    "maxclass": "newobj",
                                                    "numinlets": 6,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        150.0,
                                                        425.0,
                                                        140.0,
                                                        22.0
                                                    ],
                                                    "text": "scale 0 127 10. 1000."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 9.0,
                                                    "format": 6,
                                                    "id": "obj-44",
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
                                                        200.0,
                                                        425.0,
                                                        55.0,
                                                        19.0
                                                    ],
                                                    "presentation": 1,
                                                    "presentation_rect": [
                                                        52.0,
                                                        150.0,
                                                        42.0,
                                                        19.0
                                                    ],
                                                    "triangle": 0,
                                                    "varname": "number"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0,
                                                    "id": "obj-23",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        150.0,
                                                        455.0,
                                                        110.0,
                                                        22.0
                                                    ],
                                                    "text": "prepend release"
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
                                                    "source": [
                                                        "obj-1",
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
                                                    "order": 1,
                                                    "source": [
                                                        "obj-16",
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
                                                    "order": 0,
                                                    "source": [
                                                        "obj-16",
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
                                                    "source": [
                                                        "obj-17",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-19",
                                                        0
                                                    ],
                                                    "order": 1,
                                                    "source": [
                                                        "obj-18",
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
                                                    "order": 0,
                                                    "source": [
                                                        "obj-18",
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
                                                    "order": 1,
                                                    "source": [
                                                        "obj-2",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-4",
                                                        0
                                                    ],
                                                    "order": 0,
                                                    "source": [
                                                        "obj-2",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-21",
                                                        0
                                                    ],
                                                    "order": 1,
                                                    "source": [
                                                        "obj-20",
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
                                                    "order": 0,
                                                    "source": [
                                                        "obj-20",
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
                                                    "source": [
                                                        "obj-21",
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
                                                    "order": 1,
                                                    "source": [
                                                        "obj-22",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-44",
                                                        0
                                                    ],
                                                    "order": 0,
                                                    "source": [
                                                        "obj-22",
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
                                                    "source": [
                                                        "obj-23",
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
                                                    "order": 1,
                                                    "source": [
                                                        "obj-24",
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
                                                    "order": 0,
                                                    "source": [
                                                        "obj-24",
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
                                                    "source": [
                                                        "obj-25",
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
                                                    "source": [
                                                        "obj-30",
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
                                                    "source": [
                                                        "obj-31",
                                                        4
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
                                                        "obj-31",
                                                        3
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-34",
                                                        0
                                                    ],
                                                    "source": [
                                                        "obj-31",
                                                        2
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-35",
                                                        0
                                                    ],
                                                    "source": [
                                                        "obj-31",
                                                        1
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-36",
                                                        0
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
                                                        "obj-5",
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
                                                        "obj-6",
                                                        0
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
                                                        "obj-7",
                                                        0
                                                    ],
                                                    "source": [
                                                        "obj-34",
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
                                                        "obj-35",
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
                                                    "source": [
                                                        "obj-36",
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
                                                    "source": [
                                                        "obj-5",
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
                                                    "source": [
                                                        "obj-6",
                                                        0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [
                                                        "obj-24",
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
                                                        "obj-20",
                                                        0
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
                                                        "obj-22",
                                                        0
                                                    ],
                                                    "source": [
                                                        "obj-9",
                                                        0
                                                    ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [
                                        540.0,
                                        185.0,
                                        155.0,
                                        185.0
                                    ],
                                    "varname": "comp-band",
                                    "viewvisibility": 1
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-13",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        115.0,
                                        385.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "+~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-14",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        455.0,
                                        385.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "+~"
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
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        285.0,
                                        420.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "+~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-16",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        285.0,
                                        455.0,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "send~ proc-out"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-7",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        500.0,
                                        30.0,
                                        140.0,
                                        22.0
                                    ],
                                    "restore": {
                                        "filtergraph~": [
                                            1,
                                            0,
                                            5,
                                            1,
                                            0,
                                            0,
                                            40.0,
                                            1.0,
                                            2.5
                                        ]
                                    },
                                    "text": "autopattr @autoname 1",
                                    "varname": "u_autopattr"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-17",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        500.0,
                                        120.0,
                                        365.0,
                                        22.0
                                    ],
                                    "saved_object_attributes": {
                                        "client_rect": [
                                            4,
                                            44,
                                            358,
                                            172
                                        ],
                                        "parameter_enable": 0,
                                        "parameter_mappable": 0,
                                        "storage_rect": [
                                            583,
                                            69,
                                            1034,
                                            197
                                        ]
                                    },
                                    "text": "pattrstorage comp-state @greedy 1 @autorestore 1 @savemode 3",
                                    "varname": "comp-state"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-18",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        500.0,
                                        60.0,
                                        80.0,
                                        22.0
                                    ],
                                    "text": "closebang"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-19",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        500.0,
                                        90.0,
                                        60.0,
                                        22.0
                                    ],
                                    "text": "store 1"
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
                                        600.0,
                                        60.0,
                                        80.0,
                                        22.0
                                    ],
                                    "text": "loadmess 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-21",
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        850.0,
                                        10.0,
                                        30.0,
                                        30.0
                                    ],
                                    "comment": "pcontrol inlet"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-4",
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
                                        "obj-13",
                                        1
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
                                        "obj-14",
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
                                        1
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
                                        0
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
                                        "obj-15",
                                        1
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
                                        "obj-16",
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
                                        "obj-19",
                                        0
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
                                        "obj-17",
                                        0
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
                                        "obj-4",
                                        1
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
                                        "obj-6",
                                        0
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
                                        "obj-10",
                                        0
                                    ],
                                    "source": [
                                        "obj-6",
                                        1
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
                                        "obj-6",
                                        2
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-12",
                                        0
                                    ],
                                    "source": [
                                        "obj-6",
                                        3
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-9",
                                        0
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
                                        "obj-13",
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
                                    "destination": [
                                        "obj-17",
                                        0
                                    ],
                                    "source": [
                                        "obj-20",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        990.0,
                        30.0,
                        107.0,
                        22.0
                    ],
                    "text": "p input-processing",
                    "varname": "input-processing"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-6",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
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
                            100.0,
                            100.0,
                            400.0,
                            300.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-1",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        1305.0,
                                        30.0,
                                        303.0,
                                        20.0
                                    ],
                                    "text": "--- MIDI TRIGGER (note 64 = next cue) ---"
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
                                        51.0,
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
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        62.5,
                                        22.0
                                    ],
                                    "text": "stripnote"
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
                                        "bang",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        120.0,
                                        71.0,
                                        22.0
                                    ],
                                    "text": "select 64"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        1305.0,
                                        75.0,
                                        170.0,
                                        20.0
                                    ],
                                    "text": "--- MANUAL TRIGGER ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-6",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        90.0,
                                        30.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "receive next-cue"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-7",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 5,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "int",
                                        "",
                                        "",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        60.0,
                                        150.0,
                                        81.5,
                                        22.0
                                    ],
                                    "text": "counter 0 1 99"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        60.0,
                                        195.0,
                                        97.5,
                                        22.0
                                    ],
                                    "text": "send cue-number"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-9",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        1305.0,
                                        135.0,
                                        177.0,
                                        20.0
                                    ],
                                    "text": "--- CUE DATA (coll) ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-10",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        165.0,
                                        195.0,
                                        67.0,
                                        22.0
                                    ],
                                    "saved_object_attributes": {
                                        "embed": 0,
                                        "precision": 6
                                    },
                                    "text": "coll cue-data"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-11",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        195.0,
                                        30.0,
                                        62.0,
                                        22.0
                                    ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-12",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        75.0,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "read cue-data.txt"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-13",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        1305.0,
                                        180.0,
                                        534.0,
                                        20.0
                                    ],
                                    "text": "delay_send dist_send det_send del_time del_fb dist_drv det_amt sf1 sf2 sf3"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-14",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 10,
                                    "outlettype": [
                                        "float",
                                        "float",
                                        "float",
                                        "float",
                                        "float",
                                        "float",
                                        "float",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        135.0,
                                        240.0,
                                        116.0,
                                        22.0
                                    ],
                                    "text": "unpack f f f f f f f s s s"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-15",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        150.0,
                                        285.0,
                                        97.5,
                                        22.0
                                    ],
                                    "text": "send delay-send-lvl"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-16",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        270.0,
                                        285.0,
                                        97.5,
                                        22.0
                                    ],
                                    "text": "send dist-send-lvl"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-17",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        375.0,
                                        285.0,
                                        97.5,
                                        22.0
                                    ],
                                    "text": "send detune-send-lvl"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-18",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        480.0,
                                        285.0,
                                        97.5,
                                        22.0
                                    ],
                                    "text": "send delay-time"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-19",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        600.0,
                                        285.0,
                                        97.5,
                                        22.0
                                    ],
                                    "text": "send delay-fb"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-20",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        720.0,
                                        285.0,
                                        97.5,
                                        22.0
                                    ],
                                    "text": "send dist-drive"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-21",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        825.0,
                                        285.0,
                                        97.5,
                                        22.0
                                    ],
                                    "text": "send detune-amt"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-22",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        930.0,
                                        285.0,
                                        97.5,
                                        22.0
                                    ],
                                    "text": "send sfplay-1-trigger"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-23",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        1050.0,
                                        285.0,
                                        97.5,
                                        22.0
                                    ],
                                    "text": "send sfplay-2-trigger"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-24",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        1170.0,
                                        285.0,
                                        97.5,
                                        22.0
                                    ],
                                    "text": "send sfplay-3-trigger"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-25",
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        850.0,
                                        10.0,
                                        30.0,
                                        30.0
                                    ],
                                    "comment": "pcontrol inlet"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-14",
                                        0
                                    ],
                                    "midpoints": [
                                        174.5,
                                        228.5,
                                        144.5,
                                        228.5
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
                                        "obj-12",
                                        0
                                    ],
                                    "midpoints": [
                                        204.5,
                                        63.5,
                                        159.5,
                                        63.5
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
                                        "obj-10",
                                        0
                                    ],
                                    "midpoints": [
                                        159.5,
                                        146.0,
                                        174.5,
                                        146.0
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
                                        0
                                    ],
                                    "midpoints": [
                                        144.5,
                                        273.5,
                                        159.5,
                                        273.5
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
                                        "obj-16",
                                        0
                                    ],
                                    "midpoints": [
                                        155.27777777777777,
                                        273.5,
                                        279.5,
                                        273.5
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
                                        "obj-17",
                                        0
                                    ],
                                    "midpoints": [
                                        166.05555555555554,
                                        273.5,
                                        384.5,
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
                                        "obj-18",
                                        0
                                    ],
                                    "midpoints": [
                                        176.83333333333334,
                                        273.5,
                                        489.5,
                                        273.5
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
                                        "obj-19",
                                        0
                                    ],
                                    "midpoints": [
                                        187.61111111111111,
                                        273.5,
                                        609.5,
                                        273.5
                                    ],
                                    "source": [
                                        "obj-14",
                                        4
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
                                        198.38888888888889,
                                        273.5,
                                        729.5,
                                        273.5
                                    ],
                                    "source": [
                                        "obj-14",
                                        5
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
                                        209.16666666666669,
                                        273.5,
                                        834.5,
                                        273.5
                                    ],
                                    "source": [
                                        "obj-14",
                                        6
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
                                        219.94444444444446,
                                        273.5,
                                        939.5,
                                        273.5
                                    ],
                                    "source": [
                                        "obj-14",
                                        7
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
                                        230.72222222222223,
                                        273.5,
                                        1059.5,
                                        273.5
                                    ],
                                    "source": [
                                        "obj-14",
                                        8
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
                                        241.5,
                                        273.5,
                                        1179.5,
                                        273.5
                                    ],
                                    "source": [
                                        "obj-14",
                                        9
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-3",
                                        1
                                    ],
                                    "midpoints": [
                                        55.5,
                                        63.5,
                                        83.0,
                                        63.5
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
                                        "obj-3",
                                        0
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
                                        "obj-4",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        108.5,
                                        39.5,
                                        108.5
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
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        146.0,
                                        69.5,
                                        146.0
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
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        99.5,
                                        101.0,
                                        69.5,
                                        101.0
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
                                        "obj-10",
                                        0
                                    ],
                                    "midpoints": [
                                        69.5,
                                        183.5,
                                        174.5,
                                        183.5
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-7",
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
                                    "midpoints": [
                                        69.5,
                                        183.5,
                                        69.5,
                                        183.5
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-7",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        990.0,
                        75.0,
                        86.0,
                        22.0
                    ],
                    "text": "p cue-system",
                    "varname": "cue-system"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-7",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
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
                            100.0,
                            100.0,
                            400.0,
                            300.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-1",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        465.0,
                                        30.0,
                                        170.0,
                                        20.0
                                    ],
                                    "text": "--- FEEDBACK DELAY ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        30.0,
                                        94.0,
                                        22.0
                                    ],
                                    "text": "receive~ proc-out"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        135.0,
                                        30.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "receive delay-send-lvl"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        75.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 50"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        165.0,
                                        120.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
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
                                        105.0,
                                        150.0,
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
                                    "id": "obj-7",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        225.0,
                                        195.0,
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
                                    "id": "obj-8",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "tapconnect"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        195.0,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "tapin~ 5000"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-9",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        285.0,
                                        195.0,
                                        80.0,
                                        22.0
                                    ],
                                    "text": "tapout~ 500"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-10",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        240.0,
                                        30.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "receive delay-time"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-11",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        330.0,
                                        30.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "receive delay-fb"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-12",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        345.0,
                                        75.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 50"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-13",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        360.0,
                                        120.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-14",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        375.0,
                                        195.0,
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
                                    "id": "obj-15",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        120.0,
                                        195.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ delay-ret"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-16",
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        850.0,
                                        10.0,
                                        30.0,
                                        30.0
                                    ],
                                    "comment": "pcontrol inlet"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-9",
                                        0
                                    ],
                                    "midpoints": [
                                        249.5,
                                        123.5,
                                        294.5,
                                        123.5
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
                                        "obj-12",
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
                                        "obj-13",
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
                                        "obj-14",
                                        1
                                    ],
                                    "midpoints": [
                                        369.5,
                                        168.5,
                                        407.5,
                                        168.5
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
                                        "obj-7",
                                        1
                                    ],
                                    "midpoints": [
                                        384.5,
                                        206.0,
                                        263.0,
                                        206.0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        101.0,
                                        114.5,
                                        101.0
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
                                        "obj-4",
                                        0
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
                                        "obj-5",
                                        0
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
                                        "obj-6",
                                        1
                                    ],
                                    "midpoints": [
                                        174.5,
                                        146.0,
                                        137.5,
                                        146.0
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
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        114.5,
                                        183.5,
                                        234.5,
                                        183.5
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
                                    "midpoints": [
                                        234.5,
                                        206.0,
                                        39.5,
                                        206.0
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
                                        "obj-9",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        206.0,
                                        294.5,
                                        206.0
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
                                        "obj-14",
                                        0
                                    ],
                                    "midpoints": [
                                        294.5,
                                        206.0,
                                        384.5,
                                        206.0
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-9",
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
                                        294.5,
                                        206.0,
                                        129.5,
                                        206.0
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-9",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        990.0,
                        135.0,
                        100.0,
                        22.0
                    ],
                    "text": "p feedback-delay",
                    "varname": "feedback-delay"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-8",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
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
                            100.0,
                            100.0,
                            400.0,
                            300.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-1",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        360.0,
                                        30.0,
                                        233.0,
                                        20.0
                                    ],
                                    "text": "--- DISTORTION (overdrive~) ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        30.0,
                                        94.0,
                                        22.0
                                    ],
                                    "text": "receive~ proc-out"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        240.0,
                                        30.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "receive dist-send-lvl"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        255.0,
                                        75.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 50"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        255.0,
                                        120.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
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
                                        150.0,
                                        150.0,
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
                                    "id": "obj-7",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        120.0,
                                        195.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "overdrive~ 1."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        135.0,
                                        30.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "receive dist-drive"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-9",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        135.0,
                                        240.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ dist-ret"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-10",
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        850.0,
                                        10.0,
                                        30.0,
                                        30.0
                                    ],
                                    "comment": "pcontrol inlet"
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
                                        39.5,
                                        101.0,
                                        159.5,
                                        101.0
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
                                        "obj-4",
                                        0
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
                                        "obj-5",
                                        0
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
                                        "obj-6",
                                        1
                                    ],
                                    "midpoints": [
                                        264.5,
                                        146.0,
                                        182.5,
                                        146.0
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
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        159.5,
                                        183.5,
                                        129.5,
                                        183.5
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
                                        "obj-9",
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
                                        "obj-7",
                                        1
                                    ],
                                    "midpoints": [
                                        144.5,
                                        123.5,
                                        217.5,
                                        123.5
                                    ],
                                    "source": [
                                        "obj-8",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        990.0,
                        180.0,
                        86.0,
                        22.0
                    ],
                    "text": "p distortion",
                    "varname": "distortion"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-9",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
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
                            100.0,
                            100.0,
                            400.0,
                            300.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-1",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        360.0,
                                        30.0,
                                        205.0,
                                        20.0
                                    ],
                                    "text": "--- DETUNE (freqshift~) ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        30.0,
                                        94.0,
                                        22.0
                                    ],
                                    "text": "receive~ proc-out"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        240.0,
                                        30.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "receive detune-send-lvl"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        255.0,
                                        75.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 50"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        255.0,
                                        120.0,
                                        39.0,
                                        22.0
                                    ],
                                    "text": "line~"
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
                                        150.0,
                                        150.0,
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
                                    "id": "obj-7",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        120.0,
                                        195.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "freqshift~ 5."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        135.0,
                                        30.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "receive detune-amt"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-9",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        135.0,
                                        240.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ detune-ret"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-10",
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        850.0,
                                        10.0,
                                        30.0,
                                        30.0
                                    ],
                                    "comment": "pcontrol inlet"
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
                                        39.5,
                                        101.0,
                                        159.5,
                                        101.0
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
                                        "obj-4",
                                        0
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
                                        "obj-5",
                                        0
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
                                        "obj-6",
                                        1
                                    ],
                                    "midpoints": [
                                        264.5,
                                        146.0,
                                        182.5,
                                        146.0
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
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        159.5,
                                        183.5,
                                        129.5,
                                        183.5
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
                                        "obj-9",
                                        0
                                    ],
                                    "midpoints": [
                                        129.5,
                                        228.5,
                                        144.5,
                                        228.5
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
                                        "obj-7",
                                        1
                                    ],
                                    "midpoints": [
                                        144.5,
                                        123.5,
                                        217.5,
                                        123.5
                                    ],
                                    "source": [
                                        "obj-8",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        990.0,
                        240.0,
                        86.0,
                        22.0
                    ],
                    "text": "p detune",
                    "varname": "detune"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-10",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
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
                            100.0,
                            100.0,
                            400.0,
                            300.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-1",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        615.0,
                                        30.0,
                                        254.0,
                                        20.0
                                    ],
                                    "text": "--- 3x STEREO SOUNDFILE PLAYER ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        615.0,
                                        75.0,
                                        128.0,
                                        20.0
                                    ],
                                    "text": "--- Player 1 ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        30.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "receive sfplay-1-trigger"
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
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        101.0,
                                        22.0
                                    ],
                                    "text": "route none"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "bang",
                                        ""
                                    ],
                                    "patching_rect": [
                                        45.0,
                                        120.0,
                                        80.5,
                                        22.0
                                    ],
                                    "text": "trigger b s"
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
                                        30.0,
                                        150.0,
                                        97.0,
                                        22.0
                                    ],
                                    "text": "prepend open"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-7",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "signal",
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        195.0,
                                        172.0,
                                        22.0
                                    ],
                                    "text": "sfplay~ 2"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        150.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-9",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        105.0,
                                        240.0,
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
                                    "id": "obj-10",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        105.0,
                                        285.0,
                                        42.0,
                                        22.0
                                    ],
                                    "text": "*~ 0.5"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-11",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        615.0,
                                        135.0,
                                        128.0,
                                        20.0
                                    ],
                                    "text": "--- Player 2 ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-12",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        135.0,
                                        30.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "receive sfplay-2-trigger"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-13",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        75.0,
                                        101.0,
                                        22.0
                                    ],
                                    "text": "route none"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-14",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "bang",
                                        ""
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        120.0,
                                        80.5,
                                        22.0
                                    ],
                                    "text": "trigger b s"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-15",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        195.0,
                                        150.0,
                                        97.0,
                                        22.0
                                    ],
                                    "text": "prepend open"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-16",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "signal",
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        225.0,
                                        195.0,
                                        172.0,
                                        22.0
                                    ],
                                    "text": "sfplay~ 2"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-17",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        315.0,
                                        150.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "1"
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
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        285.0,
                                        240.0,
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
                                    "id": "obj-19",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        285.0,
                                        285.0,
                                        42.0,
                                        22.0
                                    ],
                                    "text": "*~ 0.5"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-20",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        615.0,
                                        180.0,
                                        128.0,
                                        20.0
                                    ],
                                    "text": "--- Player 3 ---"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-21",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        225.0,
                                        30.0,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "receive sfplay-3-trigger"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-22",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        255.0,
                                        75.0,
                                        101.0,
                                        22.0
                                    ],
                                    "text": "route none"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-23",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "bang",
                                        ""
                                    ],
                                    "patching_rect": [
                                        270.0,
                                        120.0,
                                        80.5,
                                        22.0
                                    ],
                                    "text": "trigger b s"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-24",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        360.0,
                                        150.0,
                                        97.0,
                                        22.0
                                    ],
                                    "text": "prepend open"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-25",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "signal",
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        405.0,
                                        195.0,
                                        172.0,
                                        22.0
                                    ],
                                    "text": "sfplay~ 2"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-26",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        480.0,
                                        150.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-27",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        480.0,
                                        240.0,
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
                                    "id": "obj-28",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        480.0,
                                        285.0,
                                        42.0,
                                        22.0
                                    ],
                                    "text": "*~ 0.5"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-29",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        615.0,
                                        225.0,
                                        149.0,
                                        20.0
                                    ],
                                    "text": "--- Sum Players ---"
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
                                        195.0,
                                        330.0,
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
                                    "id": "obj-31",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        330.0,
                                        360.0,
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
                                    "id": "obj-32",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        315.0,
                                        405.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "send~ sfplay-ret"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-33",
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        850.0,
                                        10.0,
                                        30.0,
                                        30.0
                                    ],
                                    "comment": "pcontrol inlet"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-30",
                                        0
                                    ],
                                    "midpoints": [
                                        114.5,
                                        318.5,
                                        204.5,
                                        318.5
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
                                    "midpoints": [
                                        144.5,
                                        63.5,
                                        159.5,
                                        63.5
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
                                        "obj-14",
                                        0
                                    ],
                                    "midpoints": [
                                        241.5,
                                        108.5,
                                        159.5,
                                        108.5
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
                                        "obj-15",
                                        0
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
                                        "obj-17",
                                        0
                                    ],
                                    "midpoints": [
                                        159.5,
                                        146.0,
                                        324.5,
                                        146.0
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
                                        "obj-16",
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
                                        1
                                    ],
                                    "source": [
                                        "obj-16",
                                        1
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
                                        234.5,
                                        228.5,
                                        294.5,
                                        228.5
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
                                        324.5,
                                        183.5,
                                        234.5,
                                        183.5
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
                                        "obj-19",
                                        0
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
                                        "obj-30",
                                        1
                                    ],
                                    "midpoints": [
                                        294.5,
                                        318.5,
                                        233.0,
                                        318.5
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
                                        "obj-22",
                                        0
                                    ],
                                    "midpoints": [
                                        234.5,
                                        63.5,
                                        264.5,
                                        63.5
                                    ],
                                    "source": [
                                        "obj-21",
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
                                        346.5,
                                        108.5,
                                        279.5,
                                        108.5
                                    ],
                                    "source": [
                                        "obj-22",
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
                                        341.0,
                                        146.0,
                                        369.5,
                                        146.0
                                    ],
                                    "source": [
                                        "obj-23",
                                        1
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
                                        279.5,
                                        146.0,
                                        489.5,
                                        146.0
                                    ],
                                    "source": [
                                        "obj-23",
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
                                    "source": [
                                        "obj-24",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-27",
                                        1
                                    ],
                                    "midpoints": [
                                        491.0,
                                        228.5,
                                        518.0,
                                        228.5
                                    ],
                                    "source": [
                                        "obj-25",
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
                                        414.5,
                                        228.5,
                                        489.5,
                                        228.5
                                    ],
                                    "source": [
                                        "obj-25",
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
                                        489.5,
                                        183.5,
                                        414.5,
                                        183.5
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
                                        0
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
                                        "obj-31",
                                        1
                                    ],
                                    "midpoints": [
                                        489.5,
                                        333.5,
                                        368.0,
                                        333.5
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
                                        "obj-4",
                                        0
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
                                        "obj-31",
                                        0
                                    ],
                                    "midpoints": [
                                        204.5,
                                        356.0,
                                        339.5,
                                        356.0
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
                                        "obj-32",
                                        0
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
                                        "obj-5",
                                        0
                                    ],
                                    "midpoints": [
                                        121.5,
                                        108.5,
                                        54.5,
                                        108.5
                                    ],
                                    "source": [
                                        "obj-4",
                                        1
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
                                        116.0,
                                        146.0,
                                        39.5,
                                        146.0
                                    ],
                                    "source": [
                                        "obj-5",
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-8",
                                        0
                                    ],
                                    "midpoints": [
                                        54.5,
                                        146.0,
                                        159.5,
                                        146.0
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
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        183.5,
                                        39.5,
                                        183.5
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
                                        "obj-9",
                                        1
                                    ],
                                    "midpoints": [
                                        116.0,
                                        228.5,
                                        143.0,
                                        228.5
                                    ],
                                    "source": [
                                        "obj-7",
                                        1
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
                                        39.5,
                                        228.5,
                                        114.5,
                                        228.5
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
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        159.5,
                                        183.5,
                                        39.5,
                                        183.5
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
                                        "obj-10",
                                        0
                                    ],
                                    "source": [
                                        "obj-9",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        990.0,
                        285.0,
                        103.0,
                        22.0
                    ],
                    "text": "p soundfile-player",
                    "varname": "soundfile-player"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-11",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1095.0,
                        135.0,
                        205.0,
                        20.0
                    ],
                    "text": "========== MIXER =========="
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-12",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        30.0,
                        30.0,
                        102.0,
                        22.0
                    ],
                    "text": "receive~ proc-out"
                }
            },
            {
                "box": {
                    "id": "obj-13",
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
                        60.0,
                        75.0,
                        22.0,
                        140.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        62.0,
                        38.0,
                        150.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-14",
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
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        62.0,
                        62.0,
                        22.0,
                        150.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-15",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1095.0,
                        180.0,
                        40.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        35.0,
                        90.0,
                        20.0
                    ],
                    "text": "DRY"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-16",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        135.0,
                        30.0,
                        104.0,
                        22.0
                    ],
                    "text": "receive~ delay-ret"
                }
            },
            {
                "box": {
                    "id": "obj-17",
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
                        180.0,
                        75.0,
                        22.0,
                        140.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        120.0,
                        62.0,
                        38.0,
                        150.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-18",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        195.0,
                        75.0,
                        15.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        162.0,
                        62.0,
                        22.0,
                        150.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-19",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1095.0,
                        225.0,
                        51.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        120.0,
                        35.0,
                        90.0,
                        20.0
                    ],
                    "text": "DELAY"
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
                        "signal"
                    ],
                    "patching_rect": [
                        255.0,
                        30.0,
                        94.0,
                        22.0
                    ],
                    "text": "receive~ dist-ret"
                }
            },
            {
                "box": {
                    "id": "obj-21",
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
                        285.0,
                        75.0,
                        22.0,
                        140.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        220.0,
                        62.0,
                        38.0,
                        150.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-22",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        315.0,
                        75.0,
                        15.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        262.0,
                        62.0,
                        22.0,
                        150.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-23",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1095.0,
                        285.0,
                        44.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        220.0,
                        35.0,
                        90.0,
                        20.0
                    ],
                    "text": "DIST"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-24",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        360.0,
                        30.0,
                        112.0,
                        22.0
                    ],
                    "text": "receive~ detune-ret"
                }
            },
            {
                "box": {
                    "id": "obj-25",
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
                        390.0,
                        75.0,
                        22.0,
                        140.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        320.0,
                        62.0,
                        38.0,
                        150.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-26",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        420.0,
                        75.0,
                        15.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        362.0,
                        62.0,
                        22.0,
                        150.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-27",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1095.0,
                        330.0,
                        58.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        320.0,
                        35.0,
                        90.0,
                        20.0
                    ],
                    "text": "DETUNE"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-28",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        465.0,
                        30.0,
                        107.0,
                        22.0
                    ],
                    "text": "receive~ sfplay-ret"
                }
            },
            {
                "box": {
                    "id": "obj-29",
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
                        495.0,
                        75.0,
                        22.0,
                        140.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        420.0,
                        62.0,
                        38.0,
                        150.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-30",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        525.0,
                        75.0,
                        15.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        462.0,
                        62.0,
                        22.0,
                        150.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-31",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1095.0,
                        375.0,
                        51.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        420.0,
                        35.0,
                        90.0,
                        20.0
                    ],
                    "text": "FILES"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-32",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        105.0,
                        225.0,
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
                    "id": "obj-33",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        180.0,
                        270.0,
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
                    "id": "obj-34",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        285.0,
                        315.0,
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
                    "id": "obj-35",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        390.0,
                        360.0,
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
                    "id": "obj-36",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1545.0,
                        30.0,
                        114.0,
                        20.0
                    ],
                    "text": "--- MASTER ---"
                }
            },
            {
                "box": {
                    "id": "obj-37",
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
                        390.0,
                        405.0,
                        22.0,
                        140.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        520.0,
                        62.0,
                        38.0,
                        150.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-38",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        420.0,
                        405.0,
                        15.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        562.0,
                        62.0,
                        22.0,
                        150.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-39",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1545.0,
                        75.0,
                        59.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        520.0,
                        35.0,
                        90.0,
                        20.0
                    ],
                    "text": "MASTER"
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
                    "id": "obj-40",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        390.0,
                        555.0,
                        35.0,
                        22.0
                    ],
                    "text": "dac~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-41",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1545.0,
                        135.0,
                        156.0,
                        20.0
                    ],
                    "text": "--- CUE CONTROLS ---"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-42",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        735.0,
                        30.0,
                        115.0,
                        22.0
                    ],
                    "text": "receive cue-number"
                }
            },
            {
                "box": {
                    "id": "obj-43",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        750.0,
                        75.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        70.0,
                        227.0,
                        60.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-44",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        855.0,
                        0.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        205.0,
                        227.0,
                        28.0,
                        28.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-45",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        855.0,
                        30.0,
                        97.5,
                        22.0
                    ],
                    "text": "send next-cue"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-46",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1545.0,
                        180.0,
                        44.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        227.0,
                        45.0,
                        20.0
                    ],
                    "text": "CUE:"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-47",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1545.0,
                        225.0,
                        44.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        150.0,
                        227.0,
                        50.0,
                        20.0
                    ],
                    "text": "NEXT"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-48",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1545.0,
                        285.0,
                        144.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        250.0,
                        227.0,
                        200.0,
                        20.0
                    ],
                    "text": "PERFORMANCE PATCH"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-49",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1545.0,
                        390.0,
                        100.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        258.0,
                        120.0,
                        19.0
                    ],
                    "text": "SUBPATCHERS"
                }
            },
            {
                "box": {
                    "id": "obj-50",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1545.0,
                        420.0,
                        85.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        280.0,
                        85.0,
                        22.0
                    ],
                    "text": "Input"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-51",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1545.0,
                        447.0,
                        38.0,
                        22.0
                    ],
                    "text": "open"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-52",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1545.0,
                        474.0,
                        56.0,
                        22.0
                    ],
                    "text": "pcontrol"
                }
            },
            {
                "box": {
                    "id": "obj-53",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1705.0,
                        420.0,
                        85.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        115.0,
                        280.0,
                        85.0,
                        22.0
                    ],
                    "text": "Cues"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-54",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1705.0,
                        447.0,
                        38.0,
                        22.0
                    ],
                    "text": "open"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-55",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1705.0,
                        474.0,
                        56.0,
                        22.0
                    ],
                    "text": "pcontrol"
                }
            },
            {
                "box": {
                    "id": "obj-56",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1865.0,
                        420.0,
                        85.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        210.0,
                        280.0,
                        85.0,
                        22.0
                    ],
                    "text": "Delay"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-57",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1865.0,
                        447.0,
                        38.0,
                        22.0
                    ],
                    "text": "open"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-58",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1865.0,
                        474.0,
                        56.0,
                        22.0
                    ],
                    "text": "pcontrol"
                }
            },
            {
                "box": {
                    "id": "obj-59",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1545.0,
                        500.0,
                        85.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        305.0,
                        280.0,
                        85.0,
                        22.0
                    ],
                    "text": "Distortion"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-60",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1545.0,
                        527.0,
                        38.0,
                        22.0
                    ],
                    "text": "open"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-61",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1545.0,
                        554.0,
                        56.0,
                        22.0
                    ],
                    "text": "pcontrol"
                }
            },
            {
                "box": {
                    "id": "obj-62",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1705.0,
                        500.0,
                        85.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        400.0,
                        280.0,
                        85.0,
                        22.0
                    ],
                    "text": "Detune"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-63",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1705.0,
                        527.0,
                        38.0,
                        22.0
                    ],
                    "text": "open"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-64",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1705.0,
                        554.0,
                        56.0,
                        22.0
                    ],
                    "text": "pcontrol"
                }
            },
            {
                "box": {
                    "id": "obj-65",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1865.0,
                        500.0,
                        85.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        495.0,
                        280.0,
                        85.0,
                        22.0
                    ],
                    "text": "Soundfiles"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-66",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1865.0,
                        527.0,
                        38.0,
                        22.0
                    ],
                    "text": "open"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-67",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1865.0,
                        554.0,
                        56.0,
                        22.0
                    ],
                    "text": "pcontrol"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-13",
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
                        "obj-14",
                        0
                    ],
                    "midpoints": [
                        112.0,
                        220.0,
                        112.0,
                        67.0,
                        99.0,
                        67.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-13",
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
                        69.5,
                        220.0,
                        114.5,
                        220.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-13",
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
                        "obj-16",
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
                        217.0,
                        220.0,
                        217.0,
                        67.0,
                        204.0,
                        67.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-17",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-32",
                        1
                    ],
                    "midpoints": [
                        189.5,
                        220.0,
                        143.0,
                        220.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-17",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-21",
                        0
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
                        "obj-22",
                        0
                    ],
                    "midpoints": [
                        337.0,
                        220.0,
                        337.0,
                        67.0,
                        324.0,
                        67.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-21",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-33",
                        1
                    ],
                    "midpoints": [
                        294.5,
                        242.5,
                        218.0,
                        242.5
                    ],
                    "order": 1,
                    "source": [
                        "obj-21",
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
                    "source": [
                        "obj-24",
                        0
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
                        442.0,
                        220.0,
                        442.0,
                        67.0,
                        429.0,
                        67.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-25",
                        0
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
                        399.5,
                        265.0,
                        323.0,
                        265.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-25",
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
                        547.0,
                        220.0,
                        547.0,
                        67.0,
                        534.0,
                        67.0
                    ],
                    "order": 0,
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
                        1
                    ],
                    "midpoints": [
                        504.5,
                        287.5,
                        428.0,
                        287.5
                    ],
                    "order": 1,
                    "source": [
                        "obj-29",
                        0
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
                        609.5,
                        63.5,
                        609.5,
                        63.5
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
                        "obj-33",
                        0
                    ],
                    "midpoints": [
                        114.5,
                        258.5,
                        189.5,
                        258.5
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
                        189.5,
                        303.5,
                        294.5,
                        303.5
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
                        "obj-35",
                        0
                    ],
                    "midpoints": [
                        294.5,
                        348.5,
                        399.5,
                        348.5
                    ],
                    "source": [
                        "obj-34",
                        0
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
                    "midpoints": [
                        442.0,
                        550.0,
                        442.0,
                        397.0,
                        429.0,
                        397.0
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
                        "obj-43",
                        0
                    ],
                    "source": [
                        "obj-42",
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
                        864.5,
                        27.0,
                        864.5,
                        27.0
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
                        "obj-51",
                        0
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
                        "obj-52",
                        0
                    ],
                    "source": [
                        "obj-51",
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
                    "source": [
                        "obj-52",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-54",
                        0
                    ],
                    "source": [
                        "obj-53",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-55",
                        0
                    ],
                    "source": [
                        "obj-54",
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
                    "source": [
                        "obj-55",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-57",
                        0
                    ],
                    "source": [
                        "obj-56",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-58",
                        0
                    ],
                    "source": [
                        "obj-57",
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
                    "source": [
                        "obj-58",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-60",
                        0
                    ],
                    "source": [
                        "obj-59",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-61",
                        0
                    ],
                    "source": [
                        "obj-60",
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
                        "obj-61",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-63",
                        0
                    ],
                    "source": [
                        "obj-62",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-64",
                        0
                    ],
                    "source": [
                        "obj-63",
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
                    "source": [
                        "obj-64",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-66",
                        0
                    ],
                    "source": [
                        "obj-65",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-67",
                        0
                    ],
                    "source": [
                        "obj-66",
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
                    "source": [
                        "obj-67",
                        0
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