EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:Lattice_iCE_FPGA
LIBS:ft2232
LIBS:lt3030efe#trpbf
LIBS:74lvc8t245
LIBS:Switch
LIBS:Oscillators
LIBS:sram
LIBS:tda7050
LIBS:Connector
LIBS:SeeedOPL-Connector-2016
LIBS:fpgaboard-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 5 11
Title "Game Boy reverse eng. FPGA board"
Date "2019-01-20"
Rev "0"
Comp "Author: Michael Singer"
Comment1 "https://sourceforge.net/projects/iceboy/"
Comment2 "http://iceboy.a-singer.de/"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L iCE40-HX8K-CT256 U3
U 4 1 5C157D06
P 2200 6500
F 0 "U3" H 2400 6750 60  0000 L CNN
F 1 "iCE40-HX8K-CT256" H 2400 6650 60  0000 L CNN
F 2 "bga:BGA-256_14.0x14.0mm_Layout16x16_P0.8mm_Ball0.45mm_Pad0.32mm_NSMD" H 2200 6500 60  0001 C CNN
F 3 "" H 2200 6500 60  0001 C CNN
	4    2200 6500
	-1   0    0    1   
$EndComp
$Comp
L C C59
U 1 1 5C157E77
P 1950 1250
F 0 "C59" H 1975 1350 50  0000 L CNN
F 1 "100n" H 1975 1150 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 1988 1100 50  0001 C CNN
F 3 "" H 1950 1250 50  0001 C CNN
	1    1950 1250
	1    0    0    -1  
$EndComp
$Comp
L C C58
U 1 1 5C157EF4
P 1700 1250
F 0 "C58" H 1725 1350 50  0000 L CNN
F 1 "100n" H 1725 1150 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 1738 1100 50  0001 C CNN
F 3 "" H 1700 1250 50  0001 C CNN
	1    1700 1250
	1    0    0    -1  
$EndComp
$Comp
L C C57
U 1 1 5C157F49
P 1450 1250
F 0 "C57" H 1475 1350 50  0000 L CNN
F 1 "100n" H 1475 1150 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 1488 1100 50  0001 C CNN
F 3 "" H 1450 1250 50  0001 C CNN
	1    1450 1250
	1    0    0    -1  
$EndComp
$Comp
L C C56
U 1 1 5C157F7C
P 1200 1250
F 0 "C56" H 1225 1350 50  0000 L CNN
F 1 "100n" H 1225 1150 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 1238 1100 50  0001 C CNN
F 3 "" H 1200 1250 50  0001 C CNN
	1    1200 1250
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR069
U 1 1 5C15804E
P 2350 950
F 0 "#PWR069" H 2350 800 50  0001 C CNN
F 1 "+3V3" H 2350 1090 50  0000 C CNN
F 2 "" H 2350 950 50  0001 C CNN
F 3 "" H 2350 950 50  0001 C CNN
	1    2350 950 
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR070
U 1 1 5C158167
P 850 1450
F 0 "#PWR070" H 850 1200 50  0001 C CNN
F 1 "GND" H 850 1300 50  0000 C CNN
F 2 "" H 850 1450 50  0001 C CNN
F 3 "" H 850 1450 50  0001 C CNN
	1    850  1450
	1    0    0    -1  
