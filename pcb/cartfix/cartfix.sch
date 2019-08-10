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
LIBS:cartfix-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Cartridge Adapter Fix for gbreveng board"
Date "2019-04-07"
Rev "0"
Comp "Author: Michael Singer"
Comment1 "https://sourceforge.net/projects/iceboy/"
Comment2 "http://iceboy.a-singer.de/"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CONN_02X16 J1
U 1 1 5CAA18AC
P 3750 3650
F 0 "J1" H 3750 4500 50  0000 C CNN
F 1 "CONN_02X16" V 3750 3650 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x16_Pitch2.54mm" H 3750 2550 50  0001 C CNN
F 3 "" H 3750 2550 50  0001 C CNN
	1    3750 3650
	1    0    0    -1  
$EndComp
$Comp
L CONN_02X16 J2
U 1 1 5CAA1905
P 4650 3650
F 0 "J2" H 4650 4500 50  0000 C CNN
F 1 "CONN_02X16" V 4650 3650 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x16_Pitch2.54mm" H 4650 2550 50  0001 C CNN
F 3 "" H 4650 2550 50  0001 C CNN
	1    4650 3650
	-1   0    0    1   
$EndComp
Wire Wire Line
	4000 2900 4400 2900
Wire Wire Line
	4400 4400 4000 4400
Wire Wire Line
	4400 4300 4000 4300
Wire Wire Line
	4000 4200 4400 4200
Wire Wire Line
	4400 4100 4000 4100
Wire Wire Line
	4000 4000 4400 4000
Wire Wire Line
	4400 3900 4000 3900
Wire Wire Line
	4000 3800 4400 3800
Wire Wire Line
	4400 3700 4000 3700
Wire Wire Line
	4000 3600 4400 3600
Wire Wire Line
	4400 3500 4000 3500
Wire Wire Line
	4000 3400 4400 3400
Wire Wire Line
	4400 3300 4000 3300
Wire Wire Line
	4000 3200 4400 3200
Wire Wire Line
	4400 3100 4000 3100
Wire Wire Line
	4000 3000 4400 3000
Wire Wire Line
	4900 2900 5000 2900
Wire Wire Line
	5000 2900 5000 2700
Wire Wire Line
	5000 2700 3400 2700
Wire Wire Line
	3400 2700 3400 2900
Wire Wire Line
	3400 2900 3500 2900
Wire Wire Line
	4900 3000 5100 3000
Wire Wire Line
	5100 3000 5100 2600
Wire Wire Line
	5100 2600 3300 2600
Wire Wire Line
	3300 2600 3300 3000
Wire Wire Line
	3300 3000 3500 3000
Wire Wire Line
	4900 3100 5200 3100
Wire Wire Line
	5200 3100 5200 2500
Wire Wire Line
	5200 2500 3200 2500
Wire Wire Line
	3200 2500 3200 3100
Wire Wire Line
	3200 3100 3500 3100
Wire Wire Line
	4900 3200 5300 3200
Wire Wire Line
	5300 3200 5300 2400
Wire Wire Line
	5300 2400 3100 2400
Wire Wire Line
	3100 2400 3100 3200
Wire Wire Line
	3100 3200 3500 3200
Wire Wire Line
	4900 3300 5400 3300
Wire Wire Line
	5400 3300 5400 2300
Wire Wire Line
	5400 2300 3000 2300
Wire Wire Line
	3000 2300 3000 3300
Wire Wire Line
	3000 3300 3500 3300
Wire Wire Line
	4900 3400 5500 3400
Wire Wire Line
	5500 3400 5500 2200
Wire Wire Line
	5500 2200 2900 2200
Wire Wire Line
	2900 2200 2900 3400
Wire Wire Line
	2900 3400 3500 3400
Wire Wire Line
	4900 3500 5600 3500
Wire Wire Line
	5600 3500 5600 2100
Wire Wire Line
	5600 2100 2800 2100
Wire Wire Line
	2800 2100 2800 3500
Wire Wire Line
	2800 3500 3500 3500
Wire Wire Line
	4900 3600 5700 3600
Wire Wire Line
	5700 3600 5700 2000
Wire Wire Line
	5700 2000 2700 2000
Wire Wire Line
	2700 2000 2700 3600
Wire Wire Line
	2700 3600 3500 3600
Wire Wire Line
	4900 4400 5000 4400
Wire Wire Line
	5000 4400 5000 4600
Wire Wire Line
	5000 4600 3400 4600
Wire Wire Line
	3400 4600 3400 4400
Wire Wire Line
	3400 4400 3500 4400
Wire Wire Line
	4900 4300 5100 4300
Wire Wire Line
	5100 4300 5100 4700
Wire Wire Line
	5100 4700 3300 4700
Wire Wire Line
	3300 4700 3300 4300
Wire Wire Line
	3300 4300 3500 4300
Wire Wire Line
	4900 4200 5200 4200
Wire Wire Line
	5200 4200 5200 4800
Wire Wire Line
	5200 4800 3200 4800
Wire Wire Line
	3200 4800 3200 4200
Wire Wire Line
	3200 4200 3500 4200
Wire Wire Line
	4900 4100 5300 4100
Wire Wire Line
	5300 4100 5300 4900
Wire Wire Line
	5300 4900 3100 4900
Wire Wire Line
	3100 4900 3100 4100
Wire Wire Line
	3100 4100 3500 4100
Wire Wire Line
	4900 4000 5400 4000
Wire Wire Line
	5400 4000 5400 5000
Wire Wire Line
	5400 5000 3000 5000
Wire Wire Line
	3000 5000 3000 4000
Wire Wire Line
	3000 4000 3500 4000
Wire Wire Line
	4900 3900 5500 3900
Wire Wire Line
	5500 3900 5500 5100
Wire Wire Line
	5500 5100 2900 5100
Wire Wire Line
	2900 5100 2900 3900
Wire Wire Line
	2900 3900 3500 3900
Wire Wire Line
	4900 3800 5600 3800
Wire Wire Line
	5600 3800 5600 5200
Wire Wire Line
	5600 5200 2800 5200
Wire Wire Line
	2800 5200 2800 3800
Wire Wire Line
	2800 3800 3500 3800
Wire Wire Line
	4900 3700 5700 3700
Wire Wire Line
	5700 3700 5700 5300
Wire Wire Line
	5700 5300 2700 5300
Wire Wire Line
	2700 5300 2700 3700
Wire Wire Line
	2700 3700 3500 3700
$EndSCHEMATC
