1.  objdump -d bomb > bomb.s
2.  gdb bomb
3.  disas phase_1
4.  b *0x400ee4
5.  r args
6.  info reg rax
7.  x /x 0x0123
8.  ni / si / c

### phase_1
1. from 
``` assembly
400e2d:	e8 de fc ff ff       	callq  400b10 <puts@plt>
400e32:	e8 67 06 00 00       	callq  40149e <read_line>
400e37:	48 89 c7             	mov    %rax,%rdi
```
we know the address of input string is stored in %rdi.

2. and from
``` assembly
400ee4:	be 00 24 40 00       	mov    $0x402400,%esi
400ee9:	e8 4a 04 00 00       	callq  401338 <strings_not_equal>
```
the answer is store in $0x402400

3. 
```assembly
x /s 0x402400
```
the answer is "Border relations with Canada have never been better."

### phase_2
%rax & %rdi store the address of input string
```assembly
400f17:	8b 43 fc             	mov    -0x4(%rbx),%eax
400f1a:	01 c0                	add    %eax,%eax
400f1c:	39 03                	cmp    %eax,(%rbx)
```
s[i] = 2 * s[i-1];
the answer is "1 2 4 8 16 32"

### phase_3
rsp + 0x8 = first
rsp + 0x12 = second
eax = first
eax > 1
eax < 7
```c
switch s[0] 
{
	case 2: 707; break;
	case 3: 256; break;
	case 4: 389; break;
	case 5: 206; break;
	case 6: 682; break;
}
```

### phase_4