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
            1163.0,
            707.0
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
                        660.0,
                        30.0,
                        267.0,
                        24.0
                    ],
                    "text": "Intelligent Corpus Remixer",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "fontface": 1,
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
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
                        660.0,
                        90.0,
                        135.0,
                        20.0
                    ],
                    "text": "Drop audio file →",
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
                    "maxclass": "dropfile",
                    "id": "obj-3",
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
                    "parameter_enable": 0,
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
                    "maxclass": "message",
                    "id": "obj-4",
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
                    "text": "message read",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        20.0,
                        60.0,
                        22.0
                    ]
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
                        660.0,
                        135.0,
                        147.0,
                        22.0
                    ],
                    "text": "buffer~ source",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-6",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        660.0,
                        180.0,
                        147.0,
                        22.0
                    ],
                    "text": "buffer~ onsets",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        660.0,
                        240.0,
                        93.0,
                        20.0
                    ],
                    "text": "K clusters:",
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
                    "maxclass": "number",
                    "id": "obj-8",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        150.0,
                        240.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        310.0,
                        20.0,
                        60.0,
                        22.0
                    ],
                    "minimum": 2,
                    "maximum": 16
                }
            },
            {
                "box": {
                    "maxclass": "button",
                    "id": "obj-9",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        255.0,
                        30.0,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0,
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
                    "maxclass": "comment",
                    "id": "obj-10",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        660.0,
                        285.0,
                        58.0,
                        20.0
                    ],
                    "text": "re-fit",
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
                    "id": "obj-11",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        195.0,
                        360.0,
                        107.0,
                        22.0
                    ],
                    "text": "fluid.plotter",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        60.0,
                        440.0,
                        360.0
                    ]
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
                        660.0,
                        345.0,
                        51.0,
                        20.0
                    ],
                    "text": "Loop:",
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
                    "maxclass": "toggle",
                    "id": "obj-13",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        495.0,
                        30.0,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0,
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
                    "maxclass": "comment",
                    "id": "obj-14",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        660.0,
                        390.0,
                        44.0,
                        20.0
                    ],
                    "text": "loop",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        510.0,
                        73.0,
                        50.0,
                        20.0
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
                    "id": "obj-15",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        945.0,
                        30.0,
                        65.0,
                        20.0
                    ],
                    "text": "Random:",
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
                    "maxclass": "toggle",
                    "id": "obj-16",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        450.0,
                        30.0,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0,
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
                    "maxclass": "comment",
                    "id": "obj-17",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        945.0,
                        75.0,
                        58.0,
                        20.0
                    ],
                    "text": "random",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        510.0,
                        113.0,
                        70.0,
                        20.0
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
                    "id": "obj-18",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        945.0,
                        135.0,
                        72.0,
                        20.0
                    ],
                    "text": "Rate ms:",
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
                    "maxclass": "number",
                    "id": "obj-19",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        450.0,
                        240.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        480.0,
                        145.0,
                        80.0,
                        22.0
                    ],
                    "minimum": 20,
                    "maximum": 2000
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
                        945.0,
                        180.0,
                        79.0,
                        20.0
                    ],
                    "text": "rate (ms)",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        570.0,
                        148.0,
                        80.0,
                        20.0
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
                    "id": "obj-21",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        945.0,
                        225.0,
                        72.0,
                        20.0
                    ],
                    "text": "Cluster:",
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
                    "maxclass": "number",
                    "id": "obj-22",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        300.0,
                        30.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        480.0,
                        180.0,
                        80.0,
                        22.0
                    ],
                    "minimum": 0,
                    "maximum": 15
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-23",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        945.0,
                        285.0,
                        114.0,
                        20.0
                    ],
                    "text": "active cluster",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        570.0,
                        183.0,
                        100.0,
                        20.0
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
                    "id": "obj-24",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        450.0,
                        270.0,
                        79.0,
                        22.0
                    ],
                    "text": "metro 250",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-25",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        945.0,
                        330.0,
                        65.0,
                        20.0
                    ],
                    "text": "Master:",
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
                    "maxclass": "live.gain~",
                    "id": "obj-26",
                    "numinlets": 2,
                    "numoutlets": 5,
                    "outlettype": [
                        "signal",
                        "signal",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        345.0,
                        480.0,
                        48.0,
                        136.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        480.0,
                        240.0,
                        60.0,
                        180.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-27",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        405.0,
                        480.0,
                        15.0,
                        100.0
                    ],
                    "parameter_enable": 0,
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
                    "maxclass": "comment",
                    "id": "obj-28",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        945.0,
                        375.0,
                        65.0,
                        20.0
                    ],
                    "text": "Slices:",
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
                    "maxclass": "number",
                    "id": "obj-29",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        150.0,
                        240.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
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
                    "maxclass": "comment",
                    "id": "obj-30",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1065.0,
                        30.0,
                        58.0,
                        20.0
                    ],
                    "text": "slices",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        90.0,
                        432.0,
                        60.0,
                        20.0
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
                    "id": "obj-31",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        330.0,
                        645.0,
                        72.0,
                        22.0
                    ],
                    "text": "dac~ 1 2",
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
                    "maxclass": "newobj",
                    "id": "obj-32",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        90.0,
                        195.0,
                        86.0,
                        22.0
                    ],
                    "text": "p analysis",
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
                                    "comment": "read message (filename or bang)"
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
                                        645.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "slices-ready bang"
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
                                        75.0,
                                        420.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "analysis-done bang"
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
                                        165.0,
                                        510.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "slice count"
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
                                        30.0,
                                        75.0,
                                        156.0,
                                        22.0
                                    ],
                                    "text": "ears.readfile source",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-6",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        165.0,
                                        604.0,
                                        22.0
                                    ],
                                    "text": "fluid.bufonsetslice~ @source source @indices onsets @threshold 0.5 @minslicelength 2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-7",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        720.0,
                                        30.0,
                                        147.0,
                                        22.0
                                    ],
                                    "text": "buffer~ mfcc_feat",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-8",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        720.0,
                                        75.0,
                                        147.0,
                                        22.0
                                    ],
                                    "text": "buffer~ loud_feat",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-9",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        720.0,
                                        135.0,
                                        147.0,
                                        22.0
                                    ],
                                    "text": "buffer~ mfcc_mean",
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
                                        30.0,
                                        255.0,
                                        555.0,
                                        22.0
                                    ],
                                    "text": "fluid.bufmfcc~ @source source @features mfcc_feat @numcoeffs 13 @startcoeff 1",
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
                                        30.0,
                                        300.0,
                                        569.0,
                                        22.0
                                    ],
                                    "text": "fluid.bufloudness~ @source source @features loud_feat @kweighting 1 @truepeak 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-12",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        90.0,
                                        345.0,
                                        457.0,
                                        22.0
                                    ],
                                    "text": "fluid.bufstats~ @source mfcc_feat @stats mfcc_mean @select mean",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-13",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        75.0,
                                        480.0,
                                        198.0,
                                        22.0
                                    ],
                                    "text": "fluid.dataset~ descriptors",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-14",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        120.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "t b b",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-15",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        210.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "t b b",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-16",
                                    "numinlets": 2,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        720.0,
                                        180.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "coll slice_meta",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-17",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        720.0,
                                        240.0,
                                        212.0,
                                        22.0
                                    ],
                                    "text": "fluid.dataset~ slice_meta_ds",
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
                                        60.0,
                                        375.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "t b b",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-19",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        120.0,
                                        420.0,
                                        100.0,
                                        22.0
                                    ],
                                    "text": "message size",
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
                                        "obj-5",
                                        0
                                    ],
                                    "midpoints": [
                                        45.0,
                                        67.5,
                                        108.0,
                                        67.5
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
                                        "obj-14",
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
                                        "obj-2",
                                        0
                                    ],
                                    "midpoints": [
                                        74.0,
                                        157.0,
                                        642.0,
                                        157.0,
                                        642.0,
                                        195.0,
                                        652.0,
                                        195.0
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
                                        "obj-15",
                                        0
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
                                        "obj-10",
                                        0
                                    ],
                                    "midpoints": [
                                        37.0,
                                        243.5,
                                        307.5,
                                        243.5
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
                                        "obj-12",
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
                                        "obj-18",
                                        0
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
                                        "obj-3",
                                        0
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
                                        "obj-19",
                                        0
                                    ],
                                    "midpoints": [
                                        104.0,
                                        412.0,
                                        113.0,
                                        412.0,
                                        113.0,
                                        458.0,
                                        127.0,
                                        458.0
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
                                        "obj-4",
                                        0
                                    ],
                                    "midpoints": [
                                        82.0,
                                        506.0,
                                        172.0,
                                        506.0
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
                    "maxclass": "newobj",
                    "id": "obj-33",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        150.0,
                        270.0,
                        86.0,
                        22.0
                    ],
                    "text": "p cluster",
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
                                    "comment": "analysis-done bang"
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
                                    "comment": "K (num clusters)"
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
                                        1125.0,
                                        120.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "cluster-done bang"
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
                                        1275.0,
                                        165.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "cluster labels ready"
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
                                        90.0,
                                        165.0,
                                        247.0,
                                        22.0
                                    ],
                                    "text": "fluid.normalize~ descriptors_norm",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-6",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        345.0,
                                        165.0,
                                        562.0,
                                        22.0
                                    ],
                                    "text": "fluid.umap~ descriptors_2d_obj @numdimensions 2 @numneighbours 15 @mindist 0.1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-7",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        930.0,
                                        165.0,
                                        289.0,
                                        22.0
                                    ],
                                    "text": "fluid.kmeans~ kmeans_obj @numclusters 4",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-8",
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
                                    "text": "fluid.dataset~ descriptors_norm",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-9",
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
                                    "text": "fluid.dataset~ descriptors_2d",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-10",
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
                                    "text": "fluid.labelset~ cluster_labels",
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
                                        120.0,
                                        75.0,
                                        170.0,
                                        22.0
                                    ],
                                    "text": "message numclusters $1",
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
                                        30.0,
                                        120.0,
                                        359.0,
                                        22.0
                                    ],
                                    "text": "message fittransform descriptors descriptors_norm",
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
                                        405.0,
                                        120.0,
                                        380.0,
                                        22.0
                                    ],
                                    "text": "message fittransform descriptors_norm descriptors_2d",
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
                                        795.0,
                                        120.0,
                                        317.0,
                                        22.0
                                    ],
                                    "text": "message fit descriptors_norm cluster_labels",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-15",
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
                                        75.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "t b b b b",
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
                                        1170.0,
                                        120.0,
                                        219.0,
                                        22.0
                                    ],
                                    "text": "message labels cluster_labels",
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
                                        "obj-15",
                                        0
                                    ],
                                    "midpoints": [
                                        45.0,
                                        22.0,
                                        67.0,
                                        22.0,
                                        67.0,
                                        68.0,
                                        69.5,
                                        68.0
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
                                        "obj-12",
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
                                        "obj-5",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-15",
                                        1
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        58.66666666666667,
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
                                        412.0,
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        595.0,
                                        153.5,
                                        626.0,
                                        153.5
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-15",
                                        2
                                    ],
                                    "destination": [
                                        "obj-14",
                                        0
                                    ],
                                    "midpoints": [
                                        80.33333333333334,
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
                                        802.0,
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
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        953.5,
                                        153.5,
                                        1074.5,
                                        153.5
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-15",
                                        3
                                    ],
                                    "destination": [
                                        "obj-3",
                                        0
                                    ],
                                    "midpoints": [
                                        102.0,
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
                                        1132.0,
                                        150.0
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
                                        "obj-11",
                                        0
                                    ],
                                    "midpoints": [
                                        90.0,
                                        67.0,
                                        117.0,
                                        67.0,
                                        117.0,
                                        105.0,
                                        127.0,
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
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        205.0,
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
                                        787.0,
                                        157.0,
                                        345.0,
                                        157.0,
                                        345.0,
                                        195.0,
                                        345.0,
                                        157.0,
                                        915.0,
                                        157.0,
                                        915.0,
                                        195.0,
                                        1074.5,
                                        195.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-15",
                                        3
                                    ],
                                    "destination": [
                                        "obj-16",
                                        0
                                    ],
                                    "midpoints": [
                                        102.0,
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
                                        1177.0,
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
                                        "obj-4",
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
                    "maxclass": "newobj",
                    "id": "obj-34",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        330.0,
                        450.0,
                        86.0,
                        22.0
                    ],
                    "text": "p playback",
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
                                    "comment": "slice id (int)"
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
                                    "comment": "loop flag (0/1)"
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
                                    "comment": "trigger bang"
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
                                        120.0,
                                        330.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "audio L"
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
                                        165.0,
                                        330.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "audio R"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-6",
                                    "numinlets": 2,
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
                                    "text": "coll slice_meta",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-7",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
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
                                    "maxclass": "newobj",
                                    "id": "obj-8",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        135.0,
                                        75.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "i",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-9",
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
                                    "text": "pack 0 0 0",
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
                                        60.0,
                                        255.0,
                                        100.0,
                                        22.0
                                    ],
                                    "text": "prepend note",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-11",
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
                                    "text": "poly~ slice-voice 8 @steal 1",
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
                                        ""
                                    ],
                                    "patching_rect": [
                                        60.0,
                                        75.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "i",
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
                                        "obj-12",
                                        0
                                    ],
                                    "midpoints": [
                                        45.0,
                                        22.0,
                                        67.0,
                                        22.0,
                                        67.0,
                                        68.0,
                                        67.0,
                                        68.0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        75.0,
                                        108.5,
                                        37.0,
                                        108.5
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
                                        37.0,
                                        153.5,
                                        88.0,
                                        153.5
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
                                        37.0,
                                        198.5,
                                        67.0,
                                        198.5
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-7",
                                        1
                                    ],
                                    "destination": [
                                        "obj-9",
                                        1
                                    ],
                                    "midpoints": [
                                        139.0,
                                        198.5,
                                        104.0,
                                        198.5
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
                                        "obj-8",
                                        0
                                    ],
                                    "destination": [
                                        "obj-9",
                                        2
                                    ],
                                    "midpoints": [
                                        150.0,
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
                                        141.0,
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
                                    ],
                                    "midpoints": [
                                        110.0,
                                        281.0,
                                        136.0,
                                        281.0
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
                                        "obj-4",
                                        0
                                    ],
                                    "midpoints": [
                                        37.0,
                                        318.5,
                                        127.0,
                                        318.5
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-11",
                                        1
                                    ],
                                    "destination": [
                                        "obj-5",
                                        0
                                    ],
                                    "midpoints": [
                                        235.0,
                                        318.5,
                                        172.0,
                                        318.5
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
                                        "obj-12",
                                        0
                                    ],
                                    "midpoints": [
                                        90.0,
                                        22.0,
                                        68.0,
                                        22.0,
                                        68.0,
                                        68.0,
                                        67.0,
                                        68.0
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
                    "maxclass": "newobj",
                    "id": "obj-35",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        330.0,
                        360.0,
                        86.0,
                        22.0
                    ],
                    "text": "p random",
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
                                    "comment": "metro bang (tick)"
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
                                    "comment": "active cluster id"
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
                                    "comment": "labels-ready bang"
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
                                        45.0,
                                        330.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "random slice id"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-5",
                                    "numinlets": 2,
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
                                    "text": "coll cluster_ids",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-6",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        60.0,
                                        75.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "i",
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
                                        225.0,
                                        75.0,
                                        100.0,
                                        22.0
                                    ],
                                    "text": "message dump",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-8",
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
                                    "text": "fluid.labelset~ cluster_labels",
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
                                        75.0,
                                        120.0,
                                        86.0,
                                        22.0
                                    ],
                                    "text": "message $1",
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
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        45.0,
                                        210.0,
                                        61.0,
                                        22.0
                                    ],
                                    "text": "zl len",
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
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        255.0,
                                        74.0,
                                        22.0
                                    ],
                                    "text": "random 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-12",
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
                                    "text": "zl nth",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-13",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        480.0,
                                        30.0,
                                        100.0,
                                        22.0
                                    ],
                                    "text": "zl group 128",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "source": [
                                        "obj-2",
                                        0
                                    ],
                                    "destination": [
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        90.0,
                                        22.0,
                                        68.0,
                                        22.0,
                                        68.0,
                                        68.0,
                                        67.0,
                                        68.0
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
                                    ],
                                    "midpoints": [
                                        275.0,
                                        108.5,
                                        323.0,
                                        108.5
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        45.0,
                                        22.0,
                                        67.0,
                                        22.0,
                                        67.0,
                                        68.0,
                                        67.0,
                                        68.0
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
                                        "obj-9",
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
                                        "obj-5",
                                        0
                                    ],
                                    "midpoints": [
                                        118.0,
                                        153.5,
                                        52.0,
                                        153.5
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
                                        1
                                    ],
                                    "midpoints": [
                                        52.0,
                                        243.5,
                                        97.0,
                                        243.5
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
                                        "obj-11",
                                        0
                                    ],
                                    "midpoints": [
                                        45.0,
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
                                        37.0,
                                        240.0
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
                                        1
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
                                        "obj-12",
                                        0
                                    ],
                                    "midpoints": [
                                        52.0,
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
                                        37.0,
                                        285.0
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
                                        "obj-4",
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
                    "maxclass": "newobj",
                    "id": "obj-36",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        360.0,
                        30.0,
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
                    "id": "obj-37",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        375.0,
                        150.0,
                        51.0,
                        22.0
                    ],
                    "text": "t b b",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-38",
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
                    "text": "message set 4",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-39",
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
                    "text": "message set 250",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-40",
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
                    "text": "prepend read",
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
                        90.0,
                        315.0,
                        198.0,
                        22.0
                    ],
                    "text": "message set descriptors_2d",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-42",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        300.0,
                        315.0,
                        51.0,
                        22.0
                    ],
                    "text": "t b b",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-43",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        165.0,
                        405.0,
                        101.0,
                        22.0
                    ],
                    "text": "route point",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "obj-36",
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
                        "obj-37",
                        1
                    ],
                    "destination": [
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        419.0,
                        187.0,
                        504.0,
                        187.0,
                        504.0,
                        225.0,
                        517.0,
                        225.0
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
                        "obj-8",
                        0
                    ],
                    "midpoints": [
                        563.5,
                        187.0,
                        184.0,
                        187.0,
                        184.0,
                        225.0,
                        184.0,
                        187.0,
                        367.0,
                        187.0,
                        367.0,
                        225.0,
                        367.0,
                        232.0,
                        442.0,
                        232.0,
                        442.0,
                        270.0,
                        442.0,
                        232.0,
                        208.0,
                        232.0,
                        208.0,
                        270.0,
                        175.0,
                        270.0
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
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        435.5,
                        228.5,
                        475.0,
                        228.5
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
                        "obj-40",
                        0
                    ],
                    "midpoints": [
                        37.0,
                        140.0,
                        80.0,
                        140.0
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
                        "obj-32",
                        0
                    ],
                    "midpoints": [
                        80.0,
                        183.5,
                        133.0,
                        183.5
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
                        "obj-32",
                        0
                    ],
                    "midpoints": [
                        200.0,
                        22.0,
                        138.0,
                        22.0,
                        138.0,
                        138.0,
                        138.0,
                        142.0,
                        138.0,
                        142.0,
                        138.0,
                        180.0,
                        133.0,
                        180.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-32",
                        1
                    ],
                    "destination": [
                        "obj-33",
                        0
                    ],
                    "midpoints": [
                        133.0,
                        232.0,
                        142.0,
                        232.0,
                        142.0,
                        270.0,
                        142.0,
                        232.0,
                        142.0,
                        232.0,
                        142.0,
                        270.0,
                        157.0,
                        270.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-32",
                        2
                    ],
                    "destination": [
                        "obj-29",
                        0
                    ],
                    "midpoints": [
                        169.0,
                        232.0,
                        142.0,
                        232.0,
                        142.0,
                        270.0,
                        175.0,
                        270.0
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
                        1
                    ],
                    "midpoints": [
                        157.0,
                        232.0,
                        208.0,
                        232.0,
                        208.0,
                        270.0,
                        229.0,
                        270.0
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
                        "obj-33",
                        0
                    ],
                    "midpoints": [
                        267.0,
                        22.0,
                        258.0,
                        22.0,
                        258.0,
                        60.0,
                        258.0,
                        187.0,
                        184.0,
                        187.0,
                        184.0,
                        225.0,
                        184.0,
                        232.0,
                        208.0,
                        232.0,
                        208.0,
                        270.0,
                        208.0,
                        232.0,
                        208.0,
                        232.0,
                        208.0,
                        270.0,
                        157.0,
                        270.0
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
                        "obj-41",
                        0
                    ],
                    "midpoints": [
                        157.0,
                        303.5,
                        97.0,
                        303.5
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        189.0,
                        348.5,
                        248.5,
                        348.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-33",
                        1
                    ],
                    "destination": [
                        "obj-42",
                        0
                    ],
                    "midpoints": [
                        229.0,
                        307.0,
                        296.0,
                        307.0,
                        296.0,
                        345.0,
                        325.5,
                        345.0
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
                        "obj-35",
                        2
                    ],
                    "midpoints": [
                        307.0,
                        352.0,
                        310.0,
                        352.0,
                        310.0,
                        390.0,
                        409.0,
                        390.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-42",
                        1
                    ],
                    "destination": [
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        344.0,
                        307.0,
                        296.0,
                        307.0,
                        296.0,
                        345.0,
                        296.0,
                        352.0,
                        322.0,
                        352.0,
                        322.0,
                        390.0,
                        248.5,
                        390.0
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
                        "obj-34",
                        0
                    ],
                    "midpoints": [
                        172.0,
                        438.5,
                        337.0,
                        438.5
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
                        "obj-34",
                        1
                    ],
                    "midpoints": [
                        507.0,
                        22.0,
                        442.0,
                        22.0,
                        442.0,
                        62.0,
                        442.0,
                        22.0,
                        440.0,
                        22.0,
                        440.0,
                        60.0,
                        440.0,
                        142.0,
                        434.0,
                        142.0,
                        434.0,
                        180.0,
                        434.0,
                        187.0,
                        502.0,
                        187.0,
                        502.0,
                        225.0,
                        502.0,
                        187.0,
                        504.0,
                        187.0,
                        504.0,
                        225.0,
                        504.0,
                        232.0,
                        442.0,
                        232.0,
                        442.0,
                        270.0,
                        442.0,
                        262.0,
                        442.0,
                        262.0,
                        442.0,
                        300.0,
                        442.0,
                        352.0,
                        424.0,
                        352.0,
                        424.0,
                        390.0,
                        373.0,
                        390.0
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
                        "obj-24",
                        0
                    ],
                    "midpoints": [
                        462.0,
                        187.0,
                        504.0,
                        187.0,
                        504.0,
                        225.0,
                        504.0,
                        232.0,
                        442.0,
                        232.0,
                        442.0,
                        270.0,
                        457.0,
                        270.0
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
                        "obj-24",
                        1
                    ],
                    "midpoints": [
                        457.0,
                        266.0,
                        522.0,
                        266.0
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
                        "obj-35",
                        0
                    ],
                    "midpoints": [
                        489.5,
                        307.0,
                        359.0,
                        307.0,
                        359.0,
                        345.0,
                        337.0,
                        345.0
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
                        "obj-35",
                        1
                    ],
                    "midpoints": [
                        307.0,
                        22.0,
                        352.0,
                        22.0,
                        352.0,
                        60.0,
                        352.0,
                        142.0,
                        367.0,
                        142.0,
                        367.0,
                        180.0,
                        367.0,
                        187.0,
                        367.0,
                        187.0,
                        367.0,
                        225.0,
                        367.0,
                        307.0,
                        359.0,
                        307.0,
                        359.0,
                        345.0,
                        359.0,
                        352.0,
                        310.0,
                        352.0,
                        310.0,
                        390.0,
                        373.0,
                        390.0
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
                        "obj-34",
                        0
                    ],
                    "midpoints": [
                        373.0,
                        416.0,
                        337.0,
                        416.0
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
                        "obj-26",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-34",
                        1
                    ],
                    "destination": [
                        "obj-26",
                        1
                    ],
                    "midpoints": [
                        409.0,
                        472.0,
                        397.0,
                        472.0,
                        397.0,
                        588.0,
                        386.0,
                        588.0
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
                        "obj-31",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-26",
                        1
                    ],
                    "destination": [
                        "obj-31",
                        1
                    ],
                    "midpoints": [
                        360.5,
                        630.5,
                        395.0,
                        630.5
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
                        "obj-27",
                        0
                    ],
                    "midpoints": [
                        427.0,
                        621.0,
                        427.0,
                        472.0,
                        412.5,
                        472.0
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