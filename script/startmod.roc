log === startdigmod ===

--- set voltages and current limits
vd 2600 mV
va 1600 mV
id  800 mA
ia  800 mA

--- setup timing & levels -------------------
clk  4
ctr  4  (CLK + 0)
sda 19  (CLK + 15)
tin  9  (CLK + 5)

clklvl 10
ctrlvl 10
sdalvl 10
tinlvl 10

--- power on --------------------------------
pon
mdelay 400
resoff
mdelay 200

--- setup TBM08: 2 cores at E and F

modsel b11111

tbmset $E4 $F0    Init TBM, Reset ROC
tbmset $F4 $F0

tbmset $E0 $01    Disable PKAM Counter
tbmset $F0 $01

tbmset $E2 $C0    Mode = Calibration
tbmset $F2 $C0

tbmset $E8 $10    Set PKAM Counter
tbmset $F8 $10

tbmset $EA b00000000 Delays
tbmset $FA b00000000

tbmset $EC $00    Temp measurement control
tbmset $FC $00

mdelay 100

--- setup all ROCs --------------------------

select :

dac   1   8  Vdig
dac   2 120  Vana
dac   3  40  Vsf
dac   4  12  Vcomp

dac   7  60  VwllPr
dac   9  60  VwllPr
dac  10 117  VhldDel
dac  11   1  Vtrim
dac  12  40  VthrComp

dac  13  30  VIBias_Bus
dac  14   6  Vbias_sf
dac  22  99  VIColOr

dac  15  60  VoffsetOp
dac  17 150  VoffsetRO
dac  18  45  VIon

dac  19  50  Vcomp_ADC
dac  20  70  VIref_ADC

dac  25 170  Vcal
dac  26  68  CalDel

dac  $fe 25  WBC
dac  $fd  4  CtrlReg
flush

mask

getid
getia

--- setup probe outputs ---------------------
d1 9  sync
a2 1  sdata
a1 3  ctr

--- setup readout timing --------------------

pgstop
pgset 0 b010000  15  pg_rest
pgset 1 b000100  30  pg_cal
pgset 2 b100010  30  pg_trg pg_sync

flush

