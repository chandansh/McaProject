<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*"  %>
<html xmlns="http://www.w3.org/1999/xhtml">
<LINK href="hotspot2.css" rel="stylesheet" type="text/css">
<LINK href="leftnav.css" rel="stylesheet" type="text/css">
<head>
<script language="JavaScript">
function validate()
  	{
	  	
  		if(document.editform.edit_pdname.value=="")
		{
  			alert("Product name cannot be blank!!");
  			document.editform.edit_pdid.value="";
			return;
  		}
  				
  		if(document.editform.edit_pdprice.value=="")
		{
  			alert("Product price should not be blank!!");
  			document.editform.edit_pdid.value="";
			return;
  		}
  		if(document.editform.edit_pdqty.value=="")
		{
  			alert("Product quantity should not be blank!!");
  			document.editform.edit_pdid.value="";
			return;
  		}
		
		if(document.editform.edit_pdname.value.length>20)
		{
			alert("product name should be less than or equal 20 char!!");
			document.editform.edit_pdid.value="";
			return;
		}
		if(document.editform.edit_pddes.value.length>50)
		{
			alert("product description should be less than or equal 50 char!!");
			document.editform.edit_pdid.value="";
			return;
		}
		
		
  	  	document.editform.action="editpd.jsp";
  		document.editform.submit();
  		
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
    
	<td width="20%" ><div id="menu1" align="center">
	<UL id="nav" class="nav">
		         <LI class="sub1">Product</p>
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
        <td width="7em" valign="top">
        <table class="navigation" width="100" border="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" >
    <tr><td align="center" height="30px"><a href="ViewAll.jsp">view All</a></li>
    <tr><td align="center" height="30px"><a href="AddNewProduct.jsp">Add new</a></tr>
    <tr><td align="center"  height="30px" bgcolor="#E3E3FD">Modify</tr>
    <tr><td align="center" height="30px" ><a href="ProductCategory.jsp">Category</a></tr>
    	
</table>
</td>
        <td bgcolor="#E8E8FF" height=500 valign="top">
        <p align="center">&nbsp;</p>
        <p align="center"><b><font color="#000080" face="Arial">List of All the 
        Product are</font></b></p>
        <div align="center">
          <center>
          <%
   String msg=request.getParameter("msg");
   String imagepath=request.getParameter("imagepath");
   
   if(imagepath!=null)
   {
   if(!imagepath.equals("null"))
   {
   %>
   <img src="<%=imagepath%>" height="100" width="150" alt="image not available"/><br>
   <%
   }
   }
   if(msg!=null && msg!="")
   {
   out.print(msg);
   }
   

   
   %>

          <!-- handle the request for edit Product-->
	<%
	Connection conn;
	conn=null;
	ResultSet rs;
	rs=null;
	String pd_id=request.getParameter("pd_id");
	if((pd_id!=null && pd_id!=""))
	{
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("select * from product_info where pd_id=?");
		stat.setString(1,pd_id);
		rs=stat.executeQuery();
		if(rs.next())
		{
		
		%> <b><font color="#FF0000">* Image filename should be less than 20 
          char and without space char</font></b><table border="0" cellspacing="1" width="50%">
        <tr>
        <td width="100%">
        
        <form method="POST" name="editform" enctype="multipart/form-data" >
        <fieldset style="padding: 2">
        <legend align="left">Edit Product</legend>
        <div align="center">

		<table border=0 style="border-collapse: collapse" bordercolor="#111111" cellspacing="1" width="101%" >
			
			<tr>
			<td align="left" width="34%">&nbsp;</td>
			<td align="left" width="66%">
			<br>
            <img border="0" src="<%=rs.getString("pd_photo_path")%>" width="85" height="66">
            <input type="hidden" name="old_photo_path" value="<%=rs.getString("pd_photo_path")%>" >
            <br><font size="2" color="#008000">you can change Product Image on 
            upload new image if u don't wana change image please don't select&nbsp; new image</font></td>
            </tr>
			
			
			<tr>
			<td align="left" width="34%">Image File</td>
			<td align="left" width="66%">
            <input type="file" name="new_photo_path" size="20"></td>
            </tr>			
			
			
			<tr>
			<td align="left" width="34%">product Id</td>
			<td align="left" width="66%">
            <input type ="text" name="edit_pdid" readonly="true" size="20" value="<%=rs.getString("pd_id")%>" style="background-color:#FFFFCC">
            <font size="2" color="#ff0000">you can't change</font>
            </td>
            </tr>			
			
			<tr>
			<td align="left" width="34%">Product Name</td>
			<td align="left" width="66%">
            <input type ="text" name="edit_pdname" size="20" value="<%=rs.getString("pd_name")%>" ><font size="2" color="#008000">Max 
            20 char</font></td>
            </tr>
            
            <tr>
			<td align="left" width="34%">Product Category ID</td>
			<td align="left" width="66%">
            <input type ="text" name="edit_catid" readonly="true" size="20" value="<%=rs.getString("cat_id")%>" style="background-color:#FFFFCC" >
            <font size="2" color="#ff0000">you can't change</font></td>
            </tr>
            
            <tr>
			<td align="left" width="34%">Product Brand</td>
			<td align="left" width="66%">
            <select size="1" name="edit_pdbrand">
              <option selected value="<%=rs.getString("pd_brand")%>"><%=rs.getString("pd_brand")%></option>
              <option value="Nokia">Nokia</option>
              <option value="Sony Ericsson">Sony Ericsson</option>
              <option value="Samsung">Samsung</option>
              <option value="LG">LG</option>
              <option value="Motorola">Motorola</option>
              <option value="Blackberry">Blackberry</option>
              <option value="Spice">Spice</option>
              <option value="Micromax">Micromax</option>
              <option value="Fly">Fly</option>
              <option value="htc">htc</option>
              <option value="Matrix">Matrix</option>
              <option value="Philips">Philips</option>
              <option value="Ipod">Ipod</option>
              <option value="Jabra">Jabra</option>
              <option value="Kingston">Kingston</option>
              <option value="Sandisk">Sandisk</option>
              <option value="Transcend">Transcend</option>
              <option value="other">other</option>
              </select></td>
            </tr>
            
            <tr>
			<td align="left" width="34%">Product Price</td>
			<td align="left" width="66%">
            <input type ="text" name="edit_pdprice" size="20" value="<%=rs.getString("pd_price")%>" >
            <font size="2" color="#008000">only decimal value</font></td>
            </tr>
            
            <tr>
			<td align="left" width="34%">Product Quantity</td>
			<td align="left" width="66%">
            <input type ="text" name="edit_pdqty" size="20" value="<%=rs.getString("pd_qty")%>" >
            <font size="2" color="#008000">only numric value</font></td>
            </tr>
			
			<tr>
			<td align="left" width="34%">Description</td>
			<td align="left" width="66%">
            <textarea rows="2" name="edit_pddes" cols="20"><%=rs.getString("pd_des")%></textarea></td>
			</tr>

			<tr>
			<td width="34%" align="left">
			</td>
			<td align="left" width="66%">
			<input type="submit" value="save changes" onclick="validate();">
			<input type="reset" value="Reset">
			</tr>
					
		<%
		}
		%>
		
		</table>
		</div>
        </fieldset></form>
        </td>
        </tr>
        </table>

		<%
		}
		catch(Exception E)
		{
			out.print("error fetching values from database:"+E);
		}
		finally
		{
			rs.close();
			conn.close();
		}
	}
	
		
	%>
 <!-- handle the request for delete product-->

          <%
    
	String pd_id1=request.getParameter("pd_id1");
	if(pd_id1!=null && pd_id1!="")
	{
	try
	{
		
		conn =bean.getConnection(request);
		PreparedStatement stat=conn.prepareStatement("select pd_photo_path from product_info where pd_id=? ");
		stat.setString(1,pd_id1);
	    rs=stat.executeQuery();
	    String oldphotopath="";
	    if(rs.next())
	    oldphotopath=rs.getString("pd_photo_path");

				
		PreparedStatement stat1=conn.prepareStatement("delete from product_info where pd_id=? ");
		stat1.setString(1,pd_id1);	
		int success=stat1.executeUpdate(); 
        if (success==1)
 		{
 		%><H3 align="center"><font color="#009933" 'Arial'>Selected Product Deleted</font></H3><%
		}
		else
		{
		%><H3 align="center"><font color="#FF0000" face 'Arial'>Transaction Not Allowed</font></H3><%
		}
		
		if(oldphotopath.indexOf("imgnotavailable.jpg")==-1)
		{
			boolean b=TheBean.dodelete(session,oldphotopath);
  			if(b)
  			{
  			out.print("image file also deleted");
  			}
  			else
  			{
 		 	out.print("error deleting file");
 			}
  		}
  		else
  		{
  		out.print("this product has no image");
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

          
          <!-- show the listing of products -->  
          <br>
        <table border="1" cellspacing="0" width="98%" bordercolor="#C0C0C0" bordercolorlight="#C0C0C0" bordercolordark="#FFFFFF" style="border-collapse: collapse" cellpadding="0">
            <tr>
              <th width="11%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Photo</font></th>
              <th width="11%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Product id</font></th>
              <th width="11%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Name</font></th>
              <th width="11%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Category</font></th>
              <th width="14%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Brand</font></th>
              <th width="8%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Price</font></th>
              <th width="9%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Quantity</font></th>
              <th width="13%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Add date</font></th>
              <th width="12%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Description</font></th>
              <th width="12%" bgcolor="#808080" align="center">
              &nbsp;</th>
            </tr>
            
          
		<%
		
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat = conn.prepareStatement("select a.pd_id,a.pd_name,b.cat_name,a.pd_brand,a.pd_price,a.pd_qty,a.pd_date,a.pd_photo_path,a.pd_des from product_info as a ,category_info as b where a.cat_id=b.cat_id order by a.cat_id,a.pd_brand");
		rs=stat.executeQuery();
		while(rs.next())
		{

		%>
            
            <tr>
              <td width="11%" bgcolor="#F3F2F1" align="left">
              <img border="0" src="<%=rs.getString("pd_photo_path")%>" width="85" height="66"></td>
              <td width="11%" bgcolor="#F3F2F1" align="left"><%=rs.getString("pd_id")%>&nbsp;</td>
              <td width="11%" bgcolor="#F3F2F1" align="left"><%=rs.getString("pd_name")%>&nbsp;</td>
              <td width="11%" bgcolor="#F3F2F1" align="left"><%=rs.getString("cat_name")%>&nbsp;</td>
              <td width="14%" bgcolor="#F3F2F1" align="left"><%=rs.getString("pd_brand")%>&nbsp;</td>
              <td width="8%" bgcolor="#F3F2F1" align="left"><%=rs.getString("pd_price")%>&nbsp;</td>
              <td width="9%" bgcolor="#F3F2F1" align="left"><%=rs.getString("pd_qty")%>&nbsp;</td>
              <td width="13%" bgcolor="#F3F2F1" align="left"><%=rs.getString("pd_date")%>&nbsp;</td>
              <td width="12%" bgcolor="#F3F2F1" align="left"><%=rs.getString("pd_des")%>&nbsp;</td>
              <td width="12%" bgcolor="#F3F2F1" align="center">
            
            <form method ="post" action ="ModifyProduct.jsp">
			<input type="hidden" name="pd_id" value=<%=rs.getString("pd_id")%> >
			<input type="submit" value="   Edit    ">
			</form>	
			
			<form method ="post" action ="ModifyProduct.jsp">
			<input type="hidden" name="pd_id1" value=<%=rs.getString("pd_id")%> >
			<input type="submit" value="   Delete    ">
			</form>	

			</td>
            
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
		</td>
      </tr>
      
    </table>
    
    </center>
        </div>
        <p>&nbsp;</p>


        </td>
      </tr>

  
   
</table>
    


</td></tr>
<tr>
    <td><%@ include file="footer.html" %>
       
  </tr>
</table>
</body>

</html>