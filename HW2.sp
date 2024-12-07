***-----------------------***
***        setting        ***
***-----------------------***
.lib "~/U18_HSPICE_Model/mm180_reg18_v124.lib" tt
.TEMP T
.op
***-----------------------***
***       simulation      *** 
***-----------------------***
.option post
.DC Vgs  0V 1.8V 0.05V sweep T 0 80 10
.probe id_mos = I(MN)

***-----------------------***
***      parameters       ***
***-----------------------***
.param wn = 6u 
.param ln = 0.9u
.param wp = 5u 
.param lp = 1u
.global VDD GND

***-----------------------***
***      power/input      ***
***-----------------------***
Vsupply VDD GND 1.8v
*              SIN(Offset   Amplitude   Freq.   Delay )
Vgs     Vin GND 1.8v
***-----------------------***
***        circuit        ***
***-----------------------***
MP  Vout    Vout    VDD     VDD    p_18_mm w=wp l=lp 
MN  Vout    Vin     GND     GND    n_18_mm w=wn l=ln 

.end