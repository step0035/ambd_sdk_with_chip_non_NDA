cmake_minimum_required(VERSION 3.6)

project(Test_cmake_docker_D)

set (sdk_root "${CMAKE_CURRENT_SOURCE_DIR}/../../..")

list(
    APPEND project_hp_sources
	${sdk_root}/component/common/test/Hello/hello_amebad.c
)

add_executable(
	Test_cmake_docker_D ${project_hp_sources}
)
