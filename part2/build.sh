#!/bin/bash
# Build script for the bootloader and kernel from the tutorial on Maya's Blog: https://www.mayabruin.com

# Check if there is a bootloader directory and a kernel directory
if [ -d "./bootloader" ] && [ -d "./kernel" ] 
then
	echo "Found bootloader and kernel folders..."

	# Check if a bootloader file is present
	if [ -f ./bootloader/bootloader.asm ] 
	then
		echo "Found bootloader"

	else
		echo "No bootloader file found!"
		exit 2
	fi

else
	echo "Could not find bootloader and kernel folders!"
	exit 1
fi

# Check if there is a previous build, if so remove it
if [ -d "./build" ]
then
	rm -r "./build"
fi

mkdir build

# Build the bootloader
nasm -f bin bootloader/bootloader.asm -o build/bootloader.bin

# Use cargo to build the kernel
cd kernel
cargo build --release
cd ../

# Copy built kernel over
cp kernel/target/target/release/kernel build/

# Use objcopy to convert elf file to binary
objcopy -O binary build/kernel build/kernel.bin

# Concatenate bootloader and kernel
cat build/bootloader.bin build/kernel.bin > build/disk.img
