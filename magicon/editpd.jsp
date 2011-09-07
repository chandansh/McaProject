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
    String pd_id=multi.getParameter("edit_pdid");
	String pd_name=multi.getParameter("edit_pdname");
	//String pd_cat=multi.getParameter("pd_cat");
	String pd_brand=multi.getParameter("edit_pdbrand");
	String pd_price=multi.getParameter("edit_pdprice");
	String pd_qty=multi.getParameter("edit_pdqty");
	String pd_des=multi.getParameter("edit_pddes");
	String oldphotopath=multi.getParameter("old_photo_path");
	String imgfilename=multi.getFilesystemName("new_photo_path");
	String imagepath=oldphotopath;
	if(imgfilename!=null)
	{
	imagepath="product_images/"+imgfilename;
		if(oldphotopath.indexOf("imgnotavailable.jpg")==-1 && oldphotopath.indexOf(imgfilename)==-1)
		{
		boolean b=TheBean.dodelete(session,oldphotopath);
  		if(b)
  		{
  		//out.print("file deleted");
  		msg=msg+"old image file deleted new is inserted";
  		}
  		else
  		{
 		 //out.print("error deleting file");
 		 msg=msg+"error in old image file deleting";
  		}
  		}
  		else
  		{
  		msg=msg+"new image inserted";
  		}
	}
	
	
	
	if((pd_id!=null && pd_id!=""))
	{
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat1= conn.prepareStatement("update product_info set pd_name=?,pd_brand=?,pd_price=?,pd_qty=?,pd_photo_path=?, pd_des=? where pd_id=?");
		stat1.setString(1,pd_name);
		stat1.setString(2,pd_brand);
		stat1.setString(3,pd_price);
		stat1.setString(4,pd_qty);
		stat1.setString(5,imagepath);
		stat1.setString(6,pd_des);
		stat1.setString(7,pd_id);
		stat1.executeUpdate();
		//out.print("<h3><font color='#009933' face='Arial'>Product Successfully Updated</font></h3>");
		msg=msg+"<h3><font color='#009933' face='Arial'>Product Successfully Updated</font></h3>";
		path=imagepath;
		
		}
		catch(Exception E)
		{
			out.print("error updating values:"+E);
			msg=msg+"error updating values:"+E;
			path=null;
		}
		finally
		{
			//rs.close();
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

<jsp:forward page="ModifyProduct.jsp">
<jsp:param name="imagepath" value="<%=path%>"/>
<jsp:param name="msg" value="<%=msg%>"/>
</jsp:forward>

		
 		
</body>

</html>