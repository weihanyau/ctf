.intel_syntax noprefix
.global _start
_start:
cmp rdi, 0
je zero
count:
cmp byte ptr [rdi + rax], 0
je done
add rax, 1
jmp count
zero:
mov rax, 0
done:
