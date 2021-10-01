cmake_minimum_required(VERSION 3.6)

project(app_ntz)

enable_language(C ASM)

set(prj_root "${CMAKE_CURRENT_SOURCE_DIR}/../../..")
set(sdk_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../../..")
set(km0_image "${prj_root}/GCC-RELEASE/project_lp/asdk/image")
set(app_ntz application.ntz)
set(app_ntz_pure application.ntz_pure)
set(list app_ntz_sources)
set(list_inc_path app_ntz_inc)
set(list_c_flags app_ntz_flags)
set(list_code2sram code2sram)
set(list_code2sram_network code2sram_network)

set(freertos "freertos_v10.2.0")
set(lwip "lwip_v2.1.2")

set(utility_dir "${CMAKE_CURRENT_SOURCE_DIR}/gnu_utility")
set(prepend_tool "${utility_dir}/prepend_header.sh")
set(pad_tool "${utility_dir}/pad.sh")
set(image_tool "${utility_dir}/image_tool/imagetool.sh")

set(dir_chip "${sdk_root}/../connectedhomeip")
set(dir_chip_output "${dir_chip}/examples/all-clusters-app/ameba/build/chip")
get_filename_component(CHIP_ROOT ${dir_chip} REALPATH)

include(ExternalProject)

# build_info
include(config.cmake)

# build_target_folder
# prepare the target folder path...

# build sub folder
include(make/make.cmake)


# Build_lib lib_all : make_subdirs_lib
include(${CMAKE_CURRENT_SOURCE_DIR}/make/chip_main/chip_main.cmake)
#include(${CMAKE_CURRENT_SOURCE_DIR}/make/chip/chip.cmake)


#copy_ld_img2(ld/rlx8721d_img2_is.ld) copy_ld_img3
set( ld_script_layout ${CMAKE_CURRENT_SOURCE_DIR}/rlx8721d_layout_is.ld )
#combine
set( ld_script ${CMAKE_CURRENT_SOURCE_DIR}/rlx8721d_test.ld )

# HEADER FILE PATH
include(includepath.cmake)

add_executable(
	${app_ntz}
	${app_ntz_sources}
	#$<TARGET_OBJECTS:rom>
	#$<TARGET_OBJECTS:soc>
)

target_include_directories(
	${app_ntz}
	PUBLIC

	${inc_path}
	${app_ntz_inc}
	${prj_root}/src/src_hp
)

list(
	APPEND app_ntz_flags
	CONFIG_PLATFORM_8721D
	CONFIG_USE_MBEDTLS_ROM_ALG
	CONFIG_FUNCION_O0_OPTIMIZE
	DM_ODM_SUPPORT_TYPE=32
	MBEDTLS_CONFIG_FILE=\"mbedtls_config.h\"
	LWIP_IPV6_ROUTE_TABLE_SUPPORT=1
)

target_compile_definitions(
	${app_ntz}
	PRIVATE

	${app_ntz_flags}
)

target_link_libraries(
	${app_ntz}
	_application_hp
	_cmsis_dsp
	_dct
	_wlan
	_wps
	_httpc
	_httpd
	_mdns
	_tftp
	_usbd
	_usbh
	_user
	_websocket
	chip_main
	CHIP
	m
	stdc++
	c
	gcc
	nosys
)

set(TOOLCHAINDIR "${prj_root}/GCC-RELEASE/project_hp/toolchain")
set(ASDK_TOOLCHAIN "${TOOLCHAINDIR}/linux/asdk-9.3.0/linux/newlib")
target_link_options(
	${app_ntz}
	PUBLIC
	"LINKER:SHELL:-L ${ASDK_TOOLCHAIN}/lib"
	"LINKER:SHELL:-L ${CMAKE_CURRENT_SOURCE_DIR}/lib"
	"LINKER:SHELL:-L ${CMAKE_CURRENT_SOURCE_DIR}/lib/application"
	"LINKER:SHELL:-T ${ld_script}"
	"LINKER:SHELL:-Map=text.map"
)

add_custom_command(TARGET ${app_ntz} PRE_BUILD

	COMMAND echo > ram_size.txt
	COMMAND echo > obj_list.txt
    COMMAND mkdir -p ${dir_chip_output}
)

#RENAME CODE2SRAM
foreach(_file ${code2sram})
	string(CONCAT _file_obj ${CMAKE_CURRENT_BINARY_DIR} "/CMakeFiles/${app_ntz}.dir" ${_file_net} ".obj")
	add_custom_command(TARGET ${app_ntz} PRE_LINK
		COMMAND mkdir -p ${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/${app_ntz}.dir/${CMAKE_CURRENT_SOURCE_DIR}
		#COMMAND ${CMAKE_OBJCOPY} --rename-section .text=.image2.ram.text ${_file_obj} ${_file_obj}
	)
endforeach()

#RENAME NETWORK CODE2SRAM
foreach(_file_net ${code2sram_network})
	string(CONCAT _file_obj ${CMAKE_CURRENT_BINARY_DIR} "/CMakeFiles/${app_ntz}.dir" ${_file_net} ".obj")
	add_custom_command(TARGET ${app_ntz} PRE_LINK
		COMMAND mkdir -p ${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/${app_ntz}.dir/${CMAKE_CURRENT_SOURCE_DIR}
		#COMMAND ${CMAKE_OBJCOPY} --rename-section .text=.image2.net.ram.text ${_file_obj} ${_file_obj}
	)
endforeach()

#prepare ram_size.txt and obj_list.txt
foreach(_file ${app_ntz_sources})
	string(CONCAT _file_obj ${CMAKE_CURRENT_BINARY_DIR} "/CMakeFiles/${app_ntz}.dir" ${_file} ".obj")
	add_custom_command(TARGET ${app_ntz} PRE_LINK
		COMMAND mkdir -p ${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/${app_ntz}.dir/${CMAKE_CURRENT_SOURCE_DIR}
		#COMMAND ${CMAKE_SIZE} -t ${_file_obj} >> ram_size.txt
		#COMMAND echo ${_file_obj} >> obj_list.txt
	)
endforeach()

# FOR CHIP
# GN meta-build system arguments in the form of 'key1 = value1\nkey2 = value2...' string
string(APPEND CHIP_GN_ARGS)

list(
    APPEND CHIP_CFLAGS

    -DCHIP_PROJECT=1
    -DCONFIG_PLATFORM_8721D
    -DCONFIG_USE_MBEDTLS_ROM_ALG
    -DCONFIG_FUNCION_O0_OPTIMIZE
    -DDM_ODM_SUPPORT_TYPE=32
    -DCHIP_DEVICE_LAYER_TARGET=Ameba
    -DMBEDTLS_CONFIG_FILE=\\\"mbedtls_config.h\\\"
    -DLWIP_IPV6_ND=0
    -DLWIP_IPV6_SCOPES=0
    -DLWIP_PBUF_FROM_CUSTOM_POOLS=0
    -DLWIP_IPV6_ROUTE_TABLE_SUPPORT=1
    -DCHIP_DEVICE_LAYER_NONE=0
    -DCHIP_SYSTEM_CONFIG_USE_ZEPHYR_NET_IF=0
    -DCHIP_SYSTEM_CONFIG_USE_BSD_IFADDRS=0
    -DCHIP_SYSTEM_CONFIG_USE_ZEPHYR_SOCKET_EXTENSIONS=0
    -DCHIP_SYSTEM_CONFIG_USE_LWIP=1
    -DCHIP_SYSTEM_CONFIG_USE_SOCKETS=0
    -DCHIP_SYSTEM_CONFIG_USE_NETWORK_FRAMEWORK=0
)

list(
    APPEND CHIP_CXXFLAGS

    -DFD_SETSIZE=10
    -Wno-sign-compare
    -Wno-unused-function
    -Wno-unused-but-set-variable
    -Wno-unused-variable
    -Wno-deprecated-declarations
    -Wno-unused-parameter
    -Wno-format
)

list(
    APPEND CHIP_INC

    ${dir_chip}/config/ameba
    ${dir_chip}/src/include
    ${dir_chip}/src/lib
    ${dir_chip}/src
    ${dir_chip}/src/system
    ${dir_chip}/src/app
    ${dir_chip}/third_party/nlassert/repo/include
    ${dir_chip}/third_party/nlio/repo/include
    ${dir_chip}/third_party/nlunit-test/repo/src
)

set(chip_c_flags "")
set(chip_cpp_flags "")
foreach(tmp IN LISTS CHIP_CFLAGS)
	string(CONCAT appended "\"" ${tmp} "\", ")
	string(APPEND chip_c_flags "${appended}")
endforeach()
foreach(tmp IN LISTS GLOBAL_C_FLAGS)
	string(CONCAT appended "\"" ${tmp} "\", ")
	string(APPEND chip_c_flags "${appended}")
endforeach()
foreach(tmp IN LISTS inc_path)
	string(CONCAT appended "\"-I" ${tmp} "\", ")
	string(APPEND chip_c_flags "${appended}")
endforeach()
foreach(tmp IN LISTS CHIP_INC)
	string(CONCAT appended "\"-I" ${tmp} "\", ")
	string(APPEND chip_c_flags "${appended}")
endforeach()
foreach(tmp IN LISTS CHIP_CXXFLAGS)
	string(CONCAT appended "\"" ${tmp} "\", ")
	string(APPEND chip_cpp_flags "${appended}")
endforeach()
foreach(tmp IN LISTS GLOBAL_CPP_FLAGS)
	string(CONCAT appended "\"" ${tmp} "\", ")
	string(APPEND chip_cpp_flags "${appended}")
endforeach()
string(APPEND chip_cpp_flags "${chip_c_flags}")

set(import_str "import(\"//args.gni\")\n" )

string(APPEND CHIP_GN_ARGS "${import_str}")
string(APPEND CHIP_GN_ARGS "target_cflags_c = [${chip_c_flags}]\n")
string(APPEND CHIP_GN_ARGS "target_cflags_cc = [${chip_cpp_flags}]\n")
#string(APPEND CHIP_GN_ARGS "ameba_ar = ${CMAKE_AR}\n")
#string(APPEND CHIP_GN_ARGS "ameba_cc = ${CMAKE_C_COMPILER}\n")
#string(APPEND CHIP_GN_ARGS "ameba_cxx = ${CMAKE_CXX_COMPILER}\n")
string(APPEND CHIP_GN_ARGS "ameba_ar = \"arm-none-eabi-ar\"\n")
string(APPEND CHIP_GN_ARGS "ameba_cc = \"arm-none-eabi-gcc\"\n")
string(APPEND CHIP_GN_ARGS "ameba_cxx = \"arm-none-eabi-c++\"\n")
string(APPEND CHIP_GN_ARGS "ameba_cpu = \"ameba\"\n")
string(APPEND CHIP_GN_ARGS "chip_build_tests = false\n")

file(GENERATE OUTPUT ${dir_chip_output}/args.gn CONTENT ${CHIP_GN_ARGS})

ExternalProject_Add(
    chip-gn
    PREFIX                  ${CMAKE_CURRENT_BINARY_DIR}
    SOURCE_DIR              ${CHIP_ROOT}
    BINARY_DIR              ${CMAKE_CURRENT_BINARY_DIR}
    CONFIGURE_COMMAND       gn --root=${CHIP_ROOT}/config/ameba gen --check --fail-on-unused-args ${dir_chip_output}
    BUILD_COMMAND           ninja -C ${dir_chip_output}
    INSTALL_COMMAND         ""
    BUILD_BYPRODUCTS        -lCHIP
    CONFIGURE_ALWAYS        TRUE
    BUILD_ALWAYS            TRUE
    USES_TERMINAL_CONFIGURE TRUE
    USES_TERMINAL_BUILD     TRUE
)


add_custom_command(TARGET ${app_ntz} PRE_LINK

    COMMAND echo "COPY CHIP library ..."
    COMMAND cp -f ${dir_chip_output}/lib/* ${CMAKE_CURRENT_SOURCE_DIR}/lib/application/
)

add_custom_command(TARGET ${app_ntz} POST_BUILD

	COMMAND echo "========= linker img2_ns start ========="
	COMMAND cp $<TARGET_FILE:${app_ntz}> target_image2.axf
	COMMAND ${CMAKE_NM} target_image2.axf | sort > target_image2.map
	COMMAND ${CMAKE_OBJEDUMP} -d target_image2.axf > target_image2.asm

	COMMAND rm -rf image && mkdir image
	COMMAND cp target_image2.axf image/target_image2.axf
	COMMAND cp target_image2.axf image/target_pure_image2.axf
	COMMAND cp target_image2.map image
	COMMAND cp target_image2.asm image
	COMMAND cp text.map image/text_image2_ns.map
	COMMAND cp ram_size.txt image
	COMMAND cp obj_list.txt image

	#COMMAND ${CMAKE_STRIP} --strip-unneeded output/${app_ntz_pure}.axf
	COMMAND ${CMAKE_STRIP} image/target_pure_image2.axf
	COMMAND ${CMAKE_NM} image/target_pure_image2.axf | sort > image/target_pure_image2.map

	COMMAND ${CMAKE_OBJCOPY} -j .ram_image2.entry -j .ram_image2.text -j .ram_image2.data -Obinary image/target_pure_image2.axf image/ram_2.bin
	COMMAND ${CMAKE_OBJCOPY} -j .xip_image2.text -Obinary image/target_pure_image2.axf image/xip_image2.bin
	COMMAND ${CMAKE_OBJCOPY} -j .psram_image2.text -j .psram_image2.data -Obinary image/target_pure_image2.axf image/psram_2.bin

	# BT TRACE
	#COMMAND ${CMAKE_OBJCOPY} -j .bluetooth_trace.text -Obinary output/${app_ntz_pure}.axf APP.trace

	COMMAND echo "========== Image Info HEX =========="
	COMMAND ${CMAKE_SIZE} -A --radix=16 image/target_image2.axf
	COMMAND ${CMAKE_SIZE} -t --radix=16 image/target_image2.axf
	COMMAND echo "========== Image Info HEX =========="

	COMMAND echo "========== Image Info DEC =========="
	COMMAND ${CMAKE_SIZE} -A --radix=10 image/target_image2.axf
	COMMAND ${CMAKE_SIZE} -t --radix=10 image/target_image2.axf
	COMMAND echo "========== Image Info DEC =========="

	COMMAND echo "========== Image manipulating start =========="
	COMMAND ${prepend_tool} image/ram_2.bin  __ram_image2_text_start__  image/target_image2.map
	COMMAND ${prepend_tool} image/xip_image2.bin  __flash_text_start__  image/target_image2.map
	COMMAND ${prepend_tool} image/psram_2.bin  __psram_image2_text_start__  image/target_image2.map
	COMMAND cp ${CMAKE_CURRENT_SOURCE_DIR}/code_analyze.py .
	COMMAND chmod 777 code_analyze.py
	COMMAND python2 code_analyze.py

	COMMAND cat image/xip_image2_prepend.bin image/ram_2_prepend.bin image/psram_2_prepend.bin  > image/km4_image2_all.bin

	COMMAND ${pad_tool} image/km4_image2_all.bin
	COMMAND ${image_tool} image/km4_image2_all.bin ${km0_image} NONE
	COMMAND echo "========== Image manipulating end =========="


)

