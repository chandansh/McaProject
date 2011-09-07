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
    <tr><td align="center" height="30px"><a href="MakeJointAccount.jsp">Make Joint Account</a></tr>
    <tr><td align="center" height="30px"><a href="AccountEnquiry.jsp">Account Enquiry</a></tr>
    <tr><td align="center" height="30px"><a href="IssueChequeBook.jsp">Issue ChequeBook</a></tr>
    <tr><td align="center" height="30px"><a href="StopCheque.jsp">Stop Cheque</a></tr>
    <tr><td align="center" height="30px" bgcolor="#E3E3FD">Issue ATM card</tr>

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
          <%
          String atmAcc_no=request.getParameter("acc_no");
          String atmAcc_type=request.getParameter("acc_type");
          String atm_no=request.getParameter("atm_card_no");
          String atm_kit_no=request.getParameter("atm_kit");
          
          	if(atmAcc_no!=null && atmAcc_no!="")
          	{
          	try
			{
				conn = bean.getConnection(request);
				PreparedStatement stat= conn.prepareStatement("select * from saving_and_current_account where account_no=? and branch_id=?");
				stat.setString(1,atmAcc_no);
				stat.setString(2,branch);
				rs = stat.executeQuery();
		
				if(rs.next())	
				{
				PreparedStatement stat1= conn.prepareStatement("select * from atm_card_issue_detail where card_no=?");
				stat1.setString(1,atm_no);
				ResultSet rs1=stat1.executeQuery();
					if(!rs1.next())
					{
					PreparedStatement stat2= conn.prepareStatement("insert into atm_card_issue_detail values(?,?,?,now(),?)");
					stat2.setString(1,atm_no);
					stat2.setString(2,atmAcc_no);
					stat2.setString(3,atmAcc_type);
					stat2.setString(4,atm_kit_no);
					stat2.executeUpdate();
					out.print("<font color='green'>Card issued card No:"+atm_no+"<br>account no :"+atmAcc_no+"</font>");

					}
					else
					{
					out.print("<font color='red'>Card already issued try other card</font>");
					}
				}
				else
				{
				out.print("<font color='red'>Account No not Found"+"</font>");
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

          	}//end of if
          
          %>

          <script type="text/javascript">
          function validate()
          {
          	if(document.atmfrm.acc_no.value=="")
          	{
          	alert("please enter account no");
          	return;
          	}
          	var myurl="ShowAccountEnquiry.jsp?acc_no="+document.atmfrm.acc_no.value+"&acc_type="+document.atmfrm.acc_type.value;
  	  		window.open(myurl,"enquiry","location=no,menubar=no,toolbar=no");
          }
          function validate1()
          {
          	if(document.atmfrm.acc_no.value=="")
          	{
          	alert("please enter account no");
          	return;
          	}
          	if(document.atmfrm.atm_card_no.value=="")
          	{
          	alert("please enter the atm card no");
          	return;
          	}
          	if(document.atmfrm.atm_kit.value=="")
          	{
          	alert("please enter no Atm kit no");
          	return;
          	}

          }
          </script>

          <form name="atmfrm" method="post">
          <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="60%">
            <tr>
              <td width="100%" bgcolor="#0F57BB" align="center" bordercolor="#0F57BB" colspan="2">
              <b><font color="#FFFFFF">Issue ATM Card</font></b></td>
            </tr>
            <tr>
              <td width="41%" align="left">Enter Account No</td>
              <td width="59%" align="left">
              <input type="text" name="acc_no" size="20"></td>
            </tr>
            <tr>
              <td width="41%" align="left">Select Account Type</td>
              <td width="59%" align="left"><select size="1" name="acc_type">
              <option selected value="sb">Saving Account</option>
              <option value="ca">Current Account</option>
              </select>&nbsp;&nbsp;&nbsp;
              <input type="button" value="Enquiry Account" name="B1" onclick="validate();"></td>
            </tr>
            <tr>
              <td width="41%" align="left">Card No</td>
              <td width="59%" align="left">
              <input type="text" name="atm_card_no" size="20"></td>
            </tr>
            <tr>
              <td width="41%" align="left">ATM pin Kit No</td>
              <td width="59%" align="left">
              <input type="text" name="atm_kit" size="20"></td>
            </tr>
            <tr>
              <td width="41%" align="left">&nbsp;</td>
              <td width="59%" align="left">&nbsp;</td>
            </tr>
            <tr>
              <td width="41%" align="left">&nbsp;</td>
              <td width="59%" align="left">
              <input type="submit" value="Transmit" name="B2" onclick="validate1();">
              <input type="reset" value="Reset" name="B3"></td>
            </tr>
            <tr>
              <td width="41%" align="left">&nbsp;</td>
              <td width="59%" align="left">&nbsp;</td>
            </tr>
          </table>
          </form>
          </center>
        </div>
        <div align="center">
		</center>
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