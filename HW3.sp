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
.tran 0.1n 30u


.DC V3  -3V 3V 0.05V
.probe Vout=V(x,y)
.probe Vin =V(V_diff+, V_diff-)
.probe I(M1_n)
.probe I(M2_n)

.tf V(x,y) V3

***-----------------------***
***      parameters       ***
***-----------------------***
.global VDD GND Vbs Vb


***-----------------------***
***       measure         ***
***-----------------------***

.meas tran Vx_max  max  v(x)   from=0.1ns to=30us
.meas tran Vx_min  min  v(x)   from=0.1ns to=30us
.meas tran Vx_Vpp  param ='Vx_max - Vx_min'

.meas tran Vy_max  max  v(y)   from=0.1ns to=30us
.meas tran Vy_min  min  v(y)   from=0.1ns to=30us
.meas tran Vy_Vpp  param ='Vy_max - Vy_min'

.meas tran Vin_max  max  v(V_diff+)   from=0.1ns to=30us
.meas tran Vin_min  min  v(V_diff+)   from=0.1ns to=30us
.meas tran Vin_Vpp  param ='Vin_max-Vin_min'

.meas tran Vout_max  param ='Vx_max - Vy_min'
.meas tran Vout_min  param ='Vx_min - Vy_max'
.meas tran Vout_Vpp  param ='Vout_max - Vout_min'

.meas tran Vdiff_max  max  v(Vdiff)   from=0.1ns to=30us
.meas tran Vdiff_min  min  v(Vdiff)   from=0.1ns to=30us
.meas tran Vdiff_Vpp  param ='Vdiff_max - Vdiff_min'
.meas tran V_common   max  v(N0)


.meas tran Adm  param ='-Vout_Vpp / Vdiff_Vpp'
*.meas tran Acm  param ='Vx_Vpp / Vin_Vpp'
*.meas tran CMRR param ='Adm / Acm'

*MAX tells Hspice to take the max value of V/I of variable during t1 ~ t2
***-----------------------***
***      power/input      ***
***-----------------------***
Vsupply VDD GND 3v
*              SIN(Offset   Amplitude   Freq.   Delay )
V1      Vbs GND 0.6v
V2      Vb  GND 2v
V3      Vdiff  GND SIN(0   0.004112   100k  0)
Vcm     N0  GND 1v
EV+     V_diff+ N0 Vdiff GND +0.5
EV-     V_diff- N0 Vdiff GND -0.5
***-----------------------***
***        circuit        ***
***-----------------------***
M3_p  X         Vb         VDD     VDD    p_18_mm w=10u l=0.3u
M4_p  Y         Vb         VDD     VDD    p_18_mm w=10u l=0.3u 
M1_n  X         V_diff+    Virtual GND    n_18_mm w=45u l=0.3u
M2_n  Y         V_diff-    Virtual GND    n_18_mm w=45u l=0.3u 
M5_n  Virtual   Vbs        GND     GND    n_18_mm w=75u l=1u
*X1  V_diff+  V_diff-  X   Y   CKT_A

.subckt CKT_A   V_diff+  V_diff-  X   Y
R1  VDD  X   5k
R2  VDD  Y   5k
M1_n  X         V_diff+    Virtual GND    n_18_mm w=45u l=0.3u
M2_n  Y         V_diff-    Virtual GND    n_18_mm w=45u l=0.3u 
M5_n  Virtual   Vbs        GND     GND    n_18_mm w=75u l=1u 
.ends

.subckt CKT_B   V_diff+  V_diff-  X   Y
M3_p  X         X        VDD       VDD    p_18_mm w=10u l=0.3u
M4_p  Y         Y        VDD       VDD    p_18_mm w=10u l=0.3u
M1_n  X         V_diff+  Virtual   GND    n_18_mm w=45u l=0.3u
M2_n  Y         V_diff-  Virtual   GND    n_18_mm w=45u l=0.3u 
M5_n  Virtual   Vbs      GND       GND    n_18_mm w=75u l=1u 
.ends

.subckt CKT_C   V_diff+  V_diff-  X   Y
M3_p  X         Vb         VDD     VDD    p_18_mm w=10u l=0.3u
M4_p  Y         Vb         VDD     VDD    p_18_mm w=10u l=0.3u 
M1_n  X         V_diff+    Virtual GND    n_18_mm w=45u l=0.3u
M2_n  Y         V_diff-    Virtual GND    n_18_mm w=45u l=0.3u 
M5_n  Virtual   Vbs        GND     GND    n_18_mm w=75u l=1u
.ends

.end