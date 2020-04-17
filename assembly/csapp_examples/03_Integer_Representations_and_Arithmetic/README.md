- 0
 references:
 http://www.cs.cmu.edu/afs/cs/academic/class/15213-f15/www/schedule.html
 https://www.bilibili.com/video/BV1Jb411J749?p=3
 CSAPP

- 1
```shell
/usr/include/stdio.h:27:10: fatal error: bits/libc-header-start.h: No such file or directory
 #include <bits/libc-header-start.h>
```
``` shell
sudo apt-get install gcc-multilib # ubuntu
```

- 2 CSAPP Practice Problem 2.23
```c
// Extract the low-order 8 bits of the argument,
// and return an interger ranging between 0 and 255.
int fun1(unsigned word) {
    return (int) ((word << 24) >> 24);
}

// Extract the low-order 8 bits of the argument,
// perform sign extension,
// and return an interger ranging between -128 and 127.
int fun2(unsigned word) {
    return ((int)word << 24) >> 24;
}
```

- 3 Usually, we should us signed integer as much as possible since unsigned integer many cause some subtle bugs. Some high-level language, such as Java, only has signed integer. Unsigend integer are useful when we think of words as just collections of bits with no numeric imterpretation. 