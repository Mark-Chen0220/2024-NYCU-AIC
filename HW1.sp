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
.DC V1  0V 1.8V 1mV sweep V2  0V 1.8V 0.2V
.probe id_mos = I(MN)

***-----------------------***
***      parameters       ***
***-----------------------***
.param wn = 5.4u 
.param ln = 1.8u
.param ls = 0.48u
.global VDD GND


***-----------------------***
***      power/input      ***
***-----------------------***
Vsupply VDD GND 1.8v
V1 Vds GND 1.8V
V2 Vgs GND 1.8V
***-----------------------***
***        circuit        ***
***-----------------------***
MN  Vds Vgs GND GND n_18_mm w=wn l=ln 
*AD = 'ls * wn' AS = 'ls * wn' PD = '2*ls + wn' PS = '2*ls + wn'

***-----------------------***
***         alter         ***
***-----------------------***
.end
