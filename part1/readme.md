# Part 1: a minimal "bootloader"

This is the code for part 1 of the blog series.

## Building and running the binary

First, install nasm and qemu if you haven't done so already:

On ubuntu:
```
> sudo apt-get install -y nasm qemu
```

On arch based linux:
```
> sudo pacman -S nasm qemu
```

To build the binary, run the following command:

```
> nasm -f bin boot_minimal.asm -o boot_minimal.bin
```

Finally, to run the created binary:
```
> qemu-system-x86_64 -fda boot_minimal.bin
```
