# Chipalooza Analog Project (sky130)

(c) 2026 Tim Edwards and Simon Dorrer

> [!IMPORTANT]
> This repository requires the [IIC-OSIC-TOOLS](https://github.com/iic-jku/IIC-OSIC-TOOLS) container with tag `2026.08` or later.

> [!WARNING]
> This is a port of the [`sg13cmos5l_chipalooza_analog_project`](https://github.com/simi1505/sg13cmos5l_chipalooza_analog_project) template from the IHP `ihp-sg13cmos5l` Open-PDK to SkyWater's `sky130A` Open-PDK. Only the **harness** was ported — Makefiles, [`.designinit`](.designinit), the Xschem `xschemrc` chaining, the directory layout and the two helper scripts in [`scripts/`](scripts/) — and every PDK tool invocation in it now points at `sky130A`. The **design content is not ported**:
> - The top-level hand-drawn schematic/layout (which instantiated the IHP inverter cells on the IHP floorplan) was removed rather than carried over broken. `schematic/xschem/`, `testbenches/xschem/` and `layout/` only keep their `xschemrc` files; `final/`, `netlist/` and `verification/` are gone until rebuilt.
> - [`macros/inverter/`](macros/inverter/README.md) is an empty shell (Makefile + README only) — this is the macro Chipalooza will replace next, to test this template end-to-end on sky130A.
> - [`macros/counter/`](macros/counter/README.md) keeps its RTL, FPGA build and RTL/gate-level testbenches (PDK-independent), but its LibreLane hardening flow still targets IHP sg13cmos5l standard cells and corners — see its README for what's deferred.
> - [`floorplan/`](floorplan/) still ships the **IHP** floorplan GDS templates as geometry placeholders — they define the chip-harness slot/pin convention this template follows, but their actual pin/metal geometry is IHP's, not sky130A's. Replace them with the real sky130 Chipalooza harness floorplan templates once available, and confirm layer/pitch before trusting them for anything beyond "where do the standard pins go."

> [!TIP]
> If you want to use `nix-shell` instead of the container, have a look here: [heichips26-template](https://github.com/HeiChips/heichips26-template) (IHP-specific; no sky130 equivalent is referenced by this port).

> [!TIP]
> New to this flow? Start with the [**ihp-sg13cmos5l AMS chip design tutorial**](https://iic-jku.github.io/ihp-sg13cmos5l-ams-chip-template/index.html). It is written for the IHP PDK, but this project follows the same analog flow and directory conventions, so the tutorial's structure and Makefile walkthrough still apply here — just mentally substitute `sky130A` for `ihp-sg13cmos5l` throughout. If you are more familiar with sky130, the [Zero to ASIC Course](https://www.zerotoasiccourse.com/) and [TinyTapeout documentation](https://tinytapeout.com/) cover the same flow natively for this PDK.

This is the analog-on-top example project for Chipalooza 2026: the top level `sky130_chipalooza_analog_project` is meant to be drawn **by hand** in KLayout, based on one of the floorplan templates in `floorplan/`. It uses a **recursive macro structure**: the top level embeds the [`inverter`](macros/inverter/README.md) sub-macro, which (once built) will show the complete analog design flow (schematic → simulation → layout → DRC/LVS/PEX → post-layout simulation → characterization). For **mixed-signal (AMS)** submissions the digital [`counter`](macros/counter/README.md) sub-macro is shipped alongside it, which shows the complete digital flow (RTL → lint → RTL simulation → FPGA → LibreLane hardening → PEX → gate-level and mixed-signal simulation) — modulo the LibreLane re-port noted above.

The whole flow runs inside the [IIC-OSIC-TOOLS](https://github.com/iic-jku/IIC-OSIC-TOOLS) container, which ships every tool it needs: Xschem, ngspice, Magic, Netgen, KLayout, CACE, LibreLane, Verilator, Icarus Verilog, cocotb, Yosys, and the `sak-*` helper scripts — including `sak-pdk`, used to switch the container's active PDK (see [Selecting the PDK](#selecting-the-pdk) below).

> [!IMPORTANT]
> You must fill in [`submission.yaml`](submission.yaml) in the repository root before you submit. `top-cell` there has to match `TOP` in the [`Makefile`](Makefile).

[`submission.yaml`](submission.yaml) describes the submission and is what the precheck reads. It carries these fields:

| Field | Meaning |
| --- | --- |
| `project-name` | free-text name of the project |
| `top-cell` | the macro's cell name, unique across all submissions |
| `team-members` | one list entry per person |
| `slot-size` | `tiny` (200 µm × 200 µm), `small` (500 µm × 200 µm) or `large` (500 µm × 415 µm) |
| `analog-pins` | how many of `analog_0` … `analog_2` the macro uses, `0`–`3` |
| `short-description` | one line |
| `long-description` | the project documentation, Markdown in a YAML block scalar |
| `gds-path`, `lef-path`, `header-path` | globs for the three deliverables, each must match **exactly one** file |

Because the submission macro is the **top level** of this repository rather than a folder under `macros/`, the three paths are relative to the repository root:

```yaml
gds-path: final/gds/*.gds
lef-path: final/lef/*.lef
header-path: final/vh/*.vh
```

They are produced by `make build-top`, so run it once before submitting — this needs the top-level layout to exist first (see the Warning above).

> [!WARNING]
> The precheck this template descends from rejects `analog-pins` greater than `0` unless `slot-size` is `small`, even though a `tiny` analog floorplan template is shipped and `submission.yaml` defaults to it (`tiny` with three analog pins). Confirm the rule with the organizers before you rely on a tiny analog slot.


## Selecting the PDK

This container ships several PDKs. [`.designinit`](.designinit) hardcodes this project to `sky130A`, and IIC-OSIC-TOOLS sources `$DESIGNS/.designinit` automatically when this repository is the mounted design directory. To switch a shell to a different PDK by hand (e.g. to compare against the original IHP template), use the `sak-pdk` helper:

```sh
sak-pdk <pdk> [<stdcell-lib>]      # e.g. sak-pdk sky130A sky130_fd_sc_hd
sak-pdk                            # lists installed PDKs
```

`sak-pdk` sets `PDK`, `PDKPATH`, `STD_CELL_LIBRARY`, `SPICE_USERINIT_DIR` and `KLAYOUT_PATH`, mirroring what [`.designinit`](.designinit) exports for this repository. Re-source `.designinit` (`source .designinit`) to get back to `sky130A` in the same shell.


## Directory Structure

<details>
<summary>Show Directory Structure</summary>

```text
📁 sky130_chipalooza_analog_project/
├─ 📁 final/                                 # produced by `make build-top`, not yet built
│  ├─ 📁 gds/
│  ├─ 📁 lef/
│  ├─ 📁 lib/
│  └─ 📁 vh/
├─ 📁 floorplan/                             # IHP geometry placeholders, see Warning above
│  ├─ chipalooza_template_small.gds          # 500µm × 200µm slot
│  ├─ chipalooza_template_small_analog.gds   # 500µm × 200µm slot + 3 analog pins
│  ├─ chipalooza_template_tiny.gds           # 200µm × 200µm slot
│  └─ chipalooza_template_tiny_analog.gds    # 200µm × 200µm slot + 3 analog pins
├─ 📁 layout/                                # empty until the top-level layout is drawn
├─ 📁 macros/
│  ├─ 📁 counter/                            # digital example sub-macro for AMS designs (own Makefile & README)
│  └─ 📁 inverter/                           # analog sub-macro placeholder, to be replaced (own Makefile & README)
├─ 📁 netlist/                                # produced by the verify/LVS/PEX targets, not yet built
├─ 📁 render/
│  └─ 📁 img/                                # produced by `make render-gds`, not yet built
├─ 📁 schematic/
│  └─ 📁 xschem/
│     └─ xschemrc
├─ 📁 scripts/
│  ├─ check_boundary.py
│  └─ check_pex_ports.py
├─ 📁 testbenches/
│  └─ 📁 xschem/
│     ├─ 📁 plot_simulations/
│     │  └─ ngspice2python.py
│     └─ xschemrc
├─ 📁 verification/                           # produced by the DRC/LVS/PEX targets, not yet built
├─ Makefile
├─ README.md
└─ submission.yaml                             # submission description read by the precheck
```

</details>


## Recursive Macro Structure

This project embeds two sub-macros in `macros/`, and each level has its own Makefile with the same targets:

- **Top level (`sky130_chipalooza_analog_project`)** — the hand-drawn submission macro, not yet drawn in this port. Once built, its layout instantiates the `inverter` cells; its Makefile verifies and builds the **top cell only** (`CELL` defaults to `sky130_chipalooza_analog_project`).
- **Analog sub-macro ([`macros/inverter/`](macros/inverter/README.md))** — placeholder for the complete flow reference unit cell (`TOP = inverter`) that will be designed for sky130A.
- **Digital sub-macro ([`macros/counter/`](macros/counter/README.md))** — the digital counterpart for **mixed-signal (AMS)** designs (`TOP = counter_top`). Its RTL, FPGA build and RTL/gate-level cocotb testbenches are carried over unchanged from the IHP port (PDK-independent); its LibreLane hardening flow is **not** re-ported to sky130A yet — see its README.

Every macro follows the same principle, and the simulations always run last, so they use the artifacts the same invocation has just produced:

| Makefile | `all` flow |
| --- | --- |
| [`macros/counter/`](macros/counter/) (digital) | lint → build (FPGA and LibreLane, including the XSPICE model) → extract (PEX of the hardened GDS) → simulate. DRC and LVS run inside the LibreLane flow. |
| [`macros/inverter/`](macros/inverter/) (analog) | verify (DRC, LVS, PEX) → build (LEF, LIB, Verilog stub, GDS, render) → simulate |
| top level | build macros → verify (DRC, LVS, PEX) → build (boundary check, LEF, LIB, Verilog stub, GDS, render) → simulate |

**Build order matters**: if you modify a sub-macro, run its own flow first (`make -C macros/inverter all` or `make -C macros/counter all`, or equivalently `make build-inverter` / `make build-counter` from here), then rebuild the top level. The top-level `make all` does this automatically by running `build-macros` before verifying and building the top cell.


## Floorplan Templates

> [!WARNING]
> The GDS files in `floorplan/` are **inherited unchanged from the IHP `ihp-sg13cmos5l` port**. They establish the chip-harness convention (pin names/sides, metal layers used for signal/analog/power) this template follows, but the actual geometry (layer numbers, pitch, metal stack) is IHP's. Confirm with the sky130 chip-harness organizers (e.g. TinyTapeout) whether equivalent sky130 floorplan templates exist before starting a real layout from one of these files, and re-derive the layer mapping if not.

Start your top-level layout from one of the GDS templates in `floorplan/`. They define the slot geometry and all pin positions:

- **Signal pins** (west edge): the standard chip interface (`clk`, `ena`, `rst_n`, `ui_in[7:0]`, `uo_out[7:0]`, `uio_*[7:0]`) that connects your project to the eFPGA.
- **Analog pins** (`analog_0` … `analog_2`, south edge) — only in the `*_analog` variants. Declare how many you use in [`submission.yaml`](submission.yaml) (`analog-pins:`), and see the warning above about which slot sizes may carry them.
- **Power straps**, running **vertically all the way from bottom to top**: `VPWR`, `VGND`, and optionally `VAPWR` (analog supply). Keeping them as drawn is the safe default when the layer mapping is confirmed to carry over.
- **PR boundary** on layer 189 (`prBoundary`), the box the chip flow derives the macro bounding box from, see [PR Boundary Check](#pr-boundary-check). This is a chip-flow/Magic convention (`cifin: calma BOUND 189 *`), not an IHP-specific PDK layer, so it is expected to carry over as-is.


## Layout Sources and the Exported Tapeout GDS

Not yet applicable in this port — there is no `layout/sky130_chipalooza_analog_project.klay.gds` or `.gds` yet. Once the top-level layout is drawn (per the [original template's convention](https://github.com/simi1505/sg13cmos5l_chipalooza_analog_project#layout-sources-and-the-exported-tapeout-gds)):

- `layout/sky130_chipalooza_analog_project.klay.gds` is the KLayout editing source (live PCells + library references), and binds the library name `inverter` to `../macros/inverter/layout/inverter.gds` via a `.klib` file.
- `layout/sky130_chipalooza_analog_project.gds` is exported from it with `File > Export Layout For Tapeout`, and is what every build and sign-off target reads.
- Re-export after every layout change, re-run DRC/LVS/PEX after every export, and never hand-edit the exported `.gds`.

The Makefile's `_GDS_EXT` variable picks `.gds` when it exists and falls back to `.klay.gds` otherwise, so the DRC, LVS and PEX targets work either way once either file exists.

To edit a layout, start KLayout in edit mode from inside the container, or use `make open` (needs the VNC/X11 desktop).


## Xschem Configuration

Xschem reads exactly one `xschemrc` at start-up, and that file decides which symbol libraries are visible and where netlists and simulation output are written. This template ships one per folder that holds schematics:

| `xschemrc` | Belongs to |
| --- | --- |
| [`schematic/xschem/xschemrc`](schematic/xschem/xschemrc) | top-level schematics |
| [`testbenches/xschem/xschemrc`](testbenches/xschem/xschemrc) | top-level testbenches |
| [`macros/inverter/schematic/xschem/xschemrc`](macros/inverter/schematic/xschem/xschemrc) | inverter schematics |
| [`macros/inverter/testbenches/xschem/xschemrc`](macros/inverter/testbenches/xschem/xschemrc) | inverter testbenches |
| [`macros/counter/schematic/xschem/xschemrc`](macros/counter/schematic/xschem/xschemrc) | counter schematics |
| [`macros/counter/testbenches/xschem/xschemrc`](macros/counter/testbenches/xschem/xschemrc) | counter testbenches |

### What Every File Does

All of them run the same four steps, in this order:

1. **Pick the PDK.** `PDK_ROOT` is probed in the usual install locations if the environment does not set it, and `PDK` falls back to `sky130A` (updated from the IHP port's `ihp-sg13cmos5l` fallback). The container already exports `PDK_ROOT`, and [`.designinit`](.designinit) exports `PDK`, so this step is only a safety net for an Xschem started outside that environment.
2. **Source the PDK `xschemrc`.** `$PDK_ROOT/$PDK/libs.tech/xschem/xschemrc` brings in the sky130 device symbols, the ngspice model paths and the sky130 menu. It is guarded by `[info exists PDK]` so it is read once even when several project files are chained.
3. **Add the project library paths.** `append_xschem_library_path_unique` appends a folder to `XSCHEM_LIBRARY_PATH` only if it is not already there, so the same folder never appears twice no matter how the files are chained.
4. **Pin the netlist directory.** `pin_netlist_dir` decides where `xschem netlist` and the simulators write.

### How the Files Are Chained

```text
testbenches/xschem/xschemrc
└─ source schematic/xschem/xschemrc
   ├─ source macros/inverter/schematic/xschem/xschemrc
   └─ source macros/counter/schematic/xschem/xschemrc
```

The macro files do not source each other or the top level, so a macro can be opened and simulated on its own.

### Which File Is Used

- The Makefile targets always name one explicitly with `--rcfile`, so a target behaves the same from any working directory.
- Starting Xschem from within one of the folders above picks up that folder's file, which is the normal interactive case. `make open` does the same.
- Started from anywhere else, Xschem falls back to `~/.xschem/xschemrc` and sees neither the project symbols nor the pinned `netlist_dir`. Pass the file explicitly then, for example `xschem --rcfile schematic/xschem/xschemrc <file>`.


## Verification Scripts (`sak-*`)

The DRC, LVS, PEX, render and file-browser targets call the `sak-*` Swiss-Army-Knife scripts of the [IIC-OSIC-TOOLS](https://github.com/iic-jku/IIC-OSIC-TOOLS). They are pre-installed in the container and are on `PATH`, so the Makefiles call them by name and no copy is kept in this repository:

- `sak-drc.sh` — DRC with Magic or KLayout
- `sak-lvs.sh` — LVS with Magic + Netgen or KLayout
- `sak-pex.sh` — parasitic extraction with Magic
- `sak-pin-reorder.py` — reorders extracted `.subckt` pins to match an Xschem symbol
- `sak-render.py` — renders a layout GDS to PNG (`-t sky130A` in this port's Makefiles)
- `sak-open.py` — the file browser behind `make open`
- `sak-pdk` — switches the container's active PDK, see [Selecting the PDK](#selecting-the-pdk)

They read `PDK_ROOT`, `PDK`, `PDKPATH` and `STD_CELL_LIBRARY` from the environment. The container exports `PDK_ROOT`, and [`.designinit`](.designinit) exports the other three as `sky130A` / `sky130_fd_sc_hd`. IIC-OSIC-TOOLS sources `$DESIGNS/.designinit` at start-up, so the file is picked up automatically when this repository is the mounted design directory. If the repository sits in a subfolder of `$DESIGNS`, or you are in a shell that was not started that way, source it by hand before running any target:

```sh
source .designinit
```

Only two Python helpers are kept in [`scripts/`](scripts/), both PDK-agnostic:

- [`scripts/check_boundary.py`](scripts/check_boundary.py) — the PR boundary check, see below
- [`scripts/check_pex_ports.py`](scripts/check_pex_ports.py) — checks that every port of a PEX netlist is really connected


## Makefile Targets

The Makefile is identical in structure to the original IHP template's — see the [original README's Makefile Targets section](https://github.com/simi1505/sg13cmos5l_chipalooza_analog_project#makefile-targets) for the full reference of every target and parameter. The two PDK-specific tool invocations (the Magic `.magicrc` path in the `lef` target, and `sak-render.py -t` in `render-gds`) were generalized to use `$(PDK)` instead of a hardcoded `ihp-sg13cmos5l`, so they already resolve correctly for `sky130A` via [`.designinit`](.designinit). In short:

```sh
make                                     # help: all targets and variables
make open                                # file browser for this folder (needs the VNC/X11 desktop)
make klayout-verify-all                  # KLayout DRC + LVS of the top cell
make magic-verify-all                    # Magic DRC + LVS + PEX of the top cell
make check-boundary                      # PR boundary box check of the top cell layout
make build-top                           # boundary check, LEF, LIB, Verilog stub, final GDS, render
make build-inverter                      # run the inverter sub-macro's full flow (make -C macros/inverter all)
make build-counter                       # run the counter sub-macro's full flow (make -C macros/counter all)
make build-macros                        # verify, build and simulate all sub-macros (counter and inverter)
make sim-all                             # run all top-level testbenches
make all                                 # build-macros + verify + build + simulate
make clean                               # delete the top level's generated files (final, netlist, render, reports, simulations)
make clean-all                           # clean-macros + clean
```

Run `make help` for the full list, and `macros/inverter/README.md` / `macros/counter/README.md` for the sub-macro-specific targets once the inverter replacement macro exists.


### PR Boundary Check

Checks that the top cell of `layout/<TOP>.gds` draws the PR boundary box on layer 189 (`prBoundary`). `build-top` runs it first:

```sh
make check-boundary
```

The chip flow derives the bounding box of every macro from this layer: Magic maps all datatypes of layer 189 to its boundary, and LibreLane's `Magic.StreamOut` runs `get_bbox.tcl` on every macro it places. The box comes with the floorplan templates in `floorplan/` (modulo the caveat above), so treat it as part of the layout: never delete it as clutter, keep it in the KLayout editing source so every re-export carries it.


## License

Copyright 2026 Tim Edwards and Simon Dorrer.

Licensed under the **Solderpad Hardware License v2.1** (`Apache-2.0 WITH SHL-2.1`), see [`LICENSE`](LICENSE). Source files carry an `SPDX-FileCopyrightText` header; layout data, netlists, renders and generated reports cannot carry one and are covered by this notice.
