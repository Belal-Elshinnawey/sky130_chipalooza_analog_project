# Makefile Targets

Three Makefiles: this one (repository root), [`macros/inverter/Makefile`](macros/inverter/Makefile), [`macros/counter/Makefile`](macros/counter/Makefile). `make help` in any of the three prints its own live target list, generated from the same `##` comments this file is built from.

## Top level (this directory)

### Variables

| Variable | Default | Meaning |
| --- | --- | --- |
| `CELL` | `$(TOP)` | Cell name for verification targets |
| `EXT_MODE` | `3` | PEX mode: `1`=C-decoupled, `2`=C-coupled, `3`=full-RC |
| `THRESHOLD` | `10000` | full-RC (`EXT_MODE=3`) extresist threshold in mOhm, for `magic-pex` |
| `MINRES` | `1000` | full-RC (`EXT_MODE=3`) extresist minres in mOhm, for `magic-pex` |
| `MINDELAY` | `1` | full-RC (`EXT_MODE=3`) extresist mindelay in ps, for `magic-pex` |
| `DRC_LEVEL` | `macro` | KLayout DRC level for `klayout-drc`: `precheck`\|`macro`\|`regular` |
| `EV_PRECISION` | `5` | Significant digits for Xschem's `ev` function during netlisting |
| `TB` | `<CELL>_tb_tran` | Testbench for `sim-xschem` |
| `SCRIPT` | `plot_<CELL>` | Plotting script for `sim-view-xschem` |
| `OPEN_ARGS` | *(empty)* | Extra flags passed to `sak-open.py` for `open` |

### Targets

| Target | What it does |
| --- | --- |
| `help` | Show this help message |
| `open` | Open the design files of this folder in the `sak-open.py` file browser (needs the VNC/X11 desktop) |
| `sim-xschem [TB=]` | Run TB simulation with Xschem in batch mode |
| `sim-view-xschem [SCRIPT=]` | Plot Xschem simulation results |
| `sim-all` | Simulate the macro |
| `build-counter` | Lint, build, verify and simulate the counter macro |
| `build-inverter` | Verify, build and simulate the inverter macro |
| `build-macros` | Verify, build and simulate all macros (counter and inverter) |
| `build-top` | Build TOP cell (check PR boundary, Verilog, LEF, LIB, copy GDS, and render images) |
| `check-boundary` | Check that the TOP cell layout carries the PR boundary box on layer 235 that the chip flow needs |
| `lef` | Export LEF from the TOP cell layout using Magic |
| `lib` | Generate a Liberty timing library for the TOP cell |
| `verilog` | Generate a Verilog stub of the TOP cell from Magic or KLayout PEX netlist pins |
| `copy-gds` | Copy the TOP cell GDS from `layout/` to `final/gds/` |
| `render-gds` | Render images from the final GDS using `sak-render.py` |
| `klayout-drc [CELL=] [DRC_LEVEL=]` | Run KLayout DRC of the `CELL` cell |
| `magic-drc [CELL=]` | Run Magic DRC of the `CELL` cell |
| `klayout-lvs-netlist [CELL=] [EV_PRECISION=]` | Export CDL schematic netlist from Xschem for KLayout LVS |
| `klayout-lvs [CELL=]` | Run KLayout LVS of the `CELL` cell |
| `magic-lvs-netlist [CELL=] [EV_PRECISION=]` | Export SPICE schematic netlist from Xschem for Magic + Netgen LVS |
| `magic-lvs [CELL=]` | Run Magic + Netgen LVS of the `CELL` cell |
| `symbol-pex [CELL=]` | Build the Xschem PEX symbol `<CELL>_pex.sym` from `<CELL>.sym` |
| `klayout-pex [CELL=] [EXT_MODE=]` | Run Parasitic Extraction with KPEX of the `CELL` cell |
| `magic-pex [CELL=] [EXT_MODE=] [THRESHOLD=] [MINRES=] [MINDELAY=]` | Run Parasitic Extraction with Magic of the `CELL` cell |
| `klayout-verify [CELL=]` | Verify `CELL` cell with KLayout |
| `klayout-verify-all` | Verify the top-level cell with KLayout (DRC, LVS) |
| `magic-verify [CELL=]` | Verify `CELL` cell with Magic |
| `magic-verify-all` | Verify the top-level cell with Magic (DRC, LVS, PEX) |
| `all` | Verify, build and simulate the macros and the TOP cell |
| `clean` | Delete all generated files and folders of the TOP cell (final, netlists, render, DRC/LVS reports, simulation outputs) |
| `clean-counter` | Delete all generated files and folders of the counter macro |
| `clean-inverter` | Delete all generated files and folders of the inverter macro |
| `clean-macros` | Delete all generated files and folders of all macros (counter and inverter) |
| `clean-all` | Delete all generated files and folders of the macros and the TOP cell |


