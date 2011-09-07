<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*"  %>
<html xmlns="http://www.w3.org/1999/xhtml">
<LINK href="hotspot2.css" rel="stylesheet" type="text/css">
<LINK href="leftnav.css" rel="stylesheet" type="text/css">
<head>
<script language="JavaScript">

function validate()
  	{
	  	if(document.form1.w_title.value=="")
		{
  			alert("wallpaper title cannot be blank!!");
			return;
  		}
  		if(document.form1.w_file.value=="")
		{
  			alert("please select wallpaper file!!");
			return;
  		}

		if(document.form1.w_title.value.length>50)
		{
		alert("title should be less than or equal 50 char!!");
		document.form1.w_title.value="";
			return;
		}
		
		document.form1.action="UploadWallpaper.jsp";
  		//document.form1.submit();
  	}
  	</script>


<title>Administrator Home Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>

<body>
<jsp:useBean id="bean" class="com.magicon.MagiconBean" scope="request"/>
<jsp:useBean id="TheBean" scope="page" class="com.magicon.FileUpload" /> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="index2.html" %></td>
  </tr>
  <tr ><td bgcolor="#0F57BB" valign="middle" height="34"><div align="right"  ><font face="Arial Black" size="3" color="#FFFFFF">  
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
%></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="logout.jsp"><img src="images/logout.png" border="0" width="100" height="34"/></a></div>
</td></tr>
<tr>
  <td>
  <table width="90%" border="0" align="center" cellpadding="0" cellspacing="2" >
  <tr align="center">
    
	<td width="20%" ><div id="menu" align="center">
			 <UL id="nav" class="nav">
		        <LI><A href="ViewAll.jsp" class="sub">Product</A>
				</LI>
		</UL>
	</div></td>
	<td width="20%">
	<div id="menu" align="center">
	<UL id="nav" class="nav">
		        <LI><A href="RingTones.jsp" class="sub">Ringtones</A>
				</LI>
		</UL>
	  </div>
	</td>
	<td width="20%"><div id="menu1" align="center">
	
		<UL id="nav" class="nav">
		         <LI class="sub1">Wallpaper</p>
				 </LI>
	</UL>	
	</div></td>
	
	<td width="20%"><div id="menu" align="center">
	<UL id="nav" class="nav">
		        <LI><A href="Orders.jsp" class="sub">Orders</A>
				</LI>
		</UL>
	</div></td>

	
	</tr>
</table>
  
  <table width="90%" border="0" cellspacing="1" bordercolor="#0000FF" align="center">
  <tr>
      <td bgcolor="#E8E8FF" height=500 valign="top">&nbsp;
      <table border="0" cellspacing="0" width="100%" cellpadding="0" style="border-collapse: collapse" bordercolor="#111111">
      <tr >
        
        <td bgcolor="#E8E8FF" height=500 valign="top">
        <p align="center"><b><font color="#FF0000">* Wallpaper filename should 
        be less than 50 
          char and without space char</font></b></p>
        <div align="center">
          <center>
          <table border="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="60%">
            <tr>
              <td width="100%">
              <form method="POST" enctype="multipart/form-data" name="form1">
             <fieldset style="padding: 2">
                <legend>Upload New Wallpaper</legend>
                <div align="center">
                  <center>
                  <table border="0" cellspacing="1" style="border-collapse: collapse" bordercolor="#111111" width="90%">
                    <tr>
                      <td width="41%" align="left">Wallpaper Title</td>
                      <td width="59%" align="left">
                      <input type="text" name="w_title" size="20"></td>
                    </tr>
                    <tr>
                      <td width="41%" align="left">&nbsp;</td>
                      <td width="59%" align="left">
                      &nbsp;</td>
                    </tr>
                    <tr>
                      <td width="41%" align="left">Upload File</td>
                      <td width="59%" align="left">
                      <input type="file" name="w_file" size="20"></td>
                    </tr>
                    <tr>
                      <td width="41%" align="left">&nbsp;</td>
                      <td width="59%" align="left">&nbsp;</td>
                    </tr>
                    <tr>
                      <td width="41%" align="left">&nbsp;</td>
                      <td width="59%" align="left">
                      <input type="submit" value="Upload" name="B1" onclick="validate();"><input type="reset" value="Reset" name="B2"></td>
                    </tr>
                  </table>
                  </center>
                </div>
                </fieldset></form>
              </td>
            </tr>
          </table>
         
        <p align="center">&nbsp;
        <%
        String msg=request.getParameter("msg");
   		if(msg!=null && msg!="")
   		{
   		out.print(msg);
   		}
   		%> 
   		
   		<!-- handle the request for delete product-->

          <%
    Connection conn;
	conn=null;
	ResultSet rs;
	rs=null;
	String w_id=request.getParameter("w_id");
	if(w_id!=null && w_id!="")
	{
	try
	{
		
		conn =bean.getConnection(request);
		PreparedStatement stat=conn.prepareStatement("select w_path from wallpaper where w_id=? ");
		stat.setString(1,w_id);
	    rs=stat.executeQuery();
	    String oldpath="";
	    if(rs.next())
	    oldpath=rs.getString("w_path");

				
		PreparedStatement stat1=conn.prepareStatement("delete from wallpaper where w_id=? ");
		stat1.setString(1,w_id);	
		int success=stat1.executeUpdate(); 
        if (success==1)
 		{
 		%><H3 align="center"><font color="#009933" 'Arial'>Selected Wallpaper Deleted</font></H3><%
		}
		else
		{
		%><H3 align="center"><font color="#FF0000" face 'Arial'>Transaction Not Allowed</font></H3><%
		}
		
			boolean b=TheBean.dodelete(session,oldpath);
  			if(b)
  			{
  			out.print("wallpaper file deleted");
  			}
  			else
  			{
 		 	out.print("error deleting file");
 			}
  		
	}
					
	catch(Exception E)
	{
		out.println("Error deleting value"+E);
	}	
	finally
	{
		rs.close();
		conn.close();
	}
	
	}


