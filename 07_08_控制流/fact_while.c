/*
 *  CSAPP Figure 3.20
 *  jump to middle:
 *      gcc -Og -S fact_while.c -o fact_while_Og.s
 *  guarded do:
 *      gcc -O1 -S fact_while.c -o fact_while_O1.s
 */

long fact_while(long n)
{
    long result = 1;
    while (n > 1) {
        result *= n;
        n = n - 1;
    }
    return result;
}