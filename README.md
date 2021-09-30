# Matter (previously CHIP) on AmebaD

## Get AmebaD SDK (Tested on Ubuntu 20.04)

    mkdir ${HOME}/AmebaD_with_CHIP
    
    cd ${HOME}/AmebaD_with_CHIP
    
    git clone https://github.com/pankore/ambd_sdk_with_chip_non_NDA.git
    
## Get Matter SDK

    cd ${HOME}/AmebaD_with_CHIP

    git clone -b B0707 https://github.com/pankore/connectedhomeip


## Set Matter Build Environment 

    cd ${HOME}/AmebaD_with_CHIP/connectedhomeip

    source scripts/bootstrap.sh

    source scripts/activate.sh

    > Find more details to setup linux build environment
    > https://github.com/pankore/connectedhomeip/blob/master/docs/BUILDING.md

## Matter Ameba-D All Clusters Example

    cd ${HOME}/AmebaD_with_CHIP/connectedhomeip/examples/all-clusters-app/ambd

    ./build.sh

## Make Little CPU

    cd ${HOME}/AmebaD_with_CHIP/ambd_sdk_with_chip_non_NDA/project/realtek_amebaD_va0_example/GCC-RELEASE/project_lp

    make all

    output : project/realtek_amebaD_va0_example/GCC-RELEASE/project_lp/asdk/image/km0_boot_all.bin

## Make CHIP library by gn and Make lib_main.a

    cd ${HOME}/AmebaD_with_CHIP/ambd_sdk_with_chip_non_NDA/project/realtek_amebaD_va0_example/GCC-RELEASE/project_hp

    make -C asdk lib_all


### CHIP core (generate by GN/ninja in connectedhomeip. Config by [chip/Makefile](https://github.com/pankore/ambd_sdk_with_chip_non_NDA/blob/main/project/realtek_amebaD_va0_example/GCC-RELEASE/project_hp/asdk/make/chip/Makefile))

    output : ambd_sdk_with_chip_non_NDA/project/realtek_amebaD_va0_example/GCC-RELEASE/project_hp/asdk/lib/application

    > libCHIP.a, ibCoreTests.a, ibChipCryptoTests.a, ibRawTransportTests.a...

### CHIP application (generate by [chip_main/Makefile](https://github.com/pankore/ambd_sdk_with_chip_non_NDA/blob/main/project/realtek_amebaD_va0_example/GCC-RELEASE/project_hp/asdk/make/chip_main/Makefile))

    output : ambd_sdk_with_chip_non_NDA/project/realtek_amebaD_va0_example/GCC-RELEASE/project_hp/asdk/lib/application

    > lib_main.a

## Make Big CPU
    cd ${HOME}/AmebaD_with_CHIP/ambd_sdk_with_chip_non_NDA/project/realtek_amebaD_va0_example/GCC-RELEASE/project_hp

    make all
    
    output : 

    project/realtek_amebaD_va0_example/GCC-RELEASE/project_hp/asdk/image/km4_boot_all.bin
    
    project/realtek_amebaD_va0_example/GCC-RELEASE/project_hp/asdk/image/km0_km4_image2.bin

## Flash Image on AmebaD EVB

Please refer [Application Note](https://github.com/pankore/ambd_sdk_with_chip_non_NDA/blob/master/doc/AN0400%20Ameba-D%20Application%20Note%20v14.pdf) Chapter 8 : Image Tool

    Image Tool Path : $(SDK_ROOT)/tools/AmebaD/Image_Tool/
    

## Run CHIP task on Ameba D (all-cluster-app example)
    enter command in console

    ATW0=testAP

    ATW1=password

    ATWC

    ATS$ => Run chip task


## Test with [chip-tool](https://github.com/pankore/connectedhomeip/tree/master/examples/chip-tool)
Use standalone chip-tool app(linux) to communicate with the device.

	./chip-tool pairing bypass xxx.xxx.xxx.xxx 5540  (Ameba IP)

<b>onoff cluster</b>

Use PB_5 as output, connect a LED to this pin and GND.

	./chip-tool onoff on 1

	./chip-tool onoff off 1
    
<b>doorlock cluster</b>

	./chip-tool doorlock lock-door 1 1
    
	./chip-tool doorlock unlock-door 1 1

## Test with [Python Controller](https://github.com/pankore/connectedhomeip/blob/master/docs/guides/python_chip_controller_building.md)
To build the Python Controller (linux), run the following command.

	./scripts/build_python.sh --clusters_for_ip_commissioning true --chip_mdns platform

To launch Python Controller, activate the python environment first.

	source out/python_env/bin/activate
	chip-device-ctrl

#### IP Commissioning
* In "connectedhomeip/config/ambd/args.gni"
	* Set `chip_ip_commissioning = true`
	* Set `chip_use_clusters_for_ip_commissioning = true`
	* Set `chip_config_network_layer_ble = false`

* In "connectedhomeip/src/platform/AMBD/CHIPDevicePlatformConfig.h"
	* Set `#define CONFIG_USE_CLUSTERS_FOR_IP_COMMISSIONING	1`

* Build and Flash
* Connect to AP using `ATW` commands
* Enter the ATCMD `ATS$`
* Run python controller IP commissioning command `chip-device-ctrl > connect -ip <IP> 20202021 135246`
* Resolve mDNS `chip-device-ctrl >resolve 0 135246`
* On-Off cluster command `chip-device-ctrl >zcl OnOff On 135246 1 1`
* On-Off cluster command `chip-device-ctrl >zcl OnOff Off 135246 1 1`