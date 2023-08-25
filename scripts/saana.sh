#!/bin/bash
# based on the instructions from edk2-platform
set -e
. ./scripts/build_common.sh
# not actually GCC5; it's GCC7 on Ubuntu 18.04.
GCC5_ARM_PREFIX=arm-linux-gnueabi- build -j$(nproc) -s -n 0 -a ARM -t GCC5 -p MSM8909Pkg/Devices/saana.dsc
arm-linux-gnueabi-objcopy -I binary -O elf32-littlearm --binary-architecture arm workspace/Build/MSM8909Pkg/DEBUG_GCC5/FV/MSM8909PKG_UEFI.fd workspace/MSM8909Pkg_UEFI.fd.elf && arm-linux-gnueabi-ld workspace/MSM8909Pkg_UEFI.fd.elf -T scripts/FvWrapper.ld -o workspace/emmc_appsboot.mbn
