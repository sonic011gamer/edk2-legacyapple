#!/bin/bash
set -e
sudo apt update
sudo apt install -y build-essential uuid-dev iasl git nasm crossbuild-essential-armel crossbuild-essential-armhf bc
curdir="$PWD"
cd ..
git clone https://github.com/tianocore/edk2.git -b edk2-stable202302 --recursive
git clone https://github.com/tianocore/edk2-platforms.git
cd "$curdir"
git submodule init
chmod +x ./scripts/firstrun.sh && ./scripts/firstrun.sh
chmod +x ./scripts/build_bootshim.sh && ./scripts/build_bootshim.sh
chmod +x ./scripts/iphone5.sh && ./scripts/iphone5.sh
chmod +x ./scripts/ipad2.sh && ./scripts/ipad2.sh
