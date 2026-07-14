.intel_syntax noprefix
.global solve

solve:
	call rdi
	mov  rax, qword ptr [rsp-0x10]
	ret
