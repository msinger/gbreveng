; Code runs in HRAM

.section .hdrname
	.db "dma-wram"

.section .hdata
main:
.global main
;	xor a
;	ld (0x40), a
;	nop
;	nop

	ld a, 160
	ld hl, 0xc000
fill:
	dec a
	ld (hli), a
	jr nz, fill

	ld c, 0x46
	ld a, h

loop:
	ld (c), a    ; start DMA

	ld l, 40
wait:
	dec l
	jr nz, wait

	jr loop
