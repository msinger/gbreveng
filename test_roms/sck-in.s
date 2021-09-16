.section .hdrname
	.db "sck-in"

.section .text
main:
.global main
	xor a
	ld 0x02, a
	ld a, 0x80
	ld 0x02, a
loop:
	jr loop
