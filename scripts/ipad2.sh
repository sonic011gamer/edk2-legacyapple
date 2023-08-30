#!/bin/bash
# based on the instructions from edk2-platform
set -e
. ./scripts/build_common.sh
# not actually GCC5; it's GCC7 on Ubuntu 18.04.
GCC5_ARM_PREFIX=arm-linux-gnueabi- build -j$(nproc) -s -n 0 -a ARM -t GCC5 -p APPLEPkg/Devices/ipad2.dsc
cat BootShim/BootShim.bin workspace/Build/APPLEPkg/DEBUG_GCC5/FV/APPLEPKG_UEFI.fd > workspace/ipad2.bin