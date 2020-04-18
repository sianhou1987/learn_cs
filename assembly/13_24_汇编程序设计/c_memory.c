int beyong;
char *p1, *p2, *p3, *p4;

int useless() { return 0; }

int main()
{
    p1 = malloc(1 << 28);   // 256mb
    p2 = malloc(1 << 8);    // 256b
    p3 = malloc(1 << 28);
    p4 = malloc(1 << 8);
}