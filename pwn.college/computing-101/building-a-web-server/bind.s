.intel_syntax noprefix
.global _start

_start:
	// socket
	mov rax, 41
	mov rdi, 2
	mov rsi, 1
	mov rdx, 0
	syscall

	// bind
	mov rdi, rax
	mov rax, 49
	sub rsp, 16
	mov qword ptr [rsp], 0x00000050000002
	mov rsi, rsp
	mov rdx, 16
	syscall

	// exit
	mov rax, 60
	mov rdi, 0
	syscall
