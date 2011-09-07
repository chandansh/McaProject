<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*"  %>
<html xmlns="http://www.w3.org/1999/xhtml">
<LINK href="leftnav.css" rel="stylesheet" type="text/css">
<LINK href="style.css" rel="stylesheet" type="text/css">
<head>
<script language="JavaScript">
function validate()
{
		if(document.branchfrm.b_name.value=="")
		{
  			alert("branch name cannot be blank!!");
  			document.branchfrm.b_name.value="";
			return;
  		}
  		if(document.branchfrm.b_address.value=="")
		{
  			alert("branch address cannot be blank!!");
  			document.branchfrm.b_name.value="";
			return;
  		}
  		if(document.branchfrm.b_city.value=="")
		{
  			alert("branch city cannot be blank!!");
  			document.branchfrm.b_name.value="";
			return;
  		}
  		if(document.branchfrm.b_state.value=="")
		{
  			alert("branch state cannot be blank!!");
  			document.branchfrm.b_name.value="";
			return;
  		}
  		

}


function validate1()
{
		if(document.editform.edit_bname.value=="")
		{
  			alert("branch name cannot be blank!!");
  			document.editform.edit_bid.value="";
  			return;
  		}
  		if(document.editform.edit_address.value=="")
		{
  			alert("branch address cannot be blank!!");
  			document.editform.edit_bid.value="";
			return;
  		}
  		if(document.editform.edit_city.value=="")
		{
  			alert("branch city cannot be blank!!");
  			document.editform.edit_bid.value="";
			return;
  		}
  		if(document.editform.edit_state.value=="")
		{
  			alert("branch state cannot be blank!!");
  			document.editform.edit_bid.value="";
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
    <tr><td align="center" height="30px" bgcolor="#E3E3FD">Branch</tr>
    <tr><td align="center" height="30px"><a href="NewUser.jsp">New user</a></tr>
    <tr><td align="center" height="30px"><a href="AccountType.jsp">Account Type</a></tr>
    <tr><td align="center" height="30px"><a href="IdentificationType.jsp">Identification Type</a></tr>
    <tr><td align="center" height="30px"><a href="UserAccessLog.jsp">User access Log</a></tr>
</table>

</td>
        <td valign="top" class="sbiback" height="402">
        <p align="center">
      
         <!-- handle the request for add new branch-->
        <%
        Connection conn;
		conn=null;
		ResultSet rs;
		rs=null;
		       
        String b_name=request.getParameter("b_name");
        String b_address=request.getParameter("b_address");
        String b_city=request.getParameter("b_city");
        String b_state=request.getParameter("b_state");
        String b_pin=request.getParameter("b_pin");

		if(b_name!=null && b_name!="")
        {
        try
		{
		conn = bean.getConnection(request);
		int b_id=(int)(10000*Math.random()+1);
		String ifs_code="sbi"+String.valueOf(b_id);
		PreparedStatement stat= conn.prepareStatement("insert into branch values(?,?,?,?,?,?,?)");
		stat.setString(1,String.valueOf(b_id));
		stat.setString(2,b_name);
		stat.setString(3,b_address);
		stat.setString(4,b_city);
		stat.setString(5,b_state);
		stat.setString(6,b_pin);
		stat.setString(7,ifs_code);
		stat.executeUpdate();
		//create necessary initial branch account for branch named (cash,comission,draft,interest etc)
		
		PreparedStatement acc_stat=conn.prepareStatement("insert into branch_account values(?,?,?,now(),?)");
		String acc_name[]={"Cash","Comission","Draft","Interest"};
		
		for(int i=0;i<acc_name.length;i++)
		{
		String acc_no="11"+String.valueOf(b_id)+String.valueOf((int)(10000*Math.random()+1));
		acc_stat.setString(1,acc_no);
		acc_stat.setString(2,acc_name[i]);
		acc_stat.setString(3,String.valueOf(b_id));
		acc_stat.setDouble(4,0.00D);
		acc_stat.addBatch();		
		}
		
		acc_stat.executeBatch();
		
		
		out.print("<font color='green'><b>new branch successfully created branch id :"+b_id+" and ifs code :"+ifs_code);
		out.println("<br>all the initial branch account also created</b></font>");
				
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
            <form name="branchfrm" method="post">
            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="49%">
              <tr>
                <th width="100%" colspan="2" bgcolor="#0F57BB" >
                <font color="#FFFFFF">New Branch</font></th>
              </tr>
              <tr>
                <td width="35%" align="left" bordercolor="#0F57BB">Branch Name</td>
                <td width="65%" align="left" bordercolor="#0F57BB">&nbsp;<input type="text" name="b_name" size="20"></td>
              </tr>
              <tr>
                <td width="35%" align="left" bordercolor="#0F57BB">Address</td>
                <td width="65%" align="left" bordercolor="#0F57BB">&nbsp;<input type="text" name="b_address" size="20"></td>
              </tr>
              <tr>
                <td width="35%" align="left" bordercolor="#0F57BB">City</td>
                <td width="65%" align="left" bordercolor="#0F57BB">&nbsp;<input type="text" name="b_city" size="20"></td>
              </tr>
              <tr>
                <td width="35%" align="left" bordercolor="#0F57BB">State</td>
                <td width="65%" align="left" bordercolor="#0F57BB">&nbsp;<input type="text" name="b_state" size="20"></td>
              </tr>
              <tr>
                <td width="35%" align="left" bordercolor="#0F57BB">Pin</td>
                <td width="65%" align="left" bordercolor="#0F57BB">&nbsp;<input type="text" name="b_pin" size="20"></td>
              </tr>
              <tr>
                <td width="35%" align="left" bordercolor="#0F57BB">&nbsp;</td>
                <td width="65%" align="left" bordercolor="#0F57BB">&nbsp;</td>
              </tr>
              <tr>
                <td width="35%" align="left" bordercolor="#0F57BB">&nbsp;</td>
                <td width="65%" align="left" bordercolor="#0F57BB">
                <input type="submit" value="create branch" name="B1" onclick="validate();">
                <input type="reset" value="Reset" name="B2"></td>
              </tr>
            </table>
            </form>
            </center>
          </div>
          <!-- handle the request for save changes edit Branch-->
	
	<%
    
	String edit_bid=request.getParameter("edit_bid");
	String edit_bname=request.getParameter("edit_bname");
	String edit_address=request.getParameter("edit_address");
	String edit_city=request.getParameter("edit_city");
	String edit_state=request.getParameter("edit_state");
	String edit_pin=request.getParameter("edit_pin");
	
	if((edit_bid!=null && edit_bid!=""))
	{
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("update branch set branch_name=?,address=?,city=?,state=?,pin=? where branch_id=?");
		stat.setString(1,edit_bname);
		stat.setString(2,edit_address);
		stat.setString(3,edit_city);
		stat.setString(4,edit_state);
		stat.setString(5,edit_pin);
		stat.setString(6,edit_bid);
		stat.executeUpdate();
		out.print("<h3><font color='#009933' face='Arial'>Branch Successfully updated</font></h3>");
		
		
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

	   
          
          
          <!-- handle the request for edit branch-->
	<%
	String b_id=request.getParameter("b_id");
	if((b_id!=null && b_id!=""))
	{
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("select * from branch where branch_id=?");
		stat.setString(1,b_id);
		rs=stat.executeQuery();
		if(rs.next())
		{
		
		%>
		
		
		<table border="0" cellspacing="1" width="50%">
        <tr>
        <td width="100%">
        <form method="POST" name="editform" >
        <fieldset style="padding: 2">
        <legend align="left">Edit branch</legend>
        <div align="center">

		<table border=0 style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="1" width="100%" >
			<tr>
			<td align="left" width="35%">Branch Id</td>
			<td align="left" width="65%">
            &nbsp;<input type ="text" name="edit_bid" readonly="true" size="20" value="<%=rs.getString("branch_id")%>" style="background-color:#FFFFCC" >
            </td>
            </tr>			
			
			<tr>
			<td align="left" width="35%">Branch Name</td>
			<td align="left" width="65%">
            &nbsp;<input type ="text" name="edit_bname" size="20" value="<%=rs.getString("branch_name")%>" ></td>
            </tr>
			
			<tr>
			<td align="left" width="35%">Address</td>
			<td align="left" width="65%">
            &nbsp;<input type ="text" name="edit_address" size="20" value="<%=rs.getString("address")%>" ></td>
            </tr>
			
			<tr>
			<td align="left" width="35%">City</td>
			<td align="left" width="65%">
            &nbsp;<input type ="text" name="edit_city" size="20" value="<%=rs.getString("city")%>" ></td>
			</tr>

			<tr>
			<td align="left" width="35%">State</td>
			<td align="left" width="65%">
            &nbsp;<input type ="text" name="edit_state" size="20" value="<%=rs.getString("state")%>" ></td>
			</tr>
			
			<tr>
			<td align="left" width="35%">Pin</td>
			<td align="left" width="65%">
            &nbsp;<input type ="text" name="edit_pin" size="20" value="<%=rs.getString("pin")%>" ></td>
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

          
          
          
          <!--show the list of available branch-->
          
          
		<p align="center"><font color="#000080" face="Arial"><b>List of 
        Available Branch Are </b></font></p>
        <table border="1" cellspacing="0" width="90%" bordercolor="#C0C0C0" bordercolorlight="#C0C0C0" bordercolordark="#C0C0C0" style="border-collapse: collapse" cellpadding="0">
            <tr>
              <th width="10%" bgcolor="#0F57BB">
              <font color="#FFFFFF">Branch Id</font></th>
              <th width="11%" bgcolor="#0F57BB">
              <font color="#FFFFFF">Name</font></th>
              <th width="12%" bgcolor="#0F57BB">
              <font color="#FFFFFF">IFS Code</font></th>
              <th width="13%" bgcolor="#0F57BB">
              <font color="#FFFFFF">Address</font></th>
              <th width="12%" bgcolor="#0F57BB">
              <font color="#FFFFFF">City</font></th>
              <th width="10%" bgcolor="#0F57BB">
              <font color="#FFFFFF">state</font></th>
              <th width="10%" bgcolor="#0F57BB">
              <font color="#FFFFFF">Pin</font></th>
              <th width="8%" bgcolor="#0F57BB">
              <font color="#FFFFFF">&nbsp;</font></th>

            </tr>
            
		<%
		
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat = conn.prepareStatement("select * from branch");
		rs=stat.executeQuery();
		while(rs.next())
		{

		%>
            
            <tr>
              <td width="10%" align="left"><%=rs.getString("branch_id")%>&nbsp;</td>
              <td width="11%" align="left"><%=rs.getString("branch_name")%>&nbsp;</td>
              <td width="12%" align="left"><%=rs.getString("ifs_code")%>&nbsp;</td>
              <td width="13%" align="left"><%=rs.getString("address")%>&nbsp;</td>
              <td width="12%" align="left"><%=rs.getString("city")%>&nbsp;</td>
              <td width="10%" align="left"><%=rs.getString("state")%>&nbsp;</td>
              <td width="10%" align="left"><%=rs.getString("pin")%>&nbsp;</td>
              <td width="6%" align="center">
            
            <form method ="post" action ="Branch.jsp">
			<input type="hidden" name="b_id" value=<%=rs.getString("branch_id")%> >
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