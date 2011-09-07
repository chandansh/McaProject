<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*"  %>
<html xmlns="http://www.w3.org/1999/xhtml">
<LINK href="hotspot2.css" rel="stylesheet" type="text/css">
<LINK href="leftnav.css" rel="stylesheet" type="text/css">
<head>
<script language="JavaScript">
function validate()
  	{
	  	if(document.form1.catid.value==""||document.form1.catname.value=="")
		{
  			alert("Category id or category name cannot be blank!!");
			return;
  		}
		if(document.form1.catid.value.length>5)
		{
		alert("Category id should be less than or equal 5 char!!");
		document.form1.catid.value="";
			return;
		}
		if(document.form1.catname.value.length>15)
		{
		alert("Category name should be less than or equal 15 char!!");
		document.form1.catid.value="";
			return;
		}
		if(document.form1.des.value.length>30)
		{
		alert("Category description should be less than or equal 30 char!!");
		document.form1.catid.value="";
			return;
		}
  	  	document.form1.action="ProductCategory.jsp";
  		document.form1.submit();
  	}

function validate1()
  	{
	  	if(document.editform.edit_catname.value=="")
		{
			alert("category name cannot be blank!!");
			document.editform.edit_catid.value="";
			return;
		}
		else if(document.editform.edit_catname.value.length>15)
		{
			alert("Category name should be less than or equal 15 char!!");
			document.editform.edit_catid.value="";
			return;
		}
		else if(document.editform.edit_des.value.length>30)
		{
			alert("Category description should be less than or equal 30 char!!");
			document.editform.edit_catid.value="";
			return;
		}
  	  	else
  	  	{
  	  		document.editform.action="ProductCategory.jsp";
  			document.editform.submit();
  		}
  	}


</script>
<title>Administrator Home Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>

<body>
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
    <tr><td align="center" height="30px"><a href="ModifyProduct.jsp">Modify</a></tr>
    <tr><td align="center" height="30px" bgcolor="#E3E3FD">Category</tr>    	
</table>
</td>
        <td bgcolor="#E8E8FF" height=500 valign="top">&nbsp;<div align="center">
          <center>
          <table border="0" cellspacing="1" width="50%">
            <tr>
              <td width="100%">
              <form method="POST" name="form1" >
               <fieldset style="padding: 2">
                <legend align="left">Add New Category</legend>
                <div align="center">
                  <center>
                  <table border="0" width="90%" bordercolor="#0000FF" style="border-collapse: collapse">
                    <tr>
                      <td width="34%" align="left">Category Id</td>
                      <td width="66%" align="left">
                      <input type="text" name="catid" size="20"><font size="2" color="#008000">Max 
                      5 char</font></td>
                    </tr>
                    <tr>
                      <td width="34%" align="left">Category Name</td>
                      <td width="66%" align="left">
                      <input type="text" name="catname" size="20"><font color="#008000" size="2">Max 
                      15 char</font></td>
                    </tr>
                    <tr>
                      <td width="34%" align="left">Description</td>
                      <td width="66%" align="left">
                      <textarea rows="2" name="des" cols="20"></textarea></td>
                    </tr>
                    <tr>
                      <td width="34%">&nbsp;</td>
                      <td width="66%" align="left">
                      <input type="submit" value="Add Category" name="B1" onclick="validate();"><input type="reset" value="Reset" name="B2"></td>
                    </tr>
                  </table>
                  </center>
                </div>
                </fieldset></form>
              </td>
            </tr>
          </table>
          <jsp:useBean id="bean" class="com.magicon.MagiconBean" scope="request"/>
          
          <!-- handle the request for delete category-->

          <%
    Connection conn;
	conn=null;
	ResultSet rs;
	rs=null;
	String cat_id1=request.getParameter("cat_id1");
	if(cat_id1!=null && cat_id1!="")
	{
	try
	{
		
		conn =bean.getConnection(request);
		PreparedStatement stat=conn.prepareStatement("delete from category_info where cat_id=? ");
		stat.setString(1,cat_id1);	
		int success=stat.executeUpdate(); 
        if (success==1)
 		{
 		%><H3 align="center"><font color="#009933" 'Arial'>Selected category Deleted</font></H3><%
		}
		else
		{
		%><H3 align="center"><font color="#FF0000" face 'Arial'>Transaction Not Allowed</font></H3><%
		}
		}
					
	catch(Exception E)
	{
		out.println("Error deleting value"+E);
	}	
	finally
	{
		conn.close();
	}
	
	}


%>

