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
	String msg="message";
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
String P_N_ModifyCIF=request.getParameter("p_N_ModifyCIF");
String np_N_ModifyCIF=request.getParameter("np_N_ModifyCIF");
String A_ModifyCIF=request.getParameter("A_ModifyCIF");
Connection conn;
conn=null;
ResultSet rs=null;

if(P_N_ModifyCIF!=null && P_N_ModifyCIF!="")
{
	try
	{
	conn=bean.getConnection(request);
	String first_name=request.getParameter("first_name");
	String middle_name=request.getParameter("middle_name");
	String last_name=request.getParameter("last_name");
	String relation =request.getParameter("relation");
	String relation_name=request.getParameter("relation_name");
	PreparedStatement stat=conn.prepareStatement("update customer_info_table set first_name_business_name=?,middle_name=?,last_name=?,relation=?,relation_name=? where cif_number=?");
	stat.setString(1,first_name);
	stat.setString(2,middle_name);
	stat.setString(3,last_name);
	stat.setString(4,relation);
	stat.setString(5,relation_name);
	stat.setString(6,P_N_ModifyCIF);
	stat.executeUpdate();
	msg="<font color='green'><b>Name Modified successfully</b></font>";
	
	}//end of try
	catch(Exception e)
	{
		msg="Error :"+e;
	}
	finally
	{
	conn.close();
	}

}

if(np_N_ModifyCIF!=null && np_N_ModifyCIF!="")
{
	try
	{
	conn=bean.getConnection(request);
	String business_name=request.getParameter("business_name");
	String relation =request.getParameter("relation");
	String relation_name=request.getParameter("relation_name");
	PreparedStatement stat=conn.prepareStatement("update customer_info_table set first_name_business_name=?,relation=?,relation_name=? where cif_number=?");
	stat.setString(1,business_name);
	stat.setString(2,relation);
	stat.setString(3,relation_name);
	stat.setString(4,np_N_ModifyCIF);
	stat.executeUpdate();
	msg="<font color='green'><b>Name Modified successfully</b></font>";
	
	}//end of try
	catch(Exception e)
	{
		msg="Error :"+e;
	}
	finally
	{
	conn.close();
	}

}

if(A_ModifyCIF!=null && A_ModifyCIF!="")
{
	try
	{
	conn=bean.getConnection(request);
	String address=request.getParameter("address");
	String city=request.getParameter("city");
	String pincode=request.getParameter("pincode");
	String state=request.getParameter("state");
	String country=request.getParameter("country");
	PreparedStatement stat=conn.prepareStatement("update customer_info_table set address=?,city=?,pin_code=?,state=?,country=? where cif_number=?");
	stat.setString(1,address);
	stat.setString(2,city);
	stat.setString(3,pincode);
	stat.setString(4,state);
	stat.setString(5,country);
	stat.setString(6,A_ModifyCIF);
	stat.executeUpdate();
	msg="<font color='green'><b>Address Modified successfully</b></font>";
	
	}//end of try
	catch(Exception e)
	{
		msg="Error :"+e;
	}
	finally
	{
	conn.close();
	}

}





%>

<p>CIF Modified successfully</p>

<jsp:forward page="CIFModify.jsp">
<jsp:param name="msg" value="<%=msg%>"/>
</jsp:forward>

		
 		
</body>

</html>