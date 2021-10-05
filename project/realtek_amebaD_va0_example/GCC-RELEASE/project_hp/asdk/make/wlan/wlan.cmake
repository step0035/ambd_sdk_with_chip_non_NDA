cmake_minimum_required(VERSION 3.6)

project(wlan)

set(dir "${sdk_root}/component/common/drivers/wlan/realtek/src/core/option")

list(
    APPEND ${list}

    ${dir}/rtw_opt_rf_para_rtl8721d.c
)

