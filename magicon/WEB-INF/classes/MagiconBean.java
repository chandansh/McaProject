package com.magicon;

import com.magicon.DBConnection;
import java.io.FileInputStream;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class MagiconBean
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
}