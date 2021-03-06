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
Sheet 10 11
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
L SRAM_1M_X8 U18
U 1 1 5C27E7FD
P 2400 6050
F 0 "U18" H 2100 7150 50  0000 C CNN
F 1 "IS62WV10248EBLL-45TLI" V 2400 6050 50  0000 C CNN
F 2 "housing:44-400mil-TSOP-2" H 2400 6100 50  0001 C CIN
F 3 "" H 2400 6100 50  0001 C CNN
F 4 "SRAM 1M x 8bit" V 2500 6050 60  0000 C CIN "Description"
	1    2400 6050
	1    0    0    -1  
$EndComp
$Comp
L SRAM_128K_X8 U22
U 1 1 5C27E9FB
P 8500 3700
AR Path="/5C27E9FB" Ref="U22"  Part="1" 
AR Path="/5C2795CB/5C27E9FB" Ref="U22"  Part="1" 
F 0 "U22" H 8200 4650 50  0000 C CNN
F 1 "IS62WV1288BLL-55QLI" V 8500 3700 50  0000 C CNN
F 2 "housing:32-SOP" H 8500 3600 50  0001 C CIN
F 3 "" H 8500 3600 50  0001 C CNN
F 4 "SRAM 128k x 8bit" V 8600 3700 60  0000 C CIN "Description"
	1    8500 3700
	1    0    0    -1  
$EndComp
$Comp
L C C99
U 1 1 5C27F097
P 9200 4550
F 0 "C99" H 9225 4650 50  0000 L CNN
F 1 "100n" H 9225 4450 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 9238 4400 50  0001 C CNN
F 3 "" H 9200 4550 50  0001 C CNN
	1    9200 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	9200 4700 9200 4800
Wire Wire Line
	7900 4800 9450 4800
Wire Wire Line
	8500 4700 8500 4900
Wire Wire Line
	9200 2600 9200 4400
Wire Wire Line
	7800 2600 9300 2600
$Comp
L C C100
U 1 1 5C27F47F
P 9450 4550
F 0 "C100" H 9475 4650 50  0000 L CNN
F 1 "100n" H 9475 4450 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 9488 4400 50  0001 C CNN
F 3 "" H 9450 4550 50  0001 C CNN
	1    9450 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	9450 4800 9450 4700
Connection ~ 9200 4800
Wire Wire Line
	9450 4400 9450 4300
Wire Wire Line
	9450 4300 9200 4300
Connection ~ 9200 4300
Wire Wire Line
	9000 4100 9200 4100
Connection ~ 9200 4100
Wire Wire Line
	8000 4300 7900 4300
Wire Wire Line
	7900 4500 8000 4500
Wire Wire Line
	7800 4400 8000 4400
Connection ~ 8500 2600
Wire Wire Line
	7800 4400 7800 2600
Wire Wire Line
	7900 4300 7900 4800
Connection ~ 8500 4800
Connection ~ 7900 4500
Wire Wire Line
	9000 4500 9050 4500
Wire Wire Line
	9050 4500 9050 4800
Connection ~ 9050 4800
Wire Bus Line
	10200 2800 10200 4400
Entry Wire Line
	10100 2900 10200 3000
Entry Wire Line
	10100 3000 10200 3100
Entry Wire Line
	10100 3100 10200 3200
Entry Wire Line
	10100 3200 10200 3300
Entry Wire Line
	10100 3300 10200 3400
Entry Wire Line
	10100 3400 10200 3500
Entry Wire Line
	10100 3500 10200 3600
Entry Wire Line
	10100 3600 10200 3700
Wire Wire Line
	9000 2900 10100 2900
Wire Wire Line
	10100 3000 9000 3000
Wire Wire Line
	9000 3100 10100 3100
Wire Wire Line
	10100 3200 9000 3200
Wire Wire Line
	9000 3300 10100 3300
Wire Wire Line
	10100 3400 9000 3400
Wire Wire Line
	9000 3500 10100 3500
Wire Wire Line
	10100 3600 9000 3600
Text Label 9900 2900 0    60   ~ 0
VD0
Text Label 9900 3000 0    60   ~ 0
VD1
Text Label 9900 3100 0    60   ~ 0
VD2
Text Label 9900 3200 0    60   ~ 0
VD3
Text Label 9900 3300 0    60   ~ 0
VD4
Text Label 9900 3400 0    60   ~ 0
VD5
Text Label 9900 3500 0    60   ~ 0
VD6
Text Label 9900 3600 0    60   ~ 0
VD7
Wire Bus Line
	7200 2800 7200 4400
Entry Wire Line
	7200 3000 7300 2900
Entry Wire Line
	7200 3100 7300 3000
Entry Wire Line
	7200 3200 7300 3100
Entry Wire Line
	7200 3300 7300 3200
Entry Wire Line
	7200 3400 7300 3300
Entry Wire Line
	7200 3500 7300 3400
Entry Wire Line
	7200 3600 7300 3500
Entry Wire Line
	7200 3700 7300 3600
Entry Wire Line
	7200 3800 7300 3700
Entry Wire Line
	7200 3900 7300 3800
Entry Wire Line
	7200 4000 7300 3900
Entry Wire Line
	7200 4100 7300 4000
Entry Wire Line
	7200 4200 7300 4100
Entry Wire Line
	7200 4300 7300 4200
Wire Wire Line
	7300 2900 8000 2900
Wire Wire Line
	8000 3000 7300 3000
