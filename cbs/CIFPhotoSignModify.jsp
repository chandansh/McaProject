<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*,java.util.*,com.oreilly.servlet.MultipartRequest,java.io.*"  %>
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
//String photo_modify_cif=request.getParameter("photo_modify_cif");
//String sign_modify_cif=request.getParameter("sign_modify_cif");
Connection conn;
conn=null;
ResultSet rs=null;
try
	{  
	if(request.getContentType()!=null && request.getContentType()!="")
	{
		String serverPath = session.getServletContext().getRealPath("//");
    	String filePath = serverPath + "//temp_images";
    	MultipartRequest multi = new MultipartRequest(request, filePath, 1 * 1024 * 1024);
    
    	String photo_modify_cif=multi.getParameter("photo_modify_cif");
    	String sign_modify_cif=multi.getParameter("sign_modify_cif");
    	
    	
    	
    	if(photo_modify_cif!=null && photo_modify_cif!="")
    	{
    		String photofilename=multi.getFilesystemName("modphoto");
			String photopath=null;
			
			if(photofilename!=null)
			{
			photopath=filePath+"//"+photofilename;
			}
				try
				{
				conn = bean.getConnection(request);
				PreparedStatement stat =conn.prepareStatement("update customer_info_table set photo=? where cif_number=?");
				File custphoto=new File(photopath);
				FileInputStream fisphoto=new FileInputStream(custphoto);
				stat.setBinaryStream(1,(InputStream)fisphoto, (int)(custphoto.length()));
				stat.setString(2,photo_modify_cif);
				stat.executeUpdate();
				msg="<h3><font color='#009933' face='Arial'>photo Modified successfully </font></h3>";				}
				catch(Exception e)
				{
				msg="error :"+e;
				}
				finally
				{
				conn.close();
				}
				
    	}
    	if(sign_modify_cif!=null && sign_modify_cif!="")
    	{
    		String photofilename=multi.getFilesystemName("modsign");
			String photopath=null;
			
			if(photofilename!=null)
			{
			photopath=filePath+"//"+photofilename;
			}
				try
				{
				conn = bean.getConnection(request);
				PreparedStatement stat =conn.prepareStatement("update customer_info_table set sign_image=? where cif_number=?");
				File custphoto=new File(photopath);
				FileInputStream fisphoto=new FileInputStream(custphoto);
				stat.setBinaryStream(1,(InputStream)fisphoto, (int)(custphoto.length()));
				stat.setString(2,sign_modify_cif);
				stat.executeUpdate();
				msg="<h3><font color='#009933' face='Arial'>Sign Modified successfully </font></h3>";				}
				catch(Exception e)
				{
				msg="error :"+e;
				}
				finally
				{
				conn.close();
				}

    	}

    	
    	
	}//end of if
	}//end of try
	catch(Exception e)
	{
	//out.print("error Multi part data:"+e);
	msg="error Multi part data:"+e;
	
	} 




%>

<p>photo or Sign modified successfully</p>

<jsp:forward page="CIFModify.jsp">
<jsp:param name="msg" value="<%=msg%>"/>

</jsp:forward>

		
 		
</body>

</html>