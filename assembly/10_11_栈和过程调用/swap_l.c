/*
 *  gcc -Og -S swap_l.c
 *  use stack to store the array
 */

void swap_l(long *xp, long *yp)
{
    volatile long loc[128];
    loc[0] = *xp;
    loc[1] = *yp;
    *xp = loc[1];
    *yp = loc[0];
}
