#include "STDIORedirectNative.h"
#include <stdio.h>
#include <unistd.h>
#include <stdexcept>
#include <iostream>

using namespace std;

STDIORedirectNative::STDIORedirectNative(int fileno)
{
	if((fileno != 1) && (fileno != 2))
		throw std::runtime_error("Can only redirect stdout or stderr!");

	if (-1 == pipe(_filedes))
		throw std::runtime_error("pipe failed");
	if (-1 == dup2(_filedes[1], fileno)) 
	{
		close();
		throw std::runtime_error("dup2 failed");
	}

	// set proper buffering
	
  if(1 == fileno)
		setvbuf(stdout, NULL, _IOLBF, 0); // stdout should be line buffered
	else
		setvbuf(stderr, NULL, _IONBF, 0); // stderr no buffer
}

string STDIORedirectNative::read()
{
	static char buf[8192];
	ssize_t res = ::read(_filedes[0], buf, 8192);

	string data;
	switch (res) 
	{
		case 0:
			return data; // stream finished, just return empty string
		case -1:
			throw std::runtime_error("read failed");
			break;
		default:
			data = buf;  // copy buf to string and return
			return data;
	}
}

void STDIORedirectNative::close()
{
	::close(_filedes[0]);
	::close(_filedes[1]);
}

void STDIORedirectNative::testPrint(const char* toPrint)
{
//	std::cout<<"printing "<<toPrint<<std::endl;
	printf("%s", toPrint);
//	fflush(stdout);
}
