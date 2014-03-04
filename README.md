STDIORedirect
=============

When working with Java applications or libraries that utilize JNI native code,
it is non-trivial to redirect STDIO from both unmanaged and managed sides of
the application.  This library provides a way to accomplish complete
STDOUT/STDERR redirection.  The top level class will redirect to log4j, but the
STDIORedirect.java class can be followed to create another class that will
redirect elsewhere. 

This project is inspired by the following blogpost:
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
		$ make install

make install will create Release/jar/com.animetrics.utils.jar and Release/lib/libSR.so

USE
=====

Copy com.animetrics.utils.jar and libSR.so to your classpath and
java.library.path respectively.  In your application, import
com.animetrics.utils.SR and call SR.init();


Example
======

Small example script.  After running it you should have a logfile.out file with
some logged stdout and stderr output

Change the log4j path in the following command and run

		java -Djava.library.path=.:Release/ -classpath .:Release/testJniStdio.jar:/Users/marc/.m2/repository/log4j/log4j/1.2.16/log4j-1.2.16.jar testJniStdio.testJniStdio
