package testJniStdio;

import java.io.*;
import com.animetrics.utils.*;
//import org.apache.log4j.Logger;

public class testJniStdio
{
	public static void main(String[] args) throws Exception
	{
		SR.init();
		System.out.println("from java stdout");
		System.err.println("from java stderr");
		Thread.sleep(1000);
	}
}
