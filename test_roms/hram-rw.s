; Code runs in HRAM
; Loops:
;  * Set {P15,P14} = b10
;  * Read 4 bytes (0xa0, 0xa1, 0xa2, 0xa3) from HRAM (0xff80)
;  * Set {P15,P14} = b01
;  * Write 4 bytes (0xc0, 0xc1, 0xc2, 0xc3) to HRAM (0xff84)

.section .hdrname
	.db "hram-rw"

.section .hdata
read:
	db 0xa0, 0xa1, 0xa2, 0xa3
write:
	db 0xb4, 0xb5, 0xb6, 0xb7

main:
.global main

	ld a, 0xef
	ld (0x00), a

	nop
	nop

	ld a, (read + 0)
	nop
	ld a, (read + 1)
	nop
	ld a, (read + 2)
	nop
	ld a, (read + 3)

	nop
	nop
	nop

	ld a, 0xdf
	ld (0x00), a

	ld a, 0xc0

	ld (write + 0), a
	inc a
	ld (write + 1), a
	inc a
	ld (write + 2), a
	inc a
	ld (write + 3), a

	jr main
