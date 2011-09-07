<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*,java.util.*,com.oreilly.servlet.MultipartRequest"  %>
<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>New Page 1</title>
</head>
<jsp:useBean id="bean" class="com.magicon.MagiconBean" scope="request"/>
<body>
<% 
	String user_src=(String)session.getValue("user");
	if (user_src!=null && user_src.equals("Administrator"))
  	{
	out.println("Hi "+user_src);
	//out.println("<br>"+session.getId());
	}
	else
	{
		response.sendRedirect("Unauthorised.htm");
	}
	String path=null;
	String msg="";
	%>

 <%
    Connection conn;
	conn=null;
	ResultSet rs;
	rs=null;

	try
	{  
	if(request.getContentType()!=null && request.getContentType()!="")
	{
	String serverPath = session.getServletContext().getRealPath("//");
    String filePath = serverPath + "//product_images";
    MultipartRequest multi = new MultipartRequest(request, filePath, 5 * 1024 * 1024);
    String pd_id=multi.getParameter("pd_id");
	String pd_name=multi.getParameter("pd_name");
	String pd_cat=multi.getParameter("pd_cat");
	String pd_brand=multi.getParameter("pd_brand");
	String pd_price=multi.getParameter("pd_price");
	String pd_qty=multi.getParameter("pd_qty");
	String pd_des=multi.getParameter("pd_des");
	String imgfilename=multi.getFilesystemName("imagefile");
	String imagepath="product_images/imgnotavailable.jpg";
	if(imgfilename!=null)
	imagepath="product_images/"+imgfilename;
	
	java.util.Date now = new java.util.Date();
	String cdate = String.valueOf(now.getYear()+1900)+"-"+String.valueOf(now.getMonth()+1)+"-"+String.valueOf(now.getDate());
	
	if((pd_id!=null && pd_id!=""))
	{
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("SELECT * FROM product_info where pd_id=?" );
		stat.setString(1,pd_id);
		rs = stat.executeQuery();
		if(rs.next())
		{
		//out.print("<h3><font color='#ff0000' face='Arial'>Product id already existed</font></h3>");
		msg="<h3><font color='#ff0000' face='Arial'>Product id already existed</font></h3>";
		path=null;
		}
		else
		{
		PreparedStatement stat1= conn.prepareStatement("insert into product_info values(?,?,?,?,?,?,?,?,?)");
		stat1.setString(1,pd_id);
		stat1.setString(2,pd_name);
		stat1.setString(3,pd_cat);
		stat1.setString(4,pd_brand);
		stat1.setString(5,pd_price);
		stat1.setString(6,pd_qty);
		stat1.setString(7,cdate);
		stat1.setString(8,imagepath);
		stat1.setString(9,pd_des);
		stat1.executeUpdate();
		//out.print("<h3><font color='#009933' face='Arial'>Product Successfully added</font></h3>");
		msg="<h3><font color='#009933' face='Arial'>Product Successfully added</font></h3>";
		path=imagepath;
		}
		
		}
		catch(Exception E)
		{
			out.print("error inserting values:"+E);
			msg="error inserting values:"+E;
			path=null;
		}
		finally
		{
			rs.close();
			conn.close();
		}
		
	}

    }
    }
	catch(Exception e)
	{
	out.print("error Multi part data:"+e);
	msg="error Multi part data:"+e;
	path=null;

	}       
          
          
    %>

<p>file upload succesfully

<jsp:forward page="AddNewProduct.jsp">
<jsp:param name="imagepath" value="<%=path%>"/>
<jsp:param name="msg" value="<%=msg%>"/>
</jsp:forward>

		
 		
</body>

</html>