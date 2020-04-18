# as -o first_func.o first_func.s --32
# ld -o first_func first_func.o -m elf_i386
.data                   # 数据段
msg:
    .ascii "Hello world\n"
    len = .-msg         # "." 表示当前地址
.text                   # 代码段
.globl _start           # 汇编程序的入口，如同C的main函数
_start:
    movl    $len, %edx  # 要写进去多少个数据
    movl    $msg, %ecx  # 起始地址在哪里
    movl    $1, %ebx    # 系统输出（write系统调用），写到1号输出（标准输出）
    movl    $4, %eax
    int     $0x80

    movl    $0, %ebx    # 程序退出
    movl    $1, %eax
    int     $0x80
# x86-Linux下的系统调用时通过中断指令（int $0x80）来实现的
# 在执行int $0x80指令时，寄存器eax中存放系统调用的功能号，而传给系统调用的
#   参数则必须按顺序放到寄存器ebx, ecx, edx, esi, edi中，当系统调用完成之后,
#   返回值可以存在寄存器eax中获取
# 当一个系统调用所需要的参数个数大于5时，需将系统调用功能号存在寄存器eax中，
#   全部参数一次放在一块连续的内存区域里，同时在寄存器ebx中保存指向该内存区域
#   的指针，返回值扔保存在eax中