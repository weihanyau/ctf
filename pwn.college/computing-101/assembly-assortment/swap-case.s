.intel_syntax noprefix
.global str_swapcase

str_swapcase:
	mov rsi, 0

loop:
	mov dl, [rdi+rsi]
	cmp dl, 0
	je  done
	xor dl, 0x20
	mov [rdi+rsi], dl
	inc rsi
	jmp loop

done:
	ret
