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
            40.0,
            60.0,
            1400.0,
            700.0
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
                    "id": "obj-3",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1406.0,
                        56.0,
                        420.0,
                        400.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        556.0,
                        1340.0,
                        64.0
                    ],
                    "background": 1,
                    "ignoreclick": 1,
                    "border": 0,
                    "rounded": 6,
                    "mode": 0,
                    "bgcolor": [
                        0.19,
                        0.19,
                        0.22,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-1",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30.0,
                        15.0,
                        408.8,
                        25.6
                    ],
                    "text": "BARNETT DBAP  v0.2   two sources -> 8 ch",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        10.0,
                        420.0,
                        26.0
                    ],
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
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
                        470.0,
                        20.0,
                        331.0,
                        16.0
                    ],
                    "text": "Roy Barnett Recital Hall  (OQ4 traced layout)",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        460.0,
                        15.0,
                        320.0,
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
                    "maxclass": "newobj",
                    "id": "obj-4",
                    "numinlets": 2,
                    "numoutlets": 5,
                    "outlettype": [
                        "",
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
                    "text": "dict venue @embed 1",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "saved_object_attributes": {
                        "embed": 1,
                        "parameter_enable": 0,
                        "parameter_mappable": 0
                    },
                    "data": {
                        "name": "Roy Barnett Recital Hall (O-Octagon OQ4 traced layout, not measured)",
                        "units": "metres",
                        "speakers": {
                            "s1": {
                                "x": 0.5,
                                "y": 4.5,
                                "z": 4.5
                            },
                            "s2": {
                                "x": 12.5,
                                "y": 4.5,
                                "z": 4.5
                            },
                            "s3": {
                                "x": 12.5,
                                "y": 9.85,
                                "z": 4.7
                            },
                            "s4": {
                                "x": 12.5,
                                "y": 16.0,
                                "z": 5.1
                            },
                            "s5": {
                                "x": 9.8,
                                "y": 19.5,
                                "z": 5.4
                            },
                            "s6": {
                                "x": 3.2,
                                "y": 19.5,
                                "z": 5.4
                            },
                            "s7": {
                                "x": 0.5,
                                "y": 16.0,
                                "z": 5.1
                            },
                            "s8": {
                                "x": 0.5,
                                "y": 9.85,
                                "z": 4.7
                            }
                        },
                        "rake": {
                            "front": 1.1,
                            "rear": 3.2
                        }
                    }
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
                        190.0,
                        72.0,
                        415.0,
                        17.6
                    ],
                    "text": "shared venue: read by every instance's dbap.js (Dict API)",
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
                    "maxclass": "bpatcher",
                    "id": "obj-6",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        120.0,
                        660.0,
                        500.0
                    ],
                    "args": [
                        "A"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "lockeddragscroll": 0,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "viewvisibility": 1,
                    "name": "dbap-source.maxpat",
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        40.0,
                        660.0,
                        500.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "bpatcher",
                    "id": "obj-7",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        720.0,
                        120.0,
                        660.0,
                        500.0
                    ],
                    "args": [
                        "B"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "lockeddragscroll": 0,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "viewvisibility": 1,
                    "name": "dbap-source.maxpat",
                    "presentation": 1,
                    "presentation_rect": [
                        700.0,
                        40.0,
                        660.0,
                        500.0
                    ]
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
                        30.0,
                        650.0,
                        58.0,
                        19.200000000000003
                    ],
                    "text": "OUTPUT",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        30.0,
                        562.0,
                        66.0,
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
                    "maxclass": "toggle",
                    "id": "obj-9",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        680.0,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        100.0,
                        570.0,
                        30.0,
                        30.0
                    ],
                    "checkedcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
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
                        60.0,
                        683.0,
                        40.0,
                        17.6
                    ],
                    "text": "DSP",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [
                        136.0,
                        576.0,
                        40.0,
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
                    "maxclass": "newobj",
                    "id": "obj-11",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30.0,
                        720.0,
                        177.0,
                        22.0
                    ],
                    "text": "mc.dac~ 1 2 3 4 5 6 7 8",
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
                        1420.0,
                        70.0,
                        93.84,
                        19.200000000000003
                    ],
                    "text": "VERIFY PING",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        220.0,
                        562.0,
                        111.0,
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
                    "maxclass": "number",
                    "id": "obj-13",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1520.0,
                        100.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        220.0,
                        584.0,
                        44.0,
                        22.0
                    ],
                    "minimum": 1,
                    "maximum": 8
                }
            },
            {
                "box": {
                    "maxclass": "button",
                    "id": "obj-14",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1420.0,
                        100.0,
                        22.0,
                        22.0
                    ],
                    "parameter_enable": 0,
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
                    "maxclass": "comment",
                    "id": "obj-15",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1450.0,
                        102.0,
                        219.0,
                        17.6
                    ],
                    "text": "noise burst to speaker N only",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [
                        300.0,
                        586.0,
                        200.0,
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
                    "maxclass": "newobj",
                    "id": "obj-16",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1420.0,
                        140.0,
                        65.0,
                        22.0
                    ],
                    "text": "t b b b",
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
                        1660.0,
                        190.0,
                        205.0,
                        22.0
                    ],
                    "text": "applyvalues 0 0 0 0 0 0 0 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-18",
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
                    "text": "pack setvalue 1 1",
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
                        "signal"
                    ],
                    "patching_rect": [
                        1520.0,
                        230.0,
                        128.0,
                        22.0
                    ],
                    "text": "mc.sig~ @chans 8",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        1420.0,
                        190.0,
                        72.0,
                        22.0
                    ],
                    "text": "1 0 0 80",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-21",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        1420.0,
                        230.0,
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
                    "id": "obj-22",
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
                    "text": "noise~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-23",
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
                    "text": "*~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-24",
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
                    "text": "*~ 0.25",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-25",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1420.0,
                        400.0,
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
                    "maxclass": "comment",
                    "id": "obj-26",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        220.0,
                        722.0,
                        303.0,
                        17.6
                    ],
                    "text": "instances + ping sum at the mc.dac~ inlet",
                    "fontname": "Arial",
                    "fontsize": 11.0,
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
                        "obj-6",
                        0
                    ],
                    "destination": [
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        360.0,
                        48.0,
                        8.0,
                        48.0,
                        8.0,
                        764.0,
                        8.0,
                        714.0,
                        212.0,
                        714.0,
                        212.0,
                        747.6,
                        118.5,
                        747.6
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        1050.0,
                        48.0,
                        8.0,
                        48.0,
                        8.0,
                        764.0,
                        8.0,
                        112.0,
                        698.0,
                        112.0,
                        698.0,
                        628.0,
                        698.0,
                        714.0,
                        531.0,
                        714.0,
                        531.0,
                        747.6,
                        118.5,
                        747.6
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
                    ],
                    "midpoints": [
                        42.0,
                        48.0,
                        8.0,
                        48.0,
                        8.0,
                        764.0,
                        8.0,
                        675.0,
                        108.0,
                        675.0,
                        108.0,
                        708.6,
                        118.5,
                        708.6
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
                        "obj-18",
                        1
                    ],
                    "midpoints": [
                        1527.0,
                        48.0,
                        1887.0,
                        48.0,
                        1887.0,
                        764.0,
                        1887.0,
                        94.0,
                        1442.0,
                        94.0,
                        1442.0,
                        127.6,
                        1587.5,
                        127.6
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
                        "obj-16",
                        0
                    ],
                    "midpoints": [
                        1431.0,
                        48.0,
                        1887.0,
                        48.0,
                        1887.0,
                        764.0,
                        1887.0,
                        94.0,
                        1442.0,
                        94.0,
                        1442.0,
                        127.6,
                        1452.5,
                        127.6
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-16",
                        2
                    ],
                    "destination": [
                        "obj-17",
                        0
                    ],
                    "midpoints": [
                        1478.0,
                        48.0,
                        1887.0,
                        48.0,
                        1887.0,
                        764.0,
                        1887.0,
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
                        1667.0,
                        220.0
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
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        1762.5,
                        48.0,
                        1887.0,
                        48.0,
                        1887.0,
                        764.0,
                        1887.0,
                        182.0,
                        1663.0,
                        182.0,
                        1663.0,
                        220.0,
                        1584.0,
                        220.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-16",
                        1
                    ],
                    "destination": [
                        "obj-18",
                        0
                    ],
                    "midpoints": [
                        1452.5,
                        48.0,
                        1887.0,
                        48.0,
                        1887.0,
                        764.0,
                        1887.0,
                        182.0,
                        1500.0,
                        182.0,
                        1500.0,
                        220.0,
                        1527.0,
                        220.0
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
                    ],
                    "midpoints": [
                        1587.5,
                        48.0,
                        1887.0,
                        48.0,
                        1887.0,
                        764.0,
                        1584.0,
                        764.0
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
                        "obj-20",
                        0
                    ],
                    "midpoints": [
                        1427.0,
                        48.0,
                        1887.0,
                        48.0,
                        1887.0,
                        764.0,
                        1427.0,
                        764.0
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
                    ],
                    "midpoints": [
                        1456.0,
                        48.0,
                        1887.0,
                        48.0,
                        1887.0,
                        764.0,
                        1427.0,
                        764.0
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
                    ],
                    "midpoints": [
                        1449.0,
                        48.0,
                        1887.0,
                        48.0,
                        1887.0,
                        764.0,
                        1427.0,
                        764.0
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
                        "obj-23",
                        1
                    ],
                    "midpoints": [
                        1427.0,
                        48.0,
                        1887.0,
                        48.0,
                        1887.0,
                        764.0,
                        1887.0,
                        262.0,
                        1412.0,
                        262.0,
                        1412.0,
                        300.0,
                        1455.0,
                        300.0
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
                        "obj-24",
                        0
                    ],
                    "midpoints": [
                        1441.0,
                        48.0,
                        1887.0,
                        48.0,
                        1887.0,
                        764.0,
                        1427.0,
                        764.0
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
                        1452.5,
                        48.0,
                        1887.0,
                        48.0,
                        1887.0,
                        764.0,
                        1427.0,
                        764.0
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
                        "obj-25",
                        1
                    ],
                    "midpoints": [
                        1584.0,
                        48.0,
                        1887.0,
                        48.0,
                        1887.0,
                        764.0,
                        1887.0,
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
                        1464.0,
                        380.0
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        1445.5,
                        48.0,
                        8.0,
                        48.0,
                        8.0,
                        764.0,
                        8.0,
                        112.0,
                        698.0,
                        112.0,
                        698.0,
                        628.0,
                        698.0,
                        112.0,
                        712.0,
                        112.0,
                        712.0,
                        628.0,
                        712.0,
                        714.0,
                        531.0,
                        714.0,
                        531.0,
                        747.6,
                        118.5,
                        747.6
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