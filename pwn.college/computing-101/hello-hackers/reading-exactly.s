.intel_syntax noprefix
.global _start
_start:
mov rax, 0
mov rdi, 0
add rsp, 16
mov rsi, rsp
mov rdx, 128
syscall
mov rdx, rax
mov rax, 1
mov rdi, 1
mov rsi, rsp
syscall
mov rax, 60
mov rdi, 42
syscall
