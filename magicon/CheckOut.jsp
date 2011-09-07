<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script language="JavaScript">
function validate()
  	{
	 	if(document.form1.ship_name.value=="")
		{
  			alert("Name cannot be blank!!");
			return;
  		}
  		if(document.form1.ship_address.value=="")
		{
  			alert("address cannot be blank!!");
  			return;
  		}
  		if(document.form1.ship_phone.value=="")
		{
  			alert("enter the shipping phone !!");
  			return;
  		}
		if(document.form1.ship_mobile.value=="")
		{
  			alert("enter the mobile no!!");
  			return;
  		}
  		if(document.form1.ship_email.value=="")
		{
  			alert("email should not be blank!!");
  			return;
  		}
  		if(document.form1.card_no.value=="")
		{
  			alert("credit card no should not be blank!!");
  			return;
  		}

		if(document.form1.holder_name.value=="")
		{
  			alert("holder name should not be blank!!");
  			return;
  		}
		if(document.form1.exp_day.value=="")
		{
  			alert("select any day!!");
  			return;
  		}
  		if(document.form1.exp_month.value=="")
		{
  			alert("select any month!!");
  			return;
  		}
		if(document.form1.exp_year.value=="")
		{
  			alert("select any year!!");
  			return;
  		}


		if(document.form1.card_no.value.length!=20 )
		{
			alert("card no must be equal 20 digit!!");
			return;
		}
		if(document.form1.holder_name.value.length>20)
		{
			alert("card holder name should be less than or equal 20 char!!");
			return;
		}
		if(document.form1.ship_name.value.length>30)
		{
			alert("shipping address name should be less than or equal 30 char!!");
			return;
		}
		if(document.form1.ship_address.value.length>50)
		{
			alert("shipping address should be less than or equal 50 char!!");
			return;
		}

		
		
  	  	document.form1.action="OrderPosting.jsp";
  		//document.form1.submit();
  		
  	}

</script>

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
<p>&nbsp;</p>



<!-- to view the order detail -->

<table border="1" cellspacing="0" width="98%" bordercolor="#C0C0C0" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" style="border-collapse: collapse" cellpadding="0" bgcolor="#F2F2F2">
            <tr>
              <th width="11%" bgcolor="#808080" align="center" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">
              <font color="#FFFFFF">Product Id</font></th>
              <th width="11%" bgcolor="#808080" align="center" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">
              <font color="#FFFFFF">Product Name</font></th>
              <th width="13%" bgcolor="#808080" align="center" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">
              <font color="#FFFFFF">Brand</font></th>
              <th width="8%" bgcolor="#808080" align="center" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">
              <font color="#FFFFFF">Quantity</font></th>
              <th width="12%" bgcolor="#808080" align="center" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">
              <font color="#FFFFFF">Unit Price</font></th>
              <th width="13%" bgcolor="#808080" align="center" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">
              <font color="#FFFFFF">total</font></th>


            </tr>

<%
	Connection conn;
	conn=null;
	ResultSet rs;
	rs=null;
	double total=0.0;
