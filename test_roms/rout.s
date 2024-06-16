; Output sound on right channel

.section .hdrname
	.db "rout"

.section .bank0
main:
.global main
	ld a, 0x80
	ld (0x26), a
	ld a, 0x0f
	ld (0x25), a
	ld a, 0x77
	ld (0x24), a
	ld a, 0x00
	ld (0x10), a
	ld a, 0x80
	ld (0x11), a
	ld a, 0xf0
	ld (0x12), a
	ld a, 0x83
	ld (0x13), a
	ld a, 0x87
	ld (0x14), a

loop:
	jr loop

