cmake_minimum_required(VERSION 3.6)

project(file_system)

set(dir_fatfs "${sdk_root}/component/common/file_system/fatfs")
set(dir_ftl "${sdk_root}/component/common/file_system/ftl")

message(STATUS "Building \"${target}\" folder")

list(
    APPEND ${list}

    # fatfs
    ${dir_fatfs}/disk_if/src/sdcard.c
	${dir_fatfs}/disk_if/src/usbdisk.c
	${dir_fatfs}/disk_if/src/flash_fatfs.c
	${dir_fatfs}/r0.10c/src/ff.c
	${dir_fatfs}/r0.10c/src/diskio.c
	${dir_fatfs}/r0.10c/src/option/ccsbcs.c
	${dir_fatfs}/fatfs_ext/src/ff_driver.c

)

if(${CONFIG_BT_EN})
list(
    APPEND ${list}
    # ftl
    ${dir_ftl}/ftl.c
)
endif()


#target_include_directories(
#    ${target}
#    PUBLIC
#    ${sdk_root}/component/common/drivers/usb/host/msc/inc
#    ${sdk_root}/component/common/drivers/sdio/realtek/sdio_host/inc
#)
