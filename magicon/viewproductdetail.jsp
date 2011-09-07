<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.*,com.magicon.Product" errorPage="" %>
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

<script language="JavaScript">
function validate()
{
if(document.cart_form.p_quantity.value=="")
{
alert("please enter the quantity value quantity is set to 1");
document.cart_form.p_quantity.value="1";
}
if(isNaN(document.cart_form.p_quantity.value)==true)
{
alert("please enter the numeric value quantity is set to 1");
document.cart_form.p_quantity.value="1";
}
}


function validate1()
{
document.cart_form.p_quantity.value="";
}

</script>

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
<td bgcolor="#0F57BB" valign="middle" height="34" width="60%"><div align="center" >
  <font face="Arial Black" color="#FFFFFF">Product Detail</font><font face="Arial Black" size="3" color="#FFFFFF">
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
  <!-- handle the request for view the product-->

  <%
Connection conn;
conn=null;
ResultSet rs;
rs=null;


String cart_pd_id= request.getParameter("cart_pd_id");
if(cart_pd_id!=null)
{
try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat = conn.prepareStatement("select a.*,b.cat_name from product_info as a, category_info as b where a.cat_id=b.cat_id and pd_id=?");
		stat.setString(1,cart_pd_id);
		rs=stat.executeQuery();
		if(rs.next())
		{
%>

    <form method="post" name="cart_form" action="InterCart.jsp">
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#FFFFFF" width="80%" bordercolordark="#FFFFFF" bordercolorlight="#FFFFFF" bgcolor="#E8F1FD" height="1">
  <tr>
    <td width="100%" colspan="2" height="19" bgcolor="#FFFFFF">
    &nbsp;</td>
  </tr>
  <tr>
    <td width="100%" colspan="2" height="24" bgcolor="#87B6F5">
    &nbsp;</td>
  </tr>
  <tr>
    <td width="100%" colspan="2" height="168">
    <p align="center">
    <img border="1" src="<%=rs.getString("pd_photo_path")%>" width="130" height="130"></td>
  </tr>
  <tr>
    <td width="38%" height="19" align="left">Product Id</td>
    <td width="62%" height="19" align="left"><%=rs.getString("pd_id")%></td>
    <input type="hidden" name="cpd_id" value=<%=rs.getString("pd_id")%> >
	
  </tr>
  <tr>
    <td width="38%" height="19" align="left">Product Name</td>
    <td width="62%" height="19" align="left"><%=rs.getString("pd_name")%></td>
  </tr>
  <tr>
    <td width="38%" height="19" align="left">Product Category</td>
    <td width="62%" height="19" align="left"><%=rs.getString("cat_name")%></td>
  </tr>
  <tr>
    <td width="38%" height="19" align="left">Product Brand</td>
    <td width="62%" height="19" align="left"><%=rs.getString("pd_brand")%></td>
  </tr>
  <tr>
    <td width="38%" height="19" align="left">Product Price</td>
    <td width="62%" height="19" align="left"><%=rs.getString("pd_price")%></td>
  </tr>
  <tr>
    <td width="38%" height="19" align="left">Product Add Date</td>
    <td width="62%" height="19" align="left"><%=rs.getString("pd_date")%></td>
  </tr>
  <tr>
    <td width="38%" height="18" align="left">Product Description</td>
    <td width="62%" height="18" align="left"><%=rs.getString("pd_des")%></td>
  </tr>
  <tr>
    <td width="38%" height="19" align="left">Enter the Quantity</td>
    <td width="62%" height="19" align="left"><input type="text" value="enter the numeric value" name="p_quantity" size="20" onfocus="validate1()" onblur="validate()"></td>
  </tr>
  <tr>
    <td width="38%" height="19" align="left">&nbsp;</td>
    <td width="62%" height="19" align="left">&nbsp;</td>
  </tr>
  <tr>
    <td width="38%" height="19" align="left">&nbsp;</td>
    <td width="62%" height="19" align="left">
    <input type="submit" value="Add to Cart" name="B1" onclick="validate();">
    <input type="reset" value="Reset" name="B2"></td>
  </tr>
  <tr>
    <td width="38%" height="19" align="left">&nbsp;</td>
    <td width="62%" height="19" align="left">&nbsp;</td>
  </tr>
  <tr>
    <td width="100%" height="19" align="left" colspan="2" bgcolor="#87B6F5">&nbsp;</td>
  </tr>
</table>
</form>
<%
		}//end of if
		}//end of try
		catch(Exception E)
		{
			out.println("Error displaying value"+E);
		}	
		finally
		{	
		
			rs.close();
			conn.close();
		}
	
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