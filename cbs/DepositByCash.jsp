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
    <tr><td align="center" height="30px" bgcolor="#E3E3FD">Deposit By Cash</tr>
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
          <div align="center">
            <center>
            <%
            String acc_no=request.getParameter("acc_no");
            String acc_type=request.getParameter("acc_type");
            String amount=request.getParameter("amount");
            String deposit_by=request.getParameter("deposit_by");
            if(acc_no!=null && acc_no!="" && acc_type.equals("sb"))
            {
            	try
            	{
            		conn=bean.getConnection(request);
            		PreparedStatement stat=conn.prepareStatement("select * from saving_and_current_account where account_no=? and acc_type='sb'");
            		stat.setString(1,acc_no);
            		rs=stat.executeQuery();
            		if(!rs.next())
            		{
            			out.print("<font color='red'>account no not found</font>");
            		}
            		else
            		{
            			PreparedStatement stat1=conn.prepareStatement("select * from branch_account where branch_id=? and account_name='Cash'");
            			stat1.setString(1,branch);
            			ResultSet rs1=stat1.executeQuery();
            			
            			if(rs1.next())
            			{
            			PreparedStatement stat2=conn.prepareStatement("update branch_account set balance=? where account_no=?");
            			
            			double newCashBalance=rs1.getDouble("balance")+Double.parseDouble(amount);
            			stat2.setDouble(1,newCashBalance);
            			stat2.setString(2,rs1.getString("account_no"));
            			stat2.executeUpdate();
            			
            			PreparedStatement stat3=conn.prepareStatement("update saving_and_current_account set balance=? where account_no=?");
            			double newBalance=rs.getDouble("balance")+Double.parseDouble(amount);
            			stat3.setDouble(1,newBalance);
            			stat3.setString(2,rs.getString("account_no"));
            			stat3.executeUpdate();
            			
            			PreparedStatement stat4=conn.prepareStatement("insert into transaction_details values(?,?,?,?,now(),?,?)");
            			String trans_id=String.valueOf((int)(10000*Math.random()+1));
            			stat4.setString(1,trans_id);
            			stat4.setString(2,rs1.getString("account_no"));
            			stat4.setString(3,amount);
            			stat4.setString(4,"0.0");
            			stat4.setString(5,"cash Deposit");
            			stat4.setString(6,"debit to cash deposit by customer acc");
            			stat4.executeUpdate();

						PreparedStatement stat5=conn.prepareStatement("insert into transaction_details values(?,?,?,?,now(),?,?)");
            			stat5.setString(1,trans_id);
            			stat5.setString(2,rs.getString("account_no"));
            			stat5.setString(3,"0.0");
            			stat5.setString(4,amount);
            			stat5.setString(5,deposit_by);
            			stat5.setString(6,"credit by cash deposit");
            			stat5.executeUpdate();
            			
            			
						out.print("<font color='green'>ammount deposited successfully to saving account</font>");
						}
						else
						{
						out.print("<font color='red'>Branch cash account no not found</font>");
						}
      			
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
            
            
            
            }//end of if saving deposit
            
            if(acc_no!=null && acc_no!="" && acc_type.equals("ca"))
            {
            	try
            	{
            		conn=bean.getConnection(request);
            		PreparedStatement stat=conn.prepareStatement("select * from saving_and_current_account where account_no=? and acc_type='ca'");
            		stat.setString(1,acc_no);
            		rs=stat.executeQuery();
            		if(!rs.next())
            		{
            			out.print("<font color='red'>account no not found</font>");
            		}
            		else
            		{
            			PreparedStatement stat1=conn.prepareStatement("select * from branch_account where branch_id=? and account_name='Cash'");
            			stat1.setString(1,branch);
            			ResultSet rs1=stat1.executeQuery();
            			
            			if(rs1.next())
            			{
            			PreparedStatement stat2=conn.prepareStatement("update branch_account set balance=? where account_no=?");
            			
            			double newCashBalance=rs1.getDouble("balance")+Double.parseDouble(amount);
            			stat2.setDouble(1,newCashBalance);
            			stat2.setString(2,rs1.getString("account_no"));
            			stat2.executeUpdate();
            			
            			PreparedStatement stat3=conn.prepareStatement("update saving_and_current_account set balance=? where account_no=?");
            			double newBalance=rs.getDouble("balance")+Double.parseDouble(amount);
            			stat3.setDouble(1,newBalance);
            			stat3.setString(2,rs.getString("account_no"));
            			stat3.executeUpdate();
            			
            			PreparedStatement stat4=conn.prepareStatement("insert into transaction_details values(?,?,?,?,now(),?,?)");
            			String trans_id=String.valueOf((int)(10000*Math.random()+1));
            			stat4.setString(1,trans_id);
            			stat4.setString(2,rs1.getString("account_no"));
            			stat4.setString(3,amount);
            			stat4.setString(4,"0.0");
            			stat4.setString(5,"cash Deposit");
            			stat4.setString(6,"debit to cash deposit by customer acc");
            			stat4.executeUpdate();

						PreparedStatement stat5=conn.prepareStatement("insert into transaction_details values(?,?,?,?,now(),?,?)");
            			stat5.setString(1,trans_id);
            			stat5.setString(2,rs.getString("account_no"));
            			stat5.setString(3,"0.0");
            			stat5.setString(4,amount);
            			stat5.setString(5,deposit_by);
            			stat5.setString(6,"credit by cash deposit");
            			stat5.executeUpdate();
            			
            			
						out.print("<font color='green'>ammount deposited successfully to current account</font>");
						}
						else
						{
						out.print("<font color='red'>Branch cash account no not found</font>");
						}
      			
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
            
            
            
            }//end of if current account deposit
            
            if(acc_no!=null && acc_no!="" && acc_type.equals("rd"))
            {
            	try
            	{
            		conn=bean.getConnection(request);
            		PreparedStatement stat=conn.prepareStatement("select * from rd_account where account_no=? ");
            		stat.setString(1,acc_no);
            		rs=stat.executeQuery();
            		if(!rs.next())
            		{
            			out.print("<font color='red'>account no not found</font>");
            		}
            		else
            		{
            			PreparedStatement stat1=conn.prepareStatement("select * from branch_account where branch_id=? and account_name='Cash'");
            			stat1.setString(1,branch);
            			ResultSet rs1=stat1.executeQuery();
            			
            			if(rs1.next())
            			{
            			PreparedStatement stat2=conn.prepareStatement("update branch_account set balance=? where account_no=?");
            			
            			double newCashBalance=rs1.getDouble("balance")+Double.parseDouble(amount);
            			stat2.setDouble(1,newCashBalance);
            			stat2.setString(2,rs1.getString("account_no"));
            			stat2.executeUpdate();
            			
            			PreparedStatement stat3=conn.prepareStatement("update rd_account set total_paid_amount=?,installment_paid=? where account_no=?");
            			double newBalance=rs.getDouble("total_paid_amount")+Double.parseDouble(amount);
            			int paid_premium_no=rs.getInt("installment_paid")+1;
            			stat3.setDouble(1,newBalance);
            			stat3.setInt(2,paid_premium_no);
            			stat3.setString(3,rs.getString("account_no"));
            			stat3.executeUpdate();
            			
            			PreparedStatement stat4=conn.prepareStatement("insert into transaction_details values(?,?,?,?,now(),?,?)");
            			String trans_id=String.valueOf((int)(10000*Math.random()+1));
            			stat4.setString(1,trans_id);
            			stat4.setString(2,rs1.getString("account_no"));
            			stat4.setString(3,amount);
            			stat4.setString(4,"0.0");
            			stat4.setString(5,"cash Deposit");
            			stat4.setString(6,"debit to cash deposit by customer rd acc");
            			stat4.executeUpdate();

						PreparedStatement stat5=conn.prepareStatement("insert into transaction_details values(?,?,?,?,now(),?,?)");
            			stat5.setString(1,trans_id);
            			stat5.setString(2,rs.getString("account_no"));
            			stat5.setString(3,"0.0");
            			stat5.setString(4,amount);
            			stat5.setString(5,deposit_by);
            			stat5.setString(6,"credit by cash deposit rd installment");
            			stat5.executeUpdate();
            			
            			
						out.print("<font color='green'>ammount deposited successfully to rd account installment</font>");
						}
						else
						{
						out.print("<font color='red'>Branch cash account no not found</font>");
						}
      			
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
            
            
            
            }//end of if rd account cash deposit
            
            if(acc_no!=null && acc_no!="" && acc_type.equals("fd"))
            {
            	try
            	{
            		conn=bean.getConnection(request);
            		PreparedStatement stat=conn.prepareStatement("select * from fd_account where account_no=?  ");
            		stat.setString(1,acc_no);
            		rs=stat.executeQuery();
            		if(!rs.next())
            		{
            			out.print("<font color='red'>account no not found</font>");
            		}
            		else if(!(rs.getDouble("deposit_amount")>0.0))
            		{
            			PreparedStatement stat1=conn.prepareStatement("select * from branch_account where branch_id=? and account_name='Cash'");
            			stat1.setString(1,branch);
            			ResultSet rs1=stat1.executeQuery();
            			
            			if(rs1.next())
            			{
            			
            			PreparedStatement stat6=conn.prepareStatement("select * from account_type where account_type_id='fd' ");
            			ResultSet rs6=stat6.executeQuery();
            			if(rs6.next())
            				{
            				PreparedStatement stat2=conn.prepareStatement("update branch_account set balance=? where account_no=?");
            				double newCashBalance=rs1.getDouble("balance")+Double.parseDouble(amount);
            				stat2.setDouble(1,newCashBalance);
            				stat2.setString(2,rs1.getString("account_no"));
            				stat2.executeUpdate();
            			           			
            				PreparedStatement stat3=conn.prepareStatement("update fd_account set deposit_amount=?,interest_rate=?,total_amount=? where account_no=?");
            				double newBalance=rs.getDouble("deposit_amount")+Double.parseDouble(amount);
            				double interest_rate=rs6.getDouble("interest_rate");
            				int monthfd=rs.getInt("time_duration");
            				double total_amountfd=newBalance;
							for(int i=1;i<=monthfd;i++)
							{
							if(i%3==0)
							{
							total_amountfd+=total_amountfd*interest_rate/100.0d;
							}
							}     
							stat3.setDouble(1,newBalance);
            				stat3.setDouble(2,interest_rate);
            				stat3.setDouble(3,total_amountfd);
            				stat3.setString(4,rs.getString("account_no"));
            				stat3.executeUpdate();
            			
            				PreparedStatement stat4=conn.prepareStatement("insert into transaction_details values(?,?,?,?,now(),?,?)");
            				String trans_id=String.valueOf((int)(10000*Math.random()+1));
            				stat4.setString(1,trans_id);
            				stat4.setString(2,rs1.getString("account_no"));
            				stat4.setString(3,amount);
            				stat4.setString(4,"0.0");
            				stat4.setString(5,"cash Deposit");
            				stat4.setString(6,"debit to cash deposit by customer fd acc");
            				stat4.executeUpdate();

							PreparedStatement stat5=conn.prepareStatement("insert into transaction_details values(?,?,?,?,now(),?,?)");
            				stat5.setString(1,trans_id);
            				stat5.setString(2,rs.getString("account_no"));
            				stat5.setString(3,"0.0");
            				stat5.setString(4,amount);
            				stat5.setString(5,deposit_by);
            				stat5.setString(6,"credit by cash deposit fixed deposit");
            				stat5.executeUpdate();
            			
            			
							out.print("<font color='green'>ammount deposited successfully to fixed deposit account </font>");
							
							}
							else
							{
							out.print("<font color='red'>FD Interest not found</font>");
							}
						
						}
						else
						{
						out.print("<font color='red'>Branch cash account no not found</font>");
						}
      			
            		}
            		else
            		{
            			out.print("<font color='red'><b>fd Account already deposited</b></font>");
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
            
            
            
            }//end of if rd account cash deposit

            

            %>
            
            
            
            <script type="text/javascript">
          function validate()
          {
          	if(document.cashdeposit.acc_no.value=="")
          	{
          	alert("please enter account no");
          	document.cashdeposit.acc_no.value="";
          	return;
          	}
          	var myurl="ShowAccountEnquiry.jsp?acc_no="+document.cashdeposit.acc_no.value+"&acc_type="+document.cashdeposit.acc_type.value;
  	  		window.open(myurl,"enquiry","location=no,menubar=no,toolbar=no");
          }
          function validate1()
          {
          	if(document.cashdeposit.acc_no.value=="")
          	{
          	alert("please enter account no");
          	document.cashdeposit.acc_no.value="";
          	return;
          	}
          	if(document.cashdeposit.amount.value=="")
          	{
          	alert("please enter amount");
          	document.cashdeposit.acc_no.value="";
          	return;
          	}

          	
          }

            </script>

            <form name="cashdeposit" method="post">
            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="60%">
              <tr>
                <td width="100%" colspan="2" bgcolor="#0F57BB" align="center">
                <b><font color="#FFFFFF">Cash Deposit</font></b></td>
              </tr>
              <tr>
                <td width="35%" align="left">Enter Account No</td>
                <td width="65%" align="left"><input type="text" name="acc_no" size="20"></td>
              </tr>
              <tr>
                <td width="35%" align="left">Select Account Type</td>
                <td width="65%" align="left">
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
                <td width="35%" align="left">Amount :</td>
                <td width="65%" align="left"><input type="text" name="amount" size="20"></td>
              </tr>
              <tr>
                <td width="35%" align="left">Deposit By</td>
                <td width="65%" align="left"><input type="text" name="deposit_by" size="20"></td>
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
            </center>
          </div>
&nbsp;<p><font face="Arial" color="#000080"><b>End </b></font></p>
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