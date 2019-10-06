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
LIBS:disp_bridge-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Display Bridge"
Date "2019-10-06"
Rev "1"
Comp "Author: Michael Singer"
Comment1 "https://sourceforge.net/projects/iceboy/"
Comment2 "http://iceboy.a-singer.de/"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CONN_01X21 J1
U 1 1 5D4EFD04
P 1800 3600
F 0 "J1" H 1800 4700 50  0000 C CNN
F 1 "CONN_01X21" V 1900 3600 50  0000 C CNN
F 2 "fcc:Molex-SD-52045-2145" H 1800 3600 50  0001 C CNN
F 3 "" H 1800 3600 50  0001 C CNN
	1    1800 3600
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X21 J2
U 1 1 5D4F006C
P 3300 3600
F 0 "J2" H 3300 4700 50  0000 C CNN
F 1 "CONN_01X21" V 3400 3600 50  0000 C CNN
F 2 "fcc:Molex-SD-52045-2145" H 3300 3600 50  0001 C CNN
F 3 "" H 3300 3600 50  0001 C CNN
	1    3300 3600
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X21 J3
U 1 1 5D4F015F
P 4700 3600
F 0 "J3" H 4700 4700 50  0000 C CNN
F 1 "CONN_01X21" V 4800 3600 50  0000 C CNN
F 2 "fcc:Molex-SD-52045-2145" H 4700 3600 50  0001 C CNN
F 3 "" H 4700 3600 50  0001 C CNN
	1    4700 3600
	1    0    0    -1  
$EndComp
$Comp
L CONN_02X13 J4
U 1 1 5D4F0217
P 6850 3200
F 0 "J4" H 6850 3900 50  0000 C CNN
F 1 "CONN_02X13" V 6850 3200 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x13_Pitch2.54mm" H 6850 2050 50  0001 C CNN
F 3 "" H 6850 2050 50  0001 C CNN
	1    6850 3200
	1    0    0    -1  
$EndComp
$Comp
L CONN_02X13 J5
U 1 1 5D4F0256
P 9050 3200
F 0 "J5" H 9050 3900 50  0000 C CNN
F 1 "CONN_02X13" V 9050 3200 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x13_Pitch2.54mm" H 9050 2050 50  0001 C CNN
F 3 "" H 9050 2050 50  0001 C CNN
	1    9050 3200
	1    0    0    -1  
$EndComp
Wire Bus Line
	700  2200 700  5200
Wire Bus Line
	700  5200 10500 5200
Wire Bus Line
	10500 5200 10500 2200
Text Label 8700 5200 0    60   ~ 0
P[1..21]
Wire Bus Line
	8000 2200 8000 5200
Wire Bus Line
	5300 2200 5300 5200
Wire Bus Line
	3800 2200 3800 5200
Wire Bus Line
	2300 2200 2300 5200
Connection ~ 2300 5200
Connection ~ 3800 5200
Connection ~ 5300 5200
Connection ~ 8000 5200
Wire Wire Line
	8100 2600 8800 2600
Wire Wire Line
	8100 2700 8800 2700
Wire Wire Line
	8100 2800 8800 2800
Wire Wire Line
	8100 2900 8800 2900
Wire Wire Line
	8100 3000 8800 3000
Wire Wire Line
	8100 3100 8800 3100
Wire Wire Line
	8100 3200 8800 3200
Wire Wire Line
	8100 3300 8800 3300
Wire Wire Line
	8100 3400 8800 3400
Wire Wire Line
	8100 3500 8800 3500
Wire Wire Line
	8100 3600 8800 3600
Wire Wire Line
	10400 2600 9300 2600
Wire Wire Line
	10400 2700 9300 2700
Wire Wire Line
	10400 2800 9300 2800
Wire Wire Line
	10400 2900 9300 2900
Wire Wire Line
	10400 3000 9300 3000
Wire Wire Line
	10400 3100 9300 3100
Wire Wire Line
	10400 3200 9300 3200
