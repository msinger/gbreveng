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
LIBS:fpgaboard-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 9 11
Title "Game Boy reverse eng. FPGA board"
Date "2020-04-24"
Rev "1"
Comp "CC-BY-SA-4.0 Michael Singer"
Comment1 "https://sourceforge.net/projects/iceboy/"
Comment2 "https://github.com/msinger/gbreveng/"
Comment3 "http://iceboy.a-singer.de/"
Comment4 ""
$EndDescr
$Comp
L CONN_01X06 J24
U 1 1 5C2B350E
P 10150 2200
F 0 "J24" H 10150 2550 50  0000 C CNN
F 1 "CONN_02X03" V 10250 2200 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x03_Pitch2.54mm" H 10150 2200 50  0001 C CNN
F 3 "" H 10150 2200 50  0001 C CNN
	1    10150 2200
	0    -1   -1   0   
$EndComp
$Comp
L C C89
U 1 1 5C2B3A62
P 9250 4350
F 0 "C89" H 9275 4450 50  0000 L CNN
F 1 "100p" H 9275 4250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 9288 4200 50  0001 C CNN
F 3 "" H 9250 4350 50  0001 C CNN
	1    9250 4350
	1    0    0    -1  
$EndComp
$Comp
L C C90
U 1 1 5C2B3B81
P 9750 4350
F 0 "C90" H 9775 4450 50  0000 L CNN
F 1 "100p" H 9775 4250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 9788 4200 50  0001 C CNN
F 3 "" H 9750 4350 50  0001 C CNN
	1    9750 4350
	1    0    0    -1  
$EndComp
$Comp
L C C88
U 1 1 5C2B3BD8
P 8750 4350
F 0 "C88" H 8775 4450 50  0000 L CNN
F 1 "100p" H 8775 4250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 8788 4200 50  0001 C CNN
F 3 "" H 8750 4350 50  0001 C CNN
	1    8750 4350
	1    0    0    -1  
$EndComp
$Comp
L C C87
U 1 1 5C2B3C41
P 8250 4350
F 0 "C87" H 8275 4450 50  0000 L CNN
F 1 "100p" H 8275 4250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 8288 4200 50  0001 C CNN
F 3 "" H 8250 4350 50  0001 C CNN
	1    8250 4350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0104
U 1 1 5C2B3E8D
P 10400 4700
F 0 "#PWR0104" H 10400 4450 50  0001 C CNN
F 1 "GND" H 10400 4550 50  0000 C CNN
F 2 "" H 10400 4700 50  0001 C CNN
F 3 "" H 10400 4700 50  0001 C CNN
	1    10400 4700
	1    0    0    -1  
$EndComp
$Comp
L D_ALT D23
U 1 1 5C2B4700
P 9400 2350
F 0 "D23" H 9400 2450 50  0000 C CNN
F 1 "BAV100" H 9400 2250 50  0000 C CNN
F 2 "Diodes_SMD:D_MiniMELF_Standard" H 9400 2350 50  0001 C CNN
F 3 "" H 9400 2350 50  0001 C CNN
	1    9400 2350
	0    -1   -1   0   
$EndComp
Text Notes 10400 2600 0    60   ~ 0
VCC
Text Notes 10400 3100 0    60   ~ 0
GND
Text Notes 10400 2700 0    60   ~ 0
SOUT
Text Notes 10400 2800 0    60   ~ 0
SIN
Text Notes 10400 3000 0    60   ~ 0
SCX
Text Notes 10400 2900 0    60   ~ 0
P14
$Comp
L VCC #PWR0105
U 1 1 5C2B5216
P 9500 3500
F 0 "#PWR0105" H 9500 3350 50  0001 C CNN
F 1 "VCC" H 9500 3650 50  0000 C CNN
F 2 "" H 9500 3500 50  0001 C CNN
F 3 "" H 9500 3500 50  0001 C CNN
	1    9500 3500
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR0106
U 1 1 5C2B5240
P 8500 3500
F 0 "#PWR0106" H 8500 3350 50  0001 C CNN
F 1 "VCC" H 8500 3650 50  0000 C CNN
F 2 "" H 8500 3500 50  0001 C CNN
F 3 "" H 8500 3500 50  0001 C CNN
	1    8500 3500
	1    0    0    -1  
