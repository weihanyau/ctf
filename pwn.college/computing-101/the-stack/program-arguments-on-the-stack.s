.intel_syntax noprefix
.global _start
_start:
mov rax, 60
mov rdi, [rsp+16]
mov rdi, [rdi]
syscall
