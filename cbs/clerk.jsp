<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*"  %>
<html xmlns="http://www.w3.org/1999/xhtml">
<LINK href="leftnav.css" rel="stylesheet" type="text/css">
<LINK href="style.css" rel="stylesheet" type="text/css">
<head>

<title>Clerk Home Page</title>
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
	if (user_src!=null && user_type!=null && user_type.equals("Clerk"))
  	{
	out.println("Hi "+user_src);
	//out.println("<br>"+session.getId());
	}
	else
	{
		response.sendRedirect("Unauthorised.htm");
	}
	
        Connection conn;
		conn=null;
		ResultSet rs;
		rs=null;
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("select initial_pass_changed from user_table where user_id=?");
		stat.setString(1,user_src);
		rs = stat.executeQuery();
		
		if(rs.next() && rs.getBoolean("initial_pass_changed")!=true)	
		{
		response.sendRedirect("InitialPassChange.jsp");
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

</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="logout.jsp"><img src="images/logout.png" border="0" width="100" height="34"/></a></div>
</td></tr>
<tr>
  <td>
  
  
  <table width="100%" border="0" cellspacing="1" bordercolor="#0000FF" align="center" height="400">
  <tr>
    <td height="397"  bordercolor="#000099" valign="top" >
    <table border="0" cellspacing="0" width="100%" cellpadding="0" style="border-collapse: collapse" bordercolor="#111111" height="402" >
      <tr >
        <td width="7em" valign="top" bgcolor="#E3E3FD" height="402">
        <table class="navigation" width="100" border="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" >
    <tr><td align="center" height="30px" bgcolor="#E3E3FD">Your Detail</tr>
    <tr><td align="center" height="30px"><a href="DepositByCash.jsp">Deposit By Cash</a></tr>
    <tr><td align="center" height="30px"><a href="DepositByTransfer.jsp">Deposit by Cheque (transfer)</a></tr>
    <tr><td align="center" height="30px"><a href="DepositByDraft.jsp">Deposit By Draft</a></tr>
    <tr><td align="center" height="30px"><a href="CashWithdraw.jsp">Cash Withdraw</a></tr>
    <tr><td align="center" height="30px"><a href="CashByCheque.jsp">Cash Withdraw by Cheque</a></tr>
    <tr><td align="center" height="30px"><a href="IssueDraft.jsp">Draft Issue</a></tr>
    <tr><td align="center" height="30px"><a href="CancelDraft.jsp">Cancel Draft</a></tr>
    <tr><td align="center" height="30px"><a href="AccountStatement.jsp">Account statement</a></tr>
    

</table>

</td>
        <td valign="top" class="sbiback" height="402">
        <p align="center">
        <%
        try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("select max(logout_date_time)as last_login from user_access_log where user_id=?");
		stat.setString(1,user_src);
		rs = stat.executeQuery();
		
		if(rs.next() && rs.getString("last_login")!=null)	
		{
		out.print("<font color='green'>your last login date time:"+rs.getString("last_login")+"</font>");
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

        
        
        &nbsp;</p>
        <p align="center"><b><font face="Arial" color="#000080">Clerk Page</font></b></p>
        <div align="center">
          <center>
          <%
        try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("select a.*, b.* from user_table as a ,branch as b where a.branch_id=b.branch_id and user_id=?");
		stat.setString(1,user_src);
		rs = stat.executeQuery();
		if(rs.next())	
		{
		%>
          <div align="center">
            <center>
            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="56%">
              <tr>
                <th width="100%" colspan="2" bgcolor="#0F57BB" >
                <font color="#FFFFFF">USER DETAIL</font></th>
              </tr>
              <tr>
                <td width="25%" align="left">User ID</td>
                <td width="75%" align="left">&nbsp;<%=rs.getString("user_id")%></td>
              </tr>
              <tr>
                <td width="25%" align="left">Name</td>
                <td width="75%" align="left">&nbsp;<%=rs.getString("firstname")%>&nbsp;<%=rs.getString("lastname")%></td>
              </tr>
              <tr>
                <td width="25%" align="left">Branch ID</td>
                <td width="75%" align="left">&nbsp;<%=rs.getString("branch_id")%></td>
              </tr>
              <tr>
                <td width="25%" align="left">Branch Name</td>
                <td width="75%" align="left">&nbsp;<%=rs.getString("branch_name")%></td>
              </tr>
              <tr>
                <td width="25%" align="left">Branch Address</td>
                <td width="75%" align="left">&nbsp;<%=rs.getString("address")%>&nbsp;<%=rs.getString("city")%>&nbsp;<%=rs.getString("state")%>&nbsp;<%=rs.getString("pin")%></td>
              </tr>
              <tr>
                <td width="25%" align="left">Designation</td>
                <td width="75%" align="left">&nbsp;<%=rs.getString("user_type")%></td>
              </tr>
              <tr>
                <td width="25%" align="left">&nbsp;</td>
                <td width="75%" align="left">&nbsp;</td>
              </tr>
           
&nbsp;<%	
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
              
              
            </table>
            
            </center>
          </div>
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