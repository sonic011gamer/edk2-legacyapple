cd BootShim
rm BootShim.bin
make UEFI_BASE=0x84000000 UEFI_SIZE=0x00A20000
rm BootShim.elf
cd ..
