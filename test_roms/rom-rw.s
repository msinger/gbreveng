; Code runs in HRAM
; Loops:
;  * Set {P15,P14} = b10
;  * Read 4 bytes (0xc9, 0xa1, 0xa2, 0xa3) from ROM (0x0000)
;  * Set {P15,P14} = b01
;  * Write 4 bytes (0xc0, 0xc1, 0xc2, 0xc3) to ROM (0x0004)

.section .hdrname
	.db "rom-rw"

.section .rst00
rw:
	db       0xa1, 0xa2, 0xa3
	db 0xb4, 0xb5, 0xb6, 0xb7

.section .hdata
main:
.global main
	ld a, 0xef
	ld (0x00), a

	ld hl, rw - 1

	ld a, (hli)
	nop
	ld a, (hli)
	nop
	ld a, (hli)
	nop
	ld a, (hli)

	nop
	nop
	nop

	ld a, 0xdf
	ld (0x00), a

	ld a, 0xc0
	nop

	ld (hli), a
	inc a
	ld (hli), a
	inc a
	ld (hli), a
	inc a
	ld (hli), a

	jr main
