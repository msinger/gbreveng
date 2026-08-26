.section .hdrname
	.db "lcdon-write"

.section .text

wait_ly:
	ld a, (0x44)
	cp b
	jr nz, wait_ly
	ret

disable_ppu_safe:
	ld b, 144
	call wait_ly
	xor a
	ld (0x40), a
	ret

main:
.global main
	call disable_ppu_safe

	ld c, 0x00
	ld de, 160
	ld hl, 0xfe00
	call memset

	ld hl, result
	ld b, 0xff
	call run_tests

	push hl
	ld c, 0xff
	ld de, 160
	ld hl, 0xfe00
	call memset
	pop hl

	ld b, 0x00
	call run_tests

	ld a, 0x0a
	ldx (0x0000), a
	ld bc, result
	ld de, 8
	ld hl, 0xa000
	call memcpy
	xor a
	ldx (0x0000), a

	ld a, 0x81
	ld (0x40), a

	ret

run_tests:
	ld de, 0xfe00
	ld c, 130
	call run_test

	ld c, 244
	call run_test

	ld de, 0xfe01
	ld c, 130
	call run_test

	ld c, 244
	call run_test

	ret

run_test:
	push de
	push hl
	push bc

	ld bc, test_prolog
	ld de, test_epilog - test_prolog
	ld hl, test_code
	call memcpy

	pop bc
	ld e, c
	push bc
	xor a
	ld d, a
	ld c, a
	call memset

	ld bc, test_epilog
	ld de, test_epilog_end - test_epilog
	call memcpy

	pop bc
	pop hl
	pop de

	call test_code

	push bc
	call disable_ppu_safe
	pop bc
	ld a, (de)
	ld (hli), a

	ret

test_prolog:
	ld a, 0x81
	ld (0x40), a
	ld a, b
test_epilog:
	ld (de), a
	ret
test_epilog_end:

.section .bss

result:
.rept 8
.byte 0
.endr

test_code:
.rept 512
.byte 0
.endr
