<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*"  %>
<html xmlns="http://www.w3.org/1999/xhtml">
<LINK href="leftnav.css" rel="stylesheet" type="text/css">
<LINK href="style.css" rel="stylesheet" type="text/css">
<head>

<script language="JavaScript">
function validate()
{
		if(document.change_pass_frm.old_pass.value=="")
		{
  			alert("old Password cannot be blank!!");
  			document.change_pass_frm.old_pass.value="";
			return;
  		}
  		if(document.change_pass_frm.new_pass.value=="")
		{
  			alert("new Password cannot be blank!!");
  			document.change_pass_frm.old_pass.value="";
			return;
  		}
  		if(document.change_pass_frm.re_new_pass.value=="")
		{
  			alert("re type new Password cannot be blank!!");
  			document.change_pass_frm.old_pass.value="";
			return;
  		}
  		if(document.change_pass_frm.old_pass.value==document.change_pass_frm.new_pass.value)
		{
			alert("your new password is same as your old password please change");
			document.change_pass_frm.old_pass.value="";
			return;
		}
		if(document.change_pass_frm.new_pass.value!=document.change_pass_frm.re_new_pass.value)
		{
			alert("your new password is not match your re type password");
			document.change_pass_frm.old_pass.value="";
			return;
		}
		//document.change_pass_frm.submit();
  		

}
</script>


<title>Administrator Home Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>

<body>
<jsp:useBean id="bean" class="com.cbs.CBSBean" scope="request"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="header.html" %></td>
  </tr>
  <tr ><td bgcolor="#0F57BB" valign="middle" height="34"><div align="right"  ><font face="Arial Black" size="3" color="#FFFFFF">  
<% 
	String user_src=(String)session.getAttribute("user");
	String user_type=(String)session.getAttribute("user_type");
	String branch=(String)session.getAttribute("branch");
	if (user_src!=null && user_type!=null)
  	{
	out.println("Hi "+user_src);
	//out.println("<br>"+session.getId());
	}
	else
	{
		response.sendRedirect("Unauthorised.htm");
	}
%></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="logout.jsp"><img src="images/logout.png" border="0" width="100" height="34"/></a></div>
</td></tr>
<tr>
  <td>
  
  
  <table width="100%" border="0" cellspacing="1" bordercolor="#0000FF" align="center" height="400">
  <tr>
    <td height="397"  bordercolor="#000099" valign="top" >
    <table border="0" cellspacing="0" width="100%" cellpadding="0" style="border-collapse: collapse" bordercolor="#111111" height="402" >
      <tr >
        <td valign="top" class="sbiback" height="402">
        <p align="center">
        <%
        Connection conn;
		conn=null;
		ResultSet rs;
		rs=null;
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("select max(logout_date_time)as last_login from user_access_log where user_id=?");
		stat.setString(1,user_src);
		rs = stat.executeQuery();
		
		if(rs.next() && rs.getString("last_login")!=null)	
		{
		out.print("<font color='green'>your last login date time:"+rs.getString("last_login")+"</font><br>");
		}
		else
		{
		out.print("<font color='red'>this is your first time login with this user Id please change your password"+"</font>");
		}
		}
		catch(Exception E)
		{
			out.print("error:"+E);
		}
		finally
		{
			rs.close();
			conn.close();
		}

		%>
		
		<%
		String old_pass=request.getParameter("old_pass");
		String new_pass=request.getParameter("new_pass");
		int flag=0;
		
		
		if(old_pass!=null && !old_pass.equals(""))
		{
        	try
        	{
        		conn = bean.getConnection(request);
				PreparedStatement stat= conn.prepareStatement("select * from user_table where u_password=? and user_id=?");
				stat.setString(1,old_pass);
				stat.setString(2,user_src);
				rs = stat.executeQuery();
				if(rs.next() && rs.getString("u_password").equals(old_pass))
				{
					PreparedStatement stat1= conn.prepareStatement("update user_table set u_password=?,initial_pass_changed=? where user_id=?");
					stat1.setString(1,new_pass);
					stat1.setBoolean(2,true);
					stat1.setString(3,user_src);
					flag = stat1.executeUpdate();
					out.print("<br><b><font color='green'>your password has been changed and Loged Out please login again?</font>");
					out.print("<br><a href='index.jsp'>click here</a></b>");
					session.invalidate();
				}
				else
				{
					
					flag=0;
					out.print("<br><b><font color='red'>old password is incorrect</font></b>");
				}

        	}
        	catch(Exception e)
        	{
        		out.print("error: "+e);
        	}
        	finally
        	{
        		rs.close();
        		conn.close();
        	}
        	
  		}//end of if
		
		if(flag==0)
		{
		%>


        
        
        &nbsp;</p>
        <p align="center"><b><font color="#FF0000" face="Arial">**You have not 
        changed your Initial Password please Change your Password</font></b></p>
        <div align="center">
          <center>
          <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="50%">
            <tr>
              <td width="100%">
              <form method="POST" name="change_pass_frm">
               <fieldset style="padding: 2">
                <legend>Change Password</legend>
                <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
                  <tr>
                    <td width="47%" align="left">&nbsp;</td>
                    <td width="53%" align="left">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="47%" align="left">Old Password</td>
                    <td width="53%" align="left">
                    <input type="password" name="old_pass" size="20"></td>
                  </tr>
                  <tr>
                    <td width="47%" align="left">New Password</td>
                    <td width="53%" align="left">
                    <input type="password" name="new_pass" size="20"></td>
                  </tr>
                  <tr>
                    <td width="47%" align="left">ReType New Password</td>
                    <td width="53%" align="left">
                    <input type="password" name="re_new_pass" size="20"></td>
                  </tr>
                  <tr>
                    <td width="47%" align="left">&nbsp;</td>
                    <td width="53%" align="left">&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="47%" align="left">&nbsp;</td>
                    <td width="53%" align="left">
                    <input type="submit" value="Change" name="B1" onclick="validate();">
                    <input type="reset" value="Reset" name="B2"></td>
                  </tr>
                </table>
                </fieldset></form>
              </td>
            </tr>
          </table>
          </center>
        </div>
        <%
          }//end of if
          %>
        <div align="center">
          <center>
          
          <p><font face="Arial" color="#000080"><b>End </b></font></p>
          </center>
        </div>
        </td>
      </tr>
    </table>
    
    </tr>
   
</table>
    
</td></tr>
<tr>
    <td><%@ include file="footer.html" %>
       
  </tr>
</table>
</body>

</html>