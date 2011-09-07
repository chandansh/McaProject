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
    <tr><td align="center" height="30px"><a href="clerk.jsp">Your Detail</a></tr>
    <tr><td align="center" height="30px"><a href="DepositByCash.jsp">Deposit By Cash</a></tr>
    <tr><td align="center" height="30px"><a href="DepositByTransfer.jsp">Deposit by Cheque (transfer)</a></tr>
    <tr><td align="center" height="30px"><a href="DepositByDraft.jsp">Deposit By Draft</a></tr>
    <tr><td align="center" height="30px"><a href="CashWithdraw.jsp">Cash Withdraw</a></tr>
    <tr><td align="center" height="30px"><a href="CashByCheque.jsp">Cash Withdraw by Cheque</a></tr>
    <tr><td align="center" height="30px"><a href="IssueDraft.jsp">Draft Issue</a></tr>
    <tr><td align="center" height="30px"><a href="CancelDraft.jsp">Cancel Draft</a></tr>
    <tr><td align="center" height="30px" bgcolor="#E3E3FD">Account statement</tr>
    

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
          <script type="text/javascript">
          function validate()
          {
          	if(document.stmtfrm.acc_no.value=="")
          	{
          	alert("please enter account no");
          	return;
          	}
          	var myurl="ShowAccountEnquiry.jsp?acc_no="+document.stmtfrm.acc_no.value+"&acc_type="+document.stmtfrm.acc_type.value;
  	  		window.open(myurl,"enquiry","location=no,menubar=no,toolbar=no");
          }
          </script>

          <div align="center">
            <center>
            <form name="stmtfrm" method="post">
            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="56%">
              <tr>
                <th width="100%" colspan="2" bgcolor="#0F57BB" >
                <font color="#FFFFFF">Enter Account no for statement</font></th>
              </tr>
              <tr>
                <td width="36%" align="left">Enter Account No</td>
                <td width="64%" align="left"><input type="text" name="acc_no" size="20"></td>
              </tr>
              <tr>
                <td width="36%" align="left">Select Account Type</td>
                <td width="64%" align="left">
                <select size="1" name="acc_type">
                <%
                try
                {
                	conn=bean.getConnection(request);
                	Statement stat=conn.createStatement();
                	rs=stat.executeQuery("select * from account_type");
                	while(rs.next())
                	{
                	%>
                	<option value="<%=rs.getString("account_type_id")%>"><%=rs.getString("name")%></option>
                	<%
                	}
                }
                catch(Exception e)
                {
                }
                finally
                {
                }
                
                %>
                </select>
                <input type="button" value="View Account" name="B3" onclick="validate();"></td>
              </tr>
              <tr>
                <td width="36%" align="left">&nbsp;</td>
                <td width="64%" align="left">&nbsp;</td>
              </tr>
              <tr>
                <td width="36%" align="left">&nbsp;</td>
                <td width="64%" align="left">
                <input type="submit" value="View Statement" name="B4"></td>
              </tr>
                       
              
              <tr>
                <td width="36%" align="left">&nbsp;</td>
                <td width="64%" align="left">&nbsp;</td>
              </tr>
                       
              
            </table>
            </form>  
            
            <b><font color="#0000FF">Account Statement</font></b><div align="center">
              <center>
              <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#808080" width="97%">
                <tr>
                  <th width="14%" bgcolor="#0F57BB">transaction id</th>
                  <th width="14%" bgcolor="#0F57BB">account no</th>
                  <th width="14%" bgcolor="#0F57BB">date</th>
                  <th width="14%" bgcolor="#0F57BB">DR</th>
                  <th width="14%" bgcolor="#0F57BB">CR</th>
                  <th width="15%" bgcolor="#0F57BB">&nbsp;By</th>
                  <th width="15%" bgcolor="#0F57BB">Description</th>
                </tr>
                <%
                String acc_no=request.getParameter("acc_no");
                if(acc_no!=null && acc_no!="")
                {
                try
                {
                conn=bean.getConnection(request);
                PreparedStatement stat=conn.prepareStatement("select * from transaction_details where acc_no=? order by t_date desc");
                stat.setString(1,acc_no);
                rs=stat.executeQuery();
                while(rs.next())
                {
                %>
                <tr>
                  <td width="14%">&nbsp;<%=rs.getString("transaction_id")%></td>
                  <td width="14%">&nbsp;<%=rs.getString("acc_no")%></td>
                  <td width="14%">&nbsp;<%=rs.getString("t_date")%></td>
                  <td width="14%">&nbsp;<%=rs.getString("dr")%></td>
                  <td width="14%">&nbsp;<%=rs.getString("cr")%></td>
                  <td width="15%">&nbsp;<%=rs.getString("by")%></td>
                  <td width="15%">&nbsp;<%=rs.getString("description")%></td>
                </tr>
                <%
                }//end of while
                }//end of try
                catch(Exception e)
                {
                	out.print("Error :+e");
                }
                finally
                {
                	rs.close();
                	conn.close();
                }
                }//end of if external
                %>
                
              </table>
              </center>
            </div>
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