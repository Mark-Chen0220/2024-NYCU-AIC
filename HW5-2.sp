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
.ac    DEC  100 1 200Meg 
*100 每10倍100個點
.probe AC Vdb(Vout+, Vout-), P(Vout+, Vout-)
.tran 0.1n 1m
.probe tran V(Vout+, Vout-)
.tf   V(Vout+, Vout-)   V_common

***-----------------------***
***      parameters       ***
***-----------------------***
.global VDD GND
***-----------------------***
***       measure         ***
***-----------------------***

***-----------------------***
***      power/input      ***
***-----------------------***
Vsupply VDD vss 1.8V
* V1  Vin+     GND    DC      0.8V    AC    1  
* V2  Vin-     GND    DC      0.8V 

V1          Vin+    Common    DC      0.8V
V2          Vin-    Common    DC      0.8V
V_common    Common    vss     DC      0V    AC      1
Vgnd    GND 0   0V
VSS     vss GND 0V


V3  Vcmo     vss    0.9V
I1  VDD      Vb2    50uA
I2  Vb3      vss    50uA
I3  Vb4      vss    50uA

***-----------------------***
***        circuit        ***
***-----------------------***
Mb1     Vb2     Vb2     vss     vss     n_18_mm w=3u   l=4u     ad=0.48u*3u as=0.48u*3u pd=0.96u+3u ps=0.96u+3u
Mb2     Vb3     Vb3     VDD     VDD     p_18_mm w=15u  l=4u     ad=0.48u*15u as=0.48u*15u pd=0.96u+15u ps=0.96u+15u
Mb3     N1      Vb4     VDD     VDD     p_18_mm w=90u  l=4u     ad=0.48u*90u as=0.48u*90u pd=0.96u+90u ps=0.96u+90u
Mb4     Vb4     Vb3     N1      VDD     p_18_mm w=50u  l=4u     ad=0.48u*50u as=0.48u*50u pd=0.96u+50u ps=0.96u+50u

MSS     N2      Vb1     vss     vss     n_18_mm w=150u l=8u     ad=0.48u*150u as=0.48u*150u pd=0.96u+150u ps=0.96u+150u
M1      N3      Vin+    N2      vss     n_18_mm w=60u  l=4u     ad=0.48u*60u as=0.48u*60u pd=0.96u+60u ps=0.96u+60u
M2      N4      Vin-    N2      vss     n_18_mm w=60u  l=4u     ad=0.48u*60u as=0.48u*60u pd=0.96u+60u ps=0.96u+60u
M3      Vout-   Vb2     N3      vss     n_18_mm w=65u  l=4u     ad=0.48u*65u as=0.48u*65u pd=0.96u+65u ps=0.96u+65u
M4      Vout+   Vb2     N4      vss     n_18_mm w=65u  l=4u     ad=0.48u*65u as=0.48u*65u pd=0.96u+65u ps=0.96u+65u

CL1     Vout-   vss     5p
CL2     Vout+   vss     5p

M5      Vout-   Vb3     N5      VDD     p_18_mm w=50u  l=4u     ad=0.48u*50u as=0.48u*50u pd=0.96u+50u ps=0.96u+50u
M6      Vout+   Vb3     N6      VDD     p_18_mm w=50u  l=4u     ad=0.48u*50u as=0.48u*50u pd=0.96u+50u ps=0.96u+50u
M7      N5      Vb4     VDD     VDD     p_18_mm w=90u  l=4u     ad=0.48u*90u as=0.48u*90u pd=0.96u+90u ps=0.96u+90u
M8      N6      Vb4     VDD     VDD     p_18_mm w=90u  l=4u     ad=0.48u*90u as=0.48u*90u pd=0.96u+90u ps=0.96u+90u

M9      Vb1     Vb1     vss     vss     n_18_mm w=8u   l=8u     ad=0.48u*8u as=0.48u*8u pd=0.96u+8u ps=0.96u+8u
M10     N7      N7      vss     vss     n_18_mm w=8u   l=8u     ad=0.48u*8u as=0.48u*8u pd=0.96u+8u ps=0.96u+8u
M11     N7      Vout-   N8      N8      p_18_mm w=5u   l=1u     ad=0.48u*5u as=0.48u*5u pd=0.96u+5u ps=0.96u+5u
M12     Vb1     Vcmo    N8      N8      p_18_mm w=5u   l=1u     ad=0.48u*5u as=0.48u*5u pd=0.96u+5u ps=0.96u+5u
M13     Vb1     Vcmo    N9      N9      p_18_mm w=5u   l=1u     ad=0.48u*5u as=0.48u*5u pd=0.96u+5u ps=0.96u+5u
M14     N7      Vout+   N9      N9      p_18_mm w=5u   l=1u     ad=0.48u*5u as=0.48u*5u pd=0.96u+5u ps=0.96u+5u
M15     N8      Vb4     VDD     VDD     p_18_mm w=9u   l=4u     ad=0.48u*9u as=0.48u*9u pd=0.96u+9u ps=0.96u+9u
M16     N9      Vb4     VDD     VDD     p_18_mm w=9u   l=4u     ad=0.48u*9u as=0.48u*9u pd=0.96u+9u ps=0.96u+9u

.alter
*measures gain from GND
.tf   V(Vout+, Vout-)   VSS
V_common    Common    vss    DC      0V
VSS         vss       GND    DC      0V     AC 1


.alter
*measures gain from VDD
.tf   V(Vout+, Vout-)   Vsupply
V_common    Common    vss    DC      0V
VSS         vss       GND    DC      0V  
Vsupply     VDD       vss    DC      1.8V   AC 1

.end