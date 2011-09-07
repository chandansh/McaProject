<html>
<meta http-equiv="Content-Language" content="en-us">

<body bgcolor="#CCFFFF">
<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*" import="java.util.*,java.text.*" import="com.magicon.*" %>

<%
	Connection conn;
	conn=null;
	ResultSet rs;
	rs=null;

	String userid=request.getParameter("userid");
	try
	{
		MagiconBean bean=new MagiconBean();
		conn =bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("SELECT * FROM cust_info where cust_id=?" );
		
            stat.setString(1,userid);
		rs = stat.executeQuery();
            
		if(rs.next())
		{
			out.print("<b><font color='#ff0000' face='Arial'>"+userid+" is not available</font></b>");
		}
		else
		{
			out.print("<b><font color='#008000' face='Arial'>"+userid+" is available</font></b>");
		}
	}
	catch(Exception E)
	{
		out.println("Error  "+E);
	}
	finally
	{
		rs.close();
		conn.close();
	}
		


%>
<p></p>
<body>


</body>
</html>