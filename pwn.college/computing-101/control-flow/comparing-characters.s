.intel_syntax noprefix
.global _start

_start:
	mov  rdx, [rsp+16]
	cmp  BYTE PTR [rdx], 'p'
	setz dil
	mov  rax, 60
	syscall
