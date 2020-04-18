# write_records.s
.include "linux.s"
.include "record_def.s"
.section .data
record1:
    .ascii  "Fredrick\0"
    .rept   31  # Padding to 40 bytes
    .byte   0
    .endr
    .ascii  "Bartlett\0"
    .rept   31  # Padding to 40 bytes
    .byte   0
    .endr
    .ascii  "4242 S Prairie\nTulsa, OK 55555\0"
    .rept   209 # Padding to 240 bytes
    .byte   0
    .endr
    .long   45

# as write_record.s -o write_record.o
# as write_records.s -o write_records.o
# ld write_record.o write_records.o -o write_records
file_name:
    .ascii  "test.dat\0"

.equ    ST_FILE_DESCRIPTOR, -4
.globl  _start
_start:
    movl    %esp, %ebp
    subl    $4, %esp
    movl    $SYS_OPEN, %eax
    movl    $file_name, %ebx
    movl    $0101, %ecx

    movl    $0666, %edx
    int     $LINUX_SYSCALL
    movl    %eax, ST_FILE_DESCRIPTOR(%ebp)
    pushl   ST_FILE_DESCRIPTOR(%ebp)
    pushl   $recod1
    call    write_record
    addl    $8, %esp    