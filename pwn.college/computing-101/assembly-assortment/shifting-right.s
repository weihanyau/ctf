.intel_syntax noprefix
.global solve

solve:
	mov rax, rdi
	shr rax, 8
	and rax, 0xFF
	ret
