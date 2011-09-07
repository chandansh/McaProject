package com.cbs;

import java.io.FileInputStream;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class DBConnection
{
public static Connection getDBConnection(HttpServletRequest req)
    throws Exception
  {
    Connection cn = null;
    Properties pr = System.getProperties();
    try
    {
      String serverPath = req.getSession().getServletContext().getRealPath("//");
      FileInputStream file = new FileInputStream(serverPath + "\\etc\\DBFile.properties");
      pr.load(file);
      String driver = pr.getProperty("driver");
      String url = pr.getProperty("url");
      String userName = pr.getProperty("userName");
      String password = pr.getProperty("password");
      System.out.println("in conn" + driver);
      System.out.println(url);
      System.out.println(userName);
      System.out.println(password);
      Class.forName(driver);
      cn = DriverManager.getConnection(url, userName, password);
    }
    catch (Exception e)
    {
      System.out.print("inside the DBConnection: " + e);
      throw e;
    }
    return cn;
  }
public static Connection getDBConnection(HttpSession hs)
    throws Exception
  {
    Connection cn = null;
    Properties pr = System.getProperties();
    try
    {
      String serverPath = hs.getServletContext().getRealPath("//");
      FileInputStream file = new FileInputStream(serverPath + "\\etc\\DBFile.properties");
      pr.load(file);
      String driver = pr.getProperty("driver");
      String url = pr.getProperty("url");
      String userName = pr.getProperty("userName");
      String password = pr.getProperty("password");
      System.out.println("in conn" + driver);
      System.out.println(url);
      System.out.println(userName);
      System.out.println(password);
      Class.forName(driver);
      cn = DriverManager.getConnection(url, userName, password);
    }
    catch (Exception e)
    {
      System.out.print("inside the DBConnection: " + e);
      throw e;
    }
    return cn;
  }
}