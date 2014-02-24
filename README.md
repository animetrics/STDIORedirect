STDIORedirect
=============

stdio/stderr redirection for java that will also redirect stdio for native libraries

BUILD
======

Requires CMake, Swig, and CMake module for Swig. 
Edit CMakeLists.txt and change path to log4j jar

Then to build:

$ mkdir Release
$ cd Release
$ cmake -DCMAKE_BUILD_TYPE=Release ..
$ make

RUN
======

Small test script.  After running you should have a logfile.txt file with some logged stdout and stderr output

Change path to log4j path and run

java -Djava.library.path=.:Release/ -classpath .:Release/testJniStdio.jar:/Users/marc/.m2/repository/log4j/log4j/1.2.16/log4j-1.2.16.jar testJniStdio.testJniStdio
