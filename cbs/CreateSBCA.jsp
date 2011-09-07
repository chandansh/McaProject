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
String sb_cif_no=request.getParameter("sb_cif_no");
String ca_cif_no=request.getParameter("ca_cif_no");
Connection conn;
conn=null;
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;

if(sb_cif_no!=null && sb_cif_no!="")
{
	try
	{
		String sb_cheque=request.getParameter("sb_cheque");
		String sb_location=request.getParameter("sb_location");
		String sb_nominee_cif=request.getParameter("sb_nominee_cif");
		conn=bean.getConnection(request);
		PreparedStatement stat=conn.prepareStatement("select * from customer_info_table where cif_number=? and not cust_type='Nominee' and branch_id=?");
		stat.setString(1,sb_cif_no);
		stat.setString(2,branch);
		rs=stat.executeQuery();
		
		PreparedStatement stat1=conn.prepareStatement("select * from customer_info_table where cif_number=? and cust_type='Nominee' and branch_id=?");
		stat1.setString(1,sb_nominee_cif);
		stat1.setString(2,branch);
		rs1=stat1.executeQuery();

		PreparedStatement stat2=conn.prepareStatement("select * from saving_and_current_account where cif_no=? and branch_id=?");
		stat2.setString(1,sb_cif_no);
		stat2.setString(2,branch);

		rs2=stat2.executeQuery();

		if(!rs.next())
		{
		msg="<font color='red'><b>customer CIF not found</b></font>";
		}
		else if(!rs1.next())
		{
		msg="<font color='red'><b>Nominee CIF not found</b></font>";
		}
		else if(rs2.next())
		{
		msg="<font color='red'><b>This CIF have a saving or current account Already</b></font>";
		}
		else
		{
		String sb_acc_no="22"+branch+String.valueOf((int)(10000*Math.random()+1));
		PreparedStatement stat3=conn.prepareStatement("insert into saving_and_current_account values(?,?,'sb',?,now(),?,?,?,0,' ',0.0)");
		stat3.setString(1,sb_acc_no);
		stat3.setString(2,branch);
		stat3.setString(3,sb_cif_no);
		stat3.setString(4,sb_cheque);
		stat3.setString(5,sb_location);
		stat3.setString(6,sb_nominee_cif);
		stat3.executeUpdate();
		msg="<font color='green'><b>Saving account created successfully <br>account No: "+sb_acc_no+"</b></font>";

		
		}
	}
	catch(Exception e)
	{
		msg="Error :"+e;
	}
	finally
	{
		conn.close();
	}
		
}

if(ca_cif_no!=null && ca_cif_no!="")
{
	try
	{
		String ca_cheque=request.getParameter("ca_cheque");
		String ca_location=request.getParameter("ca_location");
		String ca_nominee_cif=request.getParameter("ca_nominee_cif");
		conn=bean.getConnection(request);
		PreparedStatement stat=conn.prepareStatement("select * from customer_info_table where cif_number=? and not cust_type='Nominee' and branch_id=?");
		stat.setString(1,ca_cif_no);
		stat.setString(2,branch);
		rs=stat.executeQuery();
		
		PreparedStatement stat1=conn.prepareStatement("select * from customer_info_table where cif_number=? and cust_type='Nominee' and branch_id=?");
		stat1.setString(1,ca_nominee_cif);
		stat1.setString(2,branch);
		rs1=stat1.executeQuery();
		
		PreparedStatement stat2=conn.prepareStatement("select * from saving_and_current_account where cif_no=? and branch_id=?");
		stat2.setString(1,ca_cif_no);
		stat2.setString(2,branch);
		rs2=stat2.executeQuery();


		if(!rs.next())
		{
		msg="<font color='red'><b>customer CIF not found</b></font>";
		}
		else if(!rs1.next())
		{
		msg="<font color='red'><b>Nominee CIF not found</b></font>";
		}
		else if(rs2.next())
		{
		msg="<font color='red'><b>This CIF have a saving or current account Already</b></font>";
		}
		else
		{
		
		String ca_acc_no="22"+branch+String.valueOf((int)(10000*Math.random()+1));
		PreparedStatement stat3=conn.prepareStatement("insert into saving_and_current_account values(?,?,'ca',?,now(),?,?,?,0,' ',0.0)");
		stat3.setString(1,ca_acc_no);
		stat3.setString(2,branch);
		stat3.setString(3,ca_cif_no);
		stat3.setString(4,ca_cheque);
		stat3.setString(5,ca_location);
		stat3.setString(6,ca_nominee_cif);
		stat3.executeUpdate();
		msg="<font color='green'><b>Current account created successfully <br>account No: "+ca_acc_no+"</b></font>";
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
		
}




%>

<p>SB and CA account created Successfully</p>

<jsp:forward page="CreateAccount.jsp">
<jsp:param name="msg" value="<%=msg%>"/>
</jsp:forward>

		
 		
</body>

</html>