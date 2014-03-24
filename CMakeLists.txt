cmake_minimum_required(VERSION 2.8)

find_package(SWIG REQUIRED)
find_package(JNI REQUIRED)
find_package(Java REQUIRED)

include(${SWIG_USE_FILE}) 

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -fno-strict-aliasing")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -fno-strict-aliasing")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -Wall -fno-strict-aliasing")
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -Wall -fno-strict-aliasing")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -DDEBUG -Wall -g -fno-strict-aliasing")
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -DDEBUG -Wall -g -fno-strict-aliasing")

include_directories(${JAVA_INCLUDE_PATH})  
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/package)

if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
	set(CMAKE_INSTALL_RPATH \$ORIGIN)
	include_directories(${JAVA_INCLUDE_PATH}/linux)  
endif()
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

set(CMAKE_JAVA_INCLUDE_PATH /Users/marc/.m2/repository/log4j/log4j/1.2.16/log4j-1.2.16.jar)
#set(CMAKE_JAVA_INCLUDE_PATH /home/clean/.m2/repository/log4j/log4j/1.2.16/log4j-1.2.16.jar)

set(CMAKE_SWIG_OUTDIR ${CMAKE_CURRENT_BINARY_DIR}/com/animetrics/utils)

set(CMAKE_SWIG_FLAGS "-package" "com.animetrics.utils")

set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES "${ADDITIONAL_MAKE_CLEAN_FILES};${CMAKE_SWIG_OUTDIR}")

set_source_files_properties(SR.i PROPERTIES CPLUSPLUS ON)

swig_add_module(SR Java SR.i STDIORedirectNative.cpp)

add_custom_command(
  OUTPUT ${CMAKE_SWIG_OUTDIR}/STDIORedirectToLog4j.java
	COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/STDIORedirectToLog4j.java ${CMAKE_CURRENT_BINARY_DIR}/com/animetrics/utils/
	DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/STDIORedirectToLog4j.java)

add_custom_target(copy_java
  DEPENDS ${CMAKE_SWIG_OUTDIR}/STDIORedirectToLog4j.java)

set_source_files_properties( ${CMAKE_SWIG_OUTDIR}/STDIORedirectToLog4j.java PROPERTIES GENERATED TRUE )

include(UseJava)

add_jar(com.animetrics.utils ${CMAKE_SWIG_OUTDIR}/*.java)
add_dependencies(com.animetrics.utils copy_java)


install(TARGETS SR DESTINATION lib)
install_jar(com.animetrics.utils jar/)

# add a test client 
set(CMAKE_JAVA_INCLUDE_PATH com.animetrics.utils.jar /Users/marc/.m2/repository/log4j/log4j/1.2.16/log4j-1.2.16.jar)
#set(CMAKE_JAVA_INCLUDE_PATH com.animetrics.utils.jar /home/clean/.m2/repository/log4j/log4j/1.2.16/log4j-1.2.16.jar)

add_jar(testSTDIO testSTDIO.java)
