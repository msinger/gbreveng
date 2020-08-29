.section .hdrname
	.db "disp-test"

.section .bank0
main:
.global main
	call stop_ppu

;loop_div:
;ldh (0x04), a
;jr loop_div

	ld c, 0
	ld de, 8 * 1024
	ld hl, 0x8000
	call memset
	ld de, 160
	ld hl, 0xfe00
	call memset

	ld bc, tiles
	ld de, tiles_end - tiles
	ld hl, 0x8000
	call memcpy

;ld c, 1
;ld de, 32
;ld hl, 0x9800
;call memset

/*
ld c, 40
ld hl, 0xfe00
ena_sprites_loop:
ld a, 16
ldi (hl), a
ld a, 8
ldi (hl), a
ld a, 5
ldi (hl), a
inc hl
dec c
jr nz, ena_sprites_loop
*/

	ld hl, 0x9800
	ld a, 4
	ldi (hl), a
;	inc a
	ld (hl), a

	ld hl, 0x9c00
	ld a, 1
	ldi (hl), a
	dec a
	ld (hl), a

	ld a, 0xe4
	ldh (0x47), a ; bgp
	ldh (0x48), a ; obp0
	ldh (0x49), a ; obp1

	; Tile data:      0x8000 - 0x8fff
	; Background map: 0x9800 - 0x9bff
	; Window map:     0x9c00 - 0x9fff
	; Sprite size:    8*8
	ld a, 0xd0
	or 0x01    ; Enable background (and window)
	or 0x20    ; Enable window
	or 0x02    ; Enable sprites
;ld hl, 0x9fff
;ld (hl), a
	ldh (0x40), a
;ld (hl), a

; check if OAM is locked by PPU
/*
ld hl, 0xfe00
ldi a, (hl)
cp 16
jr nz, fail1
ldi a, (hl)
cp 8
jr nz, fail2
ldi a, (hl)
cp 5
jr nz, fail3
ld a, (hl)
cp 0
jr nz, fail4
jr good
fail1:
xor a
ldh (0x47), a
jr good
fail2:
ld a, 0x55
ldh (0x47), a
jr good
fail3:
ld a, 0xaa
ldh (0x47), a
jr good
fail4:
ld a, 0xff
ldh (0x47), a
good:
*/

;ld c, a

	ld a, 0
	ldh (0x42), a ; sy

	ld a, 0
	ldh (0x43), a ; sx

	ld a, 0
	ldh (0x4a), a ; wy

	ld a, 7
	ldh (0x4b), a ; wx

/*
loop:
call delay
call delay
call delay
call delay
call delay
call stop_ppu
call delay
call delay
ld a, c
ldh (0x40), a
jr loop
*/

	ret

tiles:
	;.db 0x40, 0xff
	.db 0xa0, 0x51
	.db 0xa0, 0x51
	.db 0xa0, 0x51
	.db 0xa0, 0x51
	.db 0xa0, 0x51
	.db 0xa0, 0x51
	.db 0xa0, 0x51
	.db 0xa0, 0x51

	.db 0xa2, 0x53
	.db 0xa2, 0x53
	.db 0xa2, 0x53
	.db 0xa2, 0x53
	.db 0xa2, 0x53
	.db 0xa2, 0x53
	.db 0xa2, 0x53
	.db 0xa2, 0x53

	.db 0x54, 0xa5
	.db 0x54, 0xa5
	.db 0x54, 0xa5
	.db 0x54, 0xa5
	.db 0x54, 0xa5
	.db 0x54, 0xa5
	.db 0x54, 0xa5
	.db 0x54, 0xa5

	.db 0x56, 0xa7
	.db 0x56, 0xa7
	.db 0x56, 0xa7
	.db 0x56, 0xa7
	.db 0x56, 0xa7
	.db 0x56, 0xa7
	.db 0x56, 0xa7
	.db 0x56, 0xa7

	.db 0, 0
	.db 0, 0
	.db 0, 0
	.db 0, 0
	.db 0, 0
	.db 0, 0
	.db 0, 0
	.db 0, 0

	.db 255, 255
	.db 255, 255
	.db 255, 255
	.db 255, 255
	.db 255, 255
	.db 255, 255
	.db 255, 255
	.db 255, 255
tiles_end:

wait_vblank:
	ldh a, (0x44)
	cp 145
	ret z
	jr wait_vblank

stop_ppu:
	call wait_vblank
	xor a
;ld hl, 0x9fff
;ld (hl), a
	ldh (0x40), a
;ld (hl), a
	ret

delay:
	nop
	nop
	nop
	nop
	nop
	dec b
	ret z
	jr delay
