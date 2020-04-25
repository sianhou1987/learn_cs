#![no_std]  // don't link the Rust standard library
#![no_main] // disable all Rust-level entry points

use core::panic::PanicInfo;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

#[no_mangle] // don't mangle the name of this function
pub extern "C" fn _start() -> ! {
    // this function is the entry point, since the linker looks for a function named `_start` by default
    loop {}
}


// for linux: cargo rustc -- -C link-arg=-nostartfiles
// for windows: cargo rustc -- -C link-args="/ENTRY:_start /SUBSYSTEM:console"
// for macos: cargo rustc -- -C link-args="-e __start -static -nostartfiles"