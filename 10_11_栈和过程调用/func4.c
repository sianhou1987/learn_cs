#include <stdio.h>
/*
edx = x, esi = y;
  400fce:	48 83 ec 08          	sub    $0x8,%rsp                    
  400fd2:	89 d0                	mov    %edx,%eax                //  eax = 14
  400fd4:	29 f0                	sub    %esi,%eax                //  t1 = x - y;
  400fd6:	89 c1                	mov    %eax,%ecx                //  t2 = t1
  400fd8:	c1 e9 1f             	shr    $0x1f,%ecx               //  t2 = t2 >> 31
  400fdb:	01 c8                	add    %ecx,%eax                    t2 = t2 + t1
  400fdd:	d1 f8                	sar    %eax                     //  eax = 7
  400fdf:	8d 0c 30             	lea    (%rax,%rsi,1),%ecx       //  ecx = 7 
  400fe2:	39 f9                	cmp    %edi,%ecx                //  ecx - edi(s[0])
  400fe4:	7e 0c                	jle    400ff2 <func4+0x24>      
  400fe6:	8d 51 ff             	lea    -0x1(%rcx),%edx          //  edx = rcx - 1
  400fe9:	e8 e0 ff ff ff       	callq  400fce <func4>
  400fee:	01 c0                	add    %eax,%eax
  400ff0:	eb 15                	jmp    401007 <func4+0x39>
  400ff2:	b8 00 00 00 00       	mov    $0x0,%eax                //  eax = 0
  400ff7:	39 f9                	cmp    %edi,%ecx                //  ecx >= edi(s[0])
  400ff9:	7d 0c                	jge    401007 <func4+0x39>      //  ecx >= edi
  400ffb:	8d 71 01             	lea    0x1(%rcx),%esi
  400ffe:	e8 cb ff ff ff       	callq  400fce <func4>
  401003:	8d 44 00 01          	lea    0x1(%rax,%rax,1),%eax
  401007:	48 83 c4 08          	add    $0x8,%rsp                //  
  40100b:	c3                   	retq   
*/
int func4(int *x, int *y, int z)
{
    int t1 = *x - *y;
    int t2 = (t1 >> 31);
    t1 += t2;
    t1 /= 2;
    t2 = t1 + *y;
    if (t2 <= z)
    {
        t1 = 0;
        if (t2 >= z)
        {
            return t1;
        }
        else
        {
            *y = t2 + 1;
            t1 = func4(x, y, z);
            t1 = t1 + t1 + 1;
            return t1;
        }
    }
    else
    {
        *x = t2 - 1;
        t1 = func4(x, y, z);
        t1 = t1 + t1;
        return t1;
    }
}
int main()
{
    int in;
    int x = 14, y = 0;
    for (int i = 0; i < 20; i++)
    {
        printf("i=%d, f=%d\n", i, func4(&x, &y, i));
    }
    return 0;
}