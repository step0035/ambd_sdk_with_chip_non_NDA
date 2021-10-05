cmake_minimum_required(VERSION 3.6)

project(drivers)

set(dir_inic "${sdk_root}/component/common/drivers/inic/rtl8721d")
set(dir_usoc "${sdk_root}/component/common/drivers/usoc/auto_install")
set(dir_si "${sdk_root}/component/common/drivers/si")
set(dir_ir "${sdk_root}/component/common/drivers/ir/protocol")

# temporary settings of macro
set(CONFIG_INIC_EN OFF)     #unable to find file
set(CONFIG_INIC_SDIO_HCI OFF)
set(CONFIG_INIC_USB_HCI OFF)
set(CONFIG_USB_AUTOINSTALL_ENABLED OFF) #unable to find file

list(
    APPEND ${list}

    # si
    ${dir_si}/rl6548.c

    # ir
    ${dir_ir}/ir_nec_protocol.c
    ${dir_ir}/ir_led.c
)

if(CONFIG_INIC_EN AND CONFIG_INIC_SDIO_HCI)
list(
    APPEND ${list}
    # inic
    ${dir_inic}/inic_sdio_device.c
)
endif()

if(CONFIG_INIC_EN AND CONFIG_INIC_USB_HCI)
list(
    APPEND ${list}
    # inic
    ${dir_inic}/inic_usb_device.c
)
endif()

if(CONFIG_USB_AUTOINSTALL_ENABLED)
list(
    APPEND ${list}
    # usoc
    ${dir_usoc}/usoc_scsi.c
)
endif()


#target_include_directories(
#    ${target}
#    PUBLIC
#    ${dir_si}
#if(${CONFIG_USB_AUTOINSTALL_ENABLED})
#    ${dir_usoc}
#endif()
#)
