cmake_minimum_required(VERSION 3.6)

project(cmsis)

set(sdk_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../../../../..")
set(prj_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../../..")
set(dir "${sdk_root}/component/soc/realtek/amebad/cmsis/source")


set(target cmsis)
set(list cmsis_sources)

message(STATUS "Building \"${target}\" folder")

list(
    APPEND ${list}

    # cmsis
    ${dir}/mpu_config.c
)

add_executable(
    ${target}
    ${cmsis_sources}
)

add_custom_command(
    TARGET ${target} POST_BUILD
    COMMAND ${FROMELF} --rename-section .rodata.str1.4=.boot.rodata.str1.4 mpu_config.o mpu_config.o
    
)
