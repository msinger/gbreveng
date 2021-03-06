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
Sheet 6 11
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
L iCE40-HX8K-CT256 U3
U 5 1 5C15B19A
P 2200 6900
F 0 "U3" H 2400 7150 60  0000 L CNN
F 1 "iCE40-HX8K-CT256" H 2400 7050 60  0000 L CNN
F 2 "bga:BGA-256_14.0x14.0mm_Layout16x16_P0.8mm_Ball0.45mm_Pad0.32mm_NSMD" H 2200 6900 60  0001 C CNN
F 3 "" H 2200 6900 60  0001 C CNN
	5    2200 6900
	-1   0    0    1   
$EndComp
$Comp
L C C64
U 1 1 5C15B61A
P 1900 1250
F 0 "C64" H 1925 1350 50  0000 L CNN
F 1 "100n" H 1925 1150 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 1938 1100 50  0001 C CNN
F 3 "" H 1900 1250 50  0001 C CNN
	1    1900 1250
	1    0    0    -1  
$EndComp
$Comp
L C C63
U 1 1 5C15B6B7
P 1650 1250
F 0 "C63" H 1675 1350 50  0000 L CNN
F 1 "100n" H 1675 1150 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 1688 1100 50  0001 C CNN
F 3 "" H 1650 1250 50  0001 C CNN
	1    1650 1250
	1    0    0    -1  
$EndComp
$Comp
L C C62
U 1 1 5C15B71C
P 1400 1250
F 0 "C62" H 1425 1350 50  0000 L CNN
F 1 "100n" H 1425 1150 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 1438 1100 50  0001 C CNN
F 3 "" H 1400 1250 50  0001 C CNN
	1    1400 1250
	1    0    0    -1  
$EndComp
$Comp
L C C61
U 1 1 5C15B799
P 1150 1250
F 0 "C61" H 1175 1350 50  0000 L CNN
F 1 "100n" H 1175 1150 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 1188 1100 50  0001 C CNN
F 3 "" H 1150 1250 50  0001 C CNN
	1    1150 1250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR074
U 1 1 5C15B86F
P 900 1500
F 0 "#PWR074" H 900 1250 50  0001 C CNN
F 1 "GND" H 900 1350 50  0000 C CNN
F 2 "" H 900 1500 50  0001 C CNN
F 3 "" H 900 1500 50  0001 C CNN
	1    900  1500
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR075
U 1 1 5C15B88F
P 2300 900
F 0 "#PWR075" H 2300 750 50  0001 C CNN
F 1 "+3V3" H 2300 1040 50  0000 C CNN
F 2 "" H 2300 900 50  0001 C CNN
F 3 "" H 2300 900 50  0001 C CNN
	1    2300 900 
	1    0    0    -1  
$EndComp
$Comp
L LED_ALT D0
U 1 1 5C1667D6
P 10050 1100
F 0 "D0" H 10050 1200 50  0000 C CNN
F 1 "red" H 10050 1000 50  0000 C CNN
F 2 "LEDs:LED_0805" H 10050 1100 50  0001 C CNN
F 3 "" H 10050 1100 50  0001 C CNN
	1    10050 1100
	-1   0    0    1   
$EndComp
$Comp
L R R67
U 1 1 5C168F55
P 10450 1100
F 0 "R67" V 10530 1100 50  0000 C CNN
F 1 "1k" V 10450 1100 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 10380 1100 50  0001 C CNN
F 3 "" H 10450 1100 50  0001 C CNN
	1    10450 1100
	0    1    1    0   
$EndComp
$Comp
L R R68
U 1 1 5C169134
P 10450 1350
F 0 "R68" V 10530 1350 50  0000 C CNN
F 1 "1k" V 10450 1350 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 10380 1350 50  0001 C CNN
F 3 "" H 10450 1350 50  0001 C CNN
	1    10450 1350
	0    1    1    0   
$EndComp
$Comp
L R R69
U 1 1 5C169241
P 10450 1600
F 0 "R69" V 10530 1600 50  0000 C CNN
F 1 "1k" V 10450 1600 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 10380 1600 50  0001 C CNN
F 3 "" H 10450 1600 50  0001 C CNN
	1    10450 1600
	0    1    1    0   
$EndComp
$Comp
L R R70
U 1 1 5C1692A6
P 10450 1850
F 0 "R70" V 10530 1850 50  0000 C CNN
F 1 "1k" V 10450 1850 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 10380 1850 50  0001 C CNN
F 3 "" H 10450 1850 50  0001 C CNN
	1    10450 1850
	0    1    1    0   
$EndComp
$Comp
L R R71
U 1 1 5C169311
P 10450 2100
F 0 "R71" V 10530 2100 50  0000 C CNN
F 1 "1k" V 10450 2100 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 10380 2100 50  0001 C CNN
F 3 "" H 10450 2100 50  0001 C CNN
	1    10450 2100
	0    1    1    0   
$EndComp
$Comp
L R R72
U 1 1 5C16935E
P 10450 2350
F 0 "R72" V 10530 2350 50  0000 C CNN
F 1 "1k" V 10450 2350 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 10380 2350 50  0001 C CNN
F 3 "" H 10450 2350 50  0001 C CNN
	1    10450 2350
	0    1    1    0   
$EndComp
$Comp
L R R73
U 1 1 5C16939B
P 10450 2600
F 0 "R73" V 10530 2600 50  0000 C CNN
F 1 "1k" V 10450 2600 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 10380 2600 50  0001 C CNN
F 3 "" H 10450 2600 50  0001 C CNN
	1    10450 2600
	0    1    1    0   
$EndComp
$Comp
L R R74
U 1 1 5C1693FA
P 10450 2850
F 0 "R74" V 10530 2850 50  0000 C CNN
F 1 "1k" V 10450 2850 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 10380 2850 50  0001 C CNN
F 3 "" H 10450 2850 50  0001 C CNN
	1    10450 2850
	0    1    1    0   
