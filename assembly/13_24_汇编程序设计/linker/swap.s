
swap.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <swap>:
   0:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 7 <swap+0x7>
   7:	8b 10                	mov    (%rax),%edx
   9:	8b 0d 00 00 00 00    	mov    0x0(%rip),%ecx        # f <swap+0xf>
   f:	89 08                	mov    %ecx,(%rax)
  11:	89 15 00 00 00 00    	mov    %edx,0x0(%rip)        # 17 <swap+0x17>
  17:	c3                   	retq   
