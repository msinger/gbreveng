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
Sheet 1 11
Title "Game Boy reverse eng. FPGA board"
Date "2019-01-20"
Rev "0"
Comp "Author: Michael Singer"
Comment1 "https://sourceforge.net/projects/iceboy/"
Comment2 "http://iceboy.a-singer.de/"
Comment3 ""
Comment4 ""
$EndDescr
$Sheet
S 1100 700  1700 1400
U 5C059AF6
F0 "Power, USB, SPI" 60
F1 "power.sch" 60
F2 "CLOCK" O R 2800 2000 60 
F3 "CDONE" I R 2800 1800 60 
F4 "~CRESET" O R 2800 1600 60 
F5 "USB_~PWR" O R 2800 1200 60 
F6 "USB_~SUSP" O R 2800 1400 60 
F7 "DBUS[0..7]" B R 2800 800 60 
F8 "CBUS[0..4]" B R 2800 1000 60 
$EndSheet
$Sheet
S 4600 700  1700 1000
U 5C06CD2F
F0 "Bank0: Display, Keyboard, Clock" 60
F1 "bank0.sch" 60
F2 "DBUS[0..7]" B L 4600 800 60 
F3 "USB_~PWR" I L 4600 1200 60 
F4 "USB_~SUSP" I L 4600 1400 60 
F5 "SPEAKER" I R 6300 1600 60 
F6 "CBUS[0..4]" B L 4600 1000 60 
F7 "CART_SL_A[0..15]" I R 6300 800 60 
F8 "CART_SL_CLK" I R 6300 1400 60 
F9 "CART_SL_~WR" I R 6300 1200 60 
F10 "CART_SL_~RD" I R 6300 1000 60 
F11 "P14" O L 4600 1600 60 
$EndSheet
$Sheet
S 4600 1900 1700 1400
U 5C16EBFA
F0 "Bank1: GPIOA" 60
F1 "bank1.sch" 60
F2 "SDCARD_SW" I R 6300 3200 60 
F3 "GPIO_B6" T L 4600 3000 60 
F4 "GPIO_B7" T L 4600 3200 60 
F5 "VRAM_A[0..13]" O L 4600 2000 60 
F6 "VRAM_D[0..7]" T L 4600 2200 60 
F7 "VRAM_~CS" O L 4600 2400 60 
F8 "VRAM_~WR" O L 4600 2800 60 
F9 "VRAM_~RD" O L 4600 2600 60 
F10 "CART_SL_D[0..7]" T R 6300 2200 60 
F11 "CART_SL_~RST" B R 6300 2000 60 
F12 "CART_SL_~CS" I R 6300 2400 60 
F13 "CART_SL_~OE" O R 6300 2600 60 
F14 "CART_SL_DIR" O R 6300 2800 60 
$EndSheet
$Sheet
S 4600 5100 1700 2400
U 5C1579CB
F0 "Bank2: SDCard" 60
F1 "bank2.sch" 60
F2 "~CRESET" I L 4600 5200 60 
F3 "CDONE" O L 4600 5400 60 
F4 "CBSEL0" I R 6300 7200 60 
F5 "CBSEL1" I R 6300 7400 60 
F6 "SDCARD_SW" O R 6300 6800 60 
F7 "SDCARD_D[0..3]" B R 6300 6600 60 
F8 "CART_MA_A[0..15]" O L 4600 5600 60 
F9 "ONBRD_A[15..20]" O R 6300 5400 60 
F10 "WRAM_~CS" O R 6300 5800 60 
F11 "XRAM_~CS" O R 6300 6000 60 
F12 "ROM_~CS" O R 6300 6200 60 
F13 "CART_MA_DIR" O L 4600 7400 60 
F14 "CART_MA_~CS" O L 4600 6000 60 
F15 "CART_MA_~OE" O L 4600 7000 60 
F16 "CART_MA_CLK" O L 4600 6600 60 
F17 "CART_MA_~WR" O L 4600 6400 60 
F18 "CART_MA_~RD" O L 4600 6200 60 
F19 "CART_MA_~OE~_DATA" O L 4600 7200 60 
F20 "CART_MA_~RST" B L 4600 6800 60 
F21 "CART_MA_D[0..7]" T L 4600 5800 60 
F22 "ONBRD_~PROG" O R 6300 5600 60 
$EndSheet
$Sheet
S 4600 3500 1700 1400
U 5C15AE59
F0 "Bank3: LEDs, Switches" 60
F1 "bank3.sch" 60
F2 "CBSEL0" O R 6300 3800 60 
F3 "CBSEL1" O R 6300 4000 60 
F4 "CLOCK" I L 4600 3600 60 
F5 "GPIO_B[1..5]" T L 4600 3800 60 
F6 "SDCARD_D[0..3]" B R 6300 4200 60 
F7 "PWM_R" O R 6300 4800 60 
F8 "PWM_L" O R 6300 4600 60 
F9 "PWM_M" O R 6300 4400 60 
F10 "GPIO_B_DIR" O L 4600 4200 60 
F11 "GPIO_B_~OE" O L 4600 4000 60 
F12 "SCX" B L 4600 4400 60 
F13 "SIN" I R 6300 3600 60 
F14 "SOUT" O L 4600 4800 60 
$EndSheet
$Sheet
S 1100 5100 1700 2400
U 5C1815A3
F0 "Cartridge Master Slot" 60
F1 "cart_ma.sch" 60
F2 "D[0..7]" T R 2800 5800 60 
F3 "DIR" I R 2800 7400 60 
F4 "~OE~_DATA" I R 2800 7200 60 
F5 "~RST" B R 2800 6800 60 
F6 "~OE" I R 2800 7000 60 
F7 "~RD" I R 2800 6200 60 
F8 "~WR" I R 2800 6400 60 
F9 "CLK" I R 2800 6600 60 
F10 "SOUT" I R 2800 5400 60 
F11 "~CS" I R 2800 6000 60 
F12 "A[0..15]" I R 2800 5600 60 
F13 "P14" I R 2800 5200 60 
F14 "P14_5V" O L 1100 5200 60 
F15 "SOUT_5V" O L 1100 5400 60 
$EndSheet
Wire Bus Line
	2800 800  4600 800 
