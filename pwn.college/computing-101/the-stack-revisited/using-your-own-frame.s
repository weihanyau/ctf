.intel_syntax noprefix
.global solve

solve:
	sub rsp, 256
	xor rdx, rdx

clear:
	cmp rdx, 256
	je  store_start
	mov BYTE PTR [rsp+rdx], 0
	inc rdx
	jmp clear

store_start:
	xor rdx, rdx
	xor rcx, rcx

store_loop:
	cmp rdx, rsi
	je  count_start
	mov cl, BYTE PTR [rdi + rdx]
	mov BYTE PTR [rsp + rcx], 1
	inc rdx
	jmp store_loop

count_start:
	xor rdx, rdx
	xor rax, rax
	xor rcx, rcx

count_loop:
	cmp rdx, 256
	je  done
	mov cl, BYTE PTR [rsp + rdx]
	add rax, rcx
	inc rdx
	jmp count_loop

done:
	add rsp, 256
	ret
