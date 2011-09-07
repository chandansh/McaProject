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
    <tr><td align="center" height="30px" ><a href="clerk.jsp">Your Detail</a></tr>
    <tr><td align="center" height="30px"><a href="DepositByCash.jsp">Deposit By Cash</a></tr>
    <tr><td align="center" height="30px"><a href="DepositByTransfer.jsp">Deposit by Cheque (transfer)</a></tr>
    <tr><td align="center" height="30px"><a href="DepositByDraft.jsp">Deposit By Draft</a></tr>
    <tr><td align="center" height="30px"><a href="CashWithdraw.jsp">Cash Withdraw</a></tr>
    <tr><td align="center" height="30px" bgcolor="#E3E3FD">Cash Withdraw by Cheque</tr>
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
            String ch_acc_no=request.getParameter("ch_acc_no");
            String ch_acc_type=request.getParameter("ch_acc_type");
            String amount=request.getParameter("amount");
            String cheque_no=request.getParameter("cheque_no");
            

            if(ch_acc_no!=null && ch_acc_no!="" && ch_acc_type.equals("sb"))
            {
            	try
            	{
            		conn=bean.getConnection(request);
            		
            		PreparedStatement chstat=conn.prepareStatement("select * from cheque_issue_details where account_no=? and cheque_no=? and cheque_status='issued'");
            		chstat.setString(1,ch_acc_no);
					chstat.setString(2,cheque_no);
            		ResultSet chrs=chstat.executeQuery();
					if(!chrs.next())
					{
						out.print("<font color='red'>cheque no not found or not issued</font>");
					}
					else
					{
            		PreparedStatement stat=conn.prepareStatement("select * from branch_account where branch_id=? and account_name='Cash'");
            		stat.setString(1,branch);
            		rs=stat.executeQuery();
            		if(!rs.next())
            		{
            			out.print("<font color='red'>branch Cash account no not found</font>");
            		}
            		else
            		{
            			PreparedStatement stat1=conn.prepareStatement("select * from saving_and_current_account where account_no=? and acc_type='sb'");
            			stat1.setString(1,ch_acc_no);
            			ResultSet rs1=stat1.executeQuery();
            			
            			if(rs1.next())
            			{
            				if((rs1.getDouble("balance")>=Double.parseDouble(amount)))
            				{
            				PreparedStatement stat2=conn.prepareStatement("update branch_account set balance=? where account_no=?");
            				double newCashBalance=rs.getDouble("balance")-Double.parseDouble(amount);
            				stat2.setDouble(1,newCashBalance);
            				stat2.setString(2,rs.getString("account_no"));
            				stat2.executeUpdate();
            			
            				PreparedStatement stat3=conn.prepareStatement("update saving_and_current_account set balance=? where account_no=?");
            				double newBalance=rs1.getDouble("balance")-Double.parseDouble(amount);
            				stat3.setDouble(1,newBalance);
            				stat3.setString(2,rs1.getString("account_no"));
            				stat3.executeUpdate();
            			
            				PreparedStatement stat4=conn.prepareStatement("insert into transaction_details values(?,?,?,?,now(),?,?)");
            				String trans_id=String.valueOf((int)(10000*Math.random()+1));
            				stat4.setString(1,trans_id);
            				stat4.setString(2,rs1.getString("account_no"));
            				stat4.setString(3,amount);
            				stat4.setString(4,"0.0");
            				stat4.setString(5,"self cheque");
            				stat4.setString(6,"debit to self cheque cheque_no:"+cheque_no);
            				stat4.executeUpdate();

							PreparedStatement stat5=conn.prepareStatement("insert into transaction_details values(?,?,?,?,now(),?,?)");
            				stat5.setString(1,trans_id);
            				stat5.setString(2,rs.getString("account_no"));
            				stat5.setString(3,"0.0");
            				stat5.setString(4,amount);
            				stat5.setString(5,"cheque withdraw");
            				stat5.setString(6,"credit by cheque withdraw cheque_no:"+cheque_no);
            				stat5.executeUpdate();
            			
            				PreparedStatement stat6=conn.prepareStatement("update cheque_issue_details set cheque_status='used' where cheque_no=?");
            				stat6.setString(1,cheque_no);
            				stat6.executeUpdate();
            				
							out.print("<font color='green'>ammount withdraw successfully from saving account by self cheque </font>");
							}
							else
							{
							PreparedStatement stat7=conn.prepareStatement("update cheque_issue_details set cheque_status='bounced' where cheque_no=?");
            				stat7.setString(1,cheque_no);
            				stat7.executeUpdate();

							out.print("<font color='red'>cheque Bounced</font>");
							}
						
						}
						else
						{
						out.print("<font color='red'>cheque account no not found</font>");
						}
						}//end of cheque no validating
      			
            		}
            	}//end of try
            	catch(Exception e)
            	{
            		out.print("Error :"+e);
            	}
            	finally
            	{
            		rs.close();
            		conn.close();
            	}
            
            
            
            }//end of if saving withdraw ///by cheque self
            
            if(ch_acc_no!=null && ch_acc_no!="" && ch_acc_type.equals("ca"))
            {
            	try
            	{
            		conn=bean.getConnection(request);
            		
            		PreparedStatement chstat=conn.prepareStatement("select * from cheque_issue_details where account_no=? and cheque_no=? and cheque_status='issued'");
            		chstat.setString(1,ch_acc_no);
					chstat.setString(2,cheque_no);
            		ResultSet chrs=chstat.executeQuery();
					if(!chrs.next())
					{
						out.print("<font color='red'>cheque no not found or not issued</font>");
					}
					else
					{
            		PreparedStatement stat=conn.prepareStatement("select * from branch_account where branch_id=? and account_name='Cash'");
            		stat.setString(1,branch);
            		rs=stat.executeQuery();
            		if(!rs.next())
            		{
            			out.print("<font color='red'>branch Cash account no not found</font>");
            		}
            		else
            		{
            			PreparedStatement stat1=conn.prepareStatement("select * from saving_and_current_account where account_no=? and acc_type='ca'");
            			stat1.setString(1,ch_acc_no);
            			ResultSet rs1=stat1.executeQuery();
            			
            			if(rs1.next())
            			{
            				if((rs1.getDouble("balance")>=Double.parseDouble(amount)))
            				{
            				PreparedStatement stat2=conn.prepareStatement("update branch_account set balance=? where account_no=?");
            				double newCashBalance=rs.getDouble("balance")-Double.parseDouble(amount);
            				stat2.setDouble(1,newCashBalance);
            				stat2.setString(2,rs.getString("account_no"));
            				stat2.executeUpdate();
            			
            				PreparedStatement stat3=conn.prepareStatement("update saving_and_current_account set balance=? where account_no=?");
            				double newBalance=rs1.getDouble("balance")-Double.parseDouble(amount);
            				stat3.setDouble(1,newBalance);
            				stat3.setString(2,rs1.getString("account_no"));
            				stat3.executeUpdate();
            			
            				PreparedStatement stat4=conn.prepareStatement("insert into transaction_details values(?,?,?,?,now(),?,?)");
            				String trans_id=String.valueOf((int)(10000*Math.random()+1));
            				stat4.setString(1,trans_id);
            				stat4.setString(2,rs1.getString("account_no"));
            				stat4.setString(3,amount);
            				stat4.setString(4,"0.0");
            				stat4.setString(5,"self cheque");
            				stat4.setString(6,"debit to self cheque cheque_no:"+cheque_no);
            				stat4.executeUpdate();

							PreparedStatement stat5=conn.prepareStatement("insert into transaction_details values(?,?,?,?,now(),?,?)");
            				stat5.setString(1,trans_id);
            				stat5.setString(2,rs.getString("account_no"));
            				stat5.setString(3,"0.0");
            				stat5.setString(4,amount);
            				stat5.setString(5,"cheque withdraw");
            				stat5.setString(6,"credit by cheque withdraw cheque_no:"+cheque_no);
            				stat5.executeUpdate();
            			
            				PreparedStatement stat6=conn.prepareStatement("update cheque_issue_details set cheque_status='used' where cheque_no=?");
            				stat6.setString(1,cheque_no);
            				stat6.executeUpdate();
            				
							out.print("<font color='green'>ammount withdraw successfully from current account by self cheque </font>");
							}
							else
							{
							PreparedStatement stat7=conn.prepareStatement("update cheque_issue_details set cheque_status='bounced' where cheque_no=?");
            				stat7.setString(1,cheque_no);
            				stat7.executeUpdate();

							out.print("<font color='red'>cheque Bounced</font>");
							}
						
						}
						else
						{
						out.print("<font color='red'>cheque account no not found</font>");
						}
						}//end of cheque no validating
      			
            		}
            	}//end of try
            	catch(Exception e)
            	{
            		out.print("Error :"+e);
            	}
            	finally
            	{
            		rs.close();
            		conn.close();
            	}

            
            
            
            }//end of if current withdraw by cheque



           
    %>

        <script type="text/javascript">
          
          function validate2()
          {
          	if(document.chequewithdraw.ch_acc_no.value=="")
          	{
          	alert("please enter cheque account no");
          	return;
          	}
          	var myurl="ShowAccountEnquiry.jsp?acc_no="+document.chequewithdraw.ch_acc_no.value+"&acc_type="+document.chequewithdraw.ch_acc_type.value;
  	  		window.open(myurl,"enquiry","location=no,menubar=no,toolbar=no");
          }

          function validate1()
          {
          	if(document.chequewithdraw.ch_acc_no.value=="")
          	{
          	alert("please enter account no");
          	document.chequewithdraw.ch_acc_no.value="";
          	return;
          	}
          	if(document.chequewithdraw.amount.value=="")
          	{
          	alert("please enter amount");
          	document.chequewithdraw.ch_acc_no.value="";
          	return;
          	}
          	if(document.chequewithdraw.ch_acc_no.value=="")
          	{
          	alert("please enter cheque account no");
          	document.chequewithdraw.ch_acc_no.value="";
          	return;
          	}
          	if(document.chequewithdraw.cheque_no.value=="")
          	{
          	alert("please enter cheque no");
          	document.chequewithdraw.ch_acc_no.value="";
          	return;
          	}



          	
          }

            </script>

            <form name="chequewithdraw" method="post">
            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="60%">
              <tr>
                <td width="100%" colspan="2" bgcolor="#0F57BB" align="center">
                <b><font color="#FFFFFF">Cheque Withdraw Self</font></b></td>
              </tr>
              <tr>
                <td width="35%" align="left">Cheque Account No</td>
                <td width="65%" align="left">
                <input type="text" name="ch_acc_no" size="20"></td>
              </tr>
              <tr>
                <td width="35%" align="left">cheque Account type</td>
                <td width="65%" align="left">
                <select size="1" name="ch_acc_type">
                
                <option selected value="ca">Current Account</option>
                <option value="sb">Saving Bank Account</option>
                
                </select><input type="button" value="View Account" name="B4" onclick="validate2();"></td>
              </tr>
              <tr>
                <td width="35%" align="left">Amount :</td>
                <td width="65%" align="left"><input type="text" name="amount" size="20"></td>
              </tr>
              <tr>
                <td width="35%" align="left">Cheque_no</td>
                <td width="65%" align="left">
                <input type="text" name="cheque_no" size="20"></td>
              </tr>
              <tr>
                <td width="35%" align="left">&nbsp;</td>
                <td width="65%" align="left">
                &nbsp;</td>
              </tr>
              <tr>
                <td width="35%" align="left">&nbsp;</td>
                <td width="65%" align="left"><input type="submit" value="Transmit" name="B1" onclick="validate1()">
                <input type="reset" value="Reset" name="B2"></td>
              </tr>
              <tr>
                <td width="35%" align="left">&nbsp;</td>
                <td width="65%" align="left">&nbsp;</td>
              </tr>
            </table>
            </form>

          
            
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