#!/bin/bash

# This script runs the built binary

qemu-system-x86_64 -fda build/disk.img
