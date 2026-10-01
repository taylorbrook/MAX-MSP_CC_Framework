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
            60.0,
            60.0,
            1520.0,
            1350.0
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
                        30,
                        15,
                        500,
                        20.0
                    ],
                    "text": "Wormhole v1.4.0 remote + recall check",
                    "fontname": "Arial",
                    "fontsize": 16,
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
                        30,
                        45,
                        1050,
                        20.0
                    ],
                    "text": "1. Turn audio on (ezdac~), pick Saw or a file. 2. Click each row's min / default / max: the dial must reach the value shown in its readout.",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        30,
                        67,
                        1050,
                        20.0
                    ],
                    "text": "3. Snapshots: open the right sidebar > Snapshots, store one, move dials, recall it -> every dial returns. 4. \"Reset all\" restores the defaults.",
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
                        30,
                        110,
                        58.0,
                        20.0
                    ],
                    "text": "Source",
                    "fontname": "Arial",
                    "fontsize": 12,
                    "fontface": 1
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-5",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30,
                        135,
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
                    "maxclass": "message",
                    "id": "obj-6",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30,
                        165,
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
                        30.0,
                        195.0,
                        90.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "items": [
                        "Off",
                        ",",
                        "Saw",
                        ",",
                        "File"
                    ]
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
                        30,
                        230,
                        93.0,
                        22.0
                    ],
                    "text": "trigger i i",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-9",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        150,
                        135,
                        72.0,
                        22.0
                    ],
                    "text": "saw~ 110",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-10",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        150,
                        165,
                        58.0,
                        22.0
                    ],
                    "text": "*~ 0.2",
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
                        330,
                        110,
                        44.0,
                        22.0
                    ],
                    "text": "open",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-12",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        390,
                        110,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0
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
                        418,
                        112,
                        44.0,
                        20.0
                    ],
                    "text": "Play",
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
                        330,
                        140,
                        128.0,
                        22.0
                    ],
                    "text": "opendialog sound",
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
                        330,
                        170,
                        100.0,
                        22.0
                    ],
                    "text": "prepend open",
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
                        470,
                        140,
                        135.0,
                        22.0
                    ],
                    "text": "loadmess modout 1",
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
                        470,
                        170,
                        121.0,
                        22.0
                    ],
                    "text": "loadmess loop 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-18",
                    "numinlets": 2,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        330.0,
                        200.0,
                        220.0,
                        22.0
                    ],
                    "text": "sfplay~ 2",
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
                        600,
                        230,
                        51.0,
                        22.0
                    ],
                    "text": "set 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-20",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        150,
                        265,
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
                    "id": "obj-21",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        330,
                        265,
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
                    "id": "obj-22",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        930,
                        265,
                        100.0,
                        22.0
                    ],
                    "text": "receive whrt",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "bpatcher",
                    "id": "obj-23",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30,
                        310,
                        1058,
                        140
                    ],
                    "args": [],
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
                    "name": "wormhole.maxpat"
                }
            },
            {
                "box": {
                    "maxclass": "live.gain~",
                    "id": "obj-24",
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
                        1110.0,
                        310.0,
                        48.0,
                        136.0
                    ],
                    "parameter_enable": 1,
                    "varname": "out_gain",
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                -6.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Output Gain",
                            "parameter_shortname": "Gain",
                            "parameter_mmin": -70.0,
                            "parameter_mmax": 6.0,
                            "parameter_type": 0,
                            "parameter_unitstyle": 4,
                            "parameter_modmode": 0
                        }
                    }
                }
            },
            {
                "box": {
                    "maxclass": "ezdac~",
                    "id": "obj-25",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1110,
                        470,
                        45.0,
                        45.0
                    ],
                    "parameter_enable": 0
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
                        30,
                        480,
                        700,
                        20.0
                    ],
                    "text": "Range check  (min / default / max  -> dial and readout must land exactly on these)",
                    "fontname": "Arial",
                    "fontsize": 12,
                    "fontface": 1
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
                        30,
                        518.0,
                        170,
                        20.0
                    ],
                    "text": "delay_L  (ms)",
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
                        210,
                        510.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt delay_L 0",
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
                        420,
                        510.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt delay_L 250",
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
                        630,
                        510.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt delay_L 500",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        30,
                        560.0,
                        170,
                        20.0
                    ],
                    "text": "delay_R  (ms)",
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
                        210,
                        552.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt delay_R 0",
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
                        420,
                        552.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt delay_R 250",
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
                        630,
                        552.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt delay_R 500",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-35",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30,
                        602.0,
                        170,
                        20.0
                    ],
                    "text": "delay_route  (Both/Dry/FX)",
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
                        210,
                        594.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt delay_route 0",
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
                        420,
                        594.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt delay_route 1",
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
                        630,
                        594.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt delay_route 2",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-39",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30,
                        644.0,
                        170,
                        20.0
                    ],
                    "text": "depth  (0-1)",
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
                        210,
                        636.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt depth 0",
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
                        420,
                        636.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt depth 0.5",
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
                        630,
                        636.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt depth 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        30,
                        686.0,
                        170,
                        20.0
                    ],
                    "text": "poles  (stages)",
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
                        210,
                        678.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt poles 2",
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
                        420,
                        678.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt poles 8",
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
                        630,
                        678.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt poles 32",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-47",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30,
                        728.0,
                        170,
                        20.0
                    ],
                    "text": "feedback  (0-1)",
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
                        210,
                        720.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt feedback 0",
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
                        420,
                        720.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt feedback 0.5",
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
                        630,
                        720.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt feedback 1",
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
                        30,
                        770.0,
                        170,
                        20.0
                    ],
                    "text": "tilt  (-1 to 1)",
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
                        210,
                        762.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt tilt -1",
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
                        420,
                        762.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt tilt 0",
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
                        630,
                        762.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt tilt 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        30,
                        812.0,
                        170,
                        20.0
                    ],
                    "text": "pitch  (st)",
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
                        210,
                        804.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt pitch -48",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-57",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420,
                        804.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt pitch 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-58",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        630,
                        804.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt pitch 48",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        30,
                        854.0,
                        170,
                        20.0
                    ],
                    "text": "freq_shift  (Hz)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-60",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        210,
                        846.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt freq_shift -4000",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-61",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420,
                        846.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt freq_shift 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-62",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        630,
                        846.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt freq_shift 4000",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        30,
                        896.0,
                        170,
                        20.0
                    ],
                    "text": "pitch_mode  (menu)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-64",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        210,
                        888.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt pitch_mode 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-65",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420,
                        888.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt pitch_mode 2",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-66",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        630,
                        888.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt pitch_mode 3",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        30,
                        938.0,
                        170,
                        20.0
                    ],
                    "text": "decay_time  (0.01-1)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-68",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        210,
                        930.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt decay_time 0.01",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-69",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420,
                        930.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt decay_time 0.5",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-70",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        630,
                        930.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt decay_time 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        30,
                        980.0,
                        170,
                        20.0
                    ],
                    "text": "pre_mix  (0-1)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-72",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        210,
                        972.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt pre_mix 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-73",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420,
                        972.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt pre_mix 0.3",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-74",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        630,
                        972.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt pre_mix 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-75",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30,
                        1022.0,
                        170,
                        20.0
                    ],
                    "text": "pre_size  (0.1-1)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-76",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        210,
                        1014.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt pre_size 0.1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-77",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420,
                        1014.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt pre_size 0.7",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-78",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        630,
                        1014.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt pre_size 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-79",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30,
                        1064.0,
                        170,
                        20.0
                    ],
                    "text": "pre_damping  (0-1)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-80",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        210,
                        1056.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt pre_damping 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-81",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420,
                        1056.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt pre_damping 0.5",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-82",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        630,
                        1056.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt pre_damping 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-83",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30,
                        1106.0,
                        170,
                        20.0
                    ],
                    "text": "blend  (0-1)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-84",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        210,
                        1098.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt blend 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-85",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420,
                        1098.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt blend 0.5",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-86",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        630,
                        1098.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt blend 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        30,
                        1148.0,
                        170,
                        20.0
                    ],
                    "text": "morph_mode  (menu)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-88",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        210,
                        1140.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt morph_mode 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-89",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420,
                        1140.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt morph_mode 1",
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
                        30,
                        1190.0,
                        170,
                        20.0
                    ],
                    "text": "post_mix  (0-1)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-91",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        210,
                        1182.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt post_mix 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-92",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420,
                        1182.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt post_mix 0.3",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-93",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        630,
                        1182.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt post_mix 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        30,
                        1232.0,
                        170,
                        20.0
                    ],
                    "text": "post_size  (0.1-1)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-95",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        210,
                        1224.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt post_size 0.1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-96",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420,
                        1224.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt post_size 0.7",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-97",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        630,
                        1224.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt post_size 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        30,
                        1274.0,
                        170,
                        20.0
                    ],
                    "text": "post_damping  (0-1)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-99",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        210,
                        1266.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt post_damping 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-100",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420,
                        1266.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt post_damping 0.5",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-101",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        630,
                        1266.0,
                        195,
                        36.0
                    ],
                    "text": ";\rwhrt post_damping 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        900.0,
                        480,
                        200,
                        20.0
                    ],
                    "text": "Presets",
                    "fontname": "Arial",
                    "fontsize": 12,
                    "fontface": 1
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-103",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        900.0,
                        505,
                        200,
                        20.0
                    ],
                    "text": "Reset all to defaults",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        900.0,
                        527,
                        230,
                        306.0
                    ],
                    "text": ";\rwhrt delay_L 0;\rwhrt delay_R 0;\rwhrt delay_route 0;\rwhrt depth 0.5;\rwhrt poles 8;\rwhrt feedback 0.5;\rwhrt tilt 0;\rwhrt pitch 0;\rwhrt freq_shift 0;\rwhrt pitch_mode 0;\rwhrt decay_time 1;\rwhrt pre_mix 0.3;\rwhrt pre_size 0.7;\rwhrt pre_damping 0.5;\rwhrt blend 0.5;\rwhrt morph_mode 0;\rwhrt post_mix 0.3;\rwhrt post_size 0.7;\rwhrt post_damping 0.5",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-105",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1160.0,
                        505,
                        260,
                        20.0
                    ],
                    "text": "Shimmer (octave up into big verb)",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-106",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1160.0,
                        527,
                        230,
                        126.0
                    ],
                    "text": ";\rwhrt pitch 12;\rwhrt pitch_mode 0;\rwhrt pre_mix 0.6;\rwhrt pre_size 1;\rwhrt blend 0.6;\rwhrt post_mix 0.5;\rwhrt post_size 0.9",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-107",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1160.0,
                        680,
                        260,
                        20.0
                    ],
                    "text": "Ring warp (slow freq shift, many poles)",
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
                        1160.0,
                        702,
                        230,
                        111.0
                    ],
                    "text": ";\rwhrt freq_shift 7;\rwhrt poles 24;\rwhrt feedback 0.7;\rwhrt depth 0.8;\rwhrt tilt 0.4;\rwhrt blend 0.8",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-109",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1160.0,
                        830,
                        260,
                        20.0
                    ],
                    "text": "Wide delay (dry only, L/R opposed)",
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
                        1160.0,
                        852,
                        230,
                        81.0
                    ],
                    "text": ";\rwhrt delay_route 1;\rwhrt delay_L 12;\rwhrt delay_R 31;\rwhrt blend 0.5",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            }
        ],
        "lines": [
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
                        66.0,
                        161.0,
                        37.0,
                        161.0
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
                        50.0,
                        191.0,
                        75.0,
                        191.0
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
                        37.0,
                        223.5,
                        76.5,
                        223.5
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
                    ],
                    "midpoints": [
                        186.0,
                        161.0,
                        157.0,
                        161.0
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
                        "obj-14",
                        0
                    ],
                    "midpoints": [
                        352.0,
                        102.0,
                        382.0,
                        102.0,
                        382.0,
                        142.0,
                        394.0,
                        142.0
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
                        337.0,
                        166.0,
                        380.0,
                        166.0
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
                        "obj-18",
                        0
                    ],
                    "midpoints": [
                        380.0,
                        196.0,
                        337.0,
                        196.0
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
                    ],
                    "midpoints": [
                        402.0,
                        102.0,
                        382.0,
                        102.0,
                        382.0,
                        140.0,
                        382.0,
                        132.0,
                        322.0,
                        132.0,
                        322.0,
                        170.0,
                        322.0,
                        162.0,
                        322.0,
                        162.0,
                        322.0,
                        200.0,
                        337.0,
                        200.0
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
                        537.5,
                        132.0,
                        466.0,
                        132.0,
                        466.0,
                        170.0,
                        466.0,
                        162.0,
                        438.0,
                        162.0,
                        438.0,
                        200.0,
                        438.0,
                        162.0,
                        462.0,
                        162.0,
                        462.0,
                        200.0,
                        337.0,
                        200.0
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
                        530.5,
                        162.0,
                        438.0,
                        162.0,
                        438.0,
                        200.0,
                        337.0,
                        200.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-18",
                        2
                    ],
                    "destination": [
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        543.0,
                        226.0,
                        607.0,
                        226.0
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
                        "obj-12",
                        0
                    ],
                    "midpoints": [
                        1450.0,
                        257.0,
                        1450.0,
                        102,
                        402.0,
                        102
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
                        "obj-21",
                        0
                    ],
                    "midpoints": [
                        116.0,
                        257.0,
                        142.0,
                        257.0,
                        142.0,
                        295.0,
                        337.0,
                        295.0
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
                        "obj-20",
                        0
                    ],
                    "midpoints": [
                        37.0,
                        258.5,
                        157.0,
                        258.5
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
                        "obj-20",
                        1
                    ],
                    "midpoints": [
                        179.0,
                        226.0,
                        230.0,
                        226.0
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
                        "obj-21",
                        1
                    ],
                    "midpoints": [
                        179.0,
                        162.0,
                        322.0,
                        162.0,
                        322.0,
                        200.0,
                        322.0,
                        192.0,
                        322.0,
                        192.0,
                        322.0,
                        230.0,
                        322.0,
                        257.0,
                        318.0,
                        257.0,
                        318.0,
                        295.0,
                        410.0,
                        295.0
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
                        "obj-20",
                        2
                    ],
                    "midpoints": [
                        337.0,
                        257.0,
                        322.0,
                        257.0,
                        322.0,
                        295.0,
                        303.0,
                        295.0
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
                        "obj-21",
                        2
                    ],
                    "midpoints": [
                        440.0,
                        243.5,
                        483.0,
                        243.5
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
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        230.0,
                        298.5,
                        37.0,
                        298.5
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
                        410.0,
                        298.5,
                        559.0,
                        298.5
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
                        2
                    ],
                    "midpoints": [
                        980.0,
                        298.5,
                        1081.0,
                        298.5
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
                        1458.0,
                        455,
                        1458.0,
                        302.0,
                        1117.0,
                        302.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-23",
                        1
                    ],
                    "destination": [
                        "obj-24",
                        1
                    ],
                    "midpoints": [
                        1466.0,
                        455,
                        1466.0,
                        302.0,
                        1151.0,
                        302.0
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
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-24",
                        1
                    ],
                    "destination": [
                        "obj-25",
                        1
                    ],
                    "midpoints": [
                        1125.5,
                        458.0,
                        1148.0,
                        458.0
                    ]
                }
            }
        ],
        "dependency_cache": [],
        "autosave": 0
    }
}