.intel_syntax noprefix
.global LOBYTE

LOBYTE:
	and rdi, 0xFF
	mov rax, rdi
	ret
