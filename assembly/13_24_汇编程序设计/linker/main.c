//  gcc -c -Og main.c
//  objdump -d main.o > main.s

int buf[2] = {1, 2};

int main()
{
    swap();
    return 0;
}