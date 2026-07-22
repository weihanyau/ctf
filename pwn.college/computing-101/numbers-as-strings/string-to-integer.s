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
	xor rdx, rdx

loop:
	cmp  BYTE PTR [rdi], 0
	je   done
	imul rdx, 10
	push rdx
	call atoi_digit
	pop  rdx
	add  rdx, rax
	inc  rdi
	jmp  loop

done:
	mov rax, rdx
	ret
