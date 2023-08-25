#!/bin/bash
# based on the instructions from edk2-platform
set -e
. ./scripts/build_common.sh
# not actually GCC5; it's GCC7 on Ubuntu 18.04.
GCC5_ARM_PREFIX=arm-linux-gnueabi- build -j$(nproc) -s -n 0 -a ARM -t GCC5 -p MSM8909Pkg/Devices/y560.dsc
./scripts/build_bootshim.sh
cat BootShim/BootShim.bin workspace/Build/MSM8909Pkg/DEBUG_GCC5/FV/MSM8909PKG_UEFI.fd > workspace/bootpayload.bin
./scripts/mkbootimg --kernel=workspace/bootpayload.bin --output=workspace/Y560.img --cmdline="EDK2" --qcdt=device_specific/y560.dtb --base=0x80000000