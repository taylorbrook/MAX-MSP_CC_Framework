# Max 9.2.0 release notes

Source: https://cycling74.com/releases/max/9.2.0


### Max 9.2 Update Overview


#### v8 Improvements

Max 9.2 updates the v8 object to a new version of the **v8** engine (14.6) and adds a substantial set of browser- and Node-style workalikes so existing JavaScript code and libraries run with far fewer modifications. A new native networking layer brings fetch (with streaming, compression, and browser-parity behavior), **WebSocket**, **HTTP**, **TCP**, **UDP** servers and clients, and an updated and more compliant **XMLHttpRequest** implementation. Standard timers (**setTimeout**, **setInterval**) are now built in and backed by Max's clock system, and the console object was expanded with improved formatting and compatibility. Finally, new native FFT classes (**MaxFFT** and **MaxFFT2D**) provide fast real and complex transforms directly from JavaScript, dramatically outperforming pure-JS FFT libraries.


#### Jitter Video Engine

A new **WMF** (Windows Media Foundation) video engine option enables movie playback (including HAP codec support) and recording via native Windows libraries.


#### Jitter Web Objects

**jit.web / jit.gl.web** is a Jitter wrapper around CEF that outputs the browser canvas as a matrix or texture and passes mouse and keyboard input from the context window. MSP variants **jit.web~ / jit.gl.web~** are also available. Matrix input is handled natively via the **bindJitterMatrix** and **bindJitterImage** streaming receive API, and copy to and from a named matrix directly with **setJitterMatrix** and **getJitterMatrix**.


#### Jitter Miscellaneous

New features include the **jit.path.ui** tool for path editing; new **jit.gl.meshwarp** features including feathering and vertex snapping; position layout matrix output from **jit.gl.textmult**; per-instance UV input for **jit.gl.multiple**; separate alpha blending control via the **alpha_blend** attribute; and new utility objects **jit.message**, **jit.unpack.geomat**, and **jit.gl.tex2mat**.


#### Windows Installer Improvements

New Windows installer technology, which allows for faster installation, reinstallation and uninstallation, as well as better management of alternate install locations.


#### Gen Improvements

Max 9.2 contains a broad range of Gen fixes focused on making GenExpr code compile correctly and predictably. The **require** system was substantially improved: nested **requires** now work, and required gendsp files can reliably be used as functions from codeboxes. A large group of compiler-correctness fixes addressed dead code elimination removing live code, over-aggressive constant folding and variable collapsing, variable-renaming and aliasing collisions, and proper handling of stateful and side-effecting operators (like poke, latch, and counter) so patches no longer silently compute wrong results or drop logic.


#### ABL Improvements

Three new objects: **abl.device.reverb2~**, **abl.device.stereocompressor~**, and **abl.dsp.djfilter~.** Added: @**quantize** to **abl.device.spectralresonator~**, scrambler modes to the** abl.dsp.transform~** and Meld-based modulator objects, sharktooth LFO waveform on **abl.dsp.stereolfo~ **and **abl.device.autofilter~**, and a Bass Shaper curve on **abl.dsp.saturator~**. Bug fixes for improved stability. Updates to reference pages, help files, and launcher patch.


#### Buffer Improvements

The **replacechannel** / **replacechannel_samples** messages can be used to copy data from one channel to another in a single buffer, or to copy data from an external file to a channel in the current buffer. The **setsize** / **sizeinsamples** messages now have an additional argument that can be used to retain previous contents when resizing. The **trim** / **trim_samples** messages can be used to trim the audio data in the buffer, removing any silence at the start and end, with optional padding arguments to specify the amount of silence at the beginning or the end of the sample. The **url** attribute can be used to specify a url to use for the contents of the buffer.


### Changelog


#### New Features

