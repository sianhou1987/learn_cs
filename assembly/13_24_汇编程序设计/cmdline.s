.text
.globl _start
_start:
    popl    %ecx        # argc
vnext:
    popl    %ecx        # argv
    test    %ecx, %ecx  # null pointer
    jz      exit
    movl    %ecx, %ebx
    xorl    %edx, %edx
strlen:
    movb    (%ebx), %al
    inc     %edx
    inc     %ebx
    text    %al, %al
    jnz     strlen
    movb    $10, -1(%ebx)
    movl    $4, %eax
    movl    $1, %ebx
    int     $0x80
    jmp     vnext
exit:
    movl    $1, %eax
    xorl    %ebx, %ebx
    int     $0x80