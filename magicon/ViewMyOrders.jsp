<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.*" errorPage="" %>
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
<td bgcolor="#0F57BB" valign="middle" height="34" width="48%"><div align="center" >
  <font face="Arial Black" color="#FFFFFF">Order detail</font><font face="Arial Black" size="3" color="#FFFFFF">
  </font></div>
</td>

<td bgcolor="#0F57BB" valign="middle" height="34" width="32%"><div align="center" >
    
       
    
    <b> <img border="0" src="images/myAcc1.png" width="20" height="20">
    <font color="#FFFFFF" face="Arial"><a href="myacc.jsp">My Account</a>&nbsp; </font></b><font face="Arial Black" size="3" color="#FFFFFF">  
<a href="usersearch.jsp"><< Back to search</a>
</font></div>
</td>
</table>



</tr>


<tr><td>
<table width="100%" height="356"  style="border-collapse: collapse" border="1" cellpadding="2">
<tr><td width="18%" height="352">

		
<br><img border="0" src="images/adsbygoogle.png" width="78" height="16"><p>
<img border="0" src="images/mobiles-prices.gif" width="160" height="137"></p>
<p><img border="0" src="images/160x120.jpg" width="160" height="124">
</td>
<td width="67%" height="61" valign="top">
<div align="center">
  <center>





	


<!-- display the order and order details -->

<%
	Connection conn;
	conn=null;
	ResultSet rs;
	rs=null;
	
	
try
{
	conn=bean.getConnection(request);
	PreparedStatement stmt =conn.prepareStatement("select * from order_table where cust_id=? order by order_date desc");
	stmt.setString(1,user_src);
	rs=stmt.executeQuery();
	while(rs.next())
	{
	%>
	<br>
	<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="85%">
  <tr>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">&nbsp;</td>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">&nbsp;</td>
  </tr>
  <tr>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">
    Order Id :</td>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left"><%=rs.getString("order_id")%>&nbsp;</td>
  </tr>
  <tr>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">
    Order Date :</td>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left"><%=rs.getString("order_date")%>&nbsp;</td>
  </tr>
  <tr>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">
    Total Amount :</td>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left"><%=rs.getString("total_amount")%>&nbsp;</td>
  </tr>
  <tr>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">
    Credit Card Number :</td>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left"><%=rs.getString("credit_card_no")%>&nbsp;</td>
  </tr>
  <tr>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">
    Credit Card Holder :</td>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left"><%=rs.getString("holder_name")%>&nbsp;</td>
  </tr>
  <tr>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">
    Exp Date :</td>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left"><%=rs.getString("exp_date")%>&nbsp;</td>
  </tr>
  <tr>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">
    Shipping Name :</td>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left"><%=rs.getString("ship_name")%>&nbsp;</td>
  </tr>
  <tr>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">
    Shipping Address :</td>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left"><%=rs.getString("ship_address")%>&nbsp;</td>
  </tr>
  <tr>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">
    Shipping Phone :</td>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left"><%=rs.getString("ship_phone")%>&nbsp;</td>
  </tr>
  <tr>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">
    Shipping Mobile :</td>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left"><%=rs.getString("ship_mobile")%>&nbsp;</td>
  </tr>
  <tr>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">
    Shipping Email :</td>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left"><%=rs.getString("ship_email")%>&nbsp;</td>
  </tr>
  <tr>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">
    Status :</td>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left"><b><font color="#008000" size="4"><%=rs.getString("status")%></font></b>&nbsp;</td>
  </tr>

  <tr>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">&nbsp;</td>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">&nbsp;</td>
  </tr>
</table>
	
	
	<%
	}
}
catch(Exception e)
{
	out.print("Error   "+e);
}
finally
{
	rs.close();
	conn.close();
}


%>






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