cmake_minimum_required(VERSION 3.6)

project(wlan)

set(sdk_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../../../../..")
set(prj_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../../..")
set(dir "${sdk_root}/component/common/drivers/wlan/realtek/src/core/option")
set(target wlan)
set(list wlan_sources)

message(STATUS "Building \"${target}\" folder")

list(
    APPEND ${list}

    ${dir}/rtw_opt_rf_para_rtl8721d.c
)

add_executable(
    ${target}
    ${wlan_sources}
)
