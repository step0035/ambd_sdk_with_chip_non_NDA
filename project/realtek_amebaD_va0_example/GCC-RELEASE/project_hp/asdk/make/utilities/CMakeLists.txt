cmake_minimum_required(VERSION 3.6)

project(utilities)

set(sdk_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../../../../..")
set(prj_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../../..")
set(dir "${sdk_root}/component/common/utilities")
set(target utilities)
set(list utilities_sources)

message(STATUS "Building \"${target}\" folder")

list(
    APPEND ${list}

    ${dir}/tcptest.c 
	${dir}/ssl_client.c 
	${dir}/ssl_client_ext.c 
	${dir}/http_client.c 
	${dir}/xml.c 
	${dir}/cJSON.c 
	${dir}/chip_porting.c 
)

add_executable(
    ${target}
    ${utilities_sources}
)

target_include_directories(
    ${target}
    PUBLIC
    ${sdk_root}/component/common/network/libcoap/include
)