$EndComp
$Comp
L LED_ALT D1
U 1 1 5C1697ED
P 10050 1350
F 0 "D1" H 10050 1450 50  0000 C CNN
F 1 "red" H 10050 1250 50  0000 C CNN
F 2 "LEDs:LED_0805" H 10050 1350 50  0001 C CNN
F 3 "" H 10050 1350 50  0001 C CNN
	1    10050 1350
	-1   0    0    1   
$EndComp
$Comp
L LED_ALT D2
U 1 1 5C169882
P 10050 1600
F 0 "D2" H 10050 1700 50  0000 C CNN
F 1 "red" H 10050 1500 50  0000 C CNN
F 2 "LEDs:LED_0805" H 10050 1600 50  0001 C CNN
F 3 "" H 10050 1600 50  0001 C CNN
	1    10050 1600
	-1   0    0    1   
$EndComp
$Comp
L LED_ALT D3
U 1 1 5C16991F
P 10050 1850
F 0 "D3" H 10050 1950 50  0000 C CNN
F 1 "red" H 10050 1750 50  0000 C CNN
F 2 "LEDs:LED_0805" H 10050 1850 50  0001 C CNN
F 3 "" H 10050 1850 50  0001 C CNN
	1    10050 1850
	-1   0    0    1   
$EndComp
$Comp
L LED_ALT D4
U 1 1 5C1699BE
P 10050 2100
F 0 "D4" H 10050 2200 50  0000 C CNN
F 1 "red" H 10050 2000 50  0000 C CNN
F 2 "LEDs:LED_0805" H 10050 2100 50  0001 C CNN
F 3 "" H 10050 2100 50  0001 C CNN
	1    10050 2100
	-1   0    0    1   
$EndComp
$Comp
L LED_ALT D5
U 1 1 5C169A77
P 10050 2350
F 0 "D5" H 10050 2450 50  0000 C CNN
F 1 "red" H 10050 2250 50  0000 C CNN
F 2 "LEDs:LED_0805" H 10050 2350 50  0001 C CNN
F 3 "" H 10050 2350 50  0001 C CNN
	1    10050 2350
	-1   0    0    1   
$EndComp
$Comp
L LED_ALT D6
U 1 1 5C169B1A
P 10050 2600
F 0 "D6" H 10050 2700 50  0000 C CNN
F 1 "red" H 10050 2500 50  0000 C CNN
F 2 "LEDs:LED_0805" H 10050 2600 50  0001 C CNN
F 3 "" H 10050 2600 50  0001 C CNN
	1    10050 2600
	-1   0    0    1   
$EndComp
$Comp
L LED_ALT D7
U 1 1 5C169B95
P 10050 2850
F 0 "D7" H 10050 2950 50  0000 C CNN
F 1 "red" H 10050 2750 50  0000 C CNN
F 2 "LEDs:LED_0805" H 10050 2850 50  0001 C CNN
F 3 "" H 10050 2850 50  0001 C CNN
	1    10050 2850
	-1   0    0    1   
$EndComp
$Comp
L LED_ALT D8
U 1 1 5C16CBFF
P 10050 3250
F 0 "D8" H 10050 3350 50  0000 C CNN
F 1 "red" H 10050 3150 50  0000 C CNN
F 2 "LEDs:LED_0805" H 10050 3250 50  0001 C CNN
F 3 "" H 10050 3250 50  0001 C CNN
	1    10050 3250
	-1   0    0    1   
$EndComp
$Comp
L R R75
U 1 1 5C16CC05
P 10450 3250
F 0 "R75" V 10530 3250 50  0000 C CNN
F 1 "1k" V 10450 3250 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 10380 3250 50  0001 C CNN
F 3 "" H 10450 3250 50  0001 C CNN
	1    10450 3250
	0    1    1    0   
$EndComp
$Comp
L R R76
U 1 1 5C16CC0B
P 10450 3500
F 0 "R76" V 10530 3500 50  0000 C CNN
F 1 "1k" V 10450 3500 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 10380 3500 50  0001 C CNN
F 3 "" H 10450 3500 50  0001 C CNN
	1    10450 3500
	0    1    1    0   
$EndComp
$Comp
L R R77
U 1 1 5C16CC11
P 10450 3750
F 0 "R77" V 10530 3750 50  0000 C CNN
F 1 "1k" V 10450 3750 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 10380 3750 50  0001 C CNN
F 3 "" H 10450 3750 50  0001 C CNN
	1    10450 3750
	0    1    1    0   
$EndComp
$Comp
L R R78
U 1 1 5C16CC17
P 10450 4000
F 0 "R78" V 10530 4000 50  0000 C CNN
F 1 "1k" V 10450 4000 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 10380 4000 50  0001 C CNN
F 3 "" H 10450 4000 50  0001 C CNN
	1    10450 4000
	0    1    1    0   
$EndComp
$Comp
L R R79
U 1 1 5C16CC1D
P 10450 4250
F 0 "R79" V 10530 4250 50  0000 C CNN
F 1 "1k" V 10450 4250 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 10380 4250 50  0001 C CNN
F 3 "" H 10450 4250 50  0001 C CNN
	1    10450 4250
	0    1    1    0   
$EndComp
$Comp
L R R80
U 1 1 5C16CC23
P 10450 4500
F 0 "R80" V 10530 4500 50  0000 C CNN
F 1 "1k" V 10450 4500 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 10380 4500 50  0001 C CNN
F 3 "" H 10450 4500 50  0001 C CNN
	1    10450 4500
	0    1    1    0   
$EndComp
$Comp
L R R81
U 1 1 5C16CC29
P 10450 4750
F 0 "R81" V 10530 4750 50  0000 C CNN
F 1 "1k" V 10450 4750 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 10380 4750 50  0001 C CNN
F 3 "" H 10450 4750 50  0001 C CNN
	1    10450 4750
	0    1    1    0   
