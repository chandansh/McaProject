<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*,java.util.*,com.oreilly.servlet.MultipartRequest"  %>
<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>New Page 1</title>
</head>
<jsp:useBean id="bean" class="com.magicon.MagiconBean" scope="request"/>
<jsp:useBean id="TheBean" scope="page" class="com.magicon.FileUpload" />
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
    String filePath = serverPath + "//wallpaper";
    MultipartRequest multi = new MultipartRequest(request, filePath, 3 * 1024 * 1024);
    String w_title=multi.getParameter("w_title");
	String wallfilename=multi.getFilesystemName("w_file");
	String wallpath="wallpaper/imgnotavailable.jpg";
	if(wallfilename!=null)
	wallpath="wallpaper/"+wallfilename;
	
	java.util.Date now = new java.util.Date();
	String cdate = String.valueOf(now.getYear()+1900)+"-"+String.valueOf(now.getMonth()+1)+"-"+String.valueOf(now.getDate());
	
	if((w_title!=null && w_title!=""))
	{
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("SELECT * FROM wallpaper where w_file_Name=?" );
		stat.setString(1,wallfilename);
		rs = stat.executeQuery();
		if(rs.next())
		{
		//out.print("<h3><font color='#ff0000' face='Arial'>wallpaper File already existed</font></h3>");
		msg="<h3><font color='#ff0000' face='Arial'>wallpaper File already existed</font></h3>";
		}
		else
		{
		PreparedStatement stat1= conn.prepareStatement("insert into wallpaper values(?,?,?,?,?)");
		int w_id=(int)(10000*Math.random()+1);
		stat1.setInt(1,w_id);
		stat1.setString(2,w_title);
		stat1.setString(3,wallfilename);
		stat1.setString(4,wallpath);
		stat1.setString(5,cdate);
		stat1.executeUpdate();
		//out.print("<h3><font color='#009933' face='Arial'>wallpaper Successfully uploaded</font></h3>");
		msg="<h3><font color='#009933' face='Arial'>wallpaper Successfully uploaded</font></h3>";
		
		}		
		}
		catch(Exception E)
		{
			out.print("error inserting values:"+E);
			msg="error inserting values :"+E;
			boolean b=TheBean.dodelete(session,wallpath);

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
	//path=null;

	}       
          
          
    %>

<p>file upload succesfully

<jsp:forward page="WallPaper.jsp">
<jsp:param name="msg" value="<%=msg%>"/>
</jsp:forward>

		
 		
</body>

</html>