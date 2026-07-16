.intel_syntax noprefix
.global _start

_start:
	mov rsi, [rsp+24]
	mov rdx, 128

write_flag:
	mov rdi, 1
	mov rax, 1
	syscall
	mov rax, 60
	mov rdi, 0
	syscall