Wire Wire Line
	10400 3300 9300 3300
Wire Wire Line
	10400 3400 9300 3400
Wire Wire Line
	10400 3500 9300 3500
Wire Wire Line
	7900 2600 7100 2600
Wire Wire Line
	7900 2700 7100 2700
Wire Wire Line
	7900 2800 7100 2800
Wire Wire Line
	7900 2900 7100 2900
Wire Wire Line
	7900 3000 7100 3000
Wire Wire Line
	7900 3100 7100 3100
Wire Wire Line
	7900 3200 7100 3200
Wire Wire Line
	7900 3300 7100 3300
Wire Wire Line
	7900 3400 7100 3400
Wire Wire Line
	7900 3500 7100 3500
Wire Wire Line
	5400 2600 6600 2600
Wire Wire Line
	5400 2700 6600 2700
Wire Wire Line
	5400 2800 6600 2800
Wire Wire Line
	5400 2900 6600 2900
Wire Wire Line
	5400 3000 6600 3000
Wire Wire Line
	5400 3100 6600 3100
Wire Wire Line
	5400 3200 6600 3200
Wire Wire Line
	5400 3300 6600 3300
Wire Wire Line
	5400 3400 6600 3400
Wire Wire Line
	5400 3500 6600 3500
Wire Wire Line
	5400 3600 6600 3600
Wire Wire Line
	3900 2600 4500 2600
Wire Wire Line
	3900 2700 4500 2700
Wire Wire Line
	3900 2800 4500 2800
Wire Wire Line
	3900 2900 4500 2900
Wire Wire Line
	3900 3000 4500 3000
Wire Wire Line
	3900 3100 4500 3100
Wire Wire Line
	3900 3200 4500 3200
Wire Wire Line
	3900 3300 4500 3300
Wire Wire Line
	3900 3400 4500 3400
Wire Wire Line
	3900 3500 4500 3500
Wire Wire Line
	3900 3600 4500 3600
Wire Wire Line
	3900 3700 4500 3700
Wire Wire Line
	3900 3800 4500 3800
Wire Wire Line
	3900 3900 4500 3900
Wire Wire Line
	3900 4000 4500 4000
Wire Wire Line
	3900 4100 4500 4100
Wire Wire Line
	3900 4200 4500 4200
Wire Wire Line
	3900 4300 4500 4300
Wire Wire Line
	3900 4400 4500 4400
Wire Wire Line
	3900 4500 4500 4500
Wire Wire Line
	3900 4600 4500 4600
Wire Wire Line
	2400 2600 3100 2600
Wire Wire Line
	2400 2700 3100 2700
Wire Wire Line
	2400 2800 3100 2800
Wire Wire Line
	2400 2900 3100 2900
Wire Wire Line
	2400 3000 3100 3000
Wire Wire Line
	2400 3100 3100 3100
Wire Wire Line
	2400 3200 3100 3200
Wire Wire Line
	2400 3300 3100 3300
Wire Wire Line
	2400 3400 3100 3400
Wire Wire Line
	2400 3500 3100 3500
Wire Wire Line
	2400 3600 3100 3600
Wire Wire Line
	2400 3700 3100 3700
Wire Wire Line
	2400 3800 3100 3800
Wire Wire Line
	2400 3900 3100 3900
Wire Wire Line
	2400 4000 3100 4000
Wire Wire Line
	2400 4100 3100 4100
Wire Wire Line
	2400 4200 3100 4200
Wire Wire Line
	2400 4300 3100 4300
Wire Wire Line
	2400 4400 3100 4400
Wire Wire Line
	2400 4500 3100 4500
Wire Wire Line
	2400 4600 3100 4600
Wire Wire Line
	800  2600 1600 2600
Wire Wire Line
	800  2700 1600 2700
Wire Wire Line
	800  2800 1600 2800
Wire Wire Line
	800  2900 1600 2900
Wire Wire Line
	800  3000 1600 3000
Wire Wire Line
	800  3100 1600 3100
Wire Wire Line
	800  3200 1600 3200
