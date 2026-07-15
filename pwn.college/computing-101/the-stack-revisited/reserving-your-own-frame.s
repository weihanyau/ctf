.intel_syntax noprefix
.global solve

solve:
	sub rsp, 256
	xor rdi, rdi

loop:
	cmp rdi, 256
	je  done
	mov BYTE PTR [rsp+rdi], 0
	inc rdi
	jmp loop

done:
	add rsp, 256
	ret
