; Fits into 128 bytes. Used together with the genclk Verilog code to
; determine the exact number of clock ticks the GameBoy needs after a
; reset until it reaches the first instruction of the cartridge (0x100).

.section .entry
	nop
loop:
	jp loop

.section .hdrlogo
	.db 0xCE, 0xED, 0x66, 0x66, 0xCC, 0x0D, 0x00, 0x0B, 0x03, 0x73, 0x00, 0x83, 0x00, 0x0C, 0x00, 0x0D
	.db 0x00, 0x08, 0x11, 0x1F, 0x88, 0x89, 0x00, 0x0E, 0xDC, 0xCC, 0x6E, 0xE6, 0xDD, 0xDD, 0xD9, 0x99
	.db 0xBB, 0xBB, 0x67, 0x63, 0x6E, 0x0E, 0xEC, 0xCC, 0xDD, 0xDC, 0x99, 0x9F, 0xBB, 0xB9, 0x33, 0x3E
.section .hdrname
	.db "genclk"
.section .hdrgc
	.db "TEST"
.section .hdrcgb
	.db 0x00
.section .hdrmc
	.db "ZZ"
.section .hdrsgb
	.db 0x00
.section .hdrtype
	.db 0x00
.section .hdrrom
	.db 0x00
.section .hdrram
	.db 0x00
.section .hdrdest
	.db 0x01
.section .hdrver
	.db 0x00