Wire Bus Line
	2800 1000 4600 1000
Wire Wire Line
	2800 1200 4600 1200
Wire Wire Line
	4600 1400 2800 1400
Wire Wire Line
	2800 2000 3600 2000
Wire Wire Line
	3400 5200 4600 5200
Wire Bus Line
	2800 3800 4600 3800
Wire Wire Line
	4600 3200 4400 3200
Wire Wire Line
	4400 3200 4400 3700
Wire Wire Line
	4200 3000 4200 3700
Wire Wire Line
	4200 3000 4600 3000
Text Label 4200 3550 1    60   ~ 0
GPIO_B6
Text Label 4400 3550 1    60   ~ 0
GPIO_B7
Wire Wire Line
	2800 6000 4600 6000
Wire Wire Line
	2800 6200 4600 6200
Wire Wire Line
	2800 6400 4600 6400
Wire Wire Line
	2800 6600 4600 6600
Wire Wire Line
	2800 6800 4600 6800
Wire Wire Line
	2800 7000 4600 7000
Wire Wire Line
	2800 7200 4600 7200
Wire Wire Line
	2800 7400 4600 7400
Wire Bus Line
	2800 5800 4600 5800
Wire Bus Line
	2800 5600 4600 5600
Wire Wire Line
	2800 4000 4600 4000
Wire Wire Line
	2800 4200 4600 4200
Wire Wire Line
	2800 4400 4600 4400
Wire Wire Line
	3800 2400 4600 2400
Wire Wire Line
	3800 2600 4600 2600
Wire Wire Line
	3800 2800 4600 2800
Wire Bus Line
	3800 2000 4600 2000
Wire Bus Line
	3800 2200 4600 2200
Text Label 3800 2200 0    60   ~ 0
VD[0..7]
Text Label 3800 2000 0    60   ~ 0
VA[0..13]
Text Label 3800 2400 0    60   ~ 0
~VCS
Text Label 3800 2600 0    60   ~ 0
~VRD
Text Label 3800 2800 0    60   ~ 0
~VWR
Text Label 3800 5600 0    60   ~ 0
MA[0..15]
Text Label 3800 5800 0    60   ~ 0
MD[0..7]
Text Label 3800 6200 0    60   ~ 0
~MRD
Text Label 3800 6400 0    60   ~ 0
~MWR
Wire Wire Line
	3300 5400 4600 5400