$EndComp
$Comp
L R R82
U 1 1 5C16CC2F
P 10450 5000
F 0 "R82" V 10530 5000 50  0000 C CNN
F 1 "1k" V 10450 5000 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 10380 5000 50  0001 C CNN
F 3 "" H 10450 5000 50  0001 C CNN
	1    10450 5000
	0    1    1    0   
$EndComp
$Comp
L LED_ALT D9
U 1 1 5C16CC35
P 10050 3500
F 0 "D9" H 10050 3600 50  0000 C CNN
F 1 "red" H 10050 3400 50  0000 C CNN
F 2 "LEDs:LED_0805" H 10050 3500 50  0001 C CNN
F 3 "" H 10050 3500 50  0001 C CNN
	1    10050 3500
	-1   0    0    1   
$EndComp
$Comp
L LED_ALT D10
U 1 1 5C16CC3B
P 10050 3750
F 0 "D10" H 10050 3850 50  0000 C CNN
F 1 "red" H 10050 3650 50  0000 C CNN
F 2 "LEDs:LED_0805" H 10050 3750 50  0001 C CNN
F 3 "" H 10050 3750 50  0001 C CNN
	1    10050 3750
	-1   0    0    1   
$EndComp
$Comp
L LED_ALT D11
U 1 1 5C16CC41
P 10050 4000
F 0 "D11" H 10050 4100 50  0000 C CNN
F 1 "red" H 10050 3900 50  0000 C CNN
F 2 "LEDs:LED_0805" H 10050 4000 50  0001 C CNN
F 3 "" H 10050 4000 50  0001 C CNN
	1    10050 4000
	-1   0    0    1   
$EndComp
$Comp
L LED_ALT D12
U 1 1 5C16CC47
P 10050 4250
F 0 "D12" H 10050 4350 50  0000 C CNN
F 1 "red" H 10050 4150 50  0000 C CNN
F 2 "LEDs:LED_0805" H 10050 4250 50  0001 C CNN
F 3 "" H 10050 4250 50  0001 C CNN
	1    10050 4250
	-1   0    0    1   
$EndComp
$Comp
L LED_ALT D13
U 1 1 5C16CC4D
P 10050 4500
F 0 "D13" H 10050 4600 50  0000 C CNN
F 1 "red" H 10050 4400 50  0000 C CNN
F 2 "LEDs:LED_0805" H 10050 4500 50  0001 C CNN
F 3 "" H 10050 4500 50  0001 C CNN
	1    10050 4500
	-1   0    0    1   
$EndComp
$Comp
L LED_ALT D14
U 1 1 5C16CC53
P 10050 4750
F 0 "D14" H 10050 4850 50  0000 C CNN
F 1 "red" H 10050 4650 50  0000 C CNN
F 2 "LEDs:LED_0805" H 10050 4750 50  0001 C CNN
F 3 "" H 10050 4750 50  0001 C CNN
	1    10050 4750
	-1   0    0    1   
$EndComp
$Comp
L LED_ALT D15
U 1 1 5C16CC59
P 10050 5000
F 0 "D15" H 10050 5100 50  0000 C CNN
F 1 "red" H 10050 4900 50  0000 C CNN
F 2 "LEDs:LED_0805" H 10050 5000 50  0001 C CNN
F 3 "" H 10050 5000 50  0001 C CNN
	1    10050 5000
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR076
U 1 1 5C16D5A9
P 10800 5100
F 0 "#PWR076" H 10800 4850 50  0001 C CNN
F 1 "GND" H 10800 4950 50  0000 C CNN
F 2 "" H 10800 5100 50  0001 C CNN
F 3 "" H 10800 5100 50  0001 C CNN
	1    10800 5100
	1    0    0    -1  
$EndComp
$Comp
L SW_DIP_x08 SW4
U 1 1 5C16F423
P 8100 3900
F 0 "SW4" H 8100 4450 50  0000 C CNN
F 1 "SW_DIP_x08" H 8100 3450 50  0000 C CNN
F 2 "Buttons_Switches_THT:SW_DIP_x8_W7.62mm_Slide" H 8100 3900 50  0001 C CNN
F 3 "" H 8100 3900 50  0001 C CNN
	1    8100 3900
	1    0    0    -1  
$EndComp
$Comp
L SW_DIP_x08 SW5
U 1 1 5C16F5A0
P 8100 5000
F 0 "SW5" H 8100 5550 50  0000 C CNN
F 1 "SW_DIP_x08" H 8100 4550 50  0000 C CNN
F 2 "Buttons_Switches_THT:SW_DIP_x8_W7.62mm_Slide" H 8100 5000 50  0001 C CNN
F 3 "" H 8100 5000 50  0001 C CNN
	1    8100 5000
	1    0    0    -1  
$EndComp
$Comp
L R R66
U 1 1 5C16F6B9
P 7700 5550
F 0 "R66" V 7780 5550 50  0000 C CNN
F 1 "10k" V 7700 5550 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 7630 5550 50  0001 C CNN
F 3 "" H 7700 5550 50  0001 C CNN
	1    7700 5550
	1    0    0    -1  
$EndComp
$Comp
L R R65
U 1 1 5C16F9BF
P 7550 5550
F 0 "R65" V 7630 5550 50  0000 C CNN
F 1 "10k" V 7550 5550 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 7480 5550 50  0001 C CNN
F 3 "" H 7550 5550 50  0001 C CNN
	1    7550 5550
	1    0    0    -1  
$EndComp
$Comp
L R R64
U 1 1 5C16FDF4
P 7400 5550
F 0 "R64" V 7480 5550 50  0000 C CNN
F 1 "10k" V 7400 5550 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 7330 5550 50  0001 C CNN
F 3 "" H 7400 5550 50  0001 C CNN
	1    7400 5550
	1    0    0    -1  
