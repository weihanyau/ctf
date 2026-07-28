.intel_syntax noprefix
.global _start

_start:
	xor r12, r12 # iterator count
	xor r13, r13 # total sum
	mov rbx, [rsp]
	sub rbx, 1 # argc

sum_total:
	cmp  rbx, r12
	je   write_total
	mov  rdi, [rsp + r12 * 8 + 16]
	call atoi
	add  r13, rax
	inc  r12
	jmp  sum_total

write_total:
	mov  rdi, r13
	push 0
	mov  rsi, rsp
	call itoa
	mov  rdx, rax
	mov  rsi, rsp
	mov  rdi, 1
	mov  rax, 1
	syscall

	mov rax, 60
	mov rdi, 0
	syscall

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
