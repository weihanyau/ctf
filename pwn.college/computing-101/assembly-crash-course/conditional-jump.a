.intel_syntax noprefix
.global _start
_start:
mov esi, 0x7f454c46
mov ebx, [rdi+4]
mov ecx, [rdi+8]
mov edx, [rdi+12]
cmp [edi], esi
jne is_first
mov eax, ebx
add eax, ecx
add eax, edx
jmp done
is_first:
mov esi, 0x00005A4D
cmp [edi], esi
jne is_second
mov eax, ebx
sub eax, ecx
sub eax, edx
jmp done
is_second:
mov eax, ebx
imul eax, ecx
imul eax, edx
done:
