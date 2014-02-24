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
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

set(CMAKE_JAVA_INCLUDE_PATH /Users/marc/.m2/repository/log4j/log4j/1.2.16/log4j-1.2.16.jar)

set(CMAKE_SWIG_OUTDIR ${CMAKE_CURRENT_BINARY_DIR}/com/animetrics/utils)

set(CMAKE_SWIG_FLAGS "-package" "com.animetrics.utils")

set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES "${ADDITIONAL_MAKE_CLEAN_FILES};${CMAKE_SWIG_OUTDIR};${CMAKE_CURRENT_BINARY_DIR}/javadoc")

set_source_files_properties(SR.i PROPERTIES CPLUSPLUS ON)

swig_add_module(SR Java SR.i STDIORedirectNative.cpp)

add_custom_command(
  TARGET SR 
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/STDIORedirect.java ${CMAKE_CURRENT_BINARY_DIR}/com/animetrics/utils
	DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/STDIORedirect.java)

include(UseJava)

add_jar(com.animetrics.utils ${CMAKE_SWIG_OUTDIR}/*.java)

get_target_property(THE_JAR_FILE com.animetrics.utils JAR_FILE)

install(TARGETS SR DESTINATION lib)
install_jar(com.animetrics.utils jar/)

# add a test client 
#set(CMAKE_JAVA_INCLUDE_PATH ${THE_JAR_FILE} /Users/marc/.m2/repository/log4j/log4j/1.2.16/log4j-1.2.16.jar)
set(CMAKE_JAVA_INCLUDE_PATH com.animetrics.utils.jar /Users/marc/.m2/repository/log4j/log4j/1.2.16/log4j-1.2.16.jar)

add_jar(testJniStdio testJniStdio.java)