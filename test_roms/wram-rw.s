; Code runs in HRAM
; Loops:
;  * Set {P15,P14} = b10
;  * Read 4 bytes (0xa0, 0xa1, 0xa2, 0xa3) from WRAM (0xc000)
;  * Set {P15,P14} = b01
;  * Write 4 bytes (0xc0, 0xc1, 0xc2, 0xc3) to WRAM (0xc004)

.section .hdrname
	.db "wram-rw"

.section .data
rw:
	db 0xa0, 0xa1, 0xa2, 0xa3
	db 0xb4, 0xb5, 0xb6, 0xb7

.section .hdata
main:
.global main
	ld a, 0xef
	ldh (0x00), a

	ld hl, rw

	ldi a, (hl)
	nop
	ldi a, (hl)
	nop
	ldi a, (hl)
	nop
	ldi a, (hl)

	nop
	nop
	nop

	ld a, 0xdf
	ldh (0x00), a

	ld a, 0xc0
	nop

	ldi (hl), a
	inc a
	ldi (hl), a
	inc a
	ldi (hl), a
	inc a
	ldi (hl), a

	jr main
