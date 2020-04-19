section .data
heap_begin: 
    .long 0                 # this points to the beginning of the memor
current_break:
    .long 0                 # this points to one location past the memory we are managing
.equ HEADER_SIZE, 8         # size of space for memory region header
.equ HDR_AVAIL_OFFSET, 0    # location of the "available" flag in the header
.equ HDR_SIZE_OFFSET, 4     # location of the size field in the header
.equ UNAVAILABLE, 0
.equ AVAILABLE, 1
.equ SYS_BRK, 45                            # systemcall for brk
.equ LINUX_SYSCALL, 0x80

section .text

.globl allocate_init
.type allocate_init, @function
allocate_init:
    pushl   %ebp
    movl    %esp, %ebp

    # If the brk system call is called with 0 in %ebx, it
    # returns the last valid usable address
    movl    $SYS_BRK, %eax
    movl    $0, %ebx
    int     $LINUX_SYSCALL
    decl    %eax                            # %eax now has the last valid address
    movl    %eax, current_break             # store the current break
    movl    %eax, heap_begin

    movl    %ebp, %esp
    popl    %ebp
    ret

.globl allocate_init
.type allocate, @function
.equ ST_MEM_SIZE, 8                         # stack position of the memory size to allocate
allocate:
    pushl   %ebp
    movl    %esp, %ebp
    movl    ST_MEM_SIZE(%ebp), %ecx         # %ecx will hold the size

    # we are  looking for (which is the first and only parameter)
    movl    heap_begin, %eax                # %eax will hold the search location
    movl    current_break, %ebx             # %ebx will hold the current break

loop_begin:
    cmpl    %ebx, %eax
    je      move_break

    # grab the size of this memory
    movl    HDR_SIZE_OFFSET(%eax), %edx
    cmpl    $UNAVAILABLE, HDR_AVAIL_OFFSET(%eax)
    je      next_location                   # if unavailable, go to the next
    cmpl    %edx, %ecx                      # if available, check the size
    jle     allocate_here                   # big enough, go the allocate_here

next_location:
    addl    $HEADER_SIZE, %eax
    addl    %edx, %eax                      # the total size of the memory
    jmp     loop_begin                      # go to the next location

allocate_here:
    # If we've made it here, that means that the region header of 
    # the region to allocate is in %eax, mark space as unavailable
    movl    $UNAVAILABLE， HDR_AVAIL_OFFSET(%eax)
    addl    $HEADER_SIZE, %eax              # move %eax to the usable memory

    movl    %ebp, %esp
    popl    %ebp
    ret

move_break:
    addl    $HEADER_SIZE, %ebx              # add space fro the headers structure
    addl    %ecx, %ebx                      # add sapce to the break for the data

    pushl   %eax                            # save needed registers
    movl    $SYS_BRK, %eax                  # reset the break
    int     $LINUX_SYSCALL
    popl    %eax                            # no error chcek?   

    # Set this memory as unavailable, since we're about to give it away
    movl    $UNAVAILABLE, HDR_AVAIL_OFFSET(%eax)
    movl    %ecx, HDR_SIZE_OFFSET(%eax)     # set the size of the memory
    addl    $HEADER_SIZE, %eax              # move %eax to the actual stat of useable memory

    movl    %ebx, current_break

    movl    %ebp, %esp
    popl    %ebp
    ret

.globl deallocate
.type deallocate, @function
.equ ST_MEM_SEG, 4
deallocate:
    movl    ST_MEM_SEG(%esp), %eax
    # get the pointer to the real beginning of the memory
    subl    $HEADER_SIZE, %eax
    # mark it as available
    movl    $AVAILABLE, HDR_AVAIL_OFFSET(%eax)

    ret