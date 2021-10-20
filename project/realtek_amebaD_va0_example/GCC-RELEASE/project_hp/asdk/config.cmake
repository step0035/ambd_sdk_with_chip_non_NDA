cmake_minimum_required(VERSION 3.6)

execute_process(
	COMMAND
		whoami
	TIMEOUT
		1
	OUTPUT_VARIABLE
		_user_name
	OUTPUT_STRIP_TRAILING_WHITESPACE
)
cmake_host_system_information(RESULT _host_name QUERY HOSTNAME)
cmake_host_system_information(RESULT _fqdn QUERY FQDN)

string(TIMESTAMP _configuration_time "%Y-%m-%d %H:%M:%S [UTC]" UTC)
string(TIMESTAMP _configuration_date "%Y-%m-%d" UTC)

get_filename_component(_compiler_name ${CMAKE_C_COMPILER} NAME)

configure_file(${prj_root}/inc/inc_hp/build_info.h.in ${prj_root}/inc/inc_hp/build_info.h @ONLY)


set(CONFIG_RTL8721D ON)
set(ARM_CORE_CM4 ON)
set(CONFIG_CHIP_A_CUT ON)

set(CONFIG_CPU_CLK ON)
set(CONFIG_CPU_200MHZ ON)
set(PLATFORM_CLOCK (200000000))
set(CPU_CLOCK_SEL_VALUE (0))

set(CONFIG_KERNEL ON)
set(PLATFORM_FREERTOS ON)
set(TASK_SCHEDULER_DISABLED (0))

set(CONFIG_SOC_PS_EN ON)
set(CONFIG_SOC_PS_MODULE ON)

set(CONFIG_SDIO_DEVICE_EN ON)
set(CONFIG_SDIO_DEVICE_NORMAL ON)
set(CONFIG_SDIO_DEVICE_MODULE ON)

set(CONFIG_MBED_API_EN ON)

set(CONFIG_BT_EN ON)
set(CONFIG_BT ON)
set(CONFIG_BT_PERIPHERAL ON)

set(CONFIG_WIFI_EN ON)
set(CONFIG_WIFI_NORMAL ON)
set(CONFIG_WIFI_MODULE ON)

set(CONFIG_NETWORK ON)

set(CONFIG_USE_MBEDTLS_ROM ON)
set(CONFIG_MBED_TLS_ENABLED ON)

set(CONFIG_DEBUG_LOG ON)

set(CONFIG_TOOLCHAIN_ASDK ON)
set(CONFIG_LINK_ROM_SYMB ON)

