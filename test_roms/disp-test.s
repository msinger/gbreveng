.section .hdrname
	.db "disp-test"

.section .bank0
main:
.global main
	call stop_ppu

;loop_div:
;ld (0x04), a
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
ld (hli), a
ld a, 8
ld (hli), a
ld a, 5
ld (hli), a
inc hl
dec c
jr nz, ena_sprites_loop
*/

	ld hl, 0x9800
	ld a, 4
	ld (hli), a
;	inc a
	ld (hl), a

	ld hl, 0x9c00
	ld a, 1
	ld (hli), a
	dec a
	ld (hl), a

	ld a, 0xe4
	ld (0x47), a ; bgp
	ld (0x48), a ; obp0
	ld (0x49), a ; obp1

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
	ld (0x40), a
;ld (hl), a

; check if OAM is locked by PPU
/*
ld hl, 0xfe00
ld a, (hli)
cp 16
jr nz, fail1
ld a, (hli)
cp 8
jr nz, fail2
ld a, (hli)
cp 5
jr nz, fail3
ld a, (hl)
cp 0
jr nz, fail4
jr good
fail1:
xor a
ld (0x47), a
jr good
fail2:
ld a, 0x55
ld (0x47), a
jr good
fail3:
ld a, 0xaa
ld (0x47), a
jr good
fail4:
ld a, 0xff
ld (0x47), a
good:
*/

;ld c, a

	ld a, 0
	ld (0x42), a ; sy

	ld a, 0
	ld (0x43), a ; sx

	ld a, 0
	ld (0x4a), a ; wy

	ld a, 7
	ld (0x4b), a ; wx

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
ld (0x40), a
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
	ld a, (0x44)
	cp 145
	ret z
	jr wait_vblank

stop_ppu:
	call wait_vblank
	xor a
;ld hl, 0x9fff
;ld (hl), a
	ld (0x40), a
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