$EndComp
Text Notes 2300 6400 0    60   ~ 0
~CRESET
Text Notes 2300 6500 0    60   ~ 0
CDONE
Text Notes 2300 1900 0    60   ~ 0
CBSEL0
Text Notes 2300 1800 0    60   ~ 0
CBSEL1
Text Notes 2750 1900 0    60   ~ 0
DipSW14
Text Notes 2750 1800 0    60   ~ 0
DipSW15
Text Label 2300 6300 0    60   ~ 0
MD7
Text Label 2300 6200 0    60   ~ 0
MD6
Text Label 2300 6100 0    60   ~ 0
MD5
Text Label 2300 6000 0    60   ~ 0
MD4
Text Label 2300 5900 0    60   ~ 0
MD3
Text Label 2300 5800 0    60   ~ 0
MD2
Text Label 2300 5700 0    60   ~ 0
MD1
Text Label 2300 5600 0    60   ~ 0
MD0
Text Label 2300 5500 0    60   ~ 0
EA15
Text Label 2300 5400 0    60   ~ 0
MA14
Text Label 2300 5100 0    60   ~ 0
MA13
Text Label 2300 5000 0    60   ~ 0
MA12
Text Label 2300 4900 0    60   ~ 0
MA11
Text Label 2300 4800 0    60   ~ 0
MA10
Text Label 2300 4600 0    60   ~ 0
MA9
Text Label 2300 4500 0    60   ~ 0
MA8
Text Label 2300 4400 0    60   ~ 0
MA7
Text Label 2300 4300 0    60   ~ 0
MA6
Text Label 2300 4200 0    60   ~ 0
MA5
Text Label 2300 4100 0    60   ~ 0
MA4
Text Label 2300 4000 0    60   ~ 0
MA3
Text Label 2300 3900 0    60   ~ 0
MA2
Text Label 2300 3400 0    60   ~ 0
MA1
Text Label 2300 3300 0    60   ~ 0
MA0
Text Label 2300 3200 0    60   ~ 0
EA16
Text Label 2300 3100 0    60   ~ 0
EA17
Text Label 2300 3000 0    60   ~ 0
EA18
Text Label 2300 2900 0    60   ~ 0
EA19
Text Label 2300 2800 0    60   ~ 0
EA20
Text Label 2300 2700 0    60   ~ 0
MA15
Entry Wire Line
	4900 5400 5000 5500
Entry Wire Line
	4900 5100 5000 5200
Entry Wire Line
	4900 5000 5000 5100
Entry Wire Line
	4900 4900 5000 5000
Entry Wire Line
	4900 4800 5000 4900
Entry Wire Line
	4900 4600 5000 4700
Entry Wire Line
	4900 4500 5000 4600
Entry Wire Line
	4900 4400 5000 4500
Entry Wire Line
	4900 4300 5000 4400
Entry Wire Line
	4900 4200 5000 4300
Entry Wire Line
	4900 4100 5000 4200
Entry Wire Line
	4900 4000 5000 4100
Entry Wire Line
	4900 3900 5000 4000
Entry Wire Line
	4900 3400 5000 3500
Entry Wire Line
	4900 3300 5000 3400
Entry Wire Line
	4900 2700 5000 2800
Text HLabel 3800 6800 3    60   Input ~ 0
~CRESET
Text HLabel 3500 6800 3    60   Output ~ 0
CDONE
$Comp
L +3V3 #PWR071
U 1 1 5C165B6B
P 5700 6300
F 0 "#PWR071" H 5700 6150 50  0001 C CNN
F 1 "+3V3" H 5700 6440 50  0000 C CNN
F 2 "" H 5700 6300 50  0001 C CNN
F 3 "" H 5700 6300 50  0001 C CNN
	1    5700 6300
	1    0    0    -1  
$EndComp
$Comp
L R R37
U 1 1 5C165BE5
P 5700 6550
F 0 "R37" V 5780 6550 50  0000 C CNN
F 1 "10k" V 5700 6550 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 5630 6550 50  0001 C CNN
F 3 "" H 5700 6550 50  0001 C CNN
	1    5700 6550
	1    0    0    -1  
$EndComp
$Comp
L R R36
U 1 1 5C166332
P 3050 6700
F 0 "R36" V 3130 6700 50  0000 C CNN
F 1 "649" V 3050 6700 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 2980 6700 50  0001 C CNN
F 3 "" H 3050 6700 50  0001 C CNN
	1    3050 6700
	0    1    1    0   
$EndComp
$Comp
L LED_ALT D18
U 1 1 5C16666D
P 2700 6900
F 0 "D18" H 2700 7000 50  0000 C CNN
F 1 "green" H 2700 6800 50  0000 C CNN
F 2 "LEDs:LED_0805" H 2700 6900 50  0001 C CNN
F 3 "" H 2700 6900 50  0001 C CNN
	1    2700 6900
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR072
U 1 1 5C1667D3
P 2700 7150
F 0 "#PWR072" H 2700 6900 50  0001 C CNN
F 1 "GND" H 2700 7000 50  0000 C CNN
F 2 "" H 2700 7150 50  0001 C CNN
F 3 "" H 2700 7150 50  0001 C CNN
	1    2700 7150
	1    0    0    -1  
