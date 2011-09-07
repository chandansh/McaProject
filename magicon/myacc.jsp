<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>
a{
	font-size : 16px;
	font-family : arial;
	font-weight: bold;
	color : #ffffff;
	text-decoration: none;
}
a:hover {
	color : #FF0000;
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Magicon Home page</title>
</head>

<body>
<jsp:useBean id="bean" class="com.magicon.MagiconBean" scope="request"/>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr><td>
<%@ include file="index1.html" %>
</tr>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr ><td bgcolor="#0F57BB" valign="middle" height="34" width="20%"><div align="center" ><font face="Arial Black" size="3" color="#FFFFFF">  
<% 
	String user_src=(String)session.getValue("user");
	if (user_src!=null)
  	{
	out.println("Hi "+user_src+".");
	//out.println("<br>"+session.getId());
	}
	else
	{
		response.sendRedirect("Unauthorised.htm");
	}
%>
</font></div>
</td>
<td bgcolor="#0F57BB" valign="middle" height="34" width="60%"><div align="center" ><font face="Arial Black" size="3" color="#FFFFFF">
My Account  
</font></div>
</td>

<td bgcolor="#0F57BB" valign="middle" height="34" width="20%"><div align="center" ><font face="Arial Black" size="3" color="#FFFFFF">  
<a href="usersearch.jsp"><< Back to search</a>
</font></div>
</td>
</table>



</tr>


<tr><td>
<table width="100%" height="356"  style="border-collapse: collapse" border="1" cellpadding="2">
<tr><td width="20%" height="352">

		
<br><img border="0" src="images/adsbygoogle.png" width="78" height="16"><p>
<img border="0" src="images/mobiles-prices.gif" width="160" height="137"></p>
<p><img border="0" src="images/160x120.jpg" width="160" height="124">
</td>
<td width="65%" height="61" valign="top">
<div align="center">
  <center>
<p>&nbsp;</p>
  </center>
</div>



<div align="center">
  <center>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="90%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#ECF3FD">
  <tr>
    <th width="100%" colspan="2" bgcolor="#80B1F4">&nbsp;</th>
  </tr>
  <tr>
    <td width="50%" align="center">&nbsp;</td>
    <td width="50%" align="center">&nbsp;</td>
  </tr>
  <tr>
    <td width="50%" align="center">
    <img border="0" src="images/wishlist%20logo.png" width="25" height="25"><font color="#000080">
    
    <a href="WishList.jsp"><font color="#000080">View Wish List</font></a></font></td>
    <td width="50%" align="center"><font color="#000080">
    <img border="0" src="images/shppngCrt1.png" width="20" height="20"> </font>
    <a href="InterCart.jsp"><font color="#000080">View Cart</font></a></td>
  </tr>
  <tr>
    <td width="50%" align="center">&nbsp;</td>
    <td width="50%" align="center">&nbsp;</td>
  </tr>
  <tr>
    <td width="50%" align="center"><font color="#000080">
    <img border="0" src="images/myAcc1.png" width="20" height="20"> </font>
    <a href="ViewMyOrders.jsp">
    <font color="#000080">View My All Orders</font></a></td>
    <td width="50%" align="center"><font color="#000080">
    &nbsp;</font></td>
  </tr>
  <tr>
    <td width="50%" align="center">&nbsp;</td>
    <td width="50%" align="center">&nbsp;</td>
  </tr>
  <tr>
    <th width="100%" colspan="2" bgcolor="#80B1F4">&nbsp;</th>
  </tr>
</table>
  </center>
</div>



</td>
<td width="15%" height="352" valign="top" align="center" >
<p><img border="0" src="images/Online-Shopping.png" width="172" height="389"></p>
<p></td>
</table>

</tr>
<tr><td>
<%@ include file="footer.html" %>
</tr>
</table>

</body></html>