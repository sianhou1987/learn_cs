global_asm!(include_str!("boot/entry64.asm"));

#[no_mangle]
pub extern "C" fn rust_main() -> ! {
    crate::interrupt::init();
    // 时钟初始化
    crate::timer::init();
    unsafe {
        llvm_asm!("ebreak"::::"volatile");
    }
    panic!("end of rust main");
    loop {}
}
