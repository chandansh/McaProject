package com.magicon;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
public class FileUpload
{
  public String doUpload(HttpSession hs,HttpServletRequest req, String foldername,String prefix)throws IOException
  {
  // the directory where the uploaded file will be saved. 
  String savePath = hs.getServletContext().getRealPath("//"); 

  String filename = ""; 

  ServletInputStream in = req.getInputStream(); 

  byte[] line = new byte[128]; 
  int i = in.readLine(line, 0, 128); 
  int boundaryLength = i - 2; 
  String boundary = new String(line, 0, boundaryLength); 

  while (i != -1) {
    String newLine = new String(line, 0, i); 
    if (newLine.startsWith("Content-Disposition: form-data; name=\"")) {
      String s = new String(line, 0, i-2); 
      int pos = s.indexOf("filename=\""); 
      if (pos != -1) {
        String filepath = s.substring(pos+10, s.length()-1); 
        // Windows browsers include the full path on the client 
        // But Linux/Unix and Mac browsers only send the filename 
        // test if this is from a Windows browser 
        pos = filepath.lastIndexOf("\\"); 
        if (pos != -1) 
          filename = filepath.substring(pos + 1); 
        else 
          filename = filepath; 
      } 

      //this is the file content 
      i = in.readLine(line, 0, 128); 
      i = in.readLine(line, 0, 128); 
      // blank line   
      i = in.readLine(line, 0, 128); 

      ByteArrayOutputStream buffer = new ByteArrayOutputStream(); 
      newLine = new String(line, 0, i); 

      while (i != -1 && !newLine.startsWith(boundary)) {
        // the problem is the last line of the file content 
        // contains the new line character. 
        // So, we need to check if the current line is 
        // the last line. 
        buffer.write(line, 0, i); 
        i = in.readLine(line, 0, 128); 
        newLine = new String(line, 0, i); 
      } 
      try {
        // save the uploaded file 
        RandomAccessFile f = new RandomAccessFile(savePath+"/"+foldername+"/"+prefix + filename, "rw"); 
        byte[] bytes = buffer.toByteArray(); 
        f.write(bytes, 0, bytes.length - 2); 
        f.close(); 
      } 
      catch (Exception e) {} 
    } 
    i = in.readLine(line, 0, 128); 
  } // end while
   String path=foldername+"/"+prefix+filename;	 
   return(path);
  
  }//end of function

public boolean dodelete(HttpSession hs,String path)throws IOException
  {
	String filepath=hs.getServletContext().getRealPath("//")+"/"+path;
	File f=new File(filepath);
	boolean b=f.delete();
	return(b);
  }

}//end of class
