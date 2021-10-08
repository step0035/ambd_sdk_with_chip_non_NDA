cmake_minimum_required(VERSION 3.6)

project(chip_main)

set(chip_dir "${ameba_matter_root}")
set(chip_dir_output "${matter_output_path}/chip")
set(dir "${sdk_root}/component/common/api")
set(chip_main chip_main)
set(list_chip_main_sources chip_main_sources)

include(${prj_root}/GCC-RELEASE/project_hp/asdk/includepath.cmake)

list(
    APPEND ${list_chip_main_sources}

    #chip app
    ${chip_dir}/src/app/Command.cpp
    ${chip_dir}/src/app/CommandHandler.cpp
    ${chip_dir}/src/app/CommandSender.cpp
    ${chip_dir}/src/app/decoder.cpp
    ${chip_dir}/src/app/encoder-common.cpp
    ${chip_dir}/src/app/EventManagement.cpp
    ${chip_dir}/src/app/InteractionModelEngine.cpp
    ${chip_dir}/src/app/ReadClient.cpp
    ${chip_dir}/src/app/ReadHandler.cpp
    ${chip_dir}/src/app/WriteClient.cpp
    ${chip_dir}/src/app/WriteHandler.cpp

    ${chip_dir}/src/app/server/Server.cpp
    ${chip_dir}/src/app/server/RendezvousServer.cpp
    ${chip_dir}/src/app/server/Mdns.cpp
    ${chip_dir}/src/app/server/EchoHandler.cpp
    ${chip_dir}/src/app/server/OnboardingCodesUtil.cpp
    ${chip_dir}/src/app/server/CommissionManager.cpp

    ${chip_dir}/src/app/util/af-event.cpp
    ${chip_dir}/src/app/util/af-main-common.cpp
    ${chip_dir}/src/app/util/attribute-storage.cpp
    ${chip_dir}/src/app/util/attribute-table.cpp
    ${chip_dir}/src/app/util/attribute-list-byte-span.cpp         #Base0518
    ${chip_dir}/src/app/util/attribute-size-util.cpp              #Base0617
    ${chip_dir}/src/app/util/binding-table.cpp
    ${chip_dir}/src/app/util/CHIPDeviceCallbacksMgr.cpp
    ${chip_dir}/src/app/util/chip-message-send.cpp
    ${chip_dir}/src/app/util/client-api.cpp
    ${chip_dir}/src/app/util/DataModelHandler.cpp
    ${chip_dir}/src/app/util/ember-compatibility-functions.cpp
    ${chip_dir}/src/app/util/ember-print.cpp
    ${chip_dir}/src/app/util/esi-management.cpp
    ${chip_dir}/src/app/util/message.cpp
    ${chip_dir}/src/app/util/process-cluster-message.cpp
    ${chip_dir}/src/app/util/process-global-message.cpp
    ${chip_dir}/src/app/util/util.cpp
    ${chip_dir}/src/app/util/error-mapping.cpp

    ${chip_dir}/src/app/clusters/on-off-server/on-off-server.cpp                                         #Base0429
    ${chip_dir}/src/app/clusters/level-control/level-control.cpp
    ${chip_dir}/src/app/clusters/identify/identify.cpp
    ${chip_dir}/src/app/clusters/barrier-control-server/barrier-control-server.cpp
    ${chip_dir}/src/app/clusters/groups-server/groups-server.cpp
    ${chip_dir}/src/app/clusters/color-control-server/color-control-server.cpp
    ${chip_dir}/src/app/clusters/content-launch-server/content-launch-server.cpp
    ${chip_dir}/src/app/clusters/media-playback-server/media-playback-server.cpp
    ${chip_dir}/src/app/clusters/temperature-measurement-server/temperature-measurement-server.cpp
    ${chip_dir}/src/app/clusters/scenes/scenes.cpp
    ${chip_dir}/src/app/clusters/basic/basic.cpp
    ${chip_dir}/src/app/clusters/bindings/bindings.cpp
    ${chip_dir}/src/app/clusters/door-lock-server/door-lock-server-core.cpp
    ${chip_dir}/src/app/clusters/door-lock-server/door-lock-server-logging.cpp
    ${chip_dir}/src/app/clusters/door-lock-server/door-lock-server-schedule.cpp
    ${chip_dir}/src/app/clusters/door-lock-server/door-lock-server-user.cpp
    ${chip_dir}/src/app/clusters/ias-zone-server/ias-zone-server.cpp
    ${chip_dir}/src/app/clusters/general-commissioning-server/general-commissioning-server.cpp
    ${chip_dir}/src/app/clusters/low-power-server/low-power-server.cpp
    ${chip_dir}/src/app/clusters/network-commissioning/network-commissioning.cpp
    ${chip_dir}/src/app/clusters/network-commissioning/network-commissioning-ember.cpp
    ${chip_dir}/src/app/clusters/descriptor/descriptor.cpp                                               #Base0429
    ${chip_dir}/src/app/clusters/operational-credentials-server/operational-credentials-server.cpp       #Base0429 + #Base0505
    ${chip_dir}/src/app/clusters/ota-provider/ota-provider.cpp                                           #Base0429 + #base0703
    ${chip_dir}/src/app/clusters/test-cluster-server/test-cluster-server.cpp                             #Base0505
    #${chip_dir}/src/app/clusters/trusted-root-certificates-server/trusted-root-certificates-server.cpp   #Base0518 + Base0614
    ${chip_dir}/src/app/clusters/occupancy-sensor-server/occupancy-sensor-server.cpp                     #Base0531
    ${chip_dir}/src/app/clusters/pump-configuration-and-control-server/pump-configuration-and-control-server.cpp
    ${chip_dir}/src/app/clusters/diagnostic-logs-server/diagnostic-logs-server.cpp
    ${chip_dir}/src/app/clusters/ethernet_network_diagnostics_server/ethernet_network_diagnostics_server.cpp
    ${chip_dir}/src/app/clusters/software_diagnostics_server/software_diagnostics_server.cpp
    ${chip_dir}/src/app/clusters/thread_network_diagnostics_server/thread_network_diagnostics_server.cpp
    ${chip_dir}/src/app/clusters/wifi_network_diagnostics_server/wifi_network_diagnostics_server.cpp
    ${chip_dir}/src/app/clusters/administrator-commissioning-server/administrator-commissioning-server.cpp

    ${chip_dir}/src/app/reporting/reporting-default-configuration.cpp
    ${chip_dir}/src/app/reporting/reporting.cpp
    ${chip_dir}/src/app/reporting/Engine.cpp

    ${chip_dir}/zzz_generated/app-common/app-common/zap-generated/attributes/Accessors.cpp

    ${chip_dir}/zzz_generated/all-clusters-app/zap-generated/attribute-size.cpp
    ${chip_dir}/zzz_generated/all-clusters-app/zap-generated/CHIPClientCallbacks.cpp
    ${chip_dir}/zzz_generated/all-clusters-app/zap-generated/callback-stub.cpp
    ${chip_dir}/zzz_generated/all-clusters-app/zap-generated/IMClusterCommandHandler.cpp
    ${chip_dir}/zzz_generated/all-clusters-app/zap-generated/CHIPClusters.cpp

    ${chip_dir}/examples/all-clusters-app/ameba/main/chipinterface.cpp
    ${chip_dir}/examples/all-clusters-app/ameba/main/DeviceCallbacks.cpp
    ${chip_dir}/examples/all-clusters-app/ameba/main/CHIPDeviceManager.cpp
    #${chip_dir}/examples/all-clusters-app/ameba/main/Globals.cpp
    #${chip_dir}/examples/all-clusters-app/ameba/main/LEDWidget.cpp
)

