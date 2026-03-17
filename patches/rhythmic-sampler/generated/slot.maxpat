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
      34.0,
      104.0,
      1660.0,
      740.0
    ],
    "openinpresentation": 1,
    "default_fontsize": 12.0,
    "default_fontface": 0,
    "default_fontname": "Arial",
    "boxes": [
      {
        "box": {
          "id": "obj-83",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            196.0,
            65.0,
            150.0,
            20.0
          ],
          "presentation": 1,
          "presentation_rect": [
            185.0,
            65.0,
            55.0,
            20.0
          ],
          "text": "STEPS:"
        }
      },
      {
        "box": {
          "id": "obj-82",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            214.0,
            67.0,
            150.0,
            20.0
          ],
          "presentation": 1,
          "presentation_rect": [
            65.0,
            65.0,
            92.0,
            20.0
          ],
          "text": "LOAD SOUND"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-1",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            120.0,
            14.0,
            147.0,
            22.0
          ],
          "text": "buffer~ #1",
          "varname": "buffer"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-2",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            "signal"
          ],
          "patching_rect": [
            10.0,
            490.0,
            210.0,
            22.0
          ],
          "text": "groove~ #1",
          "varname": "groove"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-3",
          "maxclass": "newobj",
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
            550.0,
            14.0,
            258.43748474121094,
            22.0
          ],
          "text": "info~ #1",
          "varname": "info"
        }
      },
      {
        "box": {
          "buffername": "",
          "id": "obj-4",
          "maxclass": "waveform~",
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
            10.0,
            45.0,
            350.0,
            60.0
          ],
          "presentation": 1,
          "presentation_rect": [
            0.0,
            0.0,
            400.0,
            60.0
          ],
          "varname": "waveform",
          "parameter_enable": 0
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-5",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 4,
          "outlettype": [
            "signal",
            "signal",
            "signal",
            "signal"
          ],
          "patching_rect": [
            240.0,
            490.0,
            88.0,
            22.0
          ],
          "text": "svf~",
          "varname": "svf"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-6",
          "maxclass": "newobj",
          "numinlets": 5,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            240.0,
            520.0,
            160.0,
            22.0
          ],
          "text": "selector~ 4",
          "varname": "selector"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-7",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            420.0,
            520.0,
            72.0,
            22.0
          ],
          "text": "degrade~",
          "varname": "degrade"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-8",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            560.0,
            520.0,
            42.0,
            22.0
          ],
          "text": "*~",
          "varname": "env_mult"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-9",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            710.0,
            520.0,
            42.0,
            22.0
          ],
          "text": "*~",
          "varname": "vol_mult"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-10",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            ""
          ],
          "patching_rect": [
            560.0,
            490.0,
            39.0,
            22.0
          ],
          "text": "line~",
          "varname": "env_line"
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
            710.0,
            555.0,
            88.0,
            22.0
          ],
          "text": "send~ #2",
          "varname": "send_out",
          "outlettype": []
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-12",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            390.0,
            310.0,
            44.0,
            22.0
          ],
          "text": "sig~",
          "varname": "pitch_sig"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-13",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            510.0,
            310.0,
            44.0,
            22.0
          ],
          "text": "sig~",
          "varname": "cutoff_sig"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-14",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            650.0,
            310.0,
            44.0,
            22.0
          ],
          "text": "sig~",
          "varname": "reso_sig"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-15",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            390.0,
            445.0,
            44.0,
            22.0
          ],
          "text": "sig~",
          "varname": "degrade_sr_sig"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-16",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            480.0,
            445.0,
            44.0,
            22.0
          ],
          "text": "sig~",
          "varname": "degrade_bd_sig"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-17",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            540.0,
            445.0,
            44.0,
            22.0
          ],
          "text": "sig~",
          "varname": "vol_sig"
        }
      },
      {
        "box": {
          "id": "obj-18",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            710.0,
            590.0,
            15.0,
            58.0
          ],
          "presentation": 1,
          "presentation_rect": [
            125.0,
            185.0,
            275.0,
            55.0
          ],
          "varname": "meter",
          "parameter_enable": 0
        }
      },
      {
        "box": {
          "id": "obj-19",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            10.0,
            520.0,
            15.0,
            58.0
          ],
          "presentation": 1,
          "presentation_rect": [
            5.0,
            360.0,
            58.0,
            15.0
          ],
          "varname": "dbg_meter_groove",
          "parameter_enable": 0
        }
      },
      {
        "box": {
          "id": "obj-20",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            240.0,
            550.0,
            15.0,
            58.0
          ],
          "presentation": 1,
          "presentation_rect": [
            95.0,
            360.0,
            58.0,
            15.0
          ],
          "varname": "dbg_meter_filter",
          "parameter_enable": 0
        }
      },
      {
        "box": {
          "id": "obj-21",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            420.0,
            550.0,
            15.0,
            58.0
          ],
          "presentation": 1,
          "presentation_rect": [
            185.0,
            360.0,
            58.0,
            15.0
          ],
          "varname": "dbg_meter_degrade",
          "parameter_enable": 0
        }
      },
      {
        "box": {
          "id": "obj-22",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            560.0,
            550.0,
            15.0,
            58.0
          ],
          "presentation": 1,
          "presentation_rect": [
            275.0,
            360.0,
            58.0,
            15.0
          ],
          "varname": "dbg_meter_env",
          "parameter_enable": 0
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-23",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            30.0,
            540.0,
            40.0,
            20.0
          ],
          "presentation": 1,
          "presentation_rect": [
            55.0,
            360.0,
            34.0,
            20.0
          ],
          "text": "GRV",
          "varname": "dbg_lbl_groove",
          "outlettype": []
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-24",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            260.0,
            570.0,
            40.0,
            20.0
          ],
          "presentation": 1,
          "presentation_rect": [
            145.0,
            360.0,
            30.0,
            20.0
          ],
          "text": "FLT",
          "varname": "dbg_lbl_filter",
          "outlettype": []
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-25",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            440.0,
            570.0,
            40.0,
            20.0
          ],
          "presentation": 1,
          "presentation_rect": [
            235.0,
            360.0,
            35.0,
            20.0
          ],
          "text": "DGR",
          "varname": "dbg_lbl_degrade",
          "outlettype": []
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-26",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            580.0,
            570.0,
            40.0,
            20.0
          ],
          "presentation": 1,
          "presentation_rect": [
            325.0,
            360.0,
            33.0,
            20.0
          ],
          "text": "ENV",
          "varname": "dbg_lbl_env",
          "outlettype": []
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-27",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            370.0,
            75.0,
            100.0,
            22.0
          ],
          "text": "setbuffer #1",
          "varname": "setbuf_msg"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-28",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            370.0,
            50.0,
            58.0,
            22.0
          ],
          "text": "set #1",
          "varname": "set_buf_name_msg"
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
            10.0,
            130.0,
            83.0,
            22.0
          ],
          "text": "receive tick",
          "varname": "recv_tick"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-30",
          "maxclass": "newobj",
          "numinlets": 5,
          "numoutlets": 4,
          "outlettype": [
            "",
            "",
            "",
            ""
          ],
          "patching_rect": [
            10.0,
            160.0,
            81.5,
            22.0
          ],
          "text": "counter 0 15",
          "varname": "counter"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-31",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            10.0,
            195.0,
            80.5,
            22.0
          ],
          "text": "trigger i i",
          "varname": "trig_seq"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-32",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            390.0,
            160.0,
            135.0,
            22.0
          ],
          "saved_object_attributes": {
            "filename": "slot-engine.js",
            "parameter_enable": 0
          },
          "text": "js slot-engine.js",
          "varname": "js_engine"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-33",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            10.0,
            230.0,
            97.0,
            22.0
          ],
          "text": "prepend fetch",
          "varname": "prepend_fetch"
        }
      },
      {
        "box": {
          "id": "obj-34",
          "maxclass": "multislider",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 0,
          "patching_rect": [
            140.0,
            130.0,
            220.0,
            100.0
          ],
          "presentation": 1,
          "presentation_rect": [
            5.0,
            250.0,
            390.0,
            80.0
          ],
          "setminmax": [
            0.0,
            127.0
          ],
          "setstyle": 1,
          "size": 16,
          "varname": "mslider"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-35",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            140.0,
            245.0,
            103.5,
            22.0
          ],
          "text": "split 1 127",
          "varname": "split_vel"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-36",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            140.0,
            280.0,
            80.5,
            22.0
          ],
          "text": "trigger b f",
          "varname": "trig_vel"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-37",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            90.0,
            315.0,
            40.5,
            22.0
          ],
          "text": "/ 127.",
          "varname": "vel_div"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-38",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            90.0,
            355.0,
            88.0,
            22.0
          ],
          "text": "pack f f f",
          "varname": "env_pack"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-39",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            90.0,
            385.0,
            100.0,
            22.0
          ],
          "text": "$1 $2, 0. $3",
          "varname": "env_msg"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-40",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            200.0,
            315.0,
            79.0,
            22.0
          ],
          "text": "startloop",
          "varname": "start_msg"
        }
      },
      {
        "box": {
          "id": "obj-41",
          "maxclass": "button",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "parameter_enable": 0,
          "patching_rect": [
            10.0,
            10.0,
            24.0,
            24.0
          ],
          "presentation": 1,
          "presentation_rect": [
            5.0,
            65.0,
            50.0,
            20.0
          ],
          "varname": "load_btn"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-42",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            45.0,
            14.0,
            44.0,
            22.0
          ],
          "text": "read",
          "varname": "load_msg"
        }
      },
      {
        "box": {
          "id": "obj-43",
          "maxclass": "number",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "parameter_enable": 0,
          "patching_rect": [
            390.0,
            130.0,
            50.0,
            22.0
          ],
          "presentation": 1,
          "presentation_rect": [
            245.0,
            64.0,
            100.0,
            22.0
          ],
          "varname": "num_slices"
        }
      },
      {
        "box": {
          "id": "obj-44",
          "maxclass": "dial",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "parameter_enable": 0,
          "patching_rect": [
            390.0,
            230.0,
            40.0,
            40.0
          ],
          "presentation": 1,
          "presentation_rect": [
            5.0,
            105.0,
            55.0,
            55.0
          ],
          "varname": "pitch_dial"
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
            390.0,
            280.0,
            125.0,
            22.0
          ],
          "text": "expr pow(2.\\, $f1 / 12.)",
          "varname": "pitch_expr"
        }
      },
      {
        "box": {
          "id": "obj-46",
          "maxclass": "dial",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "parameter_enable": 0,
          "patching_rect": [
            510.0,
            230.0,
            40.0,
            40.0
          ],
          "presentation": 1,
          "presentation_rect": [
            65.0,
            105.0,
            55.0,
            55.0
          ],
          "varname": "cutoff_dial"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-47",
          "maxclass": "newobj",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            510.0,
            280.0,
            130.0,
            22.0
          ],
          "text": "scale 0 127 20. 20000.",
          "varname": "cutoff_scale"
        }
      },
      {
        "box": {
          "id": "obj-48",
          "maxclass": "dial",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "parameter_enable": 0,
          "patching_rect": [
            650.0,
            230.0,
            40.0,
            40.0
          ],
          "presentation": 1,
          "presentation_rect": [
            125.0,
            105.0,
            55.0,
            55.0
          ],
          "varname": "reso_dial"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-49",
          "maxclass": "newobj",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            650.0,
            280.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "varname": "reso_scale"
        }
      },
      {
        "box": {
          "id": "obj-50",
          "items": [
            "LP",
            ",",
            "HP",
            ",",
            "BP",
            ",",
            "Notch"
          ],
          "maxclass": "umenu",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "parameter_enable": 0,
          "patching_rect": [
            790.0,
            230.0,
            70.0,
            22.0
          ],
          "presentation": 1,
          "presentation_rect": [
            185.0,
            105.0,
            55.0,
            22.0
          ],
          "varname": "filter_umenu"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-51",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            790.0,
            265.0,
            32.5,
            22.0
          ],
          "text": "+ 1",
          "varname": "filter_plus"
        }
      },
      {
        "box": {
          "id": "obj-52",
          "maxclass": "dial",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "parameter_enable": 0,
          "patching_rect": [
            390.0,
            365.0,
            40.0,
            40.0
          ],
          "presentation": 1,
          "presentation_rect": [
            245.0,
            105.0,
            55.0,
            55.0
          ],
          "varname": "degrade_dial"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-53",
          "maxclass": "newobj",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            390.0,
            415.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0.1 1.",
          "varname": "degrade_scale"
        }
      },
      {
        "box": {
          "id": "obj-54",
          "maxclass": "dial",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "parameter_enable": 0,
          "patching_rect": [
            540.0,
            365.0,
            40.0,
            40.0
          ],
          "presentation": 1,
          "presentation_rect": [
            305.0,
            105.0,
            55.0,
            55.0
          ],
          "varname": "vol_dial"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-55",
          "maxclass": "newobj",
          "numinlets": 6,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            540.0,
            415.0,
            111.0,
            22.0
          ],
          "text": "scale 0 127 0. 1.",
          "varname": "vol_scale"
        }
      },
      {
        "box": {
          "id": "obj-56",
          "maxclass": "dial",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "parameter_enable": 0,
          "patching_rect": [
            650.0,
            365.0,
            40.0,
            40.0
          ],
          "presentation": 1,
          "presentation_rect": [
            5.0,
            185.0,
            55.0,
            55.0
          ],
          "varname": "atk_dial"
        }
      },
      {
        "box": {
          "id": "obj-57",
          "maxclass": "dial",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "parameter_enable": 0,
          "patching_rect": [
            740.0,
            365.0,
            40.0,
            40.0
          ],
          "presentation": 1,
          "presentation_rect": [
            65.0,
            185.0,
            55.0,
            55.0
          ],
          "varname": "dec_dial"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-58",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            10.0,
            660.0,
            62.0,
            22.0
          ],
          "text": "loadbang",
          "varname": "loadbang",
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
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-59",
          "maxclass": "newobj",
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
            10.0,
            690.0,
            163.0,
            22.0
          ],
          "text": "trigger b b b b b b b b b b b b",
          "varname": "init_trig"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-60",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            10.0,
            730.0,
            457.0,
            22.0
          ],
          "text": "127 127 127 127 127 127 127 127 127 127 127 127 127 127 127 127",
          "varname": "init_steps"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-61",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            480.0,
            730.0,
            40.0,
            22.0
          ],
          "text": "0",
          "varname": "init_filter_type"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-62",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            530.0,
            730.0,
            79.0,
            22.0
          ],
          "text": "setloop 1",
          "varname": "init_loop"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-63",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            620.0,
            730.0,
            40.0,
            22.0
          ],
          "text": "16",
          "varname": "init_slices"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-64",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            670.0,
            730.0,
            40.0,
            22.0
          ],
          "text": "5",
          "varname": "init_atk"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-65",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            10.0,
            760.0,
            40.0,
            22.0
          ],
          "text": "300",
          "varname": "init_dec"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-66",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            60.0,
            760.0,
            40.0,
            22.0
          ],
          "text": "24.",
          "varname": "init_bitdepth"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-67",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            120.0,
            760.0,
            40.0,
            22.0
          ],
          "text": "0",
          "varname": "init_pitch"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-68",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            170.0,
            760.0,
            40.0,
            22.0
          ],
          "text": "100",
          "varname": "init_vol"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-69",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            230.0,
            760.0,
            40.0,
            22.0
          ],
          "text": "127",
          "varname": "init_cutoff"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-70",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            290.0,
            760.0,
            40.0,
            22.0
          ],
          "text": "127",
          "varname": "init_degrade_sr"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-71",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            360.0,
            760.0,
            100.0,
            22.0
          ],
          "text": "setbuffer #1",
          "varname": "init_setbuf"
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-72",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            390.0,
            210.0,
            51.0,
            20.0
          ],
          "presentation": 1,
          "presentation_rect": [
            5.0,
            90.0,
            55.0,
            20.0
          ],
          "text": "Pitch",
          "varname": "pitch_lbl",
          "outlettype": []
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-73",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            510.0,
            210.0,
            58.0,
            20.0
          ],
          "presentation": 1,
          "presentation_rect": [
            65.0,
            90.0,
            55.0,
            20.0
          ],
          "text": "Cutoff",
          "varname": "cutoff_lbl",
          "outlettype": []
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-74",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            650.0,
            210.0,
            44.0,
            20.0
          ],
          "presentation": 1,
          "presentation_rect": [
            125.0,
            90.0,
            55.0,
            20.0
          ],
          "text": "Reso",
          "varname": "reso_lbl",
          "outlettype": []
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-75",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            790.0,
            210.0,
            44.0,
            20.0
          ],
          "presentation": 1,
          "presentation_rect": [
            185.0,
            90.0,
            55.0,
            20.0
          ],
          "text": "Type",
          "varname": "type_lbl",
          "outlettype": []
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-76",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            390.0,
            345.0,
            51.0,
            20.0
          ],
          "presentation": 1,
          "presentation_rect": [
            245.0,
            90.0,
            55.0,
            20.0
          ],
          "text": "Degrd",
          "varname": "degrade_lbl",
          "outlettype": []
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-77",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            540.0,
            345.0,
            40.0,
            20.0
          ],
          "presentation": 1,
          "presentation_rect": [
            305.0,
            90.0,
            55.0,
            20.0
          ],
          "text": "Vol",
          "varname": "vol_lbl",
          "outlettype": []
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-78",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            650.0,
            345.0,
            40.0,
            20.0
          ],
          "presentation": 1,
          "presentation_rect": [
            5.0,
            170.0,
            55.0,
            20.0
          ],
          "text": "Atk",
          "varname": "atk_lbl",
          "outlettype": []
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-79",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            740.0,
            345.0,
            40.0,
            20.0
          ],
          "presentation": 1,
          "presentation_rect": [
            65.0,
            170.0,
            55.0,
            20.0
          ],
          "text": "Dec",
          "varname": "dec_lbl",
          "outlettype": []
        }
      },
      {
        "box": {
          "fontname": "Arial",
          "fontsize": 12.0,
          "id": "obj-80",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            140.0,
            108.0,
            100.0,
            20.0
          ],
          "presentation": 1,
          "presentation_rect": [
            5.0,
            335.0,
            390.0,
            20.0
          ],
          "text": "Step Pattern",
          "varname": "step_lbl",
          "outlettype": []
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
            "obj-2",
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
            "obj-6",
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
            "obj-7",
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
            "obj-8",
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
            "obj-31",
            1
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
            "obj-32",
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
            "obj-32",
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
            "obj-34",
            1
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
            "obj-36",
            1
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
            "obj-36",
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
            "obj-2",
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
            "obj-38",
            1
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
            "obj-38",
            2
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
            "obj-10",
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
            "obj-1",
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
            "obj-32",
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
            "obj-28",
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
            "obj-4",
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
            "obj-32",
            1
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
            "obj-12",
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
            "obj-47",
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
            "obj-13",
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
            "obj-14",
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
            "obj-6",
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
            "obj-15",
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
            "obj-17",
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
            11
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
            "obj-34",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-59",
            10
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
            "obj-50",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-59",
            9
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
            "obj-2",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-59",
            8
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
            "obj-43",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-59",
            7
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
            "obj-56",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-59",
            6
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
            "obj-65",
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
            "obj-59",
            5
          ],
          "destination": [
            "obj-66",
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
            "obj-16",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-59",
            4
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
            "obj-44",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-59",
            3
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
            "obj-54",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-59",
            2
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
            "obj-46",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "obj-59",
            1
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
            "obj-52",
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
            "obj-71",
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
            "obj-32",
            1
          ],
          "order": 0
        }
      }
    ],
    "autosave": 0
  }
}