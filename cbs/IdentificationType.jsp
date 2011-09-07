<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*"  %>
<html xmlns="http://www.w3.org/1999/xhtml">
<LINK href="leftnav.css" rel="stylesheet" type="text/css">
<LINK href="style.css" rel="stylesheet" type="text/css">
<head>
<script language="JavaScript">
function validate()
{
		if(document.idfrm.i_name.value=="")
		{
  			alert("Identification name cannot be blank!!");
  			document.idfrm.i_name.value="";
			return;
  		}
  		
}


function validate1()
{
		if(document.editform.edit_Iname.value=="")
		{
  			alert("Identification name cannot be blank!!");
  			document.editform.edit_Iid.value="";
  			return;
  		}
}

</script>

<title>Administrator Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>

<body>
<jsp:useBean id="bean" class="com.cbs.CBSBean" scope="request"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="header.html" %></td>
  </tr>
  <tr ><td bgcolor="#0F57BB" valign="middle" height="34"><div align="right"  ><font face="Arial Black" size="3" color="#FFFFFF">  
<% 
	String user_src=(String)session.getAttribute("user");
	String user_type=(String)session.getAttribute("user_type");
	String branch=(String)session.getAttribute("branch");
	if (user_src!=null && user_type!=null && user_type.equals("Administrator"))
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
  
  
  <table width="100%" border="0" cellspacing="1" bordercolor="#0000FF" align="center" height="400">
  <tr>
    <td height="397"  bordercolor="#000099" valign="top" >
    <table border="0" cellspacing="0" width="100%" cellpadding="0" style="border-collapse: collapse" bordercolor="#111111" height="402" >
      <tr >
        <td width="7em" valign="top" bgcolor="#E3E3FD" height="402">
        <table class="navigation" width="100" border="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" >
    <tr><td align="center" height="30px"><a href="admin.jsp">Your Detail</a></tr>
    <tr><td align="center" height="30px"><a href="Branch.jsp">Branch</a></tr>
    <tr><td align="center" height="30px"><a href="NewUser.jsp">New user</a></tr>
    <tr><td align="center" height="30px"><a href="AccountType.jsp">Account Type</a></tr>
    <tr><td align="center" height="30px" bgcolor="#E3E3FD">Identification Type</tr>
    <tr><td align="center" height="30px"><a href="UserAccessLog.jsp">User access Log</a></tr>
</table>

