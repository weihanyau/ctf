.intel_syntax noprefix
.global itoa

itoa_digit:
	mov rax, rdi
	add rax, 0x30
	ret

itoa:
	xor r8, r8

	// zero check
	cmp rdi, 0
	jne negative_check
	mov r8, 1
	mov byte ptr [rsi], 0x30
	jmp itoa_end

negative_check:
	cmp rdi, 0
	jg  count_start
	neg rdi
	add r8, 1
	mov byte ptr [rsi], 0x2D

count_start:
	xor rdx, rdx
	mov rax, rdi
	mov rcx, 10

count_loop:
	cmp rax, 0
	je  itoa_start
	inc r8
	div rcx
	xor rdx, rdx
	jmp count_loop

itoa_start:
	xor rdx, rdx
	mov rax, rdi
	mov rcx, 10
	add rsi, r8

itoa_loop:
	cmp rax, 0
	je  itoa_end
	div rcx

	push rax
	mov  rdi, rdx
	xor  rdx, rdx
	call itoa_digit
	dec  rsi
	mov  [rsi], al
	pop  rax
	jmp  itoa_loop

itoa_end:
	mov rax, r8
	ret
