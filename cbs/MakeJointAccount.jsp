<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*"  %>
<html xmlns="http://www.w3.org/1999/xhtml">
<LINK href="leftnav.css" rel="stylesheet" type="text/css">
<LINK href="style.css" rel="stylesheet" type="text/css">
<head>

<title>Officer Home Page</title>
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
	if (user_src!=null && user_type!=null && user_type.equals("Officer"))
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
    <tr><td align="center" height="30px"><a href="officer.jsp">Your Detail</a></tr>
    <tr><td align="center" height="30px"><a href="CIF.jsp">CIF</a></tr>
    <tr><td align="center" height="30px"><a href="CIFEnquiry.jsp">CIF Enquiry</a></tr>
    <tr><td align="center" height="30px"><a href="CIFModify.jsp">CIF Modify</a></tr>
    <tr><td align="center" height="30px"><a href="CreateAccount.jsp">Create Account</a></tr>
    <tr><td align="center" height="30px" bgcolor="#E3E3FD">Make Joint Account</tr>
    <tr><td align="center" height="30px"><a href="AccountEnquiry.jsp">Account Enquiry</a></tr>
    <tr><td align="center" height="30px"><a href="IssueChequeBook.jsp">Issue ChequeBook</a></tr>
    <tr><td align="center" height="30px"><a href="StopCheque.jsp">Stop Cheque</a></tr>
    <tr><td align="center" height="30px"><a href="IssueATM.jsp">Issue ATM card</a></tr>

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
        <p align="center"><b><font face="Arial" color="#000080">Officer Page</font></b></p>
        <div align="center">
          <center>
          <div align="center">
            <center>
            <script type="text/javascript">
            function validate()
            {
            if(document.makejointfrm.acc_no.value=="")
            {
            alert("please enter account no");
            return;
            }
            }
            </script>
            <form method="post" name="makejointfrm">
            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="60%">
              <tr>
                <td width="100%" colspan="2" bgcolor="#0F57BB" align="center">
                <b><font color="#FFFFFF">Make Joint Account</font></b></td>
              </tr>
              <tr>
                <td width="44%" align="left">Enter the SB or CA Account no</td>
                <td width="56%" align="left">
                <input type="text" name="acc_no" size="20"></td>
              </tr>
              <tr>
                <td width="44%" align="left">&nbsp;</td>
                <td width="56%" align="left">&nbsp;</td>
              </tr>
              <tr>
                <td width="44%" align="left">&nbsp;</td>
                <td width="56%" align="left">
                <input type="submit" value="Transmit" name="B1" onclick="validate();"></td>
              </tr>
              <tr>
                <td width="44%" align="left">&nbsp;</td>
                <td width="56%" align="left">&nbsp;</td>
              </tr>
            </table>
            </form>
            </center>
          </div>
          <br>
<%
String acc_no=request.getParameter("acc_no");
if(acc_no!=null && acc_no!="")
{
try
	{
		conn=bean.getConnection(request);
		PreparedStatement stat=conn.prepareStatement("select a.first_name_business_name,a.middle_name,a.last_name,b.* from customer_info_table as a, saving_and_current_account as b where a.cif_number=b.cif_no and b.account_no=? and b.branch_id=?");
		stat.setString(1,acc_no);
		stat.setString(2,branch);
		rs=stat.executeQuery();
		
		
		if(!rs.next())
		{
		out.print("<font color='red'><b>Account number not found</b></font>");
		}
		else if(rs.getBoolean("joint_account"))
		{
		out.print("<font color='red'><b>Account already joint Account</b></font>");
		}
		else
		{
		%>
		<script type="text/javascript">
            function validate1()
            {
            if(document.makejointfrm1.second_CIF.value=="")
            {
            alert("please enter second member CIF no");
            return;
            }
            }
            </script>
		<form name="makejointfrm1" method="post">
		<div align="center">
          <center>
          <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="60%">
            <tr>
              <td width="100%" colspan="2" bgcolor="#0F57BB" align="center"><b>
              <font color="#FFFFFF">Enter CIF second Member</font></b></td>
            </tr>
            <tr>
              <td width="44%" align="left">Account Number </td>
              <td width="56%" align="left">&nbsp;<%=acc_no%>&nbsp;</td>
              <input type="hidden" name="jointAccNo" value=<%=acc_no%>>
            </tr>

            <tr>
              <td width="44%" align="left">First Account holder </td>
              <td width="56%" align="left">&nbsp;<%=rs.getString("first_name_business_name")%>&nbsp;<%=rs.getString("middle_name")%>&nbsp;<%=rs.getString("last_name")%>&nbsp;</td>
            </tr>
            <tr>
              <td width="44%" align="left">Enter Second Account Holder CIF</td>
              <td width="56%" align="left"><input type="text" name="second_CIF" size="20"></td>
            </tr>
            <tr>
              <td width="44%" align="left">&nbsp;</td>
              <td width="56%" align="left">&nbsp;</td>
            </tr>
            <tr>
              <td width="44%" align="left">&nbsp;</td>
              <td width="56%" align="left"><input type="submit" value="Transmit" name="B1" onclick="validate1();"></td>
            </tr>
            <tr>
              <td width="44%" align="left">&nbsp;</td>
              <td width="56%" align="left">&nbsp;</td>
            </tr>
          </table>
          </center>
        </div>
&nbsp;</form>
		<%
		}
		
	}
	catch(Exception e)
	{
		out.print("Error :"+e);
	}
	finally
	{
		rs.close();
		conn.close();
	}


}
%>

<!--handle the request for make joint account -->
<%
String second_CIF=request.getParameter("second_CIF");
String jointAccNo =request.getParameter("jointAccNo");
if(second_CIF!=null && second_CIF!="" && jointAccNo!=null && jointAccNo!="")
{
	try
	{
		conn=bean.getConnection(request);
		PreparedStatement stat=conn.prepareStatement("select * from customer_info_table where cif_number=? and not cust_type='Nominee' and branch_id=?");
		stat.setString(1,second_CIF);
		stat.setString(2,branch);
		rs=stat.executeQuery();
		
		if(!rs.next())
		{
		out.print("<font color='red'><b>Second Member CIF number not found</b></font>");
		}
		else
		{
		PreparedStatement stat1=conn.prepareStatement("update saving_and_current_account set joint_account=true,cif_second_member=? where account_no=?");
		stat1.setString(1,second_CIF);
		stat1.setString(2,jointAccNo);
		stat1.executeUpdate();
		out.print("<font color='green'><b>Joint Account Created successfully Account No :"+jointAccNo+"</b></font>");

		}
		
	}
	catch(Exception e)
	{
		out.print("Error :"+e);
	}
	finally
	{
		rs.close();
		conn.close();
	}


}
%>







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