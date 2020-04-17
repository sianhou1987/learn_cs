## reference
https://www.bilibili.com/video/BV1Jb411J749?p=6

## AT&T
- movl source, destion
l -> double word, 32bits
立即数(不能太大，要满足32bits要求)，寄存器（32bit下8个寄存器），存储器（多种模型）
imm -> reg / mem 
reg -> reg / mem
mem -> reg (不能mem->mem)
```c
movl $0x4, %eax // temp = 0x4;
movl 0x4, %eax // temp = *0x4; 
movl &-147, (%eax) // *p = -147;
movl %eax, %edx // temp2 = temp1;
movl %eax, (%edx) // *p = temp;
movl (%eax), %edx // temp = *p;
```

间接寻址 (r)
基址+偏移量 d(r)

example：
```c
void swap(int *xp, int *yp)
{
    int t0 = *xp;
    int t1 = *yp;
    *xp = t1;
    *yp = t0;
}
```

```assembly
swap:
    pushl %ebp
    movl %esp, %ebp
    pushl %ebx

    movl 12(%ebp), %ecx
    movl 8(%ebp), %edx
    movl (%ecx), %eax
    movl (%edx), %ebx
    movl %eax, (%edx)
    movl %ebx, (%ecx)

    movl -4(%ebp), %ebx
    movl %ebp, %esp
    popl %ebp
    ret
```