Wire Wire Line
	3500 1600 4600 1600
Wire Wire Line
	2800 4800 4600 4800
$Sheet
S 8700 700  1700 2200
U 5C26500C
F0 "Cartridge Slave Slot" 60
F1 "cart_sl.sch" 60
F2 "D[0..7]" T L 8700 2200 60 
F3 "DIR" I L 8700 2800 60 
F4 "~OE" I L 8700 2600 60 
F5 "~RST" B L 8700 2000 60 
F6 "~RD" O L 8700 1000 60 
F7 "~WR" O L 8700 1200 60 
F8 "CLK" O L 8700 1400 60 
F9 "~CS" O L 8700 2400 60 
F10 "A[0..15]" O L 8700 800 60 
F11 "SIN" O L 8700 1800 60 
F12 "SIN_5V" I L 8700 1600 60 
$EndSheet
Wire Bus Line
	6300 800  8700 800 
Wire Bus Line
	6300 2200 8700 2200
Wire Wire Line
	6300 1000 8700 1000
Wire Wire Line
	6300 1200 8700 1200
Wire Wire Line
	6300 1400 8700 1400
Wire Wire Line
	6300 2000 8700 2000
Wire Wire Line
	6300 2400 8700 2400
Wire Wire Line
	6300 2600 8700 2600
Wire Wire Line
	8700 2800 6300 2800
Wire Wire Line
	8700 1800 6600 1800
Wire Wire Line
	6600 1800 6600 3600
Wire Wire Line
	6600 3600 6300 3600
$Sheet
S 1100 3500 1700 1400
U 5C2ACC50
F0 "External Link Port, GPIOB" 60
F1 "sio.sch" 60
F2 "SOUT_5V" I L 1100 4600 60 
F3 "P14_5V" I L 1100 4800 60 
F4 "SIN_5V" O L 1100 3600 60 
F5 "B[1..7]" B R 2800 3800 60 
F6 "SCX" B R 2800 4400 60 
F7 "DIR" I R 2800 4200 60 
F8 "~OE" I R 2800 4000 60 
F9 "SOUT" I R 2800 4800 60 
F10 "SIN" I L 1100 3800 60 
F11 "P14" I R 2800 3600 60 
$EndSheet
Wire Wire Line
	1100 4800 1000 4800
Wire Wire Line
	1000 4800 1000 5200
Wire Wire Line
	1000 5200 1100 5200
Wire Wire Line
	1100 5400 900  5400
Wire Wire Line
	900  5400 900  4600
Wire Wire Line
	900  4600 1100 4600
Wire Wire Line
	2900 4800 2900 5400
Wire Wire Line
	2900 5400 2800 5400
Connection ~ 2900 4800
Wire Wire Line
	3000 3600 3000 5200
Wire Wire Line
	3000 5200 2800 5200
Connection ~ 3000 3600
Wire Wire Line
	2800 1800 3300 1800
Wire Wire Line
	3300 1800 3300 5400
Wire Wire Line
	2800 1600 3400 1600
Wire Wire Line
	3400 1600 3400 5200
Wire Wire Line
	2800 3600 3500 3600
Wire Wire Line
	3500 3600 3500 1600
Wire Wire Line
	3600 2000 3600 3600
Wire Wire Line
	3600 3600 4600 3600
Entry Wire Line
	4100 3800 4200 3700
Entry Wire Line
	4300 3800 4400 3700
Wire Wire Line
	8000 1600 8700 1600
Text Label 8000 1600 0    60   ~ 0
SIN_5V
Text Label 8000 1800 0    60   ~ 0
SIN
Wire Wire Line
	1100 3600 700  3600
Wire Wire Line
	700  3800 1100 3800
