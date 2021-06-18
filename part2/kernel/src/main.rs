#![no_std]
#![no_main]

use core::panic::PanicInfo;

static HELLO: &[u8] = b"Hello Rust!";

// Colors
const RED: u8 = 0x4;
const ORANGE: u8 = 0x6; // Officially this is brown, but it is the closest we get in the 16 color palette
const YELLOW: u8 = 0xe;
const GREEN: u8 = 0x2;
const BLUE: u8 = 0x3; // this is cyan, but same as above
const INDIGO: u8 = 0x5; // magenta, but same as above

// Color array
const COLORS_LEN: usize = 6;
const COLORS: [u8; COLORS_LEN] = [RED, ORANGE, YELLOW, GREEN, BLUE, INDIGO];

#[no_mangle]
pub extern "C" fn _start() -> ! {
    let vga_buffer = 0xb8000 as *mut u8;

    for (i, &byte) in HELLO.iter().enumerate() {
        unsafe {
            *vga_buffer.offset(i as isize * 2) = byte; // set 
            *vga_buffer.offset(i as isize * 2 + 1) = COLORS[i % COLORS_LEN]; // Set color byte
        }
    }

    loop {}
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
