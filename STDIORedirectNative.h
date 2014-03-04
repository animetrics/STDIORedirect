#pragma once

#include <string>

class STDIORedirectNative
{
	int _filedes[2];
  char _buf[8192];

	public:

	STDIORedirectNative(int fileno);
	std::string read();
	void close();
	void testPrint(const char* toPrint);
};
