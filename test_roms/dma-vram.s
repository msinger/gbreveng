; Code runs in HRAM

.section .hdrname
	.db "dma-vram"

.section .hdata
main:
.global main
	xor a
	ldh (0x40), a
	nop
	nop

	ld a, 160
	ld hl, 0x8000
fill:
	dec a
	ldi (hl), a
	jr nz, fill

	ld a, 0x91
	ldh (0x40), a

	ld c, 0x46
	ld a, h

loop:
	ldh (c), a    ; start DMA

	ld l, 40
wait:
	dec l
	jr nz, wait

	jr loop
