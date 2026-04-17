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
            1043.0,
            707.0
        ],
        "boxes": [
            {
                "box": {
                    "bgcolor": [
                        0.88,
                        0.9,
                        0.95,
                        1.0
                    ],
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "id": "obj-1",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        660.0,
                        30.0,
                        267.0,
                        24.0
                    ],
                    "text": "Intelligent Corpus Remixer",
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
                    "id": "obj-2",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        660.0,
                        90.0,
                        100.0,
                        20.0
                    ],
                    "text": "Drop audio →",
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
                    "id": "obj-3",
                    "maxclass": "dropfile",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        30.0,
                        100.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        20.0,
                        200.0,
                        40.0
                    ]
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
                        30.0,
                        100.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        20.0,
                        85.0,
                        22.0
                    ],
                    "text": "read"
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
                        "float",
                        "bang"
                    ],
                    "patching_rect": [
                        120.0,
                        195.0,
                        147.0,
                        22.0
                    ],
                    "text": "buffer~ source"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-6",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "float",
                        "bang"
                    ],
                    "patching_rect": [
                        660.0,
                        135.0,
                        147.0,
                        22.0
                    ],
                    "text": "buffer~ onsets"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-7",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        660.0,
                        180.0,
                        93.0,
                        20.0
                    ],
                    "text": "K clusters:",
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
                    "id": "obj-8",
                    "maxclass": "number",
                    "maximum": 16,
                    "minimum": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        165.0,
                        240.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        310.0,
                        20.0,
                        60.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-9",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        255.0,
                        30.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        380.0,
                        20.0,
                        24.0,
                        24.0
                    ]
                }
            },
            {
                "box": {
                    "border": 0,
                    "filename": "fluid.plotter",
                    "id": "obj-10",
                    "maxclass": "jsui",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        120.0,
                        346.0,
                        101.0,
                        101.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        60.0,
                        101.0,
                        101.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-11",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        495.0,
                        30.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        480.0,
                        70.0,
                        24.0,
                        24.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-12",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        660.0,
                        240.0,
                        44.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        510.0,
                        73.0,
                        50.0,
                        20.0
                    ],
                    "text": "loop",
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
                    "id": "obj-13",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        450.0,
                        30.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        480.0,
                        110.0,
                        24.0,
                        24.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-14",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        660.0,
                        285.0,
                        58.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        510.0,
                        113.0,
                        70.0,
                        20.0
                    ],
                    "text": "random",
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
                    "id": "obj-15",
                    "maxclass": "number",
                    "maximum": 2000,
                    "minimum": 20,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        450.0,
                        240.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        480.0,
                        145.0,
                        80.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-16",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        660.0,
                        330.0,
                        79.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        570.0,
                        148.0,
                        80.0,
                        20.0
                    ],
                    "text": "rate (ms)",
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
                    "id": "obj-17",
                    "maxclass": "number",
                    "maximum": 15,
                    "minimum": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        300.0,
                        30.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        480.0,
                        180.0,
                        80.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-18",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        660.0,
                        390.0,
                        65.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        570.0,
                        183.0,
                        100.0,
                        20.0
                    ],
                    "text": "cluster",
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
                    "id": "obj-19",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        450.0,
                        270.0,
                        79.0,
                        22.0
                    ],
                    "text": "metro 250"
                }
            },
            {
                "box": {
                    "id": "obj-20",
                    "lastchannelcount": 0,
                    "maxclass": "live.gain~",
                    "numinlets": 2,
                    "numoutlets": 5,
                    "outlettype": [
                        "signal",
                        "signal",
                        "",
                        "float",
                        "list"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        360.0,
                        480.0,
                        48.0,
                        136.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        480.0,
                        240.0,
                        60.0,
                        180.0
                    ],
                    "varname": "live.gain~"
                }
            },
            {
                "box": {
                    "id": "obj-21",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        420.0,
                        480.0,
                        15.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        550.0,
                        240.0,
                        30.0,
                        180.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-22",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        270.0,
                        270.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        430.0,
                        60.0,
                        22.0
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
                        945.0,
                        30.0,
                        58.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        90.0,
                        432.0,
                        60.0,
                        20.0
                    ],
                    "text": "slices",
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
                    "bgcolor": [
                        0.92,
                        0.85,
                        0.85,
                        1.0
                    ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-24",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        345.0,
                        645.0,
                        72.0,
                        22.0
                    ],
                    "text": "dac~ 1 2"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-25",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "bang",
                        ""
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
                            600.0,
                            400.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "read bang after buffer~ load",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "bang"
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
                                    "comment": "analysis-done bang",
                                    "id": "obj-2",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        30.0,
                                        450.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "slice count",
                                    "id": "obj-3",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        150.0,
                                        450.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        90.0,
                                        640.0,
                                        22.0
                                    ],
                                    "text": "fluid.bufonsetslice~ @source source @indices onsets @threshold 0.5 @minslicelength 8 @blocking 1"
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
                                        "float",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        700.0,
                                        30.0,
                                        147.0,
                                        22.0
                                    ],
                                    "text": "buffer~ mfcc_feat"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-6",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "float",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        700.0,
                                        75.0,
                                        147.0,
                                        22.0
                                    ],
                                    "text": "buffer~ mfcc_mean"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-7",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        135.0,
                                        640.0,
                                        22.0
                                    ],
                                    "text": "fluid.bufmfcc~ @source source @features mfcc_feat @numcoeffs 13 @startcoeff 1 @blocking 1",
                                    "varname": "bufmfcc"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        180.0,
                                        500.0,
                                        22.0
                                    ],
                                    "text": "fluid.bufstats~ @source mfcc_feat @stats mfcc_mean @select mean @blocking 1",
                                    "varname": "bufstats"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-9",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        225.0,
                                        200.0,
                                        22.0
                                    ],
                                    "text": "fluid.dataset~ descriptors",
                                    "varname": "descriptors"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-10",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "bang",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        300.0,
                                        120.0,
                                        22.0
                                    ],
                                    "text": "js analyze.js"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-11",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "bang",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        390.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "t b b"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-12",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "float",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        700.0,
                                        120.0,
                                        147.0,
                                        22.0
                                    ],
                                    "text": "buffer~ mfcc_flat"
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
                                        30.0,
                                        255.0,
                                        450.0,
                                        22.0
                                    ],
                                    "text": "fluid.bufflatten~ @source mfcc_mean @destination mfcc_flat @blocking 1",
                                    "varname": "bufflatten"
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
                                        "obj-4",
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
                                        "obj-2",
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
                                        "obj-3",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        225.0,
                        240.0,
                        86.0,
                        22.0
                    ],
                    "text": "p analysis"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-26",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "bang",
                        ""
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
                            400.0,
                            300.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "fit bang",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "bang"
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
                                    "comment": "K (num clusters)",
                                    "id": "obj-2",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        75.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "fit-done bang",
                                    "id": "obj-3",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        1125.0,
                                        120.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "labels-ready bang",
                                    "id": "obj-4",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        1275.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ]
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
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        150.0,
                                        165.0,
                                        128.0,
                                        22.0
                                    ],
                                    "text": "fluid.normalize~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-6",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        375.0,
                                        165.0,
                                        429.0,
                                        22.0
                                    ],
                                    "text": "fluid.umap~ @numdimensions 2 @numneighbours 15 @mindist 0.1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-7",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        825.0,
                                        165.0,
                                        212.0,
                                        22.0
                                    ],
                                    "text": "fluid.kmeans~ @numclusters 4"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        1440.0,
                                        30.0,
                                        233.0,
                                        22.0
                                    ],
                                    "text": "fluid.dataset~ descriptors_norm"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-9",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        1440.0,
                                        75.0,
                                        219.0,
                                        22.0
                                    ],
                                    "text": "fluid.dataset~ descriptors_2d"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-10",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        1440.0,
                                        135.0,
                                        226.0,
                                        22.0
                                    ],
                                    "text": "fluid.labelset~ cluster_labels"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-11",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        120.0,
                                        75.0,
                                        170.0,
                                        22.0
                                    ],
                                    "text": "numclusters $1"
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
                                        30.0,
                                        120.0,
                                        359.0,
                                        22.0
                                    ],
                                    "text": "fittransform descriptors descriptors_norm"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-13",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        405.0,
                                        120.0,
                                        380.0,
                                        22.0
                                    ],
                                    "text": "fittransform descriptors_norm descriptors_2d"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-14",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        795.0,
                                        120.0,
                                        317.0,
                                        22.0
                                    ],
                                    "text": "fit descriptors_norm cluster_labels"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-15",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "t b b b b"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-16",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1170.0,
                                        120.0,
                                        219.0,
                                        22.0
                                    ],
                                    "text": "labels cluster_labels"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-15",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        22.0,
                                        67.0,
                                        22.0,
                                        67.0,
                                        68.0,
                                        39.5,
                                        68.0
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
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        129.5,
                                        112.0,
                                        397.0,
                                        112.0,
                                        397.0,
                                        150.0,
                                        397.0,
                                        112.0,
                                        397.0,
                                        112.0,
                                        397.0,
                                        150.0,
                                        397.0,
                                        112.0,
                                        787.0,
                                        112.0,
                                        787.0,
                                        150.0,
                                        787.0,
                                        157.0,
                                        286.0,
                                        157.0,
                                        286.0,
                                        195.0,
                                        286.0,
                                        157.0,
                                        367.0,
                                        157.0,
                                        367.0,
                                        195.0,
                                        834.5,
                                        195.0
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
                                        "obj-5",
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
                                        "obj-6",
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
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        804.5,
                                        153.5,
                                        834.5,
                                        153.5
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
                                        "obj-12",
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
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        59.5,
                                        67.0,
                                        298.0,
                                        67.0,
                                        298.0,
                                        105.0,
                                        298.0,
                                        112.0,
                                        397.0,
                                        112.0,
                                        397.0,
                                        150.0,
                                        414.5,
                                        150.0
                                    ],
                                    "source": [
                                        "obj-15",
                                        1
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
                                        79.5,
                                        67.0,
                                        298.0,
                                        67.0,
                                        298.0,
                                        105.0,
                                        298.0,
                                        112.0,
                                        397.0,
                                        112.0,
                                        397.0,
                                        150.0,
                                        397.0,
                                        112.0,
                                        397.0,
                                        112.0,
                                        397.0,
                                        150.0,
                                        804.5,
                                        150.0
                                    ],
                                    "source": [
                                        "obj-15",
                                        2
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
                                        99.5,
                                        67.0,
                                        298.0,
                                        67.0,
                                        298.0,
                                        105.0,
                                        298.0,
                                        112.0,
                                        1117.0,
                                        112.0,
                                        1117.0,
                                        158.0,
                                        1117.0,
                                        112.0,
                                        397.0,
                                        112.0,
                                        397.0,
                                        150.0,
                                        397.0,
                                        112.0,
                                        793.0,
                                        112.0,
                                        793.0,
                                        150.0,
                                        793.0,
                                        112.0,
                                        787.0,
                                        112.0,
                                        787.0,
                                        150.0,
                                        1179.5,
                                        150.0
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-15",
                                        3
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
                                        99.5,
                                        67.0,
                                        298.0,
                                        67.0,
                                        298.0,
                                        105.0,
                                        298.0,
                                        112.0,
                                        397.0,
                                        112.0,
                                        397.0,
                                        150.0,
                                        397.0,
                                        112.0,
                                        793.0,
                                        112.0,
                                        793.0,
                                        150.0,
                                        793.0,
                                        112.0,
                                        787.0,
                                        112.0,
                                        787.0,
                                        150.0,
                                        1134.5,
                                        150.0
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-15",
                                        3
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
                                        "obj-16",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-11",
                                        0
                                    ],
                                    "midpoints": [
                                        84.5,
                                        67.0,
                                        117.0,
                                        67.0,
                                        117.0,
                                        105.0,
                                        129.5,
                                        105.0
                                    ],
                                    "source": [
                                        "obj-2",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        165.0,
                        270.0,
                        86.0,
                        22.0
                    ],
                    "text": "p cluster"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-27",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
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
                            400.0,
                            300.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "slice id",
                                    "id": "obj-1",
                                    "index": 1,
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
                                    "comment": "loop flag",
                                    "id": "obj-2",
                                    "index": 3,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        120.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "retrigger bang",
                                    "id": "obj-3",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        75.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "audio L",
                                    "id": "obj-4",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        120.0,
                                        330.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "audio R",
                                    "id": "obj-5",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        165.0,
                                        330.0,
                                        30.0,
                                        30.0
                                    ]
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
                                        "",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        120.0,
                                        121.0,
                                        22.0
                                    ],
                                    "saved_object_attributes": {
                                        "embed": 0,
                                        "precision": 6
                                    },
                                    "text": "coll slice_meta"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-7",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "int",
                                        "int"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        165.0,
                                        116.0,
                                        22.0
                                    ],
                                    "text": "unpack 0 0"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        135.0,
                                        75.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "i"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-9",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        60.0,
                                        210.0,
                                        88.0,
                                        22.0
                                    ],
                                    "text": "pack 0 0 0"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-10",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        60.0,
                                        255.0,
                                        100.0,
                                        22.0
                                    ],
                                    "text": "prepend note"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-11",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        60.0,
                                        75.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "i"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-12",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        285.0,
                                        212.0,
                                        22.0
                                    ],
                                    "text": "poly~ slice-voice 8 @steal 1"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-11",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        22.0,
                                        67.0,
                                        22.0,
                                        67.0,
                                        68.0,
                                        69.5,
                                        68.0
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
                                        69.5,
                                        281.0,
                                        39.5,
                                        281.0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        69.5,
                                        108.5,
                                        39.5,
                                        108.5
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
                                        "obj-4",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        318.5,
                                        129.5,
                                        318.5
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
                                        "obj-5",
                                        0
                                    ],
                                    "midpoints": [
                                        232.5,
                                        318.5,
                                        174.5,
                                        318.5
                                    ],
                                    "source": [
                                        "obj-12",
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
                                    "source": [
                                        "obj-2",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-11",
                                        0
                                    ],
                                    "midpoints": [
                                        84.5,
                                        22.0,
                                        68.0,
                                        22.0,
                                        68.0,
                                        68.0,
                                        69.5,
                                        68.0
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
                                        153.5,
                                        39.5,
                                        153.5
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
                                        136.5,
                                        198.5,
                                        104.0,
                                        198.5
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
                                        198.5,
                                        69.5,
                                        198.5
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
                                        2
                                    ],
                                    "midpoints": [
                                        144.5,
                                        112.0,
                                        159.0,
                                        112.0,
                                        159.0,
                                        150.0,
                                        159.0,
                                        157.0,
                                        154.0,
                                        157.0,
                                        154.0,
                                        195.0,
                                        138.5,
                                        195.0
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
                        345.0,
                        450.0,
                        86.0,
                        22.0
                    ],
                    "text": "p playback"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-28",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
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
                            400.0,
                            300.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "metro tick",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "bang"
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
                                    "comment": "active cluster id",
                                    "id": "obj-2",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        75.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "labels-ready",
                                    "id": "obj-3",
                                    "index": 3,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "picked slice id",
                                    "id": "obj-4",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        45.0,
                                        330.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
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
                                        45.0,
                                        165.0,
                                        128.0,
                                        22.0
                                    ],
                                    "saved_object_attributes": {
                                        "embed": 0,
                                        "precision": 6
                                    },
                                    "text": "coll cluster_ids"
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
                                        "int"
                                    ],
                                    "patching_rect": [
                                        60.0,
                                        75.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "i"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-7",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        225.0,
                                        75.0,
                                        100.0,
                                        22.0
                                    ],
                                    "text": "dump"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        120.0,
                                        226.0,
                                        22.0
                                    ],
                                    "text": "fluid.labelset~ cluster_labels"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-9",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        75.0,
                                        120.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "$1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-10",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        45.0,
                                        210.0,
                                        61.0,
                                        22.0
                                    ],
                                    "text": "zl len"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-11",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        255.0,
                                        74.0,
                                        22.0
                                    ],
                                    "text": "random 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-12",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        285.0,
                                        61.0,
                                        22.0
                                    ],
                                    "text": "zl nth"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-11",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        157.0,
                                        37.0,
                                        157.0,
                                        37.0,
                                        195.0,
                                        37.0,
                                        202.0,
                                        37.0,
                                        202.0,
                                        37.0,
                                        240.0,
                                        39.5,
                                        240.0
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-1",
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
                                        22.0,
                                        67.0,
                                        22.0,
                                        67.0,
                                        68.0,
                                        69.5,
                                        68.0
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-1",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-11",
                                        1
                                    ],
                                    "midpoints": [
                                        54.5,
                                        243.5,
                                        94.5,
                                        243.5
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
                                        1
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
                                        "obj-4",
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        84.5,
                                        22.0,
                                        68.0,
                                        22.0,
                                        68.0,
                                        68.0,
                                        69.5,
                                        68.0
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
                                        "obj-7",
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
                                        "obj-10",
                                        0
                                    ],
                                    "order": 0,
                                    "source": [
                                        "obj-5",
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
                                        54.5,
                                        202.0,
                                        37.0,
                                        202.0,
                                        37.0,
                                        240.0,
                                        37.0,
                                        247.0,
                                        22.0,
                                        247.0,
                                        22.0,
                                        285.0,
                                        39.5,
                                        285.0
                                    ],
                                    "order": 1,
                                    "source": [
                                        "obj-5",
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
                                        108.5,
                                        219.5,
                                        108.5
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
                                        "obj-5",
                                        0
                                    ],
                                    "midpoints": [
                                        84.5,
                                        153.5,
                                        54.5,
                                        153.5
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
                        360.0,
                        360.0,
                        86.0,
                        22.0
                    ],
                    "text": "p random"
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
                    "id": "obj-29",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        360.0,
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
                    "id": "obj-30",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        375.0,
                        150.0,
                        51.0,
                        22.0
                    ],
                    "text": "t b b"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-31",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        510.0,
                        195.0,
                        107.0,
                        22.0
                    ],
                    "text": "set 4"
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
                        375.0,
                        195.0,
                        121.0,
                        22.0
                    ],
                    "text": "set 250"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-33",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        150.0,
                        100.0,
                        22.0
                    ],
                    "text": "prepend read"
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
                        120.0,
                        315.0,
                        60.0,
                        22.0
                    ],
                    "text": "dump"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-35",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        330.0,
                        315.0,
                        51.0,
                        22.0
                    ],
                    "text": "t b b"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-36",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        120.0,
                        467.0,
                        101.0,
                        22.0
                    ],
                    "text": "route point"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-37",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        690.0,
                        220.0,
                        22.0
                    ],
                    "text": "fluid.dataset~ descriptors_2d"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-38",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "dictionary",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        735.0,
                        120.0,
                        22.0
                    ],
                    "text": "dict plot_data"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-39",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        120.0,
                        645.0,
                        51.0,
                        22.0
                    ],
                    "text": "t b b"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-40",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        200.0,
                        690.0,
                        68.0,
                        22.0
                    ],
                    "text": "deferlow"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-41",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        200.0,
                        735.0,
                        130.0,
                        22.0
                    ],
                    "text": "dictionary plot_data"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-36",
                        0
                    ],
                    "midpoints": [
                        129.5,
                        450.0,
                        129.5,
                        450.0
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
                        "obj-27",
                        1
                    ],
                    "midpoints": [
                        504.5,
                        255.0,
                        540.0,
                        255.0,
                        540.0,
                        435.0,
                        388.0,
                        435.0
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
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        459.5,
                        180.0,
                        501.0,
                        180.0,
                        501.0,
                        264.0,
                        459.5,
                        264.0
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
                        "obj-19",
                        1
                    ],
                    "midpoints": [
                        459.5,
                        264.0,
                        519.5,
                        264.0
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
                        "obj-28",
                        1
                    ],
                    "midpoints": [
                        309.5,
                        225.0,
                        360.0,
                        225.0,
                        360.0,
                        300.0,
                        403.0,
                        300.0
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
                        "obj-28",
                        0
                    ],
                    "midpoints": [
                        459.5,
                        345.0,
                        372.0,
                        345.0,
                        372.0,
                        357.0,
                        369.5,
                        357.0
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
                        "obj-21",
                        0
                    ],
                    "midpoints": [
                        369.5,
                        627.0,
                        447.0,
                        627.0,
                        447.0,
                        477.0,
                        429.0,
                        477.0
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
                        "obj-24",
                        1
                    ],
                    "midpoints": [
                        376.75,
                        630.0,
                        407.5,
                        630.0
                    ],
                    "source": [
                        "obj-20",
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
                        369.5,
                        630.0,
                        354.5,
                        630.0
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
                        "obj-22",
                        0
                    ],
                    "midpoints": [
                        301.5,
                        264.0,
                        279.5,
                        264.0
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
                        "obj-26",
                        0
                    ],
                    "midpoints": [
                        234.5,
                        264.0,
                        174.5,
                        264.0
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
                        "obj-35",
                        0
                    ],
                    "midpoints": [
                        241.5,
                        294.0,
                        339.5,
                        294.0
                    ],
                    "source": [
                        "obj-26",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-20",
                        1
                    ],
                    "midpoints": [
                        421.5,
                        474.0,
                        398.5,
                        474.0
                    ],
                    "source": [
                        "obj-27",
                        1
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
                        354.5,
                        474.0,
                        369.5,
                        474.0
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
                        "obj-27",
                        0
                    ],
                    "midpoints": [
                        369.5,
                        435.0,
                        354.5,
                        435.0
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
                        369.5,
                        135.0,
                        384.5,
                        135.0
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
                        "obj-33",
                        0
                    ],
                    "midpoints": [
                        39.5,
                        132.0,
                        39.5,
                        132.0
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
                        416.5,
                        174.0,
                        519.5,
                        174.0
                    ],
                    "source": [
                        "obj-30",
                        1
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
                        384.5,
                        174.0,
                        384.5,
                        174.0
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
                        "obj-8",
                        0
                    ],
                    "midpoints": [
                        519.5,
                        237.0,
                        174.5,
                        237.0
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        384.5,
                        237.0,
                        459.5,
                        237.0
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
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        39.5,
                        192.0,
                        129.5,
                        192.0
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
                        "obj-10",
                        0
                    ],
                    "midpoints": [
                        371.5,
                        339.0,
                        129.5,
                        339.0
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
                        "obj-28",
                        2
                    ],
                    "midpoints": [
                        339.5,
                        339.0,
                        436.5,
                        339.0
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
                        "obj-27",
                        0
                    ],
                    "midpoints": [
                        129.5,
                        501.0,
                        330.0,
                        501.0,
                        330.0,
                        447.0,
                        354.5,
                        447.0
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
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        159.5,
                        180.0,
                        132.0,
                        180.0,
                        132.0,
                        192.0,
                        129.5,
                        192.0
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
                        "obj-25",
                        0
                    ],
                    "midpoints": [
                        257.5,
                        219.0,
                        237.0,
                        219.0,
                        237.0,
                        237.0,
                        234.5,
                        237.0
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
                        "obj-26",
                        1
                    ],
                    "midpoints": [
                        174.5,
                        264.0,
                        241.5,
                        264.0
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
                        "obj-26",
                        0
                    ],
                    "midpoints": [
                        264.5,
                        180.0,
                        279.0,
                        180.0,
                        279.0,
                        237.0,
                        216.0,
                        237.0,
                        216.0,
                        264.0,
                        174.5,
                        264.0
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
                        "obj-26",
                        0
                    ],
                    "destination": [
                        "obj-39",
                        0
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
                        "obj-34",
                        0
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
                        "obj-40",
                        0
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
                        "obj-37",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-37",
                        1
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
                        "obj-41",
                        0
                    ],
                    "destination": [
                        "obj-10",
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