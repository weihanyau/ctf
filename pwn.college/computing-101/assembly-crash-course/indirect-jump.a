.intel_syntax noprefix
.global _start
_start:
cmp edi, 3
mov eax, [esi+ 8 * 4]
jg default
mov eax, [esi + edi * 8]
default:
jmp rax
