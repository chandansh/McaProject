<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*,java.util.*,com.oreilly.servlet.MultipartRequest"  %>
<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>New Page 1</title>
</head>
<jsp:useBean id="bean" scope="page" class="com.cbs.CBSBean" />
<body>
<% 
	String user_src=(String)session.getAttribute("user");
	String user_type=(String)session.getAttribute("user_type");
	String branch=(String)session.getAttribute("branch");
	String msg="";
	if (user_src!=null && user_type!=null && user_type.equals("Officer"))
  	{
	out.println("Hi "+user_src);
	//out.println("<br>"+session.getId());
	}
	else
	{
		response.sendRedirect("Unauthorised.htm");
	}
	
	%>
<%
String rd_cif_no=request.getParameter("rd_cif_no");
String fd_cif_no=request.getParameter("fd_cif_no");
Connection conn;
conn=null;
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;

if(rd_cif_no!=null && rd_cif_no!="")
{
	try
	{
		String rd_location=request.getParameter("rd_location");
		String rd_nominee_cif=request.getParameter("rd_nominee_cif");
		String rd_time_duration=request.getParameter("rd_time_duration");
		String rd_premium=request.getParameter("rd_premium");
		Double rd_interest_rate=0.0d;
		
		conn=bean.getConnection(request);
		PreparedStatement stat=conn.prepareStatement("select * from customer_info_table where cif_number=? and not cust_type='Nominee' and branch_id=?");
		stat.setString(1,rd_cif_no);
		stat.setString(2,branch);
		rs=stat.executeQuery();
		
		PreparedStatement stat1=conn.prepareStatement("select * from customer_info_table where cif_number=? and cust_type='Nominee' and branch_id=?");
		stat1.setString(1,rd_nominee_cif);
		stat1.setString(2,branch);
		rs1=stat1.executeQuery();
		
		PreparedStatement stat2=conn.prepareStatement("select interest_rate from account_type where account_type_id='rd'");
		rs2=stat2.executeQuery();
		
		if(rs2.next())
		{
		rd_interest_rate=rs2.getDouble("interest_rate");
		}
		
		if(!rs.next())
		{
		msg="<font color='red'><b>customer CIF not found</b></font>";
		}
		else if(!rs1.next())
		{
		msg="<font color='red'><b>Nominee CIF not found</b></font>";
		}
		else
		{
		String rd_acc_no="33"+branch+String.valueOf((int)(10000*Math.random()+1));
		Double rd_total=com.cbs.CalculateRDTotal.calculate(Double.parseDouble(rd_premium),rd_interest_rate,Integer.parseInt(rd_time_duration));
		
		PreparedStatement stat3=conn.prepareStatement("insert into rd_account values(?,?,?,now(),?,?,?,?,?,?,0,0.0)");
		stat3.setString(1,rd_acc_no);
		stat3.setString(2,branch);
		stat3.setString(3,rd_cif_no);
		stat3.setString(4,rd_location);
		stat3.setString(5,rd_nominee_cif);
		stat3.setString(6,rd_time_duration);
		stat3.setString(7,rd_premium);
		stat3.setDouble(8,rd_interest_rate);
		stat3.setDouble(9,rd_total);
		stat3.executeUpdate();
		msg="<font color='green'><b>RD account created successfully <br>account No: "+rd_acc_no+"<br>Total amount :"+rd_total+"</b></font>";

		
		}
	}
	catch(Exception e)
	{
		msg="Error :"+e;
	}
	finally
	{	
		rs.close();
		rs1.close();
		rs2.close();
		conn.close();
	}
		
}//end of if rd

if(fd_cif_no!=null && fd_cif_no!="")
{
	
	try
	{
		String fd_location=request.getParameter("fd_location");
		String fd_nominee_cif=request.getParameter("fd_nominee_cif");
		String fd_time_duration=request.getParameter("fd_time_duration");
		
		
		
		conn=bean.getConnection(request);
		PreparedStatement stat=conn.prepareStatement("select * from customer_info_table where cif_number=? and not cust_type='Nominee' and branch_id=?");
		stat.setString(1,fd_cif_no);
		stat.setString(2,branch);
		rs=stat.executeQuery();
		
		PreparedStatement stat1=conn.prepareStatement("select * from customer_info_table where cif_number=? and cust_type='Nominee' and branch_id=?");
		stat1.setString(1,fd_nominee_cif);
		stat1.setString(2,branch);
		rs1=stat1.executeQuery();
		
		
		
		if(!rs.next())
		{
		msg="<font color='red'><b>customer CIF not found</b></font>";
		}
		else if(!rs1.next())
		{
		msg="<font color='red'><b>Nominee CIF not found</b></font>";
		}
		else
		{
		String fd_acc_no="44"+branch+String.valueOf((int)(10000*Math.random()+1));
		
		
		PreparedStatement stat3=conn.prepareStatement("insert into fd_account values(?,?,?,now(),?,?,?,0.0,0.0,0.0)");
		stat3.setString(1,fd_acc_no);
		stat3.setString(2,branch);
		stat3.setString(3,fd_cif_no);
		stat3.setString(4,fd_location);
		stat3.setString(5,fd_nominee_cif);
		stat3.setString(6,fd_time_duration);
		stat3.executeUpdate();
		msg="<font color='green'><b>FD account created successfully <br>account No: "+fd_acc_no+"<br>please deposite the amount to the counter</b></font>";

		
		}
	}
	catch(Exception e)
	{
		msg="Error :"+e;
	}
	finally
	{	
		rs.close();
		rs1.close();
		conn.close();
	}

		
}//end of if fd




%>

<p>SB and CA account created Successfully</p>

<jsp:forward page="CreateAccount.jsp">
<jsp:param name="msg" value="<%=msg%>"/>
</jsp:forward>

		
 		
</body>

</html>