$EndComp
$Comp
L VDD #PWR0107
U 1 1 5C2B526A
P 9000 3500
F 0 "#PWR0107" H 9000 3350 50  0001 C CNN
F 1 "VDD" H 9000 3650 50  0000 C CNN
F 2 "" H 9000 3500 50  0001 C CNN
F 3 "" H 9000 3500 50  0001 C CNN
	1    9000 3500
	1    0    0    -1  
$EndComp
$Comp
L R R132
U 1 1 5C2B6BDE
P 7650 2700
F 0 "R132" V 7730 2700 50  0000 C CNN
F 1 "220" V 7650 2700 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 7580 2700 50  0001 C CNN
F 3 "" H 7650 2700 50  0001 C CNN
	1    7650 2700
	0    1    1    0   
$EndComp
$Comp
L R R133
U 1 1 5C2B6C8B
P 7650 2900
F 0 "R133" V 7730 2900 50  0000 C CNN
F 1 "220" V 7650 2900 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 7580 2900 50  0001 C CNN
F 3 "" H 7650 2900 50  0001 C CNN
	1    7650 2900
	0    1    1    0   
$EndComp
$Comp
L R R130
U 1 1 5C2B6D00
P 7350 2800
F 0 "R130" V 7430 2800 50  0000 C CNN
F 1 "220" V 7350 2800 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 7280 2800 50  0001 C CNN
F 3 "" H 7350 2800 50  0001 C CNN
	1    7350 2800
	0    1    1    0   
$EndComp
$Comp
L R R131
U 1 1 5C2B6D99
P 7350 3000
F 0 "R131" V 7430 3000 50  0000 C CNN
F 1 "220" V 7350 3000 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 7280 3000 50  0001 C CNN
F 3 "" H 7350 3000 50  0001 C CNN
	1    7350 3000
	0    1    1    0   
$EndComp
$Comp
L 74LVCH8T245 U16
U 1 1 5C215B7C
P 3800 3500
AR Path="/5C215B7C" Ref="U16"  Part="1" 
AR Path="/5C2ACC50/5C215B7C" Ref="U16"  Part="1" 
F 0 "U16" H 3800 4850 60  0000 C CNN
F 1 "74LVCH8T245" H 4200 2350 60  0000 C CNN
F 2 "Housings_SSOP:TSSOP-24_4.4x7.8mm_Pitch0.65mm" H 3800 3500 60  0001 C CNN
F 3 "" H 3800 3500 60  0001 C CNN
	1    3800 3500
	1    0    0    -1  
$EndComp
$Comp
L R R128
U 1 1 5C217090
P 6400 1950
F 0 "R128" V 6480 1950 50  0000 C CNN
F 1 "10k" V 6400 1950 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 6330 1950 50  0001 C CNN
F 3 "" H 6400 1950 50  0001 C CNN
	1    6400 1950
	1    0    0    -1  
$EndComp
$Comp
L R R129
U 1 1 5C217361
P 6800 1950
F 0 "R129" V 6880 1950 50  0000 C CNN
F 1 "10k" V 6800 1950 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 6730 1950 50  0001 C CNN
F 3 "" H 6800 1950 50  0001 C CNN
	1    6800 1950
	1    0    0    -1  
$EndComp
Text HLabel 6600 4400 3    60   Input ~ 0
SOUT_5V
Text HLabel 7000 4400 3    60   Input ~ 0
P14_5V
Text HLabel 6800 4400 3    60   Output ~ 0
SIN_5V
$Comp
L CONN_02X03 J23
U 1 1 5C218777
P 7450 1100
F 0 "J23" H 7450 1300 50  0000 C CNN
F 1 "CONN_02X03" H 7450 900 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x03_Pitch2.54mm" H 7450 -100 50  0001 C CNN
F 3 "" H 7450 -100 50  0001 C CNN
	1    7450 1100
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR0108
U 1 1 5C21B299
P 7100 900
F 0 "#PWR0108" H 7100 750 50  0001 C CNN
F 1 "+3V3" H 7100 1040 50  0000 C CNN
F 2 "" H 7100 900 50  0001 C CNN
F 3 "" H 7100 900 50  0001 C CNN
	1    7100 900 
	1    0    0    -1  
$EndComp
$Comp
L +5VP #PWR0109
U 1 1 5C21B2D5
P 6800 900
F 0 "#PWR0109" H 6800 750 50  0001 C CNN
F 1 "+5VP" H 6800 1040 50  0000 C CNN
F 2 "" H 6800 900 50  0001 C CNN
F 3 "" H 6800 900 50  0001 C CNN
	1    6800 900 
	1    0    0    -1  
