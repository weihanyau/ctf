.intel_syntax noprefix
.global _start

_start:
	cmp  QWORD PTR [rsp], 42
	setz dil
	mov  rax, 60
	syscall
