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
      1060.0,
      1020.0
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
          "maxclass": "newobj",
          "id": "obj-1",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            500.0,
            100.0,
            100.0,
            22.0
          ],
          "text": "buffer~ #1",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-2",
          "numinlets": 3,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            "signal"
          ],
          "patching_rect": [
            700.0,
            275.0,
            107.0,
            22.0
          ],
          "text": "groove~ #1",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-3",
          "numinlets": 1,
          "numoutlets": 5,
          "outlettype": [
            "",
            "",
            "",
            "",
            ""
          ],
          "patching_rect": [
            800.0,
            145.0,
            100.0,
            22.0
          ],
          "text": "info~ #1",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-4",
          "numinlets": 5,
          "numoutlets": 6,
          "outlettype": [
            "",
            "",
            "",
            "",
            "",
            ""
          ],
          "patching_rect": [
            800.0,
            25.0,
            135.0,
            22.0
          ],
          "text": "waveform~ #1",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            0,
            0,
            400,
            60
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-5",
          "numinlets": 3,
          "numoutlets": 4,
          "outlettype": [
            "signal",
            "signal",
            "signal",
            "signal"
          ],
          "patching_rect": [
            700.0,
            365.0,
            44.0,
            22.0
          ],
          "text": "svf~",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-6",
          "numinlets": 5,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            700.0,
            445.0,
            93.0,
            22.0
          ],
          "text": "selector~ 4",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-7",
          "numinlets": 3,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            700.0,
            528.0,
            72.0,
            22.0
          ],
          "text": "degrade~",
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
            700.0,
            618.0,
            40.0,
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
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            700.0,
            710.0,
            40.0,
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
          "id": "obj-10",
          "numinlets": 2,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            "signal"
          ],
          "patching_rect": [
            400.0,
            645.0,
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
          "id": "obj-11",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            700.0,
            770.0,
            107.0,
            22.0
          ],
          "text": "send~ #2",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-12",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            260.0,
            277.0,
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
          "maxclass": "newobj",
          "id": "obj-13",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            260.0,
            367.0,
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
          "maxclass": "newobj",
          "id": "obj-14",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            540.0,
            367.0,
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
          "maxclass": "newobj",
          "id": "obj-15",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            260.0,
            530.0,
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
          "maxclass": "newobj",
          "id": "obj-16",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            400.0,
            530.0,
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
          "maxclass": "newobj",
          "id": "obj-17",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            260.0,
            720.0,
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
          "maxclass": "meter~",
          "id": "obj-18",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            840.0,
            445.0,
            15.0,
            100.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            365,
            104,
            20,
            155
          ]
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
            640.0,
            140.0,
            107.0,
            22.0
          ],
          "text": "setbuffer #1",
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
            640.0,
            100.0,
            72.0,
            22.0
          ],
          "text": "set #1",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-21",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            25.0,
            25.0,
            95.0,
            22.0
          ],
          "text": "receive tick",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-22",
          "numinlets": 5,
          "numoutlets": 4,
          "outlettype": [
            "",
            "",
            "",
            ""
          ],
          "patching_rect": [
            25.0,
            65.0,
            100.0,
            22.0
          ],
          "text": "counter 0 15",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-23",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            25.0,
            105.0,
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
          "id": "obj-24",
          "numinlets": 3,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            800.0,
            105.0,
            120.0,
            22.0
          ],
          "text": "js slot-engine.js",
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
            200.0,
            105.0,
            142.0,
            22.0
          ],
          "text": "prepend fetchindex",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "multislider",
          "id": "obj-26",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            200.0,
            25.0,
            200.0,
            65.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            8,
            246,
            345,
            80
          ],
          "size": 16,
          "setminmax": [
            0.0,
            127.0
          ],
          "setstyle": 1
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-27",
          "numinlets": 3,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            200.0,
            145.0,
            93.0,
            22.0
          ],
          "text": "split 1 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-28",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            200.0,
            185.0,
            93.0,
            22.0
          ],
          "text": "trigger b f",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-29",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            200.0,
            600.0,
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
          "id": "obj-30",
          "numinlets": 3,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            280.0,
            610.0,
            86.0,
            22.0
          ],
          "text": "pack f f f",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "message",
          "id": "obj-31",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            280.0,
            645.0,
            100.0,
            22.0
          ],
          "text": "$1 $2, 0. $3",
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
            440.0,
            255.0,
            79.0,
            22.0
          ],
          "text": "startloop",
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
            560.0,
            285.0,
            58.0,
            22.0
          ],
          "text": "loop 1",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "button",
          "id": "obj-34",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            500.0,
            25.0,
            24.0,
            24.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            38,
            64,
            20,
            20
          ]
        }
      },
      {
        "box": {
          "maxclass": "message",
          "id": "obj-35",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            500.0,
            60.0,
            44.0,
            22.0
          ],
          "text": "read",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "number",
          "id": "obj-36",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            800.0,
            65.0,
            50.0,
            22.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            62,
            64,
            50,
            20
          ]
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-37",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            25.0,
            265.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            8,
            104,
            48,
            48
          ]
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
            80.0,
            277.0,
            160.0,
            22.0
          ],
          "text": "expr pow(2.\\, $f1 / 12.)",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-39",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            25.0,
            355.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            63,
            104,
            48,
            48
          ]
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
            80.0,
            367.0,
            155.0,
            22.0
          ],
          "text": "scale 0 127 20. 20000.",
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
            340.0,
            355.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            118,
            104,
            48,
            48
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-42",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            400.0,
            367.0,
            120.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "umenu",
          "id": "obj-43",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "patching_rect": [
            440.0,
            442.0,
            80.0,
            22.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            173,
            110,
            52,
            22
          ],
          "items": [
            "LP",
            "HP",
            "BP",
            "Notch"
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
            ""
          ],
          "patching_rect": [
            540.0,
            442.0,
            40.0,
            22.0
          ],
          "text": "+ 1",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-45",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            25.0,
            518.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            228,
            104,
            48,
            48
          ]
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
            80.0,
            530.0,
            128.0,
            22.0
          ],
          "text": "scale 0 127 0.1 1.",
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
            25.0,
            708.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            283,
            104,
            48,
            48
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-48",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            80.0,
            720.0,
            120.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-49",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            25.0,
            608.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            8,
            174,
            48,
            48
          ]
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-50",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            100.0,
            608.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            63,
            174,
            48,
            48
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-51",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            25.0,
            830.0,
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
          "id": "obj-52",
          "numinlets": 1,
          "numoutlets": 12,
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
            ""
          ],
          "patching_rect": [
            25.0,
            865.0,
            300.0,
            22.0
          ],
          "text": "trigger b b b b b b b b b b b b",
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
            239,
            902.0,
            58.0,
            22.0
          ],
          "text": "loop 1",
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
            226,
            902.0,
            30.0,
            22.0
          ],
          "text": "16",
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
            202,
            902.0,
            25.0,
            22.0
          ],
          "text": "5",
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
            171,
            902.0,
            35.0,
            22.0
          ],
          "text": "300",
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
            144,
            902.0,
            35.0,
            22.0
          ],
          "text": "24.",
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
            120,
            902.0,
            30.0,
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
          "id": "obj-59",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            89,
            902.0,
            40.0,
            22.0
          ],
          "text": "100",
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
            62,
            902.0,
            40.0,
            22.0
          ],
          "text": "127",
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
            36,
            902.0,
            40.0,
            22.0
          ],
          "text": "127",
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
            15,
            902.0,
            107.0,
            22.0
          ],
          "text": "setbuffer #1",
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
            25.0,
            245.0,
            50.0,
            20.0
          ],
          "text": "Pitch",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            8,
            88,
            52,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-64",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            25.0,
            335.0,
            55.0,
            20.0
          ],
          "text": "Cutoff",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            63,
            88,
            52,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-65",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            340.0,
            335.0,
            50.0,
            20.0
          ],
          "text": "Reso",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            118,
            88,
            52,
            14
          ]
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
            440.0,
            420.0,
            50.0,
            20.0
          ],
          "text": "Type",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            173,
            88,
            52,
            14
          ]
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
            25.0,
            498.0,
            65.0,
            20.0
          ],
          "text": "Degrade",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            228,
            88,
            52,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-68",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            25.0,
            688.0,
            55.0,
            20.0
          ],
          "text": "Volume",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            283,
            88,
            52,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-69",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            25.0,
            588.0,
            50.0,
            20.0
          ],
          "text": "Attack",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            8,
            158,
            52,
            14
          ]
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-70",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            100.0,
            588.0,
            50.0,
            20.0
          ],
          "text": "Decay",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            63,
            158,
            52,
            14
          ]
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
            25.0,
            935.0,
            100.0,
            20.0
          ],
          "text": "Step Pattern",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            8,
            230,
            100,
            14
          ]
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
            279,
            902.0,
            30.0,
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
          "id": "obj-73",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            181,
            902.0,
            280.0,
            22.0
          ],
          "text": "127 127 127 127 127 127 127 127 127 127 127 127 127 127 127 127",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-74",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            460,
            25,
            35,
            20
          ],
          "text": "Load",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            8,
            64,
            30,
            18
          ]
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
            840,
            540,
            40,
            20
          ],
          "text": "Level",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            355,
            88,
            38,
            14
          ]
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "source": [
            "obj-12",
            0
          ],
          "destination": [
            "obj-2",
            0
          ],
          "order": 0,
          "midpoints": [
            260.0,
            315,
            700.0,
            315
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
            1
          ],
          "order": 0,
          "midpoints": [
            700.0,
            407,
            723.2,
            407
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-5",
            1
          ],
          "destination": [
            "obj-6",
            2
          ],
          "order": 0,
          "midpoints": [
            714.7,
            411,
            746.5,
            411
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-5",
            2
          ],
          "destination": [
            "obj-6",
            3
          ],
          "order": 0,
          "midpoints": [
            729.3,
            415,
            769.8,
            415
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-5",
            3
          ],
          "destination": [
            "obj-6",
            4
          ],
          "order": 0,
          "midpoints": [
            744.0,
            419,
            793.0,
            419
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
          "order": 0,
          "midpoints": [
            746.5,
            488,
            704.0,
            488
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
          "order": 0,
          "midpoints": [
            736.0,
            574,
            704.0,
            574
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
            "obj-8",
            1
          ],
          "order": 0,
          "midpoints": [
            400.0,
            680,
            740.0,
            680
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
            "obj-9",
            1
          ],
          "order": 0,
          "midpoints": [
            260.0,
            755,
            740.0,
            755
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
          "order": 0,
          "midpoints": [
            720.0,
            745,
            753.5,
            745
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
            "obj-5",
            1
          ],
          "order": 0,
          "midpoints": [
            260.0,
            405,
            722.0,
            405
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
            "obj-5",
            2
          ],
          "order": 0,
          "midpoints": [
            540.0,
            405,
            744.0,
            405
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
            "obj-7",
            1
          ],
          "order": 0,
          "midpoints": [
            260.0,
            570,
            736.0,
            570
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
            "obj-7",
            2
          ],
          "order": 0,
          "midpoints": [
            400.0,
            575,
            772.0,
            575
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
            "obj-18",
            0
          ],
          "order": 0,
          "midpoints": [
            870,
            732,
            870,
            445
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
            0
          ],
          "order": 0,
          "midpoints": [
            72.5,
            53,
            29.0,
            53
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
          "order": 0,
          "midpoints": [
            29.0,
            93,
            71.5,
            93
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
            0
          ],
          "order": 0,
          "midpoints": [
            118.0,
            215,
            800.0,
            215
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
            "obj-25",
            0
          ],
          "order": 0,
          "midpoints": [
            25.0,
            95,
            200.0,
            95
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
          "order": 0,
          "midpoints": [
            920,
            127.0,
            920,
            17.0,
            300.0,
            17.0
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
            "obj-2",
            1
          ],
          "order": 0,
          "midpoints": [
            800.0,
            265,
            753.5,
            265
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
            "obj-2",
            2
          ],
          "order": 0,
          "midpoints": [
            920.0,
            265,
            807.0,
            265
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
          "order": 0,
          "midpoints": [
            204.0,
            173,
            246.5,
            173
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-28",
            1
          ],
          "destination": [
            "obj-29",
            0
          ],
          "order": 0,
          "midpoints": [
            293.0,
            210,
            160,
            210,
            160,
            590,
            200.0,
            590
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
            "obj-30",
            0
          ],
          "order": 0,
          "midpoints": [
            229.0,
            600,
            284.0,
            600
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
            "obj-32",
            0
          ],
          "order": 0,
          "midpoints": [
            200.0,
            245,
            440.0,
            245
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
            "obj-2",
            0
          ],
          "order": 0,
          "midpoints": [
            479.5,
            265,
            704.0,
            265
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
            "obj-30",
            1
          ],
          "order": 0,
          "midpoints": [
            45.0,
            600,
            323.0,
            600
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
            "obj-30",
            2
          ],
          "order": 0,
          "midpoints": [
            120.0,
            600,
            362.0,
            600
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
            "obj-31",
            0
          ],
          "order": 0,
          "midpoints": [
            323.0,
            637,
            284.0,
            637
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
            "obj-10",
            0
          ],
          "order": 0,
          "midpoints": [
            330.0,
            635,
            404.0,
            635
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
            "obj-1",
            0
          ],
          "order": 0,
          "midpoints": [
            522.0,
            88,
            550.0,
            88
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
            "obj-24",
            2
          ],
          "order": 0,
          "midpoints": [
            920.0,
            87.0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-1",
            1
          ],
          "destination": [
            "obj-20",
            0
          ],
          "order": 0,
          "midpoints": [
            640.0,
            122.0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-1",
            1
          ],
          "destination": [
            "obj-19",
            0
          ],
          "order": 0,
          "midpoints": [
            640.0,
            122.0
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
            "obj-4",
            0
          ],
          "order": 0,
          "midpoints": [
            640.0,
            10,
            800.0,
            10
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
          "order": 0,
          "midpoints": [
            640.0,
            178,
            860.0,
            178
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
            "obj-38",
            0
          ],
          "order": 0,
          "midpoints": [
            45.0,
            267,
            160.0,
            267
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
            "obj-12",
            0
          ],
          "order": 0,
          "midpoints": [
            160.0,
            267,
            282.0,
            267
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
            0
          ],
          "order": 0,
          "midpoints": [
            45.0,
            357,
            84.0,
            357
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
            "obj-13",
            0
          ],
          "order": 0,
          "midpoints": [
            157.5,
            357,
            282.0,
            357
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
            0
          ],
          "order": 0,
          "midpoints": [
            360.0,
            357,
            404.0,
            357
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
            "obj-14",
            0
          ],
          "order": 0,
          "midpoints": [
            460.0,
            357,
            562.0,
            357
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
            "obj-44",
            0
          ],
          "order": 0,
          "midpoints": [
            444.0,
            432,
            544.0,
            432
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
            "obj-6",
            0
          ],
          "order": 0,
          "midpoints": [
            540.0,
            485,
            700.0,
            485
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
          ],
          "order": 0,
          "midpoints": [
            45.0,
            520,
            84.0,
            520
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
            "obj-15",
            0
          ],
          "order": 0,
          "midpoints": [
            144.0,
            520,
            282.0,
            520
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
          ],
          "order": 0,
          "midpoints": [
            45.0,
            710,
            84.0,
            710
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
            "obj-17",
            0
          ],
          "order": 0,
          "midpoints": [
            140.0,
            710,
            282.0,
            710
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
            "obj-52",
            0
          ],
          "order": 0,
          "midpoints": [
            61.0,
            857,
            175.0,
            857
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-52",
            9
          ],
          "destination": [
            "obj-53",
            0
          ],
          "order": 0,
          "midpoints": [
            267.9,
            893,
            243.0,
            893
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
            "obj-2",
            0
          ],
          "order": 0,
          "midpoints": [
            952,
            929.0,
            952,
            267.0,
            704.0,
            267.0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-52",
            8
          ],
          "destination": [
            "obj-54",
            0
          ],
          "order": 0,
          "midpoints": [
            241.4,
            893,
            230.0,
            893
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
            "obj-36",
            0
          ],
          "order": 0,
          "midpoints": [
            928,
            929.0,
            928,
            57.0,
            825.0,
            57.0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-52",
            7
          ],
          "destination": [
            "obj-55",
            0
          ],
          "order": 0,
          "midpoints": [
            214.8,
            893,
            206.0,
            893
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
            "obj-49",
            0
          ],
          "order": 0,
          "midpoints": [
            992,
            929.0,
            992,
            600.0,
            45.0,
            600.0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-52",
            6
          ],
          "destination": [
            "obj-56",
            0
          ],
          "order": 0,
          "midpoints": [
            188.3,
            893,
            175.0,
            893
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
            "obj-50",
            0
          ],
          "order": 0,
          "midpoints": [
            1000,
            929.0,
            1000,
            600.0,
            120.0,
            600.0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-52",
            5
          ],
          "destination": [
            "obj-57",
            0
          ],
          "order": 0,
          "midpoints": [
            161.7,
            893,
            148.0,
            893
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
            "obj-16",
            0
          ],
          "order": 0,
          "midpoints": [
            984,
            929.0,
            984,
            522.0,
            422.0,
            522.0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-52",
            4
          ],
          "destination": [
            "obj-58",
            0
          ],
          "order": 0,
          "midpoints": [
            135.2,
            893,
            124.0,
            893
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
            "obj-37",
            0
          ],
          "order": 0,
          "midpoints": [
            944,
            929.0,
            944,
            257.0,
            45.0,
            257.0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-52",
            3
          ],
          "destination": [
            "obj-59",
            0
          ],
          "order": 0,
          "midpoints": [
            108.6,
            893,
            93.0,
            893
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
            "obj-47",
            0
          ],
          "order": 0,
          "midpoints": [
            1008,
            929.0,
            1008,
            700.0,
            45.0,
            700.0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-52",
            2
          ],
          "destination": [
            "obj-60",
            0
          ],
          "order": 0,
          "midpoints": [
            82.1,
            893,
            66.0,
            893
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
            "obj-39",
            0
          ],
          "order": 0,
          "midpoints": [
            960,
            929.0,
            960,
            347.0,
            45.0,
            347.0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-52",
            1
          ],
          "destination": [
            "obj-61",
            0
          ],
          "order": 0,
          "midpoints": [
            55.5,
            893,
            40.0,
            893
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
            "obj-45",
            0
          ],
          "order": 0,
          "midpoints": [
            976,
            929.0,
            976,
            510.0,
            45.0,
            510.0
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
            "obj-62",
            0
          ],
          "order": 0,
          "midpoints": [
            29.0,
            893,
            68.5,
            893
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
            "obj-24",
            1
          ],
          "order": 0,
          "midpoints": [
            936,
            929.0,
            936,
            97.0,
            860.0,
            97.0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-52",
            11
          ],
          "destination": [
            "obj-73",
            0
          ],
          "order": 0,
          "midpoints": [
            321.0,
            893,
            185.0,
            893
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-73",
            0
          ],
          "destination": [
            "obj-26",
            0
          ],
          "order": 0,
          "midpoints": [
            920,
            929.0,
            920,
            17.0,
            300.0,
            17.0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-52",
            10
          ],
          "destination": [
            "obj-72",
            0
          ],
          "order": 0,
          "midpoints": [
            294.5,
            893,
            283.0,
            893
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-72",
            0
          ],
          "destination": [
            "obj-43",
            0
          ],
          "order": 0,
          "midpoints": [
            968,
            929.0,
            968,
            434.0,
            480.0,
            434.0
          ]
        }
      }
    ],
    "dependency_cache": [],
    "autosave": 0
  }
}