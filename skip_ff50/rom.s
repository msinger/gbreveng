; Fits into 512 bytes. Used together with the skip_ff50 Verilog code to
; read out the boot ROM.

.section .entry
	nop
	jp _start

.section .hdrlogo
	.db 0xCE, 0xED, 0x66, 0x66, 0xCC, 0x0D, 0x00, 0x0B, 0x03, 0x73, 0x00, 0x83, 0x00, 0x0C, 0x00, 0x0D
	.db 0x00, 0x08, 0x11, 0x1F, 0x88, 0x89, 0x00, 0x0E, 0xDC, 0xCC, 0x6E, 0xE6, 0xDD, 0xDD, 0xD9, 0x99
	.db 0xBB, 0xBB, 0x67, 0x63, 0x6E, 0x0E, 0xEC, 0xCC, 0xDD, 0xDC, 0x99, 0x9F, 0xBB, 0xB9, 0x33, 0x3E
.section .hdrname
	.db "skip_ff50"
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

.text
_start:
.global _start
	di
	xor a
	ldh (0xff), a

	ld a, 0xff
	ldh (0x00), a

	ld sp, _initial_sp

	ld bc, ldhram
	ld de, ldhram_end - ldhram
	ld hl, _hdata
	call memcpy

	ld bc, 0x0000
	ld hl, 0x01ff
	jp _hdata

ldhram:
	ld a, (bc)
	ld (hl), a
	jr ldhram
ldhram_end:

memcpy:
.global memcpy
	ld a, d
	or e
	ret z
	ld a, (bc)
	ldi (hl), a
	inc bc
	dec de
	jr memcpy