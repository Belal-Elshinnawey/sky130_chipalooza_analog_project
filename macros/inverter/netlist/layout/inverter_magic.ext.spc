* NGSPICE file created from inverter.ext - technology: sky130A

.subckt inverter VDD VSS vin vout
X0 VDD vin vout VDD sky130_fd_pr__pfet_g5v0d10v5 ad=0.5 pd=2.5 as=0.5 ps=2.5 w=2 l=2.5
X1 vout vin VSS VSS sky130_fd_pr__nfet_g5v0d10v5 ad=0.5 pd=2.5 as=0.6 ps=4.6 w=2 l=2.5
X2 vout vin VDD VDD sky130_fd_pr__pfet_g5v0d10v5 ad=0.5 pd=2.5 as=0.6 ps=4.6 w=2 l=2.5
X3 vout vin VDD VDD sky130_fd_pr__pfet_g5v0d10v5 ad=0.5 pd=2.5 as=0.5 ps=2.5 w=2 l=2.5
X4 VDD vin vout VDD sky130_fd_pr__pfet_g5v0d10v5 ad=0.5 pd=2.5 as=0.5 ps=2.5 w=2 l=2.5
X5 vout vin VDD VDD sky130_fd_pr__pfet_g5v0d10v5 ad=0.5 pd=2.5 as=0.5 ps=2.5 w=2 l=2.5
X6 vout vin VSS VSS sky130_fd_pr__nfet_g5v0d10v5 ad=0.5 pd=2.5 as=0.5 ps=2.5 w=2 l=2.5
X7 VDD vin vout VDD sky130_fd_pr__pfet_g5v0d10v5 ad=0.5 pd=2.5 as=0.5 ps=2.5 w=2 l=2.5
X8 VSS vin vout VSS sky130_fd_pr__nfet_g5v0d10v5 ad=0.5 pd=2.5 as=0.5 ps=2.5 w=2 l=2.5
X9 VDD vin vout VDD sky130_fd_pr__pfet_g5v0d10v5 ad=0.5 pd=2.5 as=0.5 ps=2.5 w=2 l=2.5
X10 vout vin VSS VSS sky130_fd_pr__nfet_g5v0d10v5 ad=0.5 pd=2.5 as=0.5 ps=2.5 w=2 l=2.5
X11 VSS vin vout VSS sky130_fd_pr__nfet_g5v0d10v5 ad=0.5 pd=2.5 as=0.5 ps=2.5 w=2 l=2.5
X12 vout vin VDD VDD sky130_fd_pr__pfet_g5v0d10v5 ad=0.5 pd=2.5 as=0.5 ps=2.5 w=2 l=2.5
X13 vout vin VSS VSS sky130_fd_pr__nfet_g5v0d10v5 ad=0.5 pd=2.5 as=0.5 ps=2.5 w=2 l=2.5
X14 VSS vin vout VSS sky130_fd_pr__nfet_g5v0d10v5 ad=0.5 pd=2.5 as=0.5 ps=2.5 w=2 l=2.5
X15 VDD vin vout VDD sky130_fd_pr__pfet_g5v0d10v5 ad=0.6 pd=4.6 as=0.5 ps=2.5 w=2 l=2.5
X16 VSS vin vout VSS sky130_fd_pr__nfet_g5v0d10v5 ad=0.5 pd=2.5 as=0.5 ps=2.5 w=2 l=2.5
X17 vout vin VDD VDD sky130_fd_pr__pfet_g5v0d10v5 ad=0.5 pd=2.5 as=0.5 ps=2.5 w=2 l=2.5
X18 vout vin VSS VSS sky130_fd_pr__nfet_g5v0d10v5 ad=0.5 pd=2.5 as=0.5 ps=2.5 w=2 l=2.5
X19 VSS vin vout VSS sky130_fd_pr__nfet_g5v0d10v5 ad=0.6 pd=4.6 as=0.5 ps=2.5 w=2 l=2.5
.ends

