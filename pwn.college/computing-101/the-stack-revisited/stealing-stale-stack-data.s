.intel_syntax noprefix
.global solve

solve:
	call rdi
	xor  rdx, rdx

count:
	cmp BYTE PTR [rsp - 0x88 + rdx], 0
	je  done
	inc rdx
	jmp count

done:
	mov rax, 1
	mov rdi, 1
	lea rsi, [rsp - 0x88]
	syscall
	ret
