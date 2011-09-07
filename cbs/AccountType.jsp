<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*"  %>
<html xmlns="http://www.w3.org/1999/xhtml">
<LINK href="leftnav.css" rel="stylesheet" type="text/css">
<LINK href="style.css" rel="stylesheet" type="text/css">
<head>
<script language="JavaScript">
function validate()
{
		if(document.acctypefrm.acc_type_id.value=="")
		{
  			alert("Account type id cannot be blank!!");
  			document.acctypefrm.acc_type_id.value="";
			return;
  		}
  		if(document.acctypefrm.name.value=="")
		{
  			alert("Account type name cannot be blank!!");
  			document.acctypefrm.acc_type_id.value="";
			return;
  		}
  		if(document.acctypefrm.min_bal.value=="")
		{
  			alert("min balance cannot be blank!!");
  			document.acctypefrm.acc_type_id.value="";
			return;
  		}
  		if(document.acctypefrm.interest.value=="")
		{
  			alert("interest cannot be blank!!");
  			document.acctypefrm.acc_type_id.value="";
			return;
  		}
  		if(isNaN(document.acctypefrm.interest.value)==true)
		{
  			alert("interest must benumeric value!!");
  			document.acctypefrm.acc_type_id.value="";
			return;
  		}
  		if(isNaN(document.acctypefrm.min_bal.value)==true)
		{
  			alert("minimum balance must benumeric value!!");
  			document.acctypefrm.acc_type_id.value="";
			return;
  		}


  		

}


function validate1()
{
		if(document.editform.edit_aname.value=="")
		{
  			alert(" name cannot be blank!!");
  			document.editform.edit_acc_t_id.value="";
  			return;
  		}
  		if(document.editform.edit_min_bal.value=="")
		{
  			alert(" minimum balance cannot be blank!!");
  			document.editform.edit_acc_t_id.value="";
  			return;
  		}
  		if(document.editform.edit_interest.value=="")
		{
  			alert("interest cannot be blank!!");
  			document.editform.edit_acc_t_id.value="";
  			return;
  		}
  		if(isNaN(document.editform.edit_interest.value)==true)
		{
  			alert("interest must be numeric value!!");
  			document.editform.edit_acc_t_id.value="";
  			return;
  		}
  		if(isNaN(document.editform.edit_min_bal.value)==true)
		{
  			alert("minimum balance must be numeric value!!");
  			document.editform.edit_acc_t_id.value="";
  			return;
  		}


  		
  		

}

</script>

<title>Administrator Home Page</title>
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
	
        Connection conn;
		conn=null;
		ResultSet rs;
		rs=null;
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("select initial_pass_changed from user_table where user_id=?");
		stat.setString(1,user_src);
		rs = stat.executeQuery();
		
		if(rs.next() && rs.getBoolean("initial_pass_changed")!=true)	
		{
		response.sendRedirect("InitialPassChange.jsp");
		}
		
		}
		catch(Exception E)
		{
			out.print("error:"+E);
		}
		finally
		{
			rs.close();
			conn.close();
		}

		%>

</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="logout.jsp"><img src="images/logout.png" border="0" width="100" height="34"/></a></div>
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
    <tr><td align="center" height="30px"><a href="admin.jsp">Your Detail</a></li>
    <tr><td align="center" height="30px"><a href="Branch.jsp">Branch</a></tr>
    <tr><td align="center" height="30px"><a href="NewUser.jsp">New User</a></tr>
    <tr><td align="center" height="30px" bgcolor="#E3E3FD">Account Type</tr>
    <tr><td align="center" height="30px"><a href="IdentificationType.jsp">Identification Type</a></tr>
    <tr><td align="center" height="30px"><a href="UserAccessLog.jsp">User access Log</a></tr>
</table>

