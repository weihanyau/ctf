.intel_syntax noprefix
.global _start
_start:
add rax, [rsp]
add rax, [rsp+8]
add rax, [rsp+16]
add rax, [rsp+24]
mov rdi, 4
div rdi
push rax
