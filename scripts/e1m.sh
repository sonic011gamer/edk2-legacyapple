#!/bin/bash
# based on the instructions from edk2-platform
set -e
. ./scripts/build_common.sh
# not actually GCC5; it's GCC7 on Ubuntu 18.04.
GCC5_ARM_PREFIX=arm-linux-gnueabi- build -j$(nproc) -s -n 0 -a ARM -t GCC5 -p MSM8909Pkg/Devices/e1m.dsc
./scripts/build_bootshim.sh
cat BootShim/BootShim.bin workspace/Build/MSM8909Pkg/DEBUG_GCC5/FV/MSM8909PKG_UEFI.fd > workspace/bootpayload.bin
gzip -c < workspace/bootpayload.bin > workspace/MSM8909_UEFI.fd.gz
cat workspace/MSM8909_UEFI.fd.gz device_specific/e1m.dtb > workspace/e1m-kernel
./scripts/mkbootimg --kernel=workspace/e1m-kernel --output=workspace/E1M.img --cmdline="EDK2" --base=0x80000000