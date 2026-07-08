.intel_syntax noprefix
.global solve

solve:
	movsx rax, BYTE PTR [rdi]
	ret
