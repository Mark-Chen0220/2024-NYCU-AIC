***-----------------------***
***        setting        ***
***-----------------------***
.lib "~/U18_HSPICE_Model/mm180_reg18_v124.lib" tt
.TEMP 25
.op
***-----------------------***
***       simulation      *** 
***-----------------------***

.option post 
.AC DEC 100 1n 100G

***-----------------------***
***      parameters       ***
***-----------------------***
.global VDD GND
***-----------------------***
***       measure         ***
***-----------------------***
.measure ac Gain_a      FIND V(VOUT_a) at=10000Hz
.measure ac Gain_b      FIND V(VOUT_b) at=10000Hz
.measure ac Gain_c      FIND V(VOUT_c) at=10000Hz


***-----------------------***
***      power/input      ***
***-----------------------***
Vsupply VDD GND 1.8V

***-----------------------***
***        circuit        ***
***-----------------------***

Xa  VIN_a   VOUT_a  CKT_A
Xb  VIN_b   VOUT_b  CKT_B
Xc  VIN_c   VOUT_c  CKT_C

.subckt CKT_A   VIN     VOUT
RD  VDD     VOUT   15k
RS  VIN     Gate   10k
MN  VOUT    Gate   GND     GND      n_18_mm w=13u l=1.3u
C1  VOUT    GND    0.02p
V1  VIN     GND    DC      0.6V     AC  1
.ends

.subckt CKT_B   VIN     VOUT
RD  VDD     VOUT   15k
RS  VIN     Source 1k
MN  VOUT    Vb     Source  GND      n_18_mm w=13u l=1.3u
C1  VOUT    GND    0.02p
V1  VIN     GND    DC      0.3V     AC  1
V2  Vb      GND    DC      0.9V 
.ends

.subckt CKT_C   VIN     VOUT
RD  VDD     VOUT   15k
RS  VIN     G1     10k
MN2 VOUT    Vb     VX      VX      n_18_mm w=13u l=1.3u
MN1 VX      G1     GND     GND     n_18_mm w=13u l=1.3u
C1  VOUT    GND    0.02p
V1  VIN     GND    DC      0.6V     AC  1
V3  Vb      GND    0.9V 
.ends

.end