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
                    "text": "terrain-voice  --  poly~ voice: slot A terrain-osc / slot B terrain-osc-b (p motion: LFO + ENV 2 -> orbit) -> mix -> svf~ -> adsr~",
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
                    "numinlets": 6,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        15,
                        430,
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
                        430,
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
                        540,
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
                        450,
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
                        495,
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
                        495,
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
                        555,
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
                        580,
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
                        615,
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
                        520,
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
                        615,
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
                        655,
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
                        690,
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
                        745,
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
                        745,
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
                        795,
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
                        840,
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
                    "text": "v0.10.0",
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
                        445,
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
                        477,
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
                        515,
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
                                    ],
                                    "midpoints": [
                                        145.0,
                                        12.0,
                                        202.0,
                                        12.0,
                                        202.0,
                                        50.0,
                                        250.0,
                                        50.0
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
                                    ],
                                    "midpoints": [
                                        225.0,
                                        61.0,
                                        443.0,
                                        61.0
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
                                    ],
                                    "midpoints": [
                                        250.0,
                                        300.0,
                                        65.0,
                                        300.0
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
                    "numinlets": 6,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        60,
                        473,
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
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-60",
                    "numinlets": 5,
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
                        15,
                        375,
                        505.0,
                        22.0
                    ],
                    "text": "p motion",
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
                            60.0,
                            120.0,
                            1500.0,
                            720.0
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
                                        15,
                                        50,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Terrain-mod x (signal)"
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
                                        125,
                                        50,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Terrain-mod y (signal)"
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
                                        235,
                                        50,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Terrain-mod radius (signal)"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-4",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        400,
                                        50,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Note gate: velocity 0-1 (float), > 0 = on"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-5",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        620,
                                        50,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Voice param messages (unmatched outlet of the voice route)"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-6",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        15,
                                        560,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Slot A x mod"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-7",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        125,
                                        560,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Slot A y mod"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-8",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        235,
                                        560,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Slot A radius mod"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-9",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        345,
                                        560,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Slot A rotate mod"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-10",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        455,
                                        560,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Slot B x mod"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-11",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        565,
                                        560,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Slot B y mod"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-12",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        675,
                                        560,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Slot B radius mod"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-13",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        785,
                                        560,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Slot B rotate mod"
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
                                        15,
                                        15,
                                        1400,
                                        20
                                    ],
                                    "text": "motion  --  per-voice LFO + ENV 2 -> orbit radius / rotate / centre x / y of slot A and slot B (own depth set each). Every control arrives as route -> \"$1 20\" -> line~ (v0.6.1 rule); only the adsr~ times take floats, like the amp envelope.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-15",
                                    "numinlets": 1,
                                    "numoutlets": 7,
                                    "outlettype": [
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        620,
                                        100,
                                        338.0,
                                        22.0
                                    ],
                                    "text": "route lforate lfoshape env2a env2d env2s env2r",
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
                                        620,
                                        170,
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
                                    "id": "obj-17",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        620,
                                        202,
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
                                    "id": "obj-18",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        620,
                                        135,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "loadmess 1.",
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
                                        730,
                                        170,
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
                                    "id": "obj-20",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        730,
                                        202,
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
                                    "maxclass": "comment",
                                    "id": "obj-21",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        675,
                                        204,
                                        60,
                                        20.0
                                    ],
                                    "text": "rate Hz",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        785,
                                        204,
                                        100,
                                        20.0
                                    ],
                                    "text": "shape 0 / 1 / 2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-23",
                                    "numinlets": 5,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        400,
                                        100,
                                        156.0,
                                        22.0
                                    ],
                                    "text": "expr ($f1 > 0.) * 1.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-24",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        400,
                                        135,
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
                                    "id": "obj-25",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        400,
                                        202,
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
                                    "id": "obj-26",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        15,
                                        135,
                                        380,
                                        34
                                    ],
                                    "text": "gate 0 / 1: ENV 2 runs at a fixed full level (not velocity-scaled); rising edge restarts the LFO",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-27",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        620,
                                        250,
                                        240.0,
                                        22.0
                                    ],
                                    "text": "terrain-lfo",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        870,
                                        250,
                                        260,
                                        20.0
                                    ],
                                    "text": "terrain-lfo.maxpat: sine / triangle / S&H",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-29",
                                    "numinlets": 5,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "signal",
                                        "signal",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        1160,
                                        250,
                                        156.0,
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
                                    "id": "obj-30",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        1370,
                                        250,
                                        360,
                                        20.0
                                    ],
                                    "text": "ENV 2 (mute outlet unused: the amp adsr~ owns thispoly~)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-31",
                                    "numinlets": 1,
                                    "numoutlets": 17,
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
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        620,
                                        330,
                                        835.0,
                                        22.0
                                    ],
                                    "text": "route lfoArad lfoArot lfoAx lfoAy lfoBrad lfoBrot lfoBx lfoBy envArad envArot envAx envAy envBrad envBrot envBx envBy",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-32",
                                    "numinlets": 21,
                                    "numoutlets": 8,
                                    "outlettype": [
                                        "signal",
                                        "signal",
                                        "signal",
                                        "signal",
                                        "signal",
                                        "signal",
                                        "signal",
                                        "signal"
                                    ],
                                    "patching_rect": [
                                        15,
                                        470,
                                        2120.0,
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
                                                    "maxclass": "newobj",
                                                    "id": "obj-4",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        290.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 4",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-5",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        370.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 5",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-6",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        450.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 6",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-7",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        530.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 7",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-8",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        610.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 8",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-9",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        690.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 9",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-10",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        770.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 10",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-11",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        850.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 11",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-12",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        930.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 12",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-13",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        1010.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 13",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-14",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        1090.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 14",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-15",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        1170.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 15",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-16",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        1250.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 16",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-17",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        1330.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 17",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-18",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        1410.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 18",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-19",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        1490.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 19",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-20",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        1570.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 20",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-21",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [
                                                        ""
                                                    ],
                                                    "patching_rect": [
                                                        1650.0,
                                                        20.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "in 21",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "codebox",
                                                    "id": "obj-22",
                                                    "numinlets": 21,
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
                                                        50.0,
                                                        80.0,
                                                        400.0,
                                                        200.0
                                                    ],
                                                    "parameter_enable": 0,
                                                    "code": "// terrain-voice motion matrix: LFO + ENV 2 -> orbit radius / rotate / centre x / centre y, own depths per slot\n// in1 LFO -1..1 | in2 ENV 2 0..1 | in3 x mod | in4 y mod | in5 radius mod (audio-rate terrain mod, shared A + B)\n// depths (line~ signals): in6-9 LFO > A radius rotate x y | in10-13 LFO > B | in14-17 ENV 2 > A | in18-21 ENV 2 > B\n// out1-4 slot A x, y, radius, rotate mod | out5-8 slot B. Radius mod multiplies (1 + mod), floored at -1\nout1 = in3 + in1 * in8 + in2 * in16;\nout2 = in4 + in1 * in9 + in2 * in17;\nout3 = max(in5 + in1 * in6 + in2 * in14, -1.);\nout4 = in1 * in7 + in2 * in15;\nout5 = in3 + in1 * in12 + in2 * in20;\nout6 = in4 + in1 * in13 + in2 * in21;\nout7 = max(in5 + in1 * in10 + in2 * in18, -1.);\nout8 = in1 * in11 + in2 * in19;\n",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-23",
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
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-24",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "outlettype": [],
                                                    "patching_rect": [
                                                        130.0,
                                                        320.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "out 2",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-25",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "outlettype": [],
                                                    "patching_rect": [
                                                        210.0,
                                                        320.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "out 3",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-26",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "outlettype": [],
                                                    "patching_rect": [
                                                        290.0,
                                                        320.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "out 4",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-27",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "outlettype": [],
                                                    "patching_rect": [
                                                        370.0,
                                                        320.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "out 5",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-28",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "outlettype": [],
                                                    "patching_rect": [
                                                        450.0,
                                                        320.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "out 6",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-29",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "outlettype": [],
                                                    "patching_rect": [
                                                        530.0,
                                                        320.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "out 7",
                                                    "fontname": "Arial",
                                                    "fontsize": 12.0
                                                }
                                            },
                                            {
                                                "box": {
                                                    "maxclass": "newobj",
                                                    "id": "obj-30",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "outlettype": [],
                                                    "patching_rect": [
                                                        610.0,
                                                        320.0,
                                                        30.0,
                                                        22.0
                                                    ],
                                                    "text": "out 8",
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
                                                        "obj-22",
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
                                                        "obj-22",
                                                        1
                                                    ],
                                                    "midpoints": [
                                                        145.0,
                                                        12.0,
                                                        88.0,
                                                        12.0,
                                                        88.0,
                                                        50.0,
                                                        76.3,
                                                        50.0
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
                                                        "obj-22",
                                                        2
                                                    ],
                                                    "midpoints": [
                                                        225.0,
                                                        12.0,
                                                        168.0,
                                                        12.0,
                                                        168.0,
                                                        50.0,
                                                        95.6,
                                                        50.0
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
                                                        "obj-22",
                                                        3
                                                    ],
                                                    "midpoints": [
                                                        305.0,
                                                        12.0,
                                                        168.0,
                                                        12.0,
                                                        168.0,
                                                        50.0,
                                                        168.0,
                                                        12.0,
                                                        202.0,
                                                        12.0,
                                                        202.0,
                                                        50.0,
                                                        114.9,
                                                        50.0
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
                                                        "obj-22",
                                                        4
                                                    ],
                                                    "midpoints": [
                                                        385.0,
                                                        12.0,
                                                        168.0,
                                                        12.0,
                                                        168.0,
                                                        50.0,
                                                        168.0,
                                                        12.0,
                                                        248.0,
                                                        12.0,
                                                        248.0,
                                                        50.0,
                                                        248.0,
                                                        12.0,
                                                        282.0,
                                                        12.0,
                                                        282.0,
                                                        50.0,
                                                        134.2,
                                                        50.0
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
                                                        "obj-22",
                                                        5
                                                    ],
                                                    "midpoints": [
                                                        465.0,
                                                        12.0,
                                                        168.0,
                                                        12.0,
                                                        168.0,
                                                        50.0,
                                                        168.0,
                                                        12.0,
                                                        248.0,
                                                        12.0,
                                                        248.0,
                                                        50.0,
                                                        248.0,
                                                        12.0,
                                                        328.0,
                                                        12.0,
                                                        328.0,
                                                        50.0,
                                                        328.0,
                                                        12.0,
                                                        362.0,
                                                        12.0,
                                                        362.0,
                                                        50.0,
                                                        153.5,
                                                        50.0
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
                                                        "obj-22",
                                                        6
                                                    ],
                                                    "midpoints": [
                                                        545.0,
                                                        12.0,
                                                        248.0,
                                                        12.0,
                                                        248.0,
                                                        50.0,
                                                        248.0,
                                                        12.0,
                                                        328.0,
                                                        12.0,
                                                        328.0,
                                                        50.0,
                                                        328.0,
                                                        12.0,
                                                        362.0,
                                                        12.0,
                                                        362.0,
                                                        50.0,
                                                        362.0,
                                                        12.0,
                                                        442.0,
                                                        12.0,
                                                        442.0,
                                                        50.0,
                                                        172.8,
                                                        50.0
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
                                                        "obj-22",
                                                        7
                                                    ],
                                                    "midpoints": [
                                                        625.0,
                                                        12.0,
                                                        248.0,
                                                        12.0,
                                                        248.0,
                                                        50.0,
                                                        248.0,
                                                        12.0,
                                                        328.0,
                                                        12.0,
                                                        328.0,
                                                        50.0,
                                                        328.0,
                                                        12.0,
                                                        408.0,
                                                        12.0,
                                                        408.0,
                                                        50.0,
                                                        408.0,
                                                        12.0,
                                                        442.0,
                                                        12.0,
                                                        442.0,
                                                        50.0,
                                                        442.0,
                                                        12.0,
                                                        522.0,
                                                        12.0,
                                                        522.0,
                                                        50.0,
                                                        192.1,
                                                        50.0
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
                                                        "obj-22",
                                                        8
                                                    ],
                                                    "midpoints": [
                                                        705.0,
                                                        12.0,
                                                        248.0,
                                                        12.0,
                                                        248.0,
                                                        50.0,
                                                        248.0,
                                                        12.0,
                                                        328.0,
                                                        12.0,
                                                        328.0,
                                                        50.0,
                                                        328.0,
                                                        12.0,
                                                        408.0,
                                                        12.0,
                                                        408.0,
                                                        50.0,
                                                        408.0,
                                                        12.0,
                                                        442.0,
                                                        12.0,
                                                        442.0,
                                                        50.0,
                                                        442.0,
                                                        12.0,
                                                        522.0,
                                                        12.0,
                                                        522.0,
                                                        50.0,
                                                        522.0,
                                                        12.0,
                                                        602.0,
                                                        12.0,
                                                        602.0,
                                                        50.0,
                                                        211.4,
                                                        50.0
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
                                                        "obj-22",
                                                        9
                                                    ],
                                                    "midpoints": [
                                                        785.0,
                                                        12.0,
                                                        248.0,
                                                        12.0,
                                                        248.0,
                                                        50.0,
                                                        248.0,
                                                        12.0,
                                                        328.0,
                                                        12.0,
                                                        328.0,
                                                        50.0,
                                                        328.0,
                                                        12.0,
                                                        408.0,
                                                        12.0,
                                                        408.0,
                                                        50.0,
                                                        408.0,
                                                        12.0,
                                                        488.0,
                                                        12.0,
                                                        488.0,
                                                        50.0,
                                                        488.0,
                                                        12.0,
                                                        522.0,
                                                        12.0,
                                                        522.0,
                                                        50.0,
                                                        522.0,
                                                        12.0,
                                                        602.0,
                                                        12.0,
                                                        602.0,
                                                        50.0,
                                                        602.0,
                                                        12.0,
                                                        682.0,
                                                        12.0,
                                                        682.0,
                                                        50.0,
                                                        230.70000000000002,
                                                        50.0
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
                                                        "obj-22",
                                                        10
                                                    ],
                                                    "midpoints": [
                                                        865.0,
                                                        12.0,
                                                        328.0,
                                                        12.0,
                                                        328.0,
                                                        50.0,
                                                        328.0,
                                                        12.0,
                                                        408.0,
                                                        12.0,
                                                        408.0,
                                                        50.0,
                                                        408.0,
                                                        12.0,
                                                        488.0,
                                                        12.0,
                                                        488.0,
                                                        50.0,
                                                        488.0,
                                                        12.0,
                                                        568.0,
                                                        12.0,
                                                        568.0,
                                                        50.0,
                                                        568.0,
                                                        12.0,
                                                        602.0,
                                                        12.0,
                                                        602.0,
                                                        50.0,
                                                        602.0,
                                                        12.0,
                                                        682.0,
                                                        12.0,
                                                        682.0,
                                                        50.0,
                                                        682.0,
                                                        12.0,
                                                        762.0,
                                                        12.0,
                                                        762.0,
                                                        50.0,
                                                        250.0,
                                                        50.0
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
                                                        "obj-22",
                                                        11
                                                    ],
                                                    "midpoints": [
                                                        945.0,
                                                        12.0,
                                                        328.0,
                                                        12.0,
                                                        328.0,
                                                        50.0,
                                                        328.0,
                                                        12.0,
                                                        408.0,
                                                        12.0,
                                                        408.0,
                                                        50.0,
                                                        408.0,
                                                        12.0,
                                                        488.0,
                                                        12.0,
                                                        488.0,
                                                        50.0,
                                                        488.0,
                                                        12.0,
                                                        568.0,
                                                        12.0,
                                                        568.0,
                                                        50.0,
                                                        568.0,
                                                        12.0,
                                                        602.0,
                                                        12.0,
                                                        602.0,
                                                        50.0,
                                                        602.0,
                                                        12.0,
                                                        682.0,
                                                        12.0,
                                                        682.0,
                                                        50.0,
                                                        682.0,
                                                        12.0,
                                                        762.0,
                                                        12.0,
                                                        762.0,
                                                        50.0,
                                                        762.0,
                                                        12.0,
                                                        842.0,
                                                        12.0,
                                                        842.0,
                                                        50.0,
                                                        269.3,
                                                        50.0
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
                                                        "obj-22",
                                                        12
                                                    ],
                                                    "midpoints": [
                                                        1025.0,
                                                        12.0,
                                                        328.0,
                                                        12.0,
                                                        328.0,
                                                        50.0,
                                                        328.0,
                                                        12.0,
                                                        408.0,
                                                        12.0,
                                                        408.0,
                                                        50.0,
                                                        408.0,
                                                        12.0,
                                                        488.0,
                                                        12.0,
                                                        488.0,
                                                        50.0,
                                                        488.0,
                                                        12.0,
                                                        568.0,
                                                        12.0,
                                                        568.0,
                                                        50.0,
                                                        568.0,
                                                        12.0,
                                                        648.0,
                                                        12.0,
                                                        648.0,
                                                        50.0,
                                                        648.0,
                                                        12.0,
                                                        682.0,
                                                        12.0,
                                                        682.0,
                                                        50.0,
                                                        682.0,
                                                        12.0,
                                                        762.0,
                                                        12.0,
                                                        762.0,
                                                        50.0,
                                                        762.0,
                                                        12.0,
                                                        842.0,
                                                        12.0,
                                                        842.0,
                                                        50.0,
                                                        842.0,
                                                        12.0,
                                                        922.0,
                                                        12.0,
                                                        922.0,
                                                        50.0,
                                                        288.6,
                                                        50.0
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
                                                        "obj-22",
                                                        13
                                                    ],
                                                    "midpoints": [
                                                        1105.0,
                                                        12.0,
                                                        328.0,
                                                        12.0,
                                                        328.0,
                                                        50.0,
                                                        328.0,
                                                        12.0,
                                                        408.0,
                                                        12.0,
                                                        408.0,
                                                        50.0,
                                                        408.0,
                                                        12.0,
                                                        488.0,
                                                        12.0,
                                                        488.0,
                                                        50.0,
                                                        488.0,
                                                        12.0,
                                                        568.0,
                                                        12.0,
                                                        568.0,
                                                        50.0,
                                                        568.0,
                                                        12.0,
                                                        648.0,
                                                        12.0,
                                                        648.0,
                                                        50.0,
                                                        648.0,
                                                        12.0,
                                                        728.0,
                                                        12.0,
                                                        728.0,
                                                        50.0,
                                                        728.0,
                                                        12.0,
                                                        762.0,
                                                        12.0,
                                                        762.0,
                                                        50.0,
                                                        762.0,
                                                        12.0,
                                                        842.0,
                                                        12.0,
                                                        842.0,
                                                        50.0,
                                                        842.0,
                                                        12.0,
                                                        922.0,
                                                        12.0,
                                                        922.0,
                                                        50.0,
                                                        922.0,
                                                        12.0,
                                                        1002.0,
                                                        12.0,
                                                        1002.0,
                                                        50.0,
                                                        307.9,
                                                        50.0
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
                                                        "obj-22",
                                                        14
                                                    ],
                                                    "midpoints": [
                                                        1185.0,
                                                        12.0,
                                                        328.0,
                                                        12.0,
                                                        328.0,
                                                        50.0,
                                                        328.0,
                                                        12.0,
                                                        408.0,
                                                        12.0,
                                                        408.0,
                                                        50.0,
                                                        408.0,
                                                        12.0,
                                                        488.0,
                                                        12.0,
                                                        488.0,
                                                        50.0,
                                                        488.0,
                                                        12.0,
                                                        568.0,
                                                        12.0,
                                                        568.0,
                                                        50.0,
                                                        568.0,
                                                        12.0,
                                                        648.0,
                                                        12.0,
                                                        648.0,
                                                        50.0,
                                                        648.0,
                                                        12.0,
                                                        728.0,
                                                        12.0,
                                                        728.0,
                                                        50.0,
                                                        728.0,
                                                        12.0,
                                                        762.0,
                                                        12.0,
                                                        762.0,
                                                        50.0,
                                                        762.0,
                                                        12.0,
                                                        842.0,
                                                        12.0,
                                                        842.0,
                                                        50.0,
                                                        842.0,
                                                        12.0,
                                                        922.0,
                                                        12.0,
                                                        922.0,
                                                        50.0,
                                                        922.0,
                                                        12.0,
                                                        1002.0,
                                                        12.0,
                                                        1002.0,
                                                        50.0,
                                                        1002.0,
                                                        12.0,
                                                        1082.0,
                                                        12.0,
                                                        1082.0,
                                                        50.0,
                                                        327.2,
                                                        50.0
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
                                                        "obj-22",
                                                        15
                                                    ],
                                                    "midpoints": [
                                                        1265.0,
                                                        12.0,
                                                        408.0,
                                                        12.0,
                                                        408.0,
                                                        50.0,
                                                        408.0,
                                                        12.0,
                                                        488.0,
                                                        12.0,
                                                        488.0,
                                                        50.0,
                                                        488.0,
                                                        12.0,
                                                        568.0,
                                                        12.0,
                                                        568.0,
                                                        50.0,
                                                        568.0,
                                                        12.0,
                                                        648.0,
                                                        12.0,
                                                        648.0,
                                                        50.0,
                                                        648.0,
                                                        12.0,
                                                        728.0,
                                                        12.0,
                                                        728.0,
                                                        50.0,
                                                        728.0,
                                                        12.0,
                                                        808.0,
                                                        12.0,
                                                        808.0,
                                                        50.0,
                                                        808.0,
                                                        12.0,
                                                        842.0,
                                                        12.0,
                                                        842.0,
                                                        50.0,
                                                        842.0,
                                                        12.0,
                                                        922.0,
                                                        12.0,
                                                        922.0,
                                                        50.0,
                                                        922.0,
                                                        12.0,
                                                        1002.0,
                                                        12.0,
                                                        1002.0,
                                                        50.0,
                                                        1002.0,
                                                        12.0,
                                                        1082.0,
                                                        12.0,
                                                        1082.0,
                                                        50.0,
                                                        1082.0,
                                                        12.0,
                                                        1162.0,
                                                        12.0,
                                                        1162.0,
                                                        50.0,
                                                        346.5,
                                                        50.0
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
                                                        "obj-22",
                                                        16
                                                    ],
                                                    "midpoints": [
                                                        1345.0,
                                                        12.0,
                                                        408.0,
                                                        12.0,
                                                        408.0,
                                                        50.0,
                                                        408.0,
                                                        12.0,
                                                        488.0,
                                                        12.0,
                                                        488.0,
                                                        50.0,
                                                        488.0,
                                                        12.0,
                                                        568.0,
                                                        12.0,
                                                        568.0,
                                                        50.0,
                                                        568.0,
                                                        12.0,
                                                        648.0,
                                                        12.0,
                                                        648.0,
                                                        50.0,
                                                        648.0,
                                                        12.0,
                                                        728.0,
                                                        12.0,
                                                        728.0,
                                                        50.0,
                                                        728.0,
                                                        12.0,
                                                        808.0,
                                                        12.0,
                                                        808.0,
                                                        50.0,
                                                        808.0,
                                                        12.0,
                                                        842.0,
                                                        12.0,
                                                        842.0,
                                                        50.0,
                                                        842.0,
                                                        12.0,
                                                        922.0,
                                                        12.0,
                                                        922.0,
                                                        50.0,
                                                        922.0,
                                                        12.0,
                                                        1002.0,
                                                        12.0,
                                                        1002.0,
                                                        50.0,
                                                        1002.0,
                                                        12.0,
                                                        1082.0,
                                                        12.0,
                                                        1082.0,
                                                        50.0,
                                                        1082.0,
                                                        12.0,
                                                        1162.0,
                                                        12.0,
                                                        1162.0,
                                                        50.0,
                                                        1162.0,
                                                        12.0,
                                                        1242.0,
                                                        12.0,
                                                        1242.0,
                                                        50.0,
                                                        365.8,
                                                        50.0
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
                                                        "obj-22",
                                                        17
                                                    ],
                                                    "midpoints": [
                                                        1425.0,
                                                        12.0,
                                                        408.0,
                                                        12.0,
                                                        408.0,
                                                        50.0,
                                                        408.0,
                                                        12.0,
                                                        488.0,
                                                        12.0,
                                                        488.0,
                                                        50.0,
                                                        488.0,
                                                        12.0,
                                                        568.0,
                                                        12.0,
                                                        568.0,
                                                        50.0,
                                                        568.0,
                                                        12.0,
                                                        648.0,
                                                        12.0,
                                                        648.0,
                                                        50.0,
                                                        648.0,
                                                        12.0,
                                                        728.0,
                                                        12.0,
                                                        728.0,
                                                        50.0,
                                                        728.0,
                                                        12.0,
                                                        808.0,
                                                        12.0,
                                                        808.0,
                                                        50.0,
                                                        808.0,
                                                        12.0,
                                                        888.0,
                                                        12.0,
                                                        888.0,
                                                        50.0,
                                                        888.0,
                                                        12.0,
                                                        922.0,
                                                        12.0,
                                                        922.0,
                                                        50.0,
                                                        922.0,
                                                        12.0,
                                                        1002.0,
                                                        12.0,
                                                        1002.0,
                                                        50.0,
                                                        1002.0,
                                                        12.0,
                                                        1082.0,
                                                        12.0,
                                                        1082.0,
                                                        50.0,
                                                        1082.0,
                                                        12.0,
                                                        1162.0,
                                                        12.0,
                                                        1162.0,
                                                        50.0,
                                                        1162.0,
                                                        12.0,
                                                        1242.0,
                                                        12.0,
                                                        1242.0,
                                                        50.0,
                                                        1242.0,
                                                        12.0,
                                                        1322.0,
                                                        12.0,
                                                        1322.0,
                                                        50.0,
                                                        385.1,
                                                        50.0
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
                                                        "obj-22",
                                                        18
                                                    ],
                                                    "midpoints": [
                                                        1505.0,
                                                        12.0,
                                                        408.0,
                                                        12.0,
                                                        408.0,
                                                        50.0,
                                                        408.0,
                                                        12.0,
                                                        488.0,
                                                        12.0,
                                                        488.0,
                                                        50.0,
                                                        488.0,
                                                        12.0,
                                                        568.0,
                                                        12.0,
                                                        568.0,
                                                        50.0,
                                                        568.0,
                                                        12.0,
                                                        648.0,
                                                        12.0,
                                                        648.0,
                                                        50.0,
                                                        648.0,
                                                        12.0,
                                                        728.0,
                                                        12.0,
                                                        728.0,
                                                        50.0,
                                                        728.0,
                                                        12.0,
                                                        808.0,
                                                        12.0,
                                                        808.0,
                                                        50.0,
                                                        808.0,
                                                        12.0,
                                                        888.0,
                                                        12.0,
                                                        888.0,
                                                        50.0,
                                                        888.0,
                                                        12.0,
                                                        968.0,
                                                        12.0,
                                                        968.0,
                                                        50.0,
                                                        968.0,
                                                        12.0,
                                                        1002.0,
                                                        12.0,
                                                        1002.0,
                                                        50.0,
                                                        1002.0,
                                                        12.0,
                                                        1082.0,
                                                        12.0,
                                                        1082.0,
                                                        50.0,
                                                        1082.0,
                                                        12.0,
                                                        1162.0,
                                                        12.0,
                                                        1162.0,
                                                        50.0,
                                                        1162.0,
                                                        12.0,
                                                        1242.0,
                                                        12.0,
                                                        1242.0,
                                                        50.0,
                                                        1242.0,
                                                        12.0,
                                                        1322.0,
                                                        12.0,
                                                        1322.0,
                                                        50.0,
                                                        1322.0,
                                                        12.0,
                                                        1402.0,
                                                        12.0,
                                                        1402.0,
                                                        50.0,
                                                        404.40000000000003,
                                                        50.0
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
                                                        "obj-22",
                                                        19
                                                    ],
                                                    "midpoints": [
                                                        1585.0,
                                                        12.0,
                                                        488.0,
                                                        12.0,
                                                        488.0,
                                                        50.0,
                                                        488.0,
                                                        12.0,
                                                        568.0,
                                                        12.0,
                                                        568.0,
                                                        50.0,
                                                        568.0,
                                                        12.0,
                                                        648.0,
                                                        12.0,
                                                        648.0,
                                                        50.0,
                                                        648.0,
                                                        12.0,
                                                        728.0,
                                                        12.0,
                                                        728.0,
                                                        50.0,
                                                        728.0,
                                                        12.0,
                                                        808.0,
                                                        12.0,
                                                        808.0,
                                                        50.0,
                                                        808.0,
                                                        12.0,
                                                        888.0,
                                                        12.0,
                                                        888.0,
                                                        50.0,
                                                        888.0,
                                                        12.0,
                                                        968.0,
                                                        12.0,
                                                        968.0,
                                                        50.0,
                                                        968.0,
                                                        12.0,
                                                        1002.0,
                                                        12.0,
                                                        1002.0,
                                                        50.0,
                                                        1002.0,
                                                        12.0,
                                                        1082.0,
                                                        12.0,
                                                        1082.0,
                                                        50.0,
                                                        1082.0,
                                                        12.0,
                                                        1162.0,
                                                        12.0,
                                                        1162.0,
                                                        50.0,
                                                        1162.0,
                                                        12.0,
                                                        1242.0,
                                                        12.0,
                                                        1242.0,
                                                        50.0,
                                                        1242.0,
                                                        12.0,
                                                        1322.0,
                                                        12.0,
                                                        1322.0,
                                                        50.0,
                                                        1322.0,
                                                        12.0,
                                                        1402.0,
                                                        12.0,
                                                        1402.0,
                                                        50.0,
                                                        1402.0,
                                                        12.0,
                                                        1482.0,
                                                        12.0,
                                                        1482.0,
                                                        50.0,
                                                        423.7,
                                                        50.0
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
                                                        "obj-22",
                                                        20
                                                    ],
                                                    "midpoints": [
                                                        1665.0,
                                                        12.0,
                                                        488.0,
                                                        12.0,
                                                        488.0,
                                                        50.0,
                                                        488.0,
                                                        12.0,
                                                        568.0,
                                                        12.0,
                                                        568.0,
                                                        50.0,
                                                        568.0,
                                                        12.0,
                                                        648.0,
                                                        12.0,
                                                        648.0,
                                                        50.0,
                                                        648.0,
                                                        12.0,
                                                        728.0,
                                                        12.0,
                                                        728.0,
                                                        50.0,
                                                        728.0,
                                                        12.0,
                                                        808.0,
                                                        12.0,
                                                        808.0,
                                                        50.0,
                                                        808.0,
                                                        12.0,
                                                        888.0,
                                                        12.0,
                                                        888.0,
                                                        50.0,
                                                        888.0,
                                                        12.0,
                                                        968.0,
                                                        12.0,
                                                        968.0,
                                                        50.0,
                                                        968.0,
                                                        12.0,
                                                        1048.0,
                                                        12.0,
                                                        1048.0,
                                                        50.0,
                                                        1048.0,
                                                        12.0,
                                                        1082.0,
                                                        12.0,
                                                        1082.0,
                                                        50.0,
                                                        1082.0,
                                                        12.0,
                                                        1162.0,
                                                        12.0,
                                                        1162.0,
                                                        50.0,
                                                        1162.0,
                                                        12.0,
                                                        1242.0,
                                                        12.0,
                                                        1242.0,
                                                        50.0,
                                                        1242.0,
                                                        12.0,
                                                        1322.0,
                                                        12.0,
                                                        1322.0,
                                                        50.0,
                                                        1322.0,
                                                        12.0,
                                                        1402.0,
                                                        12.0,
                                                        1402.0,
                                                        50.0,
                                                        1402.0,
                                                        12.0,
                                                        1482.0,
                                                        12.0,
                                                        1482.0,
                                                        50.0,
                                                        1482.0,
                                                        12.0,
                                                        1562.0,
                                                        12.0,
                                                        1562.0,
                                                        50.0,
                                                        443.0,
                                                        50.0
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
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "source": [
                                                        "obj-22",
                                                        1
                                                    ],
                                                    "destination": [
                                                        "obj-24",
                                                        0
                                                    ],
                                                    "midpoints": [
                                                        112.14285714285714,
                                                        300.0,
                                                        145.0,
                                                        300.0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "source": [
                                                        "obj-22",
                                                        2
                                                    ],
                                                    "destination": [
                                                        "obj-25",
                                                        0
                                                    ],
                                                    "midpoints": [
                                                        167.28571428571428,
                                                        312.0,
                                                        168.0,
                                                        312.0,
                                                        168.0,
                                                        350.0,
                                                        225.0,
                                                        350.0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "source": [
                                                        "obj-22",
                                                        3
                                                    ],
                                                    "destination": [
                                                        "obj-26",
                                                        0
                                                    ],
                                                    "midpoints": [
                                                        222.42857142857144,
                                                        312.0,
                                                        248.0,
                                                        312.0,
                                                        248.0,
                                                        350.0,
                                                        305.0,
                                                        350.0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "source": [
                                                        "obj-22",
                                                        4
                                                    ],
                                                    "destination": [
                                                        "obj-27",
                                                        0
                                                    ],
                                                    "midpoints": [
                                                        277.57142857142856,
                                                        312.0,
                                                        328.0,
                                                        312.0,
                                                        328.0,
                                                        350.0,
                                                        385.0,
                                                        350.0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "source": [
                                                        "obj-22",
                                                        5
                                                    ],
                                                    "destination": [
                                                        "obj-28",
                                                        0
                                                    ],
                                                    "midpoints": [
                                                        332.7142857142857,
                                                        312.0,
                                                        408.0,
                                                        312.0,
                                                        408.0,
                                                        350.0,
                                                        465.0,
                                                        350.0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "source": [
                                                        "obj-22",
                                                        6
                                                    ],
                                                    "destination": [
                                                        "obj-29",
                                                        0
                                                    ],
                                                    "midpoints": [
                                                        387.8571428571429,
                                                        312.0,
                                                        408.0,
                                                        312.0,
                                                        408.0,
                                                        350.0,
                                                        408.0,
                                                        312.0,
                                                        488.0,
                                                        312.0,
                                                        488.0,
                                                        350.0,
                                                        545.0,
                                                        350.0
                                                    ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "source": [
                                                        "obj-22",
                                                        7
                                                    ],
                                                    "destination": [
                                                        "obj-30",
                                                        0
                                                    ],
                                                    "midpoints": [
                                                        443.0,
                                                        312.0,
                                                        488.0,
                                                        312.0,
                                                        488.0,
                                                        350.0,
                                                        488.0,
                                                        312.0,
                                                        522.0,
                                                        312.0,
                                                        522.0,
                                                        350.0,
                                                        625.0,
                                                        350.0
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
                                    "maxclass": "comment",
                                    "id": "obj-33",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        15,
                                        330,
                                        590,
                                        20
                                    ],
                                    "text": "16 depths, bipolar: radius +/-1, rotate +/-1 turn, centre x / y +/-0.5 (scaled in the main patch)",
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
                                        620,
                                        370,
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
                                    "id": "obj-35",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        620,
                                        402,
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
                                    "id": "obj-36",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        715,
                                        370,
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
                                        715,
                                        402,
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
                                    "id": "obj-38",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        810,
                                        370,
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
                                    "id": "obj-39",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        810,
                                        402,
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
                                    "id": "obj-40",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        905,
                                        370,
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
                                    "id": "obj-41",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        905,
                                        402,
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
                                    "id": "obj-42",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1000,
                                        370,
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
                                    "id": "obj-43",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        1000,
                                        402,
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
                                    "id": "obj-44",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1095,
                                        370,
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
                                    "id": "obj-45",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        1095,
                                        402,
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
                                    "id": "obj-46",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1190,
                                        370,
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
                                    "id": "obj-47",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        1190,
                                        402,
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
                                    "id": "obj-48",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1285,
                                        370,
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
                                    "id": "obj-49",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        1285,
                                        402,
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
                                    "id": "obj-50",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1380,
                                        370,
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
                                        1380,
                                        402,
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
                                        1475,
                                        370,
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
                                        1475,
                                        402,
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
                                    "id": "obj-54",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1570,
                                        370,
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
                                    "id": "obj-55",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        1570,
                                        402,
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
                                    "id": "obj-56",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1665,
                                        370,
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
                                    "id": "obj-57",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        1665,
                                        402,
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
                                    "id": "obj-58",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1760,
                                        370,
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
                                    "id": "obj-59",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        1760,
                                        402,
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
                                    "id": "obj-60",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1855,
                                        370,
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
                                    "id": "obj-61",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        1855,
                                        402,
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
                                    "id": "obj-62",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        1950,
                                        370,
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
                                    "id": "obj-63",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        1950,
                                        402,
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
                                    "id": "obj-64",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        2045,
                                        370,
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
                                    "id": "obj-65",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        2045,
                                        402,
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
                                    "maxclass": "comment",
                                    "id": "obj-66",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        15,
                                        500,
                                        480,
                                        20.0
                                    ],
                                    "text": "matrix codebox: out = terrain mod + LFO * depth + ENV 2 * depth",
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
                                        "obj-15",
                                        0
                                    ],
                                    "midpoints": [
                                        635.0,
                                        90.0,
                                        789.0,
                                        90.0
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
                                        627.0,
                                        127.0,
                                        612.0,
                                        127.0,
                                        612.0,
                                        165.0,
                                        627.0,
                                        165.0
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
                                        "obj-17",
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
                                        "obj-16",
                                        0
                                    ],
                                    "midpoints": [
                                        666.5,
                                        163.5,
                                        627.0,
                                        163.5
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
                                        "obj-19",
                                        0
                                    ],
                                    "midpoints": [
                                        681.0,
                                        127.0,
                                        721.0,
                                        127.0,
                                        721.0,
                                        165.0,
                                        737.0,
                                        165.0
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
                                        755.5,
                                        196.0,
                                        743.0,
                                        196.0,
                                        743.0,
                                        232.0,
                                        737.0,
                                        232.0
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
                                        "obj-23",
                                        0
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
                                        478.0,
                                        128.5,
                                        446.5,
                                        128.5
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
                                        "obj-17",
                                        0
                                    ],
                                    "destination": [
                                        "obj-27",
                                        0
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
                                        "obj-27",
                                        1
                                    ],
                                    "midpoints": [
                                        737.0,
                                        196.0,
                                        743.0,
                                        196.0,
                                        743.0,
                                        232.0,
                                        740.0,
                                        232.0
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
                                        "obj-27",
                                        2
                                    ],
                                    "midpoints": [
                                        422.0,
                                        194.0,
                                        612.0,
                                        194.0,
                                        612.0,
                                        232.0,
                                        612.0,
                                        194.0,
                                        722.0,
                                        194.0,
                                        722.0,
                                        232.0,
                                        722.0,
                                        196.0,
                                        667.0,
                                        196.0,
                                        667.0,
                                        232.0,
                                        667.0,
                                        196.0,
                                        777.0,
                                        196.0,
                                        777.0,
                                        232.0,
                                        853.0,
                                        232.0
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
                                        "obj-29",
                                        0
                                    ],
                                    "midpoints": [
                                        486.0,
                                        127.0,
                                        721.0,
                                        127.0,
                                        721.0,
                                        165.0,
                                        721.0,
                                        162.0,
                                        679.0,
                                        162.0,
                                        679.0,
                                        200.0,
                                        679.0,
                                        162.0,
                                        789.0,
                                        162.0,
                                        789.0,
                                        200.0,
                                        789.0,
                                        194.0,
                                        679.0,
                                        194.0,
                                        679.0,
                                        232.0,
                                        679.0,
                                        194.0,
                                        789.0,
                                        194.0,
                                        789.0,
                                        232.0,
                                        789.0,
                                        196.0,
                                        743.0,
                                        196.0,
                                        743.0,
                                        232.0,
                                        743.0,
                                        196.0,
                                        777.0,
                                        196.0,
                                        777.0,
                                        232.0,
                                        777.0,
                                        242.0,
                                        868.0,
                                        242.0,
                                        868.0,
                                        280.0,
                                        868.0,
                                        242.0,
                                        862.0,
                                        242.0,
                                        862.0,
                                        278.0,
                                        1167.0,
                                        278.0
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
                                        "obj-29",
                                        1
                                    ],
                                    "midpoints": [
                                        735.0,
                                        162.0,
                                        789.0,
                                        162.0,
                                        789.0,
                                        200.0,
                                        789.0,
                                        194.0,
                                        789.0,
                                        194.0,
                                        789.0,
                                        232.0,
                                        789.0,
                                        196.0,
                                        743.0,
                                        196.0,
                                        743.0,
                                        232.0,
                                        743.0,
                                        196.0,
                                        893.0,
                                        196.0,
                                        893.0,
                                        232.0,
                                        893.0,
                                        242.0,
                                        868.0,
                                        242.0,
                                        868.0,
                                        280.0,
                                        868.0,
                                        242.0,
                                        862.0,
                                        242.0,
                                        862.0,
                                        278.0,
                                        1202.5,
                                        278.0
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
                                        "obj-29",
                                        2
                                    ],
                                    "midpoints": [
                                        789.0,
                                        162.0,
                                        789.0,
                                        162.0,
                                        789.0,
                                        200.0,
                                        789.0,
                                        194.0,
                                        789.0,
                                        194.0,
                                        789.0,
                                        232.0,
                                        789.0,
                                        196.0,
                                        893.0,
                                        196.0,
                                        893.0,
                                        232.0,
                                        893.0,
                                        242.0,
                                        868.0,
                                        242.0,
                                        868.0,
                                        280.0,
                                        868.0,
                                        242.0,
                                        1138.0,
                                        242.0,
                                        1138.0,
                                        278.0,
                                        1238.0,
                                        278.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-15",
                                        4
                                    ],
                                    "destination": [
                                        "obj-29",
                                        3
                                    ],
                                    "midpoints": [
                                        843.0,
                                        196.0,
                                        893.0,
                                        196.0,
                                        893.0,
                                        232.0,
                                        893.0,
                                        242.0,
                                        868.0,
                                        242.0,
                                        868.0,
                                        280.0,
                                        868.0,
                                        242.0,
                                        1138.0,
                                        242.0,
                                        1138.0,
                                        278.0,
                                        1273.5,
                                        278.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-15",
                                        5
                                    ],
                                    "destination": [
                                        "obj-29",
                                        4
                                    ],
                                    "midpoints": [
                                        897.0,
                                        242.0,
                                        1138.0,
                                        242.0,
                                        1138.0,
                                        278.0,
                                        1309.0,
                                        278.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-15",
                                        6
                                    ],
                                    "destination": [
                                        "obj-31",
                                        0
                                    ],
                                    "midpoints": [
                                        951.0,
                                        242.0,
                                        862.0,
                                        242.0,
                                        862.0,
                                        278.0,
                                        1037.5,
                                        278.0
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
                                        "obj-35",
                                        0
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
                                        "obj-32",
                                        5
                                    ],
                                    "midpoints": [
                                        627.0,
                                        447.0,
                                        548.5,
                                        447.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-31",
                                        1
                                    ],
                                    "destination": [
                                        "obj-36",
                                        0
                                    ],
                                    "midpoints": [
                                        678.3125,
                                        362.0,
                                        679.0,
                                        362.0,
                                        679.0,
                                        400.0,
                                        722.0,
                                        400.0
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
                                        "obj-37",
                                        0
                                    ],
                                    "destination": [
                                        "obj-32",
                                        6
                                    ],
                                    "midpoints": [
                                        722.0,
                                        394.0,
                                        679.0,
                                        394.0,
                                        679.0,
                                        432.0,
                                        653.8,
                                        432.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-31",
                                        2
                                    ],
                                    "destination": [
                                        "obj-38",
                                        0
                                    ],
                                    "midpoints": [
                                        729.625,
                                        362.0,
                                        774.0,
                                        362.0,
                                        774.0,
                                        400.0,
                                        817.0,
                                        400.0
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
                                        "obj-32",
                                        7
                                    ],
                                    "midpoints": [
                                        817.0,
                                        394.0,
                                        774.0,
                                        394.0,
                                        774.0,
                                        432.0,
                                        759.1,
                                        432.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-31",
                                        3
                                    ],
                                    "destination": [
                                        "obj-40",
                                        0
                                    ],
                                    "midpoints": [
                                        780.9375,
                                        362.0,
                                        869.0,
                                        362.0,
                                        869.0,
                                        400.0,
                                        912.0,
                                        400.0
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
                                        "obj-32",
                                        8
                                    ],
                                    "midpoints": [
                                        912.0,
                                        394.0,
                                        869.0,
                                        394.0,
                                        869.0,
                                        432.0,
                                        864.4,
                                        432.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-31",
                                        4
                                    ],
                                    "destination": [
                                        "obj-42",
                                        0
                                    ],
                                    "midpoints": [
                                        832.25,
                                        362.0,
                                        869.0,
                                        362.0,
                                        869.0,
                                        400.0,
                                        869.0,
                                        362.0,
                                        897.0,
                                        362.0,
                                        897.0,
                                        400.0,
                                        1007.0,
                                        400.0
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
                                        "obj-32",
                                        9
                                    ],
                                    "midpoints": [
                                        1007.0,
                                        447.0,
                                        969.6999999999999,
                                        447.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-31",
                                        5
                                    ],
                                    "destination": [
                                        "obj-44",
                                        0
                                    ],
                                    "midpoints": [
                                        883.5625,
                                        362.0,
                                        964.0,
                                        362.0,
                                        964.0,
                                        400.0,
                                        964.0,
                                        362.0,
                                        992.0,
                                        362.0,
                                        992.0,
                                        400.0,
                                        1102.0,
                                        400.0
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
                                        "obj-45",
                                        0
                                    ],
                                    "destination": [
                                        "obj-32",
                                        10
                                    ],
                                    "midpoints": [
                                        1102.0,
                                        447.0,
                                        1075.0,
                                        447.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-31",
                                        6
                                    ],
                                    "destination": [
                                        "obj-46",
                                        0
                                    ],
                                    "midpoints": [
                                        934.875,
                                        362.0,
                                        964.0,
                                        362.0,
                                        964.0,
                                        400.0,
                                        964.0,
                                        362.0,
                                        1059.0,
                                        362.0,
                                        1059.0,
                                        400.0,
                                        1059.0,
                                        362.0,
                                        1087.0,
                                        362.0,
                                        1087.0,
                                        400.0,
                                        1197.0,
                                        400.0
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
                                        "obj-47",
                                        0
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
                                        11
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-31",
                                        7
                                    ],
                                    "destination": [
                                        "obj-48",
                                        0
                                    ],
                                    "midpoints": [
                                        986.1875,
                                        362.0,
                                        1059.0,
                                        362.0,
                                        1059.0,
                                        400.0,
                                        1059.0,
                                        362.0,
                                        1154.0,
                                        362.0,
                                        1154.0,
                                        400.0,
                                        1154.0,
                                        362.0,
                                        1182.0,
                                        362.0,
                                        1182.0,
                                        400.0,
                                        1292.0,
                                        400.0
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
                                        "obj-49",
                                        0
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
                                        "obj-32",
                                        12
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-31",
                                        8
                                    ],
                                    "destination": [
                                        "obj-50",
                                        0
                                    ],
                                    "midpoints": [
                                        1037.5,
                                        362.0,
                                        1059.0,
                                        362.0,
                                        1059.0,
                                        400.0,
                                        1059.0,
                                        362.0,
                                        1154.0,
                                        362.0,
                                        1154.0,
                                        400.0,
                                        1154.0,
                                        362.0,
                                        1182.0,
                                        362.0,
                                        1182.0,
                                        400.0,
                                        1182.0,
                                        362.0,
                                        1277.0,
                                        362.0,
                                        1277.0,
                                        400.0,
                                        1387.0,
                                        400.0
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
                                        "obj-51",
                                        0
                                    ],
                                    "destination": [
                                        "obj-32",
                                        13
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-31",
                                        9
                                    ],
                                    "destination": [
                                        "obj-52",
                                        0
                                    ],
                                    "midpoints": [
                                        1088.8125,
                                        362.0,
                                        1154.0,
                                        362.0,
                                        1154.0,
                                        400.0,
                                        1154.0,
                                        362.0,
                                        1249.0,
                                        362.0,
                                        1249.0,
                                        400.0,
                                        1249.0,
                                        362.0,
                                        1277.0,
                                        362.0,
                                        1277.0,
                                        400.0,
                                        1277.0,
                                        362.0,
                                        1372.0,
                                        362.0,
                                        1372.0,
                                        400.0,
                                        1482.0,
                                        400.0
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
                                        "obj-53",
                                        0
                                    ],
                                    "destination": [
                                        "obj-32",
                                        14
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-31",
                                        10
                                    ],
                                    "destination": [
                                        "obj-54",
                                        0
                                    ],
                                    "midpoints": [
                                        1140.125,
                                        362.0,
                                        1154.0,
                                        362.0,
                                        1154.0,
                                        400.0,
                                        1154.0,
                                        362.0,
                                        1249.0,
                                        362.0,
                                        1249.0,
                                        400.0,
                                        1249.0,
                                        362.0,
                                        1344.0,
                                        362.0,
                                        1344.0,
                                        400.0,
                                        1344.0,
                                        362.0,
                                        1372.0,
                                        362.0,
                                        1372.0,
                                        400.0,
                                        1372.0,
                                        362.0,
                                        1467.0,
                                        362.0,
                                        1467.0,
                                        400.0,
                                        1577.0,
                                        400.0
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
                                        "obj-55",
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
                                        "obj-32",
                                        15
                                    ],
                                    "midpoints": [
                                        1577.0,
                                        447.0,
                                        1601.5,
                                        447.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-31",
                                        11
                                    ],
                                    "destination": [
                                        "obj-56",
                                        0
                                    ],
                                    "midpoints": [
                                        1191.4375,
                                        362.0,
                                        1249.0,
                                        362.0,
                                        1249.0,
                                        400.0,
                                        1249.0,
                                        362.0,
                                        1344.0,
                                        362.0,
                                        1344.0,
                                        400.0,
                                        1344.0,
                                        362.0,
                                        1439.0,
                                        362.0,
                                        1439.0,
                                        400.0,
                                        1439.0,
                                        362.0,
                                        1467.0,
                                        362.0,
                                        1467.0,
                                        400.0,
                                        1467.0,
                                        362.0,
                                        1562.0,
                                        362.0,
                                        1562.0,
                                        400.0,
                                        1672.0,
                                        400.0
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
                                        "obj-57",
                                        0
                                    ],
                                    "destination": [
                                        "obj-32",
                                        16
                                    ],
                                    "midpoints": [
                                        1672.0,
                                        447.0,
                                        1706.8,
                                        447.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-31",
                                        12
                                    ],
                                    "destination": [
                                        "obj-58",
                                        0
                                    ],
                                    "midpoints": [
                                        1242.75,
                                        362.0,
                                        1249.0,
                                        362.0,
                                        1249.0,
                                        400.0,
                                        1249.0,
                                        362.0,
                                        1344.0,
                                        362.0,
                                        1344.0,
                                        400.0,
                                        1344.0,
                                        362.0,
                                        1439.0,
                                        362.0,
                                        1439.0,
                                        400.0,
                                        1439.0,
                                        362.0,
                                        1534.0,
                                        362.0,
                                        1534.0,
                                        400.0,
                                        1534.0,
                                        362.0,
                                        1562.0,
                                        362.0,
                                        1562.0,
                                        400.0,
                                        1562.0,
                                        362.0,
                                        1657.0,
                                        362.0,
                                        1657.0,
                                        400.0,
                                        1767.0,
                                        400.0
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
                                        "obj-59",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-59",
                                        0
                                    ],
                                    "destination": [
                                        "obj-32",
                                        17
                                    ],
                                    "midpoints": [
                                        1767.0,
                                        447.0,
                                        1812.1,
                                        447.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-31",
                                        13
                                    ],
                                    "destination": [
                                        "obj-60",
                                        0
                                    ],
                                    "midpoints": [
                                        1294.0625,
                                        362.0,
                                        1344.0,
                                        362.0,
                                        1344.0,
                                        400.0,
                                        1344.0,
                                        362.0,
                                        1439.0,
                                        362.0,
                                        1439.0,
                                        400.0,
                                        1439.0,
                                        362.0,
                                        1534.0,
                                        362.0,
                                        1534.0,
                                        400.0,
                                        1534.0,
                                        362.0,
                                        1562.0,
                                        362.0,
                                        1562.0,
                                        400.0,
                                        1562.0,
                                        362.0,
                                        1657.0,
                                        362.0,
                                        1657.0,
                                        400.0,
                                        1657.0,
                                        362.0,
                                        1752.0,
                                        362.0,
                                        1752.0,
                                        400.0,
                                        1862.0,
                                        400.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-60",
                                        0
                                    ],
                                    "destination": [
                                        "obj-61",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-61",
                                        0
                                    ],
                                    "destination": [
                                        "obj-32",
                                        18
                                    ],
                                    "midpoints": [
                                        1862.0,
                                        447.0,
                                        1917.3999999999999,
                                        447.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-31",
                                        14
                                    ],
                                    "destination": [
                                        "obj-62",
                                        0
                                    ],
                                    "midpoints": [
                                        1345.375,
                                        362.0,
                                        1344.0,
                                        362.0,
                                        1344.0,
                                        400.0,
                                        1344.0,
                                        362.0,
                                        1439.0,
                                        362.0,
                                        1439.0,
                                        400.0,
                                        1439.0,
                                        362.0,
                                        1534.0,
                                        362.0,
                                        1534.0,
                                        400.0,
                                        1534.0,
                                        362.0,
                                        1629.0,
                                        362.0,
                                        1629.0,
                                        400.0,
                                        1629.0,
                                        362.0,
                                        1657.0,
                                        362.0,
                                        1657.0,
                                        400.0,
                                        1657.0,
                                        362.0,
                                        1752.0,
                                        362.0,
                                        1752.0,
                                        400.0,
                                        1752.0,
                                        362.0,
                                        1847.0,
                                        362.0,
                                        1847.0,
                                        400.0,
                                        1957.0,
                                        400.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-62",
                                        0
                                    ],
                                    "destination": [
                                        "obj-63",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-63",
                                        0
                                    ],
                                    "destination": [
                                        "obj-32",
                                        19
                                    ],
                                    "midpoints": [
                                        1957.0,
                                        447.0,
                                        2022.7,
                                        447.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-31",
                                        15
                                    ],
                                    "destination": [
                                        "obj-64",
                                        0
                                    ],
                                    "midpoints": [
                                        1396.6875,
                                        362.0,
                                        1439.0,
                                        362.0,
                                        1439.0,
                                        400.0,
                                        1439.0,
                                        362.0,
                                        1534.0,
                                        362.0,
                                        1534.0,
                                        400.0,
                                        1534.0,
                                        362.0,
                                        1629.0,
                                        362.0,
                                        1629.0,
                                        400.0,
                                        1629.0,
                                        362.0,
                                        1724.0,
                                        362.0,
                                        1724.0,
                                        400.0,
                                        1724.0,
                                        362.0,
                                        1752.0,
                                        362.0,
                                        1752.0,
                                        400.0,
                                        1752.0,
                                        362.0,
                                        1847.0,
                                        362.0,
                                        1847.0,
                                        400.0,
                                        1847.0,
                                        362.0,
                                        1942.0,
                                        362.0,
                                        1942.0,
                                        400.0,
                                        2052.0,
                                        400.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-64",
                                        0
                                    ],
                                    "destination": [
                                        "obj-65",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-65",
                                        0
                                    ],
                                    "destination": [
                                        "obj-32",
                                        20
                                    ],
                                    "midpoints": [
                                        2052.0,
                                        447.0,
                                        2128.0,
                                        447.0
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
                                        "obj-32",
                                        0
                                    ],
                                    "midpoints": [
                                        740.0,
                                        322.0,
                                        612.0,
                                        322.0,
                                        612.0,
                                        360.0,
                                        612.0,
                                        322.0,
                                        613.0,
                                        322.0,
                                        613.0,
                                        358.0,
                                        613.0,
                                        362.0,
                                        612.0,
                                        362.0,
                                        612.0,
                                        400.0,
                                        612.0,
                                        362.0,
                                        707.0,
                                        362.0,
                                        707.0,
                                        400.0,
                                        707.0,
                                        394.0,
                                        612.0,
                                        394.0,
                                        612.0,
                                        432.0,
                                        612.0,
                                        394.0,
                                        707.0,
                                        394.0,
                                        707.0,
                                        432.0,
                                        22.0,
                                        432.0
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
                                        "obj-32",
                                        1
                                    ],
                                    "midpoints": [
                                        1167.0,
                                        242.0,
                                        612.0,
                                        242.0,
                                        612.0,
                                        280.0,
                                        612.0,
                                        242.0,
                                        862.0,
                                        242.0,
                                        862.0,
                                        278.0,
                                        862.0,
                                        322.0,
                                        612.0,
                                        322.0,
                                        612.0,
                                        360.0,
                                        612.0,
                                        322.0,
                                        613.0,
                                        322.0,
                                        613.0,
                                        358.0,
                                        613.0,
                                        362.0,
                                        679.0,
                                        362.0,
                                        679.0,
                                        400.0,
                                        679.0,
                                        362.0,
                                        707.0,
                                        362.0,
                                        707.0,
                                        400.0,
                                        707.0,
                                        362.0,
                                        802.0,
                                        362.0,
                                        802.0,
                                        400.0,
                                        802.0,
                                        362.0,
                                        897.0,
                                        362.0,
                                        897.0,
                                        400.0,
                                        897.0,
                                        362.0,
                                        992.0,
                                        362.0,
                                        992.0,
                                        400.0,
                                        992.0,
                                        362.0,
                                        1087.0,
                                        362.0,
                                        1087.0,
                                        400.0,
                                        1087.0,
                                        394.0,
                                        679.0,
                                        394.0,
                                        679.0,
                                        432.0,
                                        679.0,
                                        394.0,
                                        707.0,
                                        394.0,
                                        707.0,
                                        432.0,
                                        707.0,
                                        394.0,
                                        802.0,
                                        394.0,
                                        802.0,
                                        432.0,
                                        802.0,
                                        394.0,
                                        897.0,
                                        394.0,
                                        897.0,
                                        432.0,
                                        897.0,
                                        394.0,
                                        992.0,
                                        394.0,
                                        992.0,
                                        432.0,
                                        992.0,
                                        394.0,
                                        1087.0,
                                        394.0,
                                        1087.0,
                                        432.0,
                                        127.3,
                                        432.0
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
                                        "obj-32",
                                        2
                                    ],
                                    "midpoints": [
                                        30.0,
                                        42.0,
                                        117.0,
                                        42.0,
                                        117.0,
                                        88.0,
                                        117.0,
                                        42.0,
                                        227.0,
                                        42.0,
                                        227.0,
                                        88.0,
                                        227.0,
                                        127.0,
                                        7.0,
                                        127.0,
                                        7.0,
                                        177.0,
                                        7.0,
                                        322.0,
                                        7.0,
                                        322.0,
                                        7.0,
                                        358.0,
                                        232.6,
                                        358.0
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
                                        "obj-32",
                                        3
                                    ],
                                    "midpoints": [
                                        140.0,
                                        42.0,
                                        227.0,
                                        42.0,
                                        227.0,
                                        88.0,
                                        227.0,
                                        127.0,
                                        403.0,
                                        127.0,
                                        403.0,
                                        177.0,
                                        403.0,
                                        322.0,
                                        7.0,
                                        322.0,
                                        7.0,
                                        358.0,
                                        337.9,
                                        358.0
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
                                        "obj-32",
                                        4
                                    ],
                                    "midpoints": [
                                        250.0,
                                        42.0,
                                        392.0,
                                        42.0,
                                        392.0,
                                        88.0,
                                        392.0,
                                        92.0,
                                        392.0,
                                        92.0,
                                        392.0,
                                        130.0,
                                        392.0,
                                        127.0,
                                        392.0,
                                        127.0,
                                        392.0,
                                        165.0,
                                        392.0,
                                        127.0,
                                        403.0,
                                        127.0,
                                        403.0,
                                        177.0,
                                        403.0,
                                        194.0,
                                        392.0,
                                        194.0,
                                        392.0,
                                        232.0,
                                        392.0,
                                        322.0,
                                        613.0,
                                        322.0,
                                        613.0,
                                        358.0,
                                        443.2,
                                        358.0
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
                                        "obj-6",
                                        0
                                    ],
                                    "midpoints": [
                                        22.0,
                                        492.0,
                                        7.0,
                                        492.0,
                                        7.0,
                                        528.0,
                                        22.0,
                                        528.0
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
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        322.85714285714283,
                                        492.0,
                                        7.0,
                                        492.0,
                                        7.0,
                                        528.0,
                                        7.0,
                                        552.0,
                                        227.0,
                                        552.0,
                                        227.0,
                                        598.0,
                                        132.0,
                                        598.0
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
                                        "obj-8",
                                        0
                                    ],
                                    "midpoints": [
                                        623.7142857142857,
                                        492.0,
                                        503.0,
                                        492.0,
                                        503.0,
                                        528.0,
                                        503.0,
                                        552.0,
                                        383.0,
                                        552.0,
                                        383.0,
                                        598.0,
                                        383.0,
                                        552.0,
                                        447.0,
                                        552.0,
                                        447.0,
                                        598.0,
                                        447.0,
                                        552.0,
                                        557.0,
                                        552.0,
                                        557.0,
                                        598.0,
                                        242.0,
                                        598.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-32",
                                        3
                                    ],
                                    "destination": [
                                        "obj-9",
                                        0
                                    ],
                                    "midpoints": [
                                        924.5714285714284,
                                        492.0,
                                        503.0,
                                        492.0,
                                        503.0,
                                        528.0,
                                        503.0,
                                        552.0,
                                        493.0,
                                        552.0,
                                        493.0,
                                        598.0,
                                        493.0,
                                        552.0,
                                        603.0,
                                        552.0,
                                        603.0,
                                        598.0,
                                        603.0,
                                        552.0,
                                        667.0,
                                        552.0,
                                        667.0,
                                        598.0,
                                        667.0,
                                        552.0,
                                        777.0,
                                        552.0,
                                        777.0,
                                        598.0,
                                        352.0,
                                        598.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-32",
                                        4
                                    ],
                                    "destination": [
                                        "obj-10",
                                        0
                                    ],
                                    "midpoints": [
                                        1225.4285714285713,
                                        492.0,
                                        503.0,
                                        492.0,
                                        503.0,
                                        528.0,
                                        503.0,
                                        552.0,
                                        603.0,
                                        552.0,
                                        603.0,
                                        598.0,
                                        603.0,
                                        552.0,
                                        713.0,
                                        552.0,
                                        713.0,
                                        598.0,
                                        713.0,
                                        552.0,
                                        823.0,
                                        552.0,
                                        823.0,
                                        598.0,
                                        462.0,
                                        598.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-32",
                                        5
                                    ],
                                    "destination": [
                                        "obj-11",
                                        0
                                    ],
                                    "midpoints": [
                                        1526.2857142857142,
                                        552.0,
                                        713.0,
                                        552.0,
                                        713.0,
                                        598.0,
                                        713.0,
                                        552.0,
                                        823.0,
                                        552.0,
                                        823.0,
                                        598.0,
                                        572.0,
                                        598.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-32",
                                        6
                                    ],
                                    "destination": [
                                        "obj-12",
                                        0
                                    ],
                                    "midpoints": [
                                        1827.1428571428569,
                                        552.0,
                                        823.0,
                                        552.0,
                                        823.0,
                                        598.0,
                                        682.0,
                                        598.0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-32",
                                        7
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ],
                                    "midpoints": [
                                        2128.0,
                                        526.0,
                                        792.0,
                                        526.0
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
                    "id": "obj-61",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1000,
                        262,
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
                    "maxclass": "comment",
                    "id": "obj-62",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        535,
                        375,
                        620,
                        20.0
                    ],
                    "text": "p motion: LFO + ENV 2 -> x / y / radius / rotate mod per slot (terrain mod passes through at depth 0)",
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
                        543.0,
                        217.0,
                        648.0,
                        217.0,
                        648.0,
                        255.0,
                        59.0,
                        255.0
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
                        217.0,
                        648.0,
                        217.0,
                        648.0,
                        255.0,
                        648.0,
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
                        250.0,
                        619.0,
                        250.0,
                        619.0,
                        288.0,
                        619.0,
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
                        254.0,
                        992.0,
                        254.0,
                        992.0,
                        292.0,
                        59.0,
                        292.0
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
                        217.0,
                        648.0,
                        217.0,
                        648.0,
                        255.0,
                        648.0,
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
                        250.0,
                        619.0,
                        250.0,
                        619.0,
                        288.0,
                        619.0,
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
                        254.0,
                        992.0,
                        254.0,
                        992.0,
                        292.0,
                        992.0,
                        282.0,
                        992.0,
                        282.0,
                        992.0,
                        320.0,
                        992.0,
                        282.0,
                        619.0,
                        282.0,
                        619.0,
                        320.0,
                        619.0,
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
                        314.0,
                        619.0,
                        314.0,
                        619.0,
                        352.0,
                        619.0,
                        314.0,
                        642.0,
                        314.0,
                        642.0,
                        350.0,
                        642.0,
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
                        217.0,
                        648.0,
                        217.0,
                        648.0,
                        255.0,
                        648.0,
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
                        250.0,
                        619.0,
                        250.0,
                        619.0,
                        288.0,
                        619.0,
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
                        254.0,
                        992.0,
                        254.0,
                        992.0,
                        292.0,
                        992.0,
                        282.0,
                        992.0,
                        282.0,
                        992.0,
                        320.0,
                        992.0,
                        282.0,
                        619.0,
                        282.0,
                        619.0,
                        320.0,
                        619.0,
                        287.0,
                        226.0,
                        287.0,
                        226.0,
                        325.0,
                        226.0,
                        314.0,
                        619.0,
                        314.0,
                        619.0,
                        352.0,
                        619.0,
                        314.0,
                        1038.0,
                        314.0,
                        1038.0,
                        350.0,
                        1038.0,
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
                        217.0,
                        648.0,
                        217.0,
                        648.0,
                        255.0,
                        648.0,
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
                        250.0,
                        619.0,
                        250.0,
                        619.0,
                        288.0,
                        619.0,
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
                        254.0,
                        992.0,
                        254.0,
                        992.0,
                        292.0,
                        992.0,
                        282.0,
                        992.0,
                        282.0,
                        992.0,
                        320.0,
                        992.0,
                        282.0,
                        619.0,
                        282.0,
                        619.0,
                        320.0,
                        619.0,
                        314.0,
                        619.0,
                        314.0,
                        619.0,
                        352.0,
                        619.0,
                        314.0,
                        1038.0,
                        314.0,
                        1038.0,
                        350.0,
                        1038.0,
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
                        7.0,
                        367.0,
                        7.0,
                        367.0,
                        7.0,
                        405.0,
                        22.0,
                        405.0
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
                        367.0,
                        528.0,
                        367.0,
                        528.0,
                        405.0,
                        528.0,
                        422.0,
                        482.0,
                        422.0,
                        482.0,
                        458.0,
                        378.8,
                        458.0
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
                        217.0,
                        648.0,
                        217.0,
                        648.0,
                        255.0,
                        648.0,
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
                        250.0,
                        619.0,
                        250.0,
                        619.0,
                        288.0,
                        619.0,
                        254.0,
                        992.0,
                        254.0,
                        992.0,
                        292.0,
                        992.0,
                        282.0,
                        619.0,
                        282.0,
                        619.0,
                        320.0,
                        1053.5,
                        320.0
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
                        217.0,
                        648.0,
                        217.0,
                        648.0,
                        255.0,
                        648.0,
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
                        250.0,
                        619.0,
                        250.0,
                        619.0,
                        288.0,
                        619.0,
                        254.0,
                        992.0,
                        254.0,
                        992.0,
                        292.0,
                        992.0,
                        282.0,
                        619.0,
                        282.0,
                        619.0,
                        320.0,
                        1100.0,
                        320.0
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
                        1052.0,
                        254.0,
                        992.0,
                        254.0,
                        992.0,
                        292.0,
                        1146.5,
                        292.0
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
                        1052.0,
                        254.0,
                        992.0,
                        254.0,
                        992.0,
                        292.0,
                        1193.0,
                        292.0
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
                        487.0,
                        1337.0,
                        487.0,
                        1337.0,
                        523.0,
                        1318.5,
                        523.0
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
                        426.0,
                        1318.5,
                        426.0
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
                        217.0,
                        648.0,
                        217.0,
                        648.0,
                        255.0,
                        648.0,
                        250.0,
                        619.0,
                        250.0,
                        619.0,
                        288.0,
                        619.0,
                        282.0,
                        619.0,
                        282.0,
                        619.0,
                        320.0,
                        619.0,
                        314.0,
                        619.0,
                        314.0,
                        619.0,
                        352.0,
                        619.0,
                        314.0,
                        642.0,
                        314.0,
                        642.0,
                        350.0,
                        642.0,
                        327.0,
                        556.0,
                        327.0,
                        556.0,
                        365.0,
                        556.0,
                        357.0,
                        763.0,
                        357.0,
                        763.0,
                        395.0,
                        763.0,
                        367.0,
                        528.0,
                        367.0,
                        528.0,
                        405.0,
                        528.0,
                        367.0,
                        527.0,
                        367.0,
                        527.0,
                        403.0,
                        527.0,
                        422.0,
                        482.0,
                        422.0,
                        482.0,
                        458.0,
                        482.0,
                        437.0,
                        679.0,
                        437.0,
                        679.0,
                        475.0,
                        679.0,
                        465.0,
                        528.0,
                        465.0,
                        528.0,
                        503.0,
                        528.0,
                        469.0,
                        679.0,
                        469.0,
                        679.0,
                        507.0,
                        679.0,
                        512.0,
                        722.0,
                        512.0,
                        722.0,
                        550.0,
                        722.0,
                        532.0,
                        482.0,
                        532.0,
                        482.0,
                        568.0,
                        482.0,
                        547.0,
                        512.0,
                        547.0,
                        512.0,
                        583.0,
                        527.0,
                        583.0
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
                        532.0,
                        482.0,
                        532.0,
                        482.0,
                        568.0,
                        482.0,
                        547.0,
                        512.0,
                        547.0,
                        512.0,
                        583.0,
                        527.0,
                        583.0
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
                        314.0,
                        1038.0,
                        314.0,
                        1038.0,
                        350.0,
                        1038.0,
                        357.0,
                        763.0,
                        357.0,
                        763.0,
                        395.0,
                        763.0,
                        367.0,
                        1163.0,
                        367.0,
                        1163.0,
                        403.0,
                        1163.0,
                        422.0,
                        978.0,
                        422.0,
                        978.0,
                        458.0,
                        978.0,
                        512.0,
                        722.0,
                        512.0,
                        722.0,
                        550.0,
                        722.0,
                        532.0,
                        978.0,
                        532.0,
                        978.0,
                        568.0,
                        978.0,
                        547.0,
                        948.0,
                        547.0,
                        948.0,
                        583.0,
                        707.0,
                        583.0
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
                        254.0,
                        992.0,
                        254.0,
                        992.0,
                        292.0,
                        992.0,
                        282.0,
                        992.0,
                        282.0,
                        992.0,
                        320.0,
                        992.0,
                        314.0,
                        1038.0,
                        314.0,
                        1038.0,
                        350.0,
                        1038.0,
                        357.0,
                        763.0,
                        357.0,
                        763.0,
                        395.0,
                        763.0,
                        367.0,
                        1163.0,
                        367.0,
                        1163.0,
                        403.0,
                        1163.0,
                        422.0,
                        978.0,
                        422.0,
                        978.0,
                        458.0,
                        978.0,
                        532.0,
                        978.0,
                        532.0,
                        978.0,
                        568.0,
                        978.0,
                        547.0,
                        948.0,
                        547.0,
                        948.0,
                        583.0,
                        744.0,
                        583.0
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
                        607.0,
                        579.0,
                        607.0,
                        579.0,
                        645.0,
                        560.5,
                        645.0
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
                        737.0,
                        347.0,
                        737.0,
                        347.0,
                        773.0,
                        115.0,
                        773.0
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
                        217.0,
                        552.0,
                        217.0,
                        552.0,
                        255.0,
                        552.0,
                        250.0,
                        619.0,
                        250.0,
                        619.0,
                        288.0,
                        619.0,
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
                        619.0,
                        282.0,
                        619.0,
                        320.0,
                        619.0,
                        287.0,
                        226.0,
                        287.0,
                        226.0,
                        325.0,
                        226.0,
                        314.0,
                        619.0,
                        314.0,
                        619.0,
                        352.0,
                        619.0,
                        314.0,
                        642.0,
                        314.0,
                        642.0,
                        350.0,
                        642.0,
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
                        357.0,
                        612.0,
                        357.0,
                        612.0,
                        395.0,
                        612.0,
                        367.0,
                        528.0,
                        367.0,
                        528.0,
                        405.0,
                        528.0,
                        367.0,
                        527.0,
                        367.0,
                        527.0,
                        403.0,
                        527.0,
                        422.0,
                        483.0,
                        422.0,
                        483.0,
                        460.0,
                        483.0,
                        422.0,
                        482.0,
                        422.0,
                        482.0,
                        458.0,
                        482.0,
                        437.0,
                        612.0,
                        437.0,
                        612.0,
                        475.0,
                        612.0,
                        465.0,
                        528.0,
                        465.0,
                        528.0,
                        503.0,
                        528.0,
                        469.0,
                        612.0,
                        469.0,
                        612.0,
                        507.0,
                        612.0,
                        507.0,
                        483.0,
                        507.0,
                        483.0,
                        545.0,
                        483.0,
                        512.0,
                        592.0,
                        512.0,
                        592.0,
                        550.0,
                        592.0,
                        532.0,
                        482.0,
                        532.0,
                        482.0,
                        568.0,
                        482.0,
                        547.0,
                        512.0,
                        547.0,
                        512.0,
                        583.0,
                        512.0,
                        572.0,
                        579.0,
                        572.0,
                        579.0,
                        610.0,
                        579.0,
                        607.0,
                        579.0,
                        607.0,
                        579.0,
                        645.0,
                        579.0,
                        607.0,
                        692.0,
                        607.0,
                        692.0,
                        645.0,
                        692.0,
                        647.0,
                        575.5,
                        647.0,
                        575.5,
                        685.0,
                        575.5,
                        682.0,
                        656.0,
                        682.0,
                        656.0,
                        720.0,
                        656.0,
                        737.0,
                        347.0,
                        737.0,
                        347.0,
                        773.0,
                        208.0,
                        773.0
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
                        282.0,
                        552.0,
                        282.0,
                        552.0,
                        320.0,
                        552.0,
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
                        314.0,
                        552.0,
                        314.0,
                        552.0,
                        352.0,
                        552.0,
                        314.0,
                        642.0,
                        314.0,
                        642.0,
                        350.0,
                        642.0,
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
                        357.0,
                        612.0,
                        357.0,
                        612.0,
                        395.0,
                        612.0,
                        367.0,
                        528.0,
                        367.0,
                        528.0,
                        405.0,
                        528.0,
                        367.0,
                        527.0,
                        367.0,
                        527.0,
                        403.0,
                        527.0,
                        422.0,
                        483.0,
                        422.0,
                        483.0,
                        460.0,
                        483.0,
                        422.0,
                        482.0,
                        422.0,
                        482.0,
                        458.0,
                        482.0,
                        437.0,
                        612.0,
                        437.0,
                        612.0,
                        475.0,
                        612.0,
                        465.0,
                        528.0,
                        465.0,
                        528.0,
                        503.0,
                        528.0,
                        469.0,
                        612.0,
                        469.0,
                        612.0,
                        507.0,
                        612.0,
                        507.0,
                        483.0,
                        507.0,
                        483.0,
                        545.0,
                        483.0,
                        512.0,
                        592.0,
                        512.0,
                        592.0,
                        550.0,
                        592.0,
                        532.0,
                        482.0,
                        532.0,
                        482.0,
                        568.0,
                        482.0,
                        547.0,
                        512.0,
                        547.0,
                        512.0,
                        583.0,
                        512.0,
                        572.0,
                        512.0,
                        572.0,
                        512.0,
                        610.0,
                        512.0,
                        607.0,
                        512.0,
                        607.0,
                        512.0,
                        645.0,
                        512.0,
                        607.0,
                        692.0,
                        607.0,
                        692.0,
                        645.0,
                        692.0,
                        647.0,
                        512.0,
                        647.0,
                        512.0,
                        685.0,
                        512.0,
                        682.0,
                        512.0,
                        682.0,
                        512.0,
                        720.0,
                        512.0,
                        737.0,
                        223.0,
                        737.0,
                        223.0,
                        775.0,
                        223.0,
                        737.0,
                        347.0,
                        737.0,
                        347.0,
                        773.0,
                        50.0,
                        773.0
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
                        74.0,
                        217.0,
                        552.0,
                        217.0,
                        552.0,
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
                        217.0,
                        648.0,
                        217.0,
                        648.0,
                        255.0,
                        648.0,
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
                        254.0,
                        992.0,
                        254.0,
                        992.0,
                        292.0,
                        992.0,
                        282.0,
                        992.0,
                        282.0,
                        992.0,
                        320.0,
                        992.0,
                        314.0,
                        1038.0,
                        314.0,
                        1038.0,
                        350.0,
                        1038.0,
                        357.0,
                        763.0,
                        357.0,
                        763.0,
                        395.0,
                        763.0,
                        367.0,
                        1163.0,
                        367.0,
                        1163.0,
                        403.0,
                        1163.0,
                        422.0,
                        978.0,
                        422.0,
                        978.0,
                        458.0,
                        627.0,
                        458.0
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
                        217.0,
                        648.0,
                        217.0,
                        648.0,
                        255.0,
                        648.0,
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
                        254.0,
                        992.0,
                        254.0,
                        992.0,
                        292.0,
                        567.0,
                        292.0
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
                    ],
                    "midpoints": [
                        600.0,
                        252.5,
                        567.0,
                        252.5
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
                    ],
                    "midpoints": [
                        37.0,
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
                        217.0,
                        552.0,
                        217.0,
                        552.0,
                        255.0,
                        552.0,
                        250.0,
                        552.0,
                        250.0,
                        552.0,
                        288.0,
                        552.0,
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
                        292.0,
                        252.0,
                        292.0,
                        288.0,
                        292.0,
                        282.0,
                        552.0,
                        282.0,
                        552.0,
                        320.0,
                        552.0,
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
                        567.0,
                        325.0
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
                    ],
                    "midpoints": [
                        567.0,
                        317.0,
                        604.0,
                        317.0
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
                    ],
                    "midpoints": [
                        585.5,
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
                        412.0,
                        327.0,
                        412.0,
                        365.0,
                        412.0,
                        367.0,
                        528.0,
                        367.0,
                        528.0,
                        405.0,
                        528.0,
                        367.0,
                        527.0,
                        367.0,
                        527.0,
                        403.0,
                        527.0,
                        422.0,
                        483.0,
                        422.0,
                        483.0,
                        460.0,
                        483.0,
                        422.0,
                        482.0,
                        422.0,
                        482.0,
                        458.0,
                        67.0,
                        458.0
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
                    ],
                    "midpoints": [
                        687.5,
                        367.0,
                        528.0,
                        367.0,
                        528.0,
                        405.0,
                        528.0,
                        367.0,
                        527.0,
                        367.0,
                        527.0,
                        403.0,
                        527.0,
                        422.0,
                        483.0,
                        422.0,
                        483.0,
                        460.0,
                        483.0,
                        422.0,
                        482.0,
                        422.0,
                        482.0,
                        458.0,
                        482.0,
                        437.0,
                        612.0,
                        437.0,
                        612.0,
                        475.0,
                        612.0,
                        469.0,
                        612.0,
                        469.0,
                        612.0,
                        507.0,
                        423.8,
                        507.0
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
                    ],
                    "midpoints": [
                        67.0,
                        505.0,
                        245.0,
                        505.0
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
                    ],
                    "midpoints": [
                        627.0,
                        465.0,
                        528.0,
                        465.0,
                        528.0,
                        503.0,
                        468.0,
                        503.0
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
                    ],
                    "midpoints": [
                        245.0,
                        737.0,
                        217.0,
                        737.0,
                        217.0,
                        773.0,
                        22.0,
                        773.0
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
                        "obj-60",
                        0
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
                        "obj-60",
                        1
                    ],
                    "midpoints": [
                        175.5,
                        366.0,
                        144.75,
                        366.0
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
                        "obj-60",
                        2
                    ],
                    "midpoints": [
                        310.5,
                        366.0,
                        267.5,
                        366.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-60",
                        0
                    ],
                    "destination": [
                        "obj-20",
                        1
                    ],
                    "midpoints": [
                        22.0,
                        413.5,
                        111.2,
                        413.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-60",
                        1
                    ],
                    "destination": [
                        "obj-20",
                        2
                    ],
                    "midpoints": [
                        92.14285714285714,
                        413.5,
                        200.4,
                        413.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-60",
                        2
                    ],
                    "destination": [
                        "obj-20",
                        3
                    ],
                    "midpoints": [
                        162.28571428571428,
                        413.5,
                        289.6,
                        413.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-60",
                        3
                    ],
                    "destination": [
                        "obj-20",
                        5
                    ],
                    "midpoints": [
                        232.42857142857142,
                        413.5,
                        468.0,
                        413.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-60",
                        4
                    ],
                    "destination": [
                        "obj-57",
                        1
                    ],
                    "midpoints": [
                        302.57142857142856,
                        422.0,
                        7.0,
                        422.0,
                        7.0,
                        460.0,
                        156.2,
                        460.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-60",
                        5
                    ],
                    "destination": [
                        "obj-57",
                        2
                    ],
                    "midpoints": [
                        372.71428571428567,
                        422.0,
                        483.0,
                        422.0,
                        483.0,
                        460.0,
                        245.4,
                        460.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-60",
                        6
                    ],
                    "destination": [
                        "obj-57",
                        3
                    ],
                    "midpoints": [
                        442.85714285714283,
                        422.0,
                        483.0,
                        422.0,
                        483.0,
                        460.0,
                        334.6,
                        460.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-60",
                        7
                    ],
                    "destination": [
                        "obj-57",
                        5
                    ],
                    "midpoints": [
                        513.0,
                        422.0,
                        482.0,
                        422.0,
                        482.0,
                        458.0,
                        513.0,
                        458.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        14
                    ],
                    "destination": [
                        "obj-60",
                        4
                    ],
                    "midpoints": [
                        1753.0,
                        192.0,
                        543.0,
                        192.0,
                        543.0,
                        228.0,
                        543.0,
                        217.0,
                        648.0,
                        217.0,
                        648.0,
                        255.0,
                        648.0,
                        227.0,
                        1066.0,
                        227.0,
                        1066.0,
                        265.0,
                        1066.0,
                        227.0,
                        1052.0,
                        227.0,
                        1052.0,
                        263.0,
                        1052.0,
                        250.0,
                        619.0,
                        250.0,
                        619.0,
                        288.0,
                        619.0,
                        254.0,
                        1101.0,
                        254.0,
                        1101.0,
                        292.0,
                        1101.0,
                        282.0,
                        1208.0,
                        282.0,
                        1208.0,
                        320.0,
                        1208.0,
                        282.0,
                        619.0,
                        282.0,
                        619.0,
                        320.0,
                        619.0,
                        314.0,
                        619.0,
                        314.0,
                        619.0,
                        352.0,
                        619.0,
                        314.0,
                        1038.0,
                        314.0,
                        1038.0,
                        350.0,
                        1038.0,
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
                        1242.0,
                        357.0,
                        763.0,
                        357.0,
                        763.0,
                        395.0,
                        763.0,
                        362.0,
                        1337.0,
                        362.0,
                        1337.0,
                        400.0,
                        1337.0,
                        367.0,
                        1163.0,
                        367.0,
                        1163.0,
                        403.0,
                        513.0,
                        403.0
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
                        "obj-61",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-61",
                        0
                    ],
                    "destination": [
                        "obj-28",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-61",
                        1
                    ],
                    "destination": [
                        "obj-60",
                        3
                    ],
                    "midpoints": [
                        1086.0,
                        250.0,
                        619.0,
                        250.0,
                        619.0,
                        288.0,
                        619.0,
                        282.0,
                        992.0,
                        282.0,
                        992.0,
                        320.0,
                        992.0,
                        282.0,
                        619.0,
                        282.0,
                        619.0,
                        320.0,
                        619.0,
                        314.0,
                        619.0,
                        314.0,
                        619.0,
                        352.0,
                        619.0,
                        314.0,
                        642.0,
                        314.0,
                        642.0,
                        350.0,
                        642.0,
                        327.0,
                        556.0,
                        327.0,
                        556.0,
                        365.0,
                        556.0,
                        357.0,
                        763.0,
                        357.0,
                        763.0,
                        395.0,
                        763.0,
                        367.0,
                        527.0,
                        367.0,
                        527.0,
                        403.0,
                        390.25,
                        403.0
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