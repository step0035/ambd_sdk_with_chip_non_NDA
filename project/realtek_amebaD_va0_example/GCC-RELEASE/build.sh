#!/usr/bin/env bash

#   ./build.sh ninja

BUILD_FILE_DIR=`test -d ${0%/*} && cd ${0%/*}; pwd`
CMAKE_ROOT=$BUILD_FILE_DIR/project_hp
LP_IMAGE=$BUILD_FILE_DIR/project_lp/asdk/image
HP_IMAGE=$BUILD_FILE_DIR/project_hp/asdk/image

## Unzip toolchain
cd $CMAKE_ROOT/toolchain
mkdir linux
if [ -z "$(ls -A $CMAKE_ROOT/toolchain/linux)" ]; then
   cat asdk/asdk-9.3.0-linux-newlib-build-3483-x86_64.tar.bz2.part* > asdk/asdk-9.3.0-linux-newlib-build-3483-x86_64.tar.bz2
    tar -jxvf asdk/asdk-9.3.0-linux-newlib-build-3483-x86_64.tar.bz2 -C linux/
    rm asdk/asdk-9.3.0-linux-newlib-build-3483-x86_64.tar.bz2
else
   echo "Toolchain $(ls -A $CMAKE_ROOT/toolchain/linux) is found at $CMAKE_ROOT/toolchain/linux."
fi

##CHIP_PATH to be defined in MATTER SDK
if [ ! -z ${CHIP_PATH} ]; then
    echo "CHIP_PATH is located at: ${CHIP_PATH}" 
else
    echo "Error: CHIP_PATH does not defined."
    exit
fi
export CHIP_CONFIG_PATH=${CHIP_PATH}/config/ameba
export CHIP_EXAMPLE_PATH=${CHIP_PATH}/examples/all-clusters-app/ameba

cd $CHIP_PATH
if [ ! -d "out" ]; then
    mkdir out
fi
cd out

function exe_cmake()
{
	cmake $CMAKE_ROOT -G"$BUILD_METHOD" -DCMAKE_TOOLCHAIN_FILE=$CMAKE_ROOT/toolchain.cmake
}

if [[ "$1" == "ninja" || "$1" == "Ninja" ]]; then
	BUILD_METHOD="Ninja"
	exe_cmake
	ninja
else
	BUILD_METHOD="Unix Makefiles"
    exe_cmake
	make
fi

if [ -a "$LP_IMAGE/km0_boot_all.bin" ]; then
    cp $LP_IMAGE/km0_boot_all.bin $CHIP_PATH/out/asdk/image/km0_boot_all.bin
else
    echo "Error: km0_boot_all.bin can not be found." 
fi

if [ -a "$HP_IMAGE/km4_boot_all.bin" ]; then
    cp $HP_IMAGE/km4_boot_all.bin $CHIP_PATH/out/asdk/image/km4_boot_all.bin
else
    echo "Error: km4_boot_all.bin can not be found."
fi

