#pragma once

#include <string>

class STDIORedirectNative
{
	int _filedes[2];

	public:

	STDIORedirectNative(int fileno);
	std::string read();
	void close();
	void testPrint(const char* toPrint);
};
