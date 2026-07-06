.intel_syntax noprefix
.global _start

_start:
	mov rax, 60
	mov rdi, [rsp+16]
	cmp BYTE PTR [rdi], 'p'
	jne fail
	cmp BYTE PTR [rdi+1], 'w'
	jne fail
	cmp BYTE PTR [rdi+2], 'n'
	jne fail
	mov rdi, 0
	syscall

fail:
	mov rdi, 1
	syscall