$EndComp
$Comp
L +5VD #PWR0110
U 1 1 5C21B311
P 6500 900
F 0 "#PWR0110" H 6500 750 50  0001 C CNN
F 1 "+5VD" H 6500 1040 50  0000 C CNN
F 2 "" H 6500 900 50  0001 C CNN
F 3 "" H 6500 900 50  0001 C CNN
	1    6500 900 
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X10 J22
U 1 1 5C21CC60
P 5350 5200
F 0 "J22" H 5350 5750 50  0000 C CNN
F 1 "CONN_02X05" V 5450 5200 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x05_Pitch2.54mm" H 5350 5200 50  0001 C CNN
F 3 "" H 5350 5200 50  0001 C CNN
	1    5350 5200
	0    1    1    0   
$EndComp
$Comp
L GND #PWR0111
U 1 1 5C21D9D6
P 3800 5000
F 0 "#PWR0111" H 3800 4750 50  0001 C CNN
F 1 "GND" H 3800 4850 50  0000 C CNN
F 2 "" H 3800 5000 50  0001 C CNN
F 3 "" H 3800 5000 50  0001 C CNN
	1    3800 5000
	1    0    0    -1  
$EndComp
$Comp
L C C86
U 1 1 5C21EA44
P 4750 1950
F 0 "C86" H 4775 2050 50  0000 L CNN
F 1 "100n" H 4775 1850 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 4788 1800 50  0001 C CNN
F 3 "" H 4750 1950 50  0001 C CNN
	1    4750 1950
	1    0    0    -1  
$EndComp
$Comp
L C C85
U 1 1 5C21EAF1
P 2850 1950
F 0 "C85" H 2875 2050 50  0000 L CNN
F 1 "100n" H 2875 1850 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 2888 1800 50  0001 C CNN
F 3 "" H 2850 1950 50  0001 C CNN
	1    2850 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	9900 2400 9900 2600
Wire Wire Line
	7800 2700 10600 2700
Wire Wire Line
	10000 2700 10000 2400
Wire Wire Line
	10100 2400 10100 2800
Wire Wire Line
	7500 2800 10600 2800
Wire Wire Line
	7800 2900 10600 2900
Wire Wire Line
	10200 2900 10200 2400
Wire Wire Line
	10300 2400 10300 3000
Wire Wire Line
	7500 3000 10600 3000
Wire Wire Line
	10400 2400 10400 4700
Wire Wire Line
	10400 3100 10600 3100
Wire Wire Line
	9750 2700 9750 4200
Wire Wire Line
	9750 3900 9700 3900
Connection ~ 10000 2700
Wire Wire Line
	9250 2800 9250 4200
Wire Wire Line
	9250 3900 9200 3900
Connection ~ 10100 2800
Wire Wire Line
	8750 2900 8750 4200
Wire Wire Line
	8750 3900 8700 3900
Connection ~ 10200 2900
Wire Wire Line
	8250 3000 8250 4200
Wire Wire Line
	8250 3900 8200 3900
Connection ~ 10300 3000
Connection ~ 9750 3900
Connection ~ 9250 3900
Connection ~ 8750 3900
Connection ~ 8250 3900
Wire Wire Line
	8000 4200 8000 4600
Wire Wire Line
	8000 4600 10400 4600
Wire Wire Line
	8250 4600 8250 4500
Wire Wire Line
	8750 4600 8750 4500
Connection ~ 8250 4600
Wire Wire Line
	9750 4600 9750 4500
Connection ~ 8750 4600
Wire Wire Line
	9500 4200 9500 4600
Connection ~ 9500 4600
Wire Wire Line
	9250 4600 9250 4500
Connection ~ 9250 4600
Wire Wire Line
	9000 4600 9000 4200
Connection ~ 9000 4600
Wire Wire Line
	8500 4200 8500 4600
Connection ~ 8500 4600
Connection ~ 10400 3100
Connection ~ 9750 4600
Connection ~ 10400 4600
Wire Wire Line
	9400 2500 9400 2600
Connection ~ 9900 2600
Wire Wire Line
	8500 3500 8500 3600
Wire Wire Line
	9000 3600 9000 3500
Wire Wire Line
	9500 3500 9500 3600
Wire Wire Line
	9400 2200 9400 2100
