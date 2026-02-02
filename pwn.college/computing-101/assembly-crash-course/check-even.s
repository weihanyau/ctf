.intel_syntax noprefix
.global _start
_start:
or rax, 1
and rax, 1
and rax, rdi
xor rax, 1
