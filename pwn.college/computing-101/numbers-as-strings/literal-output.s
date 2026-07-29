.intel_syntax noprefix
.global _start

_start:
	xor rdx, rdx # input byte count
	mov rsi, [rsp + 16]

count_byte:
	cmp byte ptr [rsi + rdx], 0
	je  print_byte
	inc rdx
	jmp count_byte

print_byte:
	mov rax, 1
	mov rdi, 1
	syscall

end:
	mov rax, 60
	mov rdi, 0
	syscall
