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

###phase 4:
write the func4, show the answer is 7 0
```c
/*

  40103a:	ba 0e 00 00 00       	mov    $0xe,%edx
  40103f:	be 00 00 00 00       	mov    $0x0,%esi
  401044:	8b 7c 24 08          	mov    0x8(%rsp),zzzz


0000000000400fce <func4>:
  400fce:	48 83 ec 08          	sub    $0x8,%rsp
  400fd2:	89 d0                	mov    xxxx,t1                
  400fd4:	29 f0                	sub    yyyy,t1      
  400fd6:	89 c1                	mov    t1,t2
  400fd8:	c1 e9 1f             	shr    $0x1f,t2
  400fdb:	01 c8                	add    t2,t1
  400fdd:	d1 f8                	sar    t1
  400fdf:	8d 0c 30             	lea    (t1,yyyy,1),t2
  400fe2:	39 f9                	cmp    zzzz,t2
  400fe4:	7e 0c                	jle    400ff2 <func4+0x24>
  400fe6:	8d 51 ff             	lea    -0x1(t2),xxxx
  400fe9:	e8 e0 ff ff ff       	callq  400fce <func4>
  400fee:	01 c0                	add    t1,t1
  400ff0:	eb 15                	jmp    401007 <func4+0x39>
  400ff2:	b8 00 00 00 00       	mov    $0x0,t1
  400ff7:	39 f9                	cmp    zzzz,t2
  400ff9:	7d 0c                	jge    401007 <func4+0x39>
  400ffb:	8d 71 01             	lea    0x1(t2),yyyy
  400ffe:	e8 cb ff ff ff       	callq  400fce <func4>
  401003:	8d 44 00 01          	lea    0x1(t1,t1,1),t1
  401007:	48 83 c4 08          	add    $0x8,%rsp
  40100b:	c3                   	retq  
*/

#include <stdio.h>

int func4(int *x, int *y, int z) {
    int t1 = *x - *y;
    int t2 = (t1 >> 31);
    t1 = ((t1 + t2) >> 1);
    t2 = t1 + *y;
    if (t2 <= z) {
        t1 = 0;
        if (t2 >= z) {
            return t1;       
        } else {
            *y = t2 + 1;
            func4(x, y, z);
            t1 = 2 * t1 + 1;                  
        }
    } else {
        *x = t2 - 1;
        func4(x, y, z);
        t1 += t1;
        return t1;
    }
}

int main() {
    int i;
    for (i = 0; i <= 20; ++i) {
        int x = 14, y = 0;
        printf("i=%d, f=%d\n", i, func4(&x, &y, i));    
    }
}
```

### phase_5:
```assembly
  40108b:	0f b6 0c 03          	movzbl (%rbx,%rax,1),%ecx       // ecx = s[0]
  40108f:	88 0c 24             	mov    %cl,(%rsp)               // (rsp)   = s[0]
  401092:	48 8b 14 24          	mov    (%rsp),%rdx              // rdx = (rsp)
  401096:	83 e2 0f             	and    $0xf,%edx                // low 4 bits
  401099:	0f b6 92 b0 24 40 00 	movzbl 0x4024b0(%rdx),%edx      // edx = 0x4024b0 + rdx
  4010a0:	88 54 04 10          	mov    %dl,0x10(%rsp,%rax,1)    // push dl
  4010a4:	48 83 c0 01          	add    $0x1,%rax
  4010a8:	48 83 f8 06          	cmp    $0x6,%rax
```
1. from the address x /s 0x4024b0, the string is
"maduiersnfotvbylSo you think you can stop the bomb with ctrl-c, do you?"

2. from the <strings_not_equal> and information of %rdi and %rsi, the code is "flyers"

3. compare
"maduiersnfotvbylSo you think you can stop the bomb with ctrl-c, do you?"
"0123456789abcdef"
the low 4 bits are "9fe567"

4. an available code is "YONUFG"

### phase_6
1. before 40116a, we can see that we need 6 numbers and < 7;
2. from address 0x4011da, and x/x 0x6032d0 + i*0x10 (i=0..5): we know that each input number corresponds a new number
    1 -> 433
    2 -> 477
    3 -> 691
    4 -> 924
    5 -> 168
    6 -> 332
3. we need resort the input number to make sure that the calculate number is sorted from small to big, so the answer is 4 3 2 1 6 5