$EndComp
Text HLabel 3500 1400 1    60   Input ~ 0
CBSEL0
Text HLabel 3400 1400 1    60   Input ~ 0
CBSEL1
Text HLabel 5000 1400 1    60   Output ~ 0
CART_MA_A[0..15]
$Comp
L GND #PWR073
U 1 1 5C16753B
P 8100 4500
F 0 "#PWR073" H 8100 4250 50  0001 C CNN
F 1 "GND" H 8100 4350 50  0000 C CNN
F 2 "" H 8100 4500 50  0001 C CNN
F 3 "" H 8100 4500 50  0001 C CNN
	1    8100 4500
	1    0    0    -1  
$EndComp
$Comp
L R R44
U 1 1 5C167796
P 8450 4100
F 0 "R44" V 8530 4100 50  0000 C CNN
F 1 "10k" V 8450 4100 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 8380 4100 50  0001 C CNN
F 3 "" H 8450 4100 50  0001 C CNN
	1    8450 4100
	1    0    0    -1  
$EndComp
Text HLabel 8600 5600 3    60   Output ~ 0
SDCARD_SW
$Comp
L C C60
U 1 1 5C169001
P 7800 4100
F 0 "C60" H 7825 4200 50  0000 L CNN
F 1 "100n" H 7825 4000 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 7838 3950 50  0001 C CNN
F 3 "" H 7800 4100 50  0001 C CNN
	1    7800 4100
	1    0    0    -1  
$EndComp
$Comp
L R R43
U 1 1 5C1691F7
P 7800 2650
F 0 "R43" V 7880 2650 50  0000 C CNN
F 1 "10k" V 7800 2650 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 7730 2650 50  0001 C CNN
F 3 "" H 7800 2650 50  0001 C CNN
	1    7800 2650
	1    0    0    -1  
$EndComp
$Comp
L R R42
U 1 1 5C1692E6
P 7600 2650
F 0 "R42" V 7680 2650 50  0000 C CNN
F 1 "10k" V 7600 2650 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 7530 2650 50  0001 C CNN
F 3 "" H 7600 2650 50  0001 C CNN
	1    7600 2650
	1    0    0    -1  
$EndComp
$Comp
L R R41
U 1 1 5C169385
P 7400 2650
F 0 "R41" V 7480 2650 50  0000 C CNN
F 1 "10k" V 7400 2650 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 7330 2650 50  0001 C CNN
F 3 "" H 7400 2650 50  0001 C CNN
	1    7400 2650
	1    0    0    -1  
$EndComp
$Comp
L R R40
U 1 1 5C16940C
P 7200 2650
F 0 "R40" V 7280 2650 50  0000 C CNN
F 1 "10k" V 7200 2650 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 7130 2650 50  0001 C CNN
F 3 "" H 7200 2650 50  0001 C CNN
	1    7200 2650
	1    0    0    -1  
$EndComp
$Comp
L R R39
U 1 1 5C1694B1
P 7000 2650
F 0 "R39" V 7080 2650 50  0000 C CNN
F 1 "10k" V 7000 2650 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 6930 2650 50  0001 C CNN
F 3 "" H 7000 2650 50  0001 C CNN
	1    7000 2650
	1    0    0    -1  
$EndComp
$Comp
L R R38
U 1 1 5C16954A
P 6800 2650
F 0 "R38" V 6880 2650 50  0000 C CNN
F 1 "10k" V 6800 2650 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 6730 2650 50  0001 C CNN
F 3 "" H 6800 2650 50  0001 C CNN
	1    6800 2650
	1    0    0    -1  
$EndComp
Entry Wire Line
	6200 3100 6300 3000
Entry Wire Line
	6200 3200 6300 3100
Entry Wire Line
	6200 3700 6300 3600
Entry Wire Line
	6200 3800 6300 3700
