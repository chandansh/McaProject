<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
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
<%
String userid=request.getParameter("userid");
String form_action_path=request.getParameter("action_path");

%>
<script type="text/javascript">

function searchvalidate1()
{
if(document.searchform.textfield.value=='')
  {
	document.searchform.textfield.value="enter model no or name";
  }
  if(document.searchform.textfield.value.length<3)
  {
	alert("search field value must be greater or equal 3 character");
	document.searchform.textfield.value="enter model no or name";
  }


}

function validatesearch()
{
if(document.searchform.textfield.value=="enter model no or name")
  {
   alert("please enter any model no or name in text field");
   return;
  }
  document.searchform.action="<%=form_action_path%>";
  document.searchform.submit();
}


function searchvalidate()
{
document.searchform.textfield.value='';
}
</script>

<jsp:useBean id="bean1" class="com.magicon.MagiconBean" scope="request"/>


<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#0F57BB"  height="17">
  <tr>
    <td width="25%"  valign="middle" height="17">
    <p align="center"><b><font size="4" color="#FFFFFF" face="Arial">Hi <%=userid%></font></b></td>
    <td width="42%" height="17"  valign="middle">
    
    
    
	<form id="searchform" name="searchform" method="post">
	  <table width="450" height="20" border="0" cellpadding="0" cellspacing="0" >
        <tr>
          <td width="16%" align="center" valign="middle" height="28"><div align="center">
            <font color="#FFFFFF" face="Arial"><b><span class="searchhead">Search :</span></b></font></div></td>
          <td width="35%" align="center" valign="middle" height="28"><label>
            <div align="center">
              <input name="textfield" type="text" value="enter model no or name" onfocus="searchvalidate()" onblur="searchvalidate1()" size="20"/>
            </div>
          </label></td>
          <td width="10%" align="center" valign="middle" class="style2" height="28"><div align="center" class="searchhead">
            <b><font color="#FFFFFF" face="Arial">In</font></b></div></td>
          <td width="24%" align="center" valign="middle" height="28"><label>
            <div align="center">
            
              
              <!-- fill the category list-->
        <%
       
        {
        
        Connection conn;
		conn=null;
		ResultSet rs;
		rs=null;

        try
		{
		conn = bean1.getConnection(request);
		PreparedStatement stat = conn.prepareStatement("select * from category_info");
		rs=stat.executeQuery();
        
    
        %>
              
              <select size="1" name="pd_cat">
              <option selected value="All">All category</option>
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
		}
		%>
              </select>
             
              </div>
          </label></td>
          <td width="15%" height="28"><label>
            <div align="center">
              <input type="submit" name="searchcat" value="Search" onclick="validatesearch();" />
              </div>
          </label></td>
        </tr>
      </table>
    </form>
    </td>
    <td width="350" align="center" valign="middle" height="17" >
	<%
    if(!userid.equals("Guest"))
    {
    %>
	
	<b><img border="0" src="images/shppngCrt1.png" width="20" height="20">
    <font face="Arial">
    <font color="#FFFFFF"><a href="InterCart.jsp">View Cart</a></font></font></b>
    
       
    
    <b>&nbsp; <img border="0" src="images/myAcc1.png" width="20" height="20">
    <font face="Arial">
    <font color="#FFFFFF"><a href="myacc.jsp">My Account</a></font></font></b>
        
    <%
    }  
    %> 
&nbsp;    </td>
  </tr>
</table>