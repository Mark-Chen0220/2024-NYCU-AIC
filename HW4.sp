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
.ac    DEC  100 1 150Meg 
*100 每10倍100個點
.noise V(VOUT_a)   VA  1
*每'interval'個點積分一次

.probe tran Vout=V(x,y)
.probe tran Vin =V(V_diff+, V_diff-)

***-----------------------***
***      parameters       ***
***-----------------------***
.global VDD GND
***-----------------------***
***       measure         ***
***-----------------------***
.meas AC A_gainmax max vdb(VOUT_a)
.meas AC A_f3db when vdb(VOUT_a)='A_gainmax-3.0'
.meas AC B_gainmax max vdb(VOUT_b)
.meas AC B_f3db when vdb(VOUT_b)='B_gainmax-3.0'
.meas AC C_gainmax max vdb(VOUT_c)
.meas AC C_f3db when vdb(VOUT_c)='C_gainmax-3.0'
***-----------------------***
***      power/input      ***
***-----------------------***
Vsupply VDD GND 1.8V
VA  VIN_a     GND    DC      0.6V     AC  1
VC  VIN_c     GND    DC      0.6V     AC  1

***-----------------------***
***        circuit        ***
***-----------------------***
Xa  VIN_a   VOUT_a  CKT_A
Xc  VIN_c   VOUT_c  CKT_C

.subckt CKT_A   VIN     VOUT
RD  VDD     VOUT   15k
RS  VIN     Gate   10k
MN  VOUT    Gate   GND     GND      n_18_mm w=13u l=1.3u
C1  VOUT    GND    0.02p
*V1  VIN     GND    DC      0.6V     AC  1
.ends

.subckt CKT_B   VIN     VOUT
RD  VDD     VOUT   15k
RS  VIN     Source 10k
MN  VOUT    Vb     Source  GND      n_18_mm w=13u l=1.3u
C1  VOUT    GND    0.02p
V1  VIN     GND    DC      0.3V     AC  1
V2  Vb      GND    DC      0.9V 
.ends

.subckt CKT_C   VIN    VOUT
RD  VDD     VOUT   15k
RS  VIN     G1     10k
MN2 VOUT    Vb     VX      VX      n_18_mm w=13u l=1.3u
MN1 VX      G1     GND     GND     n_18_mm w=13u l=1.3u
C1  VOUT    GND    0.02p
V3  Vb      GND    0.9V 
.ends

.alter 
.noise V(VOUT_c)   VC  1

.end