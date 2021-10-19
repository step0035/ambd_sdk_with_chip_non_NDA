#!/usr/bin/env bash

#   ./build.sh {MATTER DIR} {BUILD METHOD} {OUTPUT DIR}

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

## AMEBA_MATTER to be exported or manually keyed in.
if [ ! -z ${AMEBA_MATTER} ]; then
    echo "Matter SDK is located at: ${AMEBA_MATTER}"
elif [ -d "$1" ]; then
    echo "Matter SDK is located at: "$1""
    export AMEBA_MATTER="$1"
else
    echo "Error: Unknown path for Matter SDK."
    exit
fi
export MATTER_CONFIG_PATH=${AMEBA_MATTER}/config/ameba
export MATTER_EXAMPLE_PATH=${AMEBA_MATTER}/examples/all-clusters-app/ameba

## Check output directory
if [ ! -z "$3" ]; then
    export MATTER_OUTPUT="$3"
    mkdir -p "$MATTER_OUTPUT"
fi
cd "$MATTER_OUTPUT"

function exe_cmake()
{
	cmake $CMAKE_ROOT -G"$BUILD_METHOD" -DCMAKE_TOOLCHAIN_FILE=$CMAKE_ROOT/toolchain.cmake
}

## Decide meta build method
if [[ "$2" == "ninja" || "$2" == "Ninja" ]]; then
	BUILD_METHOD="Ninja"
	exe_cmake
	#ninja
else
	BUILD_METHOD="Unix Makefiles"
    exe_cmake
	#make
fi

## Copy bootloaders
if [ ! -d "$MATTER_OUTPUT/asdk/bootloader" ]; then
        mkdir -p $MATTER_OUTPUT/asdk/bootloader
fi

if [ -a "$LP_IMAGE/km0_boot_all.bin" ]; then
    cp $LP_IMAGE/km0_boot_all.bin $MATTER_OUTPUT/asdk/bootloader/km0_boot_all.bin
else
    echo "Error: km0_boot_all.bin can not be found."
fi

if [ -a "$HP_IMAGE/km4_boot_all.bin" ]; then
    cp $HP_IMAGE/km4_boot_all.bin $MATTER_OUTPUT/asdk/bootloader/km4_boot_all.bin
else
    echo "Error: km4_boot_all.bin can not be found."
fi
