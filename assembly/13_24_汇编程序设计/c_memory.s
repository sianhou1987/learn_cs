	.file	"c_memory.c"
	.text
	.p2align 4,,15
	.globl	useless
	.type	useless, @function
useless:
.LFB0:
	.cfi_startproc
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE0:
	.size	useless, .-useless
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	leal	4(%esp), %ecx
	.cfi_def_cfa 1, 0
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	movl	%esp, %ebp
	pushl	%ebx
	pushl	%ecx
	.cfi_escape 0xf,0x3,0x75,0x78,0x6
	.cfi_escape 0x10,0x3,0x2,0x75,0x7c
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	subl	$12, %esp
	pushl	$268435456
	call	malloc@PLT
	movl	p1@GOT(%ebx), %edx
	movl	%eax, (%edx)
	movl	$256, (%esp)
	call	malloc@PLT
	movl	p2@GOT(%ebx), %edx
	movl	%eax, (%edx)
	movl	$268435456, (%esp)
	call	malloc@PLT
	movl	p3@GOT(%ebx), %edx
	movl	%eax, (%edx)
	movl	$256, (%esp)
	call	malloc@PLT
	movl	p4@GOT(%ebx), %edx
	addl	$16, %esp
	movl	%eax, (%edx)
	leal	-8(%ebp), %esp
	xorl	%eax, %eax
	popl	%ecx
	.cfi_restore 1
	.cfi_def_cfa 1, 0
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.comm	p4,4,4
	.comm	p3,4,4
	.comm	p2,4,4
	.comm	p1,4,4
	.comm	beyong,4,4
	.section	.text.__x86.get_pc_thunk.bx,"axG",@progbits,__x86.get_pc_thunk.bx,comdat
	.globl	__x86.get_pc_thunk.bx
	.hidden	__x86.get_pc_thunk.bx
	.type	__x86.get_pc_thunk.bx, @function
__x86.get_pc_thunk.bx:
.LFB2:
	.cfi_startproc
	movl	(%esp), %ebx
	ret
	.cfi_endproc
.LFE2:
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
