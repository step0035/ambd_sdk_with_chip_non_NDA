cmake_minimum_required(VERSION 3.6)

project(project)

set(dir_library "${CMAKE_CURRENT_SOURCE_DIR}/library")
set(dir_sram "${CMAKE_CURRENT_SOURCE_DIR}/sram")
set(dir_xip "${CMAKE_CURRENT_SOURCE_DIR}/xip")
set(dir_src_hp "${prj_root}/src/src_hp")

list(
    APPEND ${list}

    # sram
    #${dir_sram}/ram_test.c #cannot find

    # xip
    #${dir_xip}/xip_test.c #cannot find

	# main.c
    ${dir_src_hp}/main.c
)


