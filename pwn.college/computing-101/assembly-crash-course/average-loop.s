.intel_syntax noprefix
.global _start
_start:
add rax, [rdi + 8 * rbx]
add rbx, 1
cmp rsi, rbx
jg _start
div rsi