Wire Wire Line
	9400 2100 8000 2100
Wire Wire Line
	8000 1000 8000 3600
Connection ~ 9750 2700
Connection ~ 9250 2800
Connection ~ 8750 2900
Connection ~ 8250 3000
Wire Wire Line
	9400 2600 10600 2600
Wire Wire Line
	6600 2700 7500 2700
Wire Wire Line
	7000 2900 7500 2900
Connection ~ 8000 2100
Wire Wire Line
	4200 1600 8200 1600
Wire Wire Line
	4200 1600 4200 2000
Wire Wire Line
	6400 3000 7200 3000
Wire Wire Line
	6400 2100 6400 3000
Wire Wire Line
	6400 2400 4700 2400
Connection ~ 6400 2400
Wire Wire Line
	6400 1800 6400 1600
Connection ~ 6400 1600
Wire Wire Line
	7000 2900 7000 4400
Wire Wire Line
	7200 2800 6800 2800
Wire Wire Line
	6800 2100 6800 4400
Wire Wire Line
	6600 2700 6600 4400
Connection ~ 6800 2800
Wire Wire Line
	6800 1800 6800 1600
Connection ~ 6800 1600
Wire Wire Line
	7700 1000 8000 1000
Connection ~ 8000 1600
Wire Wire Line
	7700 1100 8000 1100
Connection ~ 8000 1100
Wire Wire Line
	7700 1200 8000 1200
Wire Wire Line
	7100 900  7100 1000
Wire Wire Line
	7100 1000 7200 1000
Wire Wire Line
	6800 900  6800 1100
Wire Wire Line
	6800 1100 7200 1100
Wire Wire Line
	6500 900  6500 1200
Wire Wire Line
	6500 1200 7200 1200
Wire Wire Line
	3800 4800 3800 5000
Wire Wire Line
	2700 4900 5800 4900
Wire Wire Line
	5800 4900 5800 5000
Wire Wire Line
	5700 5000 5700 1600
Connection ~ 5700 1600
Connection ~ 3800 4900
Wire Wire Line
	5600 2400 5600 5000
Connection ~ 5600 2400
Wire Wire Line
	4700 2600 5500 2600
Wire Wire Line
	5500 2600 5500 5000
Wire Wire Line
	4700 2800 5400 2800
Wire Wire Line
	5400 2800 5400 5000
Wire Wire Line
	4700 3000 5300 3000
Wire Wire Line
	5300 3000 5300 5000
Wire Wire Line
	4700 3200 5200 3200
Wire Wire Line
	5200 3200 5200 5000
Wire Wire Line
	4700 3400 5100 3400
Wire Wire Line
	5100 3400 5100 5000
Wire Wire Line
	4700 3600 5000 3600
Wire Wire Line
	5000 3600 5000 5000
Wire Wire Line
	4700 3800 4900 3800
Wire Wire Line
	4900 3800 4900 5000
Wire Wire Line
	4750 1600 4750 1800
Connection ~ 4750 1600
Wire Wire Line
	4750 2100 4750 4900
Connection ~ 4750 4900
Wire Wire Line
	2850 2100 2850 4900
Wire Wire Line
	1100 1600 3400 1600
Wire Wire Line
	3400 1100 3400 2000
$Comp
L CONN_01X10 J20
U 1 1 5C21F67A
P 2250 5200
F 0 "J20" H 2250 5750 50  0000 C CNN
F 1 "CONN_02X05" V 2350 5200 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x05_Pitch2.54mm" H 2250 5200 50  0001 C CNN
F 3 "" H 2250 5200 50  0001 C CNN
	1    2250 5200
	0    1    1    0   
$EndComp
Wire Wire Line
	2700 4900 2700 5000
Connection ~ 2850 4900
Wire Wire Line
	2600 1600 2600 5000
Connection ~ 2850 1600
Wire Wire Line
	900  2400 2900 2400
Wire Wire Line
	2500 2400 2500 5000
Wire Wire Line
	800  2600 2900 2600
Wire Wire Line
	2400 2600 2400 5000
Wire Wire Line
	800  2800 2900 2800
Wire Wire Line
	2300 2800 2300 5000
Wire Wire Line
	800  3000 2900 3000
Wire Wire Line
	2200 3000 2200 5000
Wire Wire Line
	800  3200 2900 3200
Wire Wire Line
	2100 3200 2100 5000
Wire Wire Line
	800  3400 2900 3400