<!-- handle the request for add new  category-->


          <%
    
	String catid=request.getParameter("catid");
	String catname=request.getParameter("catname");
	String des=request.getParameter("des");
	if((catid!=null && catid!=""))
	{
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("insert into category_info values(?,?,?)");
		stat.setString(1,catid);
		stat.setString(2,catname);
		stat.setString(3,des);
		stat.executeUpdate();
		out.print("<h3><font color='#009933' face='Arial'>Category Successfully added</font></h3>");
		
		
		}
		catch(Exception E)
		{
			out.print("error inserting values:"+E);
		}
		finally
		{
			conn.close();
		}
	}

		%>
	<!-- handle the request for save changes edit category-->
	
	<%
    
	String edit_catid=request.getParameter("edit_catid");
	String edit_catname=request.getParameter("edit_catname");
	String edit_des=request.getParameter("edit_des");
	if((edit_catid!=null && edit_catid!=""))
	{
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("update category_info set cat_name=?,cat_des=? where cat_id=?");
		stat.setString(1,edit_catname);
		stat.setString(2,edit_des);
		stat.setString(3,edit_catid);
		stat.executeUpdate();
		out.print("<h3><font color='#009933' face='Arial'>Category Successfully updated</font></h3>");
		
		
		}
		catch(Exception E)
		{
			out.print("error updating values:"+E);
		}
		finally
		{
			conn.close();
		}
	}

		%>

	
	
	<!-- handle the request for edit category-->
	<%
	String cat_id=request.getParameter("cat_id");
	if((cat_id!=null && cat_id!=""))
	{
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("select * from category_info where cat_id=?");
		stat.setString(1,cat_id);
		rs=stat.executeQuery();
		if(rs.next())
		{
		
		%>
		
		
		<table border="0" cellspacing="1" width="50%">
        <tr>
        <td width="100%">
        <form method="POST" name="editform" >
        <fieldset style="padding: 2">
        <legend align="left">Edit Category</legend>
        <div align="center">

		<table border=0 style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="1" width="90%" >
			<tr>
			<td align="left" width="34%">Category Id</td>
			<td align="left" width="66%">
            <input type ="text" name="edit_catid" readonly="true" size="20" value="<%=rs.getString("cat_id")%>" >
            </td>
            </tr>			
			
			<tr>
			<td align="left" width="34%">Category Name</td>
			<td align="left" width="66%">
            <input type ="text" name="edit_catname" size="20" value="<%=rs.getString("cat_name")%>" ><font size="2" color="#008000">Max 
            15 char</font></td>
            </tr>
			
			<tr>
			<td align="left" width="34%">Description</td>
			<td align="left" width="66%">
            <textarea rows="2" name="edit_des" cols="20"><%=rs.getString("cat_des")%></textarea></td>
			</tr>

			<tr>
			<td width="34%" align="left">
			</td>
			<td align="left" width="66%">
			<input type="submit" value="save changes" onclick="validate1();">
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
		
	<!-- show the list of category in database-->

		
	<%
		int ctr=0;
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat = conn.prepareStatement("select * from category_info");
		rs=stat.executeQuery();

          %>
         
        
    <h3>List of Available Categories:</h3>
		<table border=1 bordercolor="#000080" cellspacing="1" width="70%">
		<tr bgcolor="000080">
		<td><b><font color="#ffffff">Sr.No</font></b></td>
		<td><b><font color="#ffffff">Category Id</font></b></td>
		<td><font color="#ffffff"><b>Category Name</b></font></td>
		<td><font color="#ffffff"><b>Description</b></font></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		</tr>
		<% 
		while(rs.next())
		{
		%>
		
			<tr><td height="30px" align="center">
			<%
			ctr=ctr+1;
			out.println(ctr);
			out.println("<td height=30px>");
			out.println(rs.getString("cat_id"));

						
			
			out.println("<td height=30px>");
			out.println(rs.getString("cat_name"));
			
			
			out.println("<td height=30px>");
			out.println(rs.getString("cat_des"));
			
			out.println("<td height=30px>");			
			%>
			<form method ="post" action ="ProductCategory.jsp">
			<input type="hidden" name="cat_id" value=<%=rs.getString("cat_id")%> >
			<input type="submit" value="   Edit    ">
			</form>	
			</td>
					
			
			
			<td height="30px" align="center">
			<form method ="post" action="ProductCategory.jsp">
			<input type="hidden" name="cat_id1" value=<%=rs.getString("cat_id")%> >
			<input type="submit" value="   delete    ">
			</form>	
			</td>
			
			</tr>
			<%
			
		}
	%>
		
		</table>
		
	<%
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

          </center>
        </div>
        <p>&nbsp;</p>
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