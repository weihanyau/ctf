.intel_syntax noprefix
.global _start

_start:
	mov rax, 2
	lea rdi, [rip+path]
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

path:
	.asciz "/flag"