try
	{
		conn = bean.getConnection(request);
		PreparedStatement stat = conn.prepareStatement("select a.*,b.*,a.pd_price*b.cart_qty as 'total' from product_info as a, cart as b where a.pd_id=b.pd_id and b.cust_id=?" );
		stat.setString(1,user_src);
		rs=stat.executeQuery();
		int total_qty=0;
		while(rs.next())
		{

		%>
            
            <tr>
              <td width="11%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><%=rs.getString("pd_id")%>&nbsp;</td>
              <td width="11%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><%=rs.getString("pd_name")%>&nbsp;</td>
              <td width="10%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><%=rs.getString("pd_brand")%>&nbsp;</td>
              <td width="14%" align="right" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><%=rs.getString("cart_qty")%>&nbsp;</td>
              <td width="8%" align="right" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><%=rs.getDouble("pd_price")%>&nbsp;</td>
              <td width="13%" align="right" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><%=Double.parseDouble(rs.getString("total"))%>&nbsp;</td>
            
        <%
			
		total_qty=total_qty+rs.getInt("cart_qty");	
		total=total+Double.parseDouble(rs.getString("total"));
		}//end of while
	
		




		%>
	
	<tr>
    <th width="11%" bgcolor="#808080" align="center" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">
    <font color="#FFFFFF">&nbsp;</font></th>
	<th width="11%" bgcolor="#808080" align="center" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">
    <font color="#FFFFFF">&nbsp;</font></th>
	<th width="10%" bgcolor="#808080" align="center" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">
    <font color="#FFFFFF">&nbsp;Total Quantity</font></th>
	<th width="11%" bgcolor="#808080" align="right" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">
    <font color="#FFFFFF"><%=total_qty%>&nbsp;</font></th>
    <th width="11%" bgcolor="#808080" align="center" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">
    <font color="#FFFFFF">Total Cart Amount</font></th>
	<th width="12%" bgcolor="#808080" align="right" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">
    <font color="#FFFFFF"><%=total%>&nbsp;</font></th>
	<font color="#FFFFFF">&nbsp;</font></th>
	
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

<p align="center"><b><font face="Arial" color="#000080">Enter the  
Details</font></b></p>

<!-- show the Address -->
<%
try
	{
		conn = bean.getConnection(request);
		PreparedStatement stat = conn.prepareStatement("select * from cust_info where cust_id=?" );
		stat.setString(1,user_src);
		rs=stat.executeQuery();
		if(rs.next())
		{

		%>



<form method="post" name="form1">
<div align="center">
  <center>
  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#ffffff" width="98%" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF" bgcolor="#F2F2F2">
    <tr>
      <th width="50%" bgcolor="#808080" colspan="2" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><font color="#FFFFFF">Your Shipping 
      Address</font></th>
      <th width="50%" bgcolor="#808080" colspan="2" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><font color="#FFFFFF">Your 
      Payment Details</font></th>
    </tr>
    <tr>
      <td width="9%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">Name:</td>
      <td width="41%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><input type="text" name="ship_name" size="20" value="<% out.print(rs.getString("cust_firstname")+" "+rs.getString("cust_lastname"));%>"></td>
      <td width="17%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">Credit Card No:</td>
      <td width="33%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><input type="text" name="card_no" size="29"></td>
    </tr>
    <tr>
      <td width="9%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">Address:</td>
      <td width="41%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><input type="text" name="ship_address" size="37" value="<%=rs.getString("cust_address")%>"></td>
      <td width="17%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">Holder Name:</td>
      <td width="33%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><input type="text" name="holder_name" size="29"></td>
    </tr>
    <tr>
      <td width="9%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">Phone:</td>
      <td width="41%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><input type="text" name="ship_phone" size="20" value="<%=rs.getString("cust_phone")%>"></td>
      <td width="17%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">Exp Date:</td>
      <td width="33%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><select size="1" name="exp_year">
      <option selected value="">year</option>
      <option value="2010">2010</option>
      <option value="2011">2011</option>
      <option value="2012">2012</option>
      <option value="2013">2013</option>
      <option value="2014">2014</option>
      <option value="2015">2015</option>
      <option value="2016">2016</option>
      </select><select size="1" name="exp_month">
      <option selected value="">month</option>
      <option value="1">jan</option>
      <option value="2">feb</option>
      <option value="3">mar</option>
      <option value="4">apr</option>
      <option value="5">may</option>
      <option value="6">jun</option>
      <option value="7">jul</option>
      <option value="8">aug</option>
      <option value="9">sep</option>
      <option value="10">oct</option>
      <option value="11">nov</option>
      <option value="12">dec</option>
      </select><select size="1" name="exp_day">
      <option selected value="">day</option>
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>
      <option value="4">4</option>
      <option value="5">5</option>
      <option value="6">6</option>
      <option value="7">7</option>
      <option value="8">8</option>
      <option value="9">9</option>
      <option value="10">10</option>
      <option value="11">11</option>
      <option value="12">12</option>
      <option value="13">13</option>
      <option value="14">14</option>
      <option value="15">15</option>
      <option value="16">16</option>
      <option value="17">17</option>
      <option value="18">18</option>
      <option value="19">19</option>
      <option value="20">20</option>
      <option value="21">21</option>
      <option value="22">22</option>
      <option value="23">23</option>
      <option value="24">24</option>
      <option value="25">25</option>
      <option value="26">26</option>
      <option value="27">27</option>
      <option value="28">28</option>
      <option value="29">29</option>
      <option value="30">30</option>
      <option value="31">31</option>
      </select></td>
    </tr>
    <tr>
      <td width="9%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">Mobile:</td>
      <td width="41%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><input type="text" name="ship_mobile" size="20" value="<%=rs.getString("cust_mobile")%>"></td>
      <td width="50%" colspan="2" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">&nbsp;</td>
    </tr>
    <tr>
      <td width="9%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">Email:</td>
      <td width="41%" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF"><input type="text" name="ship_email" size="20" value="<%=rs.getString("cust_email")%>"></td>
      <td width="50%" colspan="2" align="left" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">&nbsp;</td>
    </tr>
    <tr>
      <td width="50%" colspan="2" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">&nbsp;</td>
      <td width="50%" colspan="2" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">
      <p>
      <input type="submit" value="Confirm Order" name="confirm" onclick="validate();" >
      <input type="hidden" value="<%=total%>" name="total_amount">
      <input type="reset" value="Reset" name="B2"></td>
    </tr>
    <tr>
      <th width="50%" bgcolor="#808080" colspan="2" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">&nbsp;</th>
      <th width="50%" bgcolor="#808080" colspan="2" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">&nbsp;</th>
    </tr>
  </table>
  </center>
</div>
</form>
<%
	
		}//end of if
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


<p align="center">&nbsp;</p>


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