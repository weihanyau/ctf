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
	mov qword ptr [rsp], 0x0000000050000002 # bind to port 80
	mov rsi, rsp
	mov rdx, 16
	syscall

	// listen
	mov rax, 50
	mov rdi, r12
	mov rsi, 0
	syscall

accept_loop:
	// accept
	mov rax, 43
	mov rdi, r12
	xor rsi, rsi
	xor rdx, rdx
	syscall
	mov r13, rax # accepted fd

	mov rax, 57
	syscall
	cmp rax, 0
	je  child_handle_request

	// close accepted fd in parent since child handling it
	mov rax, 3
	mov rdi, r13
	syscall

	jne accept_loop

child_handle_request:
	// close sockfd in children since parent handling it
	mov rax, 3
	mov rdi, r12
	syscall

	// read request
	sub rsp, 1024
	mov rax, 0
	mov rdi, r13
	mov rsi, rsp
	mov rdx, 1024
	syscall

	// get HTTP request path
	mov  rdi, rsp
	sub  rsp, 8
	mov  rsi, rsp
	call get_until_space # get HTTP method
	add  rdi, rax
	inc  rdi
	sub  rsp, 24
	mov  rsi, rsp
	call get_until_space # get request path

	// open HTTP request path
	mov rax, 2
	mov rdi, rsp
	mov rsi, 0
	xor rdx, rdx
	syscall
	mov r14, rax

	// read file
	mov rdi, r14
	mov rax, 0
	sub rsp, 1024
	mov rsi, rsp
	mov rdx, 1024
	syscall
	mov r15, rax

	// close file
	mov rax, 3
	mov rdi, r14
	syscall

	// response HTTP status code header to request
	mov rax, 1
	mov rdi, r13
	lea rsi, [rip+response]
	mov rdx, 19
	syscall

	// response opened file content to request
	mov rax, 1
	mov rdi, r13
	mov rsi, rsp
	mov rdx, r15
	syscall

	// close accepted fd
	mov rax, 3
	mov rdi, r13
	syscall

	mov rax, 60
	mov rdi, 0
	syscall

response:
	.asciz "HTTP/1.0 200 OK\r\n\r\n"

get_until_space:
	xor rax, rax
	xor rdx, rdx

get_until_space_loop:
	cmp byte ptr [rdi + rax], 0x20
	je  get_until_space_done
	mov dl, byte ptr [rdi + rax]
	mov byte ptr [rsi + rax], dl
	inc rax
	jmp get_until_space_loop

get_until_space_done:
	mov byte ptr [rsi + rax], 0
	ret