</td>
        <td valign="top" class="sbiback" height="402">
        <p align="center">
        <%
        try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("select max(logout_date_time)as last_login from user_access_log where user_id=?");
		stat.setString(1,user_src);
		rs = stat.executeQuery();
		
		if(rs.next() && rs.getString("last_login")!=null)	
		{
		out.print("<font color='green'>your last login date time:"+rs.getString("last_login")+"</font>");
		}
		else
		{
		out.print("<font color='red'>this is your first time login with this user Id please change your password"+"</font>");
		}
		}
		catch(Exception E)
		{
			out.print("error:"+E);
		}
		finally
		{
			rs.close();
			conn.close();
		}

		%>



 		
         <p align="center"><b><font color="#000080" face="Arial">Administrator Page</font></b></p>
        <div align="center">
          <center>
          <div align="center">
            <center>
   
            
            
             <!-- handle the request for save changes edit Account Type-->
	
	<%
    
	String edit_acc_t_id=request.getParameter("edit_acc_t_id");
	String edit_aname=request.getParameter("edit_aname");
	String edit_min_bal=request.getParameter("edit_min_bal");
	String edit_interest=request.getParameter("edit_interest");
	
	
	if((edit_acc_t_id!=null && edit_acc_t_id!=""))
	{
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("update account_type set name=?,minimum_balance=?,interest_rate=? where account_type_id=?");
		stat.setString(1,edit_aname);
		stat.setString(2,edit_min_bal);
		stat.setString(3,edit_interest);
		stat.setString(4,edit_acc_t_id);
		stat.executeUpdate();
		out.print("<h3><font color='#009933' face='Arial'>Account Type Successfully updated</font></h3>");
		
		
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

            
            <!-- handle the request for edit Account Type-->
            
	<%
	String acc_t_id=request.getParameter("acc_t_id");
	if((acc_t_id!=null && acc_t_id!=""))
	{
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("select * from Account_type where account_type_id=?");
		stat.setString(1,acc_t_id);
		rs=stat.executeQuery();
		if(rs.next())
		{
		
		%>
		
		
		<table border="0" cellspacing="1" width="50%">
        <tr>
        <td width="100%">
        <form method="POST" name="editform" >
        <fieldset style="padding: 2">
        <legend align="left">Edit Account type</legend>
        <div align="center">

		<table border=0 style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="1" width="100%" >
			<tr>
			<td align="left" width="35%">Account Type Id</td>
			<td align="left" width="65%">
            &nbsp;<input type ="text" name="edit_acc_t_id" readonly="true" size="20" value="<%=rs.getString("Account_type_id")%>" style="background-color:#FFFFCC" >
            </td>
            </tr>			
			
			<tr>
			<td align="left" width="35%">Account Type Name</td>
			<td align="left" width="65%">
            &nbsp;<input type ="text" name="edit_aname" size="20" value="<%=rs.getString("name")%>" ></td>
            </tr>
			
			<tr>
			<td align="left" width="35%">Minimum balance</td>
			<td align="left" width="65%">
            &nbsp;<input type ="text" name="edit_min_bal" size="20" value="<%=rs.getString("minimum_balance")%>" ></td>
            </tr>
			
			<tr>
			<td align="left" width="35%">Interest Rate</td>
			<td align="left" width="65%">
            &nbsp;<input type ="text" name="edit_interest" size="20" value="<%=rs.getString("interest_rate")%>" ></td>
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

          
          
          

            
            
            
            
            
            
            <!--show the list of available Account Type-->
          
          
		<p align="center"><font color="#000080" face="Arial"><b>List of 
        Available Account Type Are </b></font></p>
        <table border="1" cellspacing="0" width="941" bordercolor="#C0C0C0" bordercolorlight="#C0C0C0" bordercolordark="#C0C0C0" style="border-collapse: collapse" cellpadding="0">
            <tr>
              <th width="170" bgcolor="#0F57BB">
              <font color="#FFFFFF">Account Type Id</font></th>
              <th width="200" bgcolor="#0F57BB">
              <font color="#FFFFFF">Account Type Name</font></th>
              <th width="188" bgcolor="#0F57BB">
              <font color="#FFFFFF">Minimum Balance</font></th>
              <th width="150" bgcolor="#0F57BB">
              <font color="#FFFFFF">Interest Rate</font></th>
              <th width="110" bgcolor="#0F57BB">
              <font color="#FFFFFF">&nbsp;</font></th>
			  


            </tr>
            
		<%
		
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat = conn.prepareStatement("select * from account_type");
		rs=stat.executeQuery();
		while(rs.next())
		{

		%>
            
            <tr>
              <td width="170" align="left"><%=rs.getString("account_type_id")%>&nbsp;</td>
              <td width="200" align="left"><%=rs.getString("name")%>&nbsp;</td>
              <td width="188" align="left"><%=rs.getString("minimum_balance")%>&nbsp;</td>
              <td width="150" align="left"><%=rs.getString("interest_rate")%>&nbsp;</td>
              
              <td width="110" align="center">
            
            <form method ="post" action ="AccountType.jsp">
			<input type="hidden" name="acc_t_id" value=<%=rs.getString("account_type_id")%> >
			<input type="submit" value="Edit    ">
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