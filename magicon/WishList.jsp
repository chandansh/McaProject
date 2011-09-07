<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Magicon Home page</title>
</head>

<body>
<jsp:useBean id="bean" class="com.magicon.MagiconBean" scope="request"/>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr><td>
<%@ include file="index1.html" %>
</tr>
<tr><td>
<%@ include file="usermenu.html" %>
</tr>
<% 
	String user_src=(String)session.getValue("user");
	if (user_src!=null)
  	{
	//out.println("Hi "+user_src);
	//out.println("<br>"+session.getId());
	}
	else
	{
		response.sendRedirect("Unauthorised.htm");
	}
%>
<tr><td>

		<jsp:include page="searchform.jsp" >
			<jsp:param name="userid" value="<%=user_src%>"/>
			<jsp:param name="action_path" value="usersearch.jsp"/>
		</jsp:include>
</tr>

<tr><td>
<table width="100%" height="356"  style="border-collapse: collapse" border="0" cellpadding="2">
<tr><td width="20%" height="352">

		<jsp:include page="advancesearch_form.jsp" >
			<jsp:param name="userid" value="<%=user_src%>"/>
			<jsp:param name="action_path" value="usersearch.jsp"/>
		</jsp:include>

		


<br><img border="0" src="images/adsbygoogle.png" width="78" height="16"><p>
<img border="0" src="images/mobiles-prices.gif" width="160" height="137"></p>
<p><img border="0" src="images/160x120.jpg" width="160" height="124">
</td>
<td width="65%" height="61" valign="top">
<%@ include file="banner.html" %>
<div align="center">
  <center>
<p>&nbsp;</p>
<!-- handle the request for remove from wish List -->

<%


    Connection conn;
	conn=null;
	ResultSet rs;
	rs=null;
	String w_id1=request.getParameter("w_id1");
	if(w_id1!=null && w_id1!="")
	{
	try
	{
		
		conn =bean.getConnection(request);
		PreparedStatement stat=conn.prepareStatement("delete from wish_list where w_id=? ");
		stat.setString(1,w_id1);	
		int success=stat.executeUpdate(); 
        if (success==1)
 		{
 		%><H3 align="center"><font color="#009933" 'Arial'>Selected product Remove from wishList</font></H3><%
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






<!-- handle the request for add to wish List-->
<%


String wish_pd_id= request.getParameter("wish_pd_id");


if(wish_pd_id!=null && wish_pd_id!="")
{
	try
	{
		conn = bean.getConnection(request);
		PreparedStatement stat = conn.prepareStatement("select * from wish_list where cust_id=? and pd_id=?");
		stat.setString(1,user_src);
		stat.setString(2,wish_pd_id);
		rs=stat.executeQuery();
		if(rs.next())
		{
			out.print("<h3><font color='#ff0000' face='Arial'>Product already in wish List</font></h3>");
		}
		else
		{
		PreparedStatement stat1 = conn.prepareStatement("insert into wish_list values(?,?,?)");
		int w_id=(int)(10000*Math.random()+1);
		stat1.setInt(1,w_id);
		stat1.setString(2,user_src);
		stat1.setString(3,wish_pd_id);
		stat1.executeUpdate();
		out.print("<h3><font color='#009933' face='Arial'>Product added to wish List</font></h3>");

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

<P align="center"><font face="Arial" color="#000080"><b>Your wish List</b></font></p> 
<table border="1" cellspacing="0" width="98%" bordercolor="#C0C0C0" bordercolorlight="#C0C0C0" bordercolordark="#C0C0C0" style="border-collapse: collapse" cellpadding="0" bgcolor="#F4F4FF">
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
              <th width="12%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Description</font></th>
              <th width="12%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Add to Cart</font></th>
              <th width="12%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">remove wish List</font></th>

              


            </tr>

<!-- handle the request for show the wish list -->

<%
try
	{
		conn = bean.getConnection(request);
		PreparedStatement stat = conn.prepareStatement("select a.*,c.cat_name,b.* from product_info as a,wish_list as b,category_info as c where a.cat_id=c.cat_id and a.pd_id=b.pd_id and cust_id=?" );
		stat.setString(1,user_src);
		rs=stat.executeQuery();
		while(rs.next())
		{

		%>
            
            <tr>
              <td width="11%" align="left">
              <img border="0" src="<%=rs.getString("pd_photo_path")%>" width="85" height="66"></td>
              <td width="11%" align="left"><%=rs.getString("pd_id")%>&nbsp;</td>
              <td width="11%" align="left"><%=rs.getString("pd_name")%>&nbsp;</td>
              <td width="11%" align="left"><%=rs.getString("cat_name")%>&nbsp;</td>
              <td width="14%" align="left"><%=rs.getString("pd_brand")%>&nbsp;</td>
              <td width="8%" align="left"><%=rs.getString("pd_price")%>&nbsp;</td>
              <td width="12%" align="left"><%=rs.getString("pd_des")%>&nbsp;</td>
              <td width="12%" align="left">
              
              <form method ="post" action ="viewproductdetail.jsp">
			  <input type="hidden" name="cart_pd_id" value=<%=rs.getString("pd_id")%> >
			  <input type="submit" value="Add to Cart">
			  </form>	
                      
              </td>
              
              <td width="12%" align="left">
              
              <form method ="post" action ="WishList.jsp">
			  <input type="hidden" name="w_id1" value=<%=rs.getString("w_id")%> >
			  <input type="submit" value="delete">
			  </form>	
                      
              </td>

                            
            </tr>
            
        <%
			
		}//end of while
	
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

<p> hello how are you magicon</body></html>