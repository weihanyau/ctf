.intel_syntax noprefix
.global _start

_start:
	cmp qword ptr [rsp], 4
	je  binary_operation
	cmp qword ptr [rsp], 3
	je  unary_operation
	jmp fail

binary_operation:
	mov  r12, [rsp + 16] # first operand buffer
	mov  r13, [rsp + 32] # second operand buffer
	mov  r14, [rsp + 24] # operator buffer
	mov  rdi, r12
	call atoi
	mov  r12, rax # first operand
	mov  rdi, r13
	call atoi
	mov  r13, rax # second operand
	cmp  byte ptr [r14], 0x2b
	je   sum
	cmp  byte ptr [r14], 0x2d
	je   subtract
	cmp  byte ptr [r14], 0x2a
	je   multiply
	cmp  byte ptr [r14], 0x5e
	je   xor_op
	cmp  byte ptr [r14], 0x7c
	je   or_op
	cmp  byte ptr [r14], 0x26
	je   and_op
	jmp  fail

// All operator result store in r12
sum:
	add r12, r13
	jmp done

subtract:
	sub r12, r13
	jmp done

multiply:
	imul r12, r13
	jmp  done

xor_op:
	xor r12, r13
	jmp done

or_op:
	or  r12, r13
	jmp done

and_op:
	and r12, r13
	jmp done

unary_operation:
	mov  r12, [rsp + 24] # operand buffer
	mov  r13, [rsp + 16] # operator buffer
	mov  rdi, r12
	call atoi
	mov  r12, rax # first operand
	cmp  byte ptr [r13], 0x2d
	je   negate
	cmp  byte ptr [r13], 0x7e
	je   flip
	jmp  fail

negate:
	neg r12
	jmp done

flip:
	not r12
	jmp done

done:
	mov  rdi, r12
	sub  rsp, 0x80
	mov  rsi, rsp
	call itoa
	mov  rdx, rax
	mov  rdi, 1
	mov  rsi, rsp
	mov  rax, 1
	syscall

	mov rax, 60
	mov rdi, 0
	syscall

fail:
	mov rax, 60
	mov rdi, 1
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