$EndComp
$Comp
L R R63
U 1 1 5C16FED1
P 7250 5550
F 0 "R63" V 7330 5550 50  0000 C CNN
F 1 "10k" V 7250 5550 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 7180 5550 50  0001 C CNN
F 3 "" H 7250 5550 50  0001 C CNN
	1    7250 5550
	1    0    0    -1  
$EndComp
$Comp
L R R62
U 1 1 5C16FF64
P 7100 5550
F 0 "R62" V 7180 5550 50  0000 C CNN
F 1 "10k" V 7100 5550 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 7030 5550 50  0001 C CNN
F 3 "" H 7100 5550 50  0001 C CNN
	1    7100 5550
	1    0    0    -1  
$EndComp
$Comp
L R R61
U 1 1 5C16FFF9
P 6950 5550
F 0 "R61" V 7030 5550 50  0000 C CNN
F 1 "10k" V 6950 5550 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 6880 5550 50  0001 C CNN
F 3 "" H 6950 5550 50  0001 C CNN
	1    6950 5550
	1    0    0    -1  
$EndComp
$Comp
L R R60
U 1 1 5C170094
P 6800 5550
F 0 "R60" V 6880 5550 50  0000 C CNN
F 1 "10k" V 6800 5550 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 6730 5550 50  0001 C CNN
F 3 "" H 6800 5550 50  0001 C CNN
	1    6800 5550
	1    0    0    -1  
$EndComp
$Comp
L R R59
U 1 1 5C170151
P 6650 5550
F 0 "R59" V 6730 5550 50  0000 C CNN
F 1 "10k" V 6650 5550 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 6580 5550 50  0001 C CNN
F 3 "" H 6650 5550 50  0001 C CNN
	1    6650 5550
	1    0    0    -1  
$EndComp
$Comp
L R R58
U 1 1 5C1703EE
P 6450 5550
F 0 "R58" V 6530 5550 50  0000 C CNN
F 1 "10k" V 6450 5550 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 6380 5550 50  0001 C CNN
F 3 "" H 6450 5550 50  0001 C CNN
	1    6450 5550
	1    0    0    -1  
$EndComp
$Comp
L R R57
U 1 1 5C1703F4
P 6300 5550
F 0 "R57" V 6380 5550 50  0000 C CNN
F 1 "10k" V 6300 5550 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 6230 5550 50  0001 C CNN
F 3 "" H 6300 5550 50  0001 C CNN
	1    6300 5550
	1    0    0    -1  
$EndComp
$Comp
L R R56
U 1 1 5C1703FA
P 6150 5550
F 0 "R56" V 6230 5550 50  0000 C CNN
F 1 "10k" V 6150 5550 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 6080 5550 50  0001 C CNN
F 3 "" H 6150 5550 50  0001 C CNN
	1    6150 5550
	1    0    0    -1  
$EndComp
$Comp
L R R55
U 1 1 5C170400
P 6000 5550
F 0 "R55" V 6080 5550 50  0000 C CNN
F 1 "10k" V 6000 5550 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 5930 5550 50  0001 C CNN
F 3 "" H 6000 5550 50  0001 C CNN
	1    6000 5550
	1    0    0    -1  
$EndComp
$Comp
L R R54
U 1 1 5C170406
P 5850 5550
F 0 "R54" V 5930 5550 50  0000 C CNN
F 1 "10k" V 5850 5550 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 5780 5550 50  0001 C CNN
F 3 "" H 5850 5550 50  0001 C CNN
	1    5850 5550
	1    0    0    -1  
$EndComp
$Comp
L R R53
U 1 1 5C17040C
P 5700 5550
F 0 "R53" V 5780 5550 50  0000 C CNN
F 1 "10k" V 5700 5550 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 5630 5550 50  0001 C CNN
F 3 "" H 5700 5550 50  0001 C CNN
	1    5700 5550
	1    0    0    -1  
$EndComp
$Comp
L R R52
U 1 1 5C170412
P 5550 5550
F 0 "R52" V 5630 5550 50  0000 C CNN
F 1 "10k" V 5550 5550 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 5480 5550 50  0001 C CNN
F 3 "" H 5550 5550 50  0001 C CNN
	1    5550 5550
	1    0    0    -1  
$EndComp
$Comp
L R R51
U 1 1 5C170418
P 5400 5550
F 0 "R51" V 5480 5550 50  0000 C CNN
F 1 "10k" V 5400 5550 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 5330 5550 50  0001 C CNN
F 3 "" H 5400 5550 50  0001 C CNN
	1    5400 5550
	1    0    0    -1  
$EndComp
Entry Wire Line
	3800 4900 3900 5000
Entry Wire Line
	3800 4800 3900 4900
Entry Wire Line
	3800 4700 3900 4800
Entry Wire Line
	3800 4100 3900 4200
Entry Wire Line
	3800 4500 3900 4600
Wire Wire Line
	2300 900  2300 1700
Wire Wire Line
	2300 1700 2200 1700
Wire Wire Line
	1150 1500 8500 1500
Wire Wire Line
	1150 1500 1150 1400
Connection ~ 2300 1500
Wire Wire Line
	1400 1400 1400 1500
Connection ~ 1400 1500
Wire Wire Line
	1650 1500 1650 1400
Connection ~ 1650 1500
Wire Wire Line
	1900 1400 1900 1500
Connection ~ 1900 1500
Wire Wire Line
	1900 1000 1900 1100
Wire Wire Line
	900  1000 1900 1000
Wire Wire Line
	900  1000 900  1500
Wire Wire Line
	1150 1100 1150 1000
Connection ~ 1150 1000
Wire Wire Line
	1400 1100 1400 1000
Connection ~ 1400 1000
Wire Wire Line
	1650 1100 1650 1000
Connection ~ 1650 1000
Wire Wire Line
	10200 1100 10300 1100
Wire Wire Line
	10300 1350 10200 1350
Wire Wire Line
	10200 1600 10300 1600
Wire Wire Line
	10300 1850 10200 1850
