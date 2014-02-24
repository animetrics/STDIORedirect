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
  public static void init() throws Exception {
        STDIORedirect sr = new STDIORedirect(1);
        sr.setDaemon(true);
        sr.start();
        STDIORedirect sre = new STDIORedirect(2);
        sre.setDaemon(true);
        sre.start();
  }
%}

%include "STDIORedirectNative.h"
