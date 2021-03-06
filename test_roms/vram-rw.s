; Code runs in HRAM
; Loops:
;  * Set {P15,P14} = b10
;  * Read 4 bytes (0xa0, 0xa1, 0xa2, 0xa3) from VRAM (0x8000)
;  * Set {P15,P14} = b01
;  * Write 4 bytes (0xc0, 0xc1, 0xc2, 0xc3) to VRAM (0x8004)

.section .hdrname
	.db "vram-rw"

.section .bank0
rw_load:
	db 0xa0, 0xa1, 0xa2, 0xa3
	db 0xb4, 0xb5, 0xb6, 0xb7

.section .hdata
main:
.global main
;	xor a
;	ld (0x40), a
;	nop
;	nop

	ld bc, rw_load
	ld de, 8
	ld hl, 0x8000
	call memcpy

loop:
	ld a, 0xef
	ld (0x00), a

	ld hl, 0x8000

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

	jr loop