Wire Wire Line
	10200 2100 10300 2100
Wire Wire Line
	10300 2350 10200 2350
Wire Wire Line
	10200 2600 10300 2600
Wire Wire Line
	10300 2850 10200 2850
Wire Wire Line
	10600 1100 10800 1100
Wire Wire Line
	10800 1100 10800 5100
Wire Wire Line
	10800 2850 10600 2850
Wire Wire Line
	10600 2600 10800 2600
Connection ~ 10800 2600
Wire Wire Line
	10800 2350 10600 2350
Connection ~ 10800 2350
Wire Wire Line
	10600 2100 10800 2100
Connection ~ 10800 2100
Wire Wire Line
	10800 1850 10600 1850
Connection ~ 10800 1850
Wire Wire Line
	10600 1600 10800 1600
Connection ~ 10800 1600
Wire Wire Line
	10800 1350 10600 1350
Connection ~ 10800 1350
Wire Wire Line
	10200 3250 10300 3250
Wire Wire Line
	10300 3500 10200 3500
Wire Wire Line
	10200 3750 10300 3750
Wire Wire Line
	10300 4000 10200 4000
Wire Wire Line
	10200 4250 10300 4250
Wire Wire Line
	10300 4500 10200 4500
Wire Wire Line
	10200 4750 10300 4750
Wire Wire Line
	10300 5000 10200 5000
Wire Wire Line
	10800 3250 10600 3250
Wire Wire Line
	10800 5000 10600 5000
Wire Wire Line
	10600 4750 10800 4750
Connection ~ 10800 4750
Wire Wire Line
	10800 4500 10600 4500
Connection ~ 10800 4500
Wire Wire Line
	10600 4250 10800 4250
Connection ~ 10800 4250
Wire Wire Line
	10800 4000 10600 4000
Connection ~ 10800 4000
Wire Wire Line
	10600 3750 10800 3750
Connection ~ 10800 3750
Wire Wire Line
	10800 3500 10600 3500
Connection ~ 10800 3500
Connection ~ 10800 3250
Connection ~ 10800 2850
Connection ~ 10800 5000
Wire Wire Line
	9900 1850 9600 1850
Wire Wire Line
	9600 1850 9600 2100
Wire Wire Line
	9600 2100 2200 2100
Wire Wire Line
	9900 2100 9700 2100
Wire Wire Line
	9700 2100 9700 2200
Wire Wire Line
	9700 2200 2200 2200
Wire Wire Line
	9900 2350 9700 2350
Wire Wire Line
	9700 2350 9700 2300
Wire Wire Line
	9700 2300 2200 2300
Wire Wire Line
	9900 2600 9600 2600
Wire Wire Line
	9600 2600 9600 2400
Wire Wire Line
	9600 2400 2200 2400
Wire Wire Line
	9900 2850 9500 2850
Wire Wire Line
	9500 2850 9500 2500
Wire Wire Line
	9500 2500 2200 2500
Wire Wire Line
	9900 1600 9500 1600
Wire Wire Line
	9500 1600 9500 2000
Wire Wire Line
	9500 2000 2200 2000
Wire Wire Line
	9900 1350 9400 1350
Wire Wire Line
	9400 1350 9400 1900
Wire Wire Line
	9400 1900 2200 1900
Wire Wire Line
	9900 1100 9300 1100
Wire Wire Line
	9300 1100 9300 1800
Wire Wire Line
	9300 1800 2200 1800
Wire Wire Line
	9900 3250 9400 3250
Wire Wire Line
	9400 3250 9400 2600
Wire Wire Line
	9400 2600 2200 2600
Wire Wire Line
	9900 3500 9300 3500
Wire Wire Line
	9300 3500 9300 2700
Wire Wire Line
	9300 2700 2200 2700
Wire Wire Line
	9900 3750 9200 3750
Wire Wire Line
	9200 3750 9200 2800
Wire Wire Line
	9200 2800 2200 2800
Wire Wire Line
	9900 4000 9100 4000
Wire Wire Line
	9100 4000 9100 2900
Wire Wire Line
	9100 2900 2200 2900
Wire Wire Line
	9900 4250 9000 4250
Wire Wire Line
	9000 4250 9000 3000
Wire Wire Line
	9000 3000 2200 3000
Wire Wire Line
	9900 4500 8900 4500
Wire Wire Line
	8900 4500 8900 3100
Wire Wire Line
	8900 3100 2200 3100
Wire Wire Line
	9900 4750 8800 4750
Wire Wire Line
	8800 4750 8800 3200
Wire Wire Line
	8800 3200 2200 3200
Wire Wire Line
	9900 5000 8700 5000
Wire Wire Line
	8700 5000 8700 3300
Wire Wire Line
	8700 3300 2200 3300
Wire Wire Line
	8500 5300 8400 5300
Wire Wire Line
	8500 3500 8400 3500
Wire Wire Line
	8500 3600 8400 3600
Connection ~ 8500 3600
Wire Wire Line
	8500 3700 8400 3700
Connection ~ 8500 3700
Wire Wire Line
	8500 3800 8400 3800
Connection ~ 8500 3800
Wire Wire Line
	8500 3900 8400 3900
Connection ~ 8500 3900
Wire Wire Line
	8500 4000 8400 4000
Connection ~ 8500 4000
Wire Wire Line
	8500 4100 8400 4100
Connection ~ 8500 4100
Wire Wire Line
	8500 4200 8400 4200
Connection ~ 8500 4200
Wire Wire Line
	8500 4600 8400 4600
Connection ~ 8500 4600
Wire Wire Line
	8500 4700 8400 4700
Connection ~ 8500 4700
Wire Wire Line
	8500 4800 8400 4800
Connection ~ 8500 4800
Wire Wire Line
	8500 4900 8400 4900
Connection ~ 8500 4900
Wire Wire Line
	8500 5000 8400 5000
