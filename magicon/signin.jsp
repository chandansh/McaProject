<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>
<SCRIPT language="JavaScript">
  	function validate()
  	{
	  	if(document.frm.userid.value==""||document.frm.password.value=="")
		{
  			alert("UserName or Password cannot be blank!!");
			return;
  		}
  	  	document.frm.action="signin.jsp";
  		document.frm.submit();
  	}
	</SCRIPT>

<body>
<jsp:useBean id="bean" class="com.magicon.MagiconBean" scope="request"/>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="index2.html" %></td>
  </tr>
  <tr>
  <% 
	String user_src=(String)session.getValue("user");
	
	if(user_src!=null && user_src.equals("Administrator"))
	{
		
		response.sendRedirect(response.encodeRedirectURL("ViewAll.jsp"));
	}
	else if(user_src!=null)
	{
		response.sendRedirect(response.encodeRedirectURL("usersearch.jsp"));
		
	}
%>

    <td height="350" valign="top"><form method="post" name="frm">
      &nbsp;
      <div align="center" >
        <center>
          
          <table border="1" bordercolor="#0F57BB" width="40%" cellspacing="1">
            <tr>
              <td colspan="2" bgcolor="#0F57BB" style="border-right-color: #0F57BB; border-right-width: 1; border-top-color: #0F57BB; border-top-width: 1">
              <font face="Arial Black" color="#FFFFFF">Sign in </font> </td>
            </tr>
            <tr>
              <td colspan="2" align="left">&nbsp;</td>
            </tr>
            
            <tr>
              <td width="34%" align="left">User Id:</td>
              <td width="66%" align="left" style="border-right-color:#0F57BB; border-right-width: 1"><label>
                <input name="userid" type="text" id="userid" size="20" /></label></td>
            </tr>
            <tr>
              <td width="34%" align="left">Password:</td>
              <td width="66%" align="left" style="border-right-color: #0F57BB; border-right-width: 1"><label>
                <input name="password" type="password" id="password" size="20" /></label></td>
            </tr>
            <tr>
              <td width="34%" align="left">&nbsp;</td>
              <td width="66%" align="left" style="border-right-color: #0F57BB; border-right-width: 1"><label>
                <input type="submit" name="Submit" value="Sign In" onclick="validate();"/>&nbsp;&nbsp;
                <a href="register.jsp">Register me/New User?</a></label></td>
            </tr>
			<tr>
              <td width="34%" align="left">&nbsp;</td>
              <td width="66%" align="left" style="border-right-color: #0F57BB; border-right-width: 1">
			  <%
	
	
	Connection conn;
	conn=null;
	ResultSet rs;
	rs=null;
	String strid=request.getParameter("userid");
	String strpass=request.getParameter("password");
	if((strid!=null && strid!="")||(strpass!=null && strpass!=""))
	{
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("SELECT * FROM cust_info where cust_id=? and cust_password =?");
		stat.setString(1,strid);
		stat.setString(2,strpass);
		rs = stat.executeQuery();
		if(rs.next())
		{
			session.putValue("user",strid);
			//out.println("Logged IN");
			if(strid.equals("Administrator"))
			{
				response.sendRedirect(response.encodeRedirectURL("ViewAll.jsp"));
			}
			else
			{
				response.sendRedirect(response.encodeRedirectURL("usersearch.jsp"));
			}
			
			
			
		}       
		else
		{
			out.print("<b><font color='#ff0000' face='Arial'>user id Or password is incorrect</font></b>");
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
	}
	
	%>
              <p align="center"><a href="index.jsp">Home Page</a></tr>
          </table>
        </center>
      </div>
    </form></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><%@ include file="footer.html" %>
        <%=new java.util.Date() %> </td>
  </tr>
</table>
<p>&nbsp;</p>
</body>
</html>