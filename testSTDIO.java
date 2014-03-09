package testSTDIO;

import java.io.*;
import com.animetrics.utils.SR;

public class testSTDIO
{
	public static void main(String[] args) throws Exception
	{
		SR.init();
		System.out.println("from java stdout");
		System.err.println("from java stderr");
		Thread.sleep(1000);
	}
}
