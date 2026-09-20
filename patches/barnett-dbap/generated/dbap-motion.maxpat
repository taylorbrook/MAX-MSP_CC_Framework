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
            134.0,
            127.0,
            1320.0,
            560.0
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
                    "id": "obj-1",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        16.0,
                        150.0,
                        900.0,
                        130.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        0.0,
                        360.0,
                        150.0
                    ],
                    "background": 1,
                    "bgcolor": [
                        0.19,
                        0.19,
                        0.22,
                        1.0
                    ],
                    "mode": 0,
                    "rounded": 6
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
                        30.0,
                        156.0,
                        58.0,
                        20.0
                    ],
                    "text": "MOTION",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        10.0,
                        6.0,
                        62.0,
                        20.0
                    ],
                    "textcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
                    ],
                    "fontface": 1
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-3",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        100.0,
                        156.0,
                        40.0,
                        20.0
                    ],
                    "text": "#1",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        74.0,
                        6.0,
                        86.0,
                        20.0
                    ],
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "fontface": 1,
                    "varname": "title"
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-4",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        190.0,
                        22.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        166.0,
                        6.0,
                        20.0,
                        20.0
                    ],
                    "varname": "on"
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
                        56.0,
                        192.0,
                        40.0,
                        20.0
                    ],
                    "text": "on",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [
                        188.0,
                        7.0,
                        24.0,
                        19.0
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
                    "id": "obj-6",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        270.0,
                        97.0,
                        22.0
                    ],
                    "text": "prepend on",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "umenu",
                    "id": "obj-7",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        120.0,
                        190.0,
                        100.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        218.0,
                        5.0,
                        92.0,
                        22.0
                    ],
                    "items": [
                        "orbit",
                        ",",
                        "figure-8",
                        ",",
                        "sweep",
                        ",",
                        "drift",
                        ",",
                        "pendulum",
                        ",",
                        "spiral"
                    ],
                    "varname": "path",
                    "bgcolor": [
                        0.27,
                        0.27,
                        0.31,
                        1.0
                    ],
                    "bgfillcolor_type": "color",
                    "bgfillcolor_color": [
                        0.27,
                        0.27,
                        0.31,
                        1.0
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
                    "id": "obj-8",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        120.0,
                        270.0,
                        100.0,
                        22.0
                    ],
                    "text": "prepend path",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "live.dial",
                    "id": "obj-9",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        240.0,
                        184.0,
                        60.0,
                        48.0
                    ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [
                        10.0,
                        32.0,
                        60.0,
                        48.0
                    ],
                    "varname": "rate",
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.1
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "rate",
                            "parameter_mmax": 10.0,
                            "parameter_mmin": 0.01,
                            "parameter_modmode": 3,
                            "parameter_shortname": "rate",
                            "parameter_type": 0,
                            "parameter_unitstyle": 3,
                            "parameter_exponent": 4.0
                        }
                    }
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
                        240.0,
                        270.0,
                        100.0,
                        22.0
                    ],
                    "text": "prepend rate",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "live.dial",
                    "id": "obj-11",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        350.0,
                        184.0,
                        60.0,
                        48.0
                    ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [
                        70.0,
                        32.0,
                        60.0,
                        48.0
                    ],
                    "varname": "size",
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                6.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "size",
                            "parameter_mmax": 24.0,
                            "parameter_mmin": 0.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "size",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    }
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-12",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        350.0,
                        270.0,
                        100.0,
                        22.0
                    ],
                    "text": "prepend size",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "live.dial",
                    "id": "obj-13",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        460.0,
                        184.0,
                        60.0,
                        48.0
                    ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [
                        130.0,
                        32.0,
                        60.0,
                        48.0
                    ],
                    "varname": "ratio",
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                1.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "ratio",
                            "parameter_mmax": 1.0,
                            "parameter_mmin": 0.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "ratio",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    }
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
                        460.0,
                        270.0,
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
                    "maxclass": "live.dial",
                    "id": "obj-15",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        570.0,
                        184.0,
                        60.0,
                        48.0
                    ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [
                        190.0,
                        32.0,
                        60.0,
                        48.0
                    ],
                    "varname": "angle",
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "angle",
                            "parameter_mmax": 360.0,
                            "parameter_mmin": 0.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "angle",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    }
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
                        570.0,
                        270.0,
                        107.0,
                        22.0
                    ],
                    "text": "prepend angle",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "live.dial",
                    "id": "obj-17",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        680.0,
                        184.0,
                        60.0,
                        48.0
                    ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [
                        10.0,
                        90.0,
                        60.0,
                        48.0
                    ],
                    "varname": "height",
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "height",
                            "parameter_mmax": 8.0,
                            "parameter_mmin": 0.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "height",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    }
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
                        680.0,
                        270.0,
                        114.0,
                        22.0
                    ],
                    "text": "prepend height",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "live.dial",
                    "id": "obj-19",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        790.0,
                        184.0,
                        60.0,
                        48.0
                    ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [
                        70.0,
                        90.0,
                        60.0,
                        48.0
                    ],
                    "varname": "phase",
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "phase",
                            "parameter_mmax": 360.0,
                            "parameter_mmin": 0.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "phase",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    }
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
                        790.0,
                        270.0,
                        107.0,
                        22.0
                    ],
                    "text": "prepend phase",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "number",
                    "id": "obj-21",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        846.0,
                        190.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        134.0,
                        112.0,
                        44.0,
                        22.0
                    ],
                    "varname": "seed",
                    "minimum": 1,
                    "maximum": 64
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
                        846.0,
                        170.0,
                        44.0,
                        20.0
                    ],
                    "text": "seed",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [
                        134.0,
                        92.0,
                        44.0,
                        19.0
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
                    "id": "obj-23",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        846.0,
                        216.0,
                        70.0,
                        19.0
                    ],
                    "text": "drift only",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [
                        182.0,
                        114.0,
                        70.0,
                        19.0
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
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        846.0,
                        270.0,
                        100.0,
                        22.0
                    ],
                    "text": "prepend seed",
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
                        30.0,
                        330.0,
                        100.0,
                        22.0
                    ],
                    "text": "js motion.js",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "outlet",
                    "id": "obj-26",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30.0,
                        380.0,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "motion dx dy dz (metres, anchor-relative) + trace -> dbap-source inlet 3"
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-27",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        70.0,
                        386.0,
                        660.0,
                        20.0
                    ],
                    "text": "motion dx dy dz + trace x1 y1 .. (metres, anchor-relative)  ->  third inlet of a dbap-source",
                    "fontname": "Arial",
                    "fontsize": 11.0,
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
                    "id": "obj-28",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        140.0,
                        332.0,
                        716.0,
                        20.0
                    ],
                    "text": "Task clock 16 ms, path from elapsed time (D22); port of MotionPath.h / MotionClock.h / PerlinNoise.h",
                    "fontname": "Arial",
                    "fontsize": 11.0,
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
                    "id": "obj-29",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        980.0,
                        156.0,
                        58.0,
                        20.0
                    ],
                    "text": "SCENES",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
                    ],
                    "fontface": 1
                }
            },
            {
                "box": {
                    "maxclass": "inlet",
                    "id": "obj-30",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        980.0,
                        190.0,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "store N / recall N from the dbap-source scenes outlet (optional)"
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-31",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        976.0,
                        224.0,
                        107.0,
                        20.0
                    ],
                    "text": "scene cord in",
                    "fontname": "Arial",
                    "fontsize": 11.0,
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
                    "id": "obj-32",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1090.0,
                        190.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        264.0,
                        34.0,
                        44.0,
                        22.0
                    ],
                    "minimum": 1,
                    "maximum": 64
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-33",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1090.0,
                        170.0,
                        44.0,
                        20.0
                    ],
                    "text": "slot",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [
                        312.0,
                        36.0,
                        36.0,
                        19.0
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
                    "id": "obj-34",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1090.0,
                        230.0,
                        51.0,
                        22.0
                    ],
                    "text": "t i i",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "button",
                    "id": "obj-35",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1050.0,
                        230.0,
                        22.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        264.0,
                        90.0,
                        22.0,
                        22.0
                    ]
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
                        1020.0,
                        210.0,
                        58.0,
                        20.0
                    ],
                    "text": "recall",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [
                        290.0,
                        92.0,
                        50.0,
                        19.0
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
                    "maxclass": "button",
                    "id": "obj-37",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1180.0,
                        230.0,
                        22.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        264.0,
                        62.0,
                        22.0,
                        22.0
                    ]
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
                        1176.0,
                        210.0,
                        51.0,
                        20.0
                    ],
                    "text": "store",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [
                        290.0,
                        64.0,
                        44.0,
                        19.0
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
                    "id": "obj-39",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1050.0,
                        270.0,
                        107.0,
                        22.0
                    ],
                    "text": "pack recall 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-40",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1180.0,
                        270.0,
                        100.0,
                        22.0
                    ],
                    "text": "pack store 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-41",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        980.0,
                        330.0,
                        205.0,
                        22.0
                    ],
                    "text": "pattrstorage #1 @savemode 0",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "saved_object_attributes": {
                        "parameter_enable": 0,
                        "parameter_mappable": 0
                    },
                    "varname": "#1"
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-42",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1210.0,
                        330.0,
                        79.0,
                        22.0
                    ],
                    "text": "autopattr",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "varname": "motion_autopattr"
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-43",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        120.0,
                        22.0,
                        226.0,
                        20.0
                    ],
                    "text": "INIT (loadbang, right to left)",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
                    ],
                    "fontface": 1
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
                        30.0,
                        20.0,
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
                    "id": "obj-45",
                    "numinlets": 1,
                    "numoutlets": 11,
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
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        60.0,
                        1120.0,
                        22.0
                    ],
                    "text": "t b b b b b b b b b b b",
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
                        30.0,
                        110.0,
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
                    "id": "obj-47",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        100.0,
                        110.0,
                        58.0,
                        22.0
                    ],
                    "text": "set #1",
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
                        120.0,
                        110.0,
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
                    "id": "obj-49",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        240.0,
                        110.0,
                        40.0,
                        22.0
                    ],
                    "text": "0.1",
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
                        350.0,
                        110.0,
                        40.0,
                        22.0
                    ],
                    "text": "6.",
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
                        460.0,
                        110.0,
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
                    "id": "obj-52",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        570.0,
                        110.0,
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
                    "id": "obj-53",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        680.0,
                        110.0,
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
                    "id": "obj-54",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        790.0,
                        110.0,
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
                    "id": "obj-55",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        846.0,
                        110.0,
                        40.0,
                        22.0
                    ],
                    "text": "1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-56",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1090.0,
                        110.0,
                        40.0,
                        22.0
                    ],
                    "text": "1",
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
                    ],
                    "midpoints": [
                        247.0,
                        142.0,
                        8.0,
                        142.0,
                        8.0,
                        288.0,
                        290.0,
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
                        "obj-12",
                        0
                    ],
                    "midpoints": [
                        357.0,
                        142.0,
                        8.0,
                        142.0,
                        8.0,
                        288.0,
                        400.0,
                        288.0
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
                        "obj-14",
                        0
                    ],
                    "midpoints": [
                        467.0,
                        142.0,
                        924.0,
                        142.0,
                        924.0,
                        288.0,
                        513.5,
                        288.0
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
                        "obj-16",
                        0
                    ],
                    "midpoints": [
                        577.0,
                        142.0,
                        924.0,
                        142.0,
                        924.0,
                        288.0,
                        623.5,
                        288.0
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
                        687.0,
                        142.0,
                        924.0,
                        142.0,
                        924.0,
                        288.0,
                        737.0,
                        288.0
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
                        "obj-20",
                        0
                    ],
                    "midpoints": [
                        797.0,
                        142.0,
                        924.0,
                        142.0,
                        924.0,
                        288.0,
                        924.0,
                        208.0,
                        838.0,
                        208.0,
                        838.0,
                        243.0,
                        838.0,
                        262.0,
                        802.0,
                        262.0,
                        802.0,
                        300.0,
                        802.0,
                        262.0,
                        838.0,
                        262.0,
                        838.0,
                        300.0,
                        843.5,
                        300.0
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
                        41.0,
                        142.0,
                        8.0,
                        142.0,
                        8.0,
                        288.0,
                        8.0,
                        184.0,
                        48.0,
                        184.0,
                        48.0,
                        220.0,
                        78.5,
                        220.0
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
                        127.0,
                        142.0,
                        8.0,
                        142.0,
                        8.0,
                        288.0,
                        8.0,
                        262.0,
                        135.0,
                        262.0,
                        135.0,
                        300.0,
                        170.0,
                        300.0
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
                        "obj-24",
                        0
                    ],
                    "midpoints": [
                        853.0,
                        142.0,
                        924.0,
                        142.0,
                        924.0,
                        288.0,
                        924.0,
                        176.0,
                        858.0,
                        176.0,
                        858.0,
                        240.0,
                        858.0,
                        208.0,
                        838.0,
                        208.0,
                        838.0,
                        243.0,
                        838.0,
                        262.0,
                        905.0,
                        262.0,
                        905.0,
                        300.0,
                        896.0,
                        300.0
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
                        "obj-25",
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
                        "obj-25",
                        0
                    ],
                    "midpoints": [
                        170.0,
                        262.0,
                        135.0,
                        262.0,
                        135.0,
                        300.0,
                        135.0,
                        324.0,
                        132.0,
                        324.0,
                        132.0,
                        360.0,
                        80.0,
                        360.0
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
                        "obj-25",
                        0
                    ],
                    "midpoints": [
                        290.0,
                        262.0,
                        135.0,
                        262.0,
                        135.0,
                        300.0,
                        135.0,
                        262.0,
                        228.0,
                        262.0,
                        228.0,
                        300.0,
                        228.0,
                        324.0,
                        132.0,
                        324.0,
                        132.0,
                        360.0,
                        80.0,
                        360.0
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
                        400.0,
                        262.0,
                        135.0,
                        262.0,
                        135.0,
                        300.0,
                        135.0,
                        262.0,
                        228.0,
                        262.0,
                        228.0,
                        300.0,
                        228.0,
                        262.0,
                        232.0,
                        262.0,
                        232.0,
                        300.0,
                        232.0,
                        324.0,
                        132.0,
                        324.0,
                        132.0,
                        360.0,
                        80.0,
                        360.0
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
                        "obj-25",
                        0
                    ],
                    "midpoints": [
                        513.5,
                        262.0,
                        135.0,
                        262.0,
                        135.0,
                        300.0,
                        135.0,
                        262.0,
                        228.0,
                        262.0,
                        228.0,
                        300.0,
                        228.0,
                        262.0,
                        348.0,
                        262.0,
                        348.0,
                        300.0,
                        348.0,
                        262.0,
                        342.0,
                        262.0,
                        342.0,
                        300.0,
                        342.0,
                        324.0,
                        132.0,
                        324.0,
                        132.0,
                        360.0,
                        80.0,
                        360.0
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
                        "obj-25",
                        0
                    ],
                    "midpoints": [
                        623.5,
                        262.0,
                        135.0,
                        262.0,
                        135.0,
                        300.0,
                        135.0,
                        262.0,
                        228.0,
                        262.0,
                        228.0,
                        300.0,
                        228.0,
                        262.0,
                        348.0,
                        262.0,
                        348.0,
                        300.0,
                        348.0,
                        262.0,
                        342.0,
                        262.0,
                        342.0,
                        300.0,
                        342.0,
                        262.0,
                        452.0,
                        262.0,
                        452.0,
                        300.0,
                        452.0,
                        324.0,
                        132.0,
                        324.0,
                        132.0,
                        360.0,
                        80.0,
                        360.0
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
                        "obj-25",
                        0
                    ],
                    "midpoints": [
                        737.0,
                        262.0,
                        135.0,
                        262.0,
                        135.0,
                        300.0,
                        135.0,
                        262.0,
                        228.0,
                        262.0,
                        228.0,
                        300.0,
                        228.0,
                        262.0,
                        348.0,
                        262.0,
                        348.0,
                        300.0,
                        348.0,
                        262.0,
                        458.0,
                        262.0,
                        458.0,
                        300.0,
                        458.0,
                        262.0,
                        452.0,
                        262.0,
                        452.0,
                        300.0,
                        452.0,
                        262.0,
                        562.0,
                        262.0,
                        562.0,
                        300.0,
                        562.0,
                        324.0,
                        132.0,
                        324.0,
                        132.0,
                        360.0,
                        80.0,
                        360.0
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
                        "obj-25",
                        0
                    ],
                    "midpoints": [
                        843.5,
                        262.0,
                        135.0,
                        262.0,
                        135.0,
                        300.0,
                        135.0,
                        262.0,
                        228.0,
                        262.0,
                        228.0,
                        300.0,
                        228.0,
                        262.0,
                        348.0,
                        262.0,
                        348.0,
                        300.0,
                        348.0,
                        262.0,
                        458.0,
                        262.0,
                        458.0,
                        300.0,
                        458.0,
                        262.0,
                        452.0,
                        262.0,
                        452.0,
                        300.0,
                        452.0,
                        262.0,
                        562.0,
                        262.0,
                        562.0,
                        300.0,
                        562.0,
                        262.0,
                        672.0,
                        262.0,
                        672.0,
                        300.0,
                        672.0,
                        262.0,
                        838.0,
                        262.0,
                        838.0,
                        300.0,
                        838.0,
                        324.0,
                        132.0,
                        324.0,
                        132.0,
                        360.0,
                        80.0,
                        360.0
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
                        "obj-25",
                        0
                    ],
                    "midpoints": [
                        896.0,
                        262.0,
                        135.0,
                        262.0,
                        135.0,
                        300.0,
                        135.0,
                        262.0,
                        228.0,
                        262.0,
                        228.0,
                        300.0,
                        228.0,
                        262.0,
                        348.0,
                        262.0,
                        348.0,
                        300.0,
                        348.0,
                        262.0,
                        458.0,
                        262.0,
                        458.0,
                        300.0,
                        458.0,
                        262.0,
                        452.0,
                        262.0,
                        452.0,
                        300.0,
                        452.0,
                        262.0,
                        562.0,
                        262.0,
                        562.0,
                        300.0,
                        562.0,
                        262.0,
                        672.0,
                        262.0,
                        672.0,
                        300.0,
                        672.0,
                        262.0,
                        782.0,
                        262.0,
                        782.0,
                        300.0,
                        782.0,
                        324.0,
                        132.0,
                        324.0,
                        132.0,
                        360.0,
                        80.0,
                        360.0
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
                        "obj-26",
                        0
                    ],
                    "midpoints": [
                        80.0,
                        366.0,
                        37.0,
                        366.0
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
                        "obj-34",
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
                        "obj-39",
                        1
                    ],
                    "midpoints": [
                        1097.0,
                        261.0,
                        1150.0,
                        261.0
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
                        "obj-40",
                        1
                    ],
                    "midpoints": [
                        1134.0,
                        222.0,
                        1210.0,
                        222.0,
                        1210.0,
                        260.0,
                        1210.0,
                        262.0,
                        1165.0,
                        262.0,
                        1165.0,
                        300.0,
                        1273.0,
                        300.0
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
                        "obj-39",
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
                        "obj-40",
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
                        "obj-41",
                        0
                    ],
                    "midpoints": [
                        1103.5,
                        311.0,
                        1082.5,
                        311.0
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
                    ],
                    "midpoints": [
                        1230.0,
                        262.0,
                        1165.0,
                        262.0,
                        1165.0,
                        300.0,
                        1165.0,
                        322.0,
                        1202.0,
                        322.0,
                        1202.0,
                        360.0,
                        1082.5,
                        360.0
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
                        "obj-41",
                        0
                    ],
                    "midpoints": [
                        995.0,
                        202.0,
                        1012.0,
                        202.0,
                        1012.0,
                        238.0,
                        1012.0,
                        216.0,
                        1091.0,
                        216.0,
                        1091.0,
                        252.0,
                        1091.0,
                        222.0,
                        1082.0,
                        222.0,
                        1082.0,
                        260.0,
                        1082.0,
                        222.0,
                        1042.0,
                        222.0,
                        1042.0,
                        260.0,
                        1042.0,
                        262.0,
                        1042.0,
                        262.0,
                        1042.0,
                        300.0,
                        1082.5,
                        300.0
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
                        66.0,
                        14.0,
                        354.0,
                        14.0,
                        354.0,
                        50.0,
                        590.0,
                        50.0
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
                        "obj-46",
                        0
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
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        50.0,
                        142.0,
                        8.0,
                        142.0,
                        8.0,
                        288.0,
                        8.0,
                        148.0,
                        22.0,
                        148.0,
                        22.0,
                        184.0,
                        22.0,
                        184.0,
                        48.0,
                        184.0,
                        48.0,
                        220.0,
                        41.0,
                        220.0
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
                        "obj-47",
                        0
                    ],
                    "midpoints": [
                        147.6,
                        102.0,
                        112.0,
                        102.0,
                        112.0,
                        140.0,
                        107.0,
                        140.0
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
                        "obj-3",
                        0
                    ],
                    "midpoints": [
                        129.0,
                        102.0,
                        112.0,
                        102.0,
                        112.0,
                        140.0,
                        112.0,
                        142.0,
                        8.0,
                        142.0,
                        8.0,
                        288.0,
                        120.0,
                        288.0
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
                        258.2,
                        102.0,
                        166.0,
                        102.0,
                        166.0,
                        140.0,
                        166.0,
                        102.0,
                        232.0,
                        102.0,
                        232.0,
                        140.0,
                        127.0,
                        140.0
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        140.0,
                        102.0,
                        166.0,
                        102.0,
                        166.0,
                        140.0,
                        166.0,
                        142.0,
                        8.0,
                        142.0,
                        8.0,
                        288.0,
                        8.0,
                        148.0,
                        148.0,
                        148.0,
                        148.0,
                        184.0,
                        170.0,
                        184.0
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
                        "obj-49",
                        0
                    ],
                    "midpoints": [
                        368.79999999999995,
                        102.0,
                        342.0,
                        102.0,
                        342.0,
                        140.0,
                        247.0,
                        140.0
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
                        260.0,
                        142.0,
                        8.0,
                        142.0,
                        8.0,
                        288.0,
                        270.0,
                        288.0
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
                        "obj-50",
                        0
                    ],
                    "midpoints": [
                        479.4,
                        102.0,
                        452.0,
                        102.0,
                        452.0,
                        140.0,
                        357.0,
                        140.0
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        370.0,
                        142.0,
                        8.0,
                        142.0,
                        8.0,
                        288.0,
                        380.0,
                        288.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-45",
                        5
                    ],
                    "destination": [
                        "obj-51",
                        0
                    ],
                    "midpoints": [
                        590.0,
                        102.0,
                        562.0,
                        102.0,
                        562.0,
                        140.0,
                        467.0,
                        140.0
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
                        "obj-13",
                        0
                    ],
                    "midpoints": [
                        480.0,
                        142.0,
                        924.0,
                        142.0,
                        924.0,
                        288.0,
                        490.0,
                        288.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-45",
                        6
                    ],
                    "destination": [
                        "obj-52",
                        0
                    ],
                    "midpoints": [
                        700.5999999999999,
                        102.0,
                        672.0,
                        102.0,
                        672.0,
                        140.0,
                        577.0,
                        140.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-52",
                        0
                    ],
                    "destination": [
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        590.0,
                        142.0,
                        924.0,
                        142.0,
                        924.0,
                        288.0,
                        600.0,
                        288.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-45",
                        7
                    ],
                    "destination": [
                        "obj-53",
                        0
                    ],
                    "midpoints": [
                        811.1999999999999,
                        102.0,
                        782.0,
                        102.0,
                        782.0,
                        140.0,
                        687.0,
                        140.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-53",
                        0
                    ],
                    "destination": [
                        "obj-17",
                        0
                    ],
                    "midpoints": [
                        700.0,
                        142.0,
                        924.0,
                        142.0,
                        924.0,
                        288.0,
                        710.0,
                        288.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-45",
                        8
                    ],
                    "destination": [
                        "obj-54",
                        0
                    ],
                    "midpoints": [
                        921.8,
                        102.0,
                        838.0,
                        102.0,
                        838.0,
                        140.0,
                        797.0,
                        140.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-54",
                        0
                    ],
                    "destination": [
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        810.0,
                        142.0,
                        924.0,
                        142.0,
                        924.0,
                        288.0,
                        820.0,
                        288.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-45",
                        9
                    ],
                    "destination": [
                        "obj-55",
                        0
                    ],
                    "midpoints": [
                        1032.4,
                        96.0,
                        853.0,
                        96.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-55",
                        0
                    ],
                    "destination": [
                        "obj-21",
                        0
                    ],
                    "midpoints": [
                        866.0,
                        142.0,
                        924.0,
                        142.0,
                        924.0,
                        288.0,
                        924.0,
                        162.0,
                        898.0,
                        162.0,
                        898.0,
                        198.0,
                        871.0,
                        198.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-45",
                        10
                    ],
                    "destination": [
                        "obj-56",
                        0
                    ],
                    "midpoints": [
                        1143.0,
                        96.0,
                        1097.0,
                        96.0
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
                        "obj-32",
                        0
                    ],
                    "midpoints": [
                        1110.0,
                        162.0,
                        1142.0,
                        162.0,
                        1142.0,
                        198.0,
                        1115.0,
                        198.0
                    ]
                }
            }
        ],
        "dependency_cache": [],
        "autosave": 0,
        "bgcolor": [
            0.13,
            0.13,
            0.15,
            1.0
        ],
        "editing_bgcolor": [
            0.13,
            0.13,
            0.15,
            1.0
        ],
        "locked_bgcolor": [
            0.13,
            0.13,
            0.15,
            1.0
        ]
    }
}