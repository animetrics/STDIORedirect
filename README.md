STDIORedirect
=============

When working with Java applications or libraries that utilize JNI native code,
it is non-trivial to redirect STDIO from both unmanaged and managed sides of
the application.  This library provides a way to accomplish complete
STDOUT/STDERR redirection, and consists of managed and unmanaged components.
It is Derived from the following blogpost:
http://tabbott.com/2010/09/capturing-native-code-output/

Note: This project is still alpha. 

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

Small test script.  After running you should have a logfile.out file with some logged stdout and stderr output

Change your path to your log4j jar in the following command and run

		java -Djava.library.path=.:Release/ -classpath .:Release/testJniStdio.jar:/Users/marc/.m2/repository/log4j/log4j/1.2.16/log4j-1.2.16.jar testJniStdio.testJniStdio
