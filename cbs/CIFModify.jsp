<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*"  %>
<html xmlns="http://www.w3.org/1999/xhtml">
<LINK href="leftnav.css" rel="stylesheet" type="text/css">
<LINK href="style.css" rel="stylesheet" type="text/css">
<head>

<title>Officer Home Page</title>
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
	if (user_src!=null && user_type!=null && user_type.equals("Officer"))
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
    <tr><td align="center" height="30px"><a href="officer.jsp">Your Detail</a></tr>
    <tr><td align="center" height="30px"><a href="CIF.jsp">CIF</a></tr>
    <tr><td align="center" height="30px"><a href="CIFEnquiry.jsp">CIF Enquiry</a></tr>
    <tr><td align="center" height="30px" bgcolor="#E3E3FD">CIF Modify</tr>
    <tr><td align="center" height="30px"><a href="CreateAccount.jsp">Create Account</a></tr>
    <tr><td align="center" height="30px"><a href="MakeJointAccount.jsp">Make Joint Account</a></tr>
    <tr><td align="center" height="30px"><a href="AccountEnquiry.jsp">Account Enquiry</a></tr>
    <tr><td align="center" height="30px"><a href="IssueChequeBook.jsp">Issue ChequeBook</a></tr>
    <tr><td align="center" height="30px"><a href="StopCheque.jsp">Stop Cheque</a></tr>
    <tr><td align="center" height="30px"><a href="IssueATM.jsp">Issue ATM card</a></tr>

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

		<script type="text/javascript">
		function validate()
		{
			if(document.cifmodify.cif_no.value=="")
			{
			alert("please enter the cif no");
			return;
			}
		}
		</script>
        
        
        &nbsp;</p>
        <p align="center"><b><font face="Arial" color="#000080">Officer Page (</font></b><font face="Arial" color="#FF0000">you 
        can only modify you branch customer CIF </font><font face="Arial" color="#000080"><b>
        )</b></font></p>
        <div align="center">
          <center>
          <%
   			//show the confirmation          
   			String msg=request.getParameter("msg");
   			if(msg!=null && msg!="")
  			{
   			out.print(msg);
   			}
   			//out.print("hello"+msg);
   
  %>

          <form name="cifmodify" method="post">
          <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="50%">
            <tr>
              <td width="100%" bordercolor="#0F57BB" colspan="2" bgcolor="#0F57BB" align="center">
              <b><font color="#FFFFFF">CIF Modify</font></b></td>
            </tr>
            <tr>
              <td width="44%" align="left">Enter the CIF number</td>
              <td width="56%" align="left">
              <input type="text" name="cif_no" size="21"></td>
            </tr>
            <tr>
              <td width="44%" align="left">Modification Type</td>
              <td width="56%" align="left"><select size="1" name="mod_type">
              <option selected value="Name Modification">Name Modification</option>
              <option value="Address Modification">Address Modification</option>
              <option value="Change Photo">Change Photo</option>
              <option value="Change Sign">Change Sign</option>
              </select></td>
            </tr>
            <tr>
              <td width="44%" align="left">&nbsp;</td>
              <td width="56%" align="left">
              <input type="submit" value="Transmit" name="B1" onclick="validate();"></td>
            </tr>
            <tr>
              <td width="44%" align="left">&nbsp;</td>
              <td width="56%" align="left">&nbsp;</td>
            </tr>
          </table>
          </form>
          <br>
          <%
          String mod_cif=request.getParameter("cif_no");
          String mod_type=request.getParameter("mod_type");
          if(mod_cif!=null && mod_cif!="" && mod_type!=null && mod_type!="")
          {
          	try
          	{
          		conn=bean.getConnection(request);
          		PreparedStatement stat=conn.prepareStatement("select * from customer_info_table where cif_number=? and branch_id=?");
          		stat.setString(1,mod_cif);
          		stat.setString(2,branch);
          		rs=stat.executeQuery();
          		if(!rs.next())
          		{
          		out.print("<font color='red' face='Arial'><b>CIF not found</b></font>");
          		}
          		else
          		{
          			if(mod_type.equals("Name Modification") && rs.getString("cust_type").equals("Personal"))
          			{
          			%>
          			<script type="text/javascript">
          			function validatefrm()
          			{
          				if(document.namemodify.first_name.value=="")
          				{
          				alert("first name should not be blank");
          				return;
          				}
          				
						if(document.namemodify.relation_name.value=="")
          				{
          				alert("relation name should not be blank");
          				return;
						}
	
          			document.namemodify.action="CIFModifydo.jsp"
          			}
          			</script>
          <form  method="post" name="namemodify">			
          <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="60%">
            <tr>
              <td width="100%" colspan="2" bgcolor="#0F57BB" bordercolor="#0000FF" align="center">
              <font color="#FFFFFF"><b>Name Modification 
              Personal Customer</b></font></td>
            </tr>
            <tr>
              <td width="50%" align="left">CIF Number</td>
              <td width="50%" align="left">&nbsp;<%=rs.getString("cif_number")%>
              <input type="hidden" value="<%=rs.getString("cif_number")%>" name="p_N_ModifyCIF">
              
              </td>
              
            </tr>
            <tr>
              <td width="50%" align="left">Title</td>
              <td width="50%" align="left"><select size="1" name="title">
                        <option selected value="<%=rs.getString("title")%>"><%=rs.getString("title")%></option>
                        <option value="Mr">Mr</option>
                        <option value="Mrs">Mrs</option>
                        <option value="Sri">Sri</option>
                        <option value="Smt">Smt</option>
                        <option value="Dr">Dr</option>
                        </select></td>
            </tr>
            <tr>
              <td width="50%" align="left">First Name</td>
              <td width="50%" align="left"><input type="text" name="first_name" size="20" value="<%=rs.getString("first_name_business_name")%>"></td>
            </tr>
            <tr>
              <td width="50%" align="left">Middle Name</td>
              <td width="50%" align="left"><input type="text" name="middle_name" size="20" value="<%=rs.getString("middle_name")%>"></td>
            </tr>
            <tr>
              <td width="50%" align="left">Last Name</td>
              <td width="50%" align="left"><input type="text" name="last_name" size="20" value="<%=rs.getString("last_name")%>"></td>
            </tr>
            <tr>
              <td width="50%" align="left">Relation</td>
              <td width="50%" align="left"><select size="1" name="relation">
                        <option selected value="<%=rs.getString("relation")%>"><%=rs.getString("relation")%></option>
                        <option value="Father">Father</option>
                        <option value="Mother">Mother</option>
                        <option value="Husband">Husband</option>
                        <option value="Guardian">Guardian</option>
                        </select></td>
            </tr>
            <tr>
              <td width="50%" align="left">Relation Name</td>
              <td width="50%" align="left"><input type="text" name="relation_name" size="20" value="<%=rs.getString("relation_name")%>"></td>
            </tr>
            <tr>
              <td width="50%" align="left">&nbsp;</td>
              <td width="50%" align="left"><input type="submit" value="Modify" name="B1" onclick="validatefrm();">
              <input type="reset" value="Reset" name="B2"></td>
            </tr>
            <tr>
              <td width="50%" align="left">&nbsp;</td>
              <td width="50%" align="left">&nbsp;</td>
            </tr>
          </table>
          </form>
          
			<%
          			}//end of if name modification personal
          			if(mod_type.equals("Name Modification") && rs.getString("cust_type").equals("Non Personal"))
          			{
          			%>
          			<script type="text/javascript">
          			function validatefrm1()
          			{
          				if(document.namemodifyNonP.business_name.value=="")
          				{
          				alert("business name should not be blank");
          				return;
          				}
          				if(document.namemodifyNonP.relation_name.value=="")
          				{
          				alert("relation name should not be blank");
          				return;
						}
						
          			document.namemodifyNonP.action="CIFModifydo.jsp"
          			}
          			</script>

          <form method="post" name="namemodifyNonP">			
          <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="60%">
            <tr>
              <td width="100%" colspan="2" bgcolor="#0F57BB" bordercolor="#0000FF" align="center">
              <font color="#FFFFFF"><b>Name Modification Non 
              Personal Customer</b></font></td>
              

            </tr>
                          
            <tr>
              <td width="50%" align="left">CIF Number</td>
              <td width="50%" align="left">&nbsp;<%=rs.getString("cif_number")%>
              <input type="hidden" value="<%=rs.getString("cif_number")%>" name="np_N_ModifyCIF">
              
            </tr>
            
            <tr>
              <td width="50%" align="left">Business Name</td>
              <td width="50%" align="left"><input type="text" name="business_name" size="20" value="<%=rs.getString("first_name_business_name")%>"></td>
            </tr>
            
            <tr>
              <td width="50%" align="left">Relation</td>
              <td width="50%" align="left"><select size="1" name="relation">
                        <option selected value="<%=rs.getString("relation")%>"><%=rs.getString("relation")%></option>
                        <option value="Owner">Owner</option>
                        <option value="CEO">CEO</option>
                        <option value="MD">MD</option>
                        </select></td>
            </tr>
            <tr>
              <td width="50%" align="left">Relation Name</td>
              <td width="50%" align="left"><input type="text" name="relation_name" size="20" value="<%=rs.getString("relation_name")%>"></td>
            </tr>
            <tr>
              <td width="50%" align="left">&nbsp;</td>
              <td width="50%" align="left"><input type="submit" value="Modify" name="B1" onclick="validatefrm1();">
              <input type="reset" value="Reset" name="B2"></td>
            </tr>
            <tr>
              <td width="50%" align="left">&nbsp;</td>
              <td width="50%" align="left">&nbsp;</td>
            </tr>
          </table>
          </form>
			<%
          			}//end of if name modification Non personal
					if(mod_type.equals("Address Modification"))
					{
					%>
					<script type="text/javascript">
          			function validatefrm2()
          			{
          				if(document.addmodify.address.value=="")
          				{
          				alert("address should not be blank");
          				return;
          				}
          				if(document.addmodify.city.value=="")
          				{
          				alert("city  should not be blank");
          				return;
						}
						if(document.addmodify.state.value=="")
          				{
          				alert("state should not be blank");
          				return;
						}
						if(document.addmodify.pincode.value=="")
          				{
          				alert("pincode should not be blank");
          				return;
						}
						if(document.addmodify.country.value=="")
          				{
          				alert("country name should not be blank");
          				return;
						}

	
          			document.addmodify.action="CIFModifydo.jsp"
          			}
          			</script>

		  <form method="post" name="addmodify">			
          <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="60%">
            <tr>
              <td width="100%" colspan="2" bgcolor="#0F57BB" bordercolor="#0000FF" align="center">
              <font color="#FFFFFF"><b>Address Modification</b></font></td>
              

            </tr>
                          
            <tr>
              <td width="50%" align="left">CIF Number</td>
              <td width="50%" align="left">&nbsp;<%=rs.getString("cif_number")%>
              <input type="hidden" value="<%=rs.getString("cif_number")%>" name="A_ModifyCIF">
              
            </tr>
            
            <tr>
              <td width="50%" align="left">Address</td>
              <td width="50%" align="left">
              <input type="text" name="address" size="20" value="<%=rs.getString("address")%>"></td>
            </tr>
            
            <tr>
              <td width="50%" align="left">City</td>
              <td width="50%" align="left">
              <input type="text" name="city" size="20" value="<%=rs.getString("city")%>"></td>
            </tr>
            <tr>
              <td width="50%" align="left">Pin code</td>
              <td width="50%" align="left">
              <input type="text" name="pincode" size="20" value="<%=rs.getString("pin_code")%>"></td>
            </tr>
            <tr>
              <td width="50%" align="left">State</td>
              <td width="50%" align="left">
              <input type="text" name="state" size="20" value="<%=rs.getString("state")%>"></td>
            </tr>
            <tr>
              <td width="50%" align="left">Country</td>
              <td width="50%" align="left">
              <input type="text" name="country" size="20" value="<%=rs.getString("country")%>"></td>
            </tr>
            <tr>
              <td width="50%" align="left">&nbsp;</td>
              <td width="50%" align="left"><input type="submit" value="Modify" name="B1" onclick="validatefrm2();">
              <input type="reset" value="Reset" name="B2"></td>
            </tr>
            <tr>
              <td width="50%" align="left">&nbsp;</td>
              <td width="50%" align="left">&nbsp;</td>
            </tr>
          </table>
          </form>
					
		<%
		}//end of address modify
        if(mod_type.equals("Change Photo") && !rs.getString("cust_type").equals("Nominee"))
        {
          %>
          <script type="text/javascript">
          function validate3()
          {
          	if(document.photomodify.photo.value=="")
          	{
          	alert("please select photo");
          	return;
          	}
          	document.photomodify.action="CIFPhotoSignModify.jsp";
          }
          </script>
          <form  method="post" name="photomodify" enctype="multipart/form-data">			
              
          <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="60%">
            <tr>
              <td width="100%" colspan="2" bgcolor="#0F57BB" bordercolor="#0000FF" align="center">
            <font color="#FFFFFF"><b>Photo Modification 
              </b></font></td>
            </tr>
            <tr>
              <td width="50%" align="left">CIF Number</td>
              <td width="50%" align="left">&nbsp;<%=rs.getString("cif_number")%>
              <input type="hidden" value="<%=rs.getString("cif_number")%>" name="photo_modify_cif">
              </td>
              
            </tr>
            <tr>
              <td width="50%" align="left">First Name/Business Name</td>
              <td width="50%" align="left">&nbsp;<%=rs.getString("first_name_business_name")%></td>
              
            </tr>
            <tr>
              <td width="50%" align="left">select Photo</td>
              <td width="50%" align="left">
              <input type="file" name="modphoto" size="20"></td>
              
            </tr>
            <tr>
              <td width="50%" align="left">&nbsp;</td>
              <td width="50%" align="left">
              <input type="submit" value="modify" name="B1" onclick="validate3();"></td>
              
            </tr>
            <tr>
              <td width="50%" align="left">&nbsp;</td>
              <td width="50%" align="left">&nbsp;</td>
              
            </tr>
            </table>
            </form>

          			<%
          			}//end of change photo
          			
          if(mod_type.equals("Change Sign") && !rs.getString("cust_type").equals("Nominee"))
        {
          %>
          <script type="text/javascript">
          function validate4()
          {
          	if(document.photomodify.sign.value=="")
          	{
          	alert("please select sign file");
          	return;
          	}
          	document.signmodify.action="CIFPhotoSignModify.jsp";
          }
          </script>
          <form  method="post" name="signmodify" enctype="multipart/form-data">			
              
          <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="60%">
            <tr>
              <td width="100%" colspan="2" bgcolor="#0F57BB" bordercolor="#0000FF" align="center">
              <font color="#FFFFFF"><b>Sign Modification 
              </b></font></td>
            </tr>
            <tr>
              <td width="50%" align="left">CIF Number</td>
              <td width="50%" align="left">&nbsp;<%=rs.getString("cif_number")%>
              <input type="hidden" value="<%=rs.getString("cif_number")%>" name="sign_modify_cif">
              </td>
              
            </tr>
            <tr>
              <td width="50%" align="left">First Name/Business Name</td>
              <td width="50%" align="left">&nbsp;<%=rs.getString("first_name_business_name")%></td>
              
            </tr>
            <tr>
              <td width="50%" align="left">select sign file</td>
              <td width="50%" align="left">
              <input type="file" name="modsign" size="20"></td>
              
            </tr>
            <tr>
              <td width="50%" align="left">&nbsp;</td>
              <td width="50%" align="left">
              <input type="submit" value="modify" name="B1" onclick="validate4();"></td>
              
            </tr>
            <tr>
              <td width="50%" align="left">&nbsp;</td>
              <td width="50%" align="left">&nbsp;</td>
              
            </tr>
            </table>
            </form>

          			<%
          			}//end of change sign
		
          		}//end of else
          	}//end of try
          	catch(Exception e)
          	{
          		out.print("Error : "+e);
          	}
          	finally
          	{
          	conn.close();
          	}
          
          
          
          }//end of if 
          %>
          
          
          
          
&nbsp;<p><font face="Arial" color="#000080"><b>End </b></font></p>
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