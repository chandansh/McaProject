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
<td bgcolor="#0F57BB" valign="middle" height="34" width="48%"><div align="center" ><font face="Arial Black" size="3" color="#FFFFFF">
  My Cart  
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
<p>&nbsp;</p>
<!--handle the request for remove from cart-->


<%


    Connection conn;
	conn=null;
	ResultSet rs;
	rs=null;
	String dcart_id=request.getParameter("cart_id");
	if(dcart_id!=null && dcart_id!="")
	{
	try
	{
		
		conn =bean.getConnection(request);
		PreparedStatement stat=conn.prepareStatement("delete from cart where cart_id=? ");
		stat.setString(1,dcart_id);	
		int success=stat.executeUpdate(); 
        if (success==1)
 		{
 		%><H3 align="center"><font color="#009933" 'Arial'>Selected product Remove from the cart</font></H3><%
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




<!-- handle the request for Add to cart-->

<%


String c_pd_id= request.getParameter("cpd_id");
String c_pd_qty= request.getParameter("p_quantity");


if(c_pd_id!=null && c_pd_id!="" && c_pd_qty!=null && c_pd_qty!="")
{
	try
	{
		conn = bean.getConnection(request);
		PreparedStatement stat = conn.prepareStatement("select * from cart where cust_id=? and pd_id=?");
		stat.setString(1,user_src);
		stat.setString(2,c_pd_id);
		rs=stat.executeQuery();
		if(rs.next())
		{
			out.print("<h3><font color='#ff0000' face='Arial'>Product already in cart</font></h3>");
		}
		else
		{
		PreparedStatement stat1 = conn.prepareStatement("insert into cart values(?,?,?,?,?)");
		int cart_id=(int)(10000*Math.random()+1);
		java.util.Date now = new java.util.Date();
		String cdate = String.valueOf(now.getYear()+1900)+"-"+String.valueOf(now.getMonth()+1)+"-"+String.valueOf(now.getDate());

		stat1.setInt(1,cart_id);
		stat1.setString(2,user_src);
		stat1.setString(3,c_pd_id);
		stat1.setString(4,c_pd_qty);
		stat1.setString(5,cdate);
		stat1.executeUpdate();
		out.print("<h3><font color='#009933' face='Arial'>Product added to Cart</font></h3>");

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

}

%>

<!-- to view the cart -->

<table border="1" cellspacing="0" width="98%" bordercolor="#C0C0C0" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" style="border-collapse: collapse" cellpadding="0" bgcolor="#F2F2F2">
            <tr>
              <th width="11%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Photo</font></th>
              <th width="11%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Product Id</font></th>
              <th width="11%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Product Name</font></th>
              <th width="13%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Brand</font></th>
              <th width="8%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Price</font></th>
              <th width="12%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">quantity</font></th>
              <th width="13%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">total</font></th>
              <th width="16%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Add Date</font></th>
              <th width="12%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">&nbsp;</font></th>


            </tr>

<%
try
	{
		conn = bean.getConnection(request);
		PreparedStatement stat = conn.prepareStatement("select a.*,b.*,a.pd_price*b.cart_qty as 'total' from product_info as a, cart as b where a.pd_id=b.pd_id and b.cust_id=?" );
		stat.setString(1,user_src);
		rs=stat.executeQuery();
		double total=0.0;
		while(rs.next())
		{

		%>
            
            <tr>
              <td width="11%" align="left">
              <img border="0" src="<%=rs.getString("pd_photo_path")%>" width="85" height="66"></td>
              <td width="11%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><%=rs.getString("pd_id")%>&nbsp;</td>
              <td width="11%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><%=rs.getString("pd_name")%>&nbsp;</td>
              <td width="10%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><%=rs.getString("pd_brand")%>&nbsp;</td>
              <td width="14%" align="right" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><%=rs.getDouble("pd_price")%>&nbsp;</td>
              <td width="8%" align="right" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><%=rs.getString("cart_qty")%>&nbsp;</td>
              <td width="13%" align="right" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><%=Double.parseDouble(rs.getString("total"))%>&nbsp;</td>
              <td width="17%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><%=rs.getString("cart_date")%>&nbsp;</td>

              <td width="12%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">
              
              <form method ="post" action ="InterCart.jsp">
			  <input type="hidden" name="cart_id" value=<%=rs.getString("cart_id")%> >
			  <input type="submit" value="remove cart">
			  </form>	
                                           
            </tr>
            
        <%
			
		total=total+Double.parseDouble(rs.getString("total"));
		}//end of while
	
		




		%>
	
	<tr>
	<th width="11%" bgcolor="#808080" align="center">
    <font color="#FFFFFF">&nbsp;</font></th>
    <th width="11%" bgcolor="#808080" align="center">
    <font color="#FFFFFF">&nbsp;</font></th>
	<th width="11%" bgcolor="#808080" align="center">
    <font color="#FFFFFF">&nbsp;</font></th>
	<th width="10%" bgcolor="#808080" align="center">
    <font color="#FFFFFF">&nbsp;</font></th>
	<th width="11%" bgcolor="#808080" align="center">
    <font color="#FFFFFF">&nbsp;</font></th>
    <th width="11%" bgcolor="#808080" align="center">
    <font color="#FFFFFF">Total Cart Amount</font></th>
	<th width="12%" bgcolor="#808080" align="right">
    <font color="#FFFFFF"><%=total%>&nbsp;</font></th>
	<th width="16%" bgcolor="#808080" align="center">
    <font color="#FFFFFF">&nbsp;</font></th>
    <font color="#FFFFFF">&nbsp;</font></th>
	<th width="11%" bgcolor="#808080" align="center">

	<a href="CheckOut.jsp">Check Out</a></tr>

	<%
	

	}//end of try
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
</center>
</div>

<p align="center"><font face="Arial" color="#000080"><b>End of&nbsp; List</b></font></p>


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