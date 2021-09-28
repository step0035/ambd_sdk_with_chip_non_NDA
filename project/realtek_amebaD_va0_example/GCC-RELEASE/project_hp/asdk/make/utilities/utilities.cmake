cmake_minimum_required(VERSION 3.6)

project(utilities)

set(dir "${sdk_root}/component/common/utilities")

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


#target_include_directories(
#    ${target}
#    PUBLIC
#    ${sdk_root}/component/common/network/libcoap/include
#)
