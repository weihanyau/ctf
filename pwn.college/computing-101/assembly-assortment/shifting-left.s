.intel_syntax noprefix
.global solve

solve:
	mov rax, rdi
	shl rax, 4
	ret