## `macros/inverter` (`TOP = inverter`)

### Variables

| Variable | Default | Meaning |
| --- | --- | --- |
| `CELL` | `$(TOP)` | Cell name for verification targets |
| `EXT_MODE` | `3` | PEX mode: `1`=C-decoupled, `2`=C-coupled, `3`=full-RC |
| `THRESHOLD` | `10000` | full-RC (`EXT_MODE=3`) extresist threshold in mOhm, for `magic-pex` |
| `MINRES` | `1000` | full-RC (`EXT_MODE=3`) extresist minres in mOhm, for `magic-pex` |
| `MINDELAY` | `1` | full-RC (`EXT_MODE=3`) extresist mindelay in ps, for `magic-pex` |
| `DRC_LEVEL` | `macro` | KLayout DRC level for `klayout-drc`: `precheck`\|`macro`\|`regular` |
| `SKIP_KLAYOUT_LVS` | `0` | Set to `1` to skip `klayout-lvs` inside `klayout-verify`/`klayout-verify-all`/`all` (`magic-lvs` still runs) |
| `EV_PRECISION` | `5` | Significant digits for Xschem's `ev` function during netlisting |
| `TB` | `<CELL>_tb_tran` | Testbench for `sim-xschem` |
| `SCRIPT` | `plot_<CELL>` | Plotting script for `sim-view-xschem` |
| `OPEN_ARGS` | *(empty)* | Extra flags passed to `sak-open.py` for `open` |

### Targets

| Target | What it does |
| --- | --- |
| `help` | Show this help message |
| `open` | Open the design files of this folder in the `sak-open.py` file browser (needs the VNC/X11 desktop) |
| `sim-xschem [TB=]` | Run TB simulation with Xschem in batch mode |
| `sim-view-xschem [SCRIPT=]` | Plot Xschem simulation results |
| `sim-cace` | Run CACE simulations and collect result plots |
| `sim-all` | Simulate the macro |
| `build-top` | Build TOP cell (Verilog, LEF, LIB, copy GDS, and render image) |
| `lef` | Export LEF from the TOP cell layout using Magic |
| `lib` | Generate a Liberty timing library for the TOP cell |
| `verilog` | Generate a Verilog stub of the TOP cell from Magic or KLayout PEX netlist pins |
| `copy-gds` | Copy the TOP cell GDS from `layout/` to `final/gds/` |
| `render-gds` | Render images from the final GDS using `sak-render.py` |
| `klayout-drc [CELL=] [DRC_LEVEL=]` | Run KLayout DRC of the `CELL` cell |
| `magic-drc [CELL=]` | Run Magic DRC of the `CELL` cell |
| `klayout-lvs-netlist [CELL=] [EV_PRECISION=]` | Export CDL schematic netlist from Xschem for KLayout LVS |
| `klayout-lvs [CELL=]` | Run KLayout LVS of the `CELL` cell |
| `magic-lvs-netlist [CELL=] [EV_PRECISION=]` | Export SPICE schematic netlist from Xschem for Magic + Netgen LVS |
| `magic-lvs [CELL=]` | Run Magic + Netgen LVS of the `CELL` cell |
| `symbol-pex [CELL=]` | Build the Xschem PEX symbol `<CELL>_pex.sym` from `<CELL>.sym` |
| `klayout-pex [CELL=] [EXT_MODE=]` | Run Parasitic Extraction with KPEX of the `CELL` cell |
| `magic-pex [CELL=] [EXT_MODE=] [THRESHOLD=] [MINRES=] [MINDELAY=]` | Run Parasitic Extraction with Magic of the `CELL` cell |
| `klayout-verify [CELL=] [SKIP_KLAYOUT_LVS=]` | Verify `CELL` cell with KLayout |
| `klayout-verify-all` | Verify all main subcells with KLayout (DRC, LVS) |
| `magic-verify [CELL=]` | Verify `CELL` cell with Magic |
| `magic-verify-all` | Verify all main subcells with Magic (DRC, LVS, PEX) |
| `all` | Verify, build and simulate the TOP cell |
| `clean` | Delete all generated files and folders (final, netlists, render, DRC/LVS reports, simulation and CACE outputs) |


