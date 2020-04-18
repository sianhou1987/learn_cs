1.  as write.s -o write.o
    as read.s -o read.o
    ld -shared write.o read.o -o librecord.so
2.  as write_records.s -o write_records.o
    ld -L . -dynamic-linker /lib/ld-linux.so.2 -o write_records -lrecord write_records.o

- -L .: 表示路径, .表示当前路径
- -dynamic-linker /lib/ld-linux.so.2: dynamic linker
- 默认路径为，首先LD_LIBRARY_PATH; 其次/etc/ld.so.conf中列出的目录; 再次/usr/lib/ 和 /lib/ 等。

