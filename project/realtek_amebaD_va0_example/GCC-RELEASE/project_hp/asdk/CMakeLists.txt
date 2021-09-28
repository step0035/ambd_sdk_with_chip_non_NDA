cmake_minimum_required(VERSION 3.6)

project(app_ntz)

enable_language(C ASM)

set(prj_root "${CMAKE_CURRENT_SOURCE_DIR}/../../..")
set(sdk_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../../..")
set(app_ntz application.ntz)
set(app_ntz_pure application.ntz_pure)
set(list app_ntz_sources)
set(list_inc_path app_ntz_inc)

set(freertos "freertos_v10.2.0")
set(lwip "lwip_v2.1.2")

set(utility_dir "${CMAKE_CURRENT_SOURCE_DIR}/gnu_utility")
set(prepend_tool "${utility_dir}/prepend_header.sh")
set(pad_tool "${utility_dir}/pad.sh")
set(image_tool "${utility_dir}/image_tool/image_tool.sh")
#set(mbedtls_dir "${sdk_root}/../connectedhomeip/third_party/mbedtls/repo/include/mbedtls")

# build_info
include(config.cmake)

# build_target_folder
# prepare the target folder path...

# build sub folder
include(make/make.cmake)


# Build_lib lib_all : make_subdirs_lib
#if(BUILD_LIB)
#	message(STATUS "build libraries")
#	include(./libsoc_ntz.cmake)
#	include(./libwlan.cmake)
#	include(./libwps.cmake)
#	include(./libmmf.cmake)
#	include(./libg711.cmake)
#	include(./libaec.cmake)
#	include(./libhttp.cmake)
#	include(./libsdcard.cmake)
#	include(./libfaac.cmake)
#	include(./libhaac.cmake)
#	include(./libmuxer.cmake)
#	include(./libusbd.cmake)
#	include(./libopus.cmake)
#	include(./libopusenc.cmake)
#	include(./libopusfile.cmake)
#	include(./libhmp3.cmake)
#	include(./librtknn.cmake)
#	include(./libvipnn.cmake)
#endif()

message(STATUS "Build libraries ${BUILD_LIB}")
message(STATUS "Build FPGA ${BUILD_FPGA}")
message(STATUS "Build PXP ${BUILD_PXP}")

#copy_ld_img2(ld/rlx8721d_img2_is.ld) copy_ld_img3
set( ld_script_layout ${CMAKE_CURRENT_SOURCE_DIR}/rlx8721d_layout_is.ld )
#combine
set( ld_script ${CMAKE_CURRENT_SOURCE_DIR}/rlx8721d_test.ld )

# HEADER FILE PATH
include(includepath.cmake)

#USER
#list(
#    APPEND app_ntz_sources
#     ${prj_root}/src/src_hp/main.c
#)

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

target_compile_definitions(${app_ntz} PRIVATE ${app_ntz_flags} )

target_link_libraries(
	${app_ntz}
	_application_hp
	_bootloader_hp
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
	_main
	CHIP
	m
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
	"LINKER:SHELL:-Map=${app_ntz}.map"
)


add_custom_command(TARGET ${app_ntz} POST_BUILD

	COMMAND echo "========= linker img2_ns start ========="
	COMMAND ${CMAKE_NM} $<TARGET_FILE:${app_ntz}> | sort > ${app_ntz}.nm.map
	COMMAND ${CMAKE_OBJEDUMP} -d $<TARGET_FILE:${app_ntz}> > ${app_ntz}.asm

	COMMAND cp $<TARGET_FILE:${app_ntz}> ${app_ntz}.axf
	COMMAND rm -rf output && mkdir output
	COMMAND cp ${app_ntz}.axf output/${app_ntz}.axf
	COMMAND cp ${app_ntz}.axf output/${app_ntz_pure}.axf
	COMMAND cp ${app_ntz}.nm.map output
	COMMAND cp ${app_ntz}.map output
	COMMAND cp ${app_ntz}.asm output

	#COMMAND ${CMAKE_STRIP} --strip-unneeded output/${app_ntz_pure}.axf
	COMMAND ${CMAKE_NM} output/${app_ntz_pure}.axf | sort > output/${app_ntz_pure}.map

	COMMAND ${CMAKE_OBJCOPY} -j .ram_image2.entry -j .ram_image2.text -j .ram_image2.data -Obinary output/${app_ntz_pure}.axf output/ram_2.bin
	COMMAND ${CMAKE_OBJCOPY} -j .xip_image2.text -Obinary output/${app_ntz_pure}.axf output/xip_image2.bin
	COMMAND ${CMAKE_OBJCOPY} -j .psram_image2.text -j .psram_image2.data -Obinary output/${app_ntz_pure}.axf output/psram_2.bin

	# BT TRACE
	#COMMAND ${CMAKE_OBJCOPY} -j .bluetooth_trace.text -Obinary output/${app_ntz_pure}.axf APP.trace

	COMMAND echo "========== Image Info HEX =========="
	COMMAND ${CMAKE_SIZE} -A --radix=16 output/${app_ntz}.axf
	COMMAND ${CMAKE_SIZE} -t --radix=16 output/${app_ntz}.axf
	COMMAND echo "========== Image Info HEX =========="

	COMMAND echo "========== Image Info DEC =========="
	COMMAND ${CMAKE_SIZE} -A --radix=10 output/${app_ntz}.axf
	COMMAND ${CMAKE_SIZE} -t --radix=10 output/${app_ntz}.axf
	COMMAND echo "========== Image Info DEC =========="

	COMMAND echo "========== Image manipulating start =========="
	COMMAND ${prepend_tool} output/ram_2.bin  __ram_image2_text_start__  output/${app_ntz}.map
	COMMAND ${prepend_tool} output/xip_image2.bin  __flash_text_start__  output/${app_ntz}.map
	COMMAND ${prepend_tool} output/psram_2.bin  __psram_image2_text_start__  output/${app_ntz}.map
	#COMMAND ${CODE_ANALYZE_PYTHON}

	COMMAND cat output/xip_image2_prepend.bin output/ram_2_prepend.bin output/psram_2_prepend.bin  > output/km4_image2_all.bin

	COMMAND ${pad_tool} output/km4_image2_all.bin
	COMMAND rm -rf output/image && mkdir output/image
	COMMAND ${image_tool} output/km4_image2_all.bin output/image NONE
	COMMAND echo "========== Image manipulating end =========="

	#COMMAND ${CMAKE_OBJCOPY} -j .bluetooth_trace.text -Obinary ${app_ntz}.axf APP.trace
	#COMMAND ${CMAKE_OBJCOPY} -R .bluetooth_trace.text ${app_ntz}.axf
	#COMMAND cp ${app} ${app}_pure
	#COMMAND ${CMAKE_STRIP} --strip-unneeded ${app}_pure
	#COMMAND ${CMAKE_OBJCOPY} -j .rom.vector_tbl -j .rom.ns_vector_tbl -j .rom.text -j .ARM.extab -j .ARM.exidx -j .data_of_rom -j .note.gnu.build-id -j .rom.stubs -j .rom.ns4s_stubs -Obinary ${app}_pure rom.bin
	#COMMAND ${CMAKE_OBJCOPY} -j .gnu.sgstubs  -Obinary ${app}_pure nsc.bin
	#COMMAND ${CMAKE_OBJCOPY} -j .ram.func.table -j .ram.img.signature -j .data -j .ram.code_text -j .ram.code_rodata  -Obinary ${app}_pure ram_ld.bin
	#COMMAND ${CMAKE_OBJCOPY} -j .ram.vector -j .ram.func.table -j .ram.img.signature -j .ram.func.table -j .data -j .ram.code_text -j .ram.code_rodata  -Obinary ${app}_pure ram.bin
	#COMMAND rm -rf info
	#COMMAND mkdir info
	#COMMAND mv *.{i,s} info

	#COMMAND ${prj_root}/GCC-RELEASE/elf2bin.exe convert ${prj_root}/GCC-RELEASE/amebapro2_partition.json PARTITIONTABLE

#	COMMAND cp ${prj_root}/GCC-RELEASE/keycfg.json keycfg.json
#	COMMAND cp ${prj_root}/GCC-RELEASE/partition.json partition.json
#	COMMAND cp ${prj_root}/GCC-RELEASE/amebapro2_firmware.json amebapro2_firmware.json
#	COMMAND ${prj_root}/GCC-RELEASE/elf2bin.exe keygen keycfg.json
#	COMMAND ${prj_root}/GCC-RELEASE/elf2bin.exe convert amebapro2_firmware.json FIRMWARE


#	COMMAND rm -rf output && mkdir output
#	COMMAND cp firmware_ntz.bin output
#	COMMAND cp ${app_ntz}.nm.map output
#	COMMAND cp ${app_ntz}.map output
#	COMMAND cp ${app_ntz}.asm output
#	COMMAND cp ${app_ntz}.axf output
#	COMMAND cp *.a output


	#COMMAND rm -rf output && mkdir output
	#COMMAND cp ${boot} output
	#COMMAND python ../split_binary.py output
	#COMMAND cd .. && tar zcvf build.tar.gz build/output
)

#if(BUILD_PXP)
#add_custom_command(TARGET ${app_ntz} POST_BUILD
#	COMMAND cp ${app_ntz}.axf output/application.axf
#	COMMAND python ${prj_root}/GCC-RELEASE/split_binary.py output Ignore
#	COMMAND rm output/application.axf
#	COMMAND cd .. && tar zcvf build.tar.gz build/output
#)
#endif()
