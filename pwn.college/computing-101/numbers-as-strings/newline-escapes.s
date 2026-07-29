.intel_syntax noprefix
.global _start

_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, [rsp + 16]
	mov rdx, 1
	sub rsp, 1
	mov byte ptr [rsp], 0x0a

print_byte:
	cmp byte ptr [rsi], 0
	je  end
	cmp byte ptr [rsi], 0x5c # check '\'
	jne write_byte
	cmp byte ptr [rsi + 1], 0x6e # check n
	jne write_byte
	mov rbx, rsi # store current buffer pointer
	mov rsi, rsp
	syscall
	mov rsi, rbx
	add rsi, 2
	jmp print_byte

write_byte:
	syscall
	inc rsi
	jmp print_byte

end:
	mov rax, 60
	mov rdi, 0
	syscall