Connection ~ 8500 5000
Wire Wire Line
	8500 5100 8400 5100
Connection ~ 8500 5100
Wire Wire Line
	8500 5200 8400 5200
Connection ~ 8500 5200
Connection ~ 8500 3500
Wire Wire Line
	8500 1500 8500 6300
Wire Wire Line
	2200 6600 5300 6600
Wire Wire Line
	5300 6600 5300 5000
Wire Wire Line
	5300 5000 7800 5000
Wire Wire Line
	2200 6500 5200 6500
Wire Wire Line
	5200 6500 5200 4900
Wire Wire Line
	5200 4900 7800 4900
Wire Wire Line
	2200 6400 5100 6400
Wire Wire Line
	5100 6400 5100 4800
Wire Wire Line
	5100 4800 7800 4800
Wire Wire Line
	2200 6300 5000 6300
Wire Wire Line
	5000 6300 5000 4700
Wire Wire Line
	5000 4700 7800 4700
Wire Wire Line
	2200 6200 4900 6200
Wire Wire Line
	4900 6200 4900 4600
Wire Wire Line
	4900 4600 7800 4600
Wire Wire Line
	2200 6100 4800 6100
Wire Wire Line
	4800 6100 4800 4200
Wire Wire Line
	4800 4200 7800 4200
Wire Wire Line
	2200 6000 4700 6000
Wire Wire Line
	4700 6000 4700 4100
Wire Wire Line
	4700 4100 7800 4100
Wire Wire Line
	2200 5900 4600 5900
Wire Wire Line
	4600 5900 4600 4000
Wire Wire Line
	4600 4000 7800 4000
Wire Wire Line
	2200 5800 4500 5800
Wire Wire Line
	4500 5800 4500 3900
Wire Wire Line
	4500 3900 7800 3900
Wire Wire Line
	2200 5700 4400 5700
Wire Wire Line
	4400 5700 4400 3800
Wire Wire Line
	4400 3800 7800 3800
Wire Wire Line
	2200 5600 4300 5600
Wire Wire Line
	4300 5600 4300 3700
Wire Wire Line
	4300 3700 7800 3700
Wire Wire Line
	2200 4000 4200 4000
Wire Wire Line
	4200 4000 4200 5100
Wire Wire Line
	4200 5100 7800 5100
Wire Wire Line
	2200 3800 4100 3800
Wire Wire Line
	4100 3800 4100 3500
Wire Wire Line
	4100 3500 7800 3500
Wire Wire Line
	2200 3900 4200 3900
Wire Wire Line
	4200 3900 4200 3600
Wire Wire Line
	4200 3600 7800 3600
Wire Wire Line
	7700 5400 7700 3500
Connection ~ 7700 3500
Wire Wire Line
	7550 5400 7550 3600
Connection ~ 7550 3600
Wire Wire Line
	7400 5400 7400 3700
Connection ~ 7400 3700
Wire Wire Line
	7250 5400 7250 3800
Connection ~ 7250 3800
Wire Wire Line
	7100 3900 7100 5400
Connection ~ 7100 3900
Wire Wire Line
	6950 5400 6950 4000
Connection ~ 6950 4000
Wire Wire Line
	6800 5400 6800 4100
Connection ~ 6800 4100
Wire Wire Line
	6650 5400 6650 4200
Connection ~ 6650 4200
Wire Wire Line
	6450 5400 6450 4600
Connection ~ 6450 4600
Wire Wire Line
	6300 5400 6300 4700
Connection ~ 6300 4700
Wire Wire Line
	6150 5400 6150 4800
Connection ~ 6150 4800
Wire Wire Line
	6000 5400 6000 4900
Connection ~ 6000 4900
Wire Wire Line
	5850 5400 5850 5000
Connection ~ 5850 5000
Wire Wire Line
	5700 5400 5700 5100
Connection ~ 5700 5100
Wire Wire Line
	5550 1300 5550 5400
Connection ~ 5550 5200
Wire Wire Line
	5400 1300 5400 5400
Connection ~ 5400 5300
Wire Bus Line
	3900 1300 3900 7100
Wire Wire Line
	3800 4100 2200 4100
Wire Wire Line
	2200 4500 3800 4500
Wire Wire Line
	2200 4700 3800 4700
Wire Wire Line
	3800 4800 2200 4800
Wire Wire Line
	2200 4900 3800 4900
Wire Wire Line
	2200 3400 3700 3400
Wire Wire Line
	3700 3400 3700 6700
Wire Wire Line
	3700 6700 5900 6700
Wire Wire Line
	2200 3500 3600 3500
Wire Wire Line
	3600 3500 3600 6800
Wire Wire Line
	3600 6800 6000 6800
Wire Wire Line
	2200 3600 3500 3600
Wire Wire Line
	3500 3600 3500 6900
Wire Wire Line
	3500 6900 6100 6900
Wire Wire Line
	2200 3700 3400 3700
Wire Wire Line
	3400 3700 3400 7000
Wire Wire Line
	3400 7000 6000 7000
Wire Wire Line
	2200 4300 3300 4300
Wire Wire Line
	3300 4300 3300 1300
Wire Bus Line
	3200 1300 3200 7100
Wire Wire Line
	3100 5000 2200 5000
Wire Wire Line
	3100 5100 2200 5100
Wire Wire Line
	3100 5200 2200 5200
Wire Wire Line
	2200 5300 3000 5300
Wire Wire Line
	3000 5300 3000 6700
Wire Wire Line
	3000 6700 3100 6700
Entry Wire Line
	3100 5000 3200 5100
Entry Wire Line
	3100 5100 3200 5200
Entry Wire Line
	3100 5200 3200 5300
Entry Wire Line
	3100 6700 3200 6800
