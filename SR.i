%module SR
%{
#include "STDIORedirectNative.h"
%}

%include "exception.i"
%include "std_string.i"  

//%apply const std::string & {std::string &};

%exception { 
   try { 
     $action 
   } catch (const std::out_of_range& e) { 
     SWIG_exception(SWIG_IndexError, e.what()); 
   } catch (const std::exception& e) { 
     SWIG_exception(SWIG_RuntimeError, e.what()); 
   } catch (...) { 
     SWIG_exception(SWIG_RuntimeError, "unknown exception"); 
   } 
} 

%pragma(java) jniclasscode=%{
  static {
    try {
      System.loadLibrary("SR");
    } catch (UnsatisfiedLinkError e) {
      System.err.println("Native SR library failed to load. \n" + e);
      System.exit(1);
    }
  }
%}

%pragma(java) modulecode=%{
  private static Boolean initialized = false;
  private static STDIORedirectToLog4j sro = null;
  private static STDIORedirectToLog4j sre = null;

  public static synchronized void init() throws Exception 
  {
    if(!SR.initialized)
    {
      SR.sro = new STDIORedirectToLog4j(1);
      SR.sro.setDaemon(true);
      SR.sro.start();

      SR.sre = new STDIORedirectToLog4j(2);
      SR.sre.setDaemon(true);
      SR.sre.start();
      SR.initialized = true;
    }
  }
%}

%include "STDIORedirectNative.h"