- **ABL modulators**: scrambler fx type
- **abl.device.autofilter~**: sharktooth LFO waveform
- **abl.device.reverb2~**: feedback delay network reverb
- **abl.device.spectralresonator~**: added @quantize attribute
- **abl.device.stereocompressor~**: stereo compressor
- **abl.dsp.djfilter~**: DJ-style filter
- **abl.dsp.saturator~**: Bass Shaper curve
- **abl.dsp.stereolfo~**: sharktooth waveform
- **abl.dsp.transform~**: scrambler mode
- **autocompletion**: enabled scrolling for attribute and argument description text
- **bpatcher**: sizes and positions box created by typing filename when openrectmode is 1
- **buffer~**: replacechannel / replacechannel_samples messages
- **buffer~**: setsize / sizeinsamples argument to retain previous contents when resizing
- **buffer~**: trim / trim_samples message to trim
- **buffer~**: url attribute
- **coll**: added 'minany' and 'maxany' messages to search all slots
- **detonate**: export message takes time argument of '2' to export using ms time
- **detonate**: write and export take tempo arguments
- **dict.compare**: @fuzzy attribute
- **dict.deserialize**: accepts strings
- **dict.pack**: added 'clear' and 'reset' messages
- **dict.serialize**: stringmode attribute to cause string output
- **dspstress~**: added to distro (needs help / ref)
- **expr / vexpr**: constants functionality a la Gen
- **fftin~/fftout~**: added copyinput/copyoutput/updatewindow messages
- **Find in Patch**: finds poundsign arguments (fe #1) in Modify Read Only patches
- **function**: mousemode 'reorder' option to reorder points on drag
- **gen~**: @file is now alias to @gen
- **jit.anim.node**: added scalemode attribute for world-axis scale application
- **jit.dx.grab**: added support for OBS virtual camera
- **jit.fft**: added support for arbitrary-sized input
- **jit.fpsgui**: added texture input dim and planecount attribute query support
- **jit.fx**: added bang message
- **jit.gl.asyncread**: added @adapt and @dim attributes for texture readback
- **jit.gl.gridshape**: optimized tri/quad grid drawing and updated the help patch
- **jit.gl.mesh**: usebvh attribute to enable bounding volume hierarchy picking
- **jit.gl.meshwarp**: added checkerboard output for video mapping
- **jit.gl.meshwarp**: added edge fades for overlapping projectors, renamed attributes
- **jit.gl.meshwarp**: added vertex snapping when editing grid with mouse
- **jit.gl.meshwarp**: implemented global mask feather
- **jit.gl.model**: concat_geometry matrixoutput mode (enabled by default)
- **jit.gl.multiple**: per instance uvs via texcoord_matrix
- **jit.gl.multiple**: restored tex_map support with GPU instancing in glcore
- **jit.gl.pbr**: added PBR support for line, line_width, quads, and quad_strip rendering
- **jit.gl.tex2mat**: texture to matrix converter with optional non-adapting dimension args
- **jit.gl.textmult**: added layout position matrix output
- **jit.gl.textureset**: added 'insert' message for FIFO queue behavior
- **jit.message**: per-frame message utility object
- **jit.path.ui**: Jitter Tool UI object for editing and animating paths in 3D
- **jit.proxy**: added support for getattribute, getstate, and getparam* shader messages
- **jit.rgb2luma**: added support for all matrix types
- **jit.scissors/glue**: added support for 1D matrix input
- **jit.unpack.geomat**: unpack jit.gl geometry matrix input utility
- **jit.web / jit.web~**: render a web browser to a GL texture or matrix / audio output
- **jit.web / jweb**: support for matrix input, transferred as raw matrix or image
- **Jitter GL Handle Gizmo**: mouse picking, auto_handle updates & node/nurb picking
- **Jitter GL**: alpha_mode implementation
- **Jitter Tools**: reworked Jitter Tools extras as a thumbnail launcher, updated examples
- **Jitter Video Engine**: Windows Media Foundation engine option (Windows-only)
- **jweb**: can handle float, int, bang, and list messages
- **launchbrowser**: added unicode and URL-fragment support
- **maxurl**: libcurl update (v8.10.1)
- **maxurl**: streaming_buffering option
- **Monaco Editor**: Windows support, suppressed invalid errors, native find/replace, improved JS completions, etc
- **mousefilter**: added @button options for middle and right mouse button filtering
- **nrpnin**: added additional hires modes
- **Parameter Window**: OSC-related attributes added
- **Parameter Window**: Revert to Inherited Names option for longname/shortname
- **Parameter Window**: undo / redo
- **patcher**: patch cords can now be in the background layer
- **pattr/pattrstorage**: improved array/string/dict handling
- **pattrstorage**: 'getstate'/'setstate' methods to support dict get/set of internal state
- **rslider**: inputrangemode attribute
- **seq**: 'insert' for non-realtime sequence construction
- **sfrecord~**: start message
- **Sidebar**: cmd+e works to toggle edit status when sidebar has focus
- **Themes**: added menubar color support (and updated factory Themes)
- **thisobject**: support for Jitter objects
- **thispatcher**: showparameterwindow message
- **udpsend/udpreceive**: added @active attribute and converted port/host to attributes
- **udpsend/udpreceive**: string support
- **v8**: added MaxFFT and MaxFFT2D classes
- **v8**: added support for toJSON() for Dict, MaxArray and MaxString
- **v8**: native Console implementation
- **v8**: native timer functions (setTimeout, setInterval, setImmediate, queueMicroTask, etc.)
- **v8**: node and browser networking API workalikes (fetch, http, udp, tcp, websockets, named pipes, XHR rewrite)
- **v8**: updated engine to 14.6.202
- **Windows Installer**: new Inno Setup based installer
- **Windows**: added themed menubar background matching current Max theme

#### Fixed Bugs

- **abl**: mc.abl.* objects now included in standalone builds via registered package name
- **abl.device.drift~**: fixed mod amount 3 range
- **abl.device.roar~**: fixed envelope filter width range
- **abl.dsp.autofilter~**: step quantizer now tracks lforate
- **abl.dsp.chorus/ensemble**: widened width range to 0-2
- **abl.dsp.darkhall~**: relabeled shape attribute to avoid duplicate ‘Modulation Amount’
- **abl.dsp.doubler~**: widened env_amount ramp to -1 to 1 to match attribute filter
- **abl.dsp.modalresonator~**: fixed @damping, ratio, setSampleRate
- **abl.dsp.pulsate~**: length now drives generator macro 2 instead of duplicating chance
- **abl.dsp.ringmod~**: restored drive range to 0-24 dB (9.1 regression)
- **abl.dsp.saturator~**: fixed @dcblock
- **abl.dsp.spectraltime~**: restored fade_out default to 40 ms (9.1 regression)
- **abl.dsp.wander~**: mapped FX types by name so labels match selected transformer
- **ad_portaudio**: fixed memory corruption and crash with signal vector size 4096
- **amxd~**: custom help patches work
- **amxd~**: fixed crash during undo/redo
- **amxd~**: fixed potential drawing-related crashes
- **amxd~**: title bar improvements when UI displayed in separate window
- **array**: recieves messages from pattrhub appropriately
- **array.group**: fixed memory leak when grouping arrays containing objects
- **array.scramble**: fixed empty array behavior
- **array.tolist**: fixed crash when list is > 32767
- **atomarray/dictobj**: fixed memory leak when replacing array items with dict values
- **Audio Drivers**: fixed crash after switching from the NonRealTime driver to CoreAudio
- **audio**: improved microphone authorization error UI and messaging
- **autopattr**: improved autorestore
- **bpatcher**: presentation span size/offset is used when transformed / opened
- **Clue Bar in Bottom Toolbar**: improved truncation
- **coll**: fixed syntax highlighting
- **coll/jit.cellblock**: fixed crash when referring to a coll that changes at high priority
- **counter**: fixed internal state before any output
- **crosspatch**: apply exclusive attribute to incoming messages
- **dac~**: fixed wclose message
- **detonate**: ms-to-beats calculation improvements
- **Dialog on Windows**: fixed default file type / filter index in open and save dialogs
- **dict**: improved handling for ANSI escape chars
- **dict.pack**: fixed edge cases for handling dictionary symbols
- **dict.unpack**: fixed retyping to preserve @legacy, added dynlet support, fixed memory leak
- **Font**: improved Lato rendering on Windows
- **function**: bold font for legend can be used
- **Gen**: fixed broken ‘Gen Overview’ see-also link in gen/gen~ ref pages
- **Group Objects**: border no longer always drawn in presentation
- **Help menu**: added missing Tutorials entry (Windows only)
- **Inspector**: fixed broken color drag-and-drop
- **Inspector**: fixed crash closing subpatcher window with focused inspector search field
- **Inspector**: separated standalone and sidebar window rect preferences
- **jit.bfg**: fixed NaN output for dim==1 and broken basis seed attribute
- **jit.cellblock**: fixed opacity issues when setting border color alpha
- **jit.cellblock**: new scrollbar implementation
- **jit.expr**: fixed crash with input lists of 256 or more elements
- **jit.fx.cf.radial**: minor fixups (flipped center Y so higher is up, fixed help patch)
- **jit.geom**: fixed freeing errors and bad object assertions on help patch close
- [**jit.gl**](http://jit.gl/): bundled with standalone / collectives when required
- **jit.gl.camera**: fixed direction attribute when locklook enabled
- **jit.gl.gridshape**: performance improvements for line rendering
- **jit.gl.gridshape**: restored quad grid mode as the default
- **jit.gl.handle**: fixed crash from stale scenegraph pointer
- **jit.gl.meshwarp**: fixed error when read message has no arguments
- **jit.gl.model**: fixed material dict to include textures and support pbr
- **jit.gl.multiple**: fixed velocity vector
- **jit.gl.picker**: touch messages now use BVH testing
- **jit.gl.shader**: fixed default shader to use vertex/instance color alpha
- **jit.gl.slab etc**: fixed ‘open’ message to Jitter objects with text editors
- **jit.gl.slab**: adapts to 4 plane colormode after receiving single plane matrix input
- **jit.gl.text**: clamped fontsize
- **jit.gl.text**: enabled concat_geometry effect on matrixoutput
- **jit.gl.textmult**: fixed color-from-matrix bug
- **jit.gl.textmult**: fixed crash on free
- **jit.gl.textmult**: improved text generation performance
- **jit.gl.textmult**: works with Global Context enabled
- **jit.gl.volume**: fixed “invalid operation” GL error and non-functional rendering
- **jit.matrix**: fixed attrui not updating when adapting to incoming matrix
- **jit.matrix**: fixed fillplane ignoring first value with out-of-range plane index
- **jit.matrix**: fixed TIFF export row alignment on Windows
- **jit.mgraphics**: cross-platform SVG path rendering improvements
- **jit.mo.time**: fixed reset not working correctly after an enable toggle
- **jit.movie AVF**: fixed loop behavior under heavy load
- **jit.net.send**: added 10-step retry logic for macOS Tahoe socket compatibility
- **jit.path**: fixed relative timemode not applying to matrix input
- **jit.path.ui**: fixed console errors after undo
- **jit.playlist (avf engine)**: fixed garbled thumbnails for ProRes files
- **jit.playlist AVF**: supports HAP files
- **jit.pwindow**: fixed blackout/flickering on Windows
- **jit.pwindow**: fixed dark color rendering
- **jit.pwindow**: outlet cable type reflects texture output
- **jit.ui**: added keyboard number input
- **jit.ui**: fixed centering in jit.pworld
- **jit.ui**: fixed mouse picking, parent group resizing, and ghost plane
- **jit.world**: auto_handle bug fixes and behavior improvements
- **jit.world**: cleaned up fps/interval warning behavior
- **jit.world**: fix operator precedence bug in argument parsing
- **jit.world**: fixed 2x capture on external monitor when main display is retina
- **jit.world**: fixed flicker when clicking on window (Windows only)
- **jit.world**: improved framerate and UI issues with multiple jit.worlds (Windows only)
- **jit.world**: window is no longer created when typing space into box after typing name
- **Jitter ob3d**: blend_mode updates when set via ‘blend’ attribute
- **jweb**: disabled Skia’s Graphite renderer to fix CEF breakage under heavy GPU load
- **jweb**: fixed AltGr key combinations dropped on Windows rendermode 0
- **jweb**: fixed command key handling in jweb inside M4L devices on macOS
- **jweb**: fixed incorrect scaling in M4L device when Live zoom is not 100%
- **jweb**: fixed onscreen browser position when Live scaled or Max zoomed at creation
- **jweb**: no longer steals two-finger-drag scroll
- **jweb**: onscreen jweb no longer obscures patcher toolbars and scrollbars
- **jweb**: restored patcher keyboard focus after jweb creation on Windows
- **jweb**: window.max.outlet() now outputs single-argument messages
- **kslider**: fixed @inputmode clamping for offset > 0 and @mode visible
- **listbox**: can click & drag on an empty listbox
- **listbox**: values restored when recalled via pattr
- **live.gain~**: fixed automation dot never drawn in horizontal mode and with parentpaint()
- **live.gain~**: fixed automation dot position in Free display mode
- **live.thisdevice in amxd~**: reports correct state on patcher reload
- **loadbang**: disabled defeating when opening help files in a patch
- **Logging Preferences**: improved initialization of preference
- **markup**: fixed click hit testing for single-character hyperlinks
- **matrixctrl**: dialmode now supports interpolation with pattrstorage
- **Max for Live**: disabled JUCE accessibility for Max for Live device views
- **Max Launch**: fixed crash when launching Max via the command line with a relative path
- **maxdb**: speed up when aborting update (Windows only)
- **MC**: fixed helpfile, refpage, and ? menu navigation
- **MC**: fixed potential crash after closing patch and creating new dictionary
- **mc.mixdown~**: pans attribute does not change when pancontrolmode changes
- **mc.noteallocator~**: fixed note-off filtering
- **mc.record~**: inlets properly created
- **menubar**: fixed crash when using cmd+f (find) in text editor
- **menus**: fixed Open Recent and Window menus opening the wrong patchers
- **Mixer**: fixed crossfade glitch and click when IOVS == SVS
- **modifiers**: works in Max for Live if “Help In Locked Patcher” is enabled
- **Monaco Editor**: text no longer truncated at 32k characters
- **number**: fixed memory corruption
- **Object Action Menu**: removed post when using Transform 'convert define to arguments"
- **Object Box**: fixed syntax coloring of pasted text containing return characters
- **OSC**: avoid creating unnecessary udpsenders for subpatches
- **Packages**: fixed crash when there is a patch in an ‘init’ dir
- **Packages**: fixed crashes when migrating packages from 8 to 9
- **Param Connect**: fixed short name being overridden when loading or pasting
- **param**: shows up in autocomplete
- **param.osc**: fixed missing output when parameter set via OSC message
- **Parameter Window**: improved focus when return is pressed
- **Parameter Window**: quotes are stripped from name columns for better sorting
- **Parameter Window**: read-only when in Live
- **parameter**: fixed crash on undo of an unautomatable parameter change in Live
- **Parameter**: fixed params not properly marked clean after saving
- **Parameter**: fixed setting attributes via Parameter Windows
- **Parameter**: fixed string->symbol conversions when restoring blob values
- **Parameter**: improved dirtying of overridden attrs in subpatcher
- **Parameter**: no longer re-output on device off/on after a set loads with the device enabled
- **Parameter**: restored output-on-change behavior on devicestate/live.ui @active
- **Patcher Clude Bar**: ‘Show Clue Bar on Open’ patcher attribute works
- **patcher**: improved box coordinate rounding when zoomed
- **Patching**: clicks on patch cords are prioritized
- **patching**: fixed unintended position shift on non-touched corners during resize
- **Paths**: identically-named files no longer replacing one another in cache
- **pattrstorage**: fixed crash when closing client window from high priority message
- **pattrstorage**: fixed issues with outputmode 1 & subscribemode 1
- **pattrstorage**: improvements to client registration
- **playlist~**: fixed crash when dragging into patcher after showontab attr is changed
- **polybuffer~**: fixed crash after first patcher closed
- **polybuffer~**: fixed crash when triggered via scheduler event
- **Popup Menus on MacOS**: fixed sluggish interactions
- **Popup menus**: allowed space character when typing menu text
- **Popup menus**: shown on correct display when there are multiple
- **poundsign arguments**: suppress “bad number” errors
- **Preferences**: fixed potential crash when opening
- **Preferences**: removed internal “dbupdatecomplete” preference from the Preferences window
- **preset**: captures MC attributes
- **preset**: fixed issues when interpolating with nodes
- **Project**: Save as Project includes files referenced from containing Project
- **rnbo~**: fixed CPU spike when typing a space in the object box
- **Save Dialog**: correctly defaults to “Patcher” file type
- **sfrecord~**: correct sample rate is used for saved files
- **Sidebar Ref**: fixed sidebar ref description incorrectly underlined when starting with tag (Win-only)
- **Snippets**: fixed “View in Browser”
- **Standalone Inspector**: fixed crash when changing showontab attribute
- **Standalone**: fixed crash when Windows .ico path is not absolute
- **stash~**: fixed issues with @mode 1 output
- **stepfun~**: fixed right signal outlet
- **Styles / Search fields**: numeric Enter does not insert a line break
- **subdiv~**: fixed step number output
- **subpatcher**: changes retained after undo create subpatcher in parent
- **Subpatchers**: fixed issues with window minimize and close
- **SVG**: fixed gradient stop offset
- **SVG**: handle missing currentColor
- **System Info**: removed ‘X’ from ‘Mac OS’
- **table~**: removed an unnecessary dictionary_dump
- **text**: fixed line message reentrancy issues
- **textbox**: fixed crash when connected to pattr and value recalled via pattrstorage
- **textbutton**: textcolors and usegradient attributes do not get disabled
- **thispatcher**: setting title from another patcher no longer opens root window
- **thispatcher**: window noclose setting is respected
- **transport**: fixed float precision errors when converting integer ticks to BBU
- **tutorials**: fixed crash when closing tutorial patcher windows
- **udpsend**: fixed regression when using port 0
- **udpsend**: improved error handling with large packets
- **v8 jssqlite**: fixed crash when opening SQLite with a bare filename
- **v8**: dict.set() supports arbitrary classes
- **v8**: fixed crash when A_OBJ atoms are output (symbols used instead)
- **v8**: fixed crash when opening SQLite with a bare filename
- **v8**: fixed crash with stack overflow
- **v8**: fixed custom this binding for Task callback function
- **v8**: fixed ParameterListener crash on missing/bogus parameter
- **v8**: fixed Save As… duplicate .js extension
- **v8**: fixed XMLHttpRequest callbacks and this/event binding
- **v8**: SQLite methods now return error codes to JavaScript
- **v8ui**: fixed crash opening the inspector for an attribute named “max”
- **v8ui**: fixed textfile embedding
- **v8ui**: stopped spurious onresize calls in presentation mode
- **vibes-a1 audio file**: added back instrument info
- **vst~**: CPU usage reduced when changing parameter values
- **vst~**: fixed crash when no outputs are provided
- **vst~**: fixed mc.audiounit~ behavior on Windows
- **vst~**: improved CPU usage when loading Kontakt sound libraries
- **what~**: fixed directional detection of 0
- **Windows**: fixed closing of minimized windows (Win only)
- **Windows**: fixed reveal message handling of unicode characters in file paths