%>

   		
   		<!-- viwe all the RingTones-->
   		<br><b><font color="#FF0000">* To download wallpaper click right mouse 
        button on link and save image as </font></b>
</p>
        <p align="center"><font color="#000080" face="Arial"><b>List of 
        Available Wallpaper Are </b></font></p>
        <table border="1" cellspacing="0" width="829" bordercolor="#C0C0C0" bordercolorlight="#C0C0C0" bordercolordark="#FFFFFF">
            <tr>
              <th width="152" bgcolor="#808080" align="center">
              <font color="#FFFFFF">File Preview</font></th>
              <th width="82" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Id</font></th>
              <th width="146" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Wallpaper Title</font></th>
              <th width="146" bgcolor="#808080" align="center">
              <font color="#FFFFFF">File Name</font></th>
              <th width="101" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Add date</font></th>
              <th width="176" bgcolor="#808080" align="center">
              <font color="#FFFFFF">&nbsp;</font></th>

            </tr>
            
		<%
		
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat = conn.prepareStatement("select * from wallpaper");
		rs=stat.executeQuery();
		while(rs.next())
		{

		%>
            
            <tr>
              <td width="152" bgcolor="#F3F2F1" align="center" height="100">
              <p align="center"><img border="0" src="<%=rs.getString("w_path")%>" width="150" height="100"></td>
              <td width="82" bgcolor="#F3F2F1" align="left"><%=rs.getString("w_id")%>&nbsp;</td>
              <td width="146" bgcolor="#F3F2F1" align="left"><%=rs.getString("w_title")%>&nbsp;</td>
              <td width="146" bgcolor="#F3F2F1" align="left"><%=rs.getString("w_file_name")%>&nbsp;</td>
              <td width="101" bgcolor="#F3F2F1" align="left"><%=rs.getString("add_date")%>&nbsp;</td>
              <td width="176" bgcolor="#F3F2F1" align="center">
            
            <form method ="post" action ="WallPaper.jsp">
			<input type="hidden" name="w_id" value=<%=rs.getString("w_id")%> >
			<input type="submit" value="   Delete    ">
			</form>	

            </tr>
            
        <%
			
		}
	
		}
		catch(Exception e)
		{
		out.print("Error = " + e + "<HR>");
		}
		finally
		{
		rs.close();
		conn.close();
		}	

		%>

          </table>
          <p><font face="Arial" color="#000080"><b>End of&nbsp; List</b></font></p>

        <p align="center">&nbsp;</td>
      </tr>
    </table>
    
  </tr>
   </center>
        </div>
      
      
      
      
      </td>
      </tr>
    </table>
    
  </tr>
   
</table>
    
<p>&nbsp;</p>


</td></tr>
<tr>
    <td><%@ include file="footer.html" %>
       
  </tr>
</table>
</body>

</html>