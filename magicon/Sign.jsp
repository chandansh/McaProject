<html>
<body bgcolor="#CCFFFF">
<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*" import="java.util.*,java.text.*" import="com.magicon.*" %>
<center>
<%
	Connection conn;
	conn=null;
	ResultSet rs;
	rs=null;

	String userid=request.getParameter("userid");
	String firstname=request.getParameter("firstname");
	String lastname=request.getParameter("lastname");
	String password=request.getParameter("password");
	String hintq=request.getParameter("hintq");
	String hintans=request.getParameter("hintans");
	String day=request.getParameter("day");
	String month=request.getParameter("month");
	String year=request.getParameter("year");
	String gender=request.getParameter("gender");
	String occupation=request.getParameter("occupation");
	String email=request.getParameter("email");
	String address=request.getParameter("address");
	String nationality=request.getParameter("nationality");
	String phone=request.getParameter("phone");
	String mobile=request.getParameter("mobile");
	String dob=year+"-"+month+"-"+day;
	
	java.util.Date now = new java.util.Date();
	
        String cdate = String.valueOf(now.getYear()+1900)+"-"+String.valueOf(now.getMonth()+1)+"-"+String.valueOf(now.getDate());
	
	int flag=0;
	
	try
	{
		MagiconBean bean=new MagiconBean();
		conn =bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("SELECT * FROM cust_info where cust_id=?" );
		
            stat.setString(1,userid);
		rs = stat.executeQuery();
            out.println("query executed");
		if(rs.next())
		{
			flag=1;
			%>
			<SCRIPT language="JavaScript">
			alert("User name already exists");
			location.href="register.jsp";
			</SCRIPT>
			<%
		}
		else
		{
			flag=0; // conn.close();
		}
	}
	catch(Exception E)
	{
		out.println("Error  "+E);
	}
	if(flag == 0)
	{
		try
		{

		

			PreparedStatement stat=conn.prepareStatement("INSERT INTO cust_info values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			stat.setString(1,userid);
			stat.setString(2,firstname);
			stat.setString(3,lastname);
			stat.setString(4,dob);
			stat.setString(5,gender);	
			stat.setString(6,occupation);
			stat.setString(7,email);
			stat.setString(8,address);
			stat.setString(9,nationality);
			stat.setString(10,phone);
			stat.setString(11,mobile);
			stat.setString(12,cdate);
			stat.setString(13,cdate);
			stat.setString(14,password);

			stat.executeUpdate(); 
                        
			flag=0;
			out.print(cdate);
			out.print(now);
			response.sendRedirect("index.jsp");
		}
		catch(Exception E)
		{
			out.println("Error inserting value"+E);
		}	
		finally
		{
			rs.close();
			conn.close();
		}
		
	}
	
%>
</center>
</body>
</html>