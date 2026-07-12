.intel_syntax noprefix
.global solve

solve:
	and rdi, 1
	cmp rdi, 1
	je  odd

even:
	mov rax, 1
	ret

odd:
	mov rax, 0
	ret
