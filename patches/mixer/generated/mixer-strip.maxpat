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
      630.0,
      632.0
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
          "id": "obj-43",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            0,
            0,
            80,
            500
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            0.0,
            0.0,
            80.0,
            500.0
          ],
          "background": 1,
          "ignoreclick": 1,
          "border": 0,
          "rounded": 7,
          "mode": 0,
          "bgfillcolor": {
            "type": "gradient",
            "color1": [
              0.94,
              0.94,
              0.96,
              1.0
            ],
            "color2": [
              0.88,
              0.89,
              0.92,
              1.0
            ],
            "color": [
              0.94,
              0.94,
              0.96,
              1.0
            ],
            "angle": 270.0,
            "proportion": 0.39,
            "autogradient": 0
          }
        }
      },
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
            30,
            20,
            30.0,
            30.0
          ],
          "parameter_enable": 0
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
            100,
            20,
            30.0,
            30.0
          ],
          "parameter_enable": 0
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
            240,
            20,
            30.0,
            30.0
          ],
          "parameter_enable": 0
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
            300,
            20,
            30.0,
            30.0
          ],
          "parameter_enable": 0
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
            55,
            20,
            65.0,
            20.0
          ],
          "text": "Audio L",
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
            125,
            20,
            65.0,
            20.0
          ],
          "text": "Audio R",
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
            265,
            20,
            79.0,
            20.0
          ],
          "text": "Ins Ret L",
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
            325,
            20,
            79.0,
            20.0
          ],
          "text": "Ins Ret R",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "dial",
          "id": "obj-9",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            200,
            50,
            36.0,
            36.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            24.0,
            24.0,
            36.0,
            36.0
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-10",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            250,
            60,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 2.",
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
            30,
            60,
            42.0,
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
          "id": "obj-12",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            100,
            60,
            42.0,
            22.0
          ],
          "text": "*~ 1.",
          "fontname": "Arial",
          "fontsize": 12.0
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
            200,
            110,
            24.0,
            24.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            30.0,
            64.0,
            20.0,
            20.0
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-14",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            240,
            110,
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
          "id": "obj-15",
          "numinlets": 3,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            30,
            110,
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
          "id": "obj-16",
          "numinlets": 3,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            100,
            110,
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
          "maxclass": "gain~",
          "id": "obj-17",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            "signal"
          ],
          "patching_rect": [
            200.0,
            165.0,
            36.0,
            130.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            22.0,
            100.0,
            36.0,
            220.0
          ]
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
            100,
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
          "maxclass": "dial",
          "id": "obj-19",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            200,
            320,
            36.0,
            36.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            24.0,
            326.0,
            36.0,
            36.0
          ]
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-20",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            250,
            320,
            40.5,
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
          "id": "obj-21",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            250,
            345,
            36.0,
            22.0
          ],
          "text": "t f f",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-22",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            250,
            370,
            32.5,
            22.0
          ],
          "text": "!- 1.",
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
            30,
            345,
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
            100,
            345,
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
          "maxclass": "toggle",
          "id": "obj-25",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            200,
            390,
            24.0,
            24.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            24.0,
            370.0,
            20.0,
            20.0
          ]
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
            240,
            390,
            32.5,
            22.0
          ],
          "text": "!- 1",
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
            30,
            390,
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
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            100,
            390,
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
          "maxclass": "meter~",
          "id": "obj-29",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            30.0,
            435.0,
            24.0,
            80.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            8.0,
            400.0,
            28.0,
            90.0
          ]
        }
      },
      {
        "box": {
          "maxclass": "meter~",
          "id": "obj-30",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            100.0,
            435.0,
            24.0,
            80.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            44.0,
            400.0,
            28.0,
            90.0
          ]
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
            200,
            435,
            88.0,
            22.0
          ],
          "text": "send~ master-L",
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
            200,
            460,
            88.0,
            22.0
          ],
          "text": "send~ master-R",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "outlet",
          "id": "obj-33",
          "numinlets": 2,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            30,
            530,
            30.0,
            30.0
          ],
          "parameter_enable": 0
        }
      },
      {
        "box": {
          "maxclass": "outlet",
          "id": "obj-34",
          "numinlets": 2,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            100,
            530,
            30.0,
            30.0
          ],
          "parameter_enable": 0
        }
      },
      {
        "box": {
          "maxclass": "outlet",
          "id": "obj-35",
          "numinlets": 2,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            200,
            530,
            30.0,
            30.0
          ],
          "parameter_enable": 0
        }
      },
      {
        "box": {
          "maxclass": "outlet",
          "id": "obj-36",
          "numinlets": 2,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            260,
            530,
            30.0,
            30.0
          ],
          "parameter_enable": 0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-37",
          "numinlets": 6,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            30.0,
            570.0,
            200.0,
            22.0
          ],
          "parameter_enable": 0,
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
              1275.0,
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
                    30,
                    15,
                    30.0,
                    30.0
                  ],
                  "parameter_enable": 0
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
                    60,
                    15,
                    51.0,
                    20.0
                  ],
                  "text": "Pre L",
                  "fontname": "Arial",
                  "fontsize": 12.0
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
                    216,
                    15,
                    30.0,
                    30.0
                  ],
                  "parameter_enable": 0
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
                    246,
                    15,
                    51.0,
                    20.0
                  ],
                  "text": "Pre R",
                  "fontname": "Arial",
                  "fontsize": 12.0
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
                    402,
                    15,
                    30.0,
                    30.0
                  ],
                  "parameter_enable": 0
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
                    432,
                    15,
                    79.0,
                    20.0
                  ],
                  "text": "PostFdr L",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "inlet",
                  "id": "obj-7",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    588,
                    15,
                    30.0,
                    30.0
                  ],
                  "parameter_enable": 0
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
                    618,
                    15,
                    79.0,
                    20.0
                  ],
                  "text": "PostFdr R",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "inlet",
                  "id": "obj-9",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    774,
                    15,
                    30.0,
                    30.0
                  ],
                  "parameter_enable": 0
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
                    804,
                    15,
                    79.0,
                    20.0
                  ],
                  "text": "PostPan L",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "inlet",
                  "id": "obj-11",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    960,
                    15,
                    30.0,
                    30.0
                  ],
                  "parameter_enable": 0
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
                    990,
                    15,
                    79.0,
                    20.0
                  ],
                  "text": "PostPan R",
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
                    30,
                    55,
                    58.0,
                    20.0
                  ],
                  "text": "Send 1",
                  "fontname": "Arial",
                  "fontsize": 12.0,
                  "fontface": 1,
                  "textcolor": [
                    0.3,
                    0.3,
                    0.35,
                    1.0
                  ]
                }
              },
              {
                "box": {
                  "maxclass": "umenu",
                  "id": "obj-14",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    30,
                    80,
                    90.0,
                    22.0
                  ],
                  "parameter_enable": 0,
                  "items": [
                    "Pre-Fader",
                    ",",
                    "Post-Fader",
                    ",",
                    "Post-Pan"
                  ]
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-15",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    30,
                    110,
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
                  "maxclass": "dial",
                  "id": "obj-16",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    80,
                    80,
                    34.0,
                    34.0
                  ],
                  "parameter_enable": 0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-17",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    80,
                    120,
                    40.5,
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
                  "id": "obj-18",
                  "numinlets": 4,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    30,
                    150,
                    160.0,
                    22.0
                  ],
                  "text": "selector~ 3",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-19",
                  "numinlets": 4,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    95,
                    150,
                    160.0,
                    22.0
                  ],
                  "text": "selector~ 3",
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
                    30,
                    185,
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
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    95,
                    185,
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
                  "id": "obj-22",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    30,
                    215,
                    88.0,
                    22.0
                  ],
                  "text": "send~ bus-1-L",
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
                    95,
                    215,
                    88.0,
                    22.0
                  ],
                  "text": "send~ bus-1-R",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "comment",
                  "id": "obj-24",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    170,
                    55,
                    58.0,
                    20.0
                  ],
                  "text": "Send 2",
                  "fontname": "Arial",
                  "fontsize": 12.0,
                  "fontface": 1,
                  "textcolor": [
                    0.3,
                    0.3,
                    0.35,
                    1.0
                  ]
                }
              },
              {
                "box": {
                  "maxclass": "umenu",
                  "id": "obj-25",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    170,
                    80,
                    90.0,
                    22.0
                  ],
                  "parameter_enable": 0,
                  "items": [
                    "Pre-Fader",
                    ",",
                    "Post-Fader",
                    ",",
                    "Post-Pan"
                  ]
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
                    170,
                    110,
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
                  "maxclass": "dial",
                  "id": "obj-27",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    220,
                    80,
                    34.0,
                    34.0
                  ],
                  "parameter_enable": 0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-28",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    220,
                    120,
                    40.5,
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
                  "id": "obj-29",
                  "numinlets": 4,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    170,
                    150,
                    160.0,
                    22.0
                  ],
                  "text": "selector~ 3",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-30",
                  "numinlets": 4,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    235,
                    150,
                    160.0,
                    22.0
                  ],
                  "text": "selector~ 3",
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
                    170,
                    185,
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
                  "id": "obj-32",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    235,
                    185,
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
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    170,
                    215,
                    88.0,
                    22.0
                  ],
                  "text": "send~ bus-2-L",
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
                    235,
                    215,
                    88.0,
                    22.0
                  ],
                  "text": "send~ bus-2-R",
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
                    310,
                    55,
                    58.0,
                    20.0
                  ],
                  "text": "Send 3",
                  "fontname": "Arial",
                  "fontsize": 12.0,
                  "fontface": 1,
                  "textcolor": [
                    0.3,
                    0.3,
                    0.35,
                    1.0
                  ]
                }
              },
              {
                "box": {
                  "maxclass": "umenu",
                  "id": "obj-36",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    310,
                    80,
                    90.0,
                    22.0
                  ],
                  "parameter_enable": 0,
                  "items": [
                    "Pre-Fader",
                    ",",
                    "Post-Fader",
                    ",",
                    "Post-Pan"
                  ]
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-37",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    310,
                    110,
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
                  "maxclass": "dial",
                  "id": "obj-38",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    360,
                    80,
                    34.0,
                    34.0
                  ],
                  "parameter_enable": 0
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
                    360,
                    120,
                    40.5,
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
                  "id": "obj-40",
                  "numinlets": 4,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    310,
                    150,
                    160.0,
                    22.0
                  ],
                  "text": "selector~ 3",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-41",
                  "numinlets": 4,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    375,
                    150,
                    160.0,
                    22.0
                  ],
                  "text": "selector~ 3",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-42",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    310,
                    185,
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
                  "id": "obj-43",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    375,
                    185,
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
                  "id": "obj-44",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    310,
                    215,
                    88.0,
                    22.0
                  ],
                  "text": "send~ bus-3-L",
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
                    375,
                    215,
                    88.0,
                    22.0
                  ],
                  "text": "send~ bus-3-R",
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
                    450,
                    55,
                    58.0,
                    20.0
                  ],
                  "text": "Send 4",
                  "fontname": "Arial",
                  "fontsize": 12.0,
                  "fontface": 1,
                  "textcolor": [
                    0.3,
                    0.3,
                    0.35,
                    1.0
                  ]
                }
              },
              {
                "box": {
                  "maxclass": "umenu",
                  "id": "obj-47",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    450,
                    80,
                    90.0,
                    22.0
                  ],
                  "parameter_enable": 0,
                  "items": [
                    "Pre-Fader",
                    ",",
                    "Post-Fader",
                    ",",
                    "Post-Pan"
                  ]
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-48",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    450,
                    110,
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
                  "maxclass": "dial",
                  "id": "obj-49",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    500,
                    80,
                    34.0,
                    34.0
                  ],
                  "parameter_enable": 0
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
                    500,
                    120,
                    40.5,
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
                  "id": "obj-51",
                  "numinlets": 4,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    450,
                    150,
                    160.0,
                    22.0
                  ],
                  "text": "selector~ 3",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-52",
                  "numinlets": 4,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    515,
                    150,
                    160.0,
                    22.0
                  ],
                  "text": "selector~ 3",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-53",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    450,
                    185,
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
                  "id": "obj-54",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    515,
                    185,
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
                  "id": "obj-55",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    450,
                    215,
                    88.0,
                    22.0
                  ],
                  "text": "send~ bus-4-L",
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
                    515,
                    215,
                    88.0,
                    22.0
                  ],
                  "text": "send~ bus-4-R",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "comment",
                  "id": "obj-57",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    590,
                    55,
                    58.0,
                    20.0
                  ],
                  "text": "Send 5",
                  "fontname": "Arial",
                  "fontsize": 12.0,
                  "fontface": 1,
                  "textcolor": [
                    0.3,
                    0.3,
                    0.35,
                    1.0
                  ]
                }
              },
              {
                "box": {
                  "maxclass": "umenu",
                  "id": "obj-58",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    590,
                    80,
                    90.0,
                    22.0
                  ],
                  "parameter_enable": 0,
                  "items": [
                    "Pre-Fader",
                    ",",
                    "Post-Fader",
                    ",",
                    "Post-Pan"
                  ]
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-59",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    590,
                    110,
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
                  "maxclass": "dial",
                  "id": "obj-60",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    640,
                    80,
                    34.0,
                    34.0
                  ],
                  "parameter_enable": 0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-61",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    640,
                    120,
                    40.5,
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
                  "id": "obj-62",
                  "numinlets": 4,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    590,
                    150,
                    160.0,
                    22.0
                  ],
                  "text": "selector~ 3",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-63",
                  "numinlets": 4,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    655,
                    150,
                    160.0,
                    22.0
                  ],
                  "text": "selector~ 3",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-64",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    590,
                    185,
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
                  "id": "obj-65",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    655,
                    185,
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
                  "id": "obj-66",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    590,
                    215,
                    88.0,
                    22.0
                  ],
                  "text": "send~ bus-5-L",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-67",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    655,
                    215,
                    88.0,
                    22.0
                  ],
                  "text": "send~ bus-5-R",
                  "fontname": "Arial",
                  "fontsize": 12.0
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
                    730,
                    55,
                    58.0,
                    20.0
                  ],
                  "text": "Send 6",
                  "fontname": "Arial",
                  "fontsize": 12.0,
                  "fontface": 1,
                  "textcolor": [
                    0.3,
                    0.3,
                    0.35,
                    1.0
                  ]
                }
              },
              {
                "box": {
                  "maxclass": "umenu",
                  "id": "obj-69",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    730,
                    80,
                    90.0,
                    22.0
                  ],
                  "parameter_enable": 0,
                  "items": [
                    "Pre-Fader",
                    ",",
                    "Post-Fader",
                    ",",
                    "Post-Pan"
                  ]
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-70",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    730,
                    110,
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
                  "maxclass": "dial",
                  "id": "obj-71",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    780,
                    80,
                    34.0,
                    34.0
                  ],
                  "parameter_enable": 0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-72",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    780,
                    120,
                    40.5,
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
                  "id": "obj-73",
                  "numinlets": 4,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    730,
                    150,
                    160.0,
                    22.0
                  ],
                  "text": "selector~ 3",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-74",
                  "numinlets": 4,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    795,
                    150,
                    160.0,
                    22.0
                  ],
                  "text": "selector~ 3",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-75",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    730,
                    185,
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
                  "id": "obj-76",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    795,
                    185,
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
                  "id": "obj-77",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    730,
                    215,
                    88.0,
                    22.0
                  ],
                  "text": "send~ bus-6-L",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-78",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    795,
                    215,
                    88.0,
                    22.0
                  ],
                  "text": "send~ bus-6-R",
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
                    870,
                    55,
                    58.0,
                    20.0
                  ],
                  "text": "Send 7",
                  "fontname": "Arial",
                  "fontsize": 12.0,
                  "fontface": 1,
                  "textcolor": [
                    0.3,
                    0.3,
                    0.35,
                    1.0
                  ]
                }
              },
              {
                "box": {
                  "maxclass": "umenu",
                  "id": "obj-80",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    870,
                    80,
                    90.0,
                    22.0
                  ],
                  "parameter_enable": 0,
                  "items": [
                    "Pre-Fader",
                    ",",
                    "Post-Fader",
                    ",",
                    "Post-Pan"
                  ]
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-81",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    870,
                    110,
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
                  "maxclass": "dial",
                  "id": "obj-82",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    920,
                    80,
                    34.0,
                    34.0
                  ],
                  "parameter_enable": 0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-83",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    920,
                    120,
                    40.5,
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
                  "id": "obj-84",
                  "numinlets": 4,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    870,
                    150,
                    160.0,
                    22.0
                  ],
                  "text": "selector~ 3",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-85",
                  "numinlets": 4,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    935,
                    150,
                    160.0,
                    22.0
                  ],
                  "text": "selector~ 3",
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
                    "signal"
                  ],
                  "patching_rect": [
                    870,
                    185,
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
                  "id": "obj-87",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    935,
                    185,
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
                  "id": "obj-88",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    870,
                    215,
                    88.0,
                    22.0
                  ],
                  "text": "send~ bus-7-L",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-89",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    935,
                    215,
                    88.0,
                    22.0
                  ],
                  "text": "send~ bus-7-R",
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
                    1010,
                    55,
                    58.0,
                    20.0
                  ],
                  "text": "Send 8",
                  "fontname": "Arial",
                  "fontsize": 12.0,
                  "fontface": 1,
                  "textcolor": [
                    0.3,
                    0.3,
                    0.35,
                    1.0
                  ]
                }
              },
              {
                "box": {
                  "maxclass": "umenu",
                  "id": "obj-91",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "outlettype": [
                    "",
                    "",
                    ""
                  ],
                  "patching_rect": [
                    1010,
                    80,
                    90.0,
                    22.0
                  ],
                  "parameter_enable": 0,
                  "items": [
                    "Pre-Fader",
                    ",",
                    "Post-Fader",
                    ",",
                    "Post-Pan"
                  ]
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
                    1010,
                    110,
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
                  "maxclass": "dial",
                  "id": "obj-93",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    1060,
                    80,
                    34.0,
                    34.0
                  ],
                  "parameter_enable": 0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-94",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    ""
                  ],
                  "patching_rect": [
                    1060,
                    120,
                    40.5,
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
                  "id": "obj-95",
                  "numinlets": 4,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    1010,
                    150,
                    160.0,
                    22.0
                  ],
                  "text": "selector~ 3",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-96",
                  "numinlets": 4,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    1075,
                    150,
                    160.0,
                    22.0
                  ],
                  "text": "selector~ 3",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              },
              {
                "box": {
                  "maxclass": "newobj",
                  "id": "obj-97",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    1010,
                    185,
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
                  "id": "obj-98",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "outlettype": [
                    "signal"
                  ],
                  "patching_rect": [
                    1075,
                    185,
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
                  "id": "obj-99",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "outlettype": [],
                  "patching_rect": [
                    1010,
                    215,
                    88.0,
                    22.0
                  ],
                  "text": "send~ bus-8-L",
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
                    1075,
                    215,
                    88.0,
                    22.0
                  ],
                  "text": "send~ bus-8-R",
                  "fontname": "Arial",
                  "fontsize": 12.0
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "source": [
                    "obj-14",
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
                    "obj-18",
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
                    "obj-19",
                    0
                  ],
                  "midpoints": [
                    46.25,
                    141.0,
                    102.0,
                    141.0
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
                    "obj-17",
                    0
                  ],
                  "destination": [
                    "obj-20",
                    1
                  ],
                  "midpoints": [
                    100.25,
                    163.5,
                    65.0,
                    163.5
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
                    "obj-21",
                    1
                  ],
                  "midpoints": [
                    100.25,
                    163.5,
                    130.0,
                    163.5
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
                    "obj-18",
                    1
                  ],
                  "midpoints": [
                    45.0,
                    97.5,
                    85.66666666666666,
                    97.5
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
                    "obj-18",
                    2
                  ],
                  "midpoints": [
                    417.0,
                    97.5,
                    134.33333333333331,
                    97.5
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
                    3
                  ],
                  "midpoints": [
                    789.0,
                    97.5,
                    183.0,
                    97.5
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
                    "obj-19",
                    1
                  ],
                  "midpoints": [
                    231.0,
                    97.5,
                    150.66666666666666,
                    97.5
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
                    "obj-19",
                    2
                  ],
                  "midpoints": [
                    603.0,
                    97.5,
                    199.33333333333331,
                    97.5
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
                    "obj-19",
                    3
                  ],
                  "midpoints": [
                    975.0,
                    97.5,
                    248.0,
                    97.5
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
                    0
                  ],
                  "midpoints": [
                    110.0,
                    178.5,
                    37.0,
                    178.5
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
                    "obj-21",
                    0
                  ],
                  "midpoints": [
                    175.0,
                    178.5,
                    102.0,
                    178.5
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
                    0
                  ],
                  "midpoints": [
                    51.0,
                    211.0,
                    74.0,
                    211.0
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
                    0
                  ],
                  "midpoints": [
                    116.0,
                    211.0,
                    139.0,
                    211.0
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
                    "obj-29",
                    0
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
                    "obj-30",
                    0
                  ],
                  "midpoints": [
                    186.25,
                    141.0,
                    242.0,
                    141.0
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
                    "obj-31",
                    1
                  ],
                  "midpoints": [
                    240.25,
                    163.5,
                    205.0,
                    163.5
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
                    1
                  ],
                  "midpoints": [
                    240.25,
                    163.5,
                    270.0,
                    163.5
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
                    "obj-29",
                    1
                  ],
                  "midpoints": [
                    45.0,
                    97.5,
                    225.66666666666666,
                    97.5
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
                    "obj-29",
                    2
                  ],
                  "midpoints": [
                    417.0,
                    97.5,
                    274.3333333333333,
                    97.5
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
                    "obj-29",
                    3
                  ],
                  "midpoints": [
                    789.0,
                    97.5,
                    323.0,
                    97.5
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
                    "obj-30",
                    1
                  ],
                  "midpoints": [
                    231.0,
                    97.5,
                    290.6666666666667,
                    97.5
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
                    "obj-30",
                    2
                  ],
                  "midpoints": [
                    603.0,
                    97.5,
                    339.3333333333333,
                    97.5
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
                    "obj-30",
                    3
                  ],
                  "midpoints": [
                    975.0,
                    97.5,
                    388.0,
                    97.5
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
                    "obj-31",
                    0
                  ],
                  "midpoints": [
                    250.0,
                    178.5,
                    177.0,
                    178.5
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
                    "obj-32",
                    0
                  ],
                  "midpoints": [
                    315.0,
                    178.5,
                    242.0,
                    178.5
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
                    "obj-33",
                    0
                  ],
                  "midpoints": [
                    191.0,
                    211.0,
                    214.0,
                    211.0
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
                  ],
                  "midpoints": [
                    256.0,
                    211.0,
                    279.0,
                    211.0
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
                    "obj-40",
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
                    "obj-41",
                    0
                  ],
                  "midpoints": [
                    326.25,
                    141.0,
                    382.0,
                    141.0
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
                    "obj-42",
                    1
                  ],
                  "midpoints": [
                    380.25,
                    163.5,
                    345.0,
                    163.5
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
                    "obj-43",
                    1
                  ],
                  "midpoints": [
                    380.25,
                    163.5,
                    410.0,
                    163.5
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
                    "obj-40",
                    1
                  ],
                  "midpoints": [
                    45.0,
                    97.5,
                    365.6666666666667,
                    97.5
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
                    "obj-40",
                    2
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
                    "obj-40",
                    3
                  ],
                  "midpoints": [
                    789.0,
                    97.5,
                    463.0,
                    97.5
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
                    "obj-41",
                    1
                  ],
                  "midpoints": [
                    231.0,
                    97.5,
                    430.6666666666667,
                    97.5
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
                    "obj-41",
                    2
                  ],
                  "midpoints": [
                    603.0,
                    97.5,
                    479.3333333333333,
                    97.5
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
                    "obj-41",
                    3
                  ],
                  "midpoints": [
                    975.0,
                    97.5,
                    528.0,
                    97.5
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
                    "obj-42",
                    0
                  ],
                  "midpoints": [
                    390.0,
                    178.5,
                    317.0,
                    178.5
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
                    "obj-43",
                    0
                  ],
                  "midpoints": [
                    455.0,
                    178.5,
                    382.0,
                    178.5
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
                  ],
                  "midpoints": [
                    331.0,
                    211.0,
                    354.0,
                    211.0
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
                    "obj-45",
                    0
                  ],
                  "midpoints": [
                    396.0,
                    211.0,
                    419.0,
                    211.0
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
                    "obj-48",
                    0
                  ],
                  "destination": [
                    "obj-52",
                    0
                  ],
                  "midpoints": [
                    466.25,
                    141.0,
                    522.0,
                    141.0
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
                    "obj-50",
                    0
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
                    "obj-53",
                    1
                  ],
                  "midpoints": [
                    520.25,
                    163.5,
                    485.0,
                    163.5
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
                    "obj-54",
                    1
                  ],
                  "midpoints": [
                    520.25,
                    163.5,
                    550.0,
                    163.5
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
                    "obj-51",
                    1
                  ],
                  "midpoints": [
                    45.0,
                    97.5,
                    505.6666666666667,
                    97.5
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
                    "obj-51",
                    2
                  ],
                  "midpoints": [
                    417.0,
                    97.5,
                    554.3333333333334,
                    97.5
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
                    "obj-51",
                    3
                  ],
                  "midpoints": [
                    789.0,
                    97.5,
                    603.0,
                    97.5
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
                    "obj-52",
                    1
                  ],
                  "midpoints": [
                    231.0,
                    97.5,
                    570.6666666666666,
                    97.5
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
                    "obj-52",
                    2
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
                    "obj-52",
                    3
                  ],
                  "midpoints": [
                    975.0,
                    97.5,
                    668.0,
                    97.5
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
                    "obj-53",
                    0
                  ],
                  "midpoints": [
                    530.0,
                    178.5,
                    457.0,
                    178.5
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
                    "obj-54",
                    0
                  ],
                  "midpoints": [
                    595.0,
                    178.5,
                    522.0,
                    178.5
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
                    "obj-55",
                    0
                  ],
                  "midpoints": [
                    471.0,
                    211.0,
                    494.0,
                    211.0
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
                    "obj-56",
                    0
                  ],
                  "midpoints": [
                    536.0,
                    211.0,
                    559.0,
                    211.0
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
                    "obj-62",
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
                    "obj-63",
                    0
                  ],
                  "midpoints": [
                    606.25,
                    141.0,
                    662.0,
                    141.0
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
                    "obj-64",
                    1
                  ],
                  "midpoints": [
                    660.25,
                    163.5,
                    625.0,
                    163.5
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
                    "obj-65",
                    1
                  ],
                  "midpoints": [
                    660.25,
                    163.5,
                    690.0,
                    163.5
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
                    "obj-62",
                    1
                  ],
                  "midpoints": [
                    45.0,
                    97.5,
                    645.6666666666666,
                    97.5
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
                    "obj-62",
                    2
                  ],
                  "midpoints": [
                    417.0,
                    97.5,
                    694.3333333333334,
                    97.5
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
                    "obj-62",
                    3
                  ],
                  "midpoints": [
                    789.0,
                    97.5,
                    743.0,
                    97.5
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
                    "obj-63",
                    1
                  ],
                  "midpoints": [
                    231.0,
                    97.5,
                    710.6666666666666,
                    97.5
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
                    "obj-63",
                    2
                  ],
                  "midpoints": [
                    603.0,
                    97.5,
                    759.3333333333334,
                    97.5
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
                    "obj-63",
                    3
                  ],
                  "midpoints": [
                    975.0,
                    97.5,
                    808.0,
                    97.5
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
                    "obj-64",
                    0
                  ],
                  "midpoints": [
                    670.0,
                    178.5,
                    597.0,
                    178.5
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
                    "obj-65",
                    0
                  ],
                  "midpoints": [
                    735.0,
                    178.5,
                    662.0,
                    178.5
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
                    "obj-66",
                    0
                  ],
                  "midpoints": [
                    611.0,
                    211.0,
                    634.0,
                    211.0
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
                    "obj-67",
                    0
                  ],
                  "midpoints": [
                    676.0,
                    211.0,
                    699.0,
                    211.0
                  ]
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
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-70",
                    0
                  ],
                  "destination": [
                    "obj-73",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-70",
                    0
                  ],
                  "destination": [
                    "obj-74",
                    0
                  ],
                  "midpoints": [
                    746.25,
                    141.0,
                    802.0,
                    141.0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-71",
                    0
                  ],
                  "destination": [
                    "obj-72",
                    0
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
                    "obj-75",
                    1
                  ],
                  "midpoints": [
                    800.25,
                    163.5,
                    765.0,
                    163.5
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
                    "obj-76",
                    1
                  ],
                  "midpoints": [
                    800.25,
                    163.5,
                    830.0,
                    163.5
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
                    "obj-73",
                    1
                  ],
                  "midpoints": [
                    45.0,
                    97.5,
                    785.6666666666666,
                    97.5
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
                    "obj-73",
                    2
                  ],
                  "midpoints": [
                    417.0,
                    97.5,
                    834.3333333333334,
                    97.5
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
                    "obj-73",
                    3
                  ],
                  "midpoints": [
                    789.0,
                    97.5,
                    883.0,
                    97.5
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
                    "obj-74",
                    1
                  ],
                  "midpoints": [
                    231.0,
                    97.5,
                    850.6666666666666,
                    97.5
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
                    "obj-74",
                    2
                  ],
                  "midpoints": [
                    603.0,
                    97.5,
                    899.3333333333334,
                    97.5
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
                    "obj-74",
                    3
                  ],
                  "midpoints": [
                    975.0,
                    97.5,
                    948.0,
                    97.5
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
                    "obj-75",
                    0
                  ],
                  "midpoints": [
                    810.0,
                    178.5,
                    737.0,
                    178.5
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-74",
                    0
                  ],
                  "destination": [
                    "obj-76",
                    0
                  ],
                  "midpoints": [
                    875.0,
                    178.5,
                    802.0,
                    178.5
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-75",
                    0
                  ],
                  "destination": [
                    "obj-77",
                    0
                  ],
                  "midpoints": [
                    751.0,
                    211.0,
                    774.0,
                    211.0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-76",
                    0
                  ],
                  "destination": [
                    "obj-78",
                    0
                  ],
                  "midpoints": [
                    816.0,
                    211.0,
                    839.0,
                    211.0
                  ]
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
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-81",
                    0
                  ],
                  "destination": [
                    "obj-84",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-81",
                    0
                  ],
                  "destination": [
                    "obj-85",
                    0
                  ],
                  "midpoints": [
                    886.25,
                    141.0,
                    942.0,
                    141.0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-82",
                    0
                  ],
                  "destination": [
                    "obj-83",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-83",
                    0
                  ],
                  "destination": [
                    "obj-86",
                    1
                  ],
                  "midpoints": [
                    940.25,
                    163.5,
                    905.0,
                    163.5
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-83",
                    0
                  ],
                  "destination": [
                    "obj-87",
                    1
                  ],
                  "midpoints": [
                    940.25,
                    163.5,
                    970.0,
                    163.5
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
                    "obj-84",
                    1
                  ],
                  "midpoints": [
                    45.0,
                    97.5,
                    925.6666666666666,
                    97.5
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
                    "obj-84",
                    2
                  ],
                  "midpoints": [
                    417.0,
                    97.5,
                    974.3333333333334,
                    97.5
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
                    "obj-84",
                    3
                  ],
                  "midpoints": [
                    789.0,
                    97.5,
                    1023.0,
                    97.5
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
                    "obj-85",
                    1
                  ],
                  "midpoints": [
                    231.0,
                    97.5,
                    990.6666666666666,
                    97.5
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
                    "obj-85",
                    2
                  ],
                  "midpoints": [
                    603.0,
                    97.5,
                    1039.3333333333333,
                    97.5
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
                    "obj-85",
                    3
                  ],
                  "midpoints": [
                    975.0,
                    97.5,
                    1088.0,
                    97.5
                  ]
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
                    0
                  ],
                  "midpoints": [
                    950.0,
                    178.5,
                    877.0,
                    178.5
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-85",
                    0
                  ],
                  "destination": [
                    "obj-87",
                    0
                  ],
                  "midpoints": [
                    1015.0,
                    178.5,
                    942.0,
                    178.5
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-86",
                    0
                  ],
                  "destination": [
                    "obj-88",
                    0
                  ],
                  "midpoints": [
                    891.0,
                    211.0,
                    914.0,
                    211.0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-87",
                    0
                  ],
                  "destination": [
                    "obj-89",
                    0
                  ],
                  "midpoints": [
                    956.0,
                    211.0,
                    979.0,
                    211.0
                  ]
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
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-92",
                    0
                  ],
                  "destination": [
                    "obj-95",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-92",
                    0
                  ],
                  "destination": [
                    "obj-96",
                    0
                  ],
                  "midpoints": [
                    1026.25,
                    141.0,
                    1082.0,
                    141.0
                  ]
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
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-94",
                    0
                  ],
                  "destination": [
                    "obj-97",
                    1
                  ],
                  "midpoints": [
                    1080.25,
                    163.5,
                    1045.0,
                    163.5
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-94",
                    0
                  ],
                  "destination": [
                    "obj-98",
                    1
                  ],
                  "midpoints": [
                    1080.25,
                    163.5,
                    1110.0,
                    163.5
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
                    "obj-95",
                    1
                  ],
                  "midpoints": [
                    45.0,
                    97.5,
                    1065.6666666666667,
                    97.5
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
                    "obj-95",
                    2
                  ],
                  "midpoints": [
                    417.0,
                    97.5,
                    1114.3333333333333,
                    97.5
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
                    "obj-95",
                    3
                  ],
                  "midpoints": [
                    789.0,
                    97.5,
                    1163.0,
                    97.5
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
                    "obj-96",
                    1
                  ],
                  "midpoints": [
                    231.0,
                    97.5,
                    1130.6666666666667,
                    97.5
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
                    "obj-96",
                    2
                  ],
                  "midpoints": [
                    603.0,
                    97.5,
                    1179.3333333333333,
                    97.5
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
                    "obj-96",
                    3
                  ],
                  "midpoints": [
                    975.0,
                    97.5,
                    1228.0,
                    97.5
                  ]
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
                  "midpoints": [
                    1090.0,
                    178.5,
                    1017.0,
                    178.5
                  ]
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
                    0
                  ],
                  "midpoints": [
                    1155.0,
                    178.5,
                    1082.0,
                    178.5
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "obj-97",
                    0
                  ],
                  "destination": [
                    "obj-99",
                    0
                  ],
                  "midpoints": [
                    1031.0,
                    211.0,
                    1054.0,
                    211.0
                  ]
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
                  "midpoints": [
                    1096.0,
                    211.0,
                    1119.0,
                    211.0
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
          },
          "text": "p sends",
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
            420,
            20,
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
          "id": "obj-39",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "patching_rect": [
            420,
            45,
            36.0,
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
          "id": "obj-40",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            420,
            75,
            40.0,
            22.0
          ],
          "text": "128",
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
            470,
            75,
            40.0,
            22.0
          ],
          "text": "64",
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
            520,
            75,
            40.0,
            22.0
          ],
          "text": "64",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-44",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            0.0,
            0.0,
            40.0,
            20.0
          ],
          "text": "#1",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            5.0,
            5.0,
            70.0,
            18.0
          ],
          "textcolor": [
            0.0,
            0.0,
            0.0,
            1.0
          ],
          "textjustification": 1,
          "fontface": 1
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-45",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            0.0,
            0.0,
            44.0,
            20.0
          ],
          "text": "Gain",
          "fontname": "Arial",
          "fontsize": 8,
          "presentation": 1,
          "presentation_rect": [
            5.0,
            28.0,
            18.0,
            12.0
          ],
          "textcolor": [
            0.0,
            0.0,
            0.0,
            1.0
          ],
          "textjustification": 2
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
            0.0,
            0.0,
            40.0,
            20.0
          ],
          "text": "Ins",
          "fontname": "Arial",
          "fontsize": 8,
          "presentation": 1,
          "presentation_rect": [
            5.0,
            67.0,
            18.0,
            12.0
          ],
          "textcolor": [
            0.0,
            0.0,
            0.0,
            1.0
          ],
          "textjustification": 2
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
            0.0,
            0.0,
            40.0,
            20.0
          ],
          "text": "+6",
          "fontname": "Arial",
          "fontsize": 8.0,
          "presentation": 1,
          "presentation_rect": [
            0.0,
            95.0,
            20.0,
            12.0
          ],
          "textcolor": [
            0.0,
            0.0,
            0.0,
            1.0
          ],
          "textjustification": 2
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
            0.0,
            0.0,
            40.0,
            20.0
          ],
          "text": "0",
          "fontname": "Arial",
          "fontsize": 8.0,
          "presentation": 1,
          "presentation_rect": [
            0.0,
            135.63694267515922,
            20.0,
            12.0
          ],
          "textcolor": [
            0.0,
            0.0,
            0.0,
            1.0
          ],
          "textjustification": 2
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-49",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            0.0,
            0.0,
            40.0,
            20.0
          ],
          "text": "-6",
          "fontname": "Arial",
          "fontsize": 8.0,
          "presentation": 1,
          "presentation_rect": [
            0.0,
            174.87261146496814,
            20.0,
            12.0
          ],
          "textcolor": [
            0.0,
            0.0,
            0.0,
            1.0
          ],
          "textjustification": 2
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-50",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            0.0,
            0.0,
            40.0,
            20.0
          ],
          "text": "-12",
          "fontname": "Arial",
          "fontsize": 8.0,
          "presentation": 1,
          "presentation_rect": [
            0.0,
            197.29299363057325,
            20.0,
            12.0
          ],
          "textcolor": [
            0.0,
            0.0,
            0.0,
            1.0
          ],
          "textjustification": 2
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
            0.0,
            0.0,
            40.0,
            20.0
          ],
          "text": "-24",
          "fontname": "Arial",
          "fontsize": 8.0,
          "presentation": 1,
          "presentation_rect": [
            0.0,
            236.52866242038218,
            20.0,
            12.0
          ],
          "textcolor": [
            0.0,
            0.0,
            0.0,
            1.0
          ],
          "textjustification": 2
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-52",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            0.0,
            0.0,
            40.0,
            20.0
          ],
          "text": "-48",
          "fontname": "Arial",
          "fontsize": 8.0,
          "presentation": 1,
          "presentation_rect": [
            0.0,
            295.38216560509557,
            20.0,
            12.0
          ],
          "textcolor": [
            0.0,
            0.0,
            0.0,
            1.0
          ],
          "textjustification": 2
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-53",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            0.0,
            0.0,
            40.0,
            20.0
          ],
          "text": "Pan",
          "fontname": "Arial",
          "fontsize": 8,
          "presentation": 1,
          "presentation_rect": [
            5.0,
            330.0,
            18.0,
            12.0
          ],
          "textcolor": [
            0.0,
            0.0,
            0.0,
            1.0
          ],
          "textjustification": 2
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
            0.0,
            0.0,
            40.0,
            20.0
          ],
          "text": "M",
          "fontname": "Arial",
          "fontsize": 8,
          "presentation": 1,
          "presentation_rect": [
            5.0,
            372.0,
            14.0,
            12.0
          ],
          "textcolor": [
            0.0,
            0.0,
            0.0,
            1.0
          ],
          "textjustification": 2
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
            "obj-11",
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
            "obj-12",
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
            "obj-10",
            0
          ],
          "midpoints": [
            218.0,
            73.0,
            257.0,
            73.0
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
            305.5,
            71.0,
            65.0,
            71.0
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
            "obj-12",
            1
          ],
          "midpoints": [
            305.5,
            71.0,
            135.0,
            71.0
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
            279.5,
            139.0,
            279.5,
            102,
            247.0,
            102
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
            256.25,
            121.0,
            37.0,
            121.0
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
            256.25,
            121.0,
            107.0,
            121.0
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
            "obj-15",
            1
          ],
          "midpoints": [
            51.0,
            96.0,
            110.0,
            96.0
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
            1
          ],
          "midpoints": [
            121.0,
            96.0,
            180.0,
            96.0
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
            "obj-15",
            2
          ],
          "midpoints": [
            255.0,
            80.0,
            183.0,
            80.0
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
            "obj-16",
            2
          ],
          "midpoints": [
            315.0,
            80.0,
            253.0,
            80.0
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
            "obj-17",
            0
          ],
          "midpoints": [
            110.0,
            148.5,
            218.0,
            148.5
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-17",
            1
          ],
          "destination": [
            "obj-18",
            1
          ],
          "midpoints": [
            590.0,
            300.0,
            590.0,
            207,
            135.0,
            207
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
            180.0,
            173.5,
            107.0,
            173.5
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
            297.5,
            361.0,
            297.5,
            312,
            257.0,
            312
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
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-21",
            1
          ],
          "destination": [
            "obj-22",
            0
          ],
          "midpoints": [
            279.0,
            368.5,
            257.0,
            368.5
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
            1
          ],
          "midpoints": [
            257.0,
            356.0,
            135.0,
            356.0
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
            1
          ],
          "midpoints": [
            266.25,
            368.5,
            65.0,
            368.5
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
            "obj-23",
            0
          ],
          "midpoints": [
            207.0,
            320.0,
            37.0,
            320.0
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
            "obj-24",
            0
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
            279.5,
            419.0,
            279.5,
            382,
            247.0,
            382
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
            1
          ],
          "midpoints": [
            256.25,
            401.0,
            65.0,
            401.0
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
            "obj-28",
            1
          ],
          "midpoints": [
            256.25,
            401.0,
            135.0,
            401.0
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
            "obj-27",
            0
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
            "obj-28",
            0
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
            "obj-29",
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
            "obj-30",
            0
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
            "obj-31",
            0
          ],
          "midpoints": [
            51.0,
            423.5,
            244.0,
            423.5
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
          "midpoints": [
            121.0,
            436.0,
            244.0,
            436.0
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
            "obj-33",
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
            "obj-34",
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
            "obj-35",
            0
          ],
          "midpoints": [
            51.0,
            306.0,
            207.0,
            306.0
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
            "obj-36",
            0
          ],
          "midpoints": [
            121.0,
            306.0,
            267.0,
            306.0
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
            "obj-37",
            0
          ],
          "midpoints": [
            110.0,
            351.0,
            37.0,
            351.0
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
            "obj-37",
            1
          ],
          "midpoints": [
            180.0,
            351.0,
            74.2,
            351.0
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
            "obj-37",
            2
          ],
          "midpoints": [
            207.0,
            432.5,
            111.4,
            432.5
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
            "obj-37",
            3
          ],
          "midpoints": [
            121.0,
            403.5,
            148.60000000000002,
            403.5
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
            "obj-37",
            4
          ],
          "midpoints": [
            51.0,
            468.5,
            185.8,
            468.5
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
            "obj-37",
            5
          ],
          "midpoints": [
            121.0,
            468.5,
            223.0,
            468.5
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
            2
          ],
          "destination": [
            "obj-42",
            0
          ],
          "midpoints": [
            449.0,
            71.0,
            527.0,
            71.0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-39",
            1
          ],
          "destination": [
            "obj-41",
            0
          ],
          "midpoints": [
            438.0,
            71.0,
            477.0,
            71.0
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
            "obj-17",
            0
          ],
          "midpoints": [
            440.0,
            131.0,
            218.0,
            131.0
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
            "obj-9",
            0
          ],
          "midpoints": [
            490.0,
            73.5,
            218.0,
            73.5
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
            "obj-19",
            0
          ],
          "midpoints": [
            540.0,
            208.5,
            218.0,
            208.5
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