Wire Wire Line
	800  3300 1600 3300
Wire Wire Line
	800  3400 1600 3400
Wire Wire Line
	800  3500 1600 3500
Wire Wire Line
	800  3600 1600 3600
Wire Wire Line
	800  3700 1600 3700
Wire Wire Line
	800  3800 1600 3800
Wire Wire Line
	800  3900 1600 3900
Wire Wire Line
	800  4000 1600 4000
Wire Wire Line
	800  4100 1600 4100
Wire Wire Line
	800  4200 1600 4200
Wire Wire Line
	800  4300 1600 4300
Wire Wire Line
	800  4400 1600 4400
Wire Wire Line
	800  4500 1600 4500
Wire Wire Line
	800  4600 1600 4600
Entry Wire Line
	700  2700 800  2600
Entry Wire Line
	700  2800 800  2700
Entry Wire Line
	700  2900 800  2800
Entry Wire Line
	700  3000 800  2900
Entry Wire Line
	700  3100 800  3000
Entry Wire Line
	700  3200 800  3100
Entry Wire Line
	700  3300 800  3200
Entry Wire Line
	700  3400 800  3300
Entry Wire Line
	700  3500 800  3400
Entry Wire Line
	700  3600 800  3500
Entry Wire Line
	700  3700 800  3600
Entry Wire Line
	700  3800 800  3700
Entry Wire Line
	700  3900 800  3800
Entry Wire Line
	700  4000 800  3900
Entry Wire Line
	700  4100 800  4000
Entry Wire Line
	700  4200 800  4100
Entry Wire Line
	700  4300 800  4200
Entry Wire Line
	700  4400 800  4300
Entry Wire Line
	700  4500 800  4400
Entry Wire Line
	700  4600 800  4500
Entry Wire Line
	700  4700 800  4600
Entry Wire Line
	2300 2700 2400 2600
Entry Wire Line
	2300 2800 2400 2700
Entry Wire Line
	2300 2900 2400 2800
Entry Wire Line
	2300 3000 2400 2900
Entry Wire Line
	2300 3100 2400 3000
Entry Wire Line
	2300 3200 2400 3100
Entry Wire Line
	2300 3300 2400 3200
Entry Wire Line
	2300 3400 2400 3300
Entry Wire Line
	2300 3500 2400 3400
Entry Wire Line
	2300 3600 2400 3500
Entry Wire Line
	2300 3700 2400 3600
Entry Wire Line
	2300 3800 2400 3700
Entry Wire Line
	2300 3900 2400 3800
Entry Wire Line
	2300 4000 2400 3900
Entry Wire Line
	2300 4100 2400 4000
Entry Wire Line
	2300 4200 2400 4100
Entry Wire Line
	2300 4300 2400 4200
Entry Wire Line
	2300 4400 2400 4300
Entry Wire Line
	2300 4500 2400 4400
Entry Wire Line
	2300 4600 2400 4500
Entry Wire Line
	2300 4700 2400 4600
Entry Wire Line
	3800 2700 3900 2600
Entry Wire Line
	3800 2800 3900 2700
Entry Wire Line
	3800 2900 3900 2800
Entry Wire Line
	3800 3000 3900 2900
Entry Wire Line
	3800 3100 3900 3000
Entry Wire Line
	3800 3200 3900 3100
Entry Wire Line
	3800 3300 3900 3200
Entry Wire Line
	3800 3400 3900 3300
Entry Wire Line
	3800 3500 3900 3400
Entry Wire Line
	3800 3600 3900 3500
Entry Wire Line
	3800 3700 3900 3600
Entry Wire Line
	3800 3800 3900 3700
Entry Wire Line
	3800 3900 3900 3800
Entry Wire Line
	3800 4000 3900 3900
Entry Wire Line
	3800 4100 3900 4000
Entry Wire Line
	3800 4200 3900 4100
Entry Wire Line
	3800 4300 3900 4200
Entry Wire Line
	3800 4400 3900 4300
