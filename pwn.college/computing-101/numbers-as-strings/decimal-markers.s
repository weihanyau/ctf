.intel_syntax noprefix
.global _start

_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, [rsp + 16]
	mov r12, rsp
	add r12, 24 # point to argv[2]
	mov rdx, 1
	sub rsp, 3
	mov byte ptr [rsp], 0x0a
	mov byte ptr [rsp + 1], 0x5c
	mov byte ptr [rsp + 2], 0x25

print_byte:
	cmp byte ptr [rsi], 0
	je  end
	cmp byte ptr [rsi], 0x5c # check '\'
	je  backslash
	cmp byte ptr [rsi], 0x25 # check '%'
	je  percentage
	jmp write_byte

backslash:
	cmp byte ptr [rsi + 1], 0x6e # check '\n'
	je  backslash_newline
	cmp byte ptr [rsi + 1], 0x5c # check '\\'
	je  double_backslash
	jmp write_byte

double_backslash:
	mov rbx, rsi # store current buffer pointer
	mov rsi, rsp
	add rsi, 1
	syscall
	mov rsi, rbx
	add rsi, 2
	jmp print_byte

backslash_newline:
	mov rbx, rsi # store current buffer pointer
	mov rsi, rsp
	syscall
	mov rsi, rbx
	add rsi, 2
	jmp print_byte

percentage:
	cmp byte ptr [rsi + 1], 0x25
	je  double_percentage
	cmp byte ptr [rsi + 1], 0x64
	je  percentage_digit
	jmp write_byte

double_percentage:
	mov rbx, rsi # store current buffer pointer
	mov rsi, rsp
	add rsi, 2
	syscall
	mov rsi, rbx
	add rsi, 2
	jmp print_byte

percentage_digit:
	push rax
	push rdi
	push rsi
	push rdx
	sub  rsp, 30
	mov  rdi, [r12]
	call atoi
	mov  rdi, rax
	mov  rsi, rsp
	call itoa
	mov  rdx, rax
	mov  rax, 1
	mov  rdi, 1
	mov  rsi, rsp
	syscall
	add  r12, 8
	add  rsp, 30
	pop  rdx
	pop  rsi
	pop  rdi
	pop  rax
	add  rsi, 2
	jmp  print_byte

write_byte:
	syscall
	inc rsi
	jmp print_byte

end:
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
	jne atoi_loop
	mov cl, BYTE PTR [rdi]
	inc rdi

atoi_loop:
	xor  rax, rax
	mov  al, BYTE PTR [rdi]
	sub  rax, 0x30
	cmp  rax, 9
	ja   atoi_done
	imul rdx, 10
	push rdx
	call atoi_digit
	pop  rdx
	add  rdx, rax
	inc  rdi
	jmp  atoi_loop

atoi_done:
	mov rax, rdx
	cmp cl, 0x2d
	jne atoi_skip_make_negative
	neg rax

atoi_skip_make_negative:
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

