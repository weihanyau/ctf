.intel_syntax noprefix
.global _start

_start:
	mov rax, 60
	mov rdi, [rsp+16]
	cmp BYTE PTR [rdi], 'p'
	jne fail
	mov rdi, 0
	syscall

fail:
	mov rdi, 1
	syscall
