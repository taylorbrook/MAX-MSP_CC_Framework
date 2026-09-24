{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 5,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [
            134.0,
            95.0,
            1279.0,
            840.0
        ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "background": 1,
                    "bgcolor": [
                        0.19,
                        0.19,
                        0.22,
                        1.0
                    ],
                    "id": "obj-3",
                    "maxclass": "panel",
                    "mode": 0,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1406.0,
                        56.0,
                        420.0,
                        400.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        556.0,
                        1206.0,
                        64.0
                    ],
                    "rounded": 6
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "id": "obj-1",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30.0,
                        15.0,
                        493.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        10.0,
                        493.0,
                        24.0
                    ],
                    "text": "BARNETT DBAP  v0.5   two sources -> 8 ch   (A mono, B stereo)",
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
                    "fontsize": 10.0,
                    "id": "obj-2",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        470.0,
                        20.0,
                        331.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        515.0,
                        16.0,
                        320.0,
                        18.0
                    ],
                    "text": "Roy Barnett Recital Hall  (OQ4 traced layout)",
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
                    "data": {
                        "name": "Roy Barnett Recital Hall (O-Octagon OQ4 traced layout, not measured)",
                        "units": "metres",
                        "speakers": {
                            "s1": {
                                "x": 0.5,
                                "y": 4.5,
                                "z": 4.5,
                                "delayMs": 0.0
                            },
                            "s2": {
                                "x": 12.5,
                                "y": 4.5,
                                "z": 4.5,
                                "delayMs": 0.0
                            },
                            "s3": {
                                "x": 12.5,
                                "y": 9.85,
                                "z": 4.7,
                                "delayMs": 0.0
                            },
                            "s4": {
                                "x": 12.5,
                                "y": 16.0,
                                "z": 5.1,
                                "delayMs": 0.0
                            },
                            "s5": {
                                "x": 9.8,
                                "y": 19.5,
                                "z": 5.4,
                                "delayMs": 0.0
                            },
                            "s6": {
                                "x": 3.2,
                                "y": 19.5,
                                "z": 5.4,
                                "delayMs": 0.0
                            },
                            "s7": {
                                "x": 0.5,
                                "y": 16.0,
                                "z": 5.1,
                                "delayMs": 0.0
                            },
                            "s8": {
                                "x": 0.5,
                                "y": 9.85,
                                "z": 4.7,
                                "delayMs": 0.0
                            }
                        },
                        "rake": {
                            "front": 1.1,
                            "rear": 3.2
                        }
                    },
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 5,
                    "outlettype": [
                        "dictionary",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        70.0,
                        149.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "embed": 1,
                        "legacy": 1,
                        "parameter_enable": 0,
                        "parameter_mappable": 0
                    },
                    "text": "dict venue @embed 1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-5",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        190.0,
                        72.0,
                        415.0,
                        19.0
                    ],
                    "text": "shared venue: read by every instance's dbap.js (Dict API)",
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
                    "args": [
                        "A",
                        1
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-6",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "dbap-source.maxpat",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "multichannelsignal",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        120.0,
                        599.0,
                        500.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        40.0,
                        609.0,
                        500.0
                    ],
                    "varname": "dbap-source[1]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        "B",
                        2
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-7",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "dbap-source.maxpat",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "multichannelsignal",
                        ""
                    ],
                    "patching_rect": [
                        720.0,
                        120.0,
                        605.0,
                        506.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        635.0,
                        40.0,
                        612.0,
                        500.0
                    ],
                    "varname": "dbap-source",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-8",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30.0,
                        650.0,
                        58.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        30.0,
                        562.0,
                        66.0,
                        20.0
                    ],
                    "text": "OUTPUT",
                    "textcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "checkedcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
                    ],
                    "id": "obj-9",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        30.0,
                        680.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        100.0,
                        570.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-10",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        60.0,
                        683.0,
                        40.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        136.0,
                        576.0,
                        40.0,
                        19.0
                    ],
                    "text": "DSP",
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
                    "id": "obj-11",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30.0,
                        720.0,
                        177.0,
                        22.0
                    ],
                    "text": "mc.dac~ 1 2 3 4 5 6 7 8"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-12",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1420.0,
                        70.0,
                        93.84,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        220.0,
                        562.0,
                        111.0,
                        20.0
                    ],
                    "text": "VERIFY PING",
                    "textcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-13",
                    "maxclass": "number",
                    "maximum": 8,
                    "minimum": 1,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1520.0,
                        100.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        220.0,
                        584.0,
                        44.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-14",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1420.0,
                        100.0,
                        22.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        272.0,
                        584.0,
                        22.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-15",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1450.0,
                        102.0,
                        219.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        300.0,
                        586.0,
                        200.0,
                        19.0
                    ],
                    "text": "noise burst to speaker N only",
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
                    "id": "obj-16",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "bang",
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        1420.0,
                        140.0,
                        65.0,
                        22.0
                    ],
                    "text": "t b b b"
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
                        1660.0,
                        190.0,
                        205.0,
                        22.0
                    ],
                    "text": "applyvalues 0 0 0 0 0 0 0 0"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-18",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1520.0,
                        190.0,
                        135.0,
                        22.0
                    ],
                    "text": "pack setvalue 1 1"
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
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        1520.0,
                        230.0,
                        128.0,
                        22.0
                    ],
                    "text": "mc.sig~ @chans 8"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-20",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1420.0,
                        190.0,
                        72.0,
                        22.0
                    ],
                    "text": "1 0 0 80"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-21",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "bang"
                    ],
                    "patching_rect": [
                        1420.0,
                        230.0,
                        51.0,
                        22.0
                    ],
                    "text": "line~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-22",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1420.0,
                        270.0,
                        58.0,
                        22.0
                    ],
                    "text": "noise~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-23",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1420.0,
                        310.0,
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
                    "id": "obj-24",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1420.0,
                        350.0,
                        65.0,
                        22.0
                    ],
                    "text": "*~ 0.25"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-25",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        1420.0,
                        400.0,
                        51.0,
                        22.0
                    ],
                    "text": "mc.*~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-26",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30.0,
                        752.0,
                        290.0,
                        31.0
                    ],
                    "text": "sources + ping sum at mc.delay~ (alignment delays from the venue dict, D23; all 0 = bit-transparent) -> mc.dac~",
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
                    "id": "obj-27",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30.0,
                        98.0,
                        639.0,
                        20.0
                    ],
                    "text": "bpatcher args: <name> <chans>   chans 1 = mono, 2 = stereo (JSON ints, #2 seeds the menu)",
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
                    "id": "obj-28",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        130.0,
                        690.0,
                        151.0,
                        22.0
                    ],
                    "text": "mc.delay~ 9600 @chans 8"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-29",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        200.0,
                        655.0,
                        100.0,
                        22.0
                    ],
                    "text": "r dbap-align"
                }
            },
            {
                "box": {
                    "args": [
                        "Am"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-30",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "dbap-motion.maxpat",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        330.0,
                        640.0,
                        460.0,
                        150.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        630.0,
                        460.0,
                        150.0
                    ],
                    "varname": "dbap-motion",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-31",
                    "linecount": 3,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        330.0,
                        806.0,
                        360.0,
                        43.0
                    ],
                    "text": "dbap-motion @args Am: outlet -> source inlet 3 (motion), source outlet 2 -> inlet (scenes). Patch one in per moving source; unpatched = no clock, no cost.",
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
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-32",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        816.0,
                        640.0,
                        100.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        490.0,
                        636.0,
                        120.0,
                        20.0
                    ],
                    "text": "MOTION -> A",
                    "textcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-33",
                    "linecount": 3,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        816.0,
                        662.0,
                        270.0,
                        43.0
                    ],
                    "presentation": 1,
                    "presentation_linecount": 2,
                    "presentation_rect": [
                        490.0,
                        658.0,
                        300.0,
                        31.0
                    ],
                    "text": "patched to source A: motion out -> inlet 3, scenes outlet -> motion in. One recall on A restores position and motion.",
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
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-34",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1000.0,
                        650.0,
                        226.0,
                        20.0
                    ],
                    "text": "VENUE read + ALIGN (D23 / D24)",
                    "textcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
                    ]
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
                        1000.0,
                        678.0,
                        44.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        540.0,
                        584.0,
                        40.0,
                        22.0
                    ],
                    "text": "read"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-36",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1050.0,
                        680.0,
                        51.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        540.0,
                        562.0,
                        60.0,
                        20.0
                    ],
                    "text": "VENUE",
                    "textcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-37",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 5,
                    "outlettype": [
                        "dictionary",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1000.0,
                        712.0,
                        100.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "legacy": 1,
                        "parameter_enable": 0,
                        "parameter_mappable": 0
                    },
                    "text": "dict venue"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-38",
                    "linecount": 3,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1110.0,
                        708.0,
                        230.0,
                        43.0
                    ],
                    "text": "same named dict as the embedded one: a read here replaces the shared venue (json from tools/venue_to_json.py)",
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
                    "id": "obj-39",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1081.0,
                        762.0,
                        101.0,
                        22.0
                    ],
                    "text": "route read"
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
                        1081.0,
                        792.0,
                        37.0,
                        22.0
                    ],
                    "text": "t b"
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
                        1081.0,
                        822.0,
                        51.0,
                        22.0
                    ],
                    "text": "venue"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-42",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1081.0,
                        852.0,
                        100.0,
                        22.0
                    ],
                    "text": "s dbap-venue"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-43",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1360.0,
                        712.0,
                        100.0,
                        22.0
                    ],
                    "text": "r dbap-venue"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-44",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "int",
                        "float",
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        1490.0,
                        678.0,
                        79.0,
                        22.0
                    ],
                    "text": "dspstate~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-45",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1490.0,
                        712.0,
                        97.0,
                        22.0
                    ],
                    "text": "prepend sr"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-46",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1360.0,
                        762.0,
                        130.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "filename": "venue-align.js",
                        "parameter_enable": 0
                    },
                    "text": "js venue-align.js"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-47",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1360.0,
                        802.0,
                        100.0,
                        22.0
                    ],
                    "text": "s dbap-align"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-48",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1480.0,
                        804.0,
                        420.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        590.0,
                        586.0,
                        560.0,
                        19.0
                    ],
                    "text": "Roy Barnett Recital Hall (O-Octagon OQ4 tra...   |   align off (all speakers 0 ms)",
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "varname": "alignstatus"
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
                        1360.0,
                        830.0,
                        420.0,
                        19.0
                    ],
                    "text": "setvalue N samples -> mc.delay~ right inlet (int samples: delay 0 = no delay)",
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
                    "id": "obj-50",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        831.0,
                        15.0,
                        86.0,
                        22.0
                    ],
                    "text": "p about",
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
                            120.0,
                            120.0,
                            750.0,
                            544.0
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
                                        20,
                                        20,
                                        700,
                                        26
                                    ],
                                    "text": "BARNETT DBAP -- two sources panned over the 8-speaker Barnett Hall rig",
                                    "fontname": "Arial",
                                    "fontsize": 16.0,
                                    "fontface": 1
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
                                        20,
                                        58,
                                        700,
                                        23
                                    ],
                                    "text": "USING IT",
                                    "fontname": "Arial",
                                    "fontsize": 13.0,
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
                                        20,
                                        83,
                                        700,
                                        22
                                    ],
                                    "text": "Turn on DSP (OUTPUT). Speaker N plays on interface output N.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "comment",
                                    "id": "obj-4",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        20,
                                        105,
                                        700,
                                        22
                                    ],
                                    "text": "Source A is mono, source B is stereo. Each picks File, Live (adc ch) or Inlet in its SOURCE menu.",
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
                                        20,
                                        127,
                                        700,
                                        22
                                    ],
                                    "text": "File: drop an audio file or click open, then play (and loop). trim sets the input level.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        20,
                                        149,
                                        700,
                                        22
                                    ],
                                    "text": "Drag the puck on the plan to place the source. src Z (m) sets its height.",
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
                                        20,
                                        171,
                                        700,
                                        22
                                    ],
                                    "text": "rolloff, blur: how sharply level falls off with distance, and how much it spreads.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        20,
                                        193,
                                        700,
                                        22
                                    ],
                                    "text": "width, decorr: spread the source into two points and blur them apart.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "comment",
                                    "id": "obj-9",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        20,
                                        215,
                                        700,
                                        22
                                    ],
                                    "text": "air: distance high-cut. hull: dB/m of fade when the source moves outside the speaker ring.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        20,
                                        237,
                                        700,
                                        22
                                    ],
                                    "text": "WEIGHTS favour or mute speakers. TRIMS (dB) offset each speaker. MASTER sets the output level.",
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
                                        20,
                                        259,
                                        700,
                                        22
                                    ],
                                    "text": "SCENES: pick a slot number, then store or recall. read / write save the slots to disk.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        20,
                                        281,
                                        700,
                                        22
                                    ],
                                    "text": "MOTION -> A: switch on, pick a path (orbit ... spiral, recorded) and shape it with the dials.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        20,
                                        303,
                                        700,
                                        22
                                    ],
                                    "text": "    rec: draw a gesture with the puck to make the recorded path. loop menu + cue fire one-shots.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        20,
                                        325,
                                        700,
                                        22
                                    ],
                                    "text": "    wander adds drift on top of any path. Motion settings are stored in source A's scenes.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        20,
                                        347,
                                        700,
                                        22
                                    ],
                                    "text": "VERIFY PING: pick a speaker number and click to send a noise burst to that speaker only.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        20,
                                        369,
                                        700,
                                        22
                                    ],
                                    "text": "VENUE read: load another venue layout (JSON) with speaker positions and alignment delays.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        20,
                                        401,
                                        700,
                                        23
                                    ],
                                    "text": "HOW IT WORKS",
                                    "fontname": "Arial",
                                    "fontsize": 13.0,
                                    "fontface": 1
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
                                        20,
                                        426,
                                        700,
                                        22
                                    ],
                                    "text": "Each source is a dbap-source bpatcher (args: name, 1 = mono / 2 = stereo) with its own js dbap.js.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "comment",
                                    "id": "obj-19",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        20,
                                        448,
                                        700,
                                        22
                                    ],
                                    "text": "The js solves Distance-Based Amplitude Panning over the hall's speaker layout into 8 gains.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        20,
                                        470,
                                        700,
                                        22
                                    ],
                                    "text": "The gains ramp an 8-channel mc signal. Both sources sum through alignment delays to mc.dac~ 1-8.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        20,
                                        492,
                                        700,
                                        22
                                    ],
                                    "text": "Both modules also accept '<control> <value>' messages to set any control (see control-demo).",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            }
                        ],
                        "lines": [],
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
                    },
                    "saved_object_attributes": {
                        "description": "",
                        "digest": "",
                        "globalpatchername": "",
                        "tags": ""
                    }
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-18",
                        1
                    ],
                    "midpoints": [
                        1529.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1398.0,
                        94.0,
                        1442.0,
                        94.0,
                        1442.0,
                        129.0,
                        1587.5,
                        129.0
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
                        0
                    ],
                    "midpoints": [
                        1429.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1398.0,
                        94.0,
                        1442.0,
                        94.0,
                        1442.0,
                        129.0,
                        1429.5,
                        129.0
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
                    "midpoints": [
                        1475.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1398.0,
                        182.0,
                        1512.0,
                        182.0,
                        1512.0,
                        220.0,
                        1512.0,
                        182.0,
                        1500.0,
                        182.0,
                        1500.0,
                        220.0,
                        1669.5,
                        220.0
                    ],
                    "source": [
                        "obj-16",
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
                        1452.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1398.0,
                        182.0,
                        1500.0,
                        182.0,
                        1500.0,
                        220.0,
                        1529.5,
                        220.0
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
                        "obj-20",
                        0
                    ],
                    "midpoints": [
                        1429.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1429.5,
                        464.0
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
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        1669.5,
                        48.0,
                        1834.0,
                        48.0,
                        1834.0,
                        464.0,
                        1834.0,
                        182.0,
                        1663.0,
                        182.0,
                        1663.0,
                        220.0,
                        1529.5,
                        220.0
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
                    "midpoints": [
                        1529.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1529.5,
                        464.0
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
                        "obj-25",
                        1
                    ],
                    "midpoints": [
                        1529.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1398.0,
                        222.0,
                        1479.0,
                        222.0,
                        1479.0,
                        260.0,
                        1479.0,
                        262.0,
                        1486.0,
                        262.0,
                        1486.0,
                        300.0,
                        1486.0,
                        302.0,
                        1470.0,
                        302.0,
                        1470.0,
                        340.0,
                        1470.0,
                        342.0,
                        1493.0,
                        342.0,
                        1493.0,
                        380.0,
                        1461.5,
                        380.0
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
                        1429.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1429.5,
                        464.0
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
                        "obj-23",
                        1
                    ],
                    "midpoints": [
                        1429.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1398.0,
                        262.0,
                        1412.0,
                        262.0,
                        1412.0,
                        300.0,
                        1452.5,
                        300.0
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
                        1429.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1429.5,
                        464.0
                    ],
                    "source": [
                        "obj-22",
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
                    "midpoints": [
                        1429.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1429.5,
                        464.0
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
                    "midpoints": [
                        1429.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1429.5,
                        464.0
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
                        "obj-28",
                        0
                    ],
                    "midpoints": [
                        1429.5,
                        630.0,
                        139.5,
                        630.0
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
                        "obj-11",
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
                        "obj-28",
                        1
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
                        "obj-6",
                        2
                    ],
                    "midpoints": [
                        339.5,
                        797.0,
                        705.0,
                        797.0,
                        705.0,
                        108.0,
                        619.5,
                        108.0
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
                        "obj-39",
                        0
                    ],
                    "source": [
                        "obj-37",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-40",
                        0
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
                        "obj-41",
                        0
                    ],
                    "source": [
                        "obj-40",
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
                    "source": [
                        "obj-41",
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
                        "obj-43",
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
                    "source": [
                        "obj-44",
                        1
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
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-47",
                        0
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
                        "obj-48",
                        0
                    ],
                    "source": [
                        "obj-46",
                        1
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
                        "obj-6",
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
                    "source": [
                        "obj-6",
                        1
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
                        729.5,
                        630.0,
                        139.5,
                        630.0
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        39.5,
                        675.0,
                        108.0,
                        675.0,
                        108.0,
                        710.0,
                        39.5,
                        710.0
                    ],
                    "source": [
                        "obj-9",
                        0
                    ]
                }
            }
        ],
        "parameters": {
            "obj-30::obj-11": [
                "size",
                "size",
                0
            ],
            "obj-30::obj-13": [
                "ratio",
                "ratio",
                0
            ],
            "obj-30::obj-15": [
                "angle",
                "angle",
                0
            ],
            "obj-30::obj-17": [
                "height",
                "height",
                0
            ],
            "obj-30::obj-19": [
                "phase",
                "phase",
                0
            ],
            "obj-30::obj-70": [
                "wander",
                "wander",
                0
            ],
            "obj-30::obj-9": [
                "rate",
                "rate",
                0
            ],
            "obj-6::obj-136": [
                "width[1]",
                "width",
                0
            ],
            "obj-6::obj-137": [
                "decorr[1]",
                "decorr",
                0
            ],
            "obj-6::obj-143": [
                "air[1]",
                "air",
                0
            ],
            "obj-6::obj-144": [
                "hull[1]",
                "hull",
                0
            ],
            "obj-6::obj-30": [
                "rolloff[1]",
                "rolloff",
                0
            ],
            "obj-6::obj-31": [
                "blur[1]",
                "blur",
                0
            ],
            "obj-6::obj-80": [
                "master[1]",
                "master",
                0
            ],
            "obj-7::obj-136": [
                "width",
                "width",
                0
            ],
            "obj-7::obj-137": [
                "decorr",
                "decorr",
                0
            ],
            "obj-7::obj-143": [
                "air",
                "air",
                0
            ],
            "obj-7::obj-144": [
                "hull",
                "hull",
                0
            ],
            "obj-7::obj-30": [
                "rolloff",
                "rolloff",
                0
            ],
            "obj-7::obj-31": [
                "blur",
                "blur",
                0
            ],
            "obj-7::obj-80": [
                "master",
                "master",
                0
            ],
            "parameterbanks": {
                "0": {
                    "index": 0,
                    "name": "",
                    "parameters": [
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-"
                    ],
                    "buttons": [
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-"
                    ]
                }
            },
            "parameter_overrides": {
                "obj-6::obj-136": {
                    "parameter_longname": "width[1]"
                },
                "obj-6::obj-137": {
                    "parameter_longname": "decorr[1]"
                },
                "obj-6::obj-143": {
                    "parameter_longname": "air[1]"
                },
                "obj-6::obj-144": {
                    "parameter_longname": "hull[1]"
                },
                "obj-6::obj-30": {
                    "parameter_longname": "rolloff[1]"
                },
                "obj-6::obj-31": {
                    "parameter_longname": "blur[1]"
                },
                "obj-6::obj-80": {
                    "parameter_longname": "master[1]"
                }
            },
            "inherited_shortname": 1
        },
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
        ]
    }
}