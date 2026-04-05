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
    "devicewidth": 614.0,
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
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "patching_rect": [
            50,
            50,
            58.0,
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
          "id": "obj-2",
          "numinlets": 2,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            50,
            80,
            79.0,
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
          "id": "obj-3",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            50,
            110,
            80.5,
            22.0
          ],
          "text": "trigger b",
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
            "signal"
          ],
          "patching_rect": [
            50,
            140,
            58.0,
            22.0
          ],
          "text": "click~",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "button",
          "id": "obj-5",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            50,
            170,
            24.0,
            24.0
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            5.0,
            30.0,
            30.0,
            30.0
          ]
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
            50,
            220,
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
                  "code": "Param pitch_start(300, min=50, max=1000);\nParam pitch_end(50, min=20, max=200);\nParam pitch_decay(30, min=1, max=500);\nParam amp_decay(200, min=10, max=2000);\nParam pitch_curve(0.3, min=0.01, max=1);\nParam amp_curve(0.15, min=0.01, max=1);\nParam body_level(1, min=0, max=1);\nParam click_level(0.5, min=0, max=1);\nParam click_decay(2, min=0.1, max=20);\nParam click_tone(3000, min=200, max=12000);\nParam sub_level(0.5, min=0, max=1);\nParam sub_decay(300, min=10, max=2000);\nParam noise_level(0.3, min=0, max=1);\nParam noise_decay(5, min=0.5, max=100);\nParam noise_tone(4000, min=200, max=12000);\n\nHistory phase(0);\nHistory pitch_env(0);\nHistory amp_env(0);\nHistory prev_trig(0);\nHistory click_env(0);\nHistory click_lp(0);\nHistory sub_phase(0);\nHistory sub_env(0);\nHistory noise_env(0);\nHistory noise_lp(0);\n\ntrig = in1;\ntrig_on = (trig > 0) && (prev_trig <= 0);\nprev_trig = trig;\n\nif (trig_on) {\n    pitch_env = 1.0;\n    amp_env = 1.0;\n    click_env = 1.0;\n    sub_env = 1.0;\n    noise_env = 1.0;\n    phase = 0;\n    sub_phase = 0;\n}\n\npitch_samples = max(pitch_decay * 0.001 * samplerate, 1);\npitch_coeff = exp(-1.0 / (pitch_samples * pitch_curve));\npitch_env *= pitch_coeff;\namp_samples = max(amp_decay * 0.001 * samplerate, 1);\namp_coeff = exp(-1.0 / (amp_samples * amp_curve));\namp_env *= amp_coeff;\nfreq = pitch_end + (pitch_start - pitch_end) * pitch_env;\nphase += freq / samplerate;\nphase -= floor(phase);\nbody = sin(phase * TWOPI) * amp_env * body_level;\n\nclick_samples = max(click_decay * 0.001 * samplerate, 1);\nclick_coeff = exp(-1.0 / click_samples);\nclick_env *= click_coeff;\nclick_alpha = min(TWOPI * click_tone / samplerate, 1);\nclick_noise = noise();\nclick_lp = click_lp + click_alpha * (click_noise - click_lp);\nclick_out = (trig_on + click_lp * click_env) * click_level;\n\nsub_samples = max(sub_decay * 0.001 * samplerate, 1);\nsub_coeff = exp(-1.0 / sub_samples);\nsub_env *= sub_coeff;\nsub_phase += pitch_end / samplerate;\nsub_phase -= floor(sub_phase);\nsub = sin(sub_phase * TWOPI) * sub_env * sub_level;\n\nnoise_samples = max(noise_decay * 0.001 * samplerate, 1);\nnoise_coeff = exp(-1.0 / noise_samples);\nnoise_env *= noise_coeff;\nnoise_alpha = min(TWOPI * noise_tone / samplerate, 1);\nnoise_raw = noise();\nnoise_lp = noise_lp + noise_alpha * (noise_raw - noise_lp);\nnoise_out = noise_lp * noise_env * noise_level;\n\nout1 = body + click_out + sub + noise_out;\n",
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
          "id": "obj-7",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "signal"
          ],
          "patching_rect": [
            50,
            260,
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
                  "code": "Param drive(1, min=1, max=20);\nParam hp_freq(30, min=20, max=200);\nParam eq_low_freq(80, min=40, max=200);\nParam eq_low_gain(0, min=-12, max=12);\nParam eq_mid_freq(300, min=100, max=800);\nParam eq_mid_gain(0, min=-12, max=12);\nParam lim_ceil(0, min=-20, max=0);\nParam lim_release(10, min=1, max=100);\n\nHistory hp_s1(0);\nHistory hp_s2(0);\nHistory ls_s1(0);\nHistory ls_s2(0);\nHistory pk_s1(0);\nHistory pk_s2(0);\nHistory peak_env(0);\n\nsig = in1;\n\ntanh_drive = tanh(drive);\nsig = tanh(drive * sig) / max(tanh_drive, 0.001);\n\nw0_hp = TWOPI * hp_freq / samplerate;\nsin_hp = sin(w0_hp);\ncos_hp = cos(w0_hp);\nalpha_hp = sin_hp / 1.4142;\nhp_b0 = (1 + cos_hp) * 0.5 / (1 + alpha_hp);\nhp_b1 = -(1 + cos_hp) / (1 + alpha_hp);\nhp_b2 = (1 + cos_hp) * 0.5 / (1 + alpha_hp);\nhp_a1 = -2 * cos_hp / (1 + alpha_hp);\nhp_a2 = (1 - alpha_hp) / (1 + alpha_hp);\nhp_y = hp_b0 * sig + hp_s1;\nhp_s1 = hp_b1 * sig - hp_a1 * hp_y + hp_s2;\nhp_s2 = hp_b2 * sig - hp_a2 * hp_y;\nsig = hp_y;\n\nls_A = pow(10, eq_low_gain / 40);\nw0_ls = TWOPI * eq_low_freq / samplerate;\nsin_ls = sin(w0_ls);\ncos_ls = cos(w0_ls);\nsqrt_ls = sqrt(max(ls_A, 0.001));\nalpha_ls = sin_ls / 1.4142;\nls_a0 = (ls_A+1) + (ls_A-1)*cos_ls + 2*sqrt_ls*alpha_ls;\nls_b0 = ls_A * ((ls_A+1) - (ls_A-1)*cos_ls + 2*sqrt_ls*alpha_ls) / ls_a0;\nls_b1 = 2*ls_A * ((ls_A-1) - (ls_A+1)*cos_ls) / ls_a0;\nls_b2 = ls_A * ((ls_A+1) - (ls_A-1)*cos_ls - 2*sqrt_ls*alpha_ls) / ls_a0;\nls_a1 = -2 * ((ls_A-1) + (ls_A+1)*cos_ls) / ls_a0;\nls_a2 = ((ls_A+1) + (ls_A-1)*cos_ls - 2*sqrt_ls*alpha_ls) / ls_a0;\nls_y = ls_b0 * sig + ls_s1;\nls_s1 = ls_b1 * sig - ls_a1 * ls_y + ls_s2;\nls_s2 = ls_b2 * sig - ls_a2 * ls_y;\nsig = ls_y;\n\npk_A = pow(10, eq_mid_gain / 40);\nw0_pk = TWOPI * eq_mid_freq / samplerate;\nsin_pk = sin(w0_pk);\ncos_pk = cos(w0_pk);\nalpha_pk = sin_pk * 0.5;\npk_a0 = 1 + alpha_pk / max(pk_A, 0.001);\npk_b0 = (1 + alpha_pk * pk_A) / pk_a0;\npk_b1 = (-2 * cos_pk) / pk_a0;\npk_b2 = (1 - alpha_pk * pk_A) / pk_a0;\npk_a1 = (-2 * cos_pk) / pk_a0;\npk_a2 = (1 - alpha_pk / max(pk_A, 0.001)) / pk_a0;\npk_y = pk_b0 * sig + pk_s1;\npk_s1 = pk_b1 * sig - pk_a1 * pk_y + pk_s2;\npk_s2 = pk_b2 * sig - pk_a2 * pk_y;\nsig = pk_y;\n\nlim_thresh = pow(10, lim_ceil / 20);\nrel_coeff = exp(-1.0 / max(lim_release * 0.001 * samplerate, 1));\nabs_sig = abs(sig);\nif (abs_sig > peak_env) {\n    peak_env = abs_sig;\n} else {\n    peak_env = abs_sig + rel_coeff * (peak_env - abs_sig);\n}\nlim_gain = (peak_env > lim_thresh) ? lim_thresh / peak_env : 1;\nout1 = sig * lim_gain;\n",
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
          "maxclass": "gain~",
          "id": "obj-8",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "signal",
            ""
          ],
          "patching_rect": [
            50,
            320,
            22.0,
            140.0
          ],
          "parameter_enable": 0
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
            "signal"
          ],
          "patching_rect": [
            50,
            370,
            90.0,
            22.0
          ],
          "text": "plugout~",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.scope~",
          "id": "obj-10",
          "numinlets": 2,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            300,
            320,
            100,
            50
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            50.0,
            30.0,
            400.0,
            130.0
          ],
          "varname": "viz_scope"
        }
      },
      {
        "box": {
          "maxclass": "live.meter~",
          "id": "obj-11",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "float"
          ],
          "patching_rect": [
            420,
            320,
            30,
            50
          ],
          "parameter_enable": 0,
          "presentation": 1,
          "presentation_rect": [
            460.0,
            30.0,
            140.0,
            130.0
          ],
          "varname": "viz_meter"
        }
      },
      {
        "box": {
          "maxclass": "live.tab",
          "id": "obj-12",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "",
            "",
            ""
          ],
          "patching_rect": [
            200,
            30,
            200,
            20
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            0.0,
            0.0,
            614.0,
            20.0
          ],
          "num_lines_patching": 1,
          "num_lines_presentation": 1,
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Tab",
              "parameter_shortname": "Tab",
              "parameter_type": 2,
              "parameter_enum": [
                "Body",
                "Sub+Noise",
                "Click",
                "Master",
                "Visualize"
              ],
              "parameter_mmax": 4.0,
              "parameter_initial_enable": 1,
              "parameter_initial": [
                0
              ],
              "parameter_modmode": 0
            }
          }
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-13",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            200,
            60,
            156.0,
            22.0
          ],
          "text": "js tab-controller.js",
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
            200,
            90,
            93.0,
            22.0
          ],
          "text": "thispatcher",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.thisdevice",
          "id": "obj-15",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            200,
            5,
            120,
            22
          ],
          "parameter_enable": 0
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
            350,
            5,
            87.5,
            22.0
          ],
          "text": "loadmess 0",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-17",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            300,
            400,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            50.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_pitch_start",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Pitch Start",
              "parameter_shortname": "P.Start",
              "parameter_type": 0,
              "parameter_mmin": 50.0,
              "parameter_mmax": 1000.0,
              "parameter_initial": [
                300.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 3,
              "parameter_modmode": 0
            }
          }
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
            300,
            455,
            149.0,
            22.0
          ],
          "text": "prepend pitch_start",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-19",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            380,
            400,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            128.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_pitch_end",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Pitch End",
              "parameter_shortname": "P.End",
              "parameter_type": 0,
              "parameter_mmin": 20.0,
              "parameter_mmax": 200.0,
              "parameter_initial": [
                50.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 3,
              "parameter_modmode": 0
            }
          }
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-20",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            380,
            455,
            135.0,
            22.0
          ],
          "text": "prepend pitch_end",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-21",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            460,
            400,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            206.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_pitch_decay",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Pitch Decay",
              "parameter_shortname": "P.Decay",
              "parameter_type": 0,
              "parameter_mmin": 1.0,
              "parameter_mmax": 500.0,
              "parameter_initial": [
                30.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 2,
              "parameter_modmode": 0
            }
          }
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
            460,
            455,
            149.0,
            22.0
          ],
          "text": "prepend pitch_decay",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-23",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            540,
            400,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            284.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_pitch_curve",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Pitch Curve",
              "parameter_shortname": "P.Curve",
              "parameter_type": 0,
              "parameter_mmin": 0.01,
              "parameter_mmax": 1.0,
              "parameter_initial": [
                0.3
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_modmode": 0
            }
          }
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-24",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            540,
            455,
            149.0,
            22.0
          ],
          "text": "prepend pitch_curve",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-25",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            620,
            400,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            362.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_amp_decay",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Amp Decay",
              "parameter_shortname": "A.Decay",
              "parameter_type": 0,
              "parameter_mmin": 10.0,
              "parameter_mmax": 2000.0,
              "parameter_initial": [
                200.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 2,
              "parameter_modmode": 0
            }
          }
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-26",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            620,
            455,
            135.0,
            22.0
          ],
          "text": "prepend amp_decay",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-27",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            700,
            400,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            440.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_amp_curve",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Amp Curve",
              "parameter_shortname": "A.Curve",
              "parameter_type": 0,
              "parameter_mmin": 0.01,
              "parameter_mmax": 1.0,
              "parameter_initial": [
                0.15
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_modmode": 0
            }
          }
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-28",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            700,
            455,
            135.0,
            22.0
          ],
          "text": "prepend amp_curve",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-29",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            780,
            400,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            518.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_body_level",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Body Level",
              "parameter_shortname": "Body",
              "parameter_type": 0,
              "parameter_mmin": 0.0,
              "parameter_mmax": 1.0,
              "parameter_initial": [
                1.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_modmode": 0
            }
          }
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-30",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            780,
            455,
            142.0,
            22.0
          ],
          "text": "prepend body_level",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-31",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            300,
            530,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            50.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_sub_level",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Sub Level",
              "parameter_shortname": "Sub",
              "parameter_type": 0,
              "parameter_mmin": 0.0,
              "parameter_mmax": 1.0,
              "parameter_initial": [
                0.5
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_modmode": 0
            }
          }
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-32",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            300,
            585,
            135.0,
            22.0
          ],
          "text": "prepend sub_level",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-33",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            380,
            530,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            160.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_sub_decay",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Sub Decay",
              "parameter_shortname": "S.Decay",
              "parameter_type": 0,
              "parameter_mmin": 10.0,
              "parameter_mmax": 2000.0,
              "parameter_initial": [
                300.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 2,
              "parameter_modmode": 0
            }
          }
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-34",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            380,
            585,
            135.0,
            22.0
          ],
          "text": "prepend sub_decay",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-35",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            460,
            530,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            270.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_noise_level",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Noise Level",
              "parameter_shortname": "Noise",
              "parameter_type": 0,
              "parameter_mmin": 0.0,
              "parameter_mmax": 1.0,
              "parameter_initial": [
                0.3
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_modmode": 0
            }
          }
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-36",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            460,
            585,
            149.0,
            22.0
          ],
          "text": "prepend noise_level",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-37",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            540,
            530,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            380.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_noise_decay",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Noise Decay",
              "parameter_shortname": "N.Decay",
              "parameter_type": 0,
              "parameter_mmin": 0.5,
              "parameter_mmax": 100.0,
              "parameter_initial": [
                5.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 2,
              "parameter_modmode": 0
            }
          }
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
            540,
            585,
            149.0,
            22.0
          ],
          "text": "prepend noise_decay",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-39",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            620,
            530,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            490.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_noise_tone",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Noise Tone",
              "parameter_shortname": "N.Tone",
              "parameter_type": 0,
              "parameter_mmin": 200.0,
              "parameter_mmax": 12000.0,
              "parameter_initial": [
                4000.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 3,
              "parameter_modmode": 0
            }
          }
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-40",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            620,
            585,
            142.0,
            22.0
          ],
          "text": "prepend noise_tone",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-41",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            300,
            660,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            50.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_click_level",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Click Level",
              "parameter_shortname": "Click",
              "parameter_type": 0,
              "parameter_mmin": 0.0,
              "parameter_mmax": 1.0,
              "parameter_initial": [
                0.5
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_modmode": 0
            }
          }
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
            300,
            715,
            149.0,
            22.0
          ],
          "text": "prepend click_level",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-43",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            380,
            660,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            230.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_click_decay",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Click Decay",
              "parameter_shortname": "C.Decay",
              "parameter_type": 0,
              "parameter_mmin": 0.1,
              "parameter_mmax": 20.0,
              "parameter_initial": [
                2.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 2,
              "parameter_modmode": 0
            }
          }
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
            380,
            715,
            149.0,
            22.0
          ],
          "text": "prepend click_decay",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-45",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            460,
            660,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            410.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_click_tone",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Click Tone",
              "parameter_shortname": "C.Tone",
              "parameter_type": 0,
              "parameter_mmin": 200.0,
              "parameter_mmax": 12000.0,
              "parameter_initial": [
                3000.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 3,
              "parameter_modmode": 0
            }
          }
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
            460,
            715,
            142.0,
            22.0
          ],
          "text": "prepend click_tone",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-47",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            300,
            790,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            50.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_drive",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Drive",
              "parameter_shortname": "Drive",
              "parameter_type": 0,
              "parameter_mmin": 1.0,
              "parameter_mmax": 20.0,
              "parameter_initial": [
                1.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 1,
              "parameter_modmode": 0
            }
          }
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
            300,
            845,
            107.0,
            22.0
          ],
          "text": "prepend drive",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-49",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            380,
            790,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            118.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_hp_freq",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "HP Frequency",
              "parameter_shortname": "HP Freq",
              "parameter_type": 0,
              "parameter_mmin": 20.0,
              "parameter_mmax": 200.0,
              "parameter_initial": [
                30.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 3,
              "parameter_modmode": 0
            }
          }
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
            380,
            845,
            121.0,
            22.0
          ],
          "text": "prepend hp_freq",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-51",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            460,
            790,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            186.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_eq_low_freq",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "EQ Low Freq",
              "parameter_shortname": "Lo Freq",
              "parameter_type": 0,
              "parameter_mmin": 40.0,
              "parameter_mmax": 200.0,
              "parameter_initial": [
                80.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 3,
              "parameter_modmode": 0
            }
          }
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-52",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            460,
            845,
            149.0,
            22.0
          ],
          "text": "prepend eq_low_freq",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-53",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            540,
            790,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            254.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_eq_low_gain",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "EQ Low Gain",
              "parameter_shortname": "Lo Gain",
              "parameter_type": 0,
              "parameter_mmin": -12.0,
              "parameter_mmax": 12.0,
              "parameter_initial": [
                0.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 4,
              "parameter_modmode": 0
            }
          }
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-54",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            540,
            845,
            149.0,
            22.0
          ],
          "text": "prepend eq_low_gain",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-55",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            620,
            790,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            322.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_eq_mid_freq",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "EQ Mid Freq",
              "parameter_shortname": "Mid Freq",
              "parameter_type": 0,
              "parameter_mmin": 100.0,
              "parameter_mmax": 800.0,
              "parameter_initial": [
                300.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 3,
              "parameter_modmode": 0
            }
          }
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-56",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            620,
            845,
            149.0,
            22.0
          ],
          "text": "prepend eq_mid_freq",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-57",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            700,
            790,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            390.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_eq_mid_gain",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "EQ Mid Gain",
              "parameter_shortname": "Mid Gain",
              "parameter_type": 0,
              "parameter_mmin": -12.0,
              "parameter_mmax": 12.0,
              "parameter_initial": [
                0.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 4,
              "parameter_modmode": 0
            }
          }
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
            700,
            845,
            149.0,
            22.0
          ],
          "text": "prepend eq_mid_gain",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-59",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            780,
            790,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            458.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_lim_ceil",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Limiter Ceiling",
              "parameter_shortname": "Lim Ceil",
              "parameter_type": 0,
              "parameter_mmin": -20.0,
              "parameter_mmax": 0.0,
              "parameter_initial": [
                0.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 4,
              "parameter_modmode": 0
            }
          }
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-60",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            780,
            845,
            128.0,
            22.0
          ],
          "text": "prepend lim_ceil",
          "fontname": "Arial",
          "fontsize": 12.0
        }
      },
      {
        "box": {
          "maxclass": "live.dial",
          "id": "obj-61",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "float"
          ],
          "patching_rect": [
            860,
            790,
            50.0,
            48.0
          ],
          "parameter_enable": 1,
          "presentation": 1,
          "presentation_rect": [
            526.0,
            30.0,
            50.0,
            48.0
          ],
          "varname": "d_lim_release",
          "saved_attribute_attributes": {
            "valueof": {
              "parameter_longname": "Limiter Release",
              "parameter_shortname": "Lim Rel",
              "parameter_type": 0,
              "parameter_mmin": 1.0,
              "parameter_mmax": 100.0,
              "parameter_initial": [
                10.0
              ],
              "parameter_initial_enable": 1,
              "parameter_unitstyle": 2,
              "parameter_modmode": 0
            }
          }
        }
      },
      {
        "box": {
          "maxclass": "newobj",
          "id": "obj-62",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            860,
            845,
            149.0,
            22.0
          ],
          "text": "prepend lim_release",
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
            500,
            700,
            44.0,
            20.0
          ],
          "text": "BODY",
          "fontname": "Arial",
          "fontsize": 11.0,
          "presentation": 1,
          "presentation_rect": [
            50.0,
            85.0,
            42,
            18.0
          ],
          "varname": "body_label",
          "fontface": 1
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
            500,
            700,
            40.0,
            20.0
          ],
          "text": "SUB",
          "fontname": "Arial",
          "fontsize": 11.0,
          "presentation": 1,
          "presentation_rect": [
            50.0,
            85.0,
            34,
            18.0
          ],
          "varname": "sub_label",
          "fontface": 1
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
            500,
            700,
            51.0,
            20.0
          ],
          "text": "NOISE",
          "fontname": "Arial",
          "fontsize": 11.0,
          "presentation": 1,
          "presentation_rect": [
            230.0,
            85.0,
            50,
            18.0
          ],
          "varname": "noise_label",
          "fontface": 1
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
            500,
            700,
            51.0,
            20.0
          ],
          "text": "CLICK",
          "fontname": "Arial",
          "fontsize": 11.0,
          "presentation": 1,
          "presentation_rect": [
            50.0,
            85.0,
            50,
            18.0
          ],
          "varname": "click_label",
          "fontface": 1
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
            500,
            700,
            58.0,
            20.0
          ],
          "text": "MASTER",
          "fontname": "Arial",
          "fontsize": 11.0,
          "presentation": 1,
          "presentation_rect": [
            50.0,
            85.0,
            58,
            18.0
          ],
          "varname": "master_label",
          "fontface": 1
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
            500,
            700,
            58.0,
            20.0
          ],
          "text": "OUTPUT",
          "fontname": "Arial",
          "fontsize": 11.0,
          "presentation": 1,
          "presentation_rect": [
            50.0,
            85.0,
            58,
            18.0
          ],
          "varname": "viz_label",
          "fontface": 1
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
            550.0,
            10.0,
            58.0,
            20.0
          ],
          "text": "v0.1.0",
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
            "obj-2",
            1
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
            "obj-4",
            0
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
            "obj-6",
            0
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
            1
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
            "obj-10",
            0
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
            "obj-11",
            0
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
            "obj-13",
            0
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
            "obj-12",
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
            "obj-18",
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
            "obj-6",
            0
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
            "obj-6",
            0
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
            "obj-6",
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
            "obj-6",
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
            "obj-6",
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
            "obj-6",
            0
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
            "obj-6",
            0
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
            "obj-6",
            0
          ]
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
            "obj-6",
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
            "obj-36",
            0
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
            "obj-6",
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
            "obj-38",
            0
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
            "obj-6",
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
            "obj-6",
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
            0
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
            "obj-6",
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
            "obj-44",
            0
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
            "obj-6",
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
            "obj-7",
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
            "obj-7",
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
            "obj-52",
            0
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
            "obj-7",
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
            "obj-54",
            0
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
            "obj-7",
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
            "obj-56",
            0
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
            "obj-7",
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
            "obj-58",
            0
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
            "obj-7",
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
            "obj-60",
            0
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
            "obj-7",
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
            "obj-62",
            0
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
            "obj-7",
            0
          ]
        }
      }
    ],
    "dependency_cache": [],
    "autosave": 0
  }
}