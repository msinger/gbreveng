.section .hdrname
	.db "w-hram2"

.section .bank1
main:
.global main
	ld c, wr
	ld a, 0xff

loop:
	ld (c), a
	jr loop

.section .hbss
wr:
.byte
