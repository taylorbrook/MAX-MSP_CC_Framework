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
            475.0,
            152.0,
            121.0,
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
            1621.0,
            152.0,
            121.0,
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
            2712.0,
            30.0,
            107.0,
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
            892.0,
            30.0,
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
            1812.0,
            152.0,
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
            1982.0,
            152.0,
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
            2145.0,
            30.0,
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
            2287.0,
            30.0,
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
            2397.0,
            30.0,
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
            1982.0,
            30.0,
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
            2507.0,
            30.0,
            135.0,
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
            1146.0,
            152.0,
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
            1146.0,
            396.0,
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
            475.0,
            274.0,
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
            1146.0,
            518.0,
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
            680.0,
            676.0,
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
            1146.0,
            274.0,
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
            2507.0,
            152.0,
            15.0,
            100.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            375,
            90,
            20,
            265
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
            680.0,
            274.0,
            135.0,
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
            680.0,
            152.0,
            93.0,
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
            30.0,
            30.0,
            100.0,
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
            200.0,
            30.0,
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
            475.0,
            30.0,
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
            892.0,
            152.0,
            135.0,
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
            680.0,
            30.0,
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
            1146.0,
            5.0,
            200.0,
            100.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            5,
            250,
            390,
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
            1146.0,
            30.0,
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
            1309.0,
            30.0,
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
            1472.0,
            30.0,
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
            1621.0,
            30.0,
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
            1812.0,
            30.0,
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
            1472.0,
            152.0,
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
            2712.0,
            152.0,
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
            200.0,
            78.0,
            24.0,
            24.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            5,
            65,
            50,
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
            200.0,
            152.0,
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
            892.0,
            80.0,
            50.0,
            22.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            60,
            65,
            100,
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
            892.0,
            184.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            5,
            105,
            55,
            55
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
            892.0,
            274.0,
            184.0,
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
            892.0,
            428.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            65,
            105,
            55,
            55
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
            892.0,
            518.0,
            170.0,
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
            200.0,
            184.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            125,
            105,
            55,
            55
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
            200.0,
            274.0,
            135.0,
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
            200.0,
            324.0,
            100.0,
            22.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            185,
            105,
            55,
            20
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
            200.0,
            396.0,
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
            892.0,
            550.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            245,
            105,
            55,
            55
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
            892.0,
            640.0,
            142.0,
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
            892.0,
            306.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            305,
            105,
            55,
            55
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
            892.0,
            396.0,
            135.0,
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
            680.0,
            396.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            5,
            185,
            55,
            55
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
            680.0,
            536.0,
            40.0,
            40.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            65,
            185,
            55,
            55
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
            30.0,
            152.0,
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
            200.0,
            518.0,
            205.0,
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
            475.0,
            396.0,
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
            475.0,
            518.0,
            40.0,
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
            475.0,
            640.0,
            40.0,
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
            475.0,
            762.0,
            40.0,
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
            475.0,
            884.0,
            40.0,
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
            475.0,
            1006.0,
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
          "id": "obj-59",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            475.0,
            1128.0,
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
            475.0,
            1250.0,
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
            475.0,
            1372.0,
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
            475.0,
            1494.0,
            135.0,
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
            2712.0,
            274.0,
            51.0,
            20.0
          ],
          "text": "Pitch",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            5,
            90,
            55,
            18
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
            2712.0,
            394.0,
            58.0,
            20.0
          ],
          "text": "Cutoff",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            65,
            90,
            55,
            18
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
            2712.0,
            514.0,
            44.0,
            20.0
          ],
          "text": "Reso",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            125,
            90,
            55,
            18
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
            2712.0,
            634.0,
            44.0,
            20.0
          ],
          "text": "Type",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            185,
            90,
            55,
            18
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
            2712.0,
            754.0,
            51.0,
            20.0
          ],
          "text": "Degrd",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            245,
            90,
            55,
            18
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
            2712.0,
            874.0,
            40.0,
            20.0
          ],
          "text": "Vol",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            305,
            90,
            55,
            18
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
            2712.0,
            994.0,
            40.0,
            20.0
          ],
          "text": "Atk",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            5,
            170,
            55,
            18
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
            2712.0,
            1114.0,
            40.0,
            20.0
          ],
          "text": "Dec",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            65,
            170,
            55,
            18
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
            2712.0,
            1234.0,
            100.0,
            20.0
          ],
          "text": "Step Pattern",
          "fontname": "Arial",
          "fontsize": 12.0,
          "presentation": 1,
          "presentation_rect": [
            5,
            335,
            390,
            20
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
            500.0,
            560.0,
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
            560.0,
            560.0,
            290.0,
            22.0
          ],
          "text": "127 127 127 127 127 127 127 127 127 127 127 127 127 127 127 127",
          "fontname": "Arial",
          "fontsize": 12.0
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
            "obj-5",
            1
          ],
          "destination": [
            "obj-6",
            2
          ],
          "order": 0
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
          "order": 0
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
            "obj-10",
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
            "obj-17",
            0
          ],
          "destination": [
            "obj-9",
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
            "obj-5",
            2
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
            "obj-7",
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
            "obj-7",
            2
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
            "obj-23",
            1
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
            "obj-24",
            0
          ],
          "destination": [
            "obj-2",
            1
          ],
          "order": 0
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
            "obj-28",
            1
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
            "obj-28",
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
            "obj-2",
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
            "obj-30",
            1
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
            "obj-30",
            2
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
            "obj-31",
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
            "obj-24",
            2
          ],
          "order": 0
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
          "order": 0
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
            "obj-4",
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
            "obj-24",
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
            "obj-12",
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
            "obj-13",
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
            "obj-42",
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
            "obj-14",
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
            "obj-44",
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
            "obj-15",
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
            "obj-48",
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
            "obj-17",
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
            9
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
            "obj-53",
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
            "obj-52",
            8
          ],
          "destination": [
            "obj-54",
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
            "obj-36",
            0
          ],
          "order": 0
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
            "obj-49",
            0
          ],
          "order": 0
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
            "obj-50",
            0
          ],
          "order": 0
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
            "obj-16",
            0
          ],
          "order": 0
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
            "obj-37",
            0
          ],
          "order": 0
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
            "obj-47",
            0
          ],
          "order": 0
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
            "obj-39",
            0
          ],
          "order": 0
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
            "obj-45",
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
            "obj-24",
            1
          ],
          "order": 0
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
            "obj-26",
            0
          ],
          "order": 0
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
            "obj-43",
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