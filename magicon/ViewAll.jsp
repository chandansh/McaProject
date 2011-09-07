<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*"  %>
<html xmlns="http://www.w3.org/1999/xhtml">
<LINK href="hotspot2.css" rel="stylesheet" type="text/css">
<LINK href="leftnav.css" rel="stylesheet" type="text/css">
<head>

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
    <tr><td align="center" height="30px" bgcolor="#E3E3FD">view All</li>
    <tr><td align="center" height="30px"><a href="AddNewProduct.jsp">Add new</a></tr>
    <tr><td align="center" height="30px"><a href="ModifyProduct.jsp">Modify</a></tr>
    <tr><td align="center" height="30px"><a href="ProductCategory.jsp">Category</a></tr>
    	
</table>
</td>
        <td bgcolor="#E8E8FF" height=500 valign="top">
        <p align="center">&nbsp;</p>
        <p align="center"><b><font color="#000080" face="Arial">List of All the 
        Product are</font></b></p>
        <div align="center">
          <center>
          <table border="1" cellspacing="0" width="90%" bordercolor="#C0C0C0" bordercolorlight="#C0C0C0" bordercolordark="#FFFFFF">
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
              <th width="11%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Quantity</font></th>
              <th width="11%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Add date</font></th>
              <th width="12%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Description</font></th>
            </tr>
            <jsp:useBean id="bean" class="com.magicon.MagiconBean" scope="request"/>
		<%
		Connection conn;
		conn=null;
		ResultSet rs;
		rs=null;
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
              <td width="11%" bgcolor="#F3F2F1" align="left"><%=rs.getString("pd_qty")%>&nbsp;</td>
              <td width="11%" bgcolor="#F3F2F1" align="left"><%=rs.getString("pd_date")%>&nbsp;</td>
              <td width="12%" bgcolor="#F3F2F1" align="left"><%=rs.getString("pd_des")%>&nbsp;</td>
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