Wire Wire Line
	7300 3100 8000 3100
Wire Wire Line
	8000 3200 7300 3200
Wire Wire Line
	7300 3300 8000 3300
Wire Wire Line
	8000 3400 7300 3400
Wire Wire Line
	7300 3500 8000 3500
Wire Wire Line
	8000 3600 7300 3600
Wire Wire Line
	7300 3700 8000 3700
Wire Wire Line
	8000 3800 7300 3800
Wire Wire Line
	7300 3900 8000 3900
Wire Wire Line
	8000 4000 7300 4000
Wire Wire Line
	7300 4100 8000 4100
Wire Wire Line
	8000 4200 7300 4200
Wire Wire Line
	9000 3750 10100 3750
Wire Wire Line
	10100 3750 10100 4400
Wire Wire Line
	10000 3850 10000 4400
Wire Wire Line
	10000 3850 9000 3850
Wire Wire Line
	9900 4000 9900 4400
Wire Wire Line
	9900 4000 9000 4000
Text Label 7350 2900 0    60   ~ 0
VA0
Text Label 7350 3100 0    60   ~ 0
VA2
Text Label 7350 3000 0    60   ~ 0
VA1
Text Label 7350 3200 0    60   ~ 0
VA3
Text Label 7350 3300 0    60   ~ 0
VA4
Text Label 7350 3400 0    60   ~ 0
VA5
Text Label 7350 3500 0    60   ~ 0
VA6
Text Label 7350 3600 0    60   ~ 0
VA7
Text Label 7350 3700 0    60   ~ 0
VA8
Text Label 7350 3800 0    60   ~ 0
VA9
Text Label 7350 3900 0    60   ~ 0
VA10
Text Label 7350 4000 0    60   ~ 0
VA11
Text Label 7350 4100 0    60   ~ 0
VA12
Text Label 7350 4200 0    60   ~ 0
VA13
Text HLabel 10200 4400 3    60   3State ~ 0
VD[0..7]
Text HLabel 10100 4400 3    60   Input ~ 0
~VRD
Text HLabel 10000 4400 3    60   Input ~ 0
~VWR
Text HLabel 9900 4400 3    60   Input ~ 0
~VCS
$Comp
L R R139
U 1 1 5C2820ED
P 9450 2600
F 0 "R139" V 9530 2600 50  0000 C CNN
F 1 "10k" V 9450 2600 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 9380 2600 50  0001 C CNN
F 3 "" H 9450 2600 50  0001 C CNN
	1    9450 2600
	0    1    1    0   
$EndComp
Wire Wire Line
	9600 2600 9700 2600
Wire Wire Line
	9700 2600 9700 4000
Connection ~ 9700 4000
Connection ~ 9200 2600
Text HLabel 7200 4400 3    60   Input ~ 0
VA[0..13]
Wire Wire Line
	2400 1300 2400 1500
Wire Wire Line
	2400 4700 2400 4900
Wire Wire Line
	4700 4700 4700 4900
Wire Wire Line
	4700 1300 4700 1500
Wire Wire Line
	8500 2500 8500 2700
$Comp
L +3V3 #PWR0114
U 1 1 5C2ACB77
P 8500 2500
F 0 "#PWR0114" H 8500 2350 50  0001 C CNN
F 1 "+3V3" H 8500 2640 50  0000 C CNN
F 2 "" H 8500 2500 50  0001 C CNN
F 3 "" H 8500 2500 50  0001 C CNN
	1    8500 2500
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR0115
U 1 1 5C2ACDA3
P 4700 1300
F 0 "#PWR0115" H 4700 1150 50  0001 C CNN
F 1 "+3V3" H 4700 1440 50  0000 C CNN
F 2 "" H 4700 1300 50  0001 C CNN
F 3 "" H 4700 1300 50  0001 C CNN
	1    4700 1300
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR0116
U 1 1 5C2ACDC7
P 2400 1300
F 0 "#PWR0116" H 2400 1150 50  0001 C CNN
F 1 "+3V3" H 2400 1440 50  0000 C CNN
F 2 "" H 2400 1300 50  0001 C CNN
F 3 "" H 2400 1300 50  0001 C CNN
	1    2400 1300
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR0117
U 1 1 5C2ACDEB
P 2400 4700
F 0 "#PWR0117" H 2400 4550 50  0001 C CNN
F 1 "+3V3" H 2400 4840 50  0000 C CNN
F 2 "" H 2400 4700 50  0001 C CNN
F 3 "" H 2400 4700 50  0001 C CNN
	1    2400 4700
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR0118
U 1 1 5C2ACE0F
P 4700 4700
F 0 "#PWR0118" H 4700 4550 50  0001 C CNN
F 1 "+3V3" H 4700 4840 50  0000 C CNN
F 2 "" H 4700 4700 50  0001 C CNN
F 3 "" H 4700 4700 50  0001 C CNN
	1    4700 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 3700 4700 3500
Wire Wire Line
	2400 3700 2400 3500
Wire Wire Line
	2400 7400 2400 7200
Wire Wire Line
	4700 7400 4700 7200
$Comp
L GND #PWR0119
U 1 1 5C2AD019
P 8500 4900
F 0 "#PWR0119" H 8500 4650 50  0001 C CNN
F 1 "GND" H 8500 4750 50  0000 C CNN
F 2 "" H 8500 4900 50  0001 C CNN
F 3 "" H 8500 4900 50  0001 C CNN
	1    8500 4900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0120
