<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*"  %>
<html xmlns="http://www.w3.org/1999/xhtml">
<LINK href="hotspot2.css" rel="stylesheet" type="text/css">
<LINK href="leftnav.css" rel="stylesheet" type="text/css">
<head>
<script language="JavaScript">

function validate()
  	{
	  	if(document.form1.r_title.value==""||document.form1.r_album.value=="")
		{
  			alert("ring tone title or album name cannot be blank!!");
			return;
  		}
		if(document.form1.r_title.value.length>50)
		{
		alert("title should be less than or equal 50 char!!");
		document.form1.r_title.value="";
			return;
		}
		if(document.form1.r_album.value.length>50)
		{
		alert("album name should be less than or equal 50 char!!");
		document.form1.r_album.value="";
			return;
		}
		if(document.form1.r_file.value=="")
		{
  			alert("please select ring tone file!!");
			return;
  		}

		document.form1.action="UploadRingTone.jsp";
  		document.form1.submit();
  	}
  	</script>

<title>Administrator Home Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>

<body>
<jsp:useBean id="bean" class="com.magicon.MagiconBean" scope="request"/>
<jsp:useBean id="TheBean" scope="page" class="com.magicon.FileUpload" /> 
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
	<div id="menu1" align="center">
	<UL id="nav" class="nav">
		        <LI class="sub1">Ringtones</p>
				 </LI>
		</UL>
	  </div>
	</td>
	<td width="20%"><div id="menu" align="center">
	<UL id="nav" class="nav">
		        <LI><A href="WallPaper.jsp" class="sub">Wallpaper</A>
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
    <td height="500"  bordercolor="#000099" valign="top">
    <table border="0" cellspacing="0" width="100%" cellpadding="0" style="border-collapse: collapse" bordercolor="#111111">
      <tr >
        
        <td bgcolor="#E8E8FF" height=500 valign="top">
        <p align="center"><b><font color="#FF0000">* Ring Tone filename should 
        be less than 50 
          char and without space char</font></b></p>
        <div align="center">
          <center>
          <table border="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="60%">
            <tr>
              <td width="100%">
              <form method="POST" enctype="multipart/form-data" name="form1">
             <fieldset style="padding: 2">
                <legend>Upload New RingTone</legend>
                <div align="center">
                  <center>
                  <table border="0" cellspacing="1" style="border-collapse: collapse" bordercolor="#111111" width="90%">
                    <tr>
                      <td width="41%" align="left">RingTone Title</td>
                      <td width="59%" align="left">
                      <input type="text" name="r_title" size="20"></td>
                    </tr>
                    <tr>
                      <td width="41%" align="left">RingTone Album</td>
                      <td width="59%" align="left">
                      <input type="text" name="r_album" size="20"></td>
                    </tr>
                    <tr>
                      <td width="41%" align="left">Upload File</td>
                      <td width="59%" align="left">
                      <input type="file" name="r_file" size="20"></td>
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
   		<!-- handle the request for delete ring tone-->
   		

          <%
    	Connection conn;
		conn=null;
		ResultSet rs;
		rs=null;
	String r_id=request.getParameter("r_id");
	if(r_id!=null && r_id!="")
	{
	try
	{
		
		conn =bean.getConnection(request);
		PreparedStatement stat=conn.prepareStatement("select r_path from ringtones where r_id=? ");
		stat.setString(1,r_id);
	    rs=stat.executeQuery();
	    String oldpath="";
	    if(rs.next())
	    oldpath=rs.getString("r_path");

				
		PreparedStatement stat1=conn.prepareStatement("delete from ringtones where r_id=? ");
		stat1.setString(1,r_id);	
		int success=stat1.executeUpdate(); 
        if (success==1)
 		{
 		%><H3 align="center"><font color="#009933" 'Arial'>Selected Ring tone Deleted</font></H3><%
		}
		else
		{
		%><H3 align="center"><font color="#FF0000" face 'Arial'>Transaction Not Allowed</font></H3><%
		}
		
			boolean b=TheBean.dodelete(session,oldpath);
  			if(b)
  			{
  			out.print("ring tone file deleted");
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
<!-- handle the request for show all the ring tones-->
   		
   		
   		<br><b><font color="#FF0000">* To download Ring Tone click right mouse 
        button on link and save target as </font></b>
</p>
        <p align="center"><font color="#000080" face="Arial"><b>List of 
        Available Ring Tones Are </b></font></p>
        <table border="1" cellspacing="0" width="90%" bordercolor="#C0C0C0" bordercolorlight="#C0C0C0" bordercolordark="#FFFFFF">
            <tr>
              <th width="6%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Sr no</font></th>
              <th width="14%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Ring Tone Title</font></th>
              <th width="13%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Ring Tone Album</font></th>
              <th width="12%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Ring Tone file</font></th>
              <th width="19%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Play</font></th>
              <th width="10%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Add date</font></th>
              <th width="12%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">&nbsp;</font></th>

            </tr>
            
		<%
		
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat = conn.prepareStatement("select * from ringtones");
		rs=stat.executeQuery();
		while(rs.next())
		{

		%>
            
            <tr>
              <td width="6%" bgcolor="#F3F2F1" align="left"><%=rs.getString("r_id")%>&nbsp;</td>
              <td width="14%" bgcolor="#F3F2F1" align="left"><%=rs.getString("r_title")%>&nbsp;</td>
              <td width="13%" bgcolor="#F3F2F1" align="left"><%=rs.getString("r_album")%>&nbsp;</td>
              <td width="12%" bgcolor="#F3F2F1" align="left"><a href="<%=rs.getString("r_path")%>"><%=rs.getString("r_file_name")%></a>&nbsp;</td>
              <td width="19%" bgcolor="#F3F2F1" align="left"><object type="application/x-shockwave-flash" data="player.swf" width="290" height="24" id="audioplayer1"><param name="movie" value="player.swf" /><param name="FlashVars" value="playerID=1&amp;bg=0xFFFFFF&amp;leftbg=0xFF8B00&amp;lefticon=0xFFFFFF&amp;rightbg=0xF9B41B&amp;rightbghover=0x999999&amp;righticon=0xFFFFFF&amp;righticonhover=0xffffff&amp;text=0x999999&amp;slider=0xE52C00&amp;track=0xFFFFFF&amp;border=0x666666&amp;loader=0xDDDDDD&amp;soundFile=<%=rs.getString("r_path")%>" /><param name="quality" value="high" /><param name="menu" value="True" /><param name="wmode" value="transparent" /></object>

&nbsp;</td>
              <td width="10%" bgcolor="#F3F2F1" align="left"><%=rs.getString("add_date")%>&nbsp;</td>
              <td width="10%" bgcolor="#F3F2F1" align="center">
            
            <form method ="post" action ="RingTones.jsp">
			<input type="hidden" name="r_id" value=<%=rs.getString("r_id")%> >
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
   
</table>
    
<p>&nbsp;</p>


</td></tr>
<tr>
    <td><%@ include file="footer.html" %>
       
  </tr>
</table>
</body>

</html>