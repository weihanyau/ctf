.intel_syntax noprefix
.global _start
_start:
jmp label
.rept 0x51
nop
.endr
label:
pop rdi
mov rax, 0x403000
jmp rax
