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
            640.0,
            480.0
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
                        15,
                        15,
                        700,
                        20.0
                    ],
                    "text": "terrain-voice  --  poly~ voice: slot A terrain-osc / slot B terrain-osc-b -> mix -> svf~ -> adsr~",
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
                    "id": "obj-2",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        15,
                        40,
                        900,
                        20.0
                    ],
                    "text": "in 1: [pitch velocity] list from poly~ midinote (velocity 0 = note-off) -> unpack -> swap (pitch first, then velocity). Global params arrive by receive: tsyn-osc (terrain-osc param messages) and tsyn-voice (<name> <value>).",
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
                    "id": "obj-3",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        15,
                        62.0,
                        44.0,
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
                    "id": "obj-4",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        250.0,
                        118.0,
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
                    "id": "obj-5",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        15,
                        160,
                        44.0,
                        22.0
                    ],
                    "text": "sig~",
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
                        70,
                        160,
                        156.0,
                        20.0
                    ],
                    "text": "pitch -> Hz (signal)",
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
                    "id": "obj-7",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        520,
                        90,
                        142.0,
                        22.0
                    ],
                    "text": "receive tsyn-voice",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-8",
                    "numinlets": 1,
                    "numoutlets": 15,
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
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        520,
                        125,
                        1240.0,
                        22.0
                    ],
                    "text": "route attack decay sustain release cutoff res fenv mix bmul modratio modhz xmod ymod rmod",
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
                        15,
                        200,
                        520,
                        20.0
                    ],
                    "text": "terrain mod osc: f * modratio + modhz -> quadrature pair -> x / y / radius depths",
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
                    "id": "obj-10",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        15,
                        225,
                        51.0,
                        22.0
                    ],
                    "text": "*~ 1.",
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
                        15,
                        260,
                        51.0,
                        22.0
                    ],
                    "text": "+~ 0.",
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
                        15,
                        295,
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
                    "id": "obj-13",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        150,
                        295,
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
                    "id": "obj-14",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        215,
                        260,
                        107.0,
                        22.0
                    ],
                    "text": "loadmess 0.25",
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
                        300,
                        260,
                        58.0,
                        20.0
                    ],
                    "text": "90 deg",
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
                    "id": "obj-16",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        15,
                        335,
                        51.0,
                        22.0
                    ],
                    "text": "*~ 0.",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        150,
                        335,
                        51.0,
                        22.0
                    ],
                    "text": "*~ 0.",
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
                        285,
                        335,
                        51.0,
                        22.0
                    ],
                    "text": "*~ 0.",
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
                        420,
                        335,
                        128.0,
                        22.0
                    ],
                    "text": "receive tsyn-osc",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-20",
                    "numinlets": 5,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        15,
                        385,
                        460.0,
                        22.0
                    ],
                    "text": "terrain-osc",
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
                        490,
                        385,
                        480,
                        20.0
                    ],
                    "text": "slot A: terrain-osc.maxpat (buffer~ terrainbuf) | slot B: terrain-osc-b.maxpat (buffer~ terrainbufB), same x / y / radius mod, own params (tsyn-oscB)",
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
                    "id": "obj-25",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        490.0,
                        495,
                        480,
                        20.0
                    ],
                    "text": "A/B crossfade; mix arrives as a line~ signal (in3)",
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
                    "id": "obj-27",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1000,
                        235,
                        58.0,
                        22.0
                    ],
                    "text": "/ 127.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-28",
                    "numinlets": 5,
                    "numoutlets": 4,
                    "outlettype": [
                        "signal",
                        "signal",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1000,
                        290,
                        200.0,
                        22.0
                    ],
                    "text": "adsr~ 10 200 0.7 400",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        1060,
                        235,
                        247.0,
                        20.0
                    ],
                    "text": "velocity 0-1 triggers, 0 releases",
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
                    "id": "obj-30",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1250,
                        335,
                        93.0,
                        22.0
                    ],
                    "text": "trigger l l",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-31",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1345,
                        370,
                        101.0,
                        22.0
                    ],
                    "text": "route mute",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-32",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1345,
                        405,
                        44.0,
                        22.0
                    ],
                    "text": "== 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-33",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1250,
                        450,
                        137.0,
                        22.0
                    ],
                    "text": "thispoly~",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        1345,
                        450,
                        480,
                        20.0
                    ],
                    "text": "adsr~ mute outlet: busy = !mute first, then mute (DSP off when the release ends)",
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
                    "id": "obj-35",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        520,
                        510,
                        420,
                        20.0
                    ],
                    "text": "cutoff Hz = cutoff + env * fenv, clipped 20-18000",
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
                    "maxclass": "message",
                    "id": "obj-36",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        520,
                        535,
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
                    "id": "obj-37",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        520,
                        570,
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
                    "id": "obj-38",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        600,
                        475,
                        114.0,
                        22.0
                    ],
                    "text": "loadmess 8000.",
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
                        700,
                        570,
                        51.0,
                        22.0
                    ],
                    "text": "*~ 0.",
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
                        "signal"
                    ],
                    "patching_rect": [
                        520,
                        610,
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
                    "id": "obj-41",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        520,
                        645,
                        128.0,
                        22.0
                    ],
                    "text": "clip~ 20. 18000.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-42",
                    "numinlets": 3,
                    "numoutlets": 4,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        15,
                        700,
                        200.0,
                        22.0
                    ],
                    "text": "svf~ 8000. 0.2",
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
                        225,
                        700,
                        114.0,
                        20.0
                    ],
                    "text": "lowpass outlet",
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
                    "id": "obj-44",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        15,
                        750,
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
                    "id": "obj-45",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        15,
                        795,
                        58.0,
                        22.0
                    ],
                    "text": "out~ 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-46",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        960.0,
                        15.0,
                        58.0,
                        20.0
                    ],
                    "text": "v0.6.1",
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
                    "id": "obj-47",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        15,
                        90,
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
                    "id": "obj-48",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        15.0,
                        118.0,
                        80.0,
                        22.0
                    ],
                    "text": "swap",
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
                        620,
                        400,
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
                    "id": "obj-51",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        620,
                        432,
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
                    "maxclass": "message",
                    "id": "obj-52",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        560,
                        258,
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
                    "id": "obj-53",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        560,
                        290,
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
                    "id": "obj-54",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        15,
                        470,
                        460.0,
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
                                    "code": "// A/B crossfade: slot A terrain-osc, slot B terrain-osc-b\n// in1 slot A | in2 slot B | in3 A>B mix 0-1 (line~ signal, clamped)\nk_mix = clamp(in3, 0., 1.);\nout1 = in1 + k_mix * (in2 - in1);\n",
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
                    "id": "obj-55",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        560,
                        225,
                        80.0,
                        22.0
                    ],
                    "text": "loadmess 1.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-56",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        560,
                        322,
                        51.0,
                        22.0
                    ],
                    "text": "*~ 1.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-57",
                    "numinlets": 5,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        60,
                        428,
                        460.0,
                        22.0
                    ],
                    "text": "terrain-osc-b",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-58",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        620,
                        365,
                        135.0,
                        22.0
                    ],
                    "text": "receive tsyn-oscB",
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
                        650,
                        322,
                        380.0,
                        20.0
                    ],
                    "text": "slot B Hz = Hz * bmul (ratio * detune, from main)",
                    "fontname": "Arial",
                    "fontsize": 12.0,
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
                        "obj-4",
                        0
                    ],
                    "destination": [
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        272.0,
                        110.0,
                        103.0,
                        110.0,
                        103.0,
                        148.0,
                        103.0,
                        152.0,
                        234.0,
                        152.0,
                        234.0,
                        188.0,
                        37.0,
                        188.0
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
                        591.0,
                        118.5,
                        1140.0,
                        118.5
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
                    ],
                    "midpoints": [
                        37.0,
                        192.0,
                        7.0,
                        192.0,
                        7.0,
                        228.0,
                        22.0,
                        228.0
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
                        "obj-11",
                        0
                    ],
                    "destination": [
                        "obj-13",
                        0
                    ],
                    "midpoints": [
                        40.5,
                        287.0,
                        91.0,
                        287.0,
                        91.0,
                        325.0,
                        157.0,
                        325.0
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
                        1
                    ],
                    "midpoints": [
                        268.5,
                        288.5,
                        211.0,
                        288.5
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
                        "obj-16",
                        0
                    ],
                    "midpoints": [
                        49.0,
                        326.0,
                        22.0,
                        326.0
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
                        "obj-17",
                        0
                    ],
                    "midpoints": [
                        184.0,
                        326.0,
                        157.0,
                        326.0
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
                        49.0,
                        287.0,
                        142.0,
                        287.0,
                        142.0,
                        325.0,
                        142.0,
                        327.0,
                        74.0,
                        327.0,
                        74.0,
                        365.0,
                        74.0,
                        327.0,
                        142.0,
                        327.0,
                        142.0,
                        365.0,
                        292.0,
                        365.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        9
                    ],
                    "destination": [
                        "obj-10",
                        1
                    ],
                    "midpoints": [
                        1315.142857142857,
                        152.0,
                        67.0,
                        152.0,
                        67.0,
                        190.0,
                        67.0,
                        152.0,
                        234.0,
                        152.0,
                        234.0,
                        188.0,
                        234.0,
                        192.0,
                        543.0,
                        192.0,
                        543.0,
                        228.0,
                        59.0,
                        228.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        10
                    ],
                    "destination": [
                        "obj-11",
                        1
                    ],
                    "midpoints": [
                        1402.7142857142858,
                        152.0,
                        67.0,
                        152.0,
                        67.0,
                        190.0,
                        67.0,
                        152.0,
                        234.0,
                        152.0,
                        234.0,
                        188.0,
                        234.0,
                        192.0,
                        543.0,
                        192.0,
                        543.0,
                        228.0,
                        543.0,
                        217.0,
                        74.0,
                        217.0,
                        74.0,
                        255.0,
                        74.0,
                        227.0,
                        992.0,
                        227.0,
                        992.0,
                        265.0,
                        992.0,
                        227.0,
                        1052.0,
                        227.0,
                        1052.0,
                        263.0,
                        1052.0,
                        252.0,
                        330.0,
                        252.0,
                        330.0,
                        290.0,
                        330.0,
                        252.0,
                        366.0,
                        252.0,
                        366.0,
                        288.0,
                        59.0,
                        288.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        11
                    ],
                    "destination": [
                        "obj-16",
                        1
                    ],
                    "midpoints": [
                        1490.2857142857142,
                        152.0,
                        67.0,
                        152.0,
                        67.0,
                        190.0,
                        67.0,
                        152.0,
                        234.0,
                        152.0,
                        234.0,
                        188.0,
                        234.0,
                        192.0,
                        543.0,
                        192.0,
                        543.0,
                        228.0,
                        543.0,
                        217.0,
                        74.0,
                        217.0,
                        74.0,
                        255.0,
                        74.0,
                        227.0,
                        992.0,
                        227.0,
                        992.0,
                        265.0,
                        992.0,
                        227.0,
                        1052.0,
                        227.0,
                        1052.0,
                        263.0,
                        1052.0,
                        252.0,
                        74.0,
                        252.0,
                        74.0,
                        290.0,
                        74.0,
                        252.0,
                        330.0,
                        252.0,
                        330.0,
                        290.0,
                        330.0,
                        252.0,
                        366.0,
                        252.0,
                        366.0,
                        288.0,
                        366.0,
                        282.0,
                        992.0,
                        282.0,
                        992.0,
                        320.0,
                        992.0,
                        287.0,
                        91.0,
                        287.0,
                        91.0,
                        325.0,
                        91.0,
                        287.0,
                        226.0,
                        287.0,
                        226.0,
                        325.0,
                        226.0,
                        327.0,
                        209.0,
                        327.0,
                        209.0,
                        365.0,
                        209.0,
                        327.0,
                        344.0,
                        327.0,
                        344.0,
                        365.0,
                        344.0,
                        327.0,
                        556.0,
                        327.0,
                        556.0,
                        365.0,
                        556.0,
                        327.0,
                        1242.0,
                        327.0,
                        1242.0,
                        365.0,
                        59.0,
                        365.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        12
                    ],
                    "destination": [
                        "obj-17",
                        1
                    ],
                    "midpoints": [
                        1577.857142857143,
                        152.0,
                        234.0,
                        152.0,
                        234.0,
                        188.0,
                        234.0,
                        192.0,
                        543.0,
                        192.0,
                        543.0,
                        228.0,
                        543.0,
                        227.0,
                        992.0,
                        227.0,
                        992.0,
                        265.0,
                        992.0,
                        227.0,
                        1052.0,
                        227.0,
                        1052.0,
                        263.0,
                        1052.0,
                        252.0,
                        330.0,
                        252.0,
                        330.0,
                        290.0,
                        330.0,
                        252.0,
                        366.0,
                        252.0,
                        366.0,
                        288.0,
                        366.0,
                        282.0,
                        992.0,
                        282.0,
                        992.0,
                        320.0,
                        992.0,
                        287.0,
                        226.0,
                        287.0,
                        226.0,
                        325.0,
                        226.0,
                        327.0,
                        344.0,
                        327.0,
                        344.0,
                        365.0,
                        344.0,
                        327.0,
                        556.0,
                        327.0,
                        556.0,
                        365.0,
                        556.0,
                        327.0,
                        1242.0,
                        327.0,
                        1242.0,
                        365.0,
                        194.0,
                        365.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        13
                    ],
                    "destination": [
                        "obj-18",
                        1
                    ],
                    "midpoints": [
                        1665.4285714285713,
                        192.0,
                        543.0,
                        192.0,
                        543.0,
                        228.0,
                        543.0,
                        227.0,
                        992.0,
                        227.0,
                        992.0,
                        265.0,
                        992.0,
                        227.0,
                        1052.0,
                        227.0,
                        1052.0,
                        263.0,
                        1052.0,
                        252.0,
                        330.0,
                        252.0,
                        330.0,
                        290.0,
                        330.0,
                        252.0,
                        366.0,
                        252.0,
                        366.0,
                        288.0,
                        366.0,
                        282.0,
                        992.0,
                        282.0,
                        992.0,
                        320.0,
                        992.0,
                        327.0,
                        556.0,
                        327.0,
                        556.0,
                        365.0,
                        556.0,
                        327.0,
                        1242.0,
                        327.0,
                        1242.0,
                        365.0,
                        329.0,
                        365.0
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
                        "obj-20",
                        0
                    ],
                    "midpoints": [
                        37.0,
                        192.0,
                        7.0,
                        192.0,
                        7.0,
                        228.0,
                        7.0,
                        217.0,
                        7.0,
                        217.0,
                        7.0,
                        255.0,
                        7.0,
                        252.0,
                        7.0,
                        252.0,
                        7.0,
                        290.0,
                        7.0,
                        287.0,
                        7.0,
                        287.0,
                        7.0,
                        325.0,
                        7.0,
                        327.0,
                        7.0,
                        327.0,
                        7.0,
                        365.0,
                        22.0,
                        365.0
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
                        1
                    ],
                    "midpoints": [
                        40.5,
                        371.0,
                        133.5,
                        371.0
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
                        "obj-20",
                        2
                    ],
                    "midpoints": [
                        175.5,
                        371.0,
                        245.0,
                        371.0
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
                        3
                    ],
                    "midpoints": [
                        310.5,
                        371.0,
                        356.5,
                        371.0
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
                        4
                    ],
                    "midpoints": [
                        484.0,
                        377.0,
                        482.0,
                        377.0,
                        482.0,
                        413.0,
                        468.0,
                        413.0
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
                        0
                    ],
                    "midpoints": [
                        1029.0,
                        273.5,
                        1007.0,
                        273.5
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
                        "obj-28",
                        1
                    ],
                    "midpoints": [
                        527.0,
                        192.0,
                        543.0,
                        192.0,
                        543.0,
                        228.0,
                        543.0,
                        227.0,
                        992.0,
                        227.0,
                        992.0,
                        265.0,
                        992.0,
                        227.0,
                        1052.0,
                        227.0,
                        1052.0,
                        263.0,
                        1053.5,
                        263.0
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
                        "obj-28",
                        2
                    ],
                    "midpoints": [
                        614.5714285714286,
                        227.0,
                        992.0,
                        227.0,
                        992.0,
                        265.0,
                        992.0,
                        227.0,
                        1052.0,
                        227.0,
                        1052.0,
                        263.0,
                        1100.0,
                        263.0
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
                        "obj-28",
                        3
                    ],
                    "midpoints": [
                        702.1428571428571,
                        227.0,
                        992.0,
                        227.0,
                        992.0,
                        265.0,
                        992.0,
                        227.0,
                        1052.0,
                        227.0,
                        1052.0,
                        263.0,
                        1146.5,
                        263.0
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
                        "obj-28",
                        4
                    ],
                    "midpoints": [
                        789.7142857142858,
                        227.0,
                        992.0,
                        227.0,
                        992.0,
                        265.0,
                        992.0,
                        227.0,
                        1052.0,
                        227.0,
                        1052.0,
                        263.0,
                        1193.0,
                        263.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-28",
                        2
                    ],
                    "destination": [
                        "obj-30",
                        0
                    ],
                    "midpoints": [
                        1131.0,
                        323.5,
                        1296.5,
                        323.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-30",
                        1
                    ],
                    "destination": [
                        "obj-31",
                        0
                    ],
                    "midpoints": [
                        1336.0,
                        363.5,
                        1395.5,
                        363.5
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
                        "obj-32",
                        0
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
                    ],
                    "midpoints": [
                        1367.0,
                        442.0,
                        1337.0,
                        442.0,
                        1337.0,
                        478.0,
                        1318.5,
                        478.0
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
                        "obj-33",
                        0
                    ],
                    "midpoints": [
                        1257.0,
                        403.5,
                        1318.5,
                        403.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        4
                    ],
                    "destination": [
                        "obj-36",
                        0
                    ],
                    "midpoints": [
                        877.2857142857142,
                        192.0,
                        543.0,
                        192.0,
                        543.0,
                        228.0,
                        543.0,
                        327.0,
                        556.0,
                        327.0,
                        556.0,
                        365.0,
                        556.0,
                        377.0,
                        482.0,
                        377.0,
                        482.0,
                        413.0,
                        482.0,
                        392.0,
                        679.0,
                        392.0,
                        679.0,
                        430.0,
                        679.0,
                        392.0,
                        732.0,
                        392.0,
                        732.0,
                        430.0,
                        732.0,
                        424.0,
                        679.0,
                        424.0,
                        679.0,
                        462.0,
                        679.0,
                        424.0,
                        732.0,
                        424.0,
                        732.0,
                        462.0,
                        732.0,
                        467.0,
                        722.0,
                        467.0,
                        722.0,
                        505.0,
                        722.0,
                        487.0,
                        482.0,
                        487.0,
                        482.0,
                        523.0,
                        482.0,
                        502.0,
                        512.0,
                        502.0,
                        512.0,
                        538.0,
                        527.0,
                        538.0
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
                        "obj-36",
                        0
                    ],
                    "midpoints": [
                        657.0,
                        487.0,
                        482.0,
                        487.0,
                        482.0,
                        523.0,
                        482.0,
                        502.0,
                        512.0,
                        502.0,
                        512.0,
                        538.0,
                        527.0,
                        538.0
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
                        "obj-37",
                        0
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
                        "obj-39",
                        0
                    ],
                    "midpoints": [
                        1007.0,
                        377.0,
                        978.0,
                        377.0,
                        978.0,
                        413.0,
                        978.0,
                        392.0,
                        799.0,
                        392.0,
                        799.0,
                        430.0,
                        799.0,
                        424.0,
                        799.0,
                        424.0,
                        799.0,
                        462.0,
                        799.0,
                        467.0,
                        722.0,
                        467.0,
                        722.0,
                        505.0,
                        722.0,
                        487.0,
                        978.0,
                        487.0,
                        978.0,
                        523.0,
                        978.0,
                        502.0,
                        948.0,
                        502.0,
                        948.0,
                        538.0,
                        707.0,
                        538.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        6
                    ],
                    "destination": [
                        "obj-39",
                        1
                    ],
                    "midpoints": [
                        1052.4285714285716,
                        227.0,
                        992.0,
                        227.0,
                        992.0,
                        265.0,
                        992.0,
                        227.0,
                        1052.0,
                        227.0,
                        1052.0,
                        263.0,
                        1052.0,
                        282.0,
                        992.0,
                        282.0,
                        992.0,
                        320.0,
                        992.0,
                        377.0,
                        978.0,
                        377.0,
                        978.0,
                        413.0,
                        978.0,
                        392.0,
                        799.0,
                        392.0,
                        799.0,
                        430.0,
                        799.0,
                        424.0,
                        799.0,
                        424.0,
                        799.0,
                        462.0,
                        799.0,
                        487.0,
                        978.0,
                        487.0,
                        978.0,
                        523.0,
                        978.0,
                        502.0,
                        948.0,
                        502.0,
                        948.0,
                        538.0,
                        744.0,
                        538.0
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
                        "obj-40",
                        1
                    ],
                    "midpoints": [
                        725.5,
                        562.0,
                        579.0,
                        562.0,
                        579.0,
                        600.0,
                        560.5,
                        600.0
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
                        "obj-42",
                        1
                    ],
                    "midpoints": [
                        584.0,
                        692.0,
                        347.0,
                        692.0,
                        347.0,
                        728.0,
                        115.0,
                        728.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        5
                    ],
                    "destination": [
                        "obj-42",
                        2
                    ],
                    "midpoints": [
                        964.8571428571429,
                        152.0,
                        234.0,
                        152.0,
                        234.0,
                        188.0,
                        234.0,
                        192.0,
                        543.0,
                        192.0,
                        543.0,
                        228.0,
                        543.0,
                        252.0,
                        330.0,
                        252.0,
                        330.0,
                        290.0,
                        330.0,
                        252.0,
                        366.0,
                        252.0,
                        366.0,
                        288.0,
                        366.0,
                        287.0,
                        226.0,
                        287.0,
                        226.0,
                        325.0,
                        226.0,
                        327.0,
                        209.0,
                        327.0,
                        209.0,
                        365.0,
                        209.0,
                        327.0,
                        344.0,
                        327.0,
                        344.0,
                        365.0,
                        344.0,
                        327.0,
                        556.0,
                        327.0,
                        556.0,
                        365.0,
                        556.0,
                        377.0,
                        483.0,
                        377.0,
                        483.0,
                        415.0,
                        483.0,
                        377.0,
                        482.0,
                        377.0,
                        482.0,
                        413.0,
                        482.0,
                        392.0,
                        612.0,
                        392.0,
                        612.0,
                        430.0,
                        612.0,
                        392.0,
                        732.0,
                        392.0,
                        732.0,
                        430.0,
                        732.0,
                        424.0,
                        612.0,
                        424.0,
                        612.0,
                        462.0,
                        612.0,
                        424.0,
                        732.0,
                        424.0,
                        732.0,
                        462.0,
                        732.0,
                        462.0,
                        483.0,
                        462.0,
                        483.0,
                        500.0,
                        483.0,
                        467.0,
                        592.0,
                        467.0,
                        592.0,
                        505.0,
                        592.0,
                        487.0,
                        482.0,
                        487.0,
                        482.0,
                        523.0,
                        482.0,
                        502.0,
                        512.0,
                        502.0,
                        512.0,
                        538.0,
                        512.0,
                        527.0,
                        579.0,
                        527.0,
                        579.0,
                        565.0,
                        579.0,
                        562.0,
                        579.0,
                        562.0,
                        579.0,
                        600.0,
                        579.0,
                        562.0,
                        692.0,
                        562.0,
                        692.0,
                        600.0,
                        692.0,
                        602.0,
                        575.5,
                        602.0,
                        575.5,
                        640.0,
                        575.5,
                        637.0,
                        656.0,
                        637.0,
                        656.0,
                        675.0,
                        656.0,
                        692.0,
                        347.0,
                        692.0,
                        347.0,
                        728.0,
                        208.0,
                        728.0
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
                        "obj-44",
                        0
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
                        "obj-44",
                        1
                    ],
                    "midpoints": [
                        1007.0,
                        287.0,
                        91.0,
                        287.0,
                        91.0,
                        325.0,
                        91.0,
                        287.0,
                        226.0,
                        287.0,
                        226.0,
                        325.0,
                        226.0,
                        327.0,
                        74.0,
                        327.0,
                        74.0,
                        365.0,
                        74.0,
                        327.0,
                        209.0,
                        327.0,
                        209.0,
                        365.0,
                        209.0,
                        327.0,
                        344.0,
                        327.0,
                        344.0,
                        365.0,
                        344.0,
                        327.0,
                        556.0,
                        327.0,
                        556.0,
                        365.0,
                        556.0,
                        377.0,
                        483.0,
                        377.0,
                        483.0,
                        415.0,
                        483.0,
                        377.0,
                        482.0,
                        377.0,
                        482.0,
                        413.0,
                        482.0,
                        392.0,
                        612.0,
                        392.0,
                        612.0,
                        430.0,
                        612.0,
                        392.0,
                        732.0,
                        392.0,
                        732.0,
                        430.0,
                        732.0,
                        424.0,
                        612.0,
                        424.0,
                        612.0,
                        462.0,
                        612.0,
                        424.0,
                        732.0,
                        424.0,
                        732.0,
                        462.0,
                        732.0,
                        462.0,
                        483.0,
                        462.0,
                        483.0,
                        500.0,
                        483.0,
                        467.0,
                        592.0,
                        467.0,
                        592.0,
                        505.0,
                        592.0,
                        487.0,
                        482.0,
                        487.0,
                        482.0,
                        523.0,
                        482.0,
                        502.0,
                        512.0,
                        502.0,
                        512.0,
                        538.0,
                        512.0,
                        527.0,
                        512.0,
                        527.0,
                        512.0,
                        565.0,
                        512.0,
                        562.0,
                        512.0,
                        562.0,
                        512.0,
                        600.0,
                        512.0,
                        562.0,
                        692.0,
                        562.0,
                        692.0,
                        600.0,
                        692.0,
                        602.0,
                        512.0,
                        602.0,
                        512.0,
                        640.0,
                        512.0,
                        637.0,
                        512.0,
                        637.0,
                        512.0,
                        675.0,
                        512.0,
                        692.0,
                        223.0,
                        692.0,
                        223.0,
                        730.0,
                        223.0,
                        692.0,
                        347.0,
                        692.0,
                        347.0,
                        728.0,
                        50.0,
                        728.0
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
                        "obj-47",
                        0
                    ],
                    "midpoints": [
                        37.0,
                        87.0,
                        73.0,
                        87.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-47",
                        1
                    ],
                    "destination": [
                        "obj-48",
                        1
                    ],
                    "midpoints": [
                        124.0,
                        115.0,
                        88.0,
                        115.0
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
                        "obj-48",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-48",
                        1
                    ],
                    "destination": [
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        88.0,
                        129.0,
                        272.0,
                        129.0
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
                        "obj-27",
                        0
                    ],
                    "midpoints": [
                        22.0,
                        110.0,
                        302.0,
                        110.0,
                        302.0,
                        148.0,
                        302.0,
                        117.0,
                        512.0,
                        117.0,
                        512.0,
                        155.0,
                        512.0,
                        152.0,
                        67.0,
                        152.0,
                        67.0,
                        190.0,
                        67.0,
                        152.0,
                        234.0,
                        152.0,
                        234.0,
                        188.0,
                        234.0,
                        192.0,
                        543.0,
                        192.0,
                        543.0,
                        228.0,
                        543.0,
                        217.0,
                        74.0,
                        217.0,
                        74.0,
                        255.0,
                        1007.0,
                        255.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        7
                    ],
                    "destination": [
                        "obj-50",
                        0
                    ],
                    "midpoints": [
                        1140.0,
                        227.0,
                        992.0,
                        227.0,
                        992.0,
                        265.0,
                        992.0,
                        227.0,
                        1052.0,
                        227.0,
                        1052.0,
                        263.0,
                        1052.0,
                        282.0,
                        992.0,
                        282.0,
                        992.0,
                        320.0,
                        992.0,
                        377.0,
                        978.0,
                        377.0,
                        978.0,
                        413.0,
                        978.0,
                        392.0,
                        799.0,
                        392.0,
                        799.0,
                        430.0,
                        627.0,
                        430.0
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
                        "obj-51",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        8
                    ],
                    "destination": [
                        "obj-52",
                        0
                    ],
                    "midpoints": [
                        1227.5714285714284,
                        227.0,
                        992.0,
                        227.0,
                        992.0,
                        265.0,
                        992.0,
                        227.0,
                        1052.0,
                        227.0,
                        1052.0,
                        263.0,
                        1052.0,
                        282.0,
                        992.0,
                        282.0,
                        992.0,
                        320.0,
                        992.0,
                        377.0,
                        978.0,
                        377.0,
                        978.0,
                        413.0,
                        747.0,
                        413.0
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
                        "obj-53",
                        0
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
                        "obj-52",
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
                        "obj-56",
                        0
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
                        "obj-56",
                        1
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
                        "obj-57",
                        0
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
                        "obj-57",
                        1
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
                        "obj-57",
                        2
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
                        "obj-57",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-58",
                        0
                    ],
                    "destination": [
                        "obj-57",
                        4
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
                        "obj-54",
                        0
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
                        "obj-54",
                        1
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
                        "obj-54",
                        2
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
                        "obj-42",
                        0
                    ]
                }
            }
        ],
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
    }
}