U 1 1 5C2AD03D
P 4700 3700
F 0 "#PWR0120" H 4700 3450 50  0001 C CNN
F 1 "GND" H 4700 3550 50  0000 C CNN
F 2 "" H 4700 3700 50  0001 C CNN
F 3 "" H 4700 3700 50  0001 C CNN
	1    4700 3700
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0121
U 1 1 5C2AD061
P 2400 3700
F 0 "#PWR0121" H 2400 3450 50  0001 C CNN
F 1 "GND" H 2400 3550 50  0000 C CNN
F 2 "" H 2400 3700 50  0001 C CNN
F 3 "" H 2400 3700 50  0001 C CNN
	1    2400 3700
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0122
U 1 1 5C2AD085
P 2400 7400
F 0 "#PWR0122" H 2400 7150 50  0001 C CNN
F 1 "GND" H 2400 7250 50  0000 C CNN
F 2 "" H 2400 7400 50  0001 C CNN
F 3 "" H 2400 7400 50  0001 C CNN
	1    2400 7400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0123
U 1 1 5C2AD0A9
P 4700 7400
F 0 "#PWR0123" H 4700 7150 50  0001 C CNN
F 1 "GND" H 4700 7250 50  0000 C CNN
F 2 "" H 4700 7400 50  0001 C CNN
F 3 "" H 4700 7400 50  0001 C CNN
	1    4700 7400
	1    0    0    -1  
$EndComp
$Comp
L SRAM_128K_X8 U20
U 1 1 5C2ADBF2
P 4700 2500
AR Path="/5C2ADBF2" Ref="U20"  Part="1" 
AR Path="/5C2795CB/5C2ADBF2" Ref="U20"  Part="1" 
F 0 "U20" H 4400 3450 50  0000 C CNN
F 1 "IS62WV1288BLL-55QLI" V 4700 2500 50  0000 C CNN
F 2 "housing:32-SOP" H 4700 2400 50  0001 C CIN
F 3 "" H 4700 2400 50  0001 C CNN
F 4 "SRAM 128k x 8bit" V 4800 2500 60  0000 C CIN "Description"
	1    4700 2500
	1    0    0    -1  
$EndComp
$Comp
L SRAM_128K_X8 U17
U 1 1 5C2ADC7A
P 2400 2500
AR Path="/5C2ADC7A" Ref="U17"  Part="1" 
AR Path="/5C2795CB/5C2ADC7A" Ref="U17"  Part="1" 
F 0 "U17" H 2100 3450 50  0000 C CNN
F 1 "IS62WV1288BLL-55QLI" V 2400 2500 50  0000 C CNN
F 2 "housing:32-SOP" H 2400 2400 50  0001 C CIN
F 3 "" H 2400 2400 50  0001 C CNN
F 4 "SRAM 128k x 8bit" V 2500 2500 60  0000 C CIN "Description"
	1    2400 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 3300 5250 3300
Wire Wire Line
	5250 3300 5250 3600
Wire Wire Line
	4400 3600 5650 3600
Connection ~ 4700 3600
$Comp
L C C96
U 1 1 5C2AE861
P 5400 3350
F 0 "C96" H 5425 3450 50  0000 L CNN
F 1 "100n" H 5425 3250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 5438 3200 50  0001 C CNN
F 3 "" H 5400 3350 50  0001 C CNN
	1    5400 3350
	1    0    0    -1  
$EndComp
$Comp
L C C98
U 1 1 5C2AE8E0
P 5650 3350
F 0 "C98" H 5675 3450 50  0000 L CNN
F 1 "100n" H 5675 3250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 5688 3200 50  0001 C CNN
F 3 "" H 5650 3350 50  0001 C CNN
	1    5650 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5400 3600 5400 3500
Connection ~ 5250 3600
Wire Wire Line
	5650 3600 5650 3500
Connection ~ 5400 3600
Wire Wire Line
	5400 3200 5400 1400
Wire Wire Line
	5400 1400 4700 1400
Connection ~ 4700 1400
Wire Wire Line
	5650 3200 5650 3100
Wire Wire Line
	5650 3100 5400 3100
Connection ~ 5400 3100
Wire Wire Line
	2900 3300 2950 3300
Wire Wire Line
	2950 3300 2950 3600
Wire Wire Line
	1800 3600 3350 3600
Connection ~ 2400 3600
$Comp
L C C92
U 1 1 5C2AEBE0
P 3100 3350
F 0 "C92" H 3125 3450 50  0000 L CNN
F 1 "100n" H 3125 3250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 3138 3200 50  0001 C CNN
F 3 "" H 3100 3350 50  0001 C CNN
	1    3100 3350
	1    0    0    -1  
$EndComp
$Comp
L C C94
U 1 1 5C2AEC79
P 3350 3350
F 0 "C94" H 3375 3450 50  0000 L CNN
F 1 "100n" H 3375 3250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 3388 3200 50  0001 C CNN
F 3 "" H 3350 3350 50  0001 C CNN
	1    3350 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 3600 3350 3500
Connection ~ 2950 3600
Wire Wire Line
	3100 3500 3100 3600
Connection ~ 3100 3600
Wire Wire Line
	3100 1400 3100 3200
Wire Wire Line
	1800 1400 3100 1400
Connection ~ 2400 1400
Wire Wire Line
	3100 3100 3350 3100
Wire Wire Line
	3350 3100 3350 3200
