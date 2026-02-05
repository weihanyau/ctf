.intel_syntax noprefix
most_common_byte:
mov rbp, rsp
sub rsp, rsi
xor rbx, rbx
xor rcx, rcx
xor r10, r10
sub rsi, 1
first_while:
cmp rbx, rsi
jg end_first_while
xor rcx, rcx
mov cl, [rdi + rbx]
shl rcx, 1
mov r10, rsp
sub r10, rcx
inc byte ptr [r10]
inc rbx
jmp first_while
end_first_while:
xor rbx, rbx
xor rdx, rdx
xor rax, rax
xor r10, r10
xor rcx, rcx
second_while:
cmp rbx, 0xff
jg end_second_while
mov r10, rsp
mov rcx, rbx
shl rcx, 1
sub r10, rcx
cmp byte ptr [r10], dl
jle endif
mov dl, [r10]
mov rax, rbx
endif:
inc rbx
jmp second_while
end_second_while:
mov rsp, rbp
ret
