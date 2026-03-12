{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 2,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [ 100.0, 100.0, 1050.0, 850.0 ],
        "boxes": [
            {
                "box": {
                    "data": {
                        "clips": [
                            {
                                "absolutepath": "Macintosh HD:/Users/taylorbrook/Downloads/I don’t speak Hunan, but i can if you like (1).mp3",
                                "filename": "I don’t speak Hunan, but i can if you like (1).mp3",
                                "filekind": "audiofile",
                                "id": "u164007939",
                                "loop": 0,
                                "content_state": {                                }
                            }
                        ]
                    },
                    "id": "obj-29",
                    "maxclass": "playlist~",
                    "mode": "basic",
                    "numinlets": 1,
                    "numoutlets": 5,
                    "outlettype": [ "signal", "signal", "signal", "", "dictionary" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 455.1470501422882, 310.5, 150.0, 30.0 ],
                    "quality": "basic",
                    "saved_attribute_attributes": {
                        "candicane2": {
                            "expression": ""
                        },
                        "candicane3": {
                            "expression": ""
                        },
                        "candicane4": {
                            "expression": ""
                        },
                        "candicane5": {
                            "expression": ""
                        },
                        "candicane6": {
                            "expression": ""
                        },
                        "candicane7": {
                            "expression": ""
                        },
                        "candicane8": {
                            "expression": ""
                        }
                    }
                }
            },
            {
                "box": {
                    "id": "obj-27",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 709.0, 326.0, 80.0, 13.0 ]
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "id": "obj-1",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 50.0, 20.0, 263.0, 24.0 ],
                    "text": "FDNVerb -- 8-Line FDN Reverb"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-2",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 50.0, 45.0, 499.0, 20.0 ],
                    "text": "Click ezdac~ to enable audio. Use attrui boxes to adjust gen~ params."
                }
            },
            {
                "box": {
                    "id": "obj-3",
                    "maxclass": "ezadc~",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "signal", "signal" ],
                    "patching_rect": [ 625.0, 303.0, 45.0, 45.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "signal", "signal" ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 2,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "dsp.gen",
                        "rect": [ 99.0, 100.0, 818.0, 787.0 ],
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
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 447.0, 20.0, 30.0, 22.0 ],
                                    "text": "in 2"
                                }
                            },
                            {
                                "box": {
                                    "code": "// FDNVerb -- 8-Line FDN Reverb\n// Feedback Delay Network with Hadamard mixing matrix\n\n// === ALL DECLARATIONS (must precede expressions) ===\nParam decay(2, min=0.1, max=30);\nParam predelay(20, min=0, max=500);\nParam damping(0.5, min=0, max=1);\nParam size(0.5, min=0, max=1);\nParam diffusion(0.7, min=0, max=1);\nParam drywet(0.5, min=0, max=1);\nParam modrate(0.5, min=0.01, max=10);\nParam moddepth(0.2, min=0, max=1);\nParam eq_low(0, min=-12, max=12);\nParam eq_high(0, min=-12, max=12);\nParam bloom(0.5, min=0, max=1);\nParam freeze(0, min=0, max=1);\n\nDelay predly(24000);\nDelay ap1d(512);\nDelay ap2d(512);\nDelay ap3d(512);\nDelay ap4d(512);\nDelay fd0(16384);\nDelay fd1(16384);\nDelay fd2(16384);\nDelay fd3(16384);\nDelay fd4(16384);\nDelay fd5(16384);\nDelay fd6(16384);\nDelay fd7(16384);\n\nHistory ph(0);\nHistory hd0(0);\nHistory hd1(0);\nHistory hd2(0);\nHistory hd3(0);\nHistory hd4(0);\nHistory hd5(0);\nHistory hd6(0);\nHistory hd7(0);\nHistory dcx0(0);\nHistory dcy0(0);\nHistory dcx1(0);\nHistory dcy1(0);\nHistory lsl(0);\nHistory lsr(0);\nHistory hsl(0);\nHistory hsr(0);\n\n// === INPUT ===\ndry_L = in1;\ndry_R = in2;\nmono_in = (dry_L + dry_R) * 0.5;\n\n// === PRE-DELAY ===\npredly.write(mono_in);\npd_samps = max(predelay * 0.001 * samplerate, 1);\npd_out = predly.read(pd_samps);\n\n// === INPUT DIFFUSION ===\ndiff_g = diffusion * 0.6;\n\nap1_rd = ap1d.read(142);\nap1_v = pd_out - diff_g * ap1_rd;\nap1_y = diff_g * ap1_v + ap1_rd;\nap1d.write(ap1_v);\n\nap2_rd = ap2d.read(107);\nap2_v = ap1_y - diff_g * ap2_rd;\nap2_y = diff_g * ap2_v + ap2_rd;\nap2d.write(ap2_v);\n\nap3_rd = ap3d.read(379);\nap3_v = ap2_y - diff_g * ap3_rd;\nap3_y = diff_g * ap3_v + ap3_rd;\nap3d.write(ap3_v);\n\nap4_rd = ap4d.read(277);\nap4_v = ap3_y - diff_g * ap4_rd;\nap4_y = diff_g * ap4_v + ap4_rd;\nap4d.write(ap4_v);\n\n// Bloom crossfade: direct vs diffused input\nfdn_in = pd_out + bloom * (ap4_y - pd_out);\n\n// === FDN CORE ===\nsm = 0.3 + size * 2.2;\nsr_ms = 0.001 * samplerate;\nt0 = 29.7 * sr_ms * sm;\nt1 = 37.1 * sr_ms * sm;\nt2 = 41.1 * sr_ms * sm;\nt3 = 43.7 * sr_ms * sm;\nt4 = 53.0 * sr_ms * sm;\nt5 = 59.3 * sr_ms * sm;\nt6 = 71.9 * sr_ms * sm;\nt7 = 83.0 * sr_ms * sm;\n\n// LFO modulation (8 phases spread evenly)\nnew_ph = wrap(ph + modrate / samplerate, 0, 1);\nph = new_ph;\nmd = moddepth * 16;\nl0 = sin(new_ph * TWOPI) * md;\nl1 = sin((new_ph + 0.125) * TWOPI) * md;\nl2 = sin((new_ph + 0.25) * TWOPI) * md;\nl3 = sin((new_ph + 0.375) * TWOPI) * md;\nl4 = sin((new_ph + 0.5) * TWOPI) * md;\nl5 = sin((new_ph + 0.625) * TWOPI) * md;\nl6 = sin((new_ph + 0.75) * TWOPI) * md;\nl7 = sin((new_ph + 0.875) * TWOPI) * md;\n\n// Modulated delay times (clamped >= 1 sample)\ndt0 = max(t0 + l0, 1);\ndt1 = max(t1 + l1, 1);\ndt2 = max(t2 + l2, 1);\ndt3 = max(t3 + l3, 1);\ndt4 = max(t4 + l4, 1);\ndt5 = max(t5 + l5, 1);\ndt6 = max(t6 + l6, 1);\ndt7 = max(t7 + l7, 1);\n\n// Feedback gains from RT60 decay time\nrt = max(decay, 0.1);\nfrz = freeze > 0.5;\ndf = -3.0 / (samplerate * rt);\ng0 = frz ? 1.0 : pow(10, dt0 * df);\ng1 = frz ? 1.0 : pow(10, dt1 * df);\ng2 = frz ? 1.0 : pow(10, dt2 * df);\ng3 = frz ? 1.0 : pow(10, dt3 * df);\ng4 = frz ? 1.0 : pow(10, dt4 * df);\ng5 = frz ? 1.0 : pow(10, dt5 * df);\ng6 = frz ? 1.0 : pow(10, dt6 * df);\ng7 = frz ? 1.0 : pow(10, dt7 * df);\n\n// Bloom gain shaping: shorter delays quieter at high bloom\ng0 = g0 * (1 - bloom * 0.7);\ng1 = g1 * (1 - bloom * 0.6);\ng2 = g2 * (1 - bloom * 0.5);\ng3 = g3 * (1 - bloom * 0.4);\ng4 = g4 * (1 - bloom * 0.3);\ng5 = g5 * (1 - bloom * 0.2);\ng6 = g6 * (1 - bloom * 0.1);\n\n// Read from FDN delay lines\nr0 = fd0.read(dt0);\nr1 = fd1.read(dt1);\nr2 = fd2.read(dt2);\nr3 = fd3.read(dt3);\nr4 = fd4.read(dt4);\nr5 = fd5.read(dt5);\nr6 = fd6.read(dt6);\nr7 = fd7.read(dt7);\n\n// Damping: one-pole LPF in feedback path\ndc = damping;\nf0 = r0 * (1 - dc) + hd0 * dc;\nf1 = r1 * (1 - dc) + hd1 * dc;\nf2 = r2 * (1 - dc) + hd2 * dc;\nf3 = r3 * (1 - dc) + hd3 * dc;\nf4 = r4 * (1 - dc) + hd4 * dc;\nf5 = r5 * (1 - dc) + hd5 * dc;\nf6 = r6 * (1 - dc) + hd6 * dc;\nf7 = r7 * (1 - dc) + hd7 * dc;\nhd0 = f0;\nhd1 = f1;\nhd2 = f2;\nhd3 = f3;\nhd4 = f4;\nhd5 = f5;\nhd6 = f6;\nhd7 = f7;\n\n// Apply feedback gains\nf0 = f0 * g0;\nf1 = f1 * g1;\nf2 = f2 * g2;\nf3 = f3 * g3;\nf4 = f4 * g4;\nf5 = f5 * g5;\nf6 = f6 * g6;\nf7 = f7 * g7;\n\n// Hadamard 8x8 butterfly mixing matrix\n// Stage 1\na0 = f0 + f4; a4 = f0 - f4;\na1 = f1 + f5; a5 = f1 - f5;\na2 = f2 + f6; a6 = f2 - f6;\na3 = f3 + f7; a7 = f3 - f7;\n// Stage 2\nb0 = a0 + a2; b2 = a0 - a2;\nb1 = a1 + a3; b3 = a1 - a3;\nb4 = a4 + a6; b6 = a4 - a6;\nb5 = a5 + a7; b7 = a5 - a7;\n// Stage 3\nc0 = b0 + b1; c1 = b0 - b1;\nc2 = b2 + b3; c3 = b2 - b3;\nc4 = b4 + b5; c5 = b4 - b5;\nc6 = b6 + b7; c7 = b6 - b7;\n// Normalize (1/sqrt(8))\nsc = 0.35355339;\nc0 = c0 * sc; c1 = c1 * sc;\nc2 = c2 * sc; c3 = c3 * sc;\nc4 = c4 * sc; c5 = c5 * sc;\nc6 = c6 * sc; c7 = c7 * sc;\n\n// Write to delays (mute input when frozen)\ninp = frz ? 0 : fdn_in;\nfd0.write(c0 + inp);\nfd1.write(c1 + inp);\nfd2.write(c2 + inp);\nfd3.write(c3 + inp);\nfd4.write(c4 + inp);\nfd5.write(c5 + inp);\nfd6.write(c6 + inp);\nfd7.write(c7 + inp);\n\n// === OUTPUT ===\n// Stereo from FDN (even taps left, odd taps right)\nwet_L = (r0 + r2 + r4 + r6) * 0.25;\nwet_R = (r1 + r3 + r5 + r7) * 0.25;\n\n// DC blocker\nw0 = wet_L - dcx0 + 0.995 * dcy0;\ndcx0 = wet_L;\ndcy0 = w0;\nwet_L = w0;\nw1 = wet_R - dcx1 + 0.995 * dcy1;\ndcx1 = wet_R;\ndcy1 = w1;\nwet_R = w1;\n\n// Output EQ: low shelf (200 Hz)\nlc = 1 - exp(-TWOPI * 200 / samplerate);\nlsl = lsl + lc * (wet_L - lsl);\nlsr = lsr + lc * (wet_R - lsr);\nlg = pow(10, eq_low / 20);\nwet_L = wet_L + (lg - 1) * lsl;\nwet_R = wet_R + (lg - 1) * lsr;\n\n// Output EQ: high shelf (4 kHz)\nhc = 1 - exp(-TWOPI * 4000 / samplerate);\nhsl = hsl + hc * (wet_L - hsl);\nhsr = hsr + hc * (wet_R - hsr);\nhg = pow(10, eq_high / 20);\nwet_L = wet_L + (hg - 1) * (wet_L - hsl);\nwet_R = wet_R + (hg - 1) * (wet_R - hsr);\n\n// Dry/wet mix\nout1 = dry_L * (1 - drywet) + wet_L * drywet;\nout2 = dry_R * (1 - drywet) + wet_R * drywet;\n",
                                    "fontface": 0,
                                    "fontname": "<Monospaced>",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "maxclass": "codebox",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 50.0, 80.0, 416.0, 491.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 50.0, 618.0, 35.0, 22.0 ],
                                    "text": "out 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 447.0, 618.0, 35.0, 22.0 ],
                                    "text": "out 2"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 1 ],
                                    "source": [ "obj-2", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-4", 0 ],
                                    "source": [ "obj-3", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-5", 0 ],
                                    "source": [ "obj-3", 1 ]
                                }
                            }
                        ],
                        "bgcolor": [ 0.9, 0.9, 0.9, 1.0 ]
                    },
                    "patching_rect": [ 250.0, 400.0, 150.0, 22.0 ],
                    "text": "gen~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-5",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 50.0, 112.0, 58.0, 20.0 ],
                    "text": "REVERB"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-6",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 50.0, 152.0, 88.0, 20.0 ],
                    "text": "MODULATION"
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
                    "patching_rect": [ 50.0, 192.0, 72.0, 20.0 ],
                    "text": "EQ / MIX"
                }
            },
            {
                "box": {
                    "attr": "decay",
                    "id": "obj-8",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 50.0, 130.0, 200.0, 22.0 ],
                    "text_width": 80.0
                }
            },
            {
                "box": {
                    "attr": "predelay",
                    "id": "obj-9",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 260.0, 130.0, 200.0, 22.0 ],
                    "text_width": 80.0
                }
            },
            {
                "box": {
                    "attr": "size",
                    "id": "obj-10",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 470.0, 130.0, 200.0, 22.0 ],
                    "text_width": 80.0
                }
            },
            {
                "box": {
                    "attr": "diffusion",
                    "id": "obj-11",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 680.0, 130.0, 200.0, 22.0 ],
                    "text_width": 80.0
                }
            },
            {
                "box": {
                    "attr": "damping",
                    "id": "obj-12",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 50.0, 170.0, 200.0, 22.0 ],
                    "text_width": 80.0
                }
            },
            {
                "box": {
                    "attr": "modrate",
                    "id": "obj-13",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 260.0, 170.0, 200.0, 22.0 ],
                    "text_width": 80.0
                }
            },
            {
                "box": {
                    "attr": "moddepth",
                    "id": "obj-14",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 470.0, 170.0, 200.0, 22.0 ],
                    "text_width": 80.0
                }
            },
            {
                "box": {
                    "attr": "bloom",
                    "id": "obj-15",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 680.0, 170.0, 200.0, 22.0 ],
                    "text_width": 80.0
                }
            },
            {
                "box": {
                    "attr": "eq_low",
                    "id": "obj-16",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 50.0, 210.0, 200.0, 22.0 ],
                    "text_width": 80.0
                }
            },
            {
                "box": {
                    "attr": "eq_high",
                    "id": "obj-17",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 260.0, 210.0, 200.0, 22.0 ],
                    "text_width": 80.0
                }
            },
            {
                "box": {
                    "attr": "drywet",
                    "id": "obj-18",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 470.0, 210.0, 200.0, 22.0 ],
                    "text_width": 80.0
                }
            },
            {
                "box": {
                    "attr": "freeze",
                    "id": "obj-19",
                    "maxclass": "attrui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 680.0, 210.0, 200.0, 22.0 ],
                    "text_width": 80.0
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-20",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 250.0, 455.0, 40.0, 20.0 ],
                    "text": "L"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-21",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 400.0, 455.0, 40.0, 20.0 ],
                    "text": "R"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-22",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 250.0, 470.0, 58.0, 22.0 ],
                    "text": "*~ 0.5"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-23",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 400.0, 470.0, 58.0, 22.0 ],
                    "text": "*~ 0.5"
                }
            },
            {
                "box": {
                    "id": "obj-24",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 250.0, 510.0, 15.0, 100.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-25",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 400.0, 510.0, 15.0, 100.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-26",
                    "maxclass": "ezdac~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [ 310.0, 560.0, 45.0, 45.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "source": [ "obj-10", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "source": [ "obj-11", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "source": [ "obj-12", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "source": [ "obj-13", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "source": [ "obj-14", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "source": [ "obj-15", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "source": [ "obj-16", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "source": [ "obj-17", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "source": [ "obj-18", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "source": [ "obj-19", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-24", 0 ],
                    "order": 1,
                    "source": [ "obj-22", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-26", 0 ],
                    "order": 0,
                    "source": [ "obj-22", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-25", 0 ],
                    "order": 0,
                    "source": [ "obj-23", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-26", 1 ],
                    "order": 1,
                    "source": [ "obj-23", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "source": [ "obj-29", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-27", 0 ],
                    "order": 0,
                    "source": [ "obj-3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "order": 1,
                    "source": [ "obj-3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-22", 0 ],
                    "source": [ "obj-4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-23", 0 ],
                    "source": [ "obj-4", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "source": [ "obj-8", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "source": [ "obj-9", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}