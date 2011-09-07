<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*,java.util.*"  %>
<html xmlns="http://www.w3.org/1999/xhtml">
<LINK href="hotspot2.css" rel="stylesheet" type="text/css">
<LINK href="leftnav.css" rel="stylesheet" type="text/css">
<head>
<script language="JavaScript">
function validate()
  	{
	  	if(document.form1.pd_id.value=="")
		{
  			alert("Product id cannot be blank!!");
			return;
  		}
  		if(document.form1.pd_name.value=="")
		{
  			alert("Product name cannot be blank!!");
  			document.form1.pd_id.value="";
			return;
  		}
  		if(document.form1.pd_cat.value=="")
		{
  			alert("select any Product category !!");
  			document.form1.pd_id.value="";
			return;
  		}
		if(document.form1.pd_brand.value=="")
		{
  			alert("select Product any product brand!!");
  			document.form1.pd_id.value="";
			return;
  		}
  		if(document.form1.pd_price.value=="")
		{
  			alert("Product price should not be blank!!");
  			document.form1.pd_id.value="";
			return;
  		}
  		if(document.form1.pd_qty.value=="")
		{
  			alert("Product quantity should not be blank!!");
  			document.form1.pd_id.value="";
			return;
  		}

		if(document.form1.pd_id.value.length>10)
		{
			alert("Category id should be less than or equal 10 char!!");
			document.form1.pd_id.value="";
			return;
		}
		if(document.form1.pd_name.value.length>20)
		{
			alert("product name should be less than or equal 20 char!!");
			document.form1.pd_id.value="";
			return;
		}
		if(document.form1.pd_des.value.length>30)
		{
			alert("product description should be less than or equal 50 char!!");
			document.form1.pd_id.value="";
			return;
		}
		
		
  	  	document.form1.action="addpd.jsp";
  		document.form1.submit();
  		
  	}

</script>
<title>Administrator Home Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>

<body>
<jsp:useBean id="bean" class="com.magicon.MagiconBean" scope="request"/>
<jsp:useBean id="TheBean" scope="request" class="com.magicon.FileUpload" /> 

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
    <tr><td align="center" height="30px"><a href="ViewAll.jsp">view All</a></li>
    <tr><td align="center"  height="30px" bgcolor="#E3E3FD">Add new</tr>
    <tr><td align="center" height="30px"><a href="ModifyProduct.jsp">Modify</a></tr>
    <tr><td align="center" height="30px"><a href="ProductCategory.jsp">Category</a></tr>
    	
</table>
</td>
        <td bgcolor="#E8E8FF" height=500 valign="top">
        <div align="center">
          <p><b><font color="#FF0000">* Image filename should be less than 20 
          char and without space char</font></b></p>
          <form name="form1" ENCTYPE="multipart/form-data" method="POST">
          <table border="1" cellspacing="1" width="49%" bordercolor="#000080">
            <tr>
              <td width="100%" colspan="2" bgcolor="#000080" align="left"><b>
              <font color="#FFFFFF" face="Arial">Add New Product</font></b></td>
            </tr>
            <tr>
              <td width="32%" align="left">Product ID</td>
              <td width="68%" align="left">
              <input type="text" name="pd_id" size="20"><b><font size="2" color="#008000">Max 
              10 char</font></b></td>
            </tr>
            <tr>
              <td width="32%" align="left">Product Name</td>
              <td width="68%" align="left">
              <input type="text" name="pd_name" size="20"><b><font size="2" color="#008000">Max 
              20 char</font></b></td>
            </tr>
            <tr>
            
		<!-- fill the category list-->
        <%
        Connection conn;
		conn=null;
		ResultSet rs;
		rs=null;

        try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat = conn.prepareStatement("select * from category_info");
		rs=stat.executeQuery();
        
    
        %>
              <td width="32%" align="left">Category ID</td>
              <td width="68%" align="left">
              <select size="1" name="pd_cat">
              <option selected value="">select category</option>
		<% 
		while(rs.next())
		{
		%>
			<option value="<%=rs.getString("cat_id")%>"><%=rs.getString("cat_name")%></option>
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
              </select></td>
            </tr>
            <tr>
              <td width="32%" align="left">Product Brand</td>
              <td width="68%" align="left"><select size="1" name="pd_brand">
              <option selected value>select brand</option>
              <option value="Nokia">Nokia</option>
              <option value="Sony Ericsson">Sony Ericsson</option>
              <option value="Samsung">Samsung</option>
              <option value="LG">LG</option>
              <option value="Motorola">Motorola</option>
              <option value="Blackberry">Blackberry</option>
              <option value="Spice">Spice</option>
              <option value="Micromax">Micromax</option>
              <option value="Fly">Fly</option>
              <option value="htc">htc</option>
              <option value="Matrix">Matrix</option>
              <option value="Philips">Philips</option>
              <option value="Ipod">Ipod</option>
              <option value="Jabra">Jabra</option>
              <option value="Kingston">Kingston</option>
              <option value="Sandisk">Sandisk</option>
              <option value="Transcend">Transcend</option>
              <option value="other">other</option>
              </select></td>
            </tr>
            <tr>
              <td width="32%" align="left">Product Price</td>
              <td width="68%" align="left">
              <input type="text" name="pd_price" size="20"></td>
            </tr>
            <tr>
              <td width="32%" align="left">Product qty</td>
              <td width="68%" align="left">
              <input type="text" name="pd_qty" size="20"></td>
            </tr>
            <tr>
              <td width="32%" align="left">Product Photo</td>
              <td width="68%" align="left">
              <input type="file" name="imagefile" size="20"></td>
                       
            </tr>
            <tr>
              <td width="32%" align="left">Description</td>
              <td width="68%" align="left">
              <textarea rows="2" name="pd_des" cols="20"></textarea></td>
            </tr>
            <tr>
              <td width="32%" align="left">&nbsp;</td>
              <td width="68%" align="left">&nbsp;</td>
            </tr>
            <tr>
              <td width="32%" align="left">&nbsp;</td>
              <td width="68%" align="left">
              <input type="submit" value="Add Product" onclick="validate();"><input type="reset" value="Reset" ></td>
            </tr>
          </table>
          </form>
   <!-- handle the request for add new  Product-->
<p>&nbsp;</p>
   <%
   String msg=request.getParameter("msg");
   String imagepath=request.getParameter("imagepath");
   
   if(imagepath!=null)
   {
   if(!imagepath.equals("null"))
   {
   %>
   <img src="<%=imagepath%>" height="100" width="150" alt="image not available"/><br>
   <%
   }
   }
   if(msg!=null && msg!="")
   {
   out.print(msg);
   }
   

   
   %>
     <p>&nbsp;</p>    
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