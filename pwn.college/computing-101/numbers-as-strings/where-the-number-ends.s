.intel_syntax noprefix
.global atoi

atoi_digit:
	xor rax, rax
	xor rdx, rdx
	mov dl, BYTE PTR [rdi]
	sub dl, 0x30
	mov rax, rdx
	ret

atoi:
	xor rcx, rcx
	xor rdx, rdx
	cmp BYTE PTR [rdi], 0x2d # negative number checks
	jne loop
	mov cl, BYTE PTR [rdi]
	inc rdi

loop:
	xor  rax, rax
	mov  al, BYTE PTR [rdi]
	sub  rax, 0x30
	cmp  rax, 9
	ja   done
	imul rdx, 10
	push rdx
	call atoi_digit
	pop  rdx
	add  rdx, rax
	inc  rdi
	jmp  loop

done:
	mov rax, rdx
	cmp cl, 0x2d
	jne skip_make_negative
	neg rax

skip_make_negative:
	ret
