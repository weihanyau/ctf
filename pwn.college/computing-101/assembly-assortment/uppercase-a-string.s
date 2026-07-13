.intel_syntax noprefix
.global str_upper

str_upper:
	mov rsi, 0

loop:
	mov dl, [rdi+rsi]
	cmp dl, 0
	je  done
	and dl, 0xDF
	mov [rdi+rsi], dl
	inc rsi
	jmp loop

done:
	ret
