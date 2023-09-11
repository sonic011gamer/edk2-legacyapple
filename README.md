Attempt to create a minimal EDK2 for APPLE ARM32 devices

## Status
Boots to UEFI shell (need to test again on iPad 2)

## Building
Tested on Ubuntu 22.04.

First, clone EDK2.

```
cd ..
git clone https://github.com/tianocore/edk2.git -b edk2-stable202302--recursive
git clone https://github.com/tianocore/edk2-platforms.git
```

You should have all three directories side by side.

Next, install dependencies:

20.04 or later:

```
sudo apt install build-essential uuid-dev iasl git nasm python3-distutils crossbuild-essential-armel
```

Also see [EDK2 website](https://github.com/tianocore/tianocore.github.io/wiki/Using-EDK-II-with-Native-GCC#Install_required_software_from_apt)

Then ./firstrun.sh

Finally, ./build.sh, or ./saana.sh if you are planning to test on the 650 with LK.

Then fastboot boot uefi.img from lk2nd.

# Credits
@ivoszbg for u-boot bringup which helped for Timer
SimpleFbDxe screen driver is from imbushuo's [Lumia950XLPkg](https://github.com/WOA-Project/Lumia950XLPkg).
