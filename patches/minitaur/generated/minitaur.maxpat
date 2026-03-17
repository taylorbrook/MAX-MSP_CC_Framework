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
      50,
      50,
      6148.0,
      435.0
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
    ],
    "boxes": [
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-1",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5385.0,
            30.0,
            240.0,
            20.0
          ],
          "text": "MINITAUR \u2014 Moog Bass Synthesizer",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-2",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            3705.0,
            150.0,
            86.0,
            22.0
          ],
          "text": "p midi-input",
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
              50,
              50,
              1200,
              800
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
                    20,
                    219.0,
                    20.0
                  ],
                  "text": "--- NOTE INPUT & PRIORITY ---",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-2",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    30,
                    50,
                    51.0,
                    22.0
                  ],
                  "text": "notein",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-3",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "",
                    ""
                  ],
                  "patching_rect": [
                    30,
                    90,
                    62.5,
                    22.0
                  ],
                  "text": "stripnote",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-4",
                  "numinlets": 3,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30,
                    120,
                    66.0,
                    22.0
                  ],
                  "text": "clip 0 72",
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
                    30,
                    150,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-note",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-6",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    120,
                    150,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-vel",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-7",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    120,
                    120,
                    32.5,
                    22.0
                  ],
                  "text": "> 0",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-8",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    120,
                    180,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-gate",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-9",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30,
                    180,
                    37.0,
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
                  "id": "obj-10",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    30,
                    210,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-freq",
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
                    250,
                    20,
                    142.0,
                    20.0
                  ],
                  "text": "--- PITCH BEND ---",
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
                    250,
                    50,
                    58.0,
                    22.0
                  ],
                  "text": "bendin",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-13",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    250,
                    80,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 16383 -1. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-14",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    250,
                    110,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-bend",
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
                    250,
                    140,
                    205.0,
                    20.0
                  ],
                  "text": "--- MOD WHEEL (CC 1/33) ---",
                  "fontname": "Arial",
                  "fontsize": 12.0
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
                    250,
                    170,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 1",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-17",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    370,
                    170,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 33",
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
                    250,
                    200,
                    92.0,
                    22.0
                  ],
                  "text": "expr $i1 * 128",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-19",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    310,
                    230,
                    32.5,
                    22.0
                  ],
                  "text": "+",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-20",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    310,
                    260,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 16383 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-21",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    310,
                    290,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-mod-wheel",
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
                    30,
                    260,
                    212.0,
                    20.0
                  ],
                  "text": "--- 14-BIT CC PARAMETERS ---",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-23",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    30,
                    290,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 3",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-24",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    150,
                    290,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 35",
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
                    30,
                    320,
                    92.0,
                    22.0
                  ],
                  "text": "expr $i1 * 128",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-26",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    90,
                    350,
                    32.5,
                    22.0
                  ],
                  "text": "+",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-27",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    90,
                    380,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 16383 0. 1.",
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
                    90,
                    410,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-lfo-rate",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-29",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    210,
                    290,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 7",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-30",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    330,
                    290,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 39",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-31",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    210,
                    320,
                    92.0,
                    22.0
                  ],
                  "text": "expr $i1 * 128",
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
                    270,
                    350,
                    32.5,
                    22.0
                  ],
                  "text": "+",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-33",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    270,
                    380,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 16383 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-34",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    270,
                    410,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-volume",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-35",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    390,
                    290,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 12",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-36",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    510,
                    290,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 44",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-37",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    390,
                    320,
                    92.0,
                    22.0
                  ],
                  "text": "expr $i1 * 128",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-38",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    450,
                    350,
                    32.5,
                    22.0
                  ],
                  "text": "+",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-39",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    450,
                    380,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 16383 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-40",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    450,
                    410,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-lfo-vcf",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-41",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    570,
                    290,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 13",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-42",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    690,
                    290,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 45",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-43",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    570,
                    320,
                    92.0,
                    22.0
                  ],
                  "text": "expr $i1 * 128",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-44",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    630,
                    350,
                    32.5,
                    22.0
                  ],
                  "text": "+",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-45",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    630,
                    380,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 16383 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-46",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    630,
                    410,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-lfo-vco",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-47",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    750,
                    290,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 15",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-48",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    870,
                    290,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 47",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-49",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    750,
                    320,
                    92.0,
                    22.0
                  ],
                  "text": "expr $i1 * 128",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-50",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    810,
                    350,
                    32.5,
                    22.0
                  ],
                  "text": "+",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-51",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    810,
                    380,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 16383 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-52",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    810,
                    410,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-vco1-lvl",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-53",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    930,
                    290,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 16",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-54",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1050,
                    290,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 48",
                  "fontname": "Arial",
                  "fontsize": 12.0
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
                    930,
                    320,
                    92.0,
                    22.0
                  ],
                  "text": "expr $i1 * 128",
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
                    ""
                  ],
                  "patching_rect": [
                    990,
                    350,
                    32.5,
                    22.0
                  ],
                  "text": "+",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-57",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    990,
                    380,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 16383 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-58",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    990,
                    410,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-vco2-lvl",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-59",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    30,
                    450,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 17",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-60",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    150,
                    450,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 49",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-61",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30,
                    480,
                    92.0,
                    22.0
                  ],
                  "text": "expr $i1 * 128",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-62",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    90,
                    510,
                    32.5,
                    22.0
                  ],
                  "text": "+",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-63",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    90,
                    540,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 16383 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-64",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    90,
                    570,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-vco2-freq",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-65",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    210,
                    450,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 19",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-66",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    330,
                    450,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 51",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-67",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    210,
                    480,
                    92.0,
                    22.0
                  ],
                  "text": "expr $i1 * 128",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-68",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    270,
                    510,
                    32.5,
                    22.0
                  ],
                  "text": "+",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-69",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    270,
                    540,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 16383 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-70",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    270,
                    570,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-cutoff",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-71",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    390,
                    450,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 21",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-72",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    510,
                    450,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 53",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-73",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    390,
                    480,
                    92.0,
                    22.0
                  ],
                  "text": "expr $i1 * 128",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-74",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    450,
                    510,
                    32.5,
                    22.0
                  ],
                  "text": "+",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-75",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    450,
                    540,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 16383 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-76",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    450,
                    570,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-resonance",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-77",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    570,
                    450,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 22",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-78",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    690,
                    450,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 50",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-79",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    570,
                    480,
                    92.0,
                    22.0
                  ],
                  "text": "expr $i1 * 128",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-80",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    630,
                    510,
                    32.5,
                    22.0
                  ],
                  "text": "+",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-81",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    630,
                    540,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 16383 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-82",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    630,
                    570,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-filt-eg-amt",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-83",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    750,
                    450,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 23",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-84",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    870,
                    450,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 55",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-85",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    750,
                    480,
                    92.0,
                    22.0
                  ],
                  "text": "expr $i1 * 128",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-86",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    810,
                    510,
                    32.5,
                    22.0
                  ],
                  "text": "+",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-87",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    810,
                    540,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 16383 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-88",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    810,
                    570,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-filt-att",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-89",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    930,
                    450,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 24",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-90",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1050,
                    450,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 56",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-91",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    930,
                    480,
                    92.0,
                    22.0
                  ],
                  "text": "expr $i1 * 128",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-92",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    990,
                    510,
                    32.5,
                    22.0
                  ],
                  "text": "+",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-93",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    990,
                    540,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 16383 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-94",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    990,
                    570,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-filt-dec",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-95",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    30,
                    610,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 25",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-96",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    150,
                    610,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 57",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-97",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30,
                    640,
                    92.0,
                    22.0
                  ],
                  "text": "expr $i1 * 128",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-98",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    90,
                    670,
                    32.5,
                    22.0
                  ],
                  "text": "+",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-99",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    90,
                    700,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 16383 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-100",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    90,
                    730,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-filt-sus",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-101",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    210,
                    610,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 27",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-102",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    330,
                    610,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 59",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-103",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    210,
                    640,
                    92.0,
                    22.0
                  ],
                  "text": "expr $i1 * 128",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-104",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    270,
                    670,
                    32.5,
                    22.0
                  ],
                  "text": "+",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-105",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    270,
                    700,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 16383 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-106",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    270,
                    730,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-ext-lvl",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-107",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    390,
                    610,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 28",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-108",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    510,
                    610,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 60",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-109",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    390,
                    640,
                    92.0,
                    22.0
                  ],
                  "text": "expr $i1 * 128",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-110",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    450,
                    670,
                    32.5,
                    22.0
                  ],
                  "text": "+",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-111",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    450,
                    700,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 16383 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-112",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    450,
                    730,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-amp-att",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-113",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    570,
                    610,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 29",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-114",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    690,
                    610,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 61",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-115",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    570,
                    640,
                    92.0,
                    22.0
                  ],
                  "text": "expr $i1 * 128",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-116",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    630,
                    670,
                    32.5,
                    22.0
                  ],
                  "text": "+",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-117",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    630,
                    700,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 16383 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-118",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    630,
                    730,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-amp-dec",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-119",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    750,
                    610,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 30",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-120",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    870,
                    610,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 62",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-121",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    750,
                    640,
                    92.0,
                    22.0
                  ],
                  "text": "expr $i1 * 128",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-122",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    810,
                    670,
                    32.5,
                    22.0
                  ],
                  "text": "+",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-123",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    810,
                    700,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 16383 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-124",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    810,
                    730,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-amp-sus",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "comment",
                  "id": "obj-125",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    30,
                    600,
                    233.0,
                    20.0
                  ],
                  "text": "--- 7-BIT SWITCHES & PARAMS ---",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-126",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    30,
                    630,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 5",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-127",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30,
                    660,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 127 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-128",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    30,
                    690,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-glide-rate",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-129",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    180,
                    630,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 20",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-130",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    180,
                    660,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 127 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-131",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    180,
                    690,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-kb-track",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-132",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    30,
                    700,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 65",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-133",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30,
                    730,
                    32.5,
                    22.0
                  ],
                  "text": ">= 64",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-134",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    30,
                    760,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-glide-sw",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-135",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    190,
                    700,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 70",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-136",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    190,
                    730,
                    32.5,
                    22.0
                  ],
                  "text": ">= 64",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-137",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    190,
                    760,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-vco1-wave",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-138",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    350,
                    700,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 71",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-139",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    350,
                    730,
                    32.5,
                    22.0
                  ],
                  "text": ">= 64",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-140",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    350,
                    760,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-vco2-wave",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-141",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    510,
                    700,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 72",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-142",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    510,
                    730,
                    32.5,
                    22.0
                  ],
                  "text": ">= 64",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-143",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    510,
                    760,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-release-sw",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-144",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    670,
                    700,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 73",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-145",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    670,
                    730,
                    32.5,
                    22.0
                  ],
                  "text": ">= 64",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-146",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    670,
                    760,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-legato",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-147",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    30,
                    800,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 80",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-148",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30,
                    830,
                    32.5,
                    22.0
                  ],
                  "text": ">= 64",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-149",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    30,
                    860,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-hard-sync",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-150",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    190,
                    800,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 81",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-151",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    190,
                    830,
                    32.5,
                    22.0
                  ],
                  "text": ">= 64",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-152",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    190,
                    860,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-note-sync",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-153",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    350,
                    800,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 82",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-154",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    350,
                    830,
                    32.5,
                    22.0
                  ],
                  "text": ">= 64",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-155",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    350,
                    860,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-lfo-keytrig",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-156",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    510,
                    800,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 112",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-157",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    510,
                    830,
                    32.5,
                    22.0
                  ],
                  "text": ">= 64",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-158",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    510,
                    860,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-lfo-vco2only",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-159",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    330,
                    630,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 85",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-160",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    330,
                    660,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 127 0 5",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-161",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    330,
                    690,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-lfo-wave",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-162",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    480,
                    630,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 92",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-163",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    480,
                    660,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 127 0 2",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-164",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    480,
                    690,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-glide-type",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-165",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    630,
                    630,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 89",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-166",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    630,
                    660,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 127 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-167",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    630,
                    690,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-filt-vel-sens",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-168",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    780,
                    630,
                    59.5,
                    22.0
                  ],
                  "text": "ctlin 90",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-169",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    780,
                    660,
                    111.0,
                    22.0
                  ],
                  "text": "scale 0 127 0. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-170",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    780,
                    690,
                    97.5,
                    22.0
                  ],
                  "text": "send mt-cc-amp-vel-sens",
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
                    1
                  ],
                  "destination": [
                    "obj-3",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-2",
                    0
                  ],
                  "destination": [
                    "obj-3",
                    0
                  ],
                  "order": 0
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
                    0
                  ],
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-3",
                    1
                  ],
                  "destination": [
                    "obj-6",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-3",
                    1
                  ],
                  "destination": [
                    "obj-7",
                    0
                  ],
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-4",
                    0
                  ],
                  "destination": [
                    "obj-9",
                    0
                  ],
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-12",
                    0
                  ],
                  "destination": [
                    "obj-13",
                    0
                  ],
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                    1
                  ],
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-23",
                    0
                  ],
                  "destination": [
                    "obj-25",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-24",
                    0
                  ],
                  "destination": [
                    "obj-26",
                    1
                  ],
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-29",
                    0
                  ],
                  "destination": [
                    "obj-31",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-30",
                    0
                  ],
                  "destination": [
                    "obj-32",
                    1
                  ],
                  "order": 0
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
                  ],
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-33",
                    0
                  ],
                  "destination": [
                    "obj-34",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-35",
                    0
                  ],
                  "destination": [
                    "obj-37",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-36",
                    0
                  ],
                  "destination": [
                    "obj-38",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-37",
                    0
                  ],
                  "destination": [
                    "obj-38",
                    0
                  ],
                  "order": 0
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
                  ],
                  "order": 0
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
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-41",
                    0
                  ],
                  "destination": [
                    "obj-43",
                    0
                  ],
                  "order": 0
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
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-43",
                    0
                  ],
                  "destination": [
                    "obj-44",
                    0
                  ],
                  "order": 0
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
                  "order": 0
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
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-47",
                    0
                  ],
                  "destination": [
                    "obj-49",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-48",
                    0
                  ],
                  "destination": [
                    "obj-50",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-49",
                    0
                  ],
                  "destination": [
                    "obj-50",
                    0
                  ],
                  "order": 0
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
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-51",
                    0
                  ],
                  "destination": [
                    "obj-52",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-53",
                    0
                  ],
                  "destination": [
                    "obj-55",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-54",
                    0
                  ],
                  "destination": [
                    "obj-56",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-55",
                    0
                  ],
                  "destination": [
                    "obj-56",
                    0
                  ],
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-57",
                    0
                  ],
                  "destination": [
                    "obj-58",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-59",
                    0
                  ],
                  "destination": [
                    "obj-61",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-60",
                    0
                  ],
                  "destination": [
                    "obj-62",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-61",
                    0
                  ],
                  "destination": [
                    "obj-62",
                    0
                  ],
                  "order": 0
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
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-63",
                    0
                  ],
                  "destination": [
                    "obj-64",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-65",
                    0
                  ],
                  "destination": [
                    "obj-67",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-66",
                    0
                  ],
                  "destination": [
                    "obj-68",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-67",
                    0
                  ],
                  "destination": [
                    "obj-68",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-68",
                    0
                  ],
                  "destination": [
                    "obj-69",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-69",
                    0
                  ],
                  "destination": [
                    "obj-70",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-71",
                    0
                  ],
                  "destination": [
                    "obj-73",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-72",
                    0
                  ],
                  "destination": [
                    "obj-74",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-73",
                    0
                  ],
                  "destination": [
                    "obj-74",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-74",
                    0
                  ],
                  "destination": [
                    "obj-75",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-75",
                    0
                  ],
                  "destination": [
                    "obj-76",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-77",
                    0
                  ],
                  "destination": [
                    "obj-79",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-78",
                    0
                  ],
                  "destination": [
                    "obj-80",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-79",
                    0
                  ],
                  "destination": [
                    "obj-80",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-80",
                    0
                  ],
                  "destination": [
                    "obj-81",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-81",
                    0
                  ],
                  "destination": [
                    "obj-82",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-83",
                    0
                  ],
                  "destination": [
                    "obj-85",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-84",
                    0
                  ],
                  "destination": [
                    "obj-86",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-85",
                    0
                  ],
                  "destination": [
                    "obj-86",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-86",
                    0
                  ],
                  "destination": [
                    "obj-87",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-87",
                    0
                  ],
                  "destination": [
                    "obj-88",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-89",
                    0
                  ],
                  "destination": [
                    "obj-91",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-90",
                    0
                  ],
                  "destination": [
                    "obj-92",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-91",
                    0
                  ],
                  "destination": [
                    "obj-92",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-92",
                    0
                  ],
                  "destination": [
                    "obj-93",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-93",
                    0
                  ],
                  "destination": [
                    "obj-94",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-95",
                    0
                  ],
                  "destination": [
                    "obj-97",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-96",
                    0
                  ],
                  "destination": [
                    "obj-98",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-97",
                    0
                  ],
                  "destination": [
                    "obj-98",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-98",
                    0
                  ],
                  "destination": [
                    "obj-99",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-99",
                    0
                  ],
                  "destination": [
                    "obj-100",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-101",
                    0
                  ],
                  "destination": [
                    "obj-103",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-102",
                    0
                  ],
                  "destination": [
                    "obj-104",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-103",
                    0
                  ],
                  "destination": [
                    "obj-104",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-104",
                    0
                  ],
                  "destination": [
                    "obj-105",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-105",
                    0
                  ],
                  "destination": [
                    "obj-106",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-107",
                    0
                  ],
                  "destination": [
                    "obj-109",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-108",
                    0
                  ],
                  "destination": [
                    "obj-110",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-109",
                    0
                  ],
                  "destination": [
                    "obj-110",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-110",
                    0
                  ],
                  "destination": [
                    "obj-111",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-111",
                    0
                  ],
                  "destination": [
                    "obj-112",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-113",
                    0
                  ],
                  "destination": [
                    "obj-115",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-114",
                    0
                  ],
                  "destination": [
                    "obj-116",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-115",
                    0
                  ],
                  "destination": [
                    "obj-116",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-116",
                    0
                  ],
                  "destination": [
                    "obj-117",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-117",
                    0
                  ],
                  "destination": [
                    "obj-118",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-119",
                    0
                  ],
                  "destination": [
                    "obj-121",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-120",
                    0
                  ],
                  "destination": [
                    "obj-122",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-121",
                    0
                  ],
                  "destination": [
                    "obj-122",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-122",
                    0
                  ],
                  "destination": [
                    "obj-123",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-123",
                    0
                  ],
                  "destination": [
                    "obj-124",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-126",
                    0
                  ],
                  "destination": [
                    "obj-127",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-127",
                    0
                  ],
                  "destination": [
                    "obj-128",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-129",
                    0
                  ],
                  "destination": [
                    "obj-130",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-130",
                    0
                  ],
                  "destination": [
                    "obj-131",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-132",
                    0
                  ],
                  "destination": [
                    "obj-133",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-133",
                    0
                  ],
                  "destination": [
                    "obj-134",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-135",
                    0
                  ],
                  "destination": [
                    "obj-136",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-136",
                    0
                  ],
                  "destination": [
                    "obj-137",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-138",
                    0
                  ],
                  "destination": [
                    "obj-139",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-139",
                    0
                  ],
                  "destination": [
                    "obj-140",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-141",
                    0
                  ],
                  "destination": [
                    "obj-142",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-142",
                    0
                  ],
                  "destination": [
                    "obj-143",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-144",
                    0
                  ],
                  "destination": [
                    "obj-145",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-145",
                    0
                  ],
                  "destination": [
                    "obj-146",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-147",
                    0
                  ],
                  "destination": [
                    "obj-148",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-148",
                    0
                  ],
                  "destination": [
                    "obj-149",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-150",
                    0
                  ],
                  "destination": [
                    "obj-151",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-151",
                    0
                  ],
                  "destination": [
                    "obj-152",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-153",
                    0
                  ],
                  "destination": [
                    "obj-154",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-154",
                    0
                  ],
                  "destination": [
                    "obj-155",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-156",
                    0
                  ],
                  "destination": [
                    "obj-157",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-157",
                    0
                  ],
                  "destination": [
                    "obj-158",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-159",
                    0
                  ],
                  "destination": [
                    "obj-160",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-160",
                    0
                  ],
                  "destination": [
                    "obj-161",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-162",
                    0
                  ],
                  "destination": [
                    "obj-163",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-163",
                    0
                  ],
                  "destination": [
                    "obj-164",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-165",
                    0
                  ],
                  "destination": [
                    "obj-166",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-166",
                    0
                  ],
                  "destination": [
                    "obj-167",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-168",
                    0
                  ],
                  "destination": [
                    "obj-169",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-169",
                    0
                  ],
                  "destination": [
                    "obj-170",
                    0
                  ],
                  "order": 0
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
          "id": "obj-3",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            3855.0,
            150.0,
            86.0,
            22.0
          ],
          "text": "p oscillators",
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
              50,
              50,
              900,
              600
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
                    20,
                    163.0,
                    20.0
                  ],
                  "text": "--- VCO 1 & VCO 2 ---",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-2",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    30,
                    50,
                    94.0,
                    22.0
                  ],
                  "text": "receive~ mt-glide-freq-sig",
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
                    200,
                    50,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-fine-tune",
                  "fontname": "Arial",
                  "fontsize": 12.0
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
                    200,
                    75,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-5",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    200,
                    100,
                    39.0,
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
                  "id": "obj-6",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    200,
                    130,
                    42.0,
                    22.0
                  ],
                  "text": "*~ 2.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-7",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    200,
                    155,
                    45.0,
                    22.0
                  ],
                  "text": "-~ 1.",
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
                    "signal"
                  ],
                  "patching_rect": [
                    200,
                    180,
                    50.5,
                    22.0
                  ],
                  "text": "/~ 12.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-9",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    200,
                    210,
                    121.0,
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
                          "maxclass": "codebox",
                          "id": "obj-2",
                          "numinlets": 1,
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
                          "code": "\n// Convert semitones offset to frequency ratio\n// out1 = 2^(in1/12)\nout1 = pow(2, in1 / 12.0);\n",
                          "fontname": "Arial",
                          "fontsize": 12.0
                        }
                      },
                      {
                        "box": {
                          "maxclass": "newobj",
                          "id": "obj-3",
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
                            "obj-2",
                            0
                          ],
                          "order": 0
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-2",
                            0
                          ],
                          "destination": [
                            "obj-3",
                            0
                          ],
                          "order": 0
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
                  "id": "obj-10",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    130,
                    250,
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
                  "id": "obj-11",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    400,
                    50,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-vco2-freq",
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
                    400,
                    75,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
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
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    400,
                    100,
                    39.0,
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
                  "id": "obj-14",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    400,
                    130,
                    42.0,
                    22.0
                  ],
                  "text": "*~ 24.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-15",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    400,
                    155,
                    45.0,
                    22.0
                  ],
                  "text": "-~ 12.",
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
                    "signal"
                  ],
                  "patching_rect": [
                    400,
                    185,
                    121.0,
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
                          "maxclass": "codebox",
                          "id": "obj-2",
                          "numinlets": 1,
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
                          "code": "\n// Convert semitones offset to frequency ratio\n// out1 = 2^(in1/12)\nout1 = pow(2, in1 / 12.0);\n",
                          "fontname": "Arial",
                          "fontsize": 12.0
                        }
                      },
                      {
                        "box": {
                          "maxclass": "newobj",
                          "id": "obj-3",
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
                            "obj-2",
                            0
                          ],
                          "order": 0
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-2",
                            0
                          ],
                          "destination": [
                            "obj-3",
                            0
                          ],
                          "order": 0
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
                  "id": "obj-17",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    400,
                    250,
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
                  "maxclass": "comment",
                  "id": "obj-18",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    30,
                    280,
                    107.0,
                    20.0
                  ],
                  "text": "--- VCO 1 ---",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-19",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    30,
                    310,
                    65.0,
                    22.0
                  ],
                  "text": "saw~",
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
                    130,
                    310,
                    62.5,
                    22.0
                  ],
                  "text": "rect~",
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
                    30,
                    340,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-vco1-wave",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-22",
                  "numinlets": 3,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    80,
                    370,
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
                  "id": "obj-23",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30,
                    370,
                    32.5,
                    22.0
                  ],
                  "text": "+ 1",
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
                    80,
                    410,
                    88.0,
                    22.0
                  ],
                  "text": "send~ mt-vco1",
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
                    400,
                    280,
                    107.0,
                    20.0
                  ],
                  "text": "--- VCO 2 ---",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-26",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    400,
                    310,
                    65.0,
                    22.0
                  ],
                  "text": "saw~",
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
                    500,
                    310,
                    62.5,
                    22.0
                  ],
                  "text": "rect~",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-28",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    400,
                    340,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-vco2-wave",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-29",
                  "numinlets": 3,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    450,
                    370,
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
                  "id": "obj-30",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    400,
                    370,
                    32.5,
                    22.0
                  ],
                  "text": "+ 1",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-31",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    450,
                    410,
                    88.0,
                    22.0
                  ],
                  "text": "send~ mt-vco2",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "source": [
                    "obj-3",
                    0
                  ],
                  "destination": [
                    "obj-4",
                    0
                  ],
                  "order": 0
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
                  "order": 0
                }
              },
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
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-2",
                    0
                  ],
                  "destination": [
                    "obj-10",
                    0
                  ],
                  "order": 0
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
                    1
                  ],
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-12",
                    0
                  ],
                  "destination": [
                    "obj-13",
                    0
                  ],
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-10",
                    0
                  ],
                  "destination": [
                    "obj-17",
                    0
                  ],
                  "order": 0
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
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-10",
                    0
                  ],
                  "destination": [
                    "obj-19",
                    0
                  ],
                  "order": 0
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
                    0
                  ],
                  "order": 0
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
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-23",
                    0
                  ],
                  "destination": [
                    "obj-22",
                    0
                  ],
                  "order": 0
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
                    1
                  ],
                  "order": 0
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
                    2
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-22",
                    0
                  ],
                  "destination": [
                    "obj-24",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-17",
                    0
                  ],
                  "destination": [
                    "obj-26",
                    0
                  ],
                  "order": 0
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
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-28",
                    0
                  ],
                  "destination": [
                    "obj-30",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-30",
                    0
                  ],
                  "destination": [
                    "obj-29",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-26",
                    0
                  ],
                  "destination": [
                    "obj-29",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-27",
                    0
                  ],
                  "destination": [
                    "obj-29",
                    2
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-29",
                    0
                  ],
                  "destination": [
                    "obj-31",
                    0
                  ],
                  "order": 0
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
          "id": "obj-4",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            3990.0,
            150.0,
            86.0,
            22.0
          ],
          "text": "p mixer",
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
              50,
              50,
              600,
              400
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
                    20,
                    107.0,
                    20.0
                  ],
                  "text": "--- MIXER ---",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-2",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    30,
                    50,
                    94.0,
                    22.0
                  ],
                  "text": "receive~ mt-vco1",
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
                    30,
                    80,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-vco1-lvl",
                  "fontname": "Arial",
                  "fontsize": 12.0
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
                    30,
                    105,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-5",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    30,
                    130,
                    39.0,
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
                  "id": "obj-6",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    30,
                    160,
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
                  "id": "obj-7",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    200,
                    50,
                    94.0,
                    22.0
                  ],
                  "text": "receive~ mt-vco2",
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
                    200,
                    80,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-vco2-lvl",
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
                    200,
                    105,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
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
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    200,
                    130,
                    39.0,
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
                  "id": "obj-11",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    200,
                    160,
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
                  "id": "obj-12",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "signal",
                    "signal",
                    "signal"
                  ],
                  "patching_rect": [
                    370,
                    50,
                    64.0,
                    22.0
                  ],
                  "text": "adc~ 1",
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
                    370,
                    80,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-ext-lvl",
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
                    370,
                    105,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-15",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    370,
                    130,
                    39.0,
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
                  "id": "obj-16",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    370,
                    160,
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
                  "id": "obj-17",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    120,
                    200,
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
                  "id": "obj-18",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    200,
                    240,
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
                  "id": "obj-19",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    200,
                    270,
                    44.0,
                    22.0
                  ],
                  "text": "tanh~",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-20",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    200,
                    300,
                    88.0,
                    22.0
                  ],
                  "text": "send~ mt-mix-out",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "source": [
                    "obj-3",
                    0
                  ],
                  "destination": [
                    "obj-4",
                    0
                  ],
                  "order": 0
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
                  "order": 0
                }
              },
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-5",
                    0
                  ],
                  "destination": [
                    "obj-6",
                    1
                  ],
                  "order": 0
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
                    0
                  ],
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-6",
                    0
                  ],
                  "destination": [
                    "obj-17",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-11",
                    0
                  ],
                  "destination": [
                    "obj-17",
                    1
                  ],
                  "order": 0
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
                  "order": 0
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
                    1
                  ],
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
          "id": "obj-5",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            4125.0,
            150.0,
            86.0,
            22.0
          ],
          "text": "p glide",
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
              50,
              50,
              500,
              350
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
                    20,
                    198.0,
                    20.0
                  ],
                  "text": "--- GLIDE / PORTAMENTO ---",
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
                    30,
                    50,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-freq",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "message",
                  "id": "obj-3",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30,
                    80,
                    44.0,
                    22.0
                  ],
                  "text": "$1 1",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-4",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    30,
                    105,
                    39.0,
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
                  "id": "obj-5",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    150,
                    50,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-glide-rate",
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
                    150,
                    75,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-7",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    150,
                    100,
                    39.0,
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
                  "id": "obj-8",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    250,
                    50,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-glide-type",
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
                    250,
                    75,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
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
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    250,
                    100,
                    39.0,
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
                  "id": "obj-11",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    350,
                    50,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-glide-sw",
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
                    350,
                    75,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
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
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    350,
                    100,
                    39.0,
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
                  "id": "obj-14",
                  "numinlets": 4,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    100,
                    180,
                    121.0,
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
                          "maxclass": "codebox",
                          "id": "obj-5",
                          "numinlets": 4,
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
                          "code": "\n// Glide/Portamento with 3 types\n// in 1: target freq Hz, in 2: rate 0-1\n// in 3: type 0-2, in 4: enable\n\nHistory current_freq(0);\n\ntarget = in1;\nrate = in2;\nglide_type = in3;\nenable = in4;\n\nglide_ms = 1.0 + rate * 1999.0;\ncoeff = 1.0 / (glide_ms * 0.001 * samplerate);\n\ndiff = target - current_freq;\nsel = round(clamp(glide_type, 0, 2));\n\n// Linear constant rate\nhz_step = max(abs(diff) * coeff, 0.01);\nlin_rate = current_freq + clamp(diff, -hz_step, hz_step);\n\n// Linear constant time\nlin_time = current_freq + diff * coeff;\n\n// Exponential\nexpo = current_freq + diff * coeff * 4;\n\nglided = (sel == 0) ? lin_rate : (sel == 1) ? lin_time : expo;\n\ncurrent_freq = (enable < 0.5) ? target : glided;\n\nout1 = current_freq;\n",
                          "fontname": "Arial",
                          "fontsize": 12.0
                        }
                      },
                      {
                        "box": {
                          "maxclass": "newobj",
                          "id": "obj-6",
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
                            "obj-5",
                            0
                          ],
                          "order": 0
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-2",
                            0
                          ],
                          "destination": [
                            "obj-5",
                            1
                          ],
                          "order": 0
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-3",
                            0
                          ],
                          "destination": [
                            "obj-5",
                            2
                          ],
                          "order": 0
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
                            3
                          ],
                          "order": 0
                        }
                      },
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
                          "order": 0
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
                  "id": "obj-15",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    100,
                    240,
                    88.0,
                    22.0
                  ],
                  "text": "send~ mt-glide-freq-sig",
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
                    "obj-3",
                    0
                  ],
                  "order": 0
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
                    0
                  ],
                  "order": 0
                }
              },
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
                  "order": 0
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
                  "order": 0
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
                    0
                  ],
                  "order": 0
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
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-12",
                    0
                  ],
                  "destination": [
                    "obj-13",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-4",
                    0
                  ],
                  "destination": [
                    "obj-14",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-7",
                    0
                  ],
                  "destination": [
                    "obj-14",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-10",
                    0
                  ],
                  "destination": [
                    "obj-14",
                    2
                  ],
                  "order": 0
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
                    3
                  ],
                  "order": 0
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
                  "order": 0
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
          "id": "obj-6",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            4275.0,
            150.0,
            86.0,
            22.0
          ],
          "text": "p envelopes",
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
              50,
              50,
              800,
              500
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
                    20,
                    177.0,
                    20.0
                  ],
                  "text": "--- FILTER ENVELOPE ---",
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
                    30,
                    50,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-gate",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "message",
                  "id": "obj-3",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30,
                    80,
                    44.0,
                    22.0
                  ],
                  "text": "$1 1",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-4",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    30,
                    105,
                    39.0,
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
                  "id": "obj-5",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30,
                    140,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-filt-att",
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
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-7",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    30,
                    190,
                    39.0,
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
                  "id": "obj-8",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    30,
                    220,
                    42.0,
                    22.0
                  ],
                  "text": "*~ 29999.",
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
                    30,
                    245,
                    47.5,
                    22.0
                  ],
                  "text": "+~ 1.",
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
                    150,
                    140,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-filt-dec",
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
                    150,
                    165,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
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
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    150,
                    190,
                    39.0,
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
                  "id": "obj-13",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    150,
                    220,
                    42.0,
                    22.0
                  ],
                  "text": "*~ 29999.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-14",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    150,
                    245,
                    47.5,
                    22.0
                  ],
                  "text": "+~ 1.",
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
                    270,
                    140,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-filt-sus",
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
                    270,
                    165,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
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
                    270,
                    190,
                    39.0,
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
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    390,
                    140,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-release-sw",
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
                    390,
                    165,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
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
                    390,
                    190,
                    39.0,
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
                  "id": "obj-21",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    500,
                    140,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-legato",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "message",
                  "id": "obj-22",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    500,
                    165,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-23",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    500,
                    190,
                    39.0,
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
                  "id": "obj-24",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    150,
                    290,
                    121.0,
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
                          "maxclass": "codebox",
                          "id": "obj-7",
                          "numinlets": 6,
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
                          "code": "\n// ADSR Envelope with shared Decay/Release\n// in 1: gate, in 2: attack ms, in 3: decay ms\n// in 4: sustain 0-1, in 5: release enable, in 6: retrigger mode\n\nHistory env(0);\nHistory stage(0);\nHistory prev_gate(0);\n\ngate = in1;\natt_ms = max(in2, 1);\ndec_ms = max(in3, 1);\nsus_level = clamp(in4, 0, 1);\nrel_enable = in5;\nretrig_mode = in6;\n\ngate_on = (gate > 0.5) * (prev_gate <= 0.5);\ngate_off = (gate <= 0.5) * (prev_gate > 0.5);\nprev_gate = gate;\n\n// Note on: reset env if not legato, go to attack\nenv = (gate_on * (retrig_mode < 0.5)) ? 0 : env;\nstage = gate_on ? 1 : stage;\n\n// Note off: release or instant off\nstage = (gate_off * (rel_enable > 0.5)) ? 4 : (gate_off * (rel_enable <= 0.5)) ? 0 : stage;\nenv = (gate_off * (rel_enable <= 0.5)) ? 0 : env;\n\natt_coeff = 1.0 / (att_ms * 0.001 * samplerate);\ndec_coeff = 1.0 / (dec_ms * 0.001 * samplerate);\ndec_smooth = 1.0 / (dec_ms * 0.001 * samplerate + 1);\n\n// Attack\natt_env = env + att_coeff;\natt_done = att_env >= 1.0;\natt_env = att_done ? 1.0 : att_env;\n\n// Decay\ndec_env = env - (env - sus_level) * dec_smooth;\ndec_done = dec_env <= sus_level + 0.001;\ndec_env = dec_done ? sus_level : dec_env;\n\n// Release\nrel_env = env * (1.0 - dec_coeff);\nrel_done = rel_env < 0.001;\nrel_env = rel_done ? 0 : rel_env;\n\n// Select stage output\nenv = (stage == 1) ? att_env : (stage == 2) ? dec_env : (stage == 3) ? sus_level : (stage == 4) ? rel_env : 0;\n\n// Advance stage\nstage = ((stage == 1) * att_done) ? 2 : ((stage == 2) * dec_done) ? 3 : ((stage == 4) * rel_done) ? 0 : stage;\n\nout1 = env;\n",
                          "fontname": "Arial",
                          "fontsize": 12.0
                        }
                      },
                      {
                        "box": {
                          "maxclass": "newobj",
                          "id": "obj-8",
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
                            "obj-7",
                            0
                          ],
                          "order": 0
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-2",
                            0
                          ],
                          "destination": [
                            "obj-7",
                            1
                          ],
                          "order": 0
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
                            2
                          ],
                          "order": 0
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-4",
                            0
                          ],
                          "destination": [
                            "obj-7",
                            3
                          ],
                          "order": 0
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-5",
                            0
                          ],
                          "destination": [
                            "obj-7",
                            4
                          ],
                          "order": 0
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
                            5
                          ],
                          "order": 0
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
                          "order": 0
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
                  "id": "obj-25",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    150,
                    340,
                    88.0,
                    22.0
                  ],
                  "text": "send~ mt-filt-eg-sig",
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
                    30,
                    370,
                    156.0,
                    20.0
                  ],
                  "text": "--- AMP ENVELOPE ---",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-27",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30,
                    400,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-amp-att",
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
                    30,
                    425,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-29",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    30,
                    450,
                    39.0,
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
                  "id": "obj-30",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    30,
                    480,
                    42.0,
                    22.0
                  ],
                  "text": "*~ 29999.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-31",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    30,
                    505,
                    47.5,
                    22.0
                  ],
                  "text": "+~ 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-32",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    150,
                    400,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-amp-dec",
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
                    150,
                    425,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-34",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    150,
                    450,
                    39.0,
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
                  "id": "obj-35",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    150,
                    480,
                    42.0,
                    22.0
                  ],
                  "text": "*~ 29999.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-36",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    150,
                    505,
                    47.5,
                    22.0
                  ],
                  "text": "+~ 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-37",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    270,
                    400,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-amp-sus",
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
                    270,
                    425,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
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
                    270,
                    450,
                    39.0,
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
                  "id": "obj-40",
                  "numinlets": 6,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    150,
                    540,
                    121.0,
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
                          "maxclass": "codebox",
                          "id": "obj-7",
                          "numinlets": 6,
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
                          "code": "\n// ADSR Envelope with shared Decay/Release\n// in 1: gate, in 2: attack ms, in 3: decay ms\n// in 4: sustain 0-1, in 5: release enable, in 6: retrigger mode\n\nHistory env(0);\nHistory stage(0);\nHistory prev_gate(0);\n\ngate = in1;\natt_ms = max(in2, 1);\ndec_ms = max(in3, 1);\nsus_level = clamp(in4, 0, 1);\nrel_enable = in5;\nretrig_mode = in6;\n\ngate_on = (gate > 0.5) * (prev_gate <= 0.5);\ngate_off = (gate <= 0.5) * (prev_gate > 0.5);\nprev_gate = gate;\n\n// Note on: reset env if not legato, go to attack\nenv = (gate_on * (retrig_mode < 0.5)) ? 0 : env;\nstage = gate_on ? 1 : stage;\n\n// Note off: release or instant off\nstage = (gate_off * (rel_enable > 0.5)) ? 4 : (gate_off * (rel_enable <= 0.5)) ? 0 : stage;\nenv = (gate_off * (rel_enable <= 0.5)) ? 0 : env;\n\natt_coeff = 1.0 / (att_ms * 0.001 * samplerate);\ndec_coeff = 1.0 / (dec_ms * 0.001 * samplerate);\ndec_smooth = 1.0 / (dec_ms * 0.001 * samplerate + 1);\n\n// Attack\natt_env = env + att_coeff;\natt_done = att_env >= 1.0;\natt_env = att_done ? 1.0 : att_env;\n\n// Decay\ndec_env = env - (env - sus_level) * dec_smooth;\ndec_done = dec_env <= sus_level + 0.001;\ndec_env = dec_done ? sus_level : dec_env;\n\n// Release\nrel_env = env * (1.0 - dec_coeff);\nrel_done = rel_env < 0.001;\nrel_env = rel_done ? 0 : rel_env;\n\n// Select stage output\nenv = (stage == 1) ? att_env : (stage == 2) ? dec_env : (stage == 3) ? sus_level : (stage == 4) ? rel_env : 0;\n\n// Advance stage\nstage = ((stage == 1) * att_done) ? 2 : ((stage == 2) * dec_done) ? 3 : ((stage == 4) * rel_done) ? 0 : stage;\n\nout1 = env;\n",
                          "fontname": "Arial",
                          "fontsize": 12.0
                        }
                      },
                      {
                        "box": {
                          "maxclass": "newobj",
                          "id": "obj-8",
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
                            "obj-7",
                            0
                          ],
                          "order": 0
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-2",
                            0
                          ],
                          "destination": [
                            "obj-7",
                            1
                          ],
                          "order": 0
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
                            2
                          ],
                          "order": 0
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-4",
                            0
                          ],
                          "destination": [
                            "obj-7",
                            3
                          ],
                          "order": 0
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-5",
                            0
                          ],
                          "destination": [
                            "obj-7",
                            4
                          ],
                          "order": 0
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
                            5
                          ],
                          "order": 0
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
                          "order": 0
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
                  "id": "obj-41",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    150,
                    590,
                    88.0,
                    22.0
                  ],
                  "text": "send~ mt-amp-eg-sig",
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
                    "obj-3",
                    0
                  ],
                  "order": 0
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
                    0
                  ],
                  "order": 0
                }
              },
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
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                    0
                  ],
                  "order": 0
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
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-12",
                    0
                  ],
                  "destination": [
                    "obj-13",
                    0
                  ],
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                  ],
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                    0
                  ],
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-4",
                    0
                  ],
                  "destination": [
                    "obj-24",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-9",
                    0
                  ],
                  "destination": [
                    "obj-24",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-14",
                    0
                  ],
                  "destination": [
                    "obj-24",
                    2
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-17",
                    0
                  ],
                  "destination": [
                    "obj-24",
                    3
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-20",
                    0
                  ],
                  "destination": [
                    "obj-24",
                    4
                  ],
                  "order": 0
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
                    5
                  ],
                  "order": 0
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
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-28",
                    0
                  ],
                  "destination": [
                    "obj-29",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-29",
                    0
                  ],
                  "destination": [
                    "obj-30",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-30",
                    0
                  ],
                  "destination": [
                    "obj-31",
                    0
                  ],
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-33",
                    0
                  ],
                  "destination": [
                    "obj-34",
                    0
                  ],
                  "order": 0
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
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-35",
                    0
                  ],
                  "destination": [
                    "obj-36",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-37",
                    0
                  ],
                  "destination": [
                    "obj-38",
                    0
                  ],
                  "order": 0
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
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-4",
                    0
                  ],
                  "destination": [
                    "obj-40",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-31",
                    0
                  ],
                  "destination": [
                    "obj-40",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-36",
                    0
                  ],
                  "destination": [
                    "obj-40",
                    2
                  ],
                  "order": 0
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
                    3
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-20",
                    0
                  ],
                  "destination": [
                    "obj-40",
                    4
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-23",
                    0
                  ],
                  "destination": [
                    "obj-40",
                    5
                  ],
                  "order": 0
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
                  "order": 0
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
          "id": "obj-7",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            4410.0,
            150.0,
            86.0,
            22.0
          ],
          "text": "p lfo",
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
              50,
              50,
              700,
              500
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
                    20,
                    93.0,
                    20.0
                  ],
                  "text": "--- LFO ---",
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
                    30,
                    50,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-lfo-rate",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "message",
                  "id": "obj-3",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30,
                    75,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-4",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    30,
                    100,
                    39.0,
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
                  "id": "obj-5",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    30,
                    130,
                    42.0,
                    22.0
                  ],
                  "text": "*~ 4.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-6",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    30,
                    160,
                    121.0,
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
                          "maxclass": "codebox",
                          "id": "obj-2",
                          "numinlets": 1,
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
                          "code": "\n// Map 0-1 to 0.01-100 Hz (exponential)\nout1 = 0.01 * pow(10000, clamp(in1, 0, 1));\n",
                          "fontname": "Arial",
                          "fontsize": 12.0
                        }
                      },
                      {
                        "box": {
                          "maxclass": "newobj",
                          "id": "obj-3",
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
                            "obj-2",
                            0
                          ],
                          "order": 0
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-2",
                            0
                          ],
                          "destination": [
                            "obj-3",
                            0
                          ],
                          "order": 0
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
                  "id": "obj-7",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    200,
                    50,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-lfo-wave",
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
                    200,
                    75,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-9",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    200,
                    100,
                    39.0,
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
                  "id": "obj-10",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    350,
                    50,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-lfo-keytrig",
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
                    350,
                    75,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
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
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    350,
                    100,
                    39.0,
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
                  "id": "obj-13",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    350,
                    130,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-gate",
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
                    350,
                    155,
                    44.0,
                    22.0
                  ],
                  "text": "$1 0",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-15",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    350,
                    180,
                    39.0,
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
                  "id": "obj-16",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    350,
                    210,
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
                  "id": "obj-17",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    500,
                    50,
                    94.0,
                    22.0
                  ],
                  "text": "receive~ mt-filt-eg-sig",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-18",
                  "numinlets": 4,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    200,
                    250,
                    121.0,
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
                          "maxclass": "codebox",
                          "id": "obj-5",
                          "numinlets": 4,
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
                          "code": "\n// LFO with 6 waveforms\n// in 1: rate Hz\n// in 2: waveform select 0-5\n// in 3: key trigger\n// in 4: filter EG value\n\nHistory phase(0);\nHistory sh_val(0);\nHistory sh_prev(0);\n\nrate = in1;\nwaveform = in2;\nkey_trig = in3;\nfilt_eg = in4;\n\nphase = (key_trig > 0.5) ? 0 : phase;\ninc = rate / samplerate;\nphase = wrap(phase + inc, 0, 1);\n\ntri = (1.0 - abs(phase * 2.0 - 1.0)) * 2.0 - 1.0;\nsqr = (phase < 0.5) ? 1.0 : -1.0;\nsaw_w = phase * 2.0 - 1.0;\nramp_w = (1.0 - phase) * 2.0 - 1.0;\n\nnew_cyc = (phase < sh_prev) ? 1 : 0;\nsh_val = new_cyc ? noise() : sh_val;\nsh_prev = phase;\n\nsel = round(clamp(waveform, 0, 5));\nlfo_out = (sel == 0) ? tri : (sel == 1) ? sqr : (sel == 2) ? saw_w : (sel == 3) ? ramp_w : (sel == 4) ? sh_val : filt_eg;\n\nout1 = lfo_out;\n",
                          "fontname": "Arial",
                          "fontsize": 12.0
                        }
                      },
                      {
                        "box": {
                          "maxclass": "newobj",
                          "id": "obj-6",
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
                            "obj-5",
                            0
                          ],
                          "order": 0
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-2",
                            0
                          ],
                          "destination": [
                            "obj-5",
                            1
                          ],
                          "order": 0
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-3",
                            0
                          ],
                          "destination": [
                            "obj-5",
                            2
                          ],
                          "order": 0
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
                            3
                          ],
                          "order": 0
                        }
                      },
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
                          "order": 0
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
                  "id": "obj-19",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    30,
                    310,
                    149.0,
                    20.0
                  ],
                  "text": "--- MOD ROUTING ---",
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
                    30,
                    340,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-mod-wheel",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "message",
                  "id": "obj-21",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30,
                    365,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-22",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    30,
                    390,
                    39.0,
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
                  "id": "obj-23",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    200,
                    340,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-lfo-vco",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "message",
                  "id": "obj-24",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    200,
                    365,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-25",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    200,
                    390,
                    39.0,
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
                  "id": "obj-26",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    200,
                    420,
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
                  "id": "obj-27",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    200,
                    450,
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
                  "id": "obj-28",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    200,
                    480,
                    88.0,
                    22.0
                  ],
                  "text": "send~ mt-lfo-pitch-mod",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-29",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    400,
                    340,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-lfo-vcf",
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
                    400,
                    365,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-31",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    400,
                    390,
                    39.0,
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
                  "id": "obj-32",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    400,
                    420,
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
                  "id": "obj-33",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    400,
                    450,
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
                  "id": "obj-34",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    400,
                    480,
                    88.0,
                    22.0
                  ],
                  "text": "send~ mt-lfo-filt-mod",
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
                    "obj-3",
                    0
                  ],
                  "order": 0
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
                    0
                  ],
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                    0
                  ],
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-6",
                    0
                  ],
                  "destination": [
                    "obj-18",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-9",
                    0
                  ],
                  "destination": [
                    "obj-18",
                    1
                  ],
                  "order": 0
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
                    2
                  ],
                  "order": 0
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
                    3
                  ],
                  "order": 0
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
                  "order": 0
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
                    0
                  ],
                  "order": 0
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
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-18",
                    0
                  ],
                  "destination": [
                    "obj-26",
                    0
                  ],
                  "order": 0
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
                    1
                  ],
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-22",
                    0
                  ],
                  "destination": [
                    "obj-27",
                    1
                  ],
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-29",
                    0
                  ],
                  "destination": [
                    "obj-30",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-30",
                    0
                  ],
                  "destination": [
                    "obj-31",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-18",
                    0
                  ],
                  "destination": [
                    "obj-32",
                    0
                  ],
                  "order": 0
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
                    1
                  ],
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-22",
                    0
                  ],
                  "destination": [
                    "obj-33",
                    1
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-33",
                    0
                  ],
                  "destination": [
                    "obj-34",
                    0
                  ],
                  "order": 0
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
          "id": "obj-8",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            4545.0,
            150.0,
            86.0,
            22.0
          ],
          "text": "p filter",
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
              50,
              50,
              700,
              500
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
                    20,
                    198.0,
                    20.0
                  ],
                  "text": "--- MOOG LADDER FILTER ---",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-2",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    30,
                    50,
                    94.0,
                    22.0
                  ],
                  "text": "receive~ mt-mix-out",
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
                    200,
                    50,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-cutoff",
                  "fontname": "Arial",
                  "fontsize": 12.0
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
                    200,
                    75,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-5",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    200,
                    100,
                    39.0,
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
                  "id": "obj-6",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    200,
                    130,
                    121.0,
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
                          "maxclass": "codebox",
                          "id": "obj-2",
                          "numinlets": 1,
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
                          "code": "\n// Map 0-1 to 20-20000 Hz (exponential)\nout1 = 20.0 * pow(1000, clamp(in1, 0, 1));\n",
                          "fontname": "Arial",
                          "fontsize": 12.0
                        }
                      },
                      {
                        "box": {
                          "maxclass": "newobj",
                          "id": "obj-3",
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
                            "obj-2",
                            0
                          ],
                          "order": 0
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-2",
                            0
                          ],
                          "destination": [
                            "obj-3",
                            0
                          ],
                          "order": 0
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
                  "id": "obj-7",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    350,
                    50,
                    94.0,
                    22.0
                  ],
                  "text": "receive~ mt-filt-eg-sig",
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
                    350,
                    80,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-filt-eg-amt",
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
                    350,
                    105,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
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
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    350,
                    130,
                    39.0,
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
                  "id": "obj-11",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    350,
                    160,
                    42.0,
                    22.0
                  ],
                  "text": "*~ 2.",
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
                    350,
                    185,
                    45.0,
                    22.0
                  ],
                  "text": "-~ 1.",
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
                    350,
                    215,
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
                  "id": "obj-14",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    350,
                    245,
                    42.0,
                    22.0
                  ],
                  "text": "*~ 5.",
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
                    "signal"
                  ],
                  "patching_rect": [
                    350,
                    275,
                    121.0,
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
                          "maxclass": "codebox",
                          "id": "obj-2",
                          "numinlets": 1,
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
                          "code": "\nout1 = pow(2, in1);\n",
                          "fontname": "Arial",
                          "fontsize": 12.0
                        }
                      },
                      {
                        "box": {
                          "maxclass": "newobj",
                          "id": "obj-3",
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
                            "obj-2",
                            0
                          ],
                          "order": 0
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-2",
                            0
                          ],
                          "destination": [
                            "obj-3",
                            0
                          ],
                          "order": 0
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
                  "id": "obj-16",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    500,
                    50,
                    94.0,
                    22.0
                  ],
                  "text": "receive~ mt-lfo-filt-mod",
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
                    500,
                    80,
                    42.0,
                    22.0
                  ],
                  "text": "*~ 5.",
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
                    "signal"
                  ],
                  "patching_rect": [
                    500,
                    110,
                    121.0,
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
                          "maxclass": "codebox",
                          "id": "obj-2",
                          "numinlets": 1,
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
                          "code": "\nout1 = pow(2, in1);\n",
                          "fontname": "Arial",
                          "fontsize": 12.0
                        }
                      },
                      {
                        "box": {
                          "maxclass": "newobj",
                          "id": "obj-3",
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
                            "obj-2",
                            0
                          ],
                          "order": 0
                        }
                      },
                      {
                        "patchline": {
                          "source": [
                            "obj-2",
                            0
                          ],
                          "destination": [
                            "obj-3",
                            0
                          ],
                          "order": 0
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
                  "id": "obj-19",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    300,
                    320,
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
                  "id": "obj-20",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    350,
                    350,
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
                  "id": "obj-21",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    500,
                    300,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-resonance",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "message",
                  "id": "obj-22",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    500,
                    325,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-23",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    500,
                    350,
                    39.0,
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
                  "id": "obj-24",
                  "numinlets": 3,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    200,
                    400,
                    121.0,
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
                          "code": "\n// Moog Ladder Filter - Huovilainen improved model\n// 4-pole 24dB/oct low-pass with self-oscillation\n// in 1: audio input\n// in 2: cutoff frequency (Hz)\n// in 3: resonance (0-1, self-oscillates near 1)\n\nHistory s0(0);\nHistory s1(0);\nHistory s2(0);\nHistory s3(0);\nHistory clip_prev(0);\n\ninput = in1;\ncutoff_hz = in2;\nresonance = in3;\n\nfc = clamp(cutoff_hz, 20, samplerate * 0.45);\nwc = 2 * 3.14159265 * fc / samplerate;\nwc2 = wc * 0.5;\ng = wc2 / (1.0 + wc2);\n\nk = resonance * 4.0;\nfb = clip_prev;\nx = tanh(input - k * fb);\n\na = s0 + g * (x - s0);\nb = s1 + g * (a - s1);\nc = s2 + g * (b - s2);\nd = s3 + g * (c - s3);\n\ns0 = a;\ns1 = b;\ns2 = c;\ns3 = d;\nclip_prev = tanh(d);\n\nout1 = d;\n",
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
                          ],
                          "order": 0
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
                          "order": 0
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
                          "order": 0
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
                          "order": 0
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
                  "id": "obj-25",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    200,
                    450,
                    88.0,
                    22.0
                  ],
                  "text": "send~ mt-filt-out",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "source": [
                    "obj-3",
                    0
                  ],
                  "destination": [
                    "obj-4",
                    0
                  ],
                  "order": 0
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
                  "order": 0
                }
              },
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
                  "order": 0
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
                    0
                  ],
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-7",
                    0
                  ],
                  "destination": [
                    "obj-13",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-12",
                    0
                  ],
                  "destination": [
                    "obj-13",
                    1
                  ],
                  "order": 0
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
                  "order": 0
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
                  "order": 0
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
                  ],
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-6",
                    0
                  ],
                  "destination": [
                    "obj-19",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-15",
                    0
                  ],
                  "destination": [
                    "obj-19",
                    1
                  ],
                  "order": 0
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
                  "order": 0
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
                    1
                  ],
                  "order": 0
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
                    0
                  ],
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-2",
                    0
                  ],
                  "destination": [
                    "obj-24",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-20",
                    0
                  ],
                  "destination": [
                    "obj-24",
                    1
                  ],
                  "order": 0
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
                    2
                  ],
                  "order": 0
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
                  "order": 0
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
          "id": "obj-9",
          "numinlets": 0,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            4695.0,
            150.0,
            86.0,
            22.0
          ],
          "text": "p vca-output",
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
              50,
              50,
              500,
              400
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
                    20,
                    156.0,
                    20.0
                  ],
                  "text": "--- VCA & OUTPUT ---",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-2",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    30,
                    50,
                    94.0,
                    22.0
                  ],
                  "text": "receive~ mt-filt-out",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-3",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    200,
                    50,
                    94.0,
                    22.0
                  ],
                  "text": "receive~ mt-amp-eg-sig",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-4",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    100,
                    100,
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
                  "id": "obj-5",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30,
                    130,
                    83.0,
                    22.0
                  ],
                  "text": "receive mt-cc-volume",
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
                    155,
                    51.0,
                    22.0
                  ],
                  "text": "$1 30",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-7",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "outlettype": [
                    "signal",
                    ""
                  ],
                  "patching_rect": [
                    30,
                    180,
                    39.0,
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
                  "id": "obj-8",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    100,
                    200,
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
                  "id": "obj-9",
                  "numinlets": 3,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    100,
                    240,
                    64.0,
                    22.0
                  ],
                  "text": "clip~ -1. 1.",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-10",
                  "numinlets": 2,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    100,
                    290,
                    35.0,
                    22.0
                  ],
                  "text": "dac~",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "meter~",
                  "id": "obj-11",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    200,
                    240,
                    15.0,
                    100.0
                  ],
                  "parameter_enable": 0
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
                    "obj-4",
                    0
                  ],
                  "order": 0
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
                    1
                  ],
                  "order": 0
                }
              },
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
                  "order": 0
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
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-4",
                    0
                  ],
                  "destination": [
                    "obj-8",
                    0
                  ],
                  "order": 0
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
                    1
                  ],
                  "order": 0
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
                    0
                  ],
                  "order": 0
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
                  "order": 0
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
                    1
                  ],
                  "order": 0
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
                  "order": 0
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
          "id": "obj-10",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5385.0,
            75.0,
            247.0,
            20.0
          ],
          "text": "========== UI CONTROLS ==========",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-11",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            990.0,
            60.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            15,
            50,
            40,
            40
          ],
          "size": 40
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
            5385.0,
            135.0,
            79.0,
            20.0
          ],
          "text": "FINE TUNE",
          "fontname": "Arial",
          "fontsize": 9,
          "presentation": 1,
          "presentation_rect": [
            15,
            95,
            55,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-13",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            990.0,
            120.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-14",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1005.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-fine-tune",
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
            990.0,
            30.0,
            83.0,
            22.0
          ],
          "text": "receive mt-cc-fine-tune",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-16",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            990.0,
            75.0,
            111.0,
            22.0
          ],
          "text": "scale 0. 1. 0 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-17",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1140.0,
            60.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            75,
            50,
            40,
            40
          ],
          "size": 40
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
            5385.0,
            180.0,
            79.0,
            20.0
          ],
          "text": "VCO2 FREQ",
          "fontname": "Arial",
          "fontsize": 9,
          "presentation": 1,
          "presentation_rect": [
            75,
            95,
            55,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-19",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1140.0,
            120.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-20",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1155.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-vco2-freq",
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
            1140.0,
            30.0,
            83.0,
            22.0
          ],
          "text": "receive mt-cc-vco2-freq",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-22",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1140.0,
            75.0,
            111.0,
            22.0
          ],
          "text": "scale 0. 1. 0 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "toggle",
          "id": "obj-23",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            4830.0,
            0.0,
            24.0,
            24.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            140,
            55,
            20,
            20
          ]
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
            4830.0,
            30.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-vco1-wave",
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
            5385.0,
            225.0,
            65.0,
            20.0
          ],
          "text": "VCO1 SQ",
          "fontname": "Arial",
          "fontsize": 8,
          "presentation": 1,
          "presentation_rect": [
            140,
            75,
            50,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "toggle",
          "id": "obj-26",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            4965.0,
            0.0,
            24.0,
            24.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            140,
            80,
            20,
            20
          ]
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
            4965.0,
            30.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-vco2-wave",
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
            5385.0,
            285.0,
            65.0,
            20.0
          ],
          "text": "VCO2 SQ",
          "fontname": "Arial",
          "fontsize": 8,
          "presentation": 1,
          "presentation_rect": [
            140,
            100,
            50,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-29",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1290.0,
            60.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            205,
            50,
            40,
            40
          ],
          "size": 40
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
            5385.0,
            330.0,
            72.0,
            20.0
          ],
          "text": "VCO1 LVL",
          "fontname": "Arial",
          "fontsize": 9,
          "presentation": 1,
          "presentation_rect": [
            205,
            95,
            55,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-31",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1290.0,
            120.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-32",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1305.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-vco1-lvl",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-33",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1290.0,
            30.0,
            83.0,
            22.0
          ],
          "text": "receive mt-cc-vco1-lvl",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-34",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1290.0,
            75.0,
            111.0,
            22.0
          ],
          "text": "scale 0. 1. 0 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-35",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1440.0,
            60.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            265,
            50,
            40,
            40
          ],
          "size": 40
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
            5385.0,
            375.0,
            72.0,
            20.0
          ],
          "text": "VCO2 LVL",
          "fontname": "Arial",
          "fontsize": 9,
          "presentation": 1,
          "presentation_rect": [
            265,
            95,
            55,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-37",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1440.0,
            120.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-38",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1455.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-vco2-lvl",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-39",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1440.0,
            30.0,
            83.0,
            22.0
          ],
          "text": "receive mt-cc-vco2-lvl",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-40",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1440.0,
            75.0,
            111.0,
            22.0
          ],
          "text": "scale 0. 1. 0 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-41",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1590.0,
            60.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            345,
            50,
            50,
            50
          ],
          "size": 50
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-42",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5640.0,
            30.0,
            58.0,
            20.0
          ],
          "text": "CUTOFF",
          "fontname": "Arial",
          "fontsize": 9,
          "presentation": 1,
          "presentation_rect": [
            345,
            95,
            55,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-43",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1590.0,
            120.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-44",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1605.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-cutoff",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-45",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1590.0,
            30.0,
            83.0,
            22.0
          ],
          "text": "receive mt-cc-cutoff",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-46",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1590.0,
            75.0,
            111.0,
            22.0
          ],
          "text": "scale 0. 1. 0 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-47",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1755.0,
            60.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            405,
            50,
            50,
            50
          ],
          "size": 50
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-48",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5640.0,
            75.0,
            79.0,
            20.0
          ],
          "text": "RESONANCE",
          "fontname": "Arial",
          "fontsize": 9,
          "presentation": 1,
          "presentation_rect": [
            405,
            95,
            55,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-49",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1755.0,
            120.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-50",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1755.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-resonance",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-51",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1755.0,
            30.0,
            83.0,
            22.0
          ],
          "text": "receive mt-cc-resonance",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-52",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1755.0,
            75.0,
            111.0,
            22.0
          ],
          "text": "scale 0. 1. 0 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-53",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1905.0,
            60.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            465,
            50,
            40,
            40
          ],
          "size": 40
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-54",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5640.0,
            135.0,
            58.0,
            20.0
          ],
          "text": "EG AMT",
          "fontname": "Arial",
          "fontsize": 9,
          "presentation": 1,
          "presentation_rect": [
            465,
            95,
            55,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-55",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1905.0,
            120.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-56",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1905.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-filt-eg-amt",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-57",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1905.0,
            30.0,
            83.0,
            22.0
          ],
          "text": "receive mt-cc-filt-eg-amt",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-58",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1905.0,
            75.0,
            111.0,
            22.0
          ],
          "text": "scale 0. 1. 0 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-59",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2055.0,
            60.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            545,
            50,
            40,
            40
          ],
          "size": 40
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-60",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5640.0,
            180.0,
            51.0,
            20.0
          ],
          "text": "F.ATT",
          "fontname": "Arial",
          "fontsize": 9,
          "presentation": 1,
          "presentation_rect": [
            545,
            95,
            55,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-61",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2055.0,
            120.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-62",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            2055.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-filt-att",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-63",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2055.0,
            30.0,
            83.0,
            22.0
          ],
          "text": "receive mt-cc-filt-att",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-64",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2055.0,
            75.0,
            111.0,
            22.0
          ],
          "text": "scale 0. 1. 0 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-65",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2205.0,
            60.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            605,
            50,
            40,
            40
          ],
          "size": 40
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
            5640.0,
            225.0,
            51.0,
            20.0
          ],
          "text": "F.DEC",
          "fontname": "Arial",
          "fontsize": 9,
          "presentation": 1,
          "presentation_rect": [
            605,
            95,
            55,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-67",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2205.0,
            120.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-68",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            2205.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-filt-dec",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-69",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2205.0,
            30.0,
            83.0,
            22.0
          ],
          "text": "receive mt-cc-filt-dec",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-70",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2205.0,
            75.0,
            111.0,
            22.0
          ],
          "text": "scale 0. 1. 0 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-71",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2355.0,
            60.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            665,
            50,
            40,
            40
          ],
          "size": 40
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-72",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5640.0,
            285.0,
            51.0,
            20.0
          ],
          "text": "F.SUS",
          "fontname": "Arial",
          "fontsize": 9,
          "presentation": 1,
          "presentation_rect": [
            665,
            95,
            55,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-73",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2355.0,
            120.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-74",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            2355.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-filt-sus",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-75",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2355.0,
            30.0,
            83.0,
            22.0
          ],
          "text": "receive mt-cc-filt-sus",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-76",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2355.0,
            75.0,
            111.0,
            22.0
          ],
          "text": "scale 0. 1. 0 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-77",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2505.0,
            60.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            745,
            50,
            40,
            40
          ],
          "size": 40
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
            5640.0,
            330.0,
            51.0,
            20.0
          ],
          "text": "A.ATT",
          "fontname": "Arial",
          "fontsize": 9,
          "presentation": 1,
          "presentation_rect": [
            745,
            95,
            55,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-79",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2505.0,
            120.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-80",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            2505.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-amp-att",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-81",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2505.0,
            30.0,
            83.0,
            22.0
          ],
          "text": "receive mt-cc-amp-att",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-82",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2505.0,
            75.0,
            111.0,
            22.0
          ],
          "text": "scale 0. 1. 0 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-83",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2655.0,
            60.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            805,
            50,
            40,
            40
          ],
          "size": 40
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-84",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5640.0,
            375.0,
            51.0,
            20.0
          ],
          "text": "A.DEC",
          "fontname": "Arial",
          "fontsize": 9,
          "presentation": 1,
          "presentation_rect": [
            805,
            95,
            55,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-85",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2655.0,
            120.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-86",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            2655.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-amp-dec",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-87",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2655.0,
            30.0,
            83.0,
            22.0
          ],
          "text": "receive mt-cc-amp-dec",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-88",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2655.0,
            75.0,
            111.0,
            22.0
          ],
          "text": "scale 0. 1. 0 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-89",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2805.0,
            60.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            865,
            50,
            40,
            40
          ],
          "size": 40
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
            5730.0,
            30.0,
            51.0,
            20.0
          ],
          "text": "A.SUS",
          "fontname": "Arial",
          "fontsize": 9,
          "presentation": 1,
          "presentation_rect": [
            865,
            95,
            55,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-91",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2805.0,
            120.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-92",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            2805.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-amp-sus",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-93",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2805.0,
            30.0,
            83.0,
            22.0
          ],
          "text": "receive mt-cc-amp-sus",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-94",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2805.0,
            75.0,
            111.0,
            22.0
          ],
          "text": "scale 0. 1. 0 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "toggle",
          "id": "obj-95",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            5100.0,
            0.0,
            24.0,
            24.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            925,
            55,
            20,
            20
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-96",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5100.0,
            30.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-release-sw",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-97",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5730.0,
            75.0,
            65.0,
            20.0
          ],
          "text": "RELEASE",
          "fontname": "Arial",
          "fontsize": 8,
          "presentation": 1,
          "presentation_rect": [
            925,
            75,
            55,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-98",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2955.0,
            60.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            975,
            50,
            40,
            40
          ],
          "size": 40
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-99",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5730.0,
            135.0,
            72.0,
            20.0
          ],
          "text": "LFO RATE",
          "fontname": "Arial",
          "fontsize": 9,
          "presentation": 1,
          "presentation_rect": [
            975,
            95,
            55,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-100",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2955.0,
            120.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-101",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            2970.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-lfo-rate",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-102",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2955.0,
            30.0,
            83.0,
            22.0
          ],
          "text": "receive mt-cc-lfo-rate",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-103",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            2955.0,
            75.0,
            111.0,
            22.0
          ],
          "text": "scale 0. 1. 0 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-104",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3105.0,
            60.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            1035,
            50,
            40,
            40
          ],
          "size": 40
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
            5730.0,
            180.0,
            65.0,
            20.0
          ],
          "text": "LFO>VCO",
          "fontname": "Arial",
          "fontsize": 9,
          "presentation": 1,
          "presentation_rect": [
            1035,
            95,
            55,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-106",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3105.0,
            120.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-107",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            3120.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-lfo-vco",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-108",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3105.0,
            30.0,
            83.0,
            22.0
          ],
          "text": "receive mt-cc-lfo-vco",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-109",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3105.0,
            75.0,
            111.0,
            22.0
          ],
          "text": "scale 0. 1. 0 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-110",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3255.0,
            60.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            1095,
            50,
            40,
            40
          ],
          "size": 40
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-111",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5730.0,
            225.0,
            65.0,
            20.0
          ],
          "text": "LFO>VCF",
          "fontname": "Arial",
          "fontsize": 9,
          "presentation": 1,
          "presentation_rect": [
            1095,
            95,
            55,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-112",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3255.0,
            120.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-113",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            3270.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-lfo-vcf",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-114",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3255.0,
            30.0,
            83.0,
            22.0
          ],
          "text": "receive mt-cc-lfo-vcf",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-115",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3255.0,
            75.0,
            111.0,
            22.0
          ],
          "text": "scale 0. 1. 0 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "toggle",
          "id": "obj-116",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            5250.0,
            0.0,
            24.0,
            24.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            1145,
            55,
            20,
            20
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-117",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5250.0,
            30.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-glide-sw",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-118",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5730.0,
            285.0,
            51.0,
            20.0
          ],
          "text": "GLIDE",
          "fontname": "Arial",
          "fontsize": 8,
          "presentation": 1,
          "presentation_rect": [
            1145,
            75,
            45,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-119",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3405.0,
            60.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            1175,
            50,
            40,
            40
          ],
          "size": 40
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-120",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5730.0,
            330.0,
            72.0,
            20.0
          ],
          "text": "GLIDE RT",
          "fontname": "Arial",
          "fontsize": 9,
          "presentation": 1,
          "presentation_rect": [
            1175,
            95,
            55,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-121",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3405.0,
            120.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-122",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            3420.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-glide-rate",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-123",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3405.0,
            30.0,
            83.0,
            22.0
          ],
          "text": "receive mt-cc-glide-rate",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-124",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3405.0,
            75.0,
            111.0,
            22.0
          ],
          "text": "scale 0. 1. 0 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-125",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3555.0,
            60.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            1285,
            50,
            50,
            50
          ],
          "size": 50
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-126",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5730.0,
            375.0,
            58.0,
            20.0
          ],
          "text": "VOLUME",
          "fontname": "Arial",
          "fontsize": 9,
          "presentation": 1,
          "presentation_rect": [
            1285,
            95,
            55,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-127",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3555.0,
            120.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-128",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            3570.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-volume",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-129",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3555.0,
            30.0,
            83.0,
            22.0
          ],
          "text": "receive mt-cc-volume",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-130",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3555.0,
            75.0,
            111.0,
            22.0
          ],
          "text": "scale 0. 1. 0 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-131",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5820.0,
            30.0,
            72.0,
            20.0
          ],
          "text": "MINITAUR",
          "fontname": "Arial",
          "fontsize": 16,
          "presentation": 1,
          "presentation_rect": [
            15,
            10,
            200,
            25
          ],
          "fontface": 1
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-132",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5820.0,
            75.0,
            40.0,
            20.0
          ],
          "text": "OSC",
          "fontname": "Arial",
          "fontsize": 10,
          "presentation": 1,
          "presentation_rect": [
            15,
            32,
            70,
            15
          ],
          "fontface": 1
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-133",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5820.0,
            135.0,
            40.0,
            20.0
          ],
          "text": "MIX",
          "fontname": "Arial",
          "fontsize": 10,
          "presentation": 1,
          "presentation_rect": [
            205,
            32,
            70,
            15
          ],
          "fontface": 1
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-134",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5820.0,
            180.0,
            58.0,
            20.0
          ],
          "text": "FILTER",
          "fontname": "Arial",
          "fontsize": 10,
          "presentation": 1,
          "presentation_rect": [
            345,
            32,
            70,
            15
          ],
          "fontface": 1
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-135",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5820.0,
            225.0,
            65.0,
            20.0
          ],
          "text": "FILT EG",
          "fontname": "Arial",
          "fontsize": 10,
          "presentation": 1,
          "presentation_rect": [
            545,
            32,
            70,
            15
          ],
          "fontface": 1
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-136",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5820.0,
            285.0,
            58.0,
            20.0
          ],
          "text": "AMP EG",
          "fontname": "Arial",
          "fontsize": 10,
          "presentation": 1,
          "presentation_rect": [
            745,
            32,
            70,
            15
          ],
          "fontface": 1
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-137",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5820.0,
            330.0,
            40.0,
            20.0
          ],
          "text": "LFO",
          "fontname": "Arial",
          "fontsize": 10,
          "presentation": 1,
          "presentation_rect": [
            975,
            32,
            70,
            15
          ],
          "fontface": 1
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-138",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5820.0,
            375.0,
            44.0,
            20.0
          ],
          "text": "PERF",
          "fontname": "Arial",
          "fontsize": 10,
          "presentation": 1,
          "presentation_rect": [
            1175,
            32,
            70,
            15
          ],
          "fontface": 1
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-139",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5910.0,
            30.0,
            40.0,
            20.0
          ],
          "text": "VOL",
          "fontname": "Arial",
          "fontsize": 10,
          "presentation": 1,
          "presentation_rect": [
            1285,
            32,
            70,
            15
          ],
          "fontface": 1
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-140",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5910.0,
            75.0,
            198.0,
            20.0
          ],
          "text": "--- SUBPATCHER BUTTONS ---",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "textbutton",
          "id": "obj-141",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "patching_rect": [
            3705.0,
            30.0,
            100.0,
            20.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            15,
            120,
            70,
            20
          ],
          "text": "MIDI"
        }
      },
      {
        "box": {
          "maxclass": "message",
          "id": "obj-142",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3705.0,
            75.0,
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
          "maxclass": "newobj",
          "id": "obj-143",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3705.0,
            105.0,
            58.0,
            22.0
          ],
          "text": "pcontrol",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "textbutton",
          "id": "obj-144",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "patching_rect": [
            3855.0,
            30.0,
            100.0,
            20.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            95,
            120,
            70,
            20
          ],
          "text": "OSC"
        }
      },
      {
        "box": {
          "maxclass": "message",
          "id": "obj-145",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3855.0,
            75.0,
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
          "maxclass": "newobj",
          "id": "obj-146",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3855.0,
            105.0,
            58.0,
            22.0
          ],
          "text": "pcontrol",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "textbutton",
          "id": "obj-147",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "patching_rect": [
            3990.0,
            30.0,
            100.0,
            20.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            175,
            120,
            70,
            20
          ],
          "text": "MIX"
        }
      },
      {
        "box": {
          "maxclass": "message",
          "id": "obj-148",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3990.0,
            75.0,
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
          "maxclass": "newobj",
          "id": "obj-149",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            3990.0,
            105.0,
            58.0,
            22.0
          ],
          "text": "pcontrol",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "textbutton",
          "id": "obj-150",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "patching_rect": [
            4125.0,
            30.0,
            100.0,
            20.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            255,
            120,
            70,
            20
          ],
          "text": "GLIDE"
        }
      },
      {
        "box": {
          "maxclass": "message",
          "id": "obj-151",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            4125.0,
            75.0,
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
          "maxclass": "newobj",
          "id": "obj-152",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            4125.0,
            105.0,
            58.0,
            22.0
          ],
          "text": "pcontrol",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "textbutton",
          "id": "obj-153",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "patching_rect": [
            4275.0,
            30.0,
            100.0,
            20.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            335,
            120,
            70,
            20
          ],
          "text": "ENV"
        }
      },
      {
        "box": {
          "maxclass": "message",
          "id": "obj-154",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            4275.0,
            75.0,
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
          "maxclass": "newobj",
          "id": "obj-155",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            4275.0,
            105.0,
            58.0,
            22.0
          ],
          "text": "pcontrol",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "textbutton",
          "id": "obj-156",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "patching_rect": [
            4410.0,
            30.0,
            100.0,
            20.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            415,
            120,
            70,
            20
          ],
          "text": "LFO"
        }
      },
      {
        "box": {
          "maxclass": "message",
          "id": "obj-157",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            4410.0,
            75.0,
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
          "maxclass": "newobj",
          "id": "obj-158",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            4410.0,
            105.0,
            58.0,
            22.0
          ],
          "text": "pcontrol",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "textbutton",
          "id": "obj-159",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "patching_rect": [
            4545.0,
            30.0,
            100.0,
            20.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            495,
            120,
            70,
            20
          ],
          "text": "FILT"
        }
      },
      {
        "box": {
          "maxclass": "message",
          "id": "obj-160",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            4545.0,
            75.0,
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
          "maxclass": "newobj",
          "id": "obj-161",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            4545.0,
            105.0,
            58.0,
            22.0
          ],
          "text": "pcontrol",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "textbutton",
          "id": "obj-162",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "patching_rect": [
            4695.0,
            30.0,
            100.0,
            20.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            575,
            120,
            70,
            20
          ],
          "text": "VCA"
        }
      },
      {
        "box": {
          "maxclass": "message",
          "id": "obj-163",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            4695.0,
            75.0,
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
          "maxclass": "newobj",
          "id": "obj-164",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            4695.0,
            105.0,
            58.0,
            22.0
          ],
          "text": "pcontrol",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-165",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            5910.0,
            135.0,
            100.0,
            20.0
          ],
          "text": "--- INIT ---",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-166",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            30.0,
            30.0,
            62.0,
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
          "id": "obj-167",
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
            30.0,
            75.0,
            80.5,
            22.0
          ],
          "text": "trigger b b b b b b b b",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "message",
          "id": "obj-168",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            90.0,
            120.0,
            40.0,
            22.0
          ],
          "text": "0.7",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-169",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            75.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-cutoff",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "message",
          "id": "obj-170",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            150.0,
            120.0,
            40.0,
            22.0
          ],
          "text": "0.7",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-171",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            180.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-volume",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "message",
          "id": "obj-172",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            210.0,
            120.0,
            40.0,
            22.0
          ],
          "text": "0.8",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-173",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            300.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-vco1-lvl",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "message",
          "id": "obj-174",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            255.0,
            120.0,
            40.0,
            22.0
          ],
          "text": "0.8",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-175",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            405.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-vco2-lvl",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "message",
          "id": "obj-176",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            315.0,
            120.0,
            40.0,
            22.0
          ],
          "text": "0.5",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-177",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            525.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-amp-sus",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "message",
          "id": "obj-178",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            375.0,
            120.0,
            40.0,
            22.0
          ],
          "text": "0.5",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-179",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            630.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-filt-sus",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "message",
          "id": "obj-180",
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
          "text": "0.5",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-181",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            750.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-filt-eg-amt",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "message",
          "id": "obj-182",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            480.0,
            120.0,
            40.0,
            22.0
          ],
          "text": "0.5",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-183",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            855.0,
            150.0,
            97.5,
            22.0
          ],
          "text": "send mt-cc-fine-tune",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      }
    ],
    "lines": [
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
          "order": 0
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
          "order": 0
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
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-16",
            0
          ],
          "destination": [
            "obj-11",
            0
          ],
          "order": 0
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
          "order": 0
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
          "order": 0
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
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-22",
            0
          ],
          "destination": [
            "obj-17",
            0
          ],
          "order": 0
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
          "order": 0
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
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-29",
            0
          ],
          "destination": [
            "obj-31",
            0
          ],
          "order": 0
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
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-33",
            0
          ],
          "destination": [
            "obj-34",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-34",
            0
          ],
          "destination": [
            "obj-29",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-35",
            0
          ],
          "destination": [
            "obj-37",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-37",
            0
          ],
          "destination": [
            "obj-38",
            0
          ],
          "order": 0
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
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-40",
            0
          ],
          "destination": [
            "obj-35",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-41",
            0
          ],
          "destination": [
            "obj-43",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-43",
            0
          ],
          "destination": [
            "obj-44",
            0
          ],
          "order": 0
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
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-46",
            0
          ],
          "destination": [
            "obj-41",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-47",
            0
          ],
          "destination": [
            "obj-49",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-49",
            0
          ],
          "destination": [
            "obj-50",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-51",
            0
          ],
          "destination": [
            "obj-52",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-52",
            0
          ],
          "destination": [
            "obj-47",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-53",
            0
          ],
          "destination": [
            "obj-55",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-55",
            0
          ],
          "destination": [
            "obj-56",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-57",
            0
          ],
          "destination": [
            "obj-58",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-58",
            0
          ],
          "destination": [
            "obj-53",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-59",
            0
          ],
          "destination": [
            "obj-61",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-61",
            0
          ],
          "destination": [
            "obj-62",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-63",
            0
          ],
          "destination": [
            "obj-64",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-64",
            0
          ],
          "destination": [
            "obj-59",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-65",
            0
          ],
          "destination": [
            "obj-67",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-67",
            0
          ],
          "destination": [
            "obj-68",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-69",
            0
          ],
          "destination": [
            "obj-70",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-70",
            0
          ],
          "destination": [
            "obj-65",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-71",
            0
          ],
          "destination": [
            "obj-73",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-73",
            0
          ],
          "destination": [
            "obj-74",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-75",
            0
          ],
          "destination": [
            "obj-76",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-76",
            0
          ],
          "destination": [
            "obj-71",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-77",
            0
          ],
          "destination": [
            "obj-79",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-79",
            0
          ],
          "destination": [
            "obj-80",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-81",
            0
          ],
          "destination": [
            "obj-82",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-82",
            0
          ],
          "destination": [
            "obj-77",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-83",
            0
          ],
          "destination": [
            "obj-85",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-85",
            0
          ],
          "destination": [
            "obj-86",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-87",
            0
          ],
          "destination": [
            "obj-88",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-88",
            0
          ],
          "destination": [
            "obj-83",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-89",
            0
          ],
          "destination": [
            "obj-91",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-91",
            0
          ],
          "destination": [
            "obj-92",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-93",
            0
          ],
          "destination": [
            "obj-94",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-94",
            0
          ],
          "destination": [
            "obj-89",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-95",
            0
          ],
          "destination": [
            "obj-96",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-98",
            0
          ],
          "destination": [
            "obj-100",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-100",
            0
          ],
          "destination": [
            "obj-101",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-102",
            0
          ],
          "destination": [
            "obj-103",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-103",
            0
          ],
          "destination": [
            "obj-98",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-104",
            0
          ],
          "destination": [
            "obj-106",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-106",
            0
          ],
          "destination": [
            "obj-107",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-108",
            0
          ],
          "destination": [
            "obj-109",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-109",
            0
          ],
          "destination": [
            "obj-104",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-110",
            0
          ],
          "destination": [
            "obj-112",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-112",
            0
          ],
          "destination": [
            "obj-113",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-114",
            0
          ],
          "destination": [
            "obj-115",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-115",
            0
          ],
          "destination": [
            "obj-110",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-116",
            0
          ],
          "destination": [
            "obj-117",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-119",
            0
          ],
          "destination": [
            "obj-121",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-121",
            0
          ],
          "destination": [
            "obj-122",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-123",
            0
          ],
          "destination": [
            "obj-124",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-124",
            0
          ],
          "destination": [
            "obj-119",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-125",
            0
          ],
          "destination": [
            "obj-127",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-127",
            0
          ],
          "destination": [
            "obj-128",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-129",
            0
          ],
          "destination": [
            "obj-130",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-130",
            0
          ],
          "destination": [
            "obj-125",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-141",
            0
          ],
          "destination": [
            "obj-142",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-142",
            0
          ],
          "destination": [
            "obj-143",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-144",
            0
          ],
          "destination": [
            "obj-145",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-145",
            0
          ],
          "destination": [
            "obj-146",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-147",
            0
          ],
          "destination": [
            "obj-148",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-148",
            0
          ],
          "destination": [
            "obj-149",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-150",
            0
          ],
          "destination": [
            "obj-151",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-151",
            0
          ],
          "destination": [
            "obj-152",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-153",
            0
          ],
          "destination": [
            "obj-154",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-154",
            0
          ],
          "destination": [
            "obj-155",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-156",
            0
          ],
          "destination": [
            "obj-157",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-157",
            0
          ],
          "destination": [
            "obj-158",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-159",
            0
          ],
          "destination": [
            "obj-160",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-160",
            0
          ],
          "destination": [
            "obj-161",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-162",
            0
          ],
          "destination": [
            "obj-163",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-163",
            0
          ],
          "destination": [
            "obj-164",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-166",
            0
          ],
          "destination": [
            "obj-167",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-167",
            7
          ],
          "destination": [
            "obj-168",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-168",
            0
          ],
          "destination": [
            "obj-169",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-167",
            6
          ],
          "destination": [
            "obj-170",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-170",
            0
          ],
          "destination": [
            "obj-171",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-167",
            5
          ],
          "destination": [
            "obj-172",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-172",
            0
          ],
          "destination": [
            "obj-173",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-167",
            4
          ],
          "destination": [
            "obj-174",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-174",
            0
          ],
          "destination": [
            "obj-175",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-167",
            3
          ],
          "destination": [
            "obj-176",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-176",
            0
          ],
          "destination": [
            "obj-177",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-167",
            2
          ],
          "destination": [
            "obj-178",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-178",
            0
          ],
          "destination": [
            "obj-179",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-167",
            1
          ],
          "destination": [
            "obj-180",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-180",
            0
          ],
          "destination": [
            "obj-181",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-167",
            0
          ],
          "destination": [
            "obj-182",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-182",
            0
          ],
          "destination": [
            "obj-183",
            0
          ],
          "order": 0
        }
      }
    ],
    "dependency_cache": [],
    "autosave": 0
  }
}