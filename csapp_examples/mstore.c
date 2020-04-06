/*
 *  1.  gcc -Og -S mstore.c
 *  2.  gcc -Og -c mstore.c
 *      objdump -d mstore.o
 *  3.  gcc -Og -S -masm=intel mstore.c
 */

long mult2(long, long);

void multstore(long x, long y, long *dest)
{
    long t = mult2(x, y);
    *dest = t;
}