Wire Wire Line
	2000 3400 2000 5000
Wire Wire Line
	800  3600 2900 3600
Wire Wire Line
	1900 3600 1900 5000
Wire Wire Line
	800  3800 2900 3800
Wire Wire Line
	1800 3800 1800 5000
$Comp
L +3V3 #PWR0112
U 1 1 5C220B7F
P 3400 1100
F 0 "#PWR0112" H 3400 950 50  0001 C CNN
F 1 "+3V3" H 3400 1240 50  0000 C CNN
F 2 "" H 3400 1100 50  0001 C CNN
F 3 "" H 3400 1100 50  0001 C CNN
	1    3400 1100
	1    0    0    -1  
$EndComp
Connection ~ 3400 1600
Wire Wire Line
	2900 4200 1100 4200
Wire Wire Line
	1100 2000 1100 5000
Wire Wire Line
	2900 4400 1300 4400
Wire Wire Line
	1300 2000 1300 5000
$Comp
L R R125
U 1 1 5C225FB9
P 1100 1850
F 0 "R125" V 1180 1850 50  0000 C CNN
F 1 "10k" V 1100 1850 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 1030 1850 50  0001 C CNN
F 3 "" H 1100 1850 50  0001 C CNN
	1    1100 1850
	1    0    0    -1  
$EndComp
$Comp
L R R126
U 1 1 5C2260C4
P 1300 1850
F 0 "R126" V 1380 1850 50  0000 C CNN
F 1 "10k" V 1300 1850 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 1230 1850 50  0001 C CNN
F 3 "" H 1300 1850 50  0001 C CNN
	1    1300 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	1100 1600 1100 1700
Connection ~ 2600 1600
Wire Wire Line
	1300 1600 1300 1700
Connection ~ 1300 1600
Connection ~ 1300 4400
Connection ~ 1100 4200
Entry Wire Line
	700  2700 800  2600
Entry Wire Line
	700  2900 800  2800
Entry Wire Line
	700  3100 800  3000
Entry Wire Line
	700  3300 800  3200
Entry Wire Line
	700  3500 800  3400
Entry Wire Line
	700  3700 800  3600
Entry Wire Line
	700  3900 800  3800
Connection ~ 2500 2400
Connection ~ 2400 2600
Connection ~ 2300 2800
Connection ~ 2200 3000
Connection ~ 2100 3200
Connection ~ 2000 3400
Connection ~ 1900 3600
Connection ~ 1800 3800
Wire Wire Line
	900  2400 900  5000
Wire Bus Line
	700  2500 700  5000
Text HLabel 700  5000 3    60   3State ~ 0
B[1..7]
Text HLabel 900  5000 3    60   BiDi ~ 0
SCX
Text HLabel 1100 5000 3    60   Input ~ 0
DIR
Text HLabel 1300 5000 3    60   Input ~ 0
~OE
Text Label 1400 2600 0    60   ~ 0
GPIO_B1
Text Label 1400 2800 0    60   ~ 0
GPIO_B2
Text Label 1400 3000 0    60   ~ 0
GPIO_B3
Text Label 1400 3200 0    60   ~ 0
GPIO_B4
Text Label 1400 3400 0    60   ~ 0
GPIO_B5
Text Label 1400 3600 0    60   ~ 0
GPIO_B6
Text Label 1400 3800 0    60   ~ 0
GPIO_B7
$Comp
L CONN_02X03 J21
U 1 1 5C239A43
P 3450 6000
F 0 "J21" H 3450 6200 50  0000 C CNN
F 1 "CONN_02X03" H 3450 5800 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x03_Pitch2.54mm" H 3450 4800 50  0001 C CNN
F 3 "" H 3450 4800 50  0001 C CNN
	1    3450 6000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2600 4800 3000 4800
Wire Wire Line
	3000 4800 3000 5900
Connection ~ 2600 4800
Wire Wire Line
	3000 5900 3200 5900
Wire Wire Line
	2500 4700 3100 4700
Wire Wire Line
	3100 4700 3100 6100
Connection ~ 2500 4700
Wire Wire Line
	3100 6100 3200 6100
Wire Wire Line
	3700 6100 4000 6100
Wire Wire Line
	4000 6100 4000 4900
Connection ~ 4000 4900
Wire Wire Line
	3700 5900 4300 5900
Wire Wire Line
	3700 6000 4300 6000
