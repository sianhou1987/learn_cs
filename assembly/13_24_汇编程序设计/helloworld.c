/*
 *  gcc -S -O2 -m32 helloworld.c -o helloworld.s1
 *  gcc -S -O2 -m32 -mpreferred-stack-boundary=2 helloworld.c -o helloworld.s2
 *  gcc -S -O2 -m32 -mpreferred-stack-boundary=2 -fomit-frame-pointer helloworld.c -o helloworld.s3
 */

#include <stdlib.h>
#include <stdio.h>

int main()
{
    printf("Hello world\n");
    exit(0);

    return 0;
}