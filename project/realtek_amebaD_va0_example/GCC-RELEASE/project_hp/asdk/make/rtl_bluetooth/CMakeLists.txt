cmake_minimum_required(VERSION 3.6)

project(rtl_bluetooth)

set(sdk_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../../../../..")
set(prj_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../../..")
set(dir "${sdk_root}/component/common/bluetooth/realtek")
set(dir_sdk "${sdk_root}/component/common/bluetooth/realtek/sdk")
set(dir_mesh "${dir_sdk}/example/bt_mesh")
set(dir_mesh_user_api "${dir_mesh}/api")
set(dir_mesh_prov_rtk_demo "${dir_sdk}/example/bt_mesh_provisioner_rtk_demo")
set(dir_mesh_dev_rtk_demo "${dir_sdk}/example/bt_mesh_device_rtk_demo")
set(target rtl_bluetooth)
set(list rtl_bluetooth_sources)

# Temporary setting of macro
set(CONFIG_BT_EN ON)
set(CONFIG_BT_MESH_PROVISIONER ON)
set(CONFIG_BT_MESH_PROVISIONER_RTK_DEMO OFF)
set(CONFIG_BT_MESH_DEVICE ON)
set(CONFIG_BT_MESH_DEVICE_RTK_DEMO OFF)
set(CONFIG_BT_MESH_PROVISIONER_MULTIPLE_PROFILE OFF)
set(CONFIG_BT_MESH_DEVICE_MULTIPLE_PROFILE OFF)

message(STATUS "Building \"${target}\" folder")

if(${CONFIG_BT_EN})

if(${CONFIG_BT_MESH_PROVISIONER})

list(
    APPEND ${list}

    # Mesh Provisioner
    ${dir_mesh}/lib/cmd/mesh_data_uart.c 
	${dir_mesh}/lib/cmd/mesh_user_cmd_parse.c 
    ${dir_mesh}/lib/profile/datatrans_service.c 
    ${dir_mesh}/lib/profile/datatrans_client.c 
    ${dir_mesh}/lib/model/configuration_client.c 
    ${dir_mesh}/lib/model/health_client.c 
    ${dir_mesh}/lib/model/realtek/ping_control.c 
    ${dir_mesh}/lib/model/realtek/tp_control.c 
    ${dir_mesh}/lib/model/realtek/light_cwrgb_client.c 
    ${dir_mesh}/lib/model/realtek/datatrans_model.c 
    ${dir_mesh}/lib/model/generic_on_off_client.c 
    ${dir_mesh}/lib/model/generic_default_transition_time_client.c 
    ${dir_mesh}/lib/model/generic_level_client.c 
    ${dir_mesh}/lib/model/generic_location_client.c 
    ${dir_mesh}/lib/model/generic_power_on_off_client.c 
    ${dir_mesh}/lib/model/generic_property_client.c 
    ${dir_mesh}/lib/model/light_lightness_client.c 
    ${dir_mesh}/lib/model/light_xyl_client.c 
    ${dir_mesh}/lib/model/light_hsl_client.c 
    ${dir_mesh}/lib/model/generic_power_level_client.c 
    ${dir_mesh}/lib/model/generic_battery_client.c 
    ${dir_mesh}/lib/model/light_ctl_client.c 
    ${dir_mesh}/lib/model/time_client.c 
    ${dir_mesh}/lib/model/scene_client.c 
    ${dir_mesh}/lib/model/sensor_client.c 
    ${dir_mesh}/lib/model/scheduler_client.c 
	${dir_mesh}/lib/model/delay_msg_rsp.c 
    ${dir_mesh}/provisioner/bt_mesh_provisioner_app_task.c 
    ${dir_mesh}/provisioner/provisioner_app.c 
    ${dir_mesh}/lib/common/ping_app.c 
    ${dir_mesh}/lib/common/generic_client_app.c 
    ${dir_mesh}/lib/common/light_client_app.c 
    ${dir_mesh}/lib/common/datatrans_app.c 
    ${dir_mesh}/lib/cmd/mesh_cmd.c 
    ${dir_mesh}/lib/cmd/client_cmd.c 
    ${dir_mesh}/lib/cmd/test_cmd.c 
    ${dir_mesh}/provisioner/provisioner_cmd.c 
    ${dir_mesh}/provisioner/bt_mesh_provisioner_app_main.c 
    ${dir_sdk}/board/amebad/src/vendor_cmd/vendor_cmd.c 
    ${dir_mesh_user_api}/provisioner/bt_mesh_provisioner_api.c 
    ${dir_mesh_user_api}/bt_mesh_user_api.c
)

if(${CONFIG_BT_MESH_PROVISIONER_RTK_DEMO})
    # Unable to find file
endif()	

elseif(${CONFIG_BT_MESH_DEVICE})
list(
    APPEND ${list}

    # Mesh Device
    ${dir_mesh}/lib/cmd/mesh_data_uart.c 
	${dir_mesh}/lib/cmd/mesh_user_cmd_parse.c 
    ${dir_mesh}/lib/profile/datatrans_server.c 
    ${dir_mesh}/lib/profile/datatrans_service.c 
	${dir_mesh}/lib/model/generic_on_off_server.c 
	${dir_mesh}/lib/model/delay_execution.c 
	${dir_mesh}/lib/model/delay_msg_rsp.c 
	${dir_mesh}/lib/model/generic_transition_time.c 
    ${dir_mesh}/lib/model/realtek/datatrans_model.c
    ${dir_mesh}/lib/model/realtek/ping_control.c 
    ${dir_mesh}/lib/model/realtek/tp_control.c 
    ${dir_mesh}/lib/model/health_server.c 
	${dir_mesh}/lib/model/light_lightness_setup_server.c 
	${dir_mesh}/lib/model/light_lightness_server.c 
	${dir_mesh}/lib/model/light_xyl_setup_server.c 
	${dir_mesh}/lib/model/light_xyl_server.c 
	${dir_mesh}/lib/model/light_ctl_server.c 
	${dir_mesh}/lib/model/light_ctl_setup_server.c 
	${dir_mesh}/lib/model/light_ctl_temperature_server.c
	${dir_mesh}/lib/model/light_ctl_temperature_server.c
	${dir_mesh}/lib/model/light_hsl_hue_server.c 
	${dir_mesh}/lib/model/light_hsl_saturation_server.c 
	${dir_mesh}/lib/model/light_hsl_server.c 
	${dir_mesh}/lib/model/light_hsl_setup_server.c 
	${dir_mesh}/lib/model/time_server.c 
	${dir_mesh}/lib/model/time_setup_server.c 
    ${dir_mesh}/lib/model/scene_server.c 
    ${dir_mesh}/lib/model/scene_setup_server.c 
    ${dir_mesh}/lib/model/scheduler_server.c 
    ${dir_mesh}/lib/model/scheduler_setup_server.c 
    ${dir_mesh}/device/bt_mesh_device_app_task.c 
    ${dir_mesh}/device/device_app.c 
    ${dir_mesh}/lib/common/ping_app.c 
    ${dir_mesh}/lib/common/datatrans_app.c 
	${dir_mesh}/lib/common/scene_server_app.c 
    ${dir_mesh}/lib/common/scheduler_server_app.c 
	${dir_mesh}/lib/common/time_server_app.c 
	${dir_mesh}/lib/common/light_server_app.c 
    ${dir_mesh}/lib/cmd/mesh_cmd.c 
    ${dir_mesh}/lib/cmd/test_cmd.c 
    ${dir_mesh}/device/device_cmd.c
    ${dir_mesh}/device/bt_mesh_device_app_main.c 
    ${dir_sdk}/board/amebad/src/vendor_cmd/vendor_cmd.c 
    ${dir_mesh_user_api}/device/bt_mesh_device_api.c 
    ${dir_mesh_user_api}/bt_mesh_user_api.c
)

if(${CONFIG_BT_MESH_DEVICE_RTK_DEMO})
    # Unable to find file
endif()

elseif(${CONFIG_BT_MESH_PROVISIONER_MULTIPLE_PROFILE})
    # Unable to find file
if(${CONFIG_BT_MESH_PROVISIONER_RTK_DEMO})
    # Unable to find file
endif()

elseif(${CONFIG_BT_MESH_DEVICE_MULTIPLE_PROFILE})
    # Unable to find file
if (${CONFIG_BT_MESH_DEVICE_RTK_DEMO})
    # Unable to find file
endif()

endif()

list(
    APPEND ${list}

    ${dir}/sdk/board/common/os/freertos/osif_freertos.c 
    ${dir}/sdk/board/amebad/src/platform_utils.c 
    ${dir}/sdk/board/common/src/cycle_queue.c 
    ${dir}/sdk/board/common/src/trace_task.c 
    ${dir}/sdk/board/common/src/hci_process.c
    ${dir}/sdk/board/common/src/hci_adapter.c
    ${dir}/sdk/board/common/src/bt_uart_bridge.c 
    ${dir}/sdk/board/amebad/src/trace_uart.c 
	${dir}/sdk/board/amebad/src/rtk_coex.c 
	${dir}/sdk/board/amebad/src/vendor_cmd/vendor_cmd.c 
	${dir}/sdk/board/amebad/src/hci/hci_uart.c 
    ${dir}/sdk/board/amebad/src/hci/hci_board.c 
    ${dir}/sdk/board/amebad/src/hci/bt_fwconfig.c 
    ${dir}/sdk/board/amebad/src/hci/bt_normal_patch.c 
	${dir}/sdk/board/amebad/src/hci/bt_mp_patch.c 
	${dir}/sdk/bt_example_entry.c

    # bt_beacon 
    ${dir}/sdk/example/bt_beacon/bt_beacon_app.c 
    ${dir}/sdk/example/bt_beacon/bt_beacon_app_main.c 
    ${dir}/sdk/example/bt_beacon/bt_beacon_app_task.c

    # bt_config
    ${dir}/sdk/src/ble/profile/server/simple_ble_service.c 
    ${dir}/sdk/src/ble/profile/server/bas.c 
    ${dir}/sdk/example/bt_config/bt_config_app_main.c 
    ${dir}/sdk/example/bt_config/bt_config_app_task.c 
    ${dir}/sdk/example/bt_config/bt_config_wifi.c 
    ${dir}/sdk/example/bt_config/bt_config_peripheral_app.c 
    ${dir}/sdk/example/bt_config/bt_config_service.c

    # bt_airsync_config
    ${dir}/../../application/airsync/1.0.4/airsync_ble_service.c 
    ${dir}/../../application/airsync/1.0.4/check_endian.c 
    ${dir}/../../application/airsync/1.0.4/epb.c 
    ${dir}/../../application/airsync/1.0.4/epb_MmBp.c 
    ${dir}/../../application/airsync/1.0.4/epb_WristBand.c 
    ${dir}/../../application/airsync/1.0.4/wechat_airsync_protocol.c 
    ${dir}/sdk/example/bt_airsync_config/bt_airsync_config_app_main.c
    ${dir}/sdk/example/bt_airsync_config/bt_airsync_config_app_task.c
    ${dir}/sdk/example/bt_airsync_config/bt_airsync_config_peripheral_app.c 
    ${dir}/sdk/example/bt_config/bt_config_wifi.c 

    # bt_breeze
    # Unable to find file

    # ble_peripheral
    ${dir}/sdk/src/ble/profile/server/simple_ble_service.c 
    ${dir}/sdk/src/ble/profile/server/bas.c 
    ${dir}/sdk/example/ble_peripheral/app_task.c 
    ${dir}/sdk/example/ble_peripheral/ble_app_main.c 
    ${dir}/sdk/example/ble_peripheral/peripheral_app.c 
    ${dir}/sdk/example/ble_peripheral/ble_peripheral_at_cmd.c

    # ble_central
    ${dir}/sdk/src/ble/profile/client/gcs_client.c 
    ${dir}/sdk/src/mcu/module/data_uart_cmd/user_cmd_parse.c 
    ${dir}/sdk/board/amebad/src/data_uart/data_uart.c 
    ${dir}/sdk/example/ble_central/ble_central_app_main.c 
    ${dir}/sdk/example/ble_central/ble_central_app_task.c 
    ${dir}/sdk/example/ble_central/ble_central_client_app.c 
    ${dir}/sdk/example/ble_central/ble_central_link_mgr.c 
    ${dir}/sdk/example/ble_central/user_cmd.c 
    ${dir}/sdk/example/ble_central/ble_central_at_cmd.c

    # ble_scatternet
    ${dir}/sdk/src/ble/profile/client/gcs_client.c 
    ${dir}/sdk/src/mcu/module/data_uart_cmd/user_cmd_parse.c 
    ${dir}/sdk/board/amebad/src/data_uart/data_uart.c 
    ${dir}/sdk/example/ble_scatternet/ble_scatternet_app_main.c 
    ${dir}/sdk/example/ble_scatternet/ble_scatternet_app_task.c 
    ${dir}/sdk/example/ble_scatternet/ble_scatternet_app.c 
    ${dir}/sdk/example/ble_scatternet/ble_scatternet_link_mgr.c
	${dir}/sdk/example/ble_scatternet/ble_scatternet_user_cmd.c
)
endif()

add_executable(
    ${target}
    ${rtl_bluetooth_sources}
)

target_include_directories(
    ${target}
    PUBLIC
    
    # Board specific
    ${dir}/sdk 
    ${dir}/sdk/inc 
    ${dir}/sdk/inc/app 
    ${dir}/sdk/inc/bluetooth/gap 
    ${dir}/sdk/inc/bluetooth/gap/gap_lib 
    ${dir}/sdk/inc/os 
    ${dir}/sdk/inc/platform 
    ${dir}/sdk/inc/bluetooth/profile 
    ${dir}/sdk/inc/bluetooth/profile/client 
    ${dir}/sdk/inc/bluetooth/profile/server 
    ${dir}/sdk/inc/stack 
    ${dir}/sdk/board/amebad/src 
    ${dir}/sdk/board/amebad/src/hci 
    ${dir}/sdk/board/amebad/src/vendor_cmd 
    ${dir}/sdk/board/amebad/lib 
    ${dir}/sdk/board/common/inc

    # bt_beacon
    ${dir}/sdk/example/bt_beacon

    # bt_config
    ${dir}/sdk/example/bt_config

    # bt_airsync_config
    ${dir}/../../application/airsync/1.0.4 
    ${dir}/sdk/example/bt_airsync_config 
    ${dir}/sdk/example/bt_config

    # ble_peripheral
    ${dir}/sdk/example/ble_peripheral

    # ble_central
    ${dir}/sdk/example/ble_central 
    ${dir}/sdk/example/ble_scatternet 
    ${dir}/sdk/board/amebad/src/data_uart 
    ${dir}/sdk/src/mcu/module/data_uart_cmd

    # ble_scatternet
    ${dir}/sdk/example/ble_scatternet 
    ${dir}/sdk/board/amebad/src/data_uart 
    ${dir}/sdk/src/mcu/module/data_uart_cmd
)

if(${CONFIG_BT_MESH_PROVISIONER})
target_include_directories(
    ${target}
    PUBLIC

    # Mesh Provisioner
    ${dir_mesh}/lib/cmd 
    ${dir_mesh}/lib/common 
    ${dir_mesh}/lib/gap 
    ${dir_mesh}/lib/inc
    ${dir_mesh}/lib/inc/amebad 
    ${dir_mesh}/lib/model 
    ${dir_mesh}/lib/model/realtek 
    ${dir_mesh}/lib/platform
    ${dir_mesh}/lib/profile 
    ${dir_mesh}/lib/utility 
    ${dir_mesh}/provisioner 
    ${dir_mesh}/device 
    ${dir_mesh}/api/provisioner 
    ${dir_mesh}/api/common 
    ${dir_sdk}/board/amebad/src/vendor_cmd 
    ${dir_mesh_user_api}/provisioner 
    ${dir_mesh_user_api}/device 
    ${dir_mesh_user_api} 
    ${dir_mesh_prov_rtk_demo}/inc 
)
endif()

if(${CONFIG_BT_MESH_DEVICE})
target_include_directories(
    ${target}
    PUBLIC

    # Mesh Device
    ${dir_mesh}/lib/cmd 
    ${dir_mesh}/lib/common 
    ${dir_mesh}/lib/gap 
    ${dir_mesh}/lib/inc 
    ${dir_mesh}/lib/inc/amebad 
    ${dir_mesh}/lib/model 
    ${dir_mesh}/lib/model/realtek 
    ${dir_mesh}/lib/platform
    ${dir_mesh}/lib/profile 
    ${dir_mesh}/lib/utility 
    ${dir_mesh}/provisioner 
    ${dir_mesh}/device 
    ${dir_sdk}/board/amebad/src/vendor_cmd 
    ${dir_mesh_user_api}/provisioner 
    ${dir_mesh_user_api}/device 
    ${dir_mesh_user_api}
)
endif()

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DUPPER_STACK_USE_NORMAL_HCI -DAMEBAD_BOARD -include bt_flags.h -include stdint.h")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DUPPER_STACK_USE_NORMAL_HCI -DAMEBAD_BOARD -include bt_flags.h -include stdint.h")