Wire Wire Line
	3200 6000 3000 6000
Wire Wire Line
	3000 6000 3000 6400
Wire Wire Line
	3000 6400 4300 6400
Text HLabel 4300 5900 2    60   Input ~ 0
SOUT
Text HLabel 4300 6400 2    60   Input ~ 0
SIN
Text HLabel 4300 6000 2    60   Input ~ 0
P14
Text Label 700  4700 1    60   ~ 0
GPIO_B[1..7]
$Comp
L PWR_FLAG #FLG0113
U 1 1 5C273646
P 8200 1600
F 0 "#FLG0113" H 8200 1675 50  0001 C CNN
F 1 "PWR_FLAG" H 8200 1750 50  0000 C CNN
F 2 "" H 8200 1600 50  0001 C CNN
F 3 "" H 8200 1600 50  0001 C CNN
	1    8200 1600
	0    1    1    0   
$EndComp
$Comp
L D_x2_Serial_AKC D19
U 1 1 5C248AD1
P 8000 3900
F 0 "D19" H 8050 3800 50  0000 C CNN
F 1 "BAV199WQ" H 8000 4000 50  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-323_SC-70" H 8000 3900 50  0001 C CNN
F 3 "" H 8000 3900 50  0001 C CNN
	1    8000 3900
	0    -1   -1   0   
$EndComp
$Comp
L D_x2_Serial_AKC D20
U 1 1 5C248E6B
P 8500 3900
F 0 "D20" H 8550 3800 50  0000 C CNN
F 1 "BAV199WQ" H 8500 4000 50  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-323_SC-70" H 8500 3900 50  0001 C CNN
F 3 "" H 8500 3900 50  0001 C CNN
	1    8500 3900
	0    -1   -1   0   
$EndComp
$Comp
L D_x2_Serial_AKC D21
U 1 1 5C248F05
P 9000 3900
F 0 "D21" H 9050 3800 50  0000 C CNN
F 1 "BAV199WQ" H 9000 4000 50  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-323_SC-70" H 9000 3900 50  0001 C CNN
F 3 "" H 9000 3900 50  0001 C CNN
	1    9000 3900
	0    -1   -1   0   
$EndComp
$Comp
L D_x2_Serial_AKC D22
U 1 1 5C248F93
P 9500 3900
F 0 "D22" H 9550 3800 50  0000 C CNN
F 1 "BAV199WQ" H 9500 4000 50  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-323_SC-70" H 9500 3900 50  0001 C CNN
F 3 "" H 9500 3900 50  0001 C CNN
	1    9500 3900
	0    -1   -1   0   
$EndComp
$Comp
L CONN_01X07 J25
U 1 1 5C27ACB1
P 10800 2900
F 0 "J25" H 10800 3300 50  0000 C CNN
F 1 "GBC_ELP" V 10900 2900 50  0000 C CNN
F 2 "gb_conn:GBC_Link_Port" H 10800 2900 50  0001 C CNN
F 3 "" H 10800 2900 50  0001 C CNN
	1    10800 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	10600 3200 10400 3200
Connection ~ 10400 3200
Text Notes 10400 3200 0    60   ~ 0
SHLD
Wire Wire Line
	2850 1600 2850 1800
Connection ~ 8000 1200
Text Label 5600 4800 1    60   ~ 0
XGPIO_B0
Text Label 5700 4800 1    60   ~ 0
VCC_GPIO_B
Text Label 5500 4800 1    60   ~ 0
XGPIO_B1
Text Label 5400 4800 1    60   ~ 0
XGPIO_B2
Text Label 5300 4800 1    60   ~ 0
XGPIO_B3
Text Label 5200 4800 1    60   ~ 0
XGPIO_B4
Text Label 5100 4800 1    60   ~ 0
XGPIO_B5
Text Label 5000 4800 1    60   ~ 0
XGPIO_B6
Text Label 4900 4800 1    60   ~ 0
XGPIO_B7
Text Notes 1400 2400 0    60   ~ 0
GPIO_B0
Text Label 9500 2600 0    60   ~ 0
VCC_ELP
Text Label 8300 2700 0    60   ~ 0
ELP_SOUT
Text Label 8300 2800 0    60   ~ 0
ELP_SIN
Text Label 8300 2900 0    60   ~ 0
ELP_P14
Text Label 8300 3000 0    60   ~ 0
ELP_SCX
$EndSCHEMATC
