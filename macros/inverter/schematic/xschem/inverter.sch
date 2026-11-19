v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -60 50 -40 50 {lab=vin}
N -60 -60 -40 -60 {lab=vin}
N 0 0 30 -0 {lab=vout}
N 0 -180 0 -90 {lab=VDD}
N 0 -60 40 -60 {lab=VDD}
N 40 -120 40 -60 {lab=VDD}
N 0 -120 40 -120 {lab=VDD}
N 0 50 40 50 {lab=VSS}
N -120 -0 -60 0 {lab=vin}
N 40 50 40 70 {lab=VSS}
N 40 70 40 110 {lab=VSS}
N 0 -30 0 20 {lab=vout}
N -60 0 -60 50 {lab=vin}
N -60 -60 -60 -0 {lab=vin}
N -0 80 -0 170 {lab=VSS}
N 0 110 40 110 {lab=VSS}
C {sky130_fd_pr/pfet_g5v0d10v5_nf.sym} -20 -60 0 0 {name=M1
W=2
L=2.5
nf=10
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {iopin.sym} 0 -180 0 0 {name=p1 lab=VDD}
C {iopin.sym} 0 170 0 0 {name=p2 lab=VSS}
C {ipin.sym} -120 0 0 0 {name=p3 lab=vin}
C {opin.sym} 30 0 0 0 {name=p4 lab=vout}
C {sky130_fd_pr/nfet_g5v0d10v5_nf.sym} -20 50 0 0 {name=M2
W=2
L=2.5
nf=10
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
