cmake_minimum_required(VERSION 3.6)

project(mbed)

set(sdk_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../../../../..")
set(prj_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../../..")
set(dir "${sdk_root}/component/common/mbed/targets/hal/rtl8721d")
set(target mbed)
set(list mbed_sources)

# temporary setting of macro
set(CONFIG_MBED_API_EN ON)

message(STATUS "Building \"${target}\" folder")

if(${CONFIG_MBED_API_EN})
list(
    APPEND ${list}

    ${dir}/pinmap_common.c
    ${dir}/sys_api.c
    ${dir}/us_ticker.c
    ${dir}/timer_api.c
    ${dir}/dma_api.c
    ${dir}/gpio_api.c
    ${dir}/gpio_irq_api.c
    ${dir}/pinmap.c
    ${dir}/port_api.c
    ${dir}/spi_api.c
    ${dir}/serial_api.c
    ${dir}/i2c_api.c
    ${dir}/i2s_api.c
    ${dir}/pwmout_api.c
    ${dir}/analogin_api.c
    ${dir}/efuse_api.c
    ${dir}/sleep.c
    ${dir}/wdt_api.c
    ${dir}/spdio_api.c
    ${dir}/us_ticker_api.c
    ${dir}/wait_api.c
    ${dir}/rtc_api.c
    ${dir}/captouch_api.c
    ${dir}/keyscan_api.c
    ${dir}/lcdc_api.c
)
endif()

add_executable(
    ${target}
    ${mbed_sources}
)
