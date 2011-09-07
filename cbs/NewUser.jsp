<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*"  %>
<html xmlns="http://www.w3.org/1999/xhtml">
<LINK href="leftnav.css" rel="stylesheet" type="text/css">
<LINK href="style.css" rel="stylesheet" type="text/css">
<head>
<script language="JavaScript">
function validate()
{
		if(document.userfrm.b_id.value=="")
		{
  			alert("branch Id cannot be blank!!");
  			document.userfrm.b_id.value="";
			return;
  		}
  		if(document.userfrm.s_s_id.value=="")
		{
  			alert("staff service Id cannot be blank!!");
  			document.userfrm.b_id.value="";
			return;
  		}
  		if(document.userfrm.firstname.value=="")
		{
  			alert("first name cannot be blank!!");
  			document.userfrm.b_id.value="";
			return;
  		}
  		if(document.userfrm.user_type.value=="")
		{
  			alert("please select user type!!");
  			document.userfrm.b_id.value="";
			return;
  		}
  		

}

function validate1()
{
	if(document.frmforedit.id.value=="")
	{
	alert("staff Id or User Id can not be blank");
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
    <tr><td align="center" height="30px" bgcolor="#E3E3FD">New user</tr>
    <tr><td align="center" height="30px"><a href="AccountType.jsp">Account Type</a></tr>
    <tr><td align="center" height="30px"><a href="IdentificationType.jsp">Identification Type</a></tr>
    <tr><td align="center" height="30px"><a href="UserAccessLog.jsp">User access Log</a></tr>
</table>

</td>
        <td valign="top" class="sbiback" height="402">
        <p align="center">
        <%
        Connection conn;
		conn=null;
		ResultSet rs;
		rs=null;
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

         <!-- handle the request for add new user-->
        <%
        		       
        String b_id=request.getParameter("b_id");
        String s_s_id=request.getParameter("s_s_id");
        String firstname=request.getParameter("firstname");
        String lastname=request.getParameter("lastname");
        String user_type1=request.getParameter("user_type");

		if(b_id!=null && b_id!="")
        {
        try
		{	
			conn = bean.getConnection(request);
			PreparedStatement stat2=conn.prepareStatement("select * from user_table where staff_service_id=?");
			stat2.setString(1,s_s_id);
			ResultSet rs1=stat2.executeQuery();
			if(!rs1.next())
			{
				PreparedStatement stat= conn.prepareStatement("select * from branch where branch_id=?");
				stat.setString(1,b_id);
				rs = stat.executeQuery();
				if(rs.next())	
				{
					int u_id=(int)(10000*Math.random()+1);
					int u_password=(int)(10000*Math.random()+1);
					PreparedStatement stat1= conn.prepareStatement("insert into user_table values(?,?,?,?,?,?,?,?)");
					stat1.setString(1,String.valueOf(u_id));
					stat1.setString(2,b_id);
					stat1.setString(3,s_s_id);
					stat1.setString(4,firstname);
					stat1.setString(5,lastname);
					stat1.setString(6,String.valueOf(u_password));
					stat1.setString(7,user_type1);
					stat1.setBoolean(8,false);
					stat1.executeUpdate();
					out.print("<br><font color='green'><b>new user successfully created user id :"+u_id+" and password :"+u_password+"</b></font>");
				}
				else
				{
					out.print("<br><b><font color='red'>Branch Id not Exist</font></b>");
				}
			}
			else
			{
				out.print("<br><b><font color='red'>Staff Service Id already Exist</font></b>");
			}
				
				
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
          <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="50%">
            <tr>
              <td width="100%">
              <form method="POST" name="userfrm">
              <fieldset style="padding: 2">
                <legend>New User</legend>
                <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
                  <tr>
                    <td width="37%" align="left">Branch ID</td>
                    <td width="63%" align="left">
                    <input type="text" name="b_id" size="20"></td>
                  </tr>
                  <tr>
                    <td width="37%" align="left">Staff Service Id</td>
                    <td width="63%" align="left">
                    <input type="text" name="s_s_id" size="20"></td>
                  </tr>
                  <tr>
                    <td width="37%" align="left">First Name</td>
                    <td width="63%" align="left">
                    <input type="text" name="firstname" size="20"></td>
                  </tr>
                  <tr>
                    <td width="37%" align="left">Last Name</td>
                    <td width="63%" align="left">
                    <input type="text" name="lastname" size="20"></td>
                  </tr>
                  <tr>
                    <td width="37%" align="left">User Type</td>
                    <td width="63%" align="left">
                    <select size="1" name="user_type">
                    <option selected value="">select user type</option>
                    <option value="Administrator">Administrator</option>
                    <option value="Officer">Officer</option>
                    <option value="Clerk">Clerk</option>
                    </select></td>
                  </tr>
                  <tr>
                    <td width="37%" align="left">&nbsp;</td>
                    <td width="63%" align="left">
                    <input type="submit" value="Create User" name="B1" onclick="validate();">
                    <input type="reset" value="Reset" name="B2"></td>
                  </tr>
                </table>
                </fieldset></form>
              </td>
            </tr>
          </table>
          <p>&nbsp;</p>
          <div align="center">
            <center>
            
            <!--form for Find the User -->
            <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="50%">
              <tr>
                <td width="100%">
                <form method="POST" name="frmforedit">
                 <fieldset style="padding: 2">
                  <legend>Find User</legend>
                  <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
                    <tr>
                      <td width="37%" align="left">Enter User Id Or Staff Service Id</td>
                      <td width="63%" align="left"><input type="text" name="u_or_s_id" size="20"></td>
                    </tr>
                    <tr>
                      <td width="37%" align="left">&nbsp;</td>
                      <td width="63%" align="left">
                      <input type="submit" value="Submit" name="B1" onclick="validate1();">
                      <input type="reset" value="Reset" name="B2"></td>
                    </tr>
                  </table>
                  </fieldset></form>
                </td>
              </tr>
            </table>
            </center>
          </div>
          </center>
        </div>
        <div align="center">
          <center>
          
          <!-- handle the request for save changes edit User-->
	
	<%
    
	String edit_uid=request.getParameter("edit_uid");
	String edit_bid=request.getParameter("edit_bid");
	String edit_firstname=request.getParameter("edit_firstname");
	String edit_lastname=request.getParameter("edit_lastname");
	String edit_user_type=request.getParameter("edit_user_type");
	
	
	if((edit_uid!=null && edit_uid!=""))
	{
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("update user_table set branch_id=?,firstname=?,lastname=?,user_type=? where user_id=?");
		stat.setString(1,edit_bid);
		stat.setString(2,edit_firstname);
		stat.setString(3,edit_lastname);
		stat.setString(4,edit_user_type);
		stat.setString(5,edit_uid);
		stat.executeUpdate();
		out.print("<h3><font color='#009933' face='Arial'>User Successfully updated</font></h3>");
		
		
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

	   

          
            <!-- handle the request for edit User-->
	<%
	String edit_u_id=request.getParameter("edit_u_id");
	if((edit_u_id!=null && edit_u_id!=""))
	{
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("select * from user_table where user_id=?");
		stat.setString(1,edit_u_id);
		rs=stat.executeQuery();
		if(rs.next())
		{
		
		%>
		
		
		<table border="0" cellspacing="1" width="50%">
        <tr>
        <td width="100%">
        <form method="POST" name="editform" >
        <fieldset style="padding: 2">
        <legend align="left">Edit user</legend>
        <div align="center">

		<table border=0 style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="1" width="100%" >
			<tr>
			<td align="left" width="37%">User Id</td>
			<td align="left" width="63%">
            <input type ="text" name="edit_uid" readonly="true" size="20" value="<%=rs.getString("user_id")%>" style="background-color:#FFFFCC" >
            </td>
            </tr>			
			
			<tr>
			<td align="left" width="37%">Branch Id</td>
			<td align="left" width="63%">
            <input type ="text" name="edit_bid" size="20" value="<%=rs.getString("branch_id")%>" ></td>
            </tr>
			
			<tr>
			<td align="left" width="37%">Staff Service Id</td>
			<td align="left" width="63%">
            <input type ="text" name="edit_s_s_id" readonly="true" size="20" value="<%=rs.getString("staff_service_id")%>" style="background-color:#FFFFCC" >
            </td>
            </tr>
			
			<tr>
			<td align="left" width="37%">First Name</td>
			<td align="left" width="63%">
            <input type ="text" name="edit_firstname" size="20" value="<%=rs.getString("firstname")%>" ></td>
			</tr>

			<tr>
			<td align="left" width="37%">Last Name</td>
			<td align="left" width="63%">
            <input type ="text" name="edit_lastname" size="20" value="<%=rs.getString("lastname")%>" ></td>
			</tr>
			
			<tr>
			<td align="left" width="37%">User Type</td>
			<td align="left" width="63%">
            <select size="1" name="edit_user_type">
              <option selected value="<%=rs.getString("user_type")%>"><%=rs.getString("user_type")%></option>
              		<option value="Administrator">Administrator</option>
                    <option value="Officer">Officer</option>
                    <option value="Clerk">Clerk</option>
              </select></td>
			</tr>

			<tr>
			<td width="37%" align="left">
			</td>
			<td align="left" width="63%">
			<input type="submit" value="save changes" onclick="validate2();" name="editb">
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

          
          
          
          
          
          
          
          
          
          
          
          
          
          
           <!--show the list of user of entered user Id-->
          
          
		
            
		<%
		String u_or_s_id=request.getParameter("u_or_s_id");
		if(u_or_s_id!=null && u_or_s_id!="")
		{
		%>
		<p align="center"><font color="#000080" face="Arial"><b>List of 
        Entered User of this user id Or service Id </b></font></p>
        <table border="1" cellspacing="0" width="90%" bordercolor="#C0C0C0" bordercolorlight="#C0C0C0" bordercolordark="#C0C0C0" style="border-collapse: collapse" cellpadding="0">
            <tr>
              <th width="10%" bgcolor="#0F57BB">
              <font color="#FFFFFF">User Id</font></th>
              <th width="10%" bgcolor="#0F57BB">
              <font color="#FFFFFF">Branch Id</font></th>
              <th width="13%" bgcolor="#0F57BB">
              <font color="#FFFFFF">Staff Service Id</font></th>
              <th width="13%" bgcolor="#0F57BB">
              <font color="#FFFFFF">First Name</font></th>
              <th width="12%" bgcolor="#0F57BB">
              <font color="#FFFFFF">Last Name</font></th>
              <th width="10%" bgcolor="#0F57BB">
              <font color="#FFFFFF">User Type</font></th>
              <th width="8%" bgcolor="#0F57BB">
              <font color="#FFFFFF">&nbsp;</font></th>

            </tr>
		<%
			try
			{
			conn = bean.getConnection(request);
			PreparedStatement stat = conn.prepareStatement("select * from user_table where user_id=? or staff_service_id=?");
			stat.setString(1,u_or_s_id);
			stat.setString(2,u_or_s_id);
			rs=stat.executeQuery();
			while(rs.next())
			{

			%>
            
            <tr>
              <td width="10%" align="left"><%=rs.getString("user_id")%>&nbsp;</td>
              <td width="10%" align="left"><%=rs.getString("branch_id")%>&nbsp;</td>
              <td width="13%" align="left"><%=rs.getString("staff_service_id")%>&nbsp;</td>
              <td width="13%" align="left"><%=rs.getString("firstname")%>&nbsp;</td>
              <td width="12%" align="left"><%=rs.getString("lastname")%>&nbsp;</td>
              <td width="10%" align="left"><%=rs.getString("user_type")%>&nbsp;</td>
              <td width="6%" align="center">
            
            <form method ="post" action ="NewUser.jsp">
			<input type="hidden" name="edit_u_id" value=<%=rs.getString("user_id")%> >
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
		<%
		}// end of If

		%>

         

          
          
          
         
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