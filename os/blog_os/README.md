## 
``` shell
$ cargo install bootimage --version "^0.7.7"
$ rustup component add llvm-tools-preview
$ cargo xbuild
$ cargo bootimage
$ qemu-system-x86_64 -drive format=raw,file=target/x86_64-blog_os/debug/bootimage-blog_os.bin
```