Connection ~ 3100 3100
Wire Wire Line
	1900 3300 1800 3300
Wire Wire Line
	1800 3300 1800 3600
Wire Wire Line
	1900 3200 1800 3200
Wire Wire Line
	1800 3200 1800 1400
Wire Bus Line
	1100 1000 1100 7200
Wire Bus Line
	1100 1000 3700 1000
Wire Bus Line
	3700 1000 3700 7200
Wire Wire Line
	2900 2900 3600 2900
Wire Wire Line
	1200 1700 1900 1700
Wire Wire Line
	1200 1800 1900 1800
Wire Wire Line
	1200 1900 1900 1900
Wire Wire Line
	1200 2000 1900 2000
Wire Wire Line
	1200 2100 1900 2100
Wire Wire Line
	1200 2200 1900 2200
Wire Wire Line
	1200 2300 1900 2300
Wire Wire Line
	1200 2400 1900 2400
Wire Wire Line
	1200 2500 1900 2500
Wire Wire Line
	1200 2600 1900 2600
Wire Wire Line
	1200 2700 1900 2700
Wire Wire Line
	1200 2800 1900 2800
Wire Wire Line
	1200 2900 1900 2900
Wire Wire Line
	1200 3000 1900 3000
Wire Wire Line
	1200 3100 1900 3100
Wire Wire Line
	3800 1700 4200 1700
Wire Wire Line
	3800 1800 4200 1800
Wire Wire Line
	3800 1900 4200 1900
Wire Wire Line
	3800 2000 4200 2000
Wire Wire Line
	3800 2100 4200 2100
Wire Wire Line
	3800 2200 4200 2200
Wire Wire Line
	3800 2300 4200 2300
Wire Wire Line
	3800 2400 4200 2400
Wire Wire Line
	3800 2500 4200 2500
Wire Wire Line
	3800 2600 4200 2600
Wire Wire Line
	3800 2700 4200 2700
Wire Wire Line
	3800 2800 4200 2800
Wire Wire Line
	3800 2900 4200 2900
Wire Wire Line
	3800 3000 4200 3000
Wire Wire Line
	3800 3100 4200 3100
Wire Wire Line
	3800 3200 4200 3200
Wire Wire Line
	3800 3300 4200 3300
Wire Wire Line
	5200 2900 5400 2900
Connection ~ 5400 2900
Entry Wire Line
	3700 1800 3800 1700
Entry Wire Line
	3700 1900 3800 1800
Entry Wire Line
	3700 2000 3800 1900
Entry Wire Line
	3700 2100 3800 2000
Entry Wire Line
	3700 2200 3800 2100
Entry Wire Line
	3700 2300 3800 2200
Entry Wire Line
	3700 2400 3800 2300
Entry Wire Line
	3700 2500 3800 2400
Entry Wire Line
	3700 2600 3800 2500
Entry Wire Line
	3700 2700 3800 2600
Entry Wire Line
	3700 2800 3800 2700
Entry Wire Line
	3700 2900 3800 2800
Entry Wire Line
	3700 3000 3800 2900
Entry Wire Line
	3700 3100 3800 3000
Entry Wire Line
	3700 3200 3800 3100
Entry Wire Line
	3700 3300 3800 3200
Entry Wire Line
	3700 3400 3800 3300
Entry Wire Line
	1100 1800 1200 1700
Entry Wire Line
	1100 1900 1200 1800
Entry Wire Line
	1100 2000 1200 1900
Entry Wire Line
	1100 2100 1200 2000
Entry Wire Line
	1100 2200 1200 2100
Entry Wire Line
	1100 2300 1200 2200
Entry Wire Line
	1100 2400 1200 2300
Entry Wire Line
	1100 2500 1200 2400
Entry Wire Line
	1100 2600 1200 2500
Entry Wire Line
	1100 2700 1200 2600
Entry Wire Line
	1100 2800 1200 2700
Entry Wire Line
	1100 2900 1200 2800
Entry Wire Line
	1100 3000 1200 2900
Entry Wire Line
	1100 3100 1200 3000
Entry Wire Line
	1100 3200 1200 3100
Entry Wire Line
	3600 2900 3700 3000
Wire Bus Line
	3600 900  6000 900 
Wire Bus Line
	6000 900  6000 7700
Entry Wire Line
	3500 1700 3600 1800
Entry Wire Line
	3500 1800 3600 1900
Entry Wire Line
	3500 1900 3600 2000
Entry Wire Line
	3500 2000 3600 2100
Entry Wire Line
	3500 2100 3600 2200
Entry Wire Line
	3500 2200 3600 2300
Entry Wire Line
	3500 2300 3600 2400
Entry Wire Line
	3500 2400 3600 2500
Entry Wire Line
	5900 1700 6000 1800
Entry Wire Line
	5900 1800 6000 1900
Entry Wire Line
	5900 1900 6000 2000
Entry Wire Line
	5900 2000 6000 2100
Entry Wire Line
	5900 2100 6000 2200
Entry Wire Line
	5900 2200 6000 2300
Entry Wire Line
	5900 2300 6000 2400
Entry Wire Line
	5900 2400 6000 2500
Wire Wire Line
	5900 1700 5200 1700
Wire Wire Line
	5200 1800 5900 1800
Wire Wire Line
	5900 1900 5200 1900
Wire Wire Line
	5200 2000 5900 2000
Wire Wire Line
	5900 2100 5200 2100
Wire Wire Line
	5200 2200 5900 2200
