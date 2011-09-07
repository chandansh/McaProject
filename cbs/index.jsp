<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="errorpage.jsp" %>
<html>
<head>
  <TITLE>CBS Login</TITLE>
<LINK rel="stylesheet" type="text/css" href="style.css">

    <jsp:useBean id="bean" class="com.cbs.CBSBean" scope="request"/>
  <SCRIPT language="JavaScript">
  	function validate()
  	{
	  	if(document.frm.userid.value==""||document.frm.password.value==""||document.frm.branchid=="")
		{
  			alert("Branch ID or UserId or Password cannot be blank!!");
			return;
  		}
  		document.frm.action="index.jsp";
  		document.frm.submit();
  	}
	</SCRIPT>

</head>

<body >
 <% 
	/*String user_src=(String)session.getValue("user");
	
	if(user_src!=null && user_src.equals("Administrator"))
	{
		
		response.sendRedirect(response.encodeRedirectURL("ViewAll.jsp"));
	}
	else if(user_src!=null)
	{
		response.sendRedirect(response.encodeRedirectURL("usersearch.jsp"));
		
	}*/
%>

<table border="0" cellpadding="0" cellspacing="0" width="100%" height="449">
  <tr>
    <td colspan="2" width="100%" valign="top" height="1">
     <%@ include file="header.html" %>


</td>
  </tr>
  <tr>
    <td width="8%" valign="top" height="449">
    <div align="left">
      <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="146" height="103">
        <tr>
          <td height="86" width="146" background="images/top.png" valign="top">&nbsp;</td>
        </tr>
        <tr>
          <td height="146" background="images/middle.png" width="146">&nbsp;</td>
        </tr>
        <tr>
          <td height="167" background="images/bottom.png" width="146">&nbsp;</td>
        </tr>
      </table>
    </div>
    </td>
    <td width="92%" class="sbiback">
    
    <form method="post" name="frm">
        <div align="center" >
        <center>
          
          <table border="1" bordercolor="#0F57BB" width="40%" cellspacing="1" >
            <tr>
              <td colspan="2" bgcolor="#0F57BB" style="border-right-color: #0F57BB; border-right-width: 1; border-top-color: #0F57BB; border-top-width: 1">
              <font face="Arial Black" color="#FFFFFF">Login</font></td>
            </tr>
            <tr>
              <td colspan="2" align="left">
              <%
              //display the logout message
              String logoutmsg=request.getParameter("logoutmsg");
              if(logoutmsg!=null && logoutmsg!="")
              {
              out.print(logoutmsg);
              }
              %> &nbsp;</td>
            </tr>
            
            <tr>
              <td width="34%" align="left"><font size="2">Branch Id:</font></td>
              <td width="66%" align="left" style="border-right-color:#0F57BB; border-right-width: 1">
              <input type="text" name="branchid" size="20" /></td>
            </tr>
            
            <tr>
              <td width="34%" align="left"><font size="2">User Id:</font></td>
              <td width="66%" align="left" style="border-right-color:#0F57BB; border-right-width: 1"><label>
                <input name="userid" type="text" id="userid" size="20" /></label></td>
            </tr>
            <tr>
              <td width="34%" align="left"><font size="2">Password:</font></td>
              <td width="66%" align="left" style="border-right-color: #0F57BB; border-right-width: 1"><label>
                <input name="password" type="password" id="password" size="20" /></label></td>
            </tr>
            <tr>
              <td width="34%" align="left">&nbsp;</td>
              <td width="66%" align="left" style="border-right-color: #0F57BB; border-right-width: 1"><label>
                <input type="submit" name="Submit" value="Sign In" onClick="validate();"/>&nbsp;&nbsp; </label></td>
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
	String strbranch=request.getParameter("branchid");

	if((strid!=null && strid!="")&&(strpass!=null && strpass!="")&&(strbranch!=null && strbranch!=""))
	{
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("SELECT * FROM user_table where user_id=? and u_password =? and branch_id=?");
		stat.setString(1,strid);
		stat.setString(2,strpass);
		stat.setString(3,strbranch);
		rs = stat.executeQuery();
		if(rs.next())
		{
			
			String user_type=rs.getString("user_type");
			session.setAttribute("user",strid);
			session.setAttribute("branch",strbranch);
			session.setAttribute("user_type",user_type);
			//out.println("Logged IN");
			if(user_type.equals("Administrator"))
			{
				response.sendRedirect(response.encodeRedirectURL("admin.jsp"));
			}
			else if(rs.getString("user_type").equals("Officer"))
			{
				response.sendRedirect(response.encodeRedirectURL("officer.jsp"));
			}
			else if(rs.getString("user_type").equals("Clerk"))
			{
				response.sendRedirect(response.encodeRedirectURL("clerk.jsp"));
			}
			else
			{
				response.sendRedirect(response.encodeRedirectURL("Unauthorised.htm"));
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
	 &nbsp;</td>
	 </tr>
	&nbsp;</table>
        </center>
      </div>
    </form></td>

   
  </tr>
  <tr>
    <td width="100%" colspan="2" height="1">
    <%@ include file="footer.html" %>
</td>
  </tr>
</table>
</body>
</html>