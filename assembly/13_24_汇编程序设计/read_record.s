# read_record.s
.include "recode_def.s"
.include "linux.s"

# INPUT: the file descriptor and a buffer
# OUTPUT: this function writes the data to the buffer and returns a statue code
# stack procedural parameters
.equ ST_READ_BUFFER, 8
.equ ST_FILEDES, 12

.section .text
.globl read_record
.type read_record, @function
read_record:
    pushl   %ebp
    movl    %esp, %ebp
    pushl   %ebx
    movl    ST_FILEDES(%ebp), %ebx
    movl    ST_READ_BUFFER(%ebp), %ecx
    movl    $RECODE_SIZE, %edx
    movl    $SYS_READ, %eax
    int     $LINUX_SYSCALL