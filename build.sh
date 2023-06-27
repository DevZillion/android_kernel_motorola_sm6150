#!/bin/bash


pathtoclang=$(pwd)/clang
pathtogcc=$(pwd)/aarch64-linux-android-4.9
path=$(pwd)



cd $path
git clone https://github.com/RaghuVarma331/aarch64-linux-android-4.9.git -b master --depth=1 aarch64-linux-android-4.9
git clone https://github.com/RaghuVarma331/clang.git -b android-11.0 --depth=1 clang
clear

if [ -f $path/drivers/kernelsu ]
then
    echo "The KernelSU driver is already installed, skipping the setup."
else
    curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -
fi

make O=out ARCH=arm64 hanoip_defconfig
PATH=$pathtoclang/bin:$pathtogcc/bin:${PATH} \
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android-