add_library(
    ${chip_main}
    STATIC
    ${chip_main_sources}
)

target_include_directories(
    ${chip_main}
    PUBLIC

	${inc_path}
    ${chip_dir}/zzz_generated/all-clusters-app
    ${chip_dir}/zzz_generated/all-clusters-app/zap-generated
    ${chip_dir}/zzz_generated/app-common
    ${chip_dir}/examples/all-clusters-app/all-clusters-common
    ${chip_dir}/examples/all-clusters-app/ameba/main/include
    ${chip_dir_output}/gen/include
    ${chip_dir}/src/include/
    ${chip_dir}/src/lib/
    ${chip_dir}/src/
    ${chip_dir}/third_party/nlassert/repo/include/
    ${chip_dir}/src/app/
    ${chip_dir}/src/app/util/
    ${chip_dir}/src/app/server/
    ${chip_dir}/src/controller/data_model
    ${chip_dir}/third_party/nlio/repo/include/
    ${chip_dir}/third_party/nlunit-test/repo/src
)

list(
    APPEND chip_main_flags

    -DCHIP_SYSTEM_CONFIG_USE_LWIP=1
    -DCHIP_SYSTEM_CONFIG_USE_SOCKETS=0
    -DCHIP_SYSTEM_CONFIG_POSIX_LOCKING=0
    -DINET_CONFIG_ENABLE_IPV4=1
    -DCHIP_PROJECT=1
    -DCHIP_DEVICE_LAYER_TARGET=Ameba
    -DUSE_ZAP_CONFIG
    -DCHIP_HAVE_CONFIG_H
    -DLWIP_IPV6_SCOPES=0

    -DLWIP_IPV6_ND=0
    -DLWIP_IPV6_SCOPES=0
    -DLWIP_PBUF_FROM_CUSTOM_POOLS=0

    -DCHIP_DEVICE_LAYER_NONE=0
    -DCHIP_SYSTEM_CONFIG_USE_ZEPHYR_NET_IF=0
    -DCHIP_SYSTEM_CONFIG_USE_BSD_IFADDRS=0
    -DCHIP_SYSTEM_CONFIG_USE_ZEPHYR_SOCKET_EXTENSIONS=0
)

list(
    APPEND chip_main_cpp_flags

	-Wno-unused-parameter
	-std=gnu++11
	-std=c++14
	-fno-rtti
)
target_compile_definitions(${chip_main} PRIVATE ${chip_main_flags} )
target_compile_options(${chip_main} PRIVATE ${chip_main_cpp_flags})

# move static library post build command
add_custom_command(
    TARGET ${chip_main}
    POST_BUILD
    COMMAND cp lib${chip_main}.a ${CMAKE_CURRENT_SOURCE_DIR}/lib/application
)
