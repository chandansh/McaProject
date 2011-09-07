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
 <jsp:useBean id="bean" class="com.magicon.MagiconBean" scope="request"/>
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
    
	<td width="20%" ><div id="menu" align="center">
	<UL id="nav" class="nav">
		        <LI><A href="ViewAll.jsp" class="sub">Product</A>
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
	
	<td width="20%"><div id="menu1" align="center">
	<UL id="nav" class="nav">
		         <LI class="sub1">Orders</p>
				 </LI>
	</UL>		</div></td>

	</tr>
</table>
  
  <table width="90%" border="0" cellspacing="1" bordercolor="#0000FF" align="center">
  <tr>
    <td height="500"  bordercolor="#000099" valign="top">
    <table border="0" cellspacing="0" width="100%" cellpadding="0" style="border-collapse: collapse" bordercolor="#111111">
      <tr >
        
        <td bgcolor="#E8E8FF" height=500 valign="top" >
        <p align="center">&nbsp;</p>
        
        <div align="center" style="width: 918; height: 146">
          <center>
          
          
          <!-- handle the request for delete product-->

          <%
    Connection conn;
	conn=null;
	ResultSet rs;
	rs=null;
	String order_id=request.getParameter("order_id");
	if(order_id!=null && order_id!="")
	{
	try
	{
		
		conn =bean.getConnection(request);
		PreparedStatement stat1=conn.prepareStatement("update order_table set status='completed' where order_id=? ");
		stat1.setString(1,order_id);	
		int success=stat1.executeUpdate(); 
        if (success==1)
 		{
 		%><H3 align="center"><font color="#009933" 'Arial'>Selected Order Completed</font></H3><%
		}
		else
		{
		%><H3 align="center"><font color="#FF0000" face 'Arial'>Transaction Not Allowed</font></H3><%
		}
					  		
	}
					
	catch(Exception E)
	{
		out.println("Error updating value"+E);
	}	
	finally
	{
		
		conn.close();
	}
	
	}


%>

          <p align="center"><b><font color="#000080" face="Arial">List of All the 
        Orders are</font></b></p>

          <table border="1" cellspacing="0" width="90%" bordercolor="#C0C0C0" bordercolorlight="#C0C0C0" bordercolordark="#FFFFFF">
            <tr>
              <th width="11%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Order Id</font></th>
              <th width="11%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Cust Id</font></th>
              <th width="12%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Total amount</font></th>
              <th width="10%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Order date</font></th>
              <th width="12%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">shipping name</font></th>
              <th width="10%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">shipping address</font></th>
              <th width="11%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Mobile</font></th>
              <th width="11%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Status</font></th>
              <th width="12%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">change status</font></th>
            </tr>
           
            
            
            <!-- view all the orders-->
		<%
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat = conn.prepareStatement("select * from order_table order by order_date desc");
		rs=stat.executeQuery();
		while(rs.next())
		{

		%>
            
            <tr>
              <td width="11%" bgcolor="#F3F2F1" align="left"><%=rs.getString("order_id")%>&nbsp;</td>
              <td width="12%" bgcolor="#F3F2F1" align="left"><%=rs.getString("cust_id")%>&nbsp;</td>
              <td width="10%" bgcolor="#F3F2F1" align="left"><%=rs.getString("total_amount")%>&nbsp;</td>
              <td width="12%" bgcolor="#F3F2F1" align="left"><%=rs.getString("order_date")%>&nbsp;</td>
              <td width="10%" bgcolor="#F3F2F1" align="left"><%=rs.getString("ship_name")%>&nbsp;</td>
              <td width="11%" bgcolor="#F3F2F1" align="left"><%=rs.getString("ship_address")%>&nbsp;</td>
              <td width="11%" bgcolor="#F3F2F1" align="left"><%=rs.getString("ship_mobile")%>&nbsp;</td>
              <td width="12%" bgcolor="#F3F2F1" align="left"><b><font color="#008000" size="3"><%=rs.getString("status")%></font></b>&nbsp;</td>
              <td width="12%" bgcolor="#F3F2F1" align="left">
              <%if (!rs.getString("status").equals("completed"))
              { %>
              	<form method ="post" action ="Orders.jsp">
              	<input type="hidden" name="order_id" value=<%=rs.getString("order_id")%> >
				<input type="submit" value="Complete order">
				</form>
			  <%
			  }
			  else
			  {
			  out.print(" ");
			  } %>
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