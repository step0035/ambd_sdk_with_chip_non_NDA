cmake_minimum_required(VERSION 3.6)

project(app)

set(dir "${sdk_root}/component/soc/realtek/amebad/app")

list(
    APPEND ${list}

    # monitor
    ${dir}/monitor/ram/monitor_hp.c
    ${dir}/monitor/ram/shell_ram.c
    ${dir}/monitor/ram/rtl_trace.c
    ${dir}/monitor/rom/shell_rom.c
    ${dir}/monitor/rom/monitor_rom.c
    ${dir}/monitor/ram/low_level_io.c

    # touch_key
    ${dir}/touch_key/touch_key.c
)


#target_include_directories(
#    ${target}
#    PUBLIC
#    ${dir}/../include
#)
