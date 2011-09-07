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
    <tr><td align="center" height="30px" bgcolor="#E3E3FD" >Deposit By Draft</tr>
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
          
          
         
          
          
                  
          
          <p></p>
          
          
         
          
          
                  
          
          </center>
        </div>
        <div align="center">
          <center>
          <div align="center">
            <center>
             <script type="text/javascript">
          function validate()
          {
          	if(document.draftdeposit.acc_no.value=="")
          	{
          	alert("please enter account no");
          	return;
          	}
          	var myurl="ShowAccountEnquiry.jsp?acc_no="+document.draftdeposit.acc_no.value+"&acc_type="+document.draftdeposit.acc_type.value;
  	  		window.open(myurl,"enquiry","location=no,menubar=no,toolbar=no");
          }
		     </script>
            <form name="draftdeposit" method="post">
            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="60%">
              <tr>
                <td width="100%" colspan="2" bgcolor="#0F57BB" align="center">
                <b><font color="#FFFFFF">Deposit By Draft</font></b></td>
              </tr>
              <tr>
                <td width="36%" align="left">Enter the account no to be deposited</td>
                <td width="64%" align="left"><input type="text" name="acc_no" size="20"></td>
              </tr>
              <tr>
                <td width="36%" align="left">select Account type</td>
                <td width="64%" align="left">
                <select size="1" name="acc_type">
                
                <option selected value="ca">Current Account</option>
                <option value="sb">Saving Bank Account</option>
                
                </select>
                <input type="button" value="View Account" name="B4" onclick="validate();"></td>
              </tr>
              <tr>
                <td width="36%" align="left">Amount</td>
                <td width="64%" align="left"><input type="text" name="amount" size="20"></td>
              </tr>
              <tr>
                <td width="36%" align="left">Draft No</td>
                <td width="64%" align="left"><input type="text" name="draft_no" size="20"></td>
              </tr>
              <tr>
                <td width="36%" align="left">Draft IFS Code</td>
                <td width="64%" align="left"><input type="text" name="d_ifs_code" size="20"></td>
              </tr>
              <tr>
                <td width="36%" align="left">Deposit By</td>
                <td width="64%" align="left"><input type="text" name="deposit_by" size="20"></td>
              </tr>
              <tr>
                <td width="36%" align="left">&nbsp;</td>
                <td width="64%" align="left"><input type="submit" value="Transmit" name="B1" onclick="validate1()">
                <input type="reset" value="Reset" name="B2"></td>
              </tr>
              <tr>
                <td width="36%" align="left">&nbsp;</td>
                <td width="64%" align="left">&nbsp;</td>
              </tr>
            </table>
            </form>
            </center>
          </div>
          </center>
        </div>
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