## `macros/counter` (`TOP = counter_top`)

### Variables

| Variable | Default | Meaning |
| --- | --- | --- |
| `CELL` | `$(TOP)` | Cell name for lint/simulation targets |
| `EXT_MODE` | `3` | PEX mode: `1`=C-decoupled, `2`=C-coupled, `3`=full-RC |
| `THRESHOLD` | `10000` | full-RC (`EXT_MODE=3`) extresist threshold in mOhm, for `magic-pex` |
| `MINRES` | `1000` | full-RC (`EXT_MODE=3`) extresist minres in mOhm, for `magic-pex` |
| `MINDELAY` | `1` | full-RC (`EXT_MODE=3`) extresist mindelay in ps, for `magic-pex` |
| `EV_PRECISION` | `5` | Significant digits for Xschem's `ev` function during netlisting |
| `WAVEFORM_VIEWER` | `gtkwave` | `gtkwave`\|`surfer`, used by `sim-view-verilog`/`sim-view-cocotb` |
| `TB` | `<CELL>_tb_tran` | Testbench for `sim-gl-xschem` |
| `SCRIPT` | `plot_<CELL>` | Plotting script for `sim-view-xschem` |
| `OPEN_ARGS` | *(empty)* | Extra flags passed to `sak-open.py` for `open` |
| `FORCE` | *(unset)* | Set to `1` to let `symbol-gl` overwrite an existing symbol instead of refusing |

### Targets

| Target | What it does |
| --- | --- |
| `help` | Show this help message |
| `open` | Open the design files of this folder in the `sak-open.py` file browser (needs the VNC/X11 desktop) |
| `lint-verilog [CELL=]` | Lint Verilog source files with Verilator |
| `lint-verilog-all` | Lint all Verilog source files (`counter`, `counter_top`) |
| `sim-rtl-verilog [CELL=]` | Run RTL simulation of `CELL` cell with Icarus Verilog |
| `sim-view-verilog [CELL=] [WAVEFORM_VIEWER=]` | View `CELL` cell Verilog simulation waveforms |
| `sim-rtl-cocotb [CELL=]` | Run RTL simulation of `CELL` cell with cocotb |
| `sim-gl-cocotb [CELL=]` | Run gate-level simulation of `CELL` cell with cocotb |
| `sim-view-cocotb [CELL=] [WAVEFORM_VIEWER=]` | View `CELL` cell cocotb simulation waveforms |
| `sim-gl-xschem [CELL=] [TB=]` | Run gate-level simulation of `CELL` cell with Xschem in batch mode |
| `sim-view-xschem [SCRIPT=]` | Plot Xschem simulation results |
| `sim-all` | Simulate the macro (RTL Verilog + RTL/GL cocotb + GL Xschem for `counter_top`) |
| `librelane` | Run LibreLane with Magic and KLayout DRC checks |
| `librelane-nodrc` | Run LibreLane without DRC checks |
| `librelane-magicdrc` | Run LibreLane with only Magic DRC checks |
| `librelane-klayoutdrc` | Run LibreLane with only KLayout DRC checks |
| `librelane-openroad` | Open the last LibreLane run in OpenROAD GUI |
| `librelane-klayout` | Open the last LibreLane run in KLayout |
| `copy-reports` | Copy yosys, antenna, STA, power, IR-drop, DRC, LVS and manufacturability reports from the last LibreLane run to `verification/` |
| `copy-final` | Copy final output gds, lef, lib, nl, pnl, spef, and vh folders from the last LibreLane run to `final/` |
| `copy-netlist` | Copy final output spice, pnl and nl netlists from the last LibreLane run to `netlist/` |
| `copy-render` | Copy macro render from the last LibreLane run to `render/img/` |
| `render-gds` | Render images from the final GDS using `sak-render.py` |
| `symbol-gl [CELL=] [FORCE=1]` | Scaffold `<CELL>.sym` for a new macro, once, from the powered netlist ports |
| `symbol-check [CELL=]` | Check `<CELL>.sym` against the powered netlist ports, runs inside `generate-xspice` |
| `generate-xspice` | Generate XSPICE model from the LibreLane-extracted SPICE netlist |
| `build-fpga` | Build target for FPGA usage |
| `build-top` | Build macro (run LibreLane with KLayout & Magic DRC checks, copy reports, copy final files, copy netlists, generate XSPICE model, copy render, and render final GDS) |
| `symbol-pex [CELL=]` | Build the Xschem PEX symbol `<CELL>_pex.sym` from `<CELL>.sym` |
| `klayout-pex [CELL=] [EXT_MODE=]` | Run Parasitic Extraction with KPEX on the final GDS |
| `magic-pex [CELL=] [EXT_MODE=] [THRESHOLD=] [MINRES=] [MINDELAY=]` | Run Parasitic Extraction with Magic on the final GDS |
| `all` | Lint, build, verify and simulate the macro |
| `clean` | Delete all generated files and folders (LibreLane runs, final, netlists, render, reports, simulation and FPGA outputs) |