Entry Wire Line
	3800 4500 3900 4400
Entry Wire Line
	3800 4600 3900 4500
Entry Wire Line
	3800 4700 3900 4600
Entry Wire Line
	5300 2700 5400 2600
Entry Wire Line
	5300 2800 5400 2700
Entry Wire Line
	5300 2900 5400 2800
Entry Wire Line
	5300 3000 5400 2900
Entry Wire Line
	5300 3100 5400 3000
Entry Wire Line
	5300 3200 5400 3100
Entry Wire Line
	5300 3300 5400 3200
Entry Wire Line
	5300 3400 5400 3300
Entry Wire Line
	5300 3500 5400 3400
Entry Wire Line
	5300 3600 5400 3500
Entry Wire Line
	5300 3700 5400 3600
Entry Wire Line
	8000 2700 8100 2600
Entry Wire Line
	8000 2800 8100 2700
Entry Wire Line
	8000 2900 8100 2800
Entry Wire Line
	8000 3000 8100 2900
Entry Wire Line
	8000 3100 8100 3000
Entry Wire Line
	8000 3200 8100 3100
Entry Wire Line
	8000 3300 8100 3200
Entry Wire Line
	8000 3400 8100 3300
Entry Wire Line
	8000 3500 8100 3400
Entry Wire Line
	8000 3600 8100 3500
Entry Wire Line
	8000 3700 8100 3600
Entry Wire Line
	7900 2600 8000 2700
Entry Wire Line
	7900 2700 8000 2800
Entry Wire Line
	7900 2800 8000 2900
Entry Wire Line
	7900 2900 8000 3000
Entry Wire Line
	7900 3000 8000 3100
Entry Wire Line
	7900 3100 8000 3200
Entry Wire Line
	7900 3200 8000 3300
Entry Wire Line
	7900 3300 8000 3400
Entry Wire Line
	7900 3400 8000 3500
Entry Wire Line
	7900 3500 8000 3600
Entry Wire Line
	10400 2600 10500 2700
Entry Wire Line
	10400 2700 10500 2800
Entry Wire Line
	10400 2800 10500 2900
Entry Wire Line
	10400 2900 10500 3000
Entry Wire Line
	10400 3000 10500 3100
Entry Wire Line
	10400 3100 10500 3200
Entry Wire Line
	10400 3200 10500 3300
Entry Wire Line
	10400 3300 10500 3400
Entry Wire Line
	10400 3400 10500 3500
Entry Wire Line
	10400 3500 10500 3600