Text HLabel 8300 5600 3    60   BiDi ~ 0
SDCARD_D[0..3]
Text Label 6400 3000 0    60   ~ 0
SD2
Text Label 6400 3100 0    60   ~ 0
SD3
Text Label 6400 3700 0    60   ~ 0
SD1
Text Label 6400 3600 0    60   ~ 0
SD0
Text Notes 2600 2700 0    60   ~ 0
(~CS~)
Text HLabel 3600 1400 1    60   Output ~ 0
WRAM_~CS
Text HLabel 3700 1400 1    60   Output ~ 0
XRAM_~CS
Text HLabel 3800 1400 1    60   Output ~ 0
ROM_~CS
Text HLabel 3900 1400 1    60   Output ~ 0
CART_MA_DIR
Text HLabel 4000 1400 1    60   Output ~ 0
CART_MA_~CS
Text HLabel 4100 1400 1    60   Output ~ 0
CART_MA_~OE
Text HLabel 4200 1400 1    60   Output ~ 0
CART_MA_CLK
Text HLabel 4400 1400 1    60   Output ~ 0
CART_MA_~WR
Text HLabel 4500 1400 1    60   Output ~ 0
CART_MA_~RD
Text HLabel 4600 1400 1    60   Output ~ 0
CART_MA_~OE~_DATA
Text HLabel 4700 1400 1    60   BiDi ~ 0
CART_MA_~RST
Text HLabel 4800 1400 1    60   3State ~ 0
CART_MA_D[0..7]
Entry Wire Line
	4700 5600 4800 5700
Entry Wire Line
	4700 5700 4800 5800
Entry Wire Line
	4700 5800 4800 5900
Entry Wire Line
	4700 5900 4800 6000
Entry Wire Line
	4700 6000 4800 6100
Entry Wire Line
	4700 6100 4800 6200
Entry Wire Line
	4700 6200 4800 6300
Entry Wire Line
	4700 6300 4800 6400
Text Notes 2300 2000 0    60   ~ 0
WRAM_~CS
Text Notes 2300 2300 0    60   ~ 0
XRAM_~CS
Text Notes 2300 2400 0    60   ~ 0
ROM_~CS
Text Notes 2300 2500 0    60   ~ 0
DIR
Text Notes 2300 2600 0    60   ~ 0
~CS
Text Notes 2300 3600 0    60   ~ 0
CLK
Text Notes 2300 3800 0    60   ~ 0
~WR
Text Notes 2300 4700 0    60   ~ 0
~RD
Text Notes 2300 5200 0    60   ~ 0
~OE~_DATA
Text Notes 2300 5300 0    60   ~ 0
~RST
Wire Wire Line
	2350 1700 2200 1700
Wire Wire Line
	2350 950  2350 1700
Wire Wire Line
	1200 1500 8100 1500
Wire Wire Line
	1200 1500 1200 1400
Connection ~ 2350 1500
Wire Wire Line
	1950 1400 1950 1500
Connection ~ 1950 1500
Wire Wire Line
	1700 1500 1700 1400
Connection ~ 1700 1500
Wire Wire Line
	1450 1400 1450 1500
Connection ~ 1450 1500
Wire Wire Line
	1950 1100 1950 1000
Wire Wire Line
	1950 1000 850  1000
Wire Wire Line
	850  1000 850  1450
Wire Wire Line
	1200 1100 1200 1000
Connection ~ 1200 1000
Wire Wire Line
	1450 1100 1450 1000
Connection ~ 1450 1000
Wire Wire Line
	1700 1100 1700 1000
Connection ~ 1700 1000
Wire Wire Line
	2200 2700 4900 2700
Wire Wire Line
	2200 3300 4900 3300
Wire Wire Line
	2200 3400 4900 3400
Wire Wire Line
	2200 3900 4900 3900
Wire Wire Line
	2200 4000 4900 4000
Wire Wire Line
	2200 4100 4900 4100
Wire Wire Line
	2200 4200 4900 4200
Wire Wire Line
	2200 4300 4900 4300
Wire Wire Line
	2200 4400 4900 4400
Wire Wire Line
	2200 4500 4900 4500
Wire Wire Line
	2200 4600 4900 4600
Wire Wire Line
	2200 4800 4900 4800
Wire Wire Line
	2200 4900 4900 4900
Wire Wire Line
	2200 5000 4900 5000
Wire Wire Line
	2200 5100 4900 5100
Wire Wire Line
	2200 5400 4900 5400
Wire Wire Line
	2200 2200 5900 2200
Wire Wire Line
	2200 2100 6000 2100
Wire Wire Line
	2200 6400 3800 6400
Wire Wire Line
	3800 6400 3800 6800
Wire Wire Line
	2200 6500 3500 6500
Wire Wire Line
	3500 6500 3500 6800
Wire Wire Line
	5700 6750 5700 6700
Wire Wire Line
	3800 6750 5700 6750