Text Label 2250 5000 0    60   ~ 0
SD0
Text Label 2250 5100 0    60   ~ 0
SD1
Text Label 2250 5200 0    60   ~ 0
SD2
Text Label 2250 5300 0    60   ~ 0
SD3
Text Label 2250 4900 0    60   ~ 0
GPIO_B3
Text Label 2250 4800 0    60   ~ 0
GPIO_B2
Text Label 2250 4700 0    60   ~ 0
GPIO_B5
Text Label 2250 4500 0    60   ~ 0
GPIO_B1
Text Label 2250 4100 0    60   ~ 0
GPIO_B4
Text Notes 2250 4300 0    60   ~ 0
Clock 12MHz
$Comp
L SW_Push SW0
U 1 1 5C191B37
P 6300 6300
F 0 "SW0" H 6350 6400 50  0000 L CNN
F 1 "SW_Push" H 6300 6240 50  0000 C CNN
F 2 "Buttons_Switches_SMD:SW_SPST_B3U-1000P-B" H 6300 6500 50  0001 C CNN
F 3 "" H 6300 6500 50  0001 C CNN
	1    6300 6300
	1    0    0    -1  
$EndComp
$Comp
L SW_Push SW1
U 1 1 5C1920BC
P 6300 6600
F 0 "SW1" H 6350 6700 50  0000 L CNN
F 1 "SW_Push" H 6300 6540 50  0000 C CNN
F 2 "Buttons_Switches_SMD:SW_SPST_B3U-1000P-B" H 6300 6800 50  0001 C CNN
F 3 "" H 6300 6800 50  0001 C CNN
	1    6300 6600
	1    0    0    -1  
$EndComp
$Comp
L SW_Push SW2
U 1 1 5C192153
P 6300 6900
F 0 "SW2" H 6350 7000 50  0000 L CNN
F 1 "SW_Push" H 6300 6840 50  0000 C CNN
F 2 "Buttons_Switches_SMD:SW_SPST_B3U-1000P-B" H 6300 7100 50  0001 C CNN
F 3 "" H 6300 7100 50  0001 C CNN
	1    6300 6900
	1    0    0    -1  
$EndComp
$Comp
L SW_Push SW3
U 1 1 5C1921F2
P 6300 7200
F 0 "SW3" H 6350 7300 50  0000 L CNN
F 1 "SW_Push" H 6300 7140 50  0000 C CNN
F 2 "Buttons_Switches_SMD:SW_SPST_B3U-1000P-B" H 6300 7400 50  0001 C CNN
F 3 "" H 6300 7400 50  0001 C CNN
	1    6300 7200
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 6300 6500 6300
Wire Wire Line
	6600 6300 6600 7200
Wire Wire Line
	6600 7200 6500 7200
Connection ~ 8500 5300
Wire Wire Line
	6500 6900 6600 6900
Connection ~ 6600 6900
Wire Wire Line
	6500 6600 6600 6600
Connection ~ 6600 6600
Connection ~ 6600 6300
Wire Wire Line
	6000 7000 6000 7200
Wire Wire Line
	6000 7200 6100 7200
Wire Wire Line
	6000 6800 6000 6600
Wire Wire Line
	6000 6600 6100 6600
Wire Wire Line
	5900 6700 5900 6300
Wire Wire Line
	5900 6300 6100 6300
Wire Wire Line
	5400 7500 5400 5700
Wire Wire Line
	5400 5800 7700 5800
Wire Wire Line
	7700 5700 7700 5900
Wire Wire Line
	7550 5700 7550 5800
Connection ~ 7550 5800
Wire Wire Line
	7400 5700 7400 5800
Connection ~ 7400 5800
Wire Wire Line
	7250 5700 7250 5800
Connection ~ 7250 5800
Wire Wire Line
	7100 5700 7100 5800
Connection ~ 7100 5800
Wire Wire Line
	6950 5700 6950 5800
Connection ~ 6950 5800
Wire Wire Line
	6800 5700 6800 5800
Connection ~ 6800 5800
Wire Wire Line
	6650 5700 6650 5800
Connection ~ 6650 5800
Wire Wire Line
	6450 5700 6450 5800
Connection ~ 6450 5800
Wire Wire Line
	6300 5700 6300 5800
Connection ~ 6300 5800
Wire Wire Line
	6150 5700 6150 5800
Connection ~ 6150 5800
Wire Wire Line
	6000 5700 6000 5800
Connection ~ 6000 5800
Wire Wire Line
	5850 5700 5850 5800
Connection ~ 5850 5800
Wire Wire Line
	5700 5700 5700 5800
Connection ~ 5700 5800
Wire Wire Line
	5550 5700 5550 5800
Connection ~ 5550 5800
$Comp
L R R50
U 1 1 5C194D21
P 5200 7250
F 0 "R50" V 5280 7250 50  0000 C CNN
F 1 "10k" V 5200 7250 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 5130 7250 50  0001 C CNN
F 3 "" H 5200 7250 50  0001 C CNN
	1    5200 7250
	1    0    0    -1  
$EndComp
$Comp
L R R49
U 1 1 5C194E00
P 5050 7250
F 0 "R49" V 5130 7250 50  0000 C CNN
F 1 "10k" V 5050 7250 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 4980 7250 50  0001 C CNN
F 3 "" H 5050 7250 50  0001 C CNN
	1    5050 7250
	1    0    0    -1  
$EndComp
$Comp
L R R48
U 1 1 5C194ED5
P 4900 7250
F 0 "R48" V 4980 7250 50  0000 C CNN
F 1 "10k" V 4900 7250 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 4830 7250 50  0001 C CNN
F 3 "" H 4900 7250 50  0001 C CNN
	1    4900 7250
	1    0    0    -1  
$EndComp
$Comp
L R R47
U 1 1 5C194FAE
P 4750 7250
F 0 "R47" V 4830 7250 50  0000 C CNN
F 1 "10k" V 4750 7250 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 4680 7250 50  0001 C CNN
F 3 "" H 4750 7250 50  0001 C CNN
	1    4750 7250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4750 7100 4750 7000
