.section .hdrname
	.db "stop"

.section .text
main:
.global main
	stop
	nop
	jr main
