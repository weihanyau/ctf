.intel_syntax noprefix
.global _start
_start:
mov rax, 1
mov rdi, 1
mov rsi, 1337000
mov rdx, 14
syscall
mov rax, 60
mov rdi, 42
syscall