Connection ~ 4750 7000
Wire Wire Line
	4900 7100 4900 6900
Connection ~ 4900 6900
Wire Wire Line
	5050 7100 5050 6800
Connection ~ 5050 6800
Wire Wire Line
	5200 7100 5200 6700
Connection ~ 5200 6700
Wire Wire Line
	4750 7400 4750 7500
Wire Wire Line
	4750 7500 5400 7500
Wire Wire Line
	5200 7500 5200 7400
Wire Wire Line
	5050 7400 5050 7500
Connection ~ 5050 7500
Wire Wire Line
	4900 7400 4900 7500
Connection ~ 4900 7500
Connection ~ 5200 7500
Connection ~ 5400 5800
Wire Wire Line
	5400 5300 7800 5300
Wire Wire Line
	7800 5200 5550 5200
$Comp
L GND #PWR077
U 1 1 5C1A3670
P 7700 5900
F 0 "#PWR077" H 7700 5650 50  0001 C CNN
F 1 "GND" H 7700 5750 50  0000 C CNN
F 2 "" H 7700 5900 50  0001 C CNN
F 3 "" H 7700 5900 50  0001 C CNN
	1    7700 5900
	1    0    0    -1  
$EndComp
Connection ~ 7700 5800
Text HLabel 5550 1300 1    60   Output ~ 0
CBSEL0
Text HLabel 5400 1300 1    60   Output ~ 0
CBSEL1
Text HLabel 3900 1300 1    60   3State ~ 0
GPIO_B[1..5]
Text HLabel 3300 1300 1    60   Input ~ 0
CLOCK
Text HLabel 3200 1300 1    60   BiDi ~ 0
SDCARD_D[0..3]
Wire Wire Line
	2200 6900 2300 6900
Wire Wire Line
	2300 6900 2300 7100
Wire Wire Line
	2200 6800 2400 6800
Wire Wire Line
	2400 6800 2400 7100
Wire Wire Line
	2200 6700 2500 6700
Wire Wire Line
	2500 6700 2500 7100
Text HLabel 2300 7100 3    60   Output ~ 0
PWM_R
Text HLabel 2400 7100 3    60   Output ~ 0
PWM_L
Text HLabel 2500 7100 3    60   Output ~ 0
PWM_M
Wire Wire Line
	2200 4200 3000 4200
Wire Wire Line
	3000 4200 3000 1300
Wire Wire Line
	2200 4600 3100 4600
Wire Wire Line
	3100 4600 3100 1300
Wire Wire Line
	2200 4400 2900 4400
Wire Wire Line
	2900 4400 2900 7100
Wire Wire Line
	2800 7100 2800 5400
Wire Wire Line
	2800 5400 2200 5400
Wire Wire Line
	2700 7100 2700 5500
Wire Wire Line
	2700 5500 2200 5500
Text HLabel 3100 1300 1    60   Output ~ 0
GPIO_B_DIR
Text HLabel 3000 1300 1    60   Output ~ 0
GPIO_B_~OE
Text Notes 2250 4200 0    60   ~ 0
~OE
Text Notes 2250 4600 0    60   ~ 0
DIR
Text Notes 2250 4400 0    60   ~ 0
SCX
Text Notes 2250 5400 0    60   ~ 0
SIN
Text Notes 2250 5500 0    60   ~ 0
SOUT
Text HLabel 2900 7100 3    60   BiDi ~ 0
SCX
Text HLabel 2800 7100 3    60   Input ~ 0
SIN
Text HLabel 2700 7100 3    60   Output ~ 0
SOUT
Text Label 3200 7100 1    60   ~ 0
SD[0..3]
Text Label 3900 5550 1    60   ~ 0
GPIO_B[1..5]
Text Label 2250 1800 0    60   ~ 0
LED0
Text Label 2250 1900 0    60   ~ 0
LED1
Text Label 2250 2000 0    60   ~ 0
LED2
Text Label 2250 2100 0    60   ~ 0
LED3
Text Label 2250 2200 0    60   ~ 0
LED4
Text Label 2250 2300 0    60   ~ 0
LED5
Text Label 2250 2400 0    60   ~ 0
LED6
Text Label 2250 2500 0    60   ~ 0
LED7
Text Label 2250 2600 0    60   ~ 0
LED8
Text Label 2250 2700 0    60   ~ 0
LED9
Text Label 2250 2800 0    60   ~ 0
LED10
Text Label 2250 2900 0    60   ~ 0
LED11
Text Label 2250 3000 0    60   ~ 0
LED12
Text Label 2250 3100 0    60   ~ 0
LED13
Text Label 2250 3200 0    60   ~ 0
LED14
Text Label 2250 3300 0    60   ~ 0
LED15
Text Label 2250 3400 0    60   ~ 0
SW0
Text Label 2250 3500 0    60   ~ 0
SW1
Text Label 2250 3600 0    60   ~ 0
SW2
Text Label 2250 3700 0    60   ~ 0
SW3
Text Label 2250 3800 0    60   ~ 0
DipSW0
Text Label 2250 3900 0    60   ~ 0
DipSW1
Text Label 2250 4000 0    60   ~ 0
DipSW13
Text Label 2250 5600 0    60   ~ 0
DipSW2
Text Label 2250 5700 0    60   ~ 0
DipSW3
Text Label 2250 5800 0    60   ~ 0
DipSW4
Text Label 2250 5900 0    60   ~ 0
DipSW5
Text Label 2250 6000 0    60   ~ 0
DipSW6
Text Label 2250 6100 0    60   ~ 0
DipSW7
Text Label 2250 6200 0    60   ~ 0
DipSW8
Text Label 2250 6300 0    60   ~ 0
DipSW9
Text Label 2250 6400 0    60   ~ 0
DipSW10
Text Label 2250 6500 0    60   ~ 0
DipSW11
Text Label 2250 6600 0    60   ~ 0
DipSW12
$EndSCHEMATC
