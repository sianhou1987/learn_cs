# write_record.s
.include "recode_def.s"
.include "linux.s"

# INPUT: the file descriptor and a buffer
# OUTPUT: this function writes the data to the buffer and returns a statue code
# stack procedural parameters
.equ ST_WRITE_BUFFER, 8
.equ ST_FILEDES, 12

.section .text
.globl write_record
.type write_record, @function
write_record:
    pushl   %ebp
    movl    %esp, %ebp
    pushl   %ebx
    movl    $SYS_WRITE, %eax
    movl    ST_FILEDES(%ebp), %ebx
    movl    ST_WRITE_BUFFER(%ebp), %ecx
    movl    $RECODE_SIZE, %edx
    int     $LINUX_SYSCALL
    