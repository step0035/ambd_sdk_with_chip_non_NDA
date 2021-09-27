cmake_minimum_required(VERSION 3.6)

project(project)

set(sdk_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../../../../..")
set(prj_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../../..")
set(dir_library "${CMAKE_CURRENT_SOURCE_DIR}/library")
set(dir_sram "${CMAKE_CURRENT_SOURCE_DIR}/sram")
set(dir_xip "${CMAKE_CURRENT_SOURCE_DIR}/xip")
set(dir_src_hp "${prj_root}/src/src_hp")
set(target project)
set(list project_sources)

message(STATUS "Building \"${target}\" folder")

add_library(
    # library
    _user
    STATIC
    ${dir_library}/lib_user_test.c
)

add_custom_command(
    TARGET _user
    POST_BUILD
    COMMAND mv -f lib_user.a ${CMAKE_CURRENT_SOURCE_DIR}/../../lib/application
)

add_executable(
    # src
    project_src
    ${dir_src_hp}/main.c
)

add_custom_command(
    TARGET project_src
    POST_BUILD
    COMMAND find ${dir_src_hp} -type f -regex '.*\(\.i\|\.d\|\.s\|\.su\|\.o\)' |xargs -i mv {} ./
)

list(
    APPEND ${list}

    # sram
    ${dir_sram}/ram_test.c

    # xip
    ${dir_xip}/xip_test.c
)

add_executable(
    ${target}
    ${project_sources}
)

