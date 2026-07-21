.intel_syntax noprefix
.global atoi_digit
.global atoi

atoi_digit:
	xor rax, rax
	xor rdx, rdx
	mov dl, BYTE PTR [rdi]
	sub dl, 0x30
	mov rax, rdx
	ret

atoi:
	call atoi_digit
	mov  rdx, rax
	push rdx
	add  rdi, 1
	call atoi_digit
	pop  rdx
	imul rdx, 10
	add  rax, rdx
	ret
