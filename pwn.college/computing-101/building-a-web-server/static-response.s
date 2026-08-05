.intel_syntax noprefix
.global _start

_start:
	// socket
	mov rax, 41
	mov rdi, 2
	mov rsi, 1
	mov rdx, 0
	syscall
	mov r12, rax # sockfd

	// bind
	mov rdi, r12
	mov rax, 49
	sub rsp, 16
	mov qword ptr [rsp], 0x0000000050000002
	mov rsi, rsp
	mov rdx, 16
	syscall

	// listen
	mov rax, 50
	mov rdi, r12
	mov rsi, 0
	syscall

	// accept
	mov rax, 43
	mov rdi, r12
	xor rsi, rsi
	xor rdx, rdx
	syscall
	mov r13, rax # accepted fd

	// read request
	sub rsp, 1024
	mov rax, 0
	mov rdi, r13
	mov rsi, rsp
	mov rdx, 1024
	syscall

	// response to request
	mov rax, 1
	mov rdi, r13
	lea rsi, [rip+response]
	mov rdx, 19
	syscall

	// close accepted fd
	mov rax, 3
	mov rdi, r13
	syscall

	// exit
	mov rax, 60
	mov rdi, 0
	syscall

response:
	.asciz "HTTP/1.0 200 OK\r\n\r\n"