Text Label 700  3800 0    60   ~ 0
SIN
Text Label 700  3600 0    60   ~ 0
SIN_5V
$Sheet
S 8700 4500 1700 1800
U 5C2795CB
F0 "Memory" 60
F1 "memory.sch" 60
F2 "VD[0..7]" T R 10400 4800 60 
F3 "~VRD" I R 10400 5200 60 
F4 "~VWR" I R 10400 5400 60 
F5 "~VCS" I R 10400 5000 60 
F6 "VA[0..13]" I R 10400 4600 60 
F7 "WRAM_~CS" I L 8700 5800 60 
F8 "XRAM_~CS" I L 8700 6000 60 
F9 "~MRD" I L 8700 5200 60 
F10 "~MWR" I L 8700 5400 60 
F11 "~PROG" I L 8700 5600 60 
F12 "ROM_~CS" I L 8700 6200 60 
F13 "MA[0..20]" I L 8700 4600 60 
F14 "MD[0..7]" T L 8700 4800 60 
$EndSheet
Text Label 3500 3800 0    60   ~ 0
GPIO_B[1..7]
Wire Wire Line
	11000 5000 10400 5000
Wire Wire Line
	11000 5200 10400 5200
Wire Wire Line
	11000 5400 10400 5400
Wire Bus Line
	11000 4600 10400 4600
Wire Bus Line
	11000 4800 10400 4800
Text Label 11000 4600 2    60   ~ 0
VA[0..13]
Text Label 11000 4800 2    60   ~ 0
VD[0..7]
Text Label 11000 5000 2    60   ~ 0
~VCS
Text Label 11000 5200 2    60   ~ 0
~VRD
Text Label 11000 5400 2    60   ~ 0
~VWR
Text Label 8000 4800 0    60   ~ 0
MD[0..7]
Wire Wire Line
	8000 5200 8700 5200
Wire Wire Line
	8000 5400 8700 5400
Wire Wire Line
	6300 5600 8700 5600
Wire Wire Line
	6300 5800 8700 5800
Wire Wire Line
	6300 6000 8700 6000
Wire Wire Line
	6300 6200 8700 6200
Wire Wire Line
	6300 7200 6600 7200
Wire Wire Line
	6600 7200 6600 3800
Wire Wire Line
	6600 3800 6300 3800
Wire Wire Line
	6300 7400 6700 7400
Wire Wire Line
	6700 7400 6700 4000
Wire Wire Line
	6700 4000 6300 4000
Wire Wire Line
	6300 6800 6500 6800
Wire Wire Line
	6500 6800 6500 3200
Wire Wire Line
	6500 3200 6300 3200
Wire Bus Line
	6300 6600 6400 6600
Wire Bus Line
	6400 6600 6400 4200
Wire Bus Line
	6400 4200 6300 4200
Text Label 7200 4600 0    60   ~ 0
MA[0..14]
Text Label 8000 5200 0    60   ~ 0
~MRD
Text Label 8000 5400 0    60   ~ 0
~MWR
Wire Bus Line
	6300 5400 7700 5400
Wire Bus Line
	8000 4800 8700 4800
$Sheet
S 8700 3100 1700 1200
U 5C3829F9
F0 "Audio" 60
F1 "audio.sch" 60
F2 "SPEAKER" O L 8700 3200 60 
F3 "PWM_M" I L 8700 3800 60 
F4 "PWM_L" I L 8700 4000 60 
F5 "PWM_R" I L 8700 4200 60 
$EndSheet
Wire Wire Line
	6300 4400 6800 4400
Wire Wire Line
	6800 4400 6800 3800
Wire Wire Line
	6800 3800 8700 3800
Wire Wire Line
	8700 4000 6900 4000
Wire Wire Line
	6900 4000 6900 4600
Wire Wire Line
	6900 4600 6300 4600
Wire Wire Line
	6300 4800 7000 4800
Wire Wire Line
	7000 4800 7000 4200
Wire Wire Line
	7000 4200 8700 4200
Wire Bus Line
	7700 5400 7700 4600
Wire Bus Line
	7200 4600 8700 4600
Connection ~ 7700 4600
Wire Wire Line
	6300 1600 6700 1600
Wire Wire Line
	6700 1600 6700 3200
Wire Wire Line
	6700 3200 8700 3200
$EndSCHEMATC