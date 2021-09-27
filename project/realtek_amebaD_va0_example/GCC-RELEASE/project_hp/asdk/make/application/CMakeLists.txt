cmake_minimum_required(VERSION 3.6)

project(application)

set(sdk_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../../../../..")
set(prj_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../../..")
set(dir_duerapp "${sdk_root}/component/common/application/baidu/duerapp/src")
set(dir_libduer "${sdk_root}/component/common/application/baidu/libduer-device")
set(dir_mqttclient "${sdk_root}/component/common/application/mqtt/MQTTClient")
set(dir_mqttpacket "${sdk_root}/component/common/application/mqtt/MQTTPacket")
set(target application)
set(list application_sources)

# Temporary setting of macros
set(CONFIG_BAIDU_DUER OFF)   # Unable to find file
set(CONFIG_MQTT_EN ON)

message(STATUS "Building \"${target}\" folder")

list(
    APPEND ${list}

)

if(${CONFIG_BAIDU_DUER})
list(
    APPEND ${list}

    # duerapp
    ${dir_duerapp}/public/duerapp.c 
    ${dir_duerapp}/public/duerapp_alert.c 
    ${dir_duerapp}/public/duerapp_audio.c 
    ${dir_duerapp}/public/duerapp_dcs_handler.c 
    ${dir_duerapp}/public/duerapp_event.c 
    ${dir_duerapp}/public/duerapp_media.c 
    ${dir_duerapp}/public/duerapp_ota.c 
    ${dir_duerapp}/public/amebad/duerapp_ota_flash.c 
    ${dir_duerapp}/public/duerapp_tone_config.c 
    ${dir_duerapp}/public/duerapp_user_defined.c 
    ${dir_duerapp}/public/duerapp_wifi_config.c 
    ${dir_duerapp}/private/duerapp_media_parser.c 
    ${dir_duerapp}/private/duerapp_media_player.c
    ${dir_duerapp}/private/duerapp_play_event.c 
    ${dir_duerapp}/private/duerapp_play_tone.c 
    ${dir_duerapp}/private/duerapp_profile_config.c 
    ${dir_duerapp}/private/duerapp_recorder.c 
    ${dir_duerapp}/private/duerapp_sdcard_config.c 
    ${dir_duerapp}/private/duerapp_sdcard_record.c 
    ${dir_duerapp}/public/amebad/duerapp_rl6548_play.c 
    ${dir_duerapp}/public/amebad/duerapp_rl6548_record.c 
    ${dir_duerapp}/public/amebad/duerapp_rl6548_play.c 
    ${dir_duerapp}/public/amebad/duerapp_rl6548_audio.c
    ${dir_duerapp}/public/amebad/duerapp_amebad_peripheral.c

    #libduer
    ${dir_libduer}/external/baidu_json.c 
    ${dir_libduer}/external/mbed-client-c/source/libCoap/sn_coap_builder.c 
    ${dir_libduer}/external/mbed-client-c/source/libCoap/sn_coap_header_check.c 
    ${dir_libduer}/external/mbed-client-c/source/libCoap/sn_coap_parser.c 
    ${dir_libduer}/external/mbed-client-c/source/libCoap/sn_coap_protocol.c 
    ${dir_libduer}/external/mbed-client-c/source/libCoap/sn_grs.c 
    ${dir_libduer}/external/mbed-client-c/source/libCoap/sn_nsdl.c 
    ${dir_libduer}/external/mbed-trace/source/mbed_trace.c 
    ${dir_libduer}/external/speex/libspeex/bits.c 
    ${dir_libduer}/external/speex/libspeex/cb_search.c 
    ${dir_libduer}/external/speex/libspeex/exc_10_16_table.c 
    ${dir_libduer}/external/speex/libspeex/exc_10_32_table.c 
    ${dir_libduer}/external/speex/libspeex/exc_20_32_table.c 
    ${dir_libduer}/external/speex/libspeex/exc_5_256_table.c 
    ${dir_libduer}/external/speex/libspeex/exc_5_64_table.c 
    ${dir_libduer}/external/speex/libspeex/exc_8_128_table.c 
    ${dir_libduer}/external/speex/libspeex/fftwrap.c 
    ${dir_libduer}/external/speex/libspeex/filterbank.c 
    ${dir_libduer}/external/speex/libspeex/filters.c 
    ${dir_libduer}/external/speex/libspeex/gain_table.c 
    ${dir_libduer}/external/speex/libspeex/gain_table_lbr.c 
    ${dir_libduer}/external/speex/libspeex/hexc_10_32_table.c 
    ${dir_libduer}/external/speex/libspeex/hexc_table.c 
    ${dir_libduer}/external/speex/libspeex/high_lsp_tables.c 
    ${dir_libduer}/external/speex/libspeex/jitter.c 
    ${dir_libduer}/external/speex/libspeex/kiss_fft.c
    ${dir_libduer}/external/speex/libspeex/kiss_fftr.c 
    ${dir_libduer}/external/speex/libspeex/lbr_48k_tables.c 
    ${dir_libduer}/external/speex/libspeex/lpc.c 
    ${dir_libduer}/external/speex/libspeex/lsp.c 
    ${dir_libduer}/external/speex/libspeex/lsp_tables_nb.c 
    ${dir_libduer}/external/speex/libspeex/ltp.c 
    ${dir_libduer}/external/speex/libspeex/math_approx.c 
    ${dir_libduer}/external/speex/libspeex/mdf.c 
    ${dir_libduer}/external/speex/libspeex/misc.c 
    ${dir_libduer}/external/speex/libspeex/modes.c 
    ${dir_libduer}/external/speex/libspeex/nb_celp.c 
    ${dir_libduer}/external/speex/libspeex/preprocess.c 
    ${dir_libduer}/external/speex/libspeex/quant_lsp.c 
    ${dir_libduer}/external/speex/libspeex/resample.c 
    ${dir_libduer}/external/speex/libspeex/sb_celp.c
    ${dir_libduer}/external/speex/libspeex/smallft.c 
    ${dir_libduer}/external/speex/libspeex/speex.c 
    ${dir_libduer}/external/speex/libspeex/speex_callbacks.c 
    ${dir_libduer}/external/speex/libspeex/speex_header.c 
    ${dir_libduer}/external/speex/libspeex/stereo.c 
    ${dir_libduer}/external/speex/libspeex/vbr.c 
    ${dir_libduer}/external/speex/libspeex/vorbis_psy.c 
    ${dir_libduer}/external/speex/libspeex/vq.c 
    ${dir_libduer}/external/speex/libspeex/window.c 
    ${dir_libduer}/framework/core/lightduer_debug.c 
    ${dir_libduer}/framework/core/lightduer_memory.c 
    ${dir_libduer}/framework/core/lightduer_mutex.c 
    ${dir_libduer}/framework/core/lightduer_net_trans_encrypted.c 
    ${dir_libduer}/framework/core/lightduer_net_transport.c 
    ${dir_libduer}/framework/core/lightduer_net_transport_wrapper.c 
    ${dir_libduer}/framework/core/lightduer_random.c 
    ${dir_libduer}/framework/core/lightduer_sleep.c 
    ${dir_libduer}/framework/core/lightduer_timestamp.c 
    ${dir_libduer}/framework/utils/lightduer_hashcode.c 
    ${dir_libduer}/framework/utils/lightduer_net_util.c 
    ${dir_libduer}/framework/utils/lightduer_queue_cache.c 
    ${dir_libduer}/framework/utils/lightduer_bitmap.c 
    ${dir_libduer}/framework/utils/lightduer_handler.c 
    ${dir_libduer}/framework/utils/lightduer_snprintf.c 
    ${dir_libduer}/modules/coap/lightduer_coap.c 
    ${dir_libduer}/modules/coap/lightduer_coap_ep.c 
    ${dir_libduer}/modules/coap/lightduer_coap_trace.c 
    ${dir_libduer}/modules/coap/lightduer_nsdl_adapter.c 
    ${dir_libduer}/modules/connagent/lightduer_ca.c 
    ${dir_libduer}/modules/connagent/lightduer_ca_conf.c 
    ${dir_libduer}/modules/connagent/lightduer_connagent.c 
    ${dir_libduer}/modules/connagent/lightduer_data_cache.c 
    ${dir_libduer}/modules/connagent/lightduer_engine.c 
    ${dir_libduer}/modules/connagent/lightduer_event_emitter.c 
    ${dir_libduer}/modules/dcs/lightduer_dcs_alert.c 
    ${dir_libduer}/modules/dcs/lightduer_dcs_audio_player.c 
    ${dir_libduer}/modules/dcs/lightduer_dcs_device_contorl.c 
    ${dir_libduer}/modules/dcs/lightduer_dcs_dummy.c 
    ${dir_libduer}/modules/dcs/lightduer_dcs_local.c 
    ${dir_libduer}/modules/dcs/lightduer_dcs_playback_control.c 
    ${dir_libduer}/modules/dcs/lightduer_dcs_router.c 
    ${dir_libduer}/modules/dcs/lightduer_dcs_screen.c 
    ${dir_libduer}/modules/dcs/lightduer_dcs_speaker_control.c 
    ${dir_libduer}/modules/dcs/lightduer_dcs_system.c 
    ${dir_libduer}/modules/dcs/lightduer_dcs_voice_input.c 
    ${dir_libduer}/modules/dcs/lightduer_dcs_voice_output.c 
    ${dir_libduer}/modules/dcs/lightduer_dcs_miscellaneous.c 
    ${dir_libduer}/modules/Device_Info/lightduer_dev_info.c 
    ${dir_libduer}/modules/device_status/lightduer_ds_log.c 
    ${dir_libduer}/modules/device_status/lightduer_ds_log_ca.c 
    ${dir_libduer}/modules/device_status/lightduer_ds_log_audio.c 
    ${dir_libduer}/modules/device_status/lightduer_ds_log_audio_player.c 
    ${dir_libduer}/modules/device_status/lightduer_ds_log_cache.c 
    ${dir_libduer}/modules/device_status/lightduer_ds_log_dcs.c 
    ${dir_libduer}/modules/device_status/lightduer_ds_log_e2e.c 
    ${dir_libduer}/modules/device_status/lightduer_ds_log_http.c
    ${dir_libduer}/modules/device_status/lightduer_ds_log_recorder.c 
    ${dir_libduer}/modules/device_status/lightduer_ds_report.c 
    ${dir_libduer}/modules/device_status/lightduer_ds_report_ca.c 
    ${dir_libduer}modules/device_status/lightduer_ds_log_bind.c 
    ${dir_libduer}modules/flash_strings/lightduer_flash_strings.c 
    ${dir_libduer}/modules/interactive_class/lightduer_interactive_class.c 
    ${dir_libduer}/modules/HTTP/lightduer_http_client.c 
    ${dir_libduer}/modules/HTTP/lightduer_http_client_ops.c 
    ${dir_libduer}/modules/HTTP/lightduer_http_dns_client_ops.c 
    ${dir_libduer}/modules/ntp/lightduer_net_ntp.c 
    ${dir_libduer}/modules/OTA/Downloader/lightduer_ota_downloader.c 
    ${dir_libduer}/modules/OTA/Downloader/lightduer_ota_http_downloader.c 
    ${dir_libduer}/modules/OTA/Notifier/lightduer_ota_notifier.c 
    ${dir_libduer}/modules/OTA/Decompression/lightduer_ota_decompression.c 
    ${dir_libduer}/modules/OTA/Decompression/lightduer_ota_zlib.c 
    ${dir_libduer}/modules/OTA/Installer/lightduer_ota_installer.c 
    ${dir_libduer}/modules/OTA/Unpacker/lightduer_ota_unpacker.c 
    ${dir_libduer}/modules/OTA/Updater/lightduer_ota_updater.c 
    ${dir_libduer}/modules/OTA/Verifier/lightduer_ota_verifier.c 
    ${dir_libduer}/modules/SystemInfo/lightduer_system_info.c 
    ${dir_libduer}/modules/bind_device/lightduer_bind_device.c 
    ${dir_libduer}/modules/voice_engine/lightduer_session.c 
    ${dir_libduer}/modules/voice_engine/lightduer_speex.c 
    ${dir_libduer}/modules/voice_engine/lightduer_voice.c 
    ${dir_libduer}/modules/voice_engine/lightduer_store_voice.c 
    ${dir_libduer}/external/Zliblite/adler32.c 
    ${dir_libduer}/external/Zliblite/compress.c 
    ${dir_libduer}/external/Zliblite/crc32.c 
    ${dir_libduer}/external/Zliblite/deflate.c 
    ${dir_libduer}/external/Zliblite/infback.c 
    ${dir_libduer}/external/Zliblite/inffast.c 
    ${dir_libduer}/external/Zliblite/inflate.c 
    ${dir_libduer}/external/Zliblite/inftrees.c
    ${dir_libduer}/external/Zliblite/trees.c 
    ${dir_libduer}/external/Zliblite/uncompr.c 
    ${dir_libduer}/external/Zliblite/zutil.c 
    ${dir_libduer}/platform/source-freertos/baidu_ca_adapter.c 
    ${dir_libduer}/platform/source-freertos/baidu_ca_debug_adp.c 
    ${dir_libduer}/platform/source-freertos/baidu_ca_memory_adp.c 
    ${dir_libduer}/platform/source-freertos/baidu_ca_mutex_adp.c 
    ${dir_libduer}/platform/source-freertos/baidu_ca_socket_adp.c 
    ${dir_libduer}/platform/source-freertos/lightduer_events.c 
    ${dir_libduer}/platform/source-freertos/lightduer_priority_conf.c 
    ${dir_libduer}/platform/source-freertos/lightduer_statistics.c 
    ${dir_libduer}/platform/source-freertos/lightduer_timers.c 
    ${dir_libduer}/platform/source-freertos/lightduer_adapter_config.c
)
endif()	

if(${CONFIG_MQTT_EN})
list(
    APPEND ${list}

    # MQTTClient
    ${dir_mqttclient}/MQTTClient.c
    ${dir_mqttclient}/MQTTFreertos.c

    #MQTTPacket
    ${dir_mqttpacket}/MQTTConnectClient.c
    ${dir_mqttpacket}/MQTTConnectServer.c
    ${dir_mqttpacket}/MQTTDeserializePublish.c
    ${dir_mqttpacket}/MQTTFormat.c
    ${dir_mqttpacket}/MQTTPacket.c
    ${dir_mqttpacket}/MQTTSerializePublish.c
    ${dir_mqttpacket}/MQTTSubscribeClient.c
    ${dir_mqttpacket}/MQTTSubscribeServer.c
    ${dir_mqttpacket}/MQTTUnsubscribeClient.c
    ${dir_mqttpacket}/MQTTUnsubscribeServer.c
)
endif()

add_executable(
    ${target}
    ${application_sources}
)

if(${CONFIG_BAIDU_DUER})
target_include_directories(
    ${target}
    PUBLIC
    # duerapp
    ${dir_duerapp}/../include 
    ${dir_duerapp}/../include/amebad 
    ${sdk_root}/component/common/application/baidu/libduer-device/modules/connagent 
    ${sdk_root}/component/common/application/baidu/libduer-device/modules/voice_engine 
    ${sdk_root}/component/common/application/baidu/libduer-device/modules/ntp 
    ${sdk_root}/component/common/application/baidu/libduer-device/modules/dcs 
    ${sdk_root}/component/common/application/baidu/libduer-device/modules/system_info 
    ${sdk_root}/component/common/application/baidu/libduer-device/modules/device_status 
    ${sdk_root}/component/common/application/baidu/libduer-device/modules/device_info 
    ${sdk_root}/component/common/application/baidu/libduer-device/modules/ota/Updater 
    ${sdk_root}/component/common/application/baidu/libduer-device/modules/ota/Unpacker 
    ${sdk_root}/component/common/application/baidu/libduer-device/modules/ota/Downloader 
    ${sdk_root}/component/common/application/baidu/libduer-device/modules/ota/Notifier 
    ${sdk_root}/component/common/application/baidu/libduer-device/modules/ota/Verifier 
    ${sdk_root}/component/common/application/baidu/libduer-device/modules/ota/Decompression 
    ${sdk_root}/component/common/application/baidu/libduer-device/modules/ota/Installer 
    ${sdk_root}/component/common/application/baidu/libduer-device/modules/http 
    ${sdk_root}/component/common/application/baidu/libduer-device/framework/include 
    ${sdk_root}/component/common/application/baidu/libduer-device/framework/core 
    ${sdk_root}/component/common/application/baidu/libduer-device/platform/include 
    ${sdk_root}/component/common/application/baidu/libduer-device/external/baidu_json	
    ${sdk_root}/component/common/application/baidu/libduer-device/sdk_headers	
    ${sdk_root}/component/common/audio/mp3	
    ${sdk_root}/component/common/file_system/fatfs/r0.10c/include 
    ${sdk_root}/component/common/file_system/fatfs	
    ${sdk_root}/component/common/drivers/sdio/realtek/sdio_host/inc
    
    #libduer
    ${dir_libduer}/external/baidu_json 
    ${dir_libduer}/external/mbed-client-c/nsdl-c 
    ${dir_libduer}/external/mbed-client-c/source/libCoap/src/include 
    ${dir_libduer}/external/mbed-client-c/source/libNsdl/src/include 
    ${dir_libduer}/external/mbed-client-c-port 
    ${dir_libduer}/external/mbed-trace 
    ${dir_libduer}/external/speex/include 
    ${dir_libduer}/external/speex/libspeex 
    ${dir_libduer}/external/Zliblite 
    ${dir_libduer}/framework/include 
    ${dir_libduer}/framework/core 
    ${dir_libduer}/framework/utils 
    ${dir_libduer}/modules/coap 
    ${dir_libduer}/modules/connagent 
    ${dir_libduer}/modules/dcs 
    ${dir_libduer}/modules/Device_Info 
    ${dir_libduer}/modules/device_status 
    ${dir_libduer}/modules/HTTP 
    ${dir_libduer}/modules/ntp 
    ${dir_libduer}/modules/OTA
    ${dir_libduer}/modules/OTA/Downloader 
    ${dir_libduer}/modules/OTA/Notifier 
    ${dir_libduer}/modules/OTA/Unpacker
    ${dir_libduer}/modules/OTA/Updater 
    ${dir_libduer}/modules/OTA/Zliblite
    ${dir_libduer}/modules/ota/Verifier
    ${dir_libduer}/modules/ota/Decompression 
    ${dir_libduer}/modules/ota/Installer 
    ${dir_libduer}/modules/System_Info 
    ${dir_libduer}/modules/voice_engine 
    ${dir_libduer}/platform/source-freertos 
    ${dir_libduer}/platform/include 
    ${dir_libduer}/../duerapp/include
)
endif()
