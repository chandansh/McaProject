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




<!-- handle the request for complete order -->
<%
	Connection conn;
	conn=null;
	ResultSet rs;
	rs=null;
	
	int order_id=(int)(10000*Math.random()+1);
	String card_no=request.getParameter("card_no");
	String holder_name=request.getParameter("holder_name");
	String exp_year=request.getParameter("exp_year");
	String exp_month=request.getParameter("exp_month");
	String exp_day=request.getParameter("exp_day");
	String ship_name=request.getParameter("ship_name");
	String ship_address=request.getParameter("ship_address");
	String ship_phone=request.getParameter("ship_phone");
	String ship_mobile=request.getParameter("ship_mobile");
	String ship_email=request.getParameter("ship_email");
	double total_amount=Double.parseDouble(request.getParameter("total_amount"));
	
	String card_exp_date=exp_year+"-"+exp_month+"-"+exp_day;
	
	java.util.Date now = new java.util.Date();
	
        String order_date = String.valueOf(now.getYear()+1900)+"-"+String.valueOf(now.getMonth()+1)+"-"+String.valueOf(now.getDate());
        
	
	//out.print(card_exp_date);
	
	
	try
	{
		conn =bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("insert into order_table values(?,?,?,?,?,?,?,?,?,?,?,?,?)" );
		
		stat.setInt(1,order_id);
		stat.setString(2,user_src);
		stat.setDouble(3,total_amount);
		stat.setString(4,order_date);
		stat.setString(5,card_no);
		stat.setString(6,holder_name);
		stat.setString(7,card_exp_date);
		stat.setString(8,ship_name);
		stat.setString(9,ship_address);
		stat.setString(10,ship_phone);
		stat.setString(11,ship_mobile);
		stat.setString(12,ship_email);
		stat.setString(13,"posted");

		
		stat.executeUpdate();
		
		PreparedStatement stat1= conn.prepareStatement("select * from cart where cust_id=?");
		stat1.setString(1,user_src);
		rs=stat1.executeQuery();
		PreparedStatement order_stat=conn.prepareStatement("insert into order_detail values(?,?,?)");
		while(rs.next())
		{
		order_stat.setInt(1,order_id);
		order_stat.setString(2,rs.getString("pd_id"));
		order_stat.setInt(3,rs.getInt("cart_qty"));
		order_stat.addBatch();
		}
		order_stat.executeBatch();
		
		PreparedStatement delcart_stat=conn.prepareStatement("delete from cart where cust_id=?");
		delcart_stat.setString(1,user_src);
		delcart_stat.executeUpdate();
		
		out.print("<h3><font color='#009933' face='Arial'>Order successfully posted order id="+order_id+"</font></h3>");


	
				
	}
	catch(Exception E)
	{
		out.println("Error  "+E);
	}
	finally
	{	
		//rs.close();
		conn.close();
	}
		

	
%>





<!-- display the order and order details -->

<%
try
{
	conn=bean.getConnection(request);
	PreparedStatement stmt =conn.prepareStatement("select * from order_table where order_id=?");
	stmt.setInt(1,order_id);
	rs=stmt.executeQuery();
	if(rs.next())
	{
	%>
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
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left"><%=rs.getString("status")%>&nbsp;</td>
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


<!-- display the order details -->
<br><br>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="85%">
  <tr>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">Product Id &nbsp;</td>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">Product Qty &nbsp;</td>
  </tr>



<%
try
{
	conn=bean.getConnection(request);
	PreparedStatement stmt =conn.prepareStatement("select * from order_detail where order_id=?");
	stmt.setInt(1,order_id);
	rs=stmt.executeQuery();
	while(rs.next())
	{
	%>
	<tr>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left"><%=rs.getString("pd_id")%> &nbsp;</td>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left"><%=rs.getString("qty")%> &nbsp;</td>
 	 </tr>


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
 <tr>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">&nbsp;</td>
    <td width="50%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#E1EDFD" align="left">&nbsp;</td>
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