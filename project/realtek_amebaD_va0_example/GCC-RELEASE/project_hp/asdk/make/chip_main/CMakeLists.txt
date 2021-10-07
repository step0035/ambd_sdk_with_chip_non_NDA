cmake_minimum_required(VERSION 3.6)

project(chip_main)

set(sdk_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../../../../..")
set(prj_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../../..")
set(dir_chip "${ameba_matter_root}")
set(dir "${sdk_root}/component/common/api")
set(target chip_main)
set(list chip_main_sources)

message(STATUS "Building \"${target}\" folder")

list(
    APPEND ${list}

    #chip app
    ${dir_chip}/src/app/Command.cpp
    ${dir_chip}/src/app/CommandHandler.cpp
    ${dir_chip}/src/app/CommandSender.cpp
    ${dir_chip}/src/app/decoder.cpp
    ${dir_chip}/src/app/encoder-common.cpp
    ${dir_chip}/src/app/EventManagement.cpp
    ${dir_chip}/src/app/InteractionModelEngine.cpp
    ${dir_chip}/src/app/ReadClient.cpp
    ${dir_chip}/src/app/ReadHandler.cpp
    ${dir_chip}/src/app/WriteClient.cpp
    ${dir_chip}/src/app/WriteHandler.cpp

    ${dir_chip}/src/app/server/Server.cpp
    ${dir_chip}/src/app/server/RendezvousServer.cpp
    ${dir_chip}/src/app/server/Mdns.cpp
    ${dir_chip}/src/app/server/EchoHandler.cpp
    ${dir_chip}/src/app/server/OnboardingCodesUtil.cpp
    ${dir_chip}/src/app/server/CommissionManager.cpp

    ${dir_chip}/src/app/util/af-event.cpp
    ${dir_chip}/src/app/util/af-main-common.cpp
    ${dir_chip}/src/app/util/attribute-storage.cpp
    ${dir_chip}/src/app/util/attribute-table.cpp
    ${dir_chip}/src/app/util/attribute-list-byte-span.cpp         #Base0518
    ${dir_chip}/src/app/util/attribute-size-util.cpp              #Base0617
    ${dir_chip}/src/app/util/binding-table.cpp
    ${dir_chip}/src/app/util/CHIPDeviceCallbacksMgr.cpp
    ${dir_chip}/src/app/util/chip-message-send.cpp
    ${dir_chip}/src/app/util/client-api.cpp
    ${dir_chip}/src/app/util/DataModelHandler.cpp
    ${dir_chip}/src/app/util/ember-compatibility-functions.cpp
    ${dir_chip}/src/app/util/ember-print.cpp
    ${dir_chip}/src/app/util/esi-management.cpp
    ${dir_chip}/src/app/util/message.cpp
    ${dir_chip}/src/app/util/process-cluster-message.cpp
    ${dir_chip}/src/app/util/process-global-message.cpp
    ${dir_chip}/src/app/util/util.cpp
    ${dir_chip}/src/app/util/error-mapping.cpp

    ${dir_chip}/src/app/clusters/on-off-server/on-off-server.cpp                                         #Base0429
    ${dir_chip}/src/app/clusters/level-control/level-control.cpp
    ${dir_chip}/src/app/clusters/identify/identify.cpp
    ${dir_chip}/src/app/clusters/barrier-control-server/barrier-control-server.cpp
    ${dir_chip}/src/app/clusters/groups-server/groups-server.cpp
    ${dir_chip}/src/app/clusters/color-control-server/color-control-server.cpp
    ${dir_chip}/src/app/clusters/content-launch-server/content-launch-server.cpp
    ${dir_chip}/src/app/clusters/media-playback-server/media-playback-server.cpp
    ${dir_chip}/src/app/clusters/temperature-measurement-server/temperature-measurement-server.cpp
    ${dir_chip}/src/app/clusters/scenes/scenes.cpp
    ${dir_chip}/src/app/clusters/basic/basic.cpp
    ${dir_chip}/src/app/clusters/bindings/bindings.cpp
    ${dir_chip}/src/app/clusters/door-lock-server/door-lock-server-core.cpp
    ${dir_chip}/src/app/clusters/door-lock-server/door-lock-server-logging.cpp
    ${dir_chip}/src/app/clusters/door-lock-server/door-lock-server-schedule.cpp
    ${dir_chip}/src/app/clusters/door-lock-server/door-lock-server-user.cpp
    ${dir_chip}/src/app/clusters/ias-zone-server/ias-zone-server.cpp
    ${dir_chip}/src/app/clusters/general-commissioning-server/general-commissioning-server.cpp
    ${dir_chip}/src/app/clusters/low-power-server/low-power-server.cpp
    ${dir_chip}/src/app/clusters/network-commissioning/network-commissioning.cpp
    ${dir_chip}/src/app/clusters/network-commissioning/network-commissioning-ember.cpp
    ${dir_chip}/src/app/clusters/descriptor/descriptor.cpp                                               #Base0429
    ${dir_chip}/src/app/clusters/operational-credentials-server/operational-credentials-server.cpp       #Base0429 + #Base0505
    ${dir_chip}/src/app/clusters/ota-provider/ota-provider.cpp                                           #Base0429 + #base0703
    ${dir_chip}/src/app/clusters/test-cluster-server/test-cluster-server.cpp                             #Base0505
    #${dir_chip}/src/app/clusters/trusted-root-certificates-server/trusted-root-certificates-server.cpp   #Base0518 + Base0614
    ${dir_chip}/src/app/clusters/occupancy-sensor-server/occupancy-sensor-server.cpp                     #Base0531
    ${dir_chip}/src/app/clusters/pump-configuration-and-control-server/pump-configuration-and-control-server.cpp
    ${dir_chip}/src/app/clusters/diagnostic-logs-server/diagnostic-logs-server.cpp
    ${dir_chip}/src/app/clusters/ethernet_network_diagnostics_server/ethernet_network_diagnostics_server.cpp
    ${dir_chip}/src/app/clusters/software_diagnostics_server/software_diagnostics_server.cpp
    ${dir_chip}/src/app/clusters/thread_network_diagnostics_server/thread_network_diagnostics_server.cpp
    ${dir_chip}/src/app/clusters/wifi_network_diagnostics_server/wifi_network_diagnostics_server.cpp
    ${dir_chip}/src/app/clusters/administrator-commissioning-server/administrator-commissioning-server.cpp

    ${dir_chip}/src/app/reporting/reporting-default-configuration.cpp
    ${dir_chip}/src/app/reporting/reporting.cpp
    ${dir_chip}/src/app/reporting/Engine.cpp

    ${dir_chip}/zzz_generated/app-common/app-common/zap-generated/attributes/Accessors.cpp

    ${dir_chip}/zzz_generated/all-clusters-app/zap-generated/attribute-size.cpp
    ${dir_chip}/zzz_generated/all-clusters-app/zap-generated/CHIPClientCallbacks.cpp
    ${dir_chip}/zzz_generated/all-clusters-app/zap-generated/callback-stub.cpp
    ${dir_chip}/zzz_generated/all-clusters-app/zap-generated/IMClusterCommandHandler.cpp
    ${dir_chip}/zzz_generated/all-clusters-app/zap-generated/CHIPClusters.cpp

    ${dir_chip}/examples/all-clusters-app/ameba/main/chipinterface.cpp
    ${dir_chip}/examples/all-clusters-app/ameba/main/DeviceCallbacks.cpp
    ${dir_chip}/examples/all-clusters-app/ameba/main/CHIPDeviceManager.cpp
    #${dir_chip}/examples/all-clusters-app/ameba/main/Globals.cpp
    #${dir_chip}/examples/all-clusters-app/ameba/main/LEDWidget.cpp
)

add_library(
    ${target}
    STATIC
    ${chip_main_sources}
)

# move static library post build command
add_custom_command(
    TARGET ${target}
    POST_BUILD
    COMMAND mv -f lib${target}.a ${CMAKE_CURRENT_SOURCE_DIR}/../../lib/application
)

target_include_directories(
    ${target}
    PUBLIC

    ${dir_chip}/zzz_generated/all-clusters-app
    ${dir_chip}/zzz_generated/all-clusters-app/zap-generated
    ${dir_chip}/zzz_generated/app-common
    ${dir_chip}/examples/all-clusters-app/all-clusters-common
    ${dir_chip}/examples/all-clusters-app/ameba/main/include
    ${dir_chip}/examples/all-clusters-app/ameba/build/chip/gen/include
    ${dir_chip}/src/include/
    ${dir_chip}/src/lib/
    ${dir_chip}/src/
    ${dir_chip}/third_party/nlassert/repo/include/
    ${dir_chip}/src/app/
    ${dir_chip}/src/app/util/
    ${dir_chip}/src/app/server/
    ${dir_chip}/src/controller/data_model
    ${dir_chip}/third_party/nlio/repo/include/
    ${dir_chip}/third_party/nlunit-test/repo/src
)

list(
    APPEND ${CMAKE_CXX_FLAGS}

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

    -Wno-unused-parameter
)

list(
    APPEND ${CMAKE_C_FLAGS}

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

    -Wno-unused-parameter
)
