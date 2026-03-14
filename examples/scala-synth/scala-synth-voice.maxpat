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
      2761.5,
      440.0
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
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            30.0,
            30.0,
            44.0,
            22.0
          ],
          "text": "in 1",
          "fontname": "Arial",
          "fontsize": 12.0,
          "saved_object_attributes": {
            "attr_comment": "MIDI note number (0-127 int)",
            "c": ""
          }
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-2",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1551.0,
            30.0,
            44.0,
            22.0
          ],
          "text": "in 2",
          "fontname": "Arial",
          "fontsize": 12.0,
          "saved_object_attributes": {
            "attr_comment": "Velocity (0-127 int, 0=note-off)",
            "c": ""
          }
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
            1680.5,
            30.0,
            450.0,
            20.0
          ],
          "text": "--- STAGE 1: MIDI note -> Hz via peek~ scala-tuning buffer ---",
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
            30.0,
            72.0,
            142.0,
            22.0
          ],
          "text": "peek~ scala-tuning",
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
            79.0,
            114.0,
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
          "maxclass": "number~",
          "id": "obj-6",
          "numinlets": 2,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            "float"
          ],
          "patching_rect": [
            177.0,
            72.0,
            56,
            22
          ],
          "parameter_enable": 0,
          "mode": 2,
          "sig": 0.0,
          "fontface": 0
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
            1680.5,
            80.0,
            401.0,
            20.0
          ],
          "text": "DEBUG: freq from peek~ (Hz, expect ~262 for C4/note 60)",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "number~",
          "id": "obj-8",
          "numinlets": 2,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            "float"
          ],
          "patching_rect": [
            128.0,
            114.0,
            56,
            22
          ],
          "parameter_enable": 0,
          "mode": 2,
          "sig": 0.0,
          "fontface": 0
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
            1680.5,
            130.0,
            387.0,
            20.0
          ],
          "text": "DEBUG: freq signal entering gen~ (should match above)",
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
            1680.5,
            180.0,
            471.0,
            20.0
          ],
          "text": "--- STAGE 2: Gen~ additive synthesis (codebox, 1-32 partials) ---",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-11",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            401.0,
            156.0,
            150.0,
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
            "classnamespace": "dsp.gen",
            "rect": [
              100.0,
              100.0,
              600.0,
              450.0
            ],
            "bgcolor": [
              0.9,
              0.9,
              0.9,
              1.0
            ],
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
                    30.0,
                    30.0,
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
                    30.0,
                    72.0,
                    400.0,
                    200.0
                  ],
                  "parameter_enable": 0,
                  "code": "Param num_partials(8, min=1, max=32);\nParam tilt(1.0, min=0, max=3);\nParam stretch(1.0, min=0.5, max=2);\nParam even_odd(0.5, min=0, max=1);\nParam drift_amt(0.0, min=0, max=1);\n\nData phases(32);\nHistory drift_clock(0);\n\nfreq = in1;\nsum = 0;\nsr = samplerate;\n\ndrift_clock = wrap(drift_clock + 1.0 / sr, 0, 1000);\n\nif (freq > 0) {\n    for (i = 0; i < 32; i = i + 1) {\n        n = i + 1;\n\n        if (n <= num_partials) {\n            partial_freq = freq * pow(n, stretch);\n            phase_inc = partial_freq / sr;\n\n            drift_val = sin(drift_clock * TWOPI * 0.3 + n * 2.17) * drift_amt * 0.003;\n            phase_inc = phase_inc * (1 + drift_val);\n\n            phase = peek(phases, i);\n            phase = phase + phase_inc;\n            phase = wrap(phase, 0, 1);\n            poke(phases, phase, i);\n\n            amp = 1.0 / pow(n, tilt);\n\n            if (n > 1) {\n                is_even = (n % 2 == 0);\n                if (is_even) {\n                    amp = amp * clamp(even_odd * 2, 0, 1);\n                } else {\n                    amp = amp * clamp((1 - even_odd) * 2, 0, 1);\n                }\n            }\n\n            sum = sum + sin(phase * TWOPI) * amp;\n        } else {\n            poke(phases, 0, i);\n        }\n    }\n\n    sum = sum / sqrt(num_partials);\n}\n\nout1 = sum;",
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
                    215.0,
                    292.0,
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
                  "order": 0,
                  "midpoints": [
                    45.0,
                    62.0,
                    230.0,
                    62.0
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
                    "obj-3",
                    0
                  ],
                  "order": 0
                }
              }
            ]
          }
        }
      },
      {
        "box": {
          "maxclass": "meter~",
          "id": "obj-12",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "float"
          ],
          "patching_rect": [
            617.0,
            156.0,
            20,
            80
          ],
          "parameter_enable": 0
        }
      },
      {
        "box": {
          "maxclass": "number~",
          "id": "obj-13",
          "numinlets": 2,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            "float"
          ],
          "patching_rect": [
            556.0,
            156.0,
            56,
            22
          ],
          "parameter_enable": 0,
          "mode": 2,
          "sig": 0.0,
          "fontface": 0
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
            1680.5,
            230.0,
            443.0,
            20.0
          ],
          "text": "DEBUG: gen~ output level -- if ZERO here, gen~ is the problem",
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
            1680.5,
            280.0,
            394.0,
            20.0
          ],
          "text": "--- STAGE 3: ADSR envelope (triggered by velocity) ---",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-16",
          "numinlets": 5,
          "numoutlets": 4,
          "outlettype": [
            "signal",
            "signal",
            "",
            ""
          ],
          "patching_rect": [
            1283.9,
            114.0,
            51.0,
            22.0
          ],
          "text": "adsr~",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "meter~",
          "id": "obj-17",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "float"
          ],
          "patching_rect": [
            1339.9,
            114.0,
            20,
            80
          ],
          "parameter_enable": 0
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
            1680.5,
            330.0,
            443.0,
            20.0
          ],
          "text": "DEBUG: ADSR level -- should rise on note-on, fall on note-off",
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
            872.7,
            198.0,
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
          "maxclass": "comment",
          "id": "obj-20",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            1680.5,
            380.0,
            205.0,
            20.0
          ],
          "text": "gen~ output * ADSR envelope",
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
            2166.5,
            30.0,
            275.0,
            20.0
          ],
          "text": "--- STAGE 3b: Velocity processing ---",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-22",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            1526.5,
            72.0,
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
          "id": "obj-23",
          "numinlets": 3,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            1526.5,
            114.0,
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
          "id": "obj-24",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1505.5,
            156.0,
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
          "maxclass": "newobj",
          "id": "obj-25",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            1551.0,
            198.0,
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
            2166.5,
            80.0,
            471.0,
            20.0
          ],
          "text": "trigger fires R-to-L: out1->adsr~(gate), out0->split->scale->sig~",
          "fontname": "Arial",
          "fontsize": 12.0
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
            2166.5,
            130.0,
            233.0,
            20.0
          ],
          "text": "--- STAGE 4: Apply velocity ---",
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
            1212.85,
            240.0,
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
          "maxclass": "comment",
          "id": "obj-29",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            2166.5,
            180.0,
            261.0,
            20.0
          ],
          "text": "(gen~ * ADSR) * velocity_normalized",
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
            2166.5,
            230.0,
            219.0,
            20.0
          ],
          "text": "--- STAGE 5: Voice output ---",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "meter~",
          "id": "obj-31",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "float"
          ],
          "patching_rect": [
            1257.85,
            240.0,
            20,
            80
          ],
          "parameter_enable": 0
        }
      },
      {
        "box": {
          "maxclass": "number~",
          "id": "obj-32",
          "numinlets": 2,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            "float"
          ],
          "patching_rect": [
            1282.85,
            240.0,
            56,
            22
          ],
          "parameter_enable": 0,
          "mode": 2,
          "sig": 0.0,
          "fontface": 0
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
            2166.5,
            280.0,
            555.0,
            20.0
          ],
          "text": "DEBUG: final voice output -- if ZERO here but gen~ is nonzero, check ADSR/vel",
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
            1203.85,
            282.0,
            58.0,
            22.0
          ],
          "text": "out~ 1",
          "fontname": "Arial",
          "fontsize": 12.0,
          "saved_object_attributes": {
            "attr_comment": "Audio signal out (gen~ * ADSR * velocity)",
            "c": ""
          }
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
            2166.5,
            330.0,
            506.0,
            20.0
          ],
          "text": "--- ADSR params via send/receive (atk ms, dec ms, sus 0-1, rel ms) ---",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-36",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            951.0,
            30.0,
            135.0,
            22.0
          ],
          "text": "receive scala-atk",
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
            1401.0,
            30.0,
            135.0,
            22.0
          ],
          "text": "receive scala-dec",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-38",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            1101.0,
            30.0,
            135.0,
            22.0
          ],
          "text": "receive scala-sus",
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
            1251.0,
            30.0,
            135.0,
            22.0
          ],
          "text": "receive scala-rel",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "comment",
          "id": "obj-40",
          "numinlets": 1,
          "numoutlets": 0,
          "outlettype": [],
          "patching_rect": [
            2166.5,
            380.0,
            513.0,
            20.0
          ],
          "text": "--- Gen~ params via send/receive (prepend param_name value -> gen~) ---",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-41",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            609.0,
            30.0,
            170.0,
            22.0
          ],
          "text": "receive scala-partials",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-42",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            616.0,
            72.0,
            156.0,
            22.0
          ],
          "text": "prepend num_partials",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-43",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            794.0,
            30.0,
            142.0,
            22.0
          ],
          "text": "receive scala-tilt",
          "fontname": "Arial",
          "fontsize": 12.0
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
            815.0,
            72.0,
            100.0,
            22.0
          ],
          "text": "prepend tilt",
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
            431.0,
            30.0,
            163.0,
            22.0
          ],
          "text": "receive scala-stretch",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-46",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            480.0,
            72.0,
            121.0,
            22.0
          ],
          "text": "prepend stretch",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-47",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            253.0,
            30.0,
            163.0,
            22.0
          ],
          "text": "receive scala-evenodd",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-48",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            337.0,
            72.0,
            128.0,
            22.0
          ],
          "text": "prepend even_odd",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-49",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            89.0,
            30.0,
            149.0,
            22.0
          ],
          "text": "receive scala-drift",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-50",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            187.0,
            72.0,
            135.0,
            22.0
          ],
          "text": "prepend drift_amt",
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
            "obj-4",
            0
          ],
          "destination": [
            "obj-6",
            0
          ],
          "order": 0,
          "midpoints": [
            101.0,
            83.0,
            184.0,
            83.0
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
            "obj-8",
            0
          ],
          "order": 0,
          "midpoints": [
            191.0,
            141.0,
            191.0,
            106.0,
            135.0,
            106.0
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
            "obj-11",
            0
          ],
          "order": 0,
          "midpoints": [
            101.0,
            146.0,
            476.0,
            146.0
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
          "order": 0,
          "midpoints": [
            476.0,
            167.0,
            627.0,
            167.0
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
          "order": 0,
          "midpoints": [
            476.0,
            167.0,
            563.0,
            167.0
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
            0
          ],
          "order": 0,
          "midpoints": [
            476.0,
            188.0,
            879.7,
            188.0
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
          ],
          "order": 0,
          "midpoints": [
            1366.9,
            141.0,
            1366.9,
            106.0,
            1349.9,
            106.0
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
            "obj-19",
            1
          ],
          "order": 0,
          "midpoints": [
            1290.9,
            167.0,
            905.7,
            167.0
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
            "obj-28",
            0
          ],
          "order": 0,
          "midpoints": [
            892.7,
            230.0,
            1219.85,
            230.0
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
            "obj-28",
            1
          ],
          "order": 0,
          "midpoints": [
            1573.0,
            230.0,
            1245.85,
            230.0
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
            0
          ],
          "order": 0,
          "midpoints": [
            1284.85,
            267.0,
            1284.85,
            232.0,
            1267.85,
            232.0
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
            1345.85,
            267.0,
            1345.85,
            232.0,
            1289.85,
            232.0
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
            1
          ],
          "destination": [
            "obj-16",
            0
          ],
          "order": 0,
          "midpoints": [
            1612.5,
            104.0,
            1290.9,
            104.0
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
          "order": 0,
          "midpoints": [
            1533.5,
            146.0,
            1512.5,
            146.0
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
            "obj-16",
            1
          ],
          "order": 0,
          "midpoints": [
            1018.5,
            83.0,
            1300.15,
            83.0
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
            "obj-16",
            2
          ],
          "order": 0,
          "midpoints": [
            1468.5,
            83.0,
            1309.4,
            83.0
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
            "obj-16",
            3
          ],
          "order": 0,
          "midpoints": [
            1168.5,
            83.0,
            1318.65,
            83.0
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
            "obj-16",
            4
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
            "obj-11",
            0
          ],
          "order": 0,
          "midpoints": [
            694.0,
            125.0,
            476.0,
            125.0
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
            "obj-11",
            0
          ],
          "order": 0,
          "midpoints": [
            865.0,
            125.0,
            476.0,
            125.0
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
            512.5,
            62.0,
            540.5,
            62.0
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
            "obj-11",
            0
          ],
          "order": 0,
          "midpoints": [
            540.5,
            125.0,
            476.0,
            125.0
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
            334.5,
            62.0,
            401.0,
            62.0
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
            "obj-11",
            0
          ],
          "order": 0,
          "midpoints": [
            401.0,
            125.0,
            476.0,
            125.0
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
          ],
          "order": 0,
          "midpoints": [
            163.5,
            62.0,
            254.5,
            62.0
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
          "order": 0,
          "midpoints": [
            254.5,
            125.0,
            476.0,
            125.0
          ]
        }
      }
    ],
    "dependency_cache": [],
    "autosave": 0
  }
}