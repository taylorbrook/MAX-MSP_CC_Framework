{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 5,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [ 85.0, 104.0, 1236.0, 865.0 ],
        "boxes": [
            {
                "box": {
                    "angle": 270.0,
                    "background": 1,
                    "grad1": [ 0.94, 0.94, 0.96, 1.0 ],
                    "grad2": [ 0.88, 0.89, 0.92, 1.0 ],
                    "id": "obj-58",
                    "maxclass": "panel",
                    "mode": 1,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 0.0, 0.0, 255.0, 44.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 5.0, 5.0, 460.0, 375.0 ],
                    "proportion": 0.39,
                    "rounded": 7
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
                    "outlettype": [ "signal", "signal" ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 5,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "dsp.gen",
                        "rect": [ 100.0, 100.0, 600.0, 450.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-1",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50.0, 20.0, 30.0, 22.0 ],
                                    "text": "in 1"
                                }
                            },
                            {
                                "box": {
                                    "code": "// STEREO FEEDBACK DELAY -- mono in, stereo out\n// single delay line, tape-glide time, in-loop damping + saturation,\n// post-loop Haas width tap. Loop stays mono (CLAUDE.md filter rules).\nParam time_ms(500, min=1, max=2000);\nParam feedback(0.45, min=0, max=0.95);\nParam damp(6000, min=500, max=15000);\nParam mod_rate(0.8, min=0.1, max=8);\nParam mod_depth(0.15, min=0, max=1);\nParam drive(0.2, min=0, max=1);\nParam width(12, min=0, max=30);\nParam mixamt(0.35, min=0, max=1);\nDelay dline(192001);\nHistory t_smooth(24000);\nHistory lfo_phase(0);\nHistory damp_state(0);\nHistory dc_x(0);\nHistory dc_y(0);\n\nx = in1;\nsr = samplerate;\n\n// target delay time in samples, clamped inside the line\ntarget = clamp(mstosamps(time_ms), 1, 190000);\n\n// tape-style glide: one-pole slew toward target (time changes bend pitch)\nt_next = t_smooth + 0.0005 * (target - t_smooth);\nt_smooth = t_next;\n\n// warble LFO on the read position (up to ~3 ms swing)\ninc = twopi * mod_rate / sr;\nph = wrap(lfo_phase + inc, 0, twopi);\nlfo_phase = ph;\nwarble = sin(ph) * mod_depth * mstosamps(3.0);\n\npos = clamp(t_next + warble, 1, 190000);\n\n// main tap (feedback source) + Haas width tap (post-loop only)\nmain_tap = dline.read(pos);\nwide_pos = clamp(pos + mstosamps(width), 1, 190000);\nwide_tap = dline.read(wide_pos);\n\n// in-loop one-pole lowpass damping (repeats darken naturally)\ndcoef = clamp(1.0 - exp(0.0 - twopi * damp / sr), 0.001, 0.999);\nd_next = damp_state + dcoef * (main_tap - damp_state);\ndamp_state = d_next;\n\n// soft-clip saturation, unity small-signal gain (loop gain stays = feedback < 1)\ndgain = 1.0 + drive * 9.0;\nsat = tanh(d_next * dgain) / dgain;\n\n// feedback gain (capped at 0.95 by Param range) + DC blocker\nfb_in = sat * feedback;\ndc_out = fb_in - dc_x + 0.995 * dc_y;\ndc_x = fb_in;\ndc_y = dc_out;\n\ndline.write(x + dc_out);\n\nout1 = mix(x, main_tap, mixamt);\nout2 = mix(x, wide_tap, mixamt);\n",
                                    "fontface": 0,
                                    "fontname": "<Monospaced>",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "maxclass": "codebox",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 50.0, 80.0, 400.0, 200.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 50.0, 320.0, 30.0, 22.0 ],
                                    "text": "out 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 130.0, 320.0, 30.0, 22.0 ],
                                    "text": "out 2"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-2", 0 ],
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "source": [ "obj-2", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-4", 0 ],
                                    "source": [ "obj-2", 1 ]
                                }
                            }
                        ],
                        "bgcolor": [ 0.9, 0.9, 0.9, 1.0 ]
                    },
                    "patching_rect": [ 195.0, 470.0, 121.0, 22.0 ],
                    "text": "gen~"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.88, 0.9, 0.95, 1.0 ],
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "id": "obj-2",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 15.0, 10.0, 225.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 14.0, 260.0, 24.0 ],
                    "text": "STEREO FEEDBACK DELAY",
                    "textcolor": [ 0.2, 0.2, 0.25, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-3",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 48.0, 65.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 262.0, 70.0, 20.0 ],
                    "text": "mono in",
                    "textcolor": [ 0.2, 0.2, 0.25, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "signal", "signal" ],
                    "patching_rect": [ 30.0, 70.0, 64.0, 22.0 ],
                    "text": "adc~"
                }
            },
            {
                "box": {
                    "id": "obj-5",
                    "maxclass": "gain~",
                    "multichannelvariant": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "signal", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 30.0, 120.0, 22.0, 140.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 282.0, 130.0, 22.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-6",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 90.0, 120.0, 15.0, 100.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 308.0, 130.0, 12.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-7",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 195.0, 70.0, 44.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 52.0, 90.0, 20.0 ],
                    "text": "Time",
                    "textcolor": [ 0.2, 0.2, 0.25, 1.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-8",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 195.0, 92.0, 40.0, 40.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 24.0, 70.0, 44.0, 44.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-9",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 195.0, 140.0, 156.0, 22.0 ],
                    "text": "scale 0 127 1. 2000."
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-10",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 195.0, 170.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 24.0, 116.0, 56.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-11",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 195.0, 200.0, 86.0, 22.0 ],
                    "text": "time_ms $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-12",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 385.0, 70.0, 72.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 132.0, 52.0, 90.0, 20.0 ],
                    "text": "Feedback",
                    "textcolor": [ 0.2, 0.2, 0.25, 1.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-13",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 385.0, 92.0, 40.0, 40.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 136.0, 70.0, 44.0, 44.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-14",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 385.0, 140.0, 149.0, 22.0 ],
                    "text": "scale 0 127 0. 0.95"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-15",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 385.0, 170.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 136.0, 116.0, 56.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-16",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 385.0, 200.0, 93.0, 22.0 ],
                    "text": "feedback $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-17",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 575.0, 70.0, 44.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 244.0, 52.0, 90.0, 20.0 ],
                    "text": "Damp",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-18",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 575.0, 92.0, 40.0, 40.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 248.0, 70.0, 44.0, 44.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-19",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 575.0, 140.0, 177.0, 22.0 ],
                    "text": "scale 0 127 500. 15000."
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-20",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 575.0, 170.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 248.0, 116.0, 56.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-21",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 575.0, 200.0, 65.0, 22.0 ],
                    "text": "damp $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-22",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 765.0, 70.0, 44.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 356.0, 52.0, 90.0, 20.0 ],
                    "text": "Rate",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-23",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 765.0, 92.0, 40.0, 40.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 360.0, 70.0, 44.0, 44.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-24",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 765.0, 140.0, 142.0, 22.0 ],
                    "text": "scale 0 127 0.1 8."
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-25",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 765.0, 170.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 360.0, 116.0, 56.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-26",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 765.0, 200.0, 93.0, 22.0 ],
                    "text": "mod_rate $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-27",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 195.0, 260.0, 51.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 152.0, 90.0, 20.0 ],
                    "text": "Depth",
                    "textcolor": [ 0.2, 0.2, 0.25, 1.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-28",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 195.0, 282.0, 40.0, 40.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 24.0, 170.0, 44.0, 44.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-29",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 195.0, 330.0, 135.0, 22.0 ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-30",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 195.0, 360.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 24.0, 216.0, 56.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-31",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 195.0, 390.0, 100.0, 22.0 ],
                    "text": "mod_depth $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-32",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 385.0, 260.0, 51.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 132.0, 152.0, 90.0, 20.0 ],
                    "text": "Drive",
                    "textcolor": [ 0.2, 0.2, 0.25, 1.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-33",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 385.0, 282.0, 40.0, 40.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 136.0, 170.0, 44.0, 44.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-34",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 385.0, 330.0, 135.0, 22.0 ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-35",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 385.0, 360.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 136.0, 216.0, 56.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-36",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 385.0, 390.0, 72.0, 22.0 ],
                    "text": "drive $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-37",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 575.0, 260.0, 51.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 244.0, 152.0, 90.0, 20.0 ],
                    "text": "Width",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-38",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 575.0, 282.0, 40.0, 40.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 248.0, 170.0, 44.0, 44.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-39",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 575.0, 330.0, 142.0, 22.0 ],
                    "text": "scale 0 127 0. 30."
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-40",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 575.0, 360.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 248.0, 216.0, 56.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-41",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 575.0, 390.0, 72.0, 22.0 ],
                    "text": "width $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-42",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 765.0, 260.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 356.0, 152.0, 90.0, 20.0 ],
                    "text": "Mix",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-43",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 765.0, 282.0, 40.0, 40.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 360.0, 170.0, 44.0, 44.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-44",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 765.0, 330.0, 135.0, 22.0 ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-45",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 765.0, 360.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 360.0, 216.0, 56.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-46",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 765.0, 390.0, 79.0, 22.0 ],
                    "text": "mixamt $1"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.85, 0.92, 0.85, 1.0 ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-47",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 990.0, 70.0, 72.0, 22.0 ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-48",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "bang" ],
                    "patching_rect": [ 990.0, 105.0, 93.0, 22.0 ],
                    "text": "trigger b b"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-49",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 990.0, 145.0, 744.0, 22.0 ],
                    "text": "time_ms 500., feedback 0.45, damp 6000., mod_rate 0.8, mod_depth 0.15, drive 0.2, width 12., mixamt 0.35"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-50",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 990.0, 190.0, 40.0, 22.0 ],
                    "text": "128"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-51",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "int", "int" ],
                    "patching_rect": [ 990.0, 225.0, 93.0, 22.0 ],
                    "text": "trigger i i"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-52",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 195.0, 530.0, 86.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 240.0, 262.0, 90.0, 20.0 ],
                    "text": "stereo out",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-53",
                    "maxclass": "gain~",
                    "multichannelvariant": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "signal", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 195.0, 552.0, 22.0, 140.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 240.0, 282.0, 130.0, 22.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-54",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 255.0, 552.0, 15.0, 100.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 240.0, 308.0, 130.0, 12.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-55",
                    "maxclass": "gain~",
                    "multichannelvariant": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "signal", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 330.0, 552.0, 22.0, 140.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-56",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 390.0, 552.0, 15.0, 100.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 240.0, 324.0, 130.0, 12.0 ]
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.92, 0.85, 0.85, 1.0 ],
                    "id": "obj-57",
                    "maxclass": "ezdac~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [ 195.0, 712.0, 45.0, 45.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 400.0, 282.0, 45.0, 45.0 ]
                }
            },
            {
                "box": {
                    "bubblesize": 16,
                    "id": "obj-59",
                    "maxclass": "preset",
                    "numinlets": 1,
                    "numoutlets": 5,
                    "outlettype": [ "preset", "int", "preset", "int", "" ],
                    "patching_rect": [ 400.0, 15.0, 170.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 285.0, 16.0, 165.0, 22.0 ],
                    "preset_data": [
                        {
                            "number": 1,
                            "data": [ 5, "obj-8", "dial", "float", 6.0, 5, "obj-13", "dial", "float", 16.0, 5, "obj-18", "dial", "float", 74.0, 5, "obj-23", "dial", "float", 6.0, 5, "obj-28", "dial", "float", 6.0, 5, "obj-33", "dial", "float", 19.0, 5, "obj-38", "dial", "float", 34.0, 5, "obj-43", "dial", "float", 38.0 ]
                        },
                        {
                            "number": 2,
                            "data": [ 5, "obj-8", "dial", "float", 27.0, 5, "obj-13", "dial", "float", 104.0, 5, "obj-18", "dial", "float", 18.0, 5, "obj-23", "dial", "float", 5.0, 5, "obj-28", "dial", "float", 15.0, 5, "obj-33", "dial", "float", 70.0, 5, "obj-38", "dial", "float", 76.0, 5, "obj-43", "dial", "float", 57.0 ]
                        },
                        {
                            "number": 3,
                            "data": [ 5, "obj-8", "dial", "float", 20.0, 5, "obj-13", "dial", "float", 74.0, 5, "obj-18", "dial", "float", 35.0, 5, "obj-23", "dial", "float", 50.0, 5, "obj-28", "dial", "float", 64.0, 5, "obj-33", "dial", "float", 44.0, 5, "obj-38", "dial", "float", 51.0, 5, "obj-43", "dial", "float", 51.0 ]
                        },
                        {
                            "number": 4,
                            "data": [ 5, "obj-8", "dial", "float", 48.0, 5, "obj-13", "dial", "float", 87.0, 5, "obj-18", "dial", "float", 53.0, 5, "obj-23", "dial", "float", 2.0, 5, "obj-28", "dial", "float", 13.0, 5, "obj-33", "dial", "float", 13.0, 5, "obj-38", "dial", "float", 119.0, 5, "obj-43", "dial", "float", 44.0 ]
                        },
                        {
                            "number": 5,
                            "data": [ 5, "obj-8", "dial", "float", 89.0, 5, "obj-13", "dial", "float", 120.0, 5, "obj-18", "dial", "float", 26.0, 5, "obj-23", "dial", "float", 8.0, 5, "obj-28", "dial", "float", 19.0, 5, "obj-33", "dial", "float", 32.0, 5, "obj-38", "dial", "float", 85.0, 5, "obj-43", "dial", "float", 64.0 ]
                        },
                        {
                            "number": 6,
                            "data": [ 5, "obj-8", "dial", "float", 32.0, 5, "obj-13", "dial", "float", 60.0, 5, "obj-18", "dial", "float", 118.0, 5, "obj-23", "dial", "float", 0.0, 5, "obj-28", "dial", "float", 0.0, 5, "obj-33", "dial", "float", 0.0, 5, "obj-38", "dial", "float", 0.0, 5, "obj-43", "dial", "float", 44.0 ]
                        }
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-60",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 400.0, 44.0, 620.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 3.0, 389.0, 546.0, 18.0 ],
                    "text": "Presets: 1 Slapback | 2 Dub Echo | 3 Tape Wobble | 4 Wide Ambience | 5 Long Trails | 6 Clean Digital  (shift-click to store)",
                    "textcolor": [ 0.85, 0.87, 0.92, 1.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-53", 0 ],
                    "midpoints": [ 204.5, 516.0, 192.0, 516.0, 192.0, 549.0, 204.5, 549.0 ],
                    "source": [ "obj-1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-55", 0 ],
                    "midpoints": [ 306.5, 537.0, 339.5, 537.0 ],
                    "source": [ "obj-1", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-11", 0 ],
                    "midpoints": [ 204.5, 195.0, 204.5, 195.0 ],
                    "source": [ "obj-10", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 204.5, 246.0, 180.0, 246.0, 180.0, 456.0, 204.5, 456.0 ],
                    "source": [ "obj-11", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-14", 0 ],
                    "midpoints": [ 394.5, 135.0, 394.5, 135.0 ],
                    "source": [ "obj-13", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-15", 0 ],
                    "midpoints": [ 394.5, 165.0, 394.5, 165.0 ],
                    "source": [ "obj-14", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-16", 0 ],
                    "midpoints": [ 394.5, 195.0, 394.5, 195.0 ],
                    "source": [ "obj-15", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 394.5, 225.0, 531.0, 225.0, 531.0, 456.0, 204.5, 456.0 ],
                    "source": [ "obj-16", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-19", 0 ],
                    "midpoints": [ 584.5, 135.0, 584.5, 135.0 ],
                    "source": [ "obj-18", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-20", 0 ],
                    "midpoints": [ 584.5, 165.0, 584.5, 165.0 ],
                    "source": [ "obj-19", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-21", 0 ],
                    "midpoints": [ 584.5, 195.0, 584.5, 195.0 ],
                    "source": [ "obj-20", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 584.5, 246.0, 531.0, 246.0, 531.0, 456.0, 204.5, 456.0 ],
                    "source": [ "obj-21", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-24", 0 ],
                    "midpoints": [ 774.5, 135.0, 774.5, 135.0 ],
                    "source": [ "obj-23", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-25", 0 ],
                    "midpoints": [ 774.5, 165.0, 774.5, 165.0 ],
                    "source": [ "obj-24", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-26", 0 ],
                    "midpoints": [ 774.5, 195.0, 774.5, 195.0 ],
                    "source": [ "obj-25", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 774.5, 246.0, 531.0, 246.0, 531.0, 456.0, 204.5, 456.0 ],
                    "source": [ "obj-26", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-29", 0 ],
                    "midpoints": [ 204.5, 324.0, 204.5, 324.0 ],
                    "source": [ "obj-28", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-30", 0 ],
                    "midpoints": [ 204.5, 354.0, 204.5, 354.0 ],
                    "source": [ "obj-29", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-31", 0 ],
                    "midpoints": [ 204.5, 384.0, 204.5, 384.0 ],
                    "source": [ "obj-30", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 204.5, 414.0, 204.5, 414.0 ],
                    "source": [ "obj-31", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-34", 0 ],
                    "midpoints": [ 394.5, 324.0, 394.5, 324.0 ],
                    "source": [ "obj-33", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-35", 0 ],
                    "midpoints": [ 394.5, 354.0, 394.5, 354.0 ],
                    "source": [ "obj-34", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-36", 0 ],
                    "midpoints": [ 394.5, 384.0, 394.5, 384.0 ],
                    "source": [ "obj-35", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 394.5, 456.0, 204.5, 456.0 ],
                    "source": [ "obj-36", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-39", 0 ],
                    "midpoints": [ 584.5, 324.0, 584.5, 324.0 ],
                    "source": [ "obj-38", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-40", 0 ],
                    "midpoints": [ 584.5, 354.0, 584.5, 354.0 ],
                    "source": [ "obj-39", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-5", 0 ],
                    "midpoints": [ 39.5, 93.0, 39.5, 93.0 ],
                    "source": [ "obj-4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-41", 0 ],
                    "midpoints": [ 584.5, 384.0, 584.5, 384.0 ],
                    "source": [ "obj-40", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 584.5, 456.0, 204.5, 456.0 ],
                    "source": [ "obj-41", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-44", 0 ],
                    "midpoints": [ 774.5, 324.0, 774.5, 324.0 ],
                    "source": [ "obj-43", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-45", 0 ],
                    "midpoints": [ 774.5, 354.0, 774.5, 354.0 ],
                    "source": [ "obj-44", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-46", 0 ],
                    "midpoints": [ 774.5, 384.0, 774.5, 384.0 ],
                    "source": [ "obj-45", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 774.5, 456.0, 204.5, 456.0 ],
                    "source": [ "obj-46", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-48", 0 ],
                    "midpoints": [ 999.5, 93.0, 999.5, 93.0 ],
                    "source": [ "obj-47", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-49", 0 ],
                    "midpoints": [ 1073.5, 129.0, 1002.0, 129.0, 1002.0, 141.0, 999.5, 141.0 ],
                    "source": [ "obj-48", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-50", 0 ],
                    "midpoints": [ 999.5, 129.0, 975.0, 129.0, 975.0, 177.0, 999.5, 177.0 ],
                    "source": [ "obj-48", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 999.5, 177.0, 912.0, 177.0, 912.0, 456.0, 204.5, 456.0 ],
                    "source": [ "obj-49", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 39.5, 456.0, 204.5, 456.0 ],
                    "order": 0,
                    "source": [ "obj-5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-6", 0 ],
                    "midpoints": [ 39.5, 261.0, 75.0, 261.0, 75.0, 117.0, 99.0, 117.0 ],
                    "order": 1,
                    "source": [ "obj-5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-51", 0 ],
                    "midpoints": [ 999.5, 213.0, 999.5, 213.0 ],
                    "source": [ "obj-50", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-5", 0 ],
                    "midpoints": [ 1073.5, 258.0, 816.0, 258.0, 816.0, 234.0, 63.0, 234.0, 63.0, 117.0, 39.5, 117.0 ],
                    "source": [ "obj-51", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-53", 0 ],
                    "midpoints": [ 999.5, 516.0, 192.0, 516.0, 192.0, 549.0, 204.5, 549.0 ],
                    "source": [ "obj-51", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-54", 0 ],
                    "midpoints": [ 204.5, 693.0, 282.0, 693.0, 282.0, 552.0, 264.0, 552.0 ],
                    "order": 0,
                    "source": [ "obj-53", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-55", 0 ],
                    "midpoints": [ 208.0, 693.0, 315.0, 693.0, 315.0, 549.0, 339.5, 549.0 ],
                    "source": [ "obj-53", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-57", 0 ],
                    "midpoints": [ 204.5, 693.0, 204.5, 693.0 ],
                    "order": 1,
                    "source": [ "obj-53", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-56", 0 ],
                    "midpoints": [ 339.5, 693.0, 375.0, 693.0, 375.0, 549.0, 399.0, 549.0 ],
                    "order": 0,
                    "source": [ "obj-55", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-57", 1 ],
                    "midpoints": [ 339.5, 708.0, 230.5, 708.0 ],
                    "order": 1,
                    "source": [ "obj-55", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-13", 0 ],
                    "midpoints": [ 409.5, 39.0, 381.0, 39.0, 381.0, 87.0, 394.5, 87.0 ],
                    "order": 5,
                    "source": [ "obj-59", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-18", 0 ],
                    "midpoints": [ 409.5, -3.0, 471.0, -3.0, 471.0, 0.0, 570.0, 0.0, 570.0, 87.0, 584.5, 87.0 ],
                    "order": 3,
                    "source": [ "obj-59", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-23", 0 ],
                    "midpoints": [ 409.5, -3.0, 471.0, -3.0, 471.0, 0.0, 1020.0, 0.0, 1020.0, 66.0, 975.0, 66.0, 975.0, 72.0, 810.0, 72.0, 810.0, 66.0, 762.0, 66.0, 762.0, 87.0, 774.5, 87.0 ],
                    "order": 1,
                    "source": [ "obj-59", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-28", 0 ],
                    "midpoints": [ 409.5, 39.0, 363.0, 39.0, 363.0, 246.0, 192.0, 246.0, 192.0, 279.0, 204.5, 279.0 ],
                    "order": 6,
                    "source": [ "obj-59", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-33", 0 ],
                    "midpoints": [ 409.5, 39.0, 372.0, 39.0, 372.0, 279.0, 394.5, 279.0 ],
                    "order": 4,
                    "source": [ "obj-59", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-38", 0 ],
                    "midpoints": [ 409.5, -3.0, 471.0, -3.0, 471.0, 0.0, 1020.0, 0.0, 1020.0, 66.0, 975.0, 66.0, 975.0, 246.0, 561.0, 246.0, 561.0, 279.0, 584.5, 279.0 ],
                    "order": 2,
                    "source": [ "obj-59", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-43", 0 ],
                    "midpoints": [ 409.5, -3.0, 471.0, -3.0, 471.0, 0.0, 1020.0, 0.0, 1020.0, 66.0, 975.0, 66.0, 975.0, 246.0, 762.0, 246.0, 762.0, 279.0, 774.5, 279.0 ],
                    "order": 0,
                    "source": [ "obj-59", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-8", 0 ],
                    "midpoints": [ 409.5, 39.0, 267.0, 39.0, 267.0, 57.0, 192.0, 57.0, 192.0, 87.0, 204.5, 87.0 ],
                    "order": 7,
                    "source": [ "obj-59", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-9", 0 ],
                    "midpoints": [ 204.5, 135.0, 204.5, 135.0 ],
                    "source": [ "obj-8", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-10", 0 ],
                    "midpoints": [ 204.5, 165.0, 204.5, 165.0 ],
                    "source": [ "obj-9", 0 ]
                }
            }
        ],
        "autosave": 0,
        "editing_bgcolor": [ 0.333, 0.333, 0.333, 1.0 ]
    }
}