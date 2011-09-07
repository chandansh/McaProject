package com.cbs;
import java.util.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class UserLog implements HttpSessionAttributeListener,HttpSessionListener
{
HttpSession hs;
//hs=null;
Connection conn;
//conn=null;
CBSBean bean =new CBSBean();


	public void attributeAdded(HttpSessionBindingEvent e)
	{
	try
	{
	hs=e.getSession();
	String struser;
	if(e.getName().equals("user"))
	{
	struser=(String)e.getValue();
	String Sessionid=hs.getId();
	java.util.Date now=new java.util.Date();
	String cdate = String.valueOf(now.getYear()+1900)+"-"+String.valueOf(now.getMonth()+1)+"-"+String.valueOf(now.getDate())+" "+String.valueOf(now.getHours())+":"+String.valueOf(now.getMinutes())+":"+String.valueOf(now.getSeconds());
	conn=bean.getConnection(hs);
	PreparedStatement stat= conn.prepareStatement("insert into user_access_log(session_id,user_id,login_date_time) values(?,?,?)");
	stat.setString(1,Sessionid);
	stat.setString(2,struser);
	stat.setString(3,cdate);
	stat.executeUpdate();
	conn.close();
	
	}
	
	}
	catch(Exception ex)
	{
	System.out.print(ex);
	}
	finally
	{
	
	}
	}
	
	public void attributeReplaced(HttpSessionBindingEvent e)
	{
	
	}


	public void attributeRemoved(HttpSessionBindingEvent e)
	{
	try
	{
	hs=e.getSession();
	String struser;
	if(e.getName().equals("user"))
	{
	struser=(String)e.getValue();
	String Sessionid=hs.getId();
	java.util.Date now=new java.util.Date();
	String cdate = String.valueOf(now.getYear()+1900)+"-"+String.valueOf(now.getMonth()+1)+"-"+String.valueOf(now.getDate())+" "+String.valueOf(now.getHours())+":"+String.valueOf(now.getMinutes())+":"+String.valueOf(now.getSeconds());
	conn=bean.getConnection(hs);
	PreparedStatement stat= conn.prepareStatement("update user_access_log set logout_date_time=? where session_id=?");
	stat.setString(1,cdate);	
	stat.setString(2,Sessionid);
	stat.executeUpdate();
	conn.close();
	
	}
	
	}
	catch(Exception ex)
	{
	System.out.print(ex);
	}
	finally
	{
	
	}

	}


	public void sessionCreated(HttpSessionEvent e)
	{
	}

	public void sessionDestroyed(HttpSessionEvent e)
	{
	try
	{
	hs=e.getSession();
	String Sessionid=hs.getId();
	java.util.Date now=new java.util.Date();
	String cdate = String.valueOf(now.getYear()+1900)+"-"+String.valueOf(now.getMonth()+1)+"-"+String.valueOf(now.getDate())+" "+String.valueOf(now.getHours())+":"+String.valueOf(now.getMinutes())+":"+String.valueOf(now.getSeconds());
	conn=bean.getConnection(hs);
	PreparedStatement stat= conn.prepareStatement("update user_access_log set session_destroyed_time=? where session_id=?");
	stat.setString(1,cdate);	
	stat.setString(2,Sessionid);
	stat.executeUpdate();
	conn.close();
	}
	catch(Exception ex)
	{
	System.out.print(ex);
	}
	finally
	{
	
	}

	}



}
	