</td>
        <td valign="top" class="sbiback" height="402">
        <p align="center">
      
         <!-- handle the request for add new Identification Type-->
        <%
        Connection conn;
		conn=null;
		ResultSet rs;
		rs=null;
		       
        String i_name=request.getParameter("i_name");
        String cust_type=request.getParameter("cust_type");
        String id_type=request.getParameter("id_type");
        

		if(i_name!=null && i_name!="")
        {
        try
		{
		conn = bean.getConnection(request);
		int i_id=(int)(10000*Math.random()+1);
		PreparedStatement stat= conn.prepareStatement("insert into identification_type values(?,?,?,?)");
		stat.setString(1,String.valueOf(i_id));
		stat.setString(2,i_name);
		stat.setString(3,cust_type);
		stat.setString(4,id_type);
		stat.executeUpdate();
				
		out.print("<font color='green'><b>new Identification Type successfully created</b></font>");
		
				
		}//end of try
		catch(Exception E)
		{
			out.print("error:"+E);
		}
		finally
		{
			
			conn.close();
		}
		
		}//end of if
		%>
        
        &nbsp;</p>
        <p align="center"><b><font color="#000080" face="Arial">Administrator Page</font></b></p>
        <div align="center">
          <center>
          <div align="center">
            <center>
            <form name="idfrm" method="post">
            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="49%">
              <tr>
                <th width="100%" colspan="2" bgcolor="#0F57BB" >
                <font color="#FFFFFF">New Identification </font></th>
              </tr>
              <tr>
                <td width="35%" align="left" bordercolor="#0F57BB">Name</td>
                <td width="65%" align="left" bordercolor="#0F57BB">&nbsp;<input type="text" name="i_name" size="20"></td>
              </tr>
              <tr>
                <td width="35%" align="left" bordercolor="#0F57BB">Customer Type</td>
                <td width="65%" align="left" bordercolor="#0F57BB">&nbsp;<select size="1" name="cust_type">
                <option selected value="Personal">Personal</option>
                <option value="Non Personal">Non Personal</option>
                <option value="Both">Both</option>
                </select></td>
              </tr>
              <tr>
                <td width="35%" align="left" bordercolor="#0F57BB">
                Identification Type</td>
                <td width="65%" align="left" bordercolor="#0F57BB">&nbsp;<select size="1" name="id_type">
                <option selected value="Identification">Identification</option>
                <option value="Address">Address</option>
                </select></td>
              </tr>
              <tr>
                <td width="35%" align="left" bordercolor="#0F57BB">&nbsp;</td>
                <td width="65%" align="left" bordercolor="#0F57BB">&nbsp;</td>
              </tr>
              <tr>
                <td width="35%" align="left" bordercolor="#0F57BB">&nbsp;</td>
                <td width="65%" align="left" bordercolor="#0F57BB">
                <input type="submit" value="create Identification" name="B1" onclick="validate();">
                <input type="reset" value="Reset" name="B2"></td>
              </tr>
            </table>
            </form>
            </center>
          </div>
          <!-- handle the request for save changes edit Identification-->
	
	<%
    
	String edit_Iid=request.getParameter("edit_Iid");
	String edit_Iname=request.getParameter("edit_Iname");
	String edit_Ctype=request.getParameter("edit_Ctype");
	String edit_Itype=request.getParameter("edit_Itype");
	
	
	if((edit_Iid!=null && edit_Iid!=""))
	{
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("update Identification_type set identification_name=?,cust_type=?,identification_type=? where identification_type_id=?");
		stat.setString(1,edit_Iname);
		stat.setString(2,edit_Ctype);
		stat.setString(3,edit_Itype);
		stat.setString(4,edit_Iid);
		stat.executeUpdate();
		out.print("<h3><font color='#009933' face='Arial'>Identification Type Successfully updated</font></h3>");
		
		
		}
		catch(Exception E)
		{
			out.print("error updating values:"+E);
		}
		finally
		{
			conn.close();
		}
	}

		%>

	   
          
          
          <!-- handle the request for edit Identification Type-->
	<%
	String id_type_id=request.getParameter("id_type_id");
	if((id_type_id!=null && id_type_id!=""))
	{
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("select * from identification_type where identification_type_id=?");
		stat.setString(1,id_type_id);
		rs=stat.executeQuery();
		if(rs.next())
		{
		
		%>
		
		
		<table border="0" cellspacing="1" width="50%">
        <tr>
        <td width="100%">
        <form method="POST" name="editform" >
        <fieldset style="padding: 2">
        <legend align="left">Edit Identification</legend>
        <div align="center">

		<table border=0 style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="1" width="100%" >
			<tr>
			<td align="left" width="35%">Identification Type Id</td>
			<td align="left" width="65%">
            &nbsp;<input type ="text" name="edit_Iid" readonly="true" size="20" value="<%=rs.getString("identification_type_id")%>" style="background-color:#FFFFCC" >
            </td>
            </tr>			
			
			<tr>
			<td align="left" width="35%">Name</td>
			<td align="left" width="65%">
            &nbsp;<input type ="text" name="edit_Iname" size="20" value="<%=rs.getString("identification_name")%>" ></td>
            </tr>
			
			<tr>
			<td align="left" width="35%">Customer Type</td>
			<td align="left" width="65%">
            &nbsp;<select size="1" name="edit_Ctype">
              <option selected value="<%=rs.getString("cust_type")%>"><%=rs.getString("cust_type")%></option>
              <option value="Personal">Personal</option>
              <option value="Non Personal">Non Personal</option>
              <option value="Both">Both</option>

              </select>

            </td>
            </tr>
			
			<tr>
			<td align="left" width="35%">Identification Type</td>
			<td align="left" width="65%">
            &nbsp;<select size="1" name="edit_Itype">
              <option selected value="<%=rs.getString("identification_type")%>"><%=rs.getString("identification_type")%></option>
              <option value="Identification">Identification</option>
              <option value="Address">Address</option>
              </select>
            </td>
			</tr>

			<tr>
			<td width="35%" align="left">
			</td>
			<td align="left" width="65%">
			<input type="submit" value="save changes" onclick="validate1();" name="editb">
			<input type="reset" value="Reset">
			</tr>
					
		<%
		}
		%>
		
		</table>
		</div>
        </fieldset></form>
        </td>
        </tr>
        </table>

		<%
		}
		catch(Exception E)
		{
			out.print("error fetching values from database:"+E);
		}
		finally
		{
			rs.close();
			conn.close();
		}
	}
	
		
	%>

          
          
          
          <!--show the list of available Identification Type-->
          
          
		<p align="center"><font color="#000080" face="Arial"><b>List of 
        Available Identification Type Are </b></font></p>
        <table border="1" cellspacing="0" width="90%" bordercolor="#C0C0C0" bordercolorlight="#C0C0C0" bordercolordark="#C0C0C0" style="border-collapse: collapse" cellpadding="0">
            <tr>
              <th width="11%" bgcolor="#0F57BB">
              <font color="#FFFFFF">Identification Type Id</font></th>
              <th width="10%" bgcolor="#0F57BB">
              <font color="#FFFFFF">Identification Name</font></th>
              <th width="12%" bgcolor="#0F57BB">
              <font color="#FFFFFF">Customer Type</font></th>
              <th width="13%" bgcolor="#0F57BB">
              <font color="#FFFFFF">Identification Type</font></th>
              <th width="8%" bgcolor="#0F57BB">
              <font color="#FFFFFF">&nbsp;</font></th>

            </tr>
            
		<%
		
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat = conn.prepareStatement("select * from Identification_type");
		rs=stat.executeQuery();
		while(rs.next())
		{

		%>
            
            <tr>
              <td width="11%" align="left"><%=rs.getString("Identification_type_id")%>&nbsp;</td>
              <td width="10%" align="left"><%=rs.getString("identification_name")%>&nbsp;</td>
              <td width="12%" align="left"><%=rs.getString("cust_type")%>&nbsp;</td>
              <td width="13%" align="left"><%=rs.getString("identification_type")%>&nbsp;</td>
              <td width="6%" align="center">
            
            <form method ="post" action ="IdentificationType.jsp">
			<input type="hidden" name="id_type_id" value=<%=rs.getString("Identification_type_id")%> >
			<input type="submit" value="Edit    ">
			</form>	

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
         <p><font face="Arial" color="#000080"><b>End </b></font></p>
          </center>
        </div>
        </td>
      </tr>
    </table>
    
    </tr>
   
</table>
    
</td></tr>
<tr>
    <td><%@ include file="footer.html" %>
       
  </tr>
</table>
</body>

</html>