Wire Wire Line
	5900 2300 5200 2300
Wire Wire Line
	5200 2400 5900 2400
Wire Wire Line
	2900 1700 3500 1700
Wire Wire Line
	3500 1800 2900 1800
Wire Wire Line
	2900 1900 3500 1900
Wire Wire Line
	3500 2000 2900 2000
Wire Wire Line
	2900 2100 3500 2100
Wire Wire Line
	3500 2200 2900 2200
Wire Wire Line
	2900 2300 3500 2300
Wire Wire Line
	3500 2400 2900 2400
Entry Wire Line
	3500 5100 3600 5200
Entry Wire Line
	3500 5200 3600 5300
Entry Wire Line
	3500 5300 3600 5400
Entry Wire Line
	3500 5400 3600 5500
Entry Wire Line
	3500 5500 3600 5600
Entry Wire Line
	3500 5600 3600 5700
Entry Wire Line
	3500 5700 3600 5800
Entry Wire Line
	3500 5800 3600 5900
Entry Wire Line
	5900 5100 6000 5200
Entry Wire Line
	5900 5200 6000 5300
Entry Wire Line
	5900 5300 6000 5400
Entry Wire Line
	5900 5400 6000 5500
Entry Wire Line
	5900 5500 6000 5600
Entry Wire Line
	5900 5600 6000 5700
Entry Wire Line
	5900 5700 6000 5800
Entry Wire Line
	5900 5800 6000 5900
Entry Wire Line
	1100 5200 1200 5100
Entry Wire Line
	1100 5300 1200 5200
Entry Wire Line
	1100 5400 1200 5300
Entry Wire Line
	1100 5500 1200 5400
Entry Wire Line
	1100 5600 1200 5500
Entry Wire Line
	1100 5700 1200 5600
Entry Wire Line
	1100 5800 1200 5700
Entry Wire Line
	1100 5900 1200 5800
Entry Wire Line
	1100 6000 1200 5900
Entry Wire Line
	1100 6100 1200 6000
Entry Wire Line
	1100 6200 1200 6100
Entry Wire Line
	1100 6300 1200 6200
Entry Wire Line
	1100 6400 1200 6300
Entry Wire Line
	1100 6500 1200 6400
Entry Wire Line
	1100 6600 1200 6500
Entry Wire Line
	1100 6700 1200 6600
Entry Wire Line
	1100 6800 1200 6700
Entry Wire Line
	1100 6900 1200 6800
Entry Wire Line
	1100 7000 1200 6900
Entry Wire Line
	1100 7100 1200 7000
Entry Wire Line
	3700 5200 3800 5100
Entry Wire Line
	3700 5300 3800 5200
Entry Wire Line
	3700 5400 3800 5300
Entry Wire Line
	3700 5500 3800 5400
Entry Wire Line
	3700 5600 3800 5500
Entry Wire Line
	3700 5700 3800 5600
Entry Wire Line
	3700 5800 3800 5700
Entry Wire Line
	3700 5900 3800 5800
Entry Wire Line
	3700 6000 3800 5900
Entry Wire Line
	3700 6100 3800 6000
Entry Wire Line
	3700 6200 3800 6100
Entry Wire Line
	3700 6300 3800 6200
Entry Wire Line
	3700 6400 3800 6300
Entry Wire Line
	3700 6500 3800 6400
Entry Wire Line
	3700 6600 3800 6500
Entry Wire Line
	3700 6700 3800 6600
Entry Wire Line
	3700 6800 3800 6700
Entry Wire Line
	3700 6900 3800 6800
Entry Wire Line
	3700 7000 3800 6900
Entry Wire Line
	3700 7100 3800 7000
Wire Wire Line
	1200 5100 1900 5100
Wire Wire Line
	1900 5200 1200 5200
Wire Wire Line
	1200 5300 1900 5300
Wire Wire Line
	1900 5400 1200 5400
Wire Wire Line
	1200 5500 1900 5500
Wire Wire Line
	1900 5600 1200 5600
Wire Wire Line
	1200 5700 1900 5700
Wire Wire Line
	1900 5800 1200 5800
Wire Wire Line
	1200 5900 1900 5900
Wire Wire Line
	1900 6000 1200 6000
Wire Wire Line
	1200 6100 1900 6100
Wire Wire Line
	1900 6200 1200 6200
Wire Wire Line
	1200 6300 1900 6300
Wire Wire Line
	1900 6400 1200 6400
Wire Wire Line
	1200 6500 1900 6500
Wire Wire Line
	1900 6600 1200 6600
Wire Wire Line
	1200 6700 1900 6700
Wire Wire Line
	1900 6800 1200 6800
Wire Wire Line
	1200 6900 1900 6900
Wire Wire Line
	1900 7000 1200 7000
Wire Wire Line
	2900 5100 3500 5100
Wire Wire Line
	3500 5200 2900 5200
Wire Wire Line
	2900 5300 3500 5300
Wire Wire Line
	3500 5400 2900 5400
Wire Wire Line
	2900 5500 3500 5500
Wire Wire Line
	3500 5600 2900 5600
Wire Wire Line
	2900 5700 3500 5700
Wire Wire Line
	3500 5800 2900 5800
Wire Wire Line
	3800 5100 4200 5100
Wire Wire Line
	4200 5200 3800 5200
Wire Wire Line
	3800 5300 4200 5300
Wire Wire Line
	4200 5400 3800 5400
