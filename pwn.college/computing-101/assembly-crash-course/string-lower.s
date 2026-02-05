.intel_syntax noprefix
str_lower:
mov rbx, rdi
mov rdx, 0
cmp rdi, 0
je done
while_loop:
cmp byte ptr [rbx], 0x00
je done
cmp byte ptr [rbx], 0x5a
jg endif
mov r10b, byte ptr [rbx]
mov rdi, r10
mov rax, 0x403000
call rax
mov byte ptr [rbx], al
add rdx, 1
endif:
add rbx, 1
jmp while_loop
done:
mov rax, rdx
ret
