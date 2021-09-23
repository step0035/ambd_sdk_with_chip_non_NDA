cmake_minimum_required(VERSION 3.6)

project(make)

set(sdk_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../../../..")
set(prj_root "${CMAKE_CURRENT_SOURCE_DIR}/../../../..")

macro(SUBDIRLIST result curdir)
  file(GLOB children RELATIVE ${curdir} ${curdir}/*)
  set(dirlist "")
  foreach(child ${children})
    if(IS_DIRECTORY ${curdir}/${child})
      list(APPEND dirlist ${child})
    endif()
  endforeach()
  set(${result} ${dirlist})
endmacro()

SUBDIRLIST(SUBDIRS ${CMAKE_CURRENT_SOURCE_DIR})

foreach(subdir ${SUBDIRS})
  add_subdirectory(${subdir})
endforeach()
