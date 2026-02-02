.intel_syntax noprefix
.global _start
_start:
mov rbx, [rdi]
mov rax, [rdi+8]
add rbx, rax
mov [rsi], rbx
