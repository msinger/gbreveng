.section .hdrname
	.db "eidi"

.section .text
main:
.global main
	di
;	ei
	xor a
	ld (0x0f), a
	ld a, 0x08
	ld (0xff), a
	ld a, 0x80
	ld (0x02), a
	nop
	nop
	ei
;	di
	nop
	nop
	jr main

