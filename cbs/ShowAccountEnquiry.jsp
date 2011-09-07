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
  
  
<% 
	String user_src=(String)session.getAttribute("user");
	String user_type=(String)session.getAttribute("user_type");
	String branch=(String)session.getAttribute("branch");
	if (user_src!=null && user_type!=null )
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

<tr>
  
        <td valign="top" class="sbiback" height="402">
        <div align="center">
          <center>
         <%
         String acc_no=request.getParameter("acc_no");
         String acc_type=request.getParameter("acc_type");
		//out.print("account no :"+acc_no);
		//out.print("<br>account type :"+acc_type);
		if(acc_type.equals("sb"))
		{
			try
			{
			conn=bean.getConnection(request);
			PreparedStatement stat=conn.prepareStatement("select a.*,b.* from customer_info_table as a, saving_and_current_account as b where a.cif_number=b.cif_no and b.account_no=? and b.acc_type='sb'");
			stat.setString(1,acc_no);
			//stat.setString(2,branch);
			rs=stat.executeQuery();
		
		
				if(!rs.next())
				{
				out.print("<font color='red'><b>Account number not found</b></font>");
				}
				else
				{
				%>
         <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#336699" width="880" height="182">
           <tr>
             <td width="896" colspan="3" bgcolor="#336699" align="center" bordercolor="#003366" height="18">
             <b><font color="#FFFFFF">Account Information 
             Saving Account</font></b></td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Account No:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("account_no")%>&nbsp; CIF:<%=rs.getString("cif_no")%></td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Branch:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("branch_id")%></td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Account Type:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("acc_type")%></td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Account Holder Name:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("first_name_business_name")%>&nbsp;<%=rs.getString("middle_name")%>&nbsp;<%=rs.getString("last_name")%>&nbsp;</td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Address:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("address")%>&nbsp;<%=rs.getString("city")%>&nbsp;<%=rs.getString("pin_code")%>&nbsp;
             <%=rs.getString("state")%>&nbsp;<%=rs.getString("country")%>&nbsp;
             
             </td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Balance:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("balance")%></td>
           </tr>
           <tr>
             <td width="245" align="left" height="18"></td>
             <td width="650" align="left" height="18" colspan="2"></td>
           </tr>
           <%
           if(rs.getBoolean("joint_account"))
           {
           PreparedStatement stat2=conn.prepareStatement("select * from customer_info_table where cif_number=? and not cust_type='Nominee'");
           stat2.setString(1,rs.getString("cif_second_member"));
           ResultSet rs2=stat2.executeQuery();
           		if(rs2.next())
           		{
           		%>
           		<tr>
             <td width="245" align="left" height="18">Joint Account Holder CIF:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("cif_second_member")%></td>
           </tr>

           		<tr>
             <td width="245" align="left" height="18">Joint Account Holder Name:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs2.getString("first_name_business_name")%>&nbsp;<%=rs2.getString("middle_name")%>&nbsp;<%=rs2.getString("last_name")%>&nbsp;</td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Joint Account Holder Address:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs2.getString("address")%>&nbsp;<%=rs2.getString("city")%>&nbsp;<%=rs2.getString("pin_code")%>&nbsp;
             <%=rs2.getString("state")%>&nbsp;<%=rs2.getString("country")%>&nbsp;
             
             </td>
           </tr>
			<%
           		}

           }
           %>
           <%
           PreparedStatement stat1=conn.prepareStatement("select * from customer_info_table where cif_number=? and cust_type='Nominee'");
           stat1.setString(1,rs.getString("nominee_cif"));
           ResultSet rs1=stat1.executeQuery();
           if(rs1.next())
           {
           %>
			<tr>
             <td width="245" align="left" height="18">Nominee CIF:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("nominee_cif")%></td>
           </tr>
           
           <tr>
             <td width="245" align="left" height="18">Nominee Name:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs1.getString("first_name_business_name")%>&nbsp;<%=rs1.getString("middle_name")%>&nbsp;<%=rs1.getString("last_name")%>&nbsp;</td>
           </tr>
           <tr>
             <td width="245" align="left" height="17">Nominee Address:</td>
             <td width="650" align="left" height="17" colspan="2">&nbsp;<%=rs1.getString("address")%>&nbsp;<%=rs1.getString("city")%>&nbsp;<%=rs1.getString("pin_code")%>&nbsp;
             <%=rs1.getString("state")%>&nbsp;<%=rs1.getString("country")%>&nbsp;

             
             </td>
           </tr>
           <%
           }//end of nominee if
           %>
           <tr>
             <td width="505" align="left" height="12" colspan="2">Photo And Sign 
             First customer</td>
             <td width="390" align="left" height="12">Photo Sign Second Member</td>
           </tr>
           <tr>
             <td width="505" align="left" height="220" colspan="2">
             <img border="0" src="DisplayPhoto.jsp?cif_no_first_cust=<%=rs.getString("cif_no")%>" width="186" height="207">
             <img border="0" src="DisplaySign.jsp?cif_no_first_cust=<%=rs.getString("cif_no")%>" width="190" height="207"></td>
             <td width="372" align="left" height="220">
             <%
             if(rs.getBoolean("joint_account"))
             {
             %>
             <img border="0" src="DisplayPhoto.jsp?cif_no_first_cust=<%=rs.getString("cif_second_member")%>" width="184" height="207"><img border="0" src="DisplaySign.jsp?cif_no_first_cust=<%=rs.getString("cif_second_member")%>" width="185" height="206">
             <%
             }
             %></td>
           </tr>
         </table>
         <%
				}//end of else
		
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
		}//end of if saving account enquiry
		
		if(acc_type.equals("ca"))
		{
			try
			{
			conn=bean.getConnection(request);
			PreparedStatement stat=conn.prepareStatement("select a.*,b.* from customer_info_table as a, saving_and_current_account as b where a.cif_number=b.cif_no and b.account_no=? and b.acc_type='ca'");
			stat.setString(1,acc_no);
			//stat.setString(2,branch);
			rs=stat.executeQuery();
		
		
				if(!rs.next())
				{
				out.print("<font color='red'><b>Account number not found</b></font>");
				}
				else
				{
				%>
         <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#336699" width="880" height="182">
           <tr>
             <td width="896" colspan="3" bgcolor="#336699" align="center" bordercolor="#003366" height="18">
             <b><font color="#FFFFFF">Account Information Current Account</font></b></td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Account No:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("account_no")%> &nbsp; CIF:<%=rs.getString("cif_no")%></td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Branch:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("branch_id")%></td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Account Type:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("acc_type")%></td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Account Holder Name:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("first_name_business_name")%>&nbsp;<%=rs.getString("middle_name")%>&nbsp;<%=rs.getString("last_name")%>&nbsp;</td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Address:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("address")%>&nbsp;<%=rs.getString("city")%>&nbsp;<%=rs.getString("pin_code")%>&nbsp;
             <%=rs.getString("state")%>&nbsp;<%=rs.getString("country")%>&nbsp;
             
             </td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Balance:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("balance")%></td>
           </tr>
           <tr>
             <td width="245" align="left" height="18"></td>
             <td width="650" align="left" height="18" colspan="2"></td>
           </tr>
           <%
           if(rs.getBoolean("joint_account"))
           {
           PreparedStatement stat2=conn.prepareStatement("select * from customer_info_table where cif_number=? and not cust_type='Nominee'");
           stat2.setString(1,rs.getString("cif_second_member"));
           ResultSet rs2=stat2.executeQuery();
           		if(rs2.next())
           		{
           		%>
           		<tr>
             <td width="245" align="left" height="18">Joint Account CIF:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("cif_second_member")%></td>
           </tr>

           		<tr>
             <td width="245" align="left" height="18">Joint Account Holder Name:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs2.getString("first_name_business_name")%>&nbsp;<%=rs2.getString("middle_name")%>&nbsp;<%=rs2.getString("last_name")%>&nbsp;</td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Joint Account Holder Address:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs2.getString("address")%>&nbsp;<%=rs2.getString("city")%>&nbsp;<%=rs2.getString("pin_code")%>&nbsp;
             <%=rs2.getString("state")%>&nbsp;<%=rs2.getString("country")%>&nbsp;
             
             </td>
           </tr>
			<%
           		}

           }
           %>
           <%
           PreparedStatement stat1=conn.prepareStatement("select * from customer_info_table where cif_number=? and cust_type='Nominee'");
           stat1.setString(1,rs.getString("nominee_cif"));
           ResultSet rs1=stat1.executeQuery();
           if(rs1.next())
           {
           %>
			<tr>
             <td width="245" align="left" height="18">Nominee CIF:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("nominee_cif")%></td>
           </tr>
           
           <tr>
             <td width="245" align="left" height="18">Nominee Name:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs1.getString("first_name_business_name")%>&nbsp;<%=rs1.getString("middle_name")%>&nbsp;<%=rs1.getString("last_name")%>&nbsp;</td>
           </tr>
           <tr>
             <td width="245" align="left" height="17">Nominee Address:</td>
             <td width="650" align="left" height="17" colspan="2">&nbsp;<%=rs1.getString("address")%>&nbsp;<%=rs1.getString("city")%>&nbsp;<%=rs1.getString("pin_code")%>&nbsp;
             <%=rs1.getString("state")%>&nbsp;<%=rs1.getString("country")%>&nbsp;

             
             </td>
           </tr>
           <%
           }//end of nominee if
           %>
           <tr>
             <td width="505" align="left" height="12" colspan="2">Photo And Sign 
             First customer</td>
             <td width="390" align="left" height="12">Photo Sign Second Member</td>
           </tr>
           <tr>
             <td width="505" align="left" height="220" colspan="2">
             <img border="0" src="DisplayPhoto.jsp?cif_no_first_cust=<%=rs.getString("cif_no")%>" width="186" height="207">
             <img border="0" src="DisplaySign.jsp?cif_no_first_cust=<%=rs.getString("cif_no")%>" width="190" height="207"></td>
             <td width="372" align="left" height="220">
             <%
             if(rs.getBoolean("joint_account"))
             {
             %>
             <img border="0" src="DisplayPhoto.jsp?cif_no_first_cust=<%=rs.getString("cif_second_member")%>" width="184" height="207"><img border="0" src="DisplaySign.jsp?cif_no_first_cust=<%=rs.getString("cif_second_member")%>" width="185" height="206">
             <%
             }
             %></td>
           </tr>
         </table>
         <%
				}//end of else
		
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
		}//end of if current account enquiry
		
		if(acc_type.equals("fd"))
		{
			try
			{
			conn=bean.getConnection(request);
			PreparedStatement stat=conn.prepareStatement("select a.*,b.* from customer_info_table as a, fd_account as b where a.cif_number=b.cif_no and b.account_no=? ");
			stat.setString(1,acc_no);
			//stat.setString(2,branch);
			rs=stat.executeQuery();
		
		
				if(!rs.next())
				{
				out.print("<font color='red'><b>Account number not found</b></font>");
				}
				else
				{
				%>
         <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#336699" width="880" height="182">
           <tr>
             <td width="896" colspan="3" bgcolor="#336699" align="center" bordercolor="#003366" height="18">
             <b><font color="#FFFFFF">Account Information Fixed Account</font></b></td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Account No:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("account_no")%>&nbsp;CIF:<%=rs.getString("cif_no")%></td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Branch:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("branch_id")%></td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Account Type:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;Fixed Account</td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Account Holder Name:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("first_name_business_name")%>&nbsp;<%=rs.getString("middle_name")%>&nbsp;<%=rs.getString("last_name")%>&nbsp;</td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Address:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("address")%>&nbsp;<%=rs.getString("city")%>&nbsp;<%=rs.getString("pin_code")%>&nbsp;
             <%=rs.getString("state")%>&nbsp;<%=rs.getString("country")%>&nbsp;
             
             </td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Time Duration:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("time_duration")%>&nbsp;months</td>
           </tr>
		<tr>
             <td width="245" align="left" height="18">Account Open Date:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("account_open_date")%></td>
           </tr>

           <tr>
             <td width="245" align="left" height="18">Deposit Amount:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("deposit_amount")%></td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Total Amount:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("total_amount")%></td>
           </tr>

			<tr>
             <td width="245" align="left" height="18">Interest Rate:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("interest_rate")%></td>
           </tr>

           
           
           <%
           PreparedStatement stat1=conn.prepareStatement("select * from customer_info_table where cif_number=? and cust_type='Nominee'");
           stat1.setString(1,rs.getString("nominee_cif"));
           ResultSet rs1=stat1.executeQuery();
           if(rs1.next())
           {
           %>
			<tr>
             <td width="245" align="left" height="18">Nominee CIF:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("nominee_cif")%></td>
           </tr>
           
           <tr>
             <td width="245" align="left" height="18">Nominee Name:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs1.getString("first_name_business_name")%>&nbsp;<%=rs1.getString("middle_name")%>&nbsp;<%=rs1.getString("last_name")%>&nbsp;</td>
           </tr>
           <tr>
             <td width="245" align="left" height="17">Nominee Address:</td>
             <td width="650" align="left" height="17" colspan="2">&nbsp;<%=rs1.getString("address")%>&nbsp;<%=rs1.getString("city")%>&nbsp;<%=rs1.getString("pin_code")%>&nbsp;
             <%=rs1.getString("state")%>&nbsp;<%=rs1.getString("country")%>&nbsp;

             
             </td>
           </tr>
           <%
           }//end of nominee if
           %>
           <tr>
             <td width="505" align="left" height="12" colspan="2">Photo And Sign 
              
             customer</td>
             <td width="390" align="left" height="12"></td>
           </tr>
           <tr>
             <td width="505" align="left" height="220" colspan="2">
             <img border="0" src="DisplayPhoto.jsp?cif_no_first_cust=<%=rs.getString("cif_no")%>" width="186" height="207">
             <img border="0" src="DisplaySign.jsp?cif_no_first_cust=<%=rs.getString("cif_no")%>" width="190" height="207"></td>
             <td width="372" align="left" height="220">
             </td>
           </tr>
         </table>
         <%
				}//end of else
		
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
		}//end of if Fixed account enquiry
		
		
		
if(acc_type.equals("rd"))
		{
			try
			{
			conn=bean.getConnection(request);
			PreparedStatement stat=conn.prepareStatement("select a.*,b.* from customer_info_table as a, rd_account as b where a.cif_number=b.cif_no and b.account_no=? ");
			stat.setString(1,acc_no);
			//stat.setString(2,branch);
			rs=stat.executeQuery();
		
		
				if(!rs.next())
				{
				out.print("<font color='red'><b>Account number not found</b></font>");
				}
				else
				{
				%>
         <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#336699" width="880" height="182">
           <tr>
             <td width="896" colspan="3" bgcolor="#336699" align="center" bordercolor="#003366" height="18">
             <b><font color="#FFFFFF">Account Information Recurrent Deposit Account</font></b></td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Account No:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("account_no")%>&nbsp;CIF:<%=rs.getString("cif_no")%></td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Branch:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("branch_id")%></td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Account Type:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;Recurrent deposit Account</td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Account Holder Name:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("first_name_business_name")%>&nbsp;<%=rs.getString("middle_name")%>&nbsp;<%=rs.getString("last_name")%>&nbsp;</td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Address:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("address")%>&nbsp;<%=rs.getString("city")%>&nbsp;<%=rs.getString("pin_code")%>&nbsp;
             <%=rs.getString("state")%>&nbsp;<%=rs.getString("country")%>&nbsp;
             
             </td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Time Duration:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("time_duration")%>&nbsp;months</td>
           </tr>
		<tr>
             <td width="245" align="left" height="18">Account Open Date:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("account_open_date")%></td>
           </tr>

           <tr>
             <td width="245" align="left" height="18">premium Amount:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("premium_amount")%></td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Total Amount after completing the time duration if all premium paid:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("total_amount")%></td>
           </tr>

			<tr>
             <td width="245" align="left" height="18">Interest Rate:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("interest_rate")%></td>
           </tr>
           <tr>
             <td width="245" align="left" height="18">Installment Paid:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("installment_paid")%></td>
           </tr>
			<tr>
             <td width="245" align="left" height="18">Total Paid Amount:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("total_paid_amount")%></td>
           </tr>


          
           
           <%
           PreparedStatement stat1=conn.prepareStatement("select * from customer_info_table where cif_number=? and cust_type='Nominee'");
           stat1.setString(1,rs.getString("nominee_cif"));
           ResultSet rs1=stat1.executeQuery();
           if(rs1.next())
           {
           %>
			<tr>
             <td width="245" align="left" height="18">Nominee CIF:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs.getString("nominee_cif")%></td>
           </tr>

           
           <tr>
             <td width="245" align="left" height="18">Nominee Name:</td>
             <td width="650" align="left" height="18" colspan="2">&nbsp;<%=rs1.getString("first_name_business_name")%>&nbsp;<%=rs1.getString("middle_name")%>&nbsp;<%=rs1.getString("last_name")%>&nbsp;</td>
           </tr>
           <tr>
             <td width="245" align="left" height="17">Nominee Address:</td>
             <td width="650" align="left" height="17" colspan="2">&nbsp;<%=rs1.getString("address")%>&nbsp;<%=rs1.getString("city")%>&nbsp;<%=rs1.getString("pin_code")%>&nbsp;
             <%=rs1.getString("state")%>&nbsp;<%=rs1.getString("country")%>&nbsp;

             
             </td>
           </tr>
           <%
           }//end of nominee if
           %>
           <tr>
             <td width="505" align="left" height="12" colspan="2">Photo And Sign 
              
             customer</td>
             <td width="390" align="left" height="12"></td>
           </tr>
           <tr>
             <td width="505" align="left" height="220" colspan="2">
             <img border="0" src="DisplayPhoto.jsp?cif_no_first_cust=<%=rs.getString("cif_no")%>" width="186" height="207">
             <img border="0" src="DisplaySign.jsp?cif_no_first_cust=<%=rs.getString("cif_no")%>" width="190" height="207"></td>
             <td width="372" align="left" height="220">
             </td>
           </tr>
         </table>
         <%
				}//end of else
		
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
		}//end of if RD account enquiry


%>
		<script type="text/javascript">
		function validate();
		{
		document.close();
		}
		 </script>
         <form method="POST">
          <p>
           <input type="button" value="Close" name="B1" onclick="validate();"></p>
         </form>

         
         
          <p>&nbsp;</p>

         
         
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