Connection ~ 3800 6750
Wire Wire Line
	5700 6300 5700 6400
Wire Wire Line
	3250 1500 3250 6700
Wire Wire Line
	3250 6700 3200 6700
Wire Wire Line
	2850 6700 2850 6500
Connection ~ 2850 6500
Wire Wire Line
	2700 6700 2900 6700
Wire Wire Line
	2700 6700 2700 6750
Connection ~ 2850 6700
Wire Wire Line
	2700 7050 2700 7150
Wire Wire Line
	7800 3300 8700 3300
Wire Wire Line
	8100 1500 8100 3300
Connection ~ 3250 1500
Wire Wire Line
	8700 3500 8100 3500
Wire Wire Line
	8100 3500 8100 4500
Connection ~ 8100 4450
Wire Wire Line
	7800 4450 7800 4250
Wire Wire Line
	7800 3950 7800 3300
Connection ~ 8100 3300
Wire Wire Line
	8700 3600 6300 3600
Wire Wire Line
	8700 3700 6300 3700
Wire Wire Line
	8700 3000 6300 3000
Wire Wire Line
	8700 3100 6300 3100
Wire Wire Line
	8700 3200 7700 3200
Wire Wire Line
	7700 3200 7700 3300
Wire Wire Line
	7800 2800 7800 3000
Connection ~ 7800 3000
Wire Wire Line
	7600 2800 7600 3100
Connection ~ 7600 3100
Wire Wire Line
	7400 2800 7400 3300
Connection ~ 7400 3300
Wire Wire Line
	7200 2800 7200 3400
Connection ~ 7200 3400
Wire Wire Line
	7000 2800 7000 3600
Connection ~ 7000 3600
Wire Wire Line
	6800 2800 6800 3700
Connection ~ 6800 3700
Wire Wire Line
	6800 2500 6800 1500
Connection ~ 6800 1500
Wire Wire Line
	7000 2500 7000 1500
Connection ~ 7000 1500
Wire Wire Line
	7200 2500 7200 1500
Connection ~ 7200 1500
Wire Wire Line
	7400 2500 7400 1500
Connection ~ 7400 1500
Wire Wire Line
	7600 2500 7600 1500
Connection ~ 7600 1500
Wire Wire Line
	7800 2500 7800 1500
Connection ~ 7800 1500
Wire Bus Line
	6200 2900 6200 5500
Wire Bus Line
	6200 5500 8300 5500
Wire Bus Line
	8300 5500 8300 5600
Wire Wire Line
	3400 1400 3400 1800
Wire Wire Line
	3500 1400 3500 1900
Wire Wire Line
	3500 1900 2200 1900
Wire Wire Line
	8700 3400 6000 3400
Wire Wire Line
	6000 3400 6000 2100
Wire Wire Line
	7700 3300 5900 3300
Wire Wire Line
	5900 3300 5900 2200
Wire Wire Line
	2300 2800 2200 2800
Wire Wire Line
	2300 2900 2200 2900
Wire Wire Line
	2300 3000 2200 3000
Wire Wire Line
	2300 3100 2200 3100
Wire Wire Line
	2300 3200 2200 3200
Wire Wire Line
	2300 5500 2200 5500
Wire Bus Line
	5000 1400 5000 5600
Wire Bus Line
	4800 1400 4800 6500
Wire Wire Line
	2200 5600 4700 5600
Wire Wire Line
	2200 6300 4700 6300
Wire Wire Line
	3600 2000 3600 1400
Wire Wire Line
	3700 2300 3700 1400
Wire Wire Line
	3800 2400 3800 1400
Wire Wire Line
	3900 2500 3900 1400
Wire Wire Line
	4000 2600 4000 1400
Wire Wire Line
	4100 3500 4100 1400
Wire Wire Line
	4200 3600 4200 1400
Wire Wire Line
	2200 3800 4400 3800
Wire Wire Line
	4400 3800 4400 1400
Wire Wire Line
	2200 4700 4500 4700
Wire Wire Line
	4500 4700 4500 1400
Wire Wire Line
	2200 5200 4600 5200
Wire Wire Line
	4600 5200 4600 1400
Wire Wire Line
	2200 5300 4700 5300
Wire Wire Line
	4700 5300 4700 1400
Wire Wire Line
	2200 5700 4700 5700
Wire Wire Line
	4700 5800 2200 5800