## To-Do

Top-level (this directory, outside `macros/`) gaps against the `gf180mcu_chipalooza_analog_project` template:

- **Fill insertion** — gf180's top-level Makefile has `gds-fill`/`gds-fill-comp`/`gds-fill-undo` targets (dummy-fill generation via `gdsfill`, DRC density compliance). No equivalent targets or scripts exist here yet.
- **Slot wrapper pull** — gf180's top-level Makefile has `pull-wrappers` (pulls floorplan slot wrapper GDS files from the `gf180mcu_ocd_chipalooza` harness repo) and `top-schem`/`top-layout` `SLOT=<N>` targets (sync the top schematic/layout to a floorplan slot's wrapper, pins and PEX symbol). There, `TOP` itself tracks whichever `slot_<N>` was last generated this way; here it's still the fixed literal `sky130_chipalooza_analog_project`, so that mechanism would need to change too once ported. Not ported here; this project's `floorplan/` still only has the inherited IHP placeholder GDS templates (see below), not a sky130 harness repo to pull from.
- **`SKIP_KLAYOUT_LVS`** — gf180's top-level Makefile has this variable and a conditional in `klayout-verify` to skip `klayout-lvs` (works around gf180mcuD's KLayout LVS runset not merging multi-finger devices; `magic-lvs` still runs). Already ported to `macros/inverter/Makefile` this session, but not to the top-level Makefile here.
- **`MIXED_LVS` / `magic-lvs-mixed`** — gf180's top-level Makefile has a `magic-lvs-mixed` target and a `MIXED_LVS` variable (`magic-verify [MIXED_LVS=]`) that splices in real netlists for hardened digital macros during top-level LVS. Needed once the `counter` macro is actually placed into the top-level layout; not ported here, and `magic-verify` currently always runs plain `magic-lvs`.
- **`load-drc-klayout [CELL=]` / `load-drc-magic [CELL=]`** — gf180's top-level Makefile has these convenience targets (open the KLayout/Magic GUI with `CELL`'s layout and DRC results already loaded, needs the VNC/X11 desktop). Not ported here.
- **Floorplan templates** — `floorplan/` still ships the **IHP** `ihp-sg13cmos5l` GDS templates unchanged. They establish the slot/pin convention but their actual layer numbers, pitch and metal stack are IHP's, not sky130A's. Needs real sky130 Chipalooza floorplan templates (or a re-derived layer mapping) before a top-level layout can be drawn from one.
- **Top-level schematic/layout** — no `schematic/xschem/sky130_chipalooza_analog_project.sch`, `.sym`, or `layout/sky130_chipalooza_analog_project.gds` exist yet (only each folder's `xschemrc`). `sim-xschem`, `build-top`, `check-boundary`, and every DRC/LVS/PEX target above need these to exist first.
