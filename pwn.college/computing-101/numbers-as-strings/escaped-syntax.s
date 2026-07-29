.intel_syntax noprefix
.global _start

_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, [rsp + 16]
	mov rdx, 1
	sub rsp, 3
	mov byte ptr [rsp], 0x0a
	mov byte ptr [rsp + 1], 0x5c
	mov byte ptr [rsp + 2], 0x25

print_byte:
	cmp byte ptr [rsi], 0
	je  end
	cmp byte ptr [rsi], 0x5c # check '\'
	je  backslash
	cmp byte ptr [rsi], 0x25 # check '%'
	je  percentage
	jmp write_byte

backslash:
	cmp byte ptr [rsi + 1], 0x6e # check '\n'
	je  backslash_newline
	cmp byte ptr [rsi + 1], 0x5c # check '\\'
	je  double_backslash
	jmp write_byte

double_backslash:
	mov rbx, rsi # store current buffer pointer
	mov rsi, rsp
	add rsi, 1
	syscall
	mov rsi, rbx
	add rsi, 2
	jmp print_byte

backslash_newline:
	mov rbx, rsi # store current buffer pointer
	mov rsi, rsp
	syscall
	mov rsi, rbx
	add rsi, 2
	jmp print_byte

percentage:
	cmp byte ptr [rsi + 1], 0x25
	je  double_percentage
	jmp write_byte

double_percentage:
	mov rbx, rsi # store current buffer pointer
	mov rsi, rsp
	add rsi, 2
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