Wire Wire Line
	3800 5500 4200 5500
Wire Wire Line
	4200 5600 3800 5600
Wire Wire Line
	3800 5700 4200 5700
Wire Wire Line
	4200 5800 3800 5800
Wire Wire Line
	3800 5900 4200 5900
Wire Wire Line
	4200 6000 3800 6000
Wire Wire Line
	3800 6100 4200 6100
Wire Wire Line
	4200 6200 3800 6200
Wire Wire Line
	3800 6300 4200 6300
Wire Wire Line
	4200 6400 3800 6400
Wire Wire Line
	3800 6500 4200 6500
Wire Wire Line
	4200 6600 3800 6600
Wire Wire Line
	3800 6700 4200 6700
Wire Wire Line
	4200 6800 3800 6800
Wire Wire Line
	3800 6900 4200 6900
Wire Wire Line
	4200 7000 3800 7000
Wire Wire Line
	5200 5100 5900 5100
Wire Wire Line
	5900 5200 5200 5200
Wire Wire Line
	5200 5300 5900 5300
Wire Wire Line
	5900 5400 5200 5400
Wire Wire Line
	5200 5500 5900 5500
Wire Wire Line
	5900 5600 5200 5600
Wire Wire Line
	5200 5700 5900 5700
Wire Wire Line
	5900 5800 5200 5800
Text Label 7200 4350 1    60   ~ 0
VA[0..13]
Text Label 10200 4350 1    60   ~ 0
VD[0..7]
Text Label 1100 4400 1    60   ~ 0
MA[0..20]
Text Label 6000 4400 1    60   ~ 0
MD[0..7]
Text Label 5900 1700 2    60   ~ 0
MD0
Text Label 5900 1800 2    60   ~ 0
MD1
Text Label 5900 1900 2    60   ~ 0
MD2
Text Label 5900 2000 2    60   ~ 0
MD3
Text Label 5900 2100 2    60   ~ 0
MD4
Text Label 5900 2200 2    60   ~ 0
MD5
Text Label 5900 2300 2    60   ~ 0
MD6
Text Label 5900 2400 2    60   ~ 0
MD7
Text Label 5900 5100 2    60   ~ 0
MD0
Text Label 5900 5200 2    60   ~ 0
MD1
Text Label 5900 5300 2    60   ~ 0
MD2
Text Label 5900 5400 2    60   ~ 0
MD3
Text Label 5900 5500 2    60   ~ 0
MD4
Text Label 5900 5600 2    60   ~ 0
MD5
Text Label 5900 5700 2    60   ~ 0
MD6
Text Label 5900 5800 2    60   ~ 0
MD7
Text Label 3500 5100 2    60   ~ 0
MD0
Text Label 3500 5200 2    60   ~ 0
MD1
Text Label 3500 5300 2    60   ~ 0
MD2
Text Label 3500 5400 2    60   ~ 0
MD3
Text Label 3500 5500 2    60   ~ 0
MD4
Text Label 3500 5600 2    60   ~ 0
MD5
Text Label 3500 5700 2    60   ~ 0
MD6
Text Label 3500 5800 2    60   ~ 0
MD7
Text Label 3500 1700 2    60   ~ 0
MD0
Text Label 3500 1800 2    60   ~ 0
MD1
Text Label 3500 1900 2    60   ~ 0
MD2
Text Label 3500 2000 2    60   ~ 0
MD3
Text Label 3500 2100 2    60   ~ 0
MD4
Text Label 3500 2200 2    60   ~ 0
MD5
Text Label 3500 2300 2    60   ~ 0
MD6
Text Label 3500 2400 2    60   ~ 0
MD7
Wire Wire Line
	2900 2550 3500 2550
Wire Wire Line
	2900 2650 3500 2650
Wire Wire Line
	5200 2550 6200 2550
Wire Wire Line
	5200 2650 6200 2650
Wire Wire Line
	2900 5950 3500 5950
Wire Wire Line
	2900 6050 3500 6050
Wire Wire Line
	5200 5950 5900 5950
Wire Wire Line
	5200 6050 6200 6050
Text Label 5900 5950 2    60   ~ 0
~MRD
Text Label 3500 5950 2    60   ~ 0
~MRD
Text Label 3500 2550 2    60   ~ 0
~MRD
Text Label 5900 2550 2    60   ~ 0
~MRD
Wire Bus Line
	6000 7700 3600 7700
Wire Bus Line
	3600 7700 3600 5100
Wire Bus Line
	3600 900  3600 2600
