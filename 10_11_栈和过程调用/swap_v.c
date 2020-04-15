/*
 *  gcc -Og -S swap_v.c
 *  without volatile, use registers directly.
 */

void swap_v(long *xp, long *yp)
{
    long loc[128];
    loc[0] = *xp;
    loc[1] = *yp;
    *xp = loc[1];
    *yp = loc[0];
}
