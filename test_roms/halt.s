.section .hdrname
	.db "halt"

.section .text
main:
.global main
	halt
	nop
	jr main