Text Label 3500 2650 2    60   ~ 0
~MWR
Text Label 5900 2650 2    60   ~ 0
~MWR
Text Label 5900 6050 2    60   ~ 0
~PROG
Text Label 3500 6050 2    60   ~ 0
~PROG
Text Label 1200 5100 0    60   ~ 0
MA0
Text Label 1200 5200 0    60   ~ 0
MA1
Text Label 1200 5300 0    60   ~ 0
MA2
Text Label 1200 5400 0    60   ~ 0
MA3
Text Label 1200 5500 0    60   ~ 0
MA4
Text Label 1200 5600 0    60   ~ 0
MA5
Text Label 1200 5700 0    60   ~ 0
MA6
Text Label 1200 5800 0    60   ~ 0
MA7
Text Label 1200 5900 0    60   ~ 0
MA8
Text Label 1200 6000 0    60   ~ 0
MA9
Text Label 1200 6100 0    60   ~ 0
MA10
Text Label 1200 6200 0    60   ~ 0
MA11
Text Label 1200 6300 0    60   ~ 0
MA12
Text Label 1200 6400 0    60   ~ 0
MA13
Text Label 1200 6500 0    60   ~ 0
MA14
Text Label 1200 6600 0    60   ~ 0
MA15
Text Label 1200 6700 0    60   ~ 0
MA16
Text Label 1200 6800 0    60   ~ 0
MA17
Text Label 1200 6900 0    60   ~ 0
MA18
Text Label 1200 7000 0    60   ~ 0
MA19
Text Label 3800 5100 0    60   ~ 0
MA0
Text Label 3800 5200 0    60   ~ 0
MA1
Text Label 3800 5300 0    60   ~ 0
MA2
Text Label 3800 5400 0    60   ~ 0
MA3
Text Label 3800 5500 0    60   ~ 0
MA4
Text Label 3800 5600 0    60   ~ 0
MA5
Text Label 3800 5700 0    60   ~ 0
MA6
Text Label 3800 5800 0    60   ~ 0
MA7
Text Label 3800 5900 0    60   ~ 0
MA8
Text Label 3800 6000 0    60   ~ 0
MA9
Text Label 3800 6100 0    60   ~ 0
MA10
Text Label 3800 6200 0    60   ~ 0
MA11
Text Label 3800 6300 0    60   ~ 0
MA12
Text Label 3800 6400 0    60   ~ 0
MA13
Text Label 3800 6500 0    60   ~ 0
MA14
Text Label 3800 6600 0    60   ~ 0
MA15
Text Label 3800 6700 0    60   ~ 0
MA16
Text Label 3800 6800 0    60   ~ 0
MA17
Text Label 3800 6900 0    60   ~ 0
MA18
Text Label 3800 7000 0    60   ~ 0
MA19
Text Label 3500 2900 2    60   ~ 0
MA14
Text Label 1200 1700 0    60   ~ 0
MA0
Text Label 1200 1800 0    60   ~ 0
MA1
Text Label 1200 1900 0    60   ~ 0
MA2
Text Label 1200 2000 0    60   ~ 0
MA3
Text Label 1200 2100 0    60   ~ 0
MA4
Text Label 1200 2200 0    60   ~ 0
MA5
Text Label 1200 2300 0    60   ~ 0
MA6
Text Label 1200 2400 0    60   ~ 0
MA7
Text Label 1200 2500 0    60   ~ 0
MA8
Text Label 1200 2600 0    60   ~ 0
MA9
Text Label 1200 2700 0    60   ~ 0
MA10
Text Label 1200 2800 0    60   ~ 0
MA11
Text Label 1200 2900 0    60   ~ 0
MA12
Text Label 1200 3000 0    60   ~ 0
MA16
Text Label 1200 3100 0    60   ~ 0
MA17
Text Label 3800 1700 0    60   ~ 0
MA0
Text Label 3800 1800 0    60   ~ 0
MA1
Text Label 3800 1900 0    60   ~ 0
MA2
Text Label 3800 2000 0    60   ~ 0
MA3
Text Label 3800 2100 0    60   ~ 0
MA4
Text Label 3800 2200 0    60   ~ 0
MA5
Text Label 3800 2300 0    60   ~ 0
MA6
Text Label 3800 2400 0    60   ~ 0
MA7
Text Label 3800 2500 0    60   ~ 0
MA8
Text Label 3800 2600 0    60   ~ 0
MA9
Text Label 3800 2700 0    60   ~ 0
MA10
Text Label 3800 2800 0    60   ~ 0
MA11
Text Label 3800 2900 0    60   ~ 0
MA12
Text Label 3800 3000 0    60   ~ 0
MA16
Text Label 3800 3100 0    60   ~ 0
MA17
Text Label 3800 3200 0    60   ~ 0
MA18
Text Label 3800 3300 0    60   ~ 0
MA19
Wire Wire Line
	2900 2800 3550 2800
Wire Wire Line
	5200 2800 6200 2800
Wire Wire Line
	3550 2800 3550 3600
$Comp
L R R138
U 1 1 5C2F885E
P 5550 1400
F 0 "R138" V 5630 1400 50  0000 C CNN
F 1 "10k" V 5550 1400 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 5480 1400 50  0001 C CNN
F 3 "" H 5550 1400 50  0001 C CNN
	1    5550 1400
	0    1    1    0   
$EndComp
Wire Wire Line
	5700 1400 5700 2800
Connection ~ 5700 2800
$Comp
L R R136
U 1 1 5C2F9014
P 3150 1300
F 0 "R136" V 3230 1300 50  0000 C CNN
F 1 "10k" V 3150 1300 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 3080 1300 50  0001 C CNN
F 3 "" H 3150 1300 50  0001 C CNN
	1    3150 1300
	0    1    1    0   
$EndComp
Wire Wire Line
	3300 1300 3300 2800
Connection ~ 3300 2800
Wire Wire Line
	3000 1300 3000 1400
Connection ~ 3000 1400
Text HLabel 3550 3600 3    60   Input ~ 0
WRAM_~CS
Text HLabel 6200 2800 2    60   Input ~ 0
XRAM_~CS
Text HLabel 6200 2550 2    60   Input ~ 0
~MRD
Text HLabel 6200 2650 2    60   Input ~ 0
~MWR
Text HLabel 6200 6050 2    60   Input ~ 0
~PROG
Wire Wire Line
	2900 6200 3500 6200
