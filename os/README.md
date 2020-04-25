# OS
### Tsinghua ros
- http://os.cs.tsinghua.edu.cn/oscourse/FrontPage
- https://github.com/chyyuu/os_course_info
- https://rcore-os.github.io/rCore_tutorial_doc/
- https://piazza.com/tsinghua.edu.cn/spring2015/30240243x/home#

### Blog os
- https://os.phil-opp.com/

### 佐治亚理工学院 CS-3210
- https://tc.gts3.org/cs3210/2020/spring/lab.html

### Stanford’s CS140e Winter 2018 course
- https://cs140e.sergio.bz/

## dev_nostd
- for linux: 
``` shell
$ cargo rustc -- -C link-arg=-nostartfiles
```
- for windows: 
``` shell
$ cargo rustc -- -C link-args="/ENTRY:_start /SUBSYSTEM:console"
```
- for macos: 
``` shell
$ cargo rustc -- -C link-args="-e __start -static -nostartfiles"
```

## dev_minicore

https://rcore-os.github.io/rCore_tutorial_doc/chapter2/introduction.html

### create a json file
for linux
``` shell
$ rustc -Z unstable-options --print target-spec-json --target x86_64-unknown-linux-gnu
```

for rsic-v
``` shell
$ rustc -Z unstable-options --print target-spec-json --target riscv64imac-unknown-none-elf
```

### complie
``` shell
$ rustup target add riscv64imac-unknown-none-elf // run once
$ cargo build --target riscv64imac-unknown-none-elf
```

### objdump
``` shell
rust-objdump .\target\riscv64imac-unknown-none-elf\debug\ros -x --arch-name=riscv64
rust-objdump .\target\riscv64imac-unknown-none-elf\debug\ros -d --arch-name=riscv64
```

### create binary file
``` shell
$ rust-objcopy .\target\riscv64imac-unknown-none-elf\debug\ros --strip-all -O binary .\target\riscv64imac-unknown-none-elf\debug\kernel.bin
```
这里 ```--strip-all``` 表明丢弃所有符号表及调试信息，```-O binary``` 表示输出为二进制文件。

### run
``` shell
$ qemu-system-riscv64 -machine virt -nographic -bios default -device loader,file=.\target\riscv64imac-unknown-none-elf\debug\kernel.bin,addr=0x80200000
```