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


<table border="1" cellspacing="0" width="98%" bordercolor="#C0C0C0" bordercolorlight="#C0C0C0" bordercolordark="#FFFFFF" style="border-collapse: collapse" cellpadding="0">
            <tr>
              <th width="11%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Photo</font></th>
              <th width="11%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Name</font></th>
              <th width="11%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Category</font></th>
              <th width="14%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Brand</font></th>
              <th width="8%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Price</font></th>
              <th width="12%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Add to Cart</font></th>
              <th width="12%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Add to WishList</font></th>


            </tr>
<!-- handle the request for advance search-->
<%
Connection conn;
conn=null;
ResultSet rs;
rs=null;


String pd_brand1= request.getParameter("pd_brand");
String price_range1=request.getParameter("price_range");

if(pd_brand1!=null)
{

String sqlquery="";
out.print("Brand : "+pd_brand1);

if(price_range1!=null && !pd_brand1.equals("All Brand"))
{
	out.print(" price range : "+price_range1);
	if(price_range1.equals("All Prices"))
	{
	sqlquery="select a.pd_id,a.pd_name,b.cat_name,a.pd_brand,a.pd_price,a.pd_photo_path,a.pd_des from product_info as a"; 
	sqlquery=sqlquery+",category_info as b where a.cat_id=b.cat_id and a.pd_brand='"+pd_brand1+"' order by a.cat_id,a.pd_brand ";
	}
	if(price_range1.equals("0 to 5000"))
	{
	sqlquery="select a.pd_id,a.pd_name,b.cat_name,a.pd_brand,a.pd_price,a.pd_photo_path,a.pd_des from product_info as a"; 
	sqlquery=sqlquery+",category_info as b where a.cat_id=b.cat_id and a.pd_brand='"+pd_brand1+"' and a.pd_price>=0 and a.pd_price<=5000 order by a.cat_id,a.pd_brand ";
	}
	if(price_range1.equals("5000 to 10000"))
	{
	sqlquery="select a.pd_id,a.pd_name,b.cat_name,a.pd_brand,a.pd_price,a.pd_photo_path,a.pd_des from product_info as a"; 
	sqlquery=sqlquery+",category_info as b where a.cat_id=b.cat_id and a.pd_brand='"+pd_brand1+"' and a.pd_price>=5000 and a.pd_price<=10000 order by a.cat_id,a.pd_brand ";
	}
	if(price_range1.equals("10000 to 15000"))
	{
	sqlquery="select a.pd_id,a.pd_name,b.cat_name,a.pd_brand,a.pd_price,a.pd_photo_path,a.pd_des from product_info as a"; 
	sqlquery=sqlquery+",category_info as b where a.cat_id=b.cat_id and a.pd_brand='"+pd_brand1+"' and a.pd_price>=10000 and a.pd_price<=15000 order by a.cat_id,a.pd_brand ";
	}
	if(price_range1.equals("15000 to above"))
	{
	sqlquery="select a.pd_id,a.pd_name,b.cat_name,a.pd_brand,a.pd_price,a.pd_photo_path,a.pd_des from product_info as a"; 
	sqlquery=sqlquery+",category_info as b where a.cat_id=b.cat_id and a.pd_brand='"+pd_brand1+"' and a.pd_price>=15000 order by a.cat_id,a.pd_brand ";
	}
}

if(price_range1!=null && pd_brand1.equals("All Brand"))
{
	out.print(" price range : "+price_range1);
	if(price_range1.equals("All Prices"))
	{
	sqlquery="select a.pd_id,a.pd_name,b.cat_name,a.pd_brand,a.pd_price,a.pd_photo_path,a.pd_des from product_info as a"; 
	sqlquery=sqlquery+",category_info as b where a.cat_id=b.cat_id order by a.cat_id,a.pd_brand ";
	}
	if(price_range1.equals("0 to 5000"))
	{
	sqlquery="select a.pd_id,a.pd_name,b.cat_name,a.pd_brand,a.pd_price,a.pd_photo_path,a.pd_des from product_info as a"; 
	sqlquery=sqlquery+",category_info as b where a.cat_id=b.cat_id and a.pd_price>=0 and a.pd_price<=5000 order by a.cat_id,a.pd_brand ";
	}
	if(price_range1.equals("5000 to 10000"))
	{
	sqlquery="select a.pd_id,a.pd_name,b.cat_name,a.pd_brand,a.pd_price,a.pd_photo_path,a.pd_des from product_info as a"; 
	sqlquery=sqlquery+",category_info as b where a.cat_id=b.cat_id and a.pd_price>=5000 and a.pd_price<=10000 order by a.cat_id,a.pd_brand ";
	}
	if(price_range1.equals("10000 to 15000"))
	{
	sqlquery="select a.pd_id,a.pd_name,b.cat_name,a.pd_brand,a.pd_price,a.pd_photo_path,a.pd_des from product_info as a"; 
	sqlquery=sqlquery+",category_info as b where a.cat_id=b.cat_id and a.pd_price>=10000 and a.pd_price<=15000 order by a.cat_id,a.pd_brand ";
	}
	if(price_range1.equals("15000 to above"))
	{
	sqlquery="select a.pd_id,a.pd_name,b.cat_name,a.pd_brand,a.pd_price,a.pd_photo_path,a.pd_des from product_info as a"; 
	sqlquery=sqlquery+",category_info as b where a.cat_id=b.cat_id and a.pd_price>=15000 order by a.cat_id,a.pd_brand ";
	}

}

if(price_range1==null && !pd_brand1.equals("All Brand"))
{
sqlquery="select a.pd_id,a.pd_name,b.cat_name,a.pd_brand,a.pd_price,a.pd_photo_path,a.pd_des from product_info as a"; 
sqlquery=sqlquery+",category_info as b where a.cat_id=b.cat_id and a.pd_brand='"+pd_brand1+"' order by a.cat_id,a.pd_brand ";
}

if(!sqlquery.equals(""))
{
try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat = conn.prepareStatement(sqlquery);
		//stat.setString(1,pd_brand1);
		rs=stat.executeQuery();
		while(rs.next())
		{

		%>
            
            <tr>
              <td width="11%" bgcolor="#F3F2F1" align="center">
              <img border="0" src="<%=rs.getString("pd_photo_path")%>" width="85" height="66"></td>
              <td width="11%" bgcolor="#F3F2F1" align="left"><%=rs.getString("pd_name")%>&nbsp;</td>
              <td width="11%" bgcolor="#F3F2F1" align="left"><%=rs.getString("cat_name")%>&nbsp;</td>
              <td width="14%" bgcolor="#F3F2F1" align="left"><%=rs.getString("pd_brand")%>&nbsp;</td>
              <td width="8%" bgcolor="#F3F2F1" align="left"><%=rs.getString("pd_price")%>&nbsp;</td>
              <td width="12%" bgcolor="#F3F2F1" align="left">
              
              <form method ="post" action ="viewproductdetail.jsp">
			  <p>
			  <input type="hidden" name="cart_pd_id" value=<%=rs.getString("pd_id")%> >
			  <input type="submit" value="Add to Cart"> </p>
			  </form>
              
              </td>
              
              <td width="12%" bgcolor="#F3F2F1" align="left">
              
              <form method ="post" action ="WishList.jsp">
			  <input type="hidden" name="wish_pd_id" value=<%=rs.getString("pd_id")%> >
			  <input type="submit" value="Add WishList">
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

}
}

%>

<!-- handle the request for category search -->

<%
String pd_cat_id=request.getParameter("pd_cat");
String search_creteria="%"+request.getParameter("textfield")+"%";

if(pd_cat_id!=null)
{
	String sqlquery="";
	if(pd_cat_id.equals("All"))
	{
	sqlquery="select a.*,b.cat_name from product_info as a,category_info as b where a.cat_id=b.cat_id and (a.pd_name like ? or a.pd_brand like ?)";
	}
	else
	{
	sqlquery="select a.*,b.cat_name from product_info as a,category_info as b where a.cat_id=b.cat_id and (a.pd_name like ? or a.pd_brand like ?) and a.cat_id='"+pd_cat_id+"'";
	}
if(!sqlquery.equals(""))
{
try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat = conn.prepareStatement(sqlquery);
		stat.setString(1,search_creteria);
		stat.setString(2,search_creteria);
		rs=stat.executeQuery();
		while(rs.next())
		{

		%>
            
            <tr>
              <td width="11%" bgcolor="#F3F2F1" align="center">
              <img border="0" src="<%=rs.getString("pd_photo_path")%>" width="85" height="66"></td>
              <td width="11%" bgcolor="#F3F2F1" align="left"><%=rs.getString("pd_name")%>&nbsp;</td>
              <td width="11%" bgcolor="#F3F2F1" align="left"><%=rs.getString("cat_name")%>&nbsp;</td>
              <td width="14%" bgcolor="#F3F2F1" align="left"><%=rs.getString("pd_brand")%>&nbsp;</td>
              <td width="8%" bgcolor="#F3F2F1" align="left"><%=rs.getString("pd_price")%>&nbsp;</td>
              <td width="12%" bgcolor="#F3F2F1" align="left">
              
              <form method ="post" action ="viewproductdetail.jsp">
			  <input type="hidden" name="cart_pd_id" value=<%=rs.getString("pd_id")%> >
			  <input type="submit" value="Add to Cart">
			  </form>	
                      
              </td>
              <td width="12%" bgcolor="#F3F2F1" align="left">
              
              <form method ="post" action ="WishList.jsp">
			  <input type="hidden" name="wish_pd_id" value=<%=rs.getString("pd_id")%> >
			  <input type="submit" value="Add WishList">
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

}

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