Wire Wire Line
	5200 6200 6200 6200
Text Label 3500 6200 2    60   ~ 0
ROM_~CS
Text Label 5900 6200 2    60   ~ 0
ROM_~CS
Text HLabel 6200 6200 2    60   Input ~ 0
ROM_~CS
Text HLabel 1100 7200 3    60   Input ~ 0
MA[0..20]
Text HLabel 3600 5100 1    60   3State ~ 0
MD[0..7]
$Comp
L C C91
U 1 1 5C227CC5
P 2950 7050
F 0 "C91" H 2975 7150 50  0000 L CNN
F 1 "100n" H 2975 6950 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 2988 6900 50  0001 C CNN
F 3 "" H 2950 7050 50  0001 C CNN
	1    2950 7050
	1    0    0    -1  
$EndComp
$Comp
L C C93
U 1 1 5C227D66
P 3200 7050
F 0 "C93" H 3225 7150 50  0000 L CNN
F 1 "100n" H 3225 6950 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 3238 6900 50  0001 C CNN
F 3 "" H 3200 7050 50  0001 C CNN
	1    3200 7050
	1    0    0    -1  
$EndComp
$Comp
L C C95
U 1 1 5C227DB3
P 5250 7050
F 0 "C95" H 5275 7150 50  0000 L CNN
F 1 "100n" H 5275 6950 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 5288 6900 50  0001 C CNN
F 3 "" H 5250 7050 50  0001 C CNN
	1    5250 7050
	1    0    0    -1  
$EndComp
$Comp
L C C97
U 1 1 5C227E3A
P 5500 7050
F 0 "C97" H 5525 7150 50  0000 L CNN
F 1 "100n" H 5525 6950 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 5538 6900 50  0001 C CNN
F 3 "" H 5500 7050 50  0001 C CNN
	1    5500 7050
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 4800 2950 4800
Wire Wire Line
	2950 4600 2950 6900
Connection ~ 2400 4800
Wire Wire Line
	4400 4800 5250 4800
Wire Wire Line
	5250 4800 5250 6900
Connection ~ 4700 4800
Wire Wire Line
	5250 6800 5500 6800
Wire Wire Line
	5500 6800 5500 6900
Connection ~ 5250 6800
Wire Wire Line
	2950 6800 3200 6800
Wire Wire Line
	3200 6700 3200 6900
Connection ~ 2950 6800
Wire Wire Line
	2950 7200 2950 7300
Wire Wire Line
	2400 7300 3200 7300
Connection ~ 2400 7300
Wire Wire Line
	3200 7300 3200 7200
Connection ~ 2950 7300
Wire Wire Line
	5500 7200 5500 7300
Wire Wire Line
	5500 7300 4700 7300
Connection ~ 4700 7300
Wire Wire Line
	5250 7200 5250 7300
Connection ~ 5250 7300
$Comp
L SRAM_1M_X8 U21
U 1 1 5C22B43A
P 4700 6050
F 0 "U21" H 4400 7150 50  0000 C CNN
F 1 "IS62WV10248EBLL-45TLI" V 4700 6050 50  0000 C CNN
F 2 "housing:44-400mil-TSOP-2" H 4700 6100 50  0001 C CIN
F 3 "" H 4700 6100 50  0001 C CNN
F 4 "SRAM 1M x 8bit" V 4800 6050 60  0000 C CIN "Description"
	1    4700 6050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3100 6300 2900 6300
Wire Wire Line
	3100 4200 3100 6300
Wire Wire Line
	3100 4500 3600 4500
Entry Wire Line
	3600 4500 3700 4600
Text Label 3500 4500 2    60   ~ 0
MA20
$Comp
L R R137
U 1 1 5C22DD54
P 3200 6550
F 0 "R137" V 3280 6550 50  0000 C CNN
F 1 "10k" V 3200 6550 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 3130 6550 50  0001 C CNN
F 3 "" H 3200 6550 50  0001 C CNN
	1    3200 6550
	1    0    0    -1  
$EndComp
Wire Wire Line
	3200 6200 3200 6400
Connection ~ 3200 6200
Connection ~ 3200 6800
$Comp
L 74AHC1G14 U19
U 1 1 5C2307E9
P 4450 4200
F 0 "U19" H 4595 4315 50  0000 C CNN
F 1 "74AHC1GU04" H 4650 4100 50  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-353_SC-70-5" H 4545 4065 50  0001 C CNN
F 3 "" H 4595 4315 50  0001 C CNN
	1    4450 4200
	1    0    0    1   
$EndComp
Wire Wire Line
	4400 3600 4400 4000
Wire Wire Line
	4400 4400 4400 4800
Wire Wire Line
	2950 4200 4000 4200
Connection ~ 3100 4500
$Comp
L R R135
U 1 1 5C2325D4
P 2950 4450
F 0 "R135" V 3030 4450 50  0000 C CNN
F 1 "10k" V 2950 4450 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 2880 4450 50  0001 C CNN
F 3 "" H 2950 4450 50  0001 C CNN
	1    2950 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	2950 4200 2950 4300
Connection ~ 3100 4200
Connection ~ 2950 4800
Wire Wire Line
	4900 4200 5400 4200
Wire Wire Line
	5400 4200 5400 6300
Wire Wire Line
	5400 6300 5200 6300
Text Label 5100 4200 0    60   ~ 0
~MA20
Connection ~ 5400 1400
$EndSCHEMATC
