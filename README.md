STDIORedirect
=============

When working with Java applications or libraries that utilize JNI native code,
it is [non-trivial](http://tabbott.com/2010/09/capturing-native-code-output/)
to redirect STDIO from both unmanaged and managed sides of the application.
This library provides a way to accomplish complete STDOUT/STDERR redirection,
currently only for POSIX compliant systems (tested in Linux and OSX).  It
consists of a native Cpp class, STDIORedirectNative, which uses pipe and dup2
to create a new file descriptor pair with STDOUT or STDERR attached to the
write end of the pipe.  It also provides a method for reading from the pipe,
which can be used to capture the written output.  This class is automatically
wrapped in JNI and Java using [SWIG](http://www.swig.org/) to provide
STDIORedirectNative as a Java class so that output can be captured on the Java
side.  A top level class, STDIORedirectToLog4j extends Thread to read from
STDIORedirectNative.read() and writes the output to a Log4j logger.  A static
method SR.init() can be used to instantiate STDIORedirectToLog4j threads for
STDOUT and STDERR. 

STDIORedirectToLog4j can be followed to create another class that will redirect
more generically to an OutputStream. 

This project is derived from the STDIO redirect solution in the following
blogpost: http://tabbott.com/2010/09/capturing-native-code-output/


BUILD
======

Requires CMake, Swig, and the CMake module for Swig. 
Edit CMakeLists.txt and change the path to the log4j jar

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

testSTDIO.java is a small example script (doesn't test native side).  After
running it you should have a logfile.out file with some logged stdout and
stderr output

Change the log4j path in the following command and run

		java -Djava.library.path=.:Release/ -classpath .:Release/testSTDIO.jar:/Users/marc/.m2/repository/log4j/log4j/1.2.16/log4j-1.2.16.jar testSTDIO.testSTDIO
