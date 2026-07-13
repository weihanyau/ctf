.intel_syntax noprefix
.global chr_lower

chr_lower:
	mov rax, rdi
	or  rax, 0x20
	ret
