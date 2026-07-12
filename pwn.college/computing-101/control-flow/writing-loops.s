.intel_syntax noprefix
.global _start

_start:
	mov rdi, 0

loop:
	mov rsi, [rsp + 0x10]
	cmp BYTE PTR [rsi + rdi], 0
	je  end
	inc rdi
	jne loop

end:
	mov rax, 60
	syscall

