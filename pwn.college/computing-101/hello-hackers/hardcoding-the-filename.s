.intel_syntax noprefix
.global _start

_start:
	mov BYTE PTR [rsp], '/'
	mov BYTE PTR [rsp+1], 'f'
	mov BYTE PTR [rsp+2], 'l'
	mov BYTE PTR [rsp+3], 'a'
	mov BYTE PTR [rsp+4], 'g'
	mov BYTE PTR [rsp+5], 0
	mov rax, 2
	mov rdi, rsp
	mov rsi, 0
	syscall
	mov rdi, rax
	mov rax, 0
	sub rsp, 128
	mov rsi, rsp
	mov rdx, 128
	syscall
	mov rdx, rax
	mov rax, 1
	mov rdi, 1
	mov rsi, rsp
	syscall
	mov rax, 60
	mov rdi, 42
	syscall
