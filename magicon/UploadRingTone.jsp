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
    String filePath = serverPath + "//ring_tones";
    MultipartRequest multi = new MultipartRequest(request, filePath, 7 * 1024 * 1024);
    String r_title=multi.getParameter("r_title");
	String r_album=multi.getParameter("r_album");
	String tonefilename=multi.getFilesystemName("r_file");
	String ringtonepath="ring_tones/imgnotavailable.jpg";
	if(tonefilename!=null)
	ringtonepath="ring_tones/"+tonefilename;
	
	java.util.Date now = new java.util.Date();
	String cdate = String.valueOf(now.getYear()+1900)+"-"+String.valueOf(now.getMonth()+1)+"-"+String.valueOf(now.getDate());
	
	if((r_title!=null && r_title!=""))
	{
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("SELECT * FROM ringtones where r_file_Name=?" );
		stat.setString(1,tonefilename);
		rs = stat.executeQuery();
		if(rs.next())
		{
		//out.print("<h3><font color='#ff0000' face='Arial'>Ring tone File already existed</font></h3>");
		msg="<h3><font color='#ff0000' face='Arial'>Ring tone File already existed</font></h3>";
		}
		else
		{
		PreparedStatement stat1= conn.prepareStatement("insert into ringtones values(?,?,?,?,?,?)");
		int r_id=(int)(10000*Math.random()+1);
		stat1.setInt(1,r_id);
		stat1.setString(2,r_title);
		stat1.setString(3,r_album);
		stat1.setString(4,tonefilename);
		stat1.setString(5,ringtonepath);
		stat1.setString(6,cdate);
		stat1.executeUpdate();
		//out.print("<h3><font color='#009933' face='Arial'>Ring tone Successfully uploaded</font></h3>");
		msg="<h3><font color='#009933' face='Arial'>Ring tone Successfully uploaded</font></h3>";
		
		}		
		}
		catch(Exception E)
		{
			out.print("error inserting values:"+E);
			msg="error inserting values :"+E;
			boolean b=TheBean.dodelete(session,ringtonepath);

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

<jsp:forward page="RingTones.jsp">
<jsp:param name="msg" value="<%=msg%>"/>
</jsp:forward>

		
 		
</body>

</html>