Text Label 1050 2600 0    60   ~ 0
P1
Text Label 1050 2700 0    60   ~ 0
P2
Text Label 1050 2800 0    60   ~ 0
P3
Text Label 1050 2900 0    60   ~ 0
P4
Text Label 1050 3000 0    60   ~ 0
P5
Text Label 1050 3100 0    60   ~ 0
P6
Text Label 1050 3200 0    60   ~ 0
P7
Text Label 1050 3300 0    60   ~ 0
P8
Text Label 1050 3400 0    60   ~ 0
P9
Text Label 1050 3500 0    60   ~ 0
P10
Text Label 1050 3600 0    60   ~ 0
P11
Text Label 1050 3700 0    60   ~ 0
P12
Text Label 1050 3800 0    60   ~ 0
P13
Text Label 1050 3900 0    60   ~ 0
P14
Text Label 1050 4000 0    60   ~ 0
P15
Text Label 1050 4100 0    60   ~ 0
P16
Text Label 1050 4200 0    60   ~ 0
P17
Text Label 1050 4300 0    60   ~ 0
P18
Text Label 1050 4400 0    60   ~ 0
P19
Text Label 1050 4500 0    60   ~ 0
P20
Text Label 1050 4600 0    60   ~ 0
P21
Text Label 2550 4600 0    60   ~ 0
P1
Text Label 2550 4500 0    60   ~ 0
P2
Text Label 2550 4400 0    60   ~ 0
P3
Text Label 2550 4300 0    60   ~ 0
P4
Text Label 2550 4200 0    60   ~ 0
P5
Text Label 2550 4100 0    60   ~ 0
P6
Text Label 2550 4000 0    60   ~ 0
P7
Text Label 2550 3900 0    60   ~ 0
P8
Text Label 2550 3800 0    60   ~ 0
P9
Text Label 2550 3700 0    60   ~ 0
P10
Text Label 2550 3600 0    60   ~ 0
P11
Text Label 2550 3500 0    60   ~ 0
P12
Text Label 2550 3400 0    60   ~ 0
P13
Text Label 2550 3300 0    60   ~ 0
P14
Text Label 2550 3200 0    60   ~ 0
P15
Text Label 2550 3100 0    60   ~ 0
P16
Text Label 2550 3000 0    60   ~ 0
P17
Text Label 2550 2900 0    60   ~ 0
P18
Text Label 2550 2800 0    60   ~ 0
P19
Text Label 2550 2700 0    60   ~ 0
P20
Text Label 2550 2600 0    60   ~ 0
P21
Text Label 4050 2600 0    60   ~ 0
P1
Text Label 4050 2700 0    60   ~ 0
P2
Text Label 4050 2800 0    60   ~ 0
P3
Text Label 4050 2900 0    60   ~ 0
P4
Text Label 4050 3000 0    60   ~ 0
P5
Text Label 4050 3100 0    60   ~ 0
P6
Text Label 4050 3200 0    60   ~ 0
P7
Text Label 4050 3300 0    60   ~ 0
P8
Text Label 4050 3400 0    60   ~ 0
P9
Text Label 4050 3500 0    60   ~ 0
P10
Text Label 4050 3600 0    60   ~ 0
P11
Text Label 4050 3700 0    60   ~ 0
P12
Text Label 4050 3800 0    60   ~ 0
P13
Text Label 4050 3900 0    60   ~ 0
P14
Text Label 4050 4000 0    60   ~ 0
P15
Text Label 4050 4100 0    60   ~ 0
P16
Text Label 4050 4200 0    60   ~ 0
P17
Text Label 4050 4300 0    60   ~ 0
P18
Text Label 4050 4400 0    60   ~ 0
P19
Text Label 4050 4500 0    60   ~ 0
P20
Text Label 4050 4600 0    60   ~ 0
P21
Text Label 5550 2600 0    60   ~ 0
P1
Text Label 7700 2600 0    60   ~ 0
P2
Text Label 5550 2700 0    60   ~ 0
P3
Text Label 7700 2700 0    60   ~ 0
P4
Text Label 5550 2800 0    60   ~ 0
P5
Text Label 7700 2800 0    60   ~ 0
P6
Text Label 5550 2900 0    60   ~ 0
P7
Text Label 7700 2900 0    60   ~ 0
P8
Text Label 5550 3000 0    60   ~ 0
P9
Text Label 7700 3000 0    60   ~ 0
P10
Text Label 5550 3100 0    60   ~ 0
P11
Text Label 7700 3100 0    60   ~ 0
P12
Text Label 5550 3200 0    60   ~ 0
P13
Text Label 7700 3200 0    60   ~ 0
P14
Text Label 5550 3300 0    60   ~ 0
P15
Text Label 7700 3300 0    60   ~ 0
P16
Text Label 5550 3400 0    60   ~ 0
P17
Text Label 7700 3400 0    60   ~ 0
P18
Text Label 5550 3500 0    60   ~ 0
P19
Text Label 7700 3500 0    60   ~ 0
P20
Text Label 5550 3600 0    60   ~ 0
P21
NoConn ~ 9300 3600
NoConn ~ 9300 3700
NoConn ~ 9300 3800
NoConn ~ 8800 3700
NoConn ~ 8800 3800
NoConn ~ 7100 3600
NoConn ~ 7100 3700
NoConn ~ 7100 3800
NoConn ~ 6600 3800
NoConn ~ 6600 3700
Text Label 8250 2600 0    60   ~ 0
P1
Text Label 10200 2600 0    60   ~ 0
P2
Text Label 8250 2700 0    60   ~ 0
P3
Text Label 10200 2700 0    60   ~ 0
P4
Text Label 8250 2800 0    60   ~ 0
P5
Text Label 10200 2800 0    60   ~ 0
P6
Text Label 8250 2900 0    60   ~ 0
P7
Text Label 10200 2900 0    60   ~ 0
P8
Text Label 8250 3000 0    60   ~ 0
P9
Text Label 10200 3000 0    60   ~ 0
P10
Text Label 8250 3100 0    60   ~ 0
P11
Text Label 10200 3100 0    60   ~ 0
P12
Text Label 8250 3200 0    60   ~ 0
P13
Text Label 10200 3200 0    60   ~ 0
P14
Text Label 8250 3300 0    60   ~ 0
P15
Text Label 10200 3300 0    60   ~ 0
P16
Text Label 8250 3400 0    60   ~ 0
P17
Text Label 10200 3400 0    60   ~ 0
P18
Text Label 8250 3500 0    60   ~ 0
P19
Text Label 10200 3500 0    60   ~ 0
P20
Text Label 8250 3600 0    60   ~ 0
P21
Text Notes 1300 2600 0    60   ~ 0
GND
Text Notes 1300 2700 0    60   ~ 0
LED
Text Notes 1300 2800 0    60   ~ 0
-19V
Text Notes 1300 2900 0    60   ~ 0
P11
Text Notes 1300 3000 0    60   ~ 0
P14
Text Notes 1300 3100 0    60   ~ 0
P13
Text Notes 1300 3200 0    60   ~ 0
P12
Text Notes 1300 3300 0    60   ~ 0
P10
Text Notes 1300 3400 0    60   ~ 0
P15
Text Notes 1300 3500 0    60   ~ 0
GND
Text Notes 1300 3600 0    60   ~ 0
VCC
Text Notes 1300 3700 0    60   ~ 0
VSYNC
Text Notes 1300 3800 0    60   ~ 0
ALT
Text Notes 1300 3900 0    60   ~ 0
CLK
Text Notes 1300 4000 0    60   ~ 0
D1
Text Notes 1300 4100 0    60   ~ 0
D0
Text Notes 1300 4200 0    60   ~ 0
HSYNC
Text Notes 1300 4300 0    60   ~ 0
LATCH
Text Notes 1300 4400 0    60   ~ 0
CTRL
Text Notes 1300 4500 0    60   ~ 0
SPKR
Text Notes 1300 4600 0    60   ~ 0
GND
Text Notes 6000 2600 0    60   ~ 0
GND
Text Notes 7250 2600 0    60   ~ 0
LED
Text Notes 6000 2700 0    60   ~ 0
-19V
Text Notes 7250 2700 0    60   ~ 0
P11
Text Notes 6000 2800 0    60   ~ 0
P14
Text Notes 7250 2800 0    60   ~ 0
P13
Text Notes 6000 2900 0    60   ~ 0
P12
Text Notes 7250 2900 0    60   ~ 0
P10
Text Notes 6000 3000 0    60   ~ 0
P15
Text Notes 7250 3000 0    60   ~ 0
GND
Text Notes 6000 3100 0    60   ~ 0
VCC
Text Notes 7250 3100 0    60   ~ 0
VSYNC
Text Notes 6000 3200 0    60   ~ 0
ALT
Text Notes 7250 3200 0    60   ~ 0
CLK
Text Notes 6000 3300 0    60   ~ 0
D1
Text Notes 7250 3300 0    60   ~ 0
D0
Text Notes 6000 3400 0    60   ~ 0
HSYNC
Text Notes 7250 3400 0    60   ~ 0
LATCH
Text Notes 6000 3500 0    60   ~ 0
CTRL
Text Notes 7250 3500 0    60   ~ 0
SPKR
Text Notes 6000 3600 0    60   ~ 0
GND
$EndSCHEMATC
