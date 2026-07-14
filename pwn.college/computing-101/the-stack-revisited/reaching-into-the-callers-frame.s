.intel_syntax noprefix
.global solve

solve:
	xor rdx, rdx

count:
	cmp BYTE PTR [rsp + 0x40 + rdx], 0
	je  done
	inc rdx
	jmp count

done:
	mov rax, 1
	mov rdi, 1
	lea rsi, [rsp + 0x40]
	syscall
	ret
