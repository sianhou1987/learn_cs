/*
 *  gcc -Og -S swap_a.c
 *  use stack to store the array, 
 *  however don't need to move rsp 
 */

void swap_a(long *xp, long *yp)
{
    volatile long loc[2];
    loc[0] = *xp;
    loc[1] = *yp;
    *xp = loc[1];
    *yp = loc[0];
}
