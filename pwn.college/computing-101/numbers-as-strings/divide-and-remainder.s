.intel_syntax noprefix
.global itoa

itoa_digit:
	mov rax, rdi
	add rax, 0x30
	ret

itoa:
	xor rdx, rdx
	mov rax, rdi
	mov rcx, 10
	div rcx

	push rax
	mov  rdi, rdx
	call itoa_digit
	mov  [rsi+1], al
	pop  rax

	mov  rdi, rax
	call itoa_digit
	mov  [rsi], al

	mov rax, 2
	ret
