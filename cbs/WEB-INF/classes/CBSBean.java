package com.cbs;

import com.cbs.DBConnection;
import java.io.FileInputStream;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class CBSBean
{
 public Connection getConnection(HttpServletRequest req)
  {
    try
    {
      Connection cn = DBConnection.getDBConnection(req);
      return cn;
    } catch (Exception e) {
    }
    return null;
  }

public Connection getConnection(HttpSession hs)
  {
    try
    {
      Connection cn = DBConnection.getDBConnection(hs);
      return cn;
    } catch (Exception e) {
    }
    return null;
  }
}