Wire Wire Line
	2200 5900 4700 5900
Wire Wire Line
	4700 6000 2200 6000
Wire Wire Line
	2200 6100 4700 6100
Wire Wire Line
	4700 6200 2200 6200
Text HLabel 5100 1400 1    60   Output ~ 0
ONBRD_A[15..20]
Wire Bus Line
	5100 3100 5100 1400
Entry Wire Line
	5100 3000 5200 2900
Entry Wire Line
	5100 2900 5200 2800
Entry Wire Line
	5100 2800 5200 2700
Entry Wire Line
	5100 2700 5200 2600
Entry Wire Line
	5100 2600 5200 2500
Entry Wire Line
	5100 2500 5200 2400
Text Label 5700 2900 2    60   ~ 0
EA20
Text Label 5700 2800 2    60   ~ 0
EA19
Text Label 5700 2700 2    60   ~ 0
EA18
Text Label 5700 2600 2    60   ~ 0
EA17
Text Label 5700 2500 2    60   ~ 0
EA16
Text Label 5700 2400 2    60   ~ 0
EA15
Wire Wire Line
	5200 2900 5700 2900
Wire Wire Line
	5200 2800 5700 2800
Wire Wire Line
	5200 2700 5700 2700
Wire Wire Line
	5200 2600 5700 2600
Wire Wire Line
	5200 2500 5700 2500
Wire Wire Line
	5700 2400 5200 2400
Text Label 4800 1950 1    60   ~ 0
MD[0..7]
Text Label 5000 1950 1    60   ~ 0
MA[0..15]
Text Label 5100 1950 1    60   ~ 0
EA[15..20]
Text Label 7000 5500 0    60   ~ 0
SD[0..3]
Wire Wire Line
	3400 1800 2200 1800
Wire Wire Line
	3600 2000 2200 2000
Wire Wire Line
	3700 2300 2200 2300
Wire Wire Line
	3800 2400 2200 2400
Wire Wire Line
	3900 2500 2200 2500
Wire Wire Line
	4000 2600 2200 2600
Wire Wire Line
	4100 3500 2200 3500
Wire Wire Line
	4200 3600 2200 3600
Wire Wire Line
	2200 3700 4300 3700
Wire Wire Line
	4300 3700 4300 1400
Text Notes 2300 3700 0    60   ~ 0
~PROG
Text HLabel 4300 1400 1    60   Output ~ 0
ONBRD_~PROG
Wire Wire Line
	7450 4450 10500 4450
$Comp
L Micro_SD_Card_Det_Hirose_DM3AT J11
U 1 1 5C26428C
P 9600 3400
F 0 "J11" H 8950 4100 50  0000 C CNN
F 1 "Micro_SD_Card_Det_Hirose_DM3AT" H 10450 4100 50  0000 R CNN
F 2 "conn_card:microSD_HC_Hirose_DM3AT-SF-PEJM5" H 11650 4100 50  0001 C CNN
F 3 "" H 9600 3500 50  0001 C CNN
	1    9600 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8450 3900 8700 3900
Wire Wire Line
	8600 3900 8600 5600
Wire Wire Line
	8700 3800 8600 3800
Wire Wire Line
	8600 3800 8600 3300
Connection ~ 8600 3300
Wire Wire Line
	8450 4250 8450 4450
Connection ~ 8450 4450
Wire Wire Line
	8450 3950 8450 3900
Connection ~ 8600 3900
Wire Wire Line
	10500 4450 10500 3900
Wire Wire Line
	10500 3900 10400 3900
$Comp
L C C111
U 1 1 5C3BCAB9
P 7450 4100
F 0 "C111" H 7475 4200 50  0000 L CNN
F 1 "100µ" H 7475 4000 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206" H 7488 3950 50  0001 C CNN
F 3 "" H 7450 4100 50  0001 C CNN
	1    7450 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 3800 7450 3800
Wire Wire Line
	7450 3800 7450 3950
Connection ~ 7800 3800
Wire Wire Line
	7450 4450 7450 4250
Connection ~ 7800 4450
Text Label 2300 2100 0    60   ~ 0
SDCARD_CLK
Text Label 2300 2200 0    60   ~ 0
SDCARD_CMD
Text Notes 2300 3500 0    60   ~ 0
~OE
$EndSCHEMATC