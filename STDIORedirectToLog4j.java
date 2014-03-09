package com.animetrics.utils;

import org.apache.log4j.Logger;

public class STDIORedirectToLog4j extends Thread {

  private final STDIORedirectNative srNative;
  private final Logger log;
  private final int fileno;

  public STDIORedirectToLog4j(int fileno)
  {
    this.fileno = fileno;
    this.srNative = new STDIORedirectNative(this.fileno);
    this.log = Logger.getLogger("STDIO");
  }
  
  public void run()
  {

    String s = new String();
    try 
    {
      while (true) 
      {
        s = this.srNative.read();
        if(0 == s.length())
          break;

        // since logger adds a new line, remove trailing new line

        s = s.replaceAll("[\r]?[\n]?$", "");

        // if we are left with an empty string, don't print

        if(s.length() > 0)
        {
          if(1 == this.fileno)
            this.log.info(s);
          else
            this.log.error(s);
        }
      }
    }
    catch (Exception ex) 
    {
      this.srNative.close();
      ex.printStackTrace();
    }
    finally
    {
      this.srNative.close();
    }
  }

}
