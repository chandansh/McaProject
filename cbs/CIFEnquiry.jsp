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
    <tr><td align="center" height="30px" bgcolor="#E3E3FD">CIF Enquiry</tr>
    <tr><td align="center" height="30px"><a href="CIFModify.jsp">CIF Modify</a></tr>
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

        
        
        &nbsp;</p>
        <p align="center"><b><font face="Arial" color="#000080">Officer Page</font></b></p>
        <div align="center">
          <center>
          <form name="enquiryfrm" method="post">
          <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="54%">
            <tr>
              <td width="100%" bgcolor="#0F57BB" colspan="2" align="center">
              <b><font color="#FFFFFF" face="Arial">CIF 
              ENQUIRY</font></b></td>
            </tr>
            <tr>
              <td width="55%" align="left">
              <input type="radio" value="CIFno" checked name="CIF">By CIF number</td>
              <td width="45%" align="left"><input type="text" name="CIFno" size="20"></td>
            </tr>
            <tr>
              <td width="55%" align="left"><input type="radio" name="CIF" value="name">By 
              First Name/Company name</td>
              <td width="45%" align="left"><input type="text" name="name" size="20"></td>
            </tr>
            <tr>
              <td width="55%" align="left"><input type="radio" name="CIF" value="address">By 
              Address</td>
              <td width="45%" align="left"><input type="text" name="address" size="20"></td>
            </tr>
            <tr>
              <td width="55%" align="left"><input type="radio" name="CIF" value="IDno">By ID 
              Number (first id or second Id)</td>
              <td width="45%" align="left"><input type="text" name="idnumber" size="20"></td>
            </tr>
            <tr>
              <td width="55%" align="left">&nbsp;</td>
              <td width="45%" align="left">&nbsp;</td>
            </tr>
            <tr>
              <td width="55%" align="left">&nbsp;</td>
              <td width="45%" align="left"><input type="submit" value="Search" name="B1"></td>
            </tr>
          </table>
          </form>
&nbsp;

          
          
          
          <div align="center">
            <center>
            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="90%">
              <tr>
                <th width="16%" bgcolor="#0F57BB" bordercolor="#C0C0C0">
                <font color="#FFFFFF">CIF NUMBER</font></th>
                <th width="16%" bgcolor="#0F57BB" bordercolor="#C0C0C0">
                <font color="#FFFFFF">CUSTOMER TYPE</font></th>
                <th width="17%" bgcolor="#0F57BB" bordercolor="#C0C0C0">
                <font color="#FFFFFF">NAME/COMPANY NAME</font></th>
                <th width="17%" bgcolor="#0F57BB" bordercolor="#C0C0C0">
                <font color="#FFFFFF">RELATION NAME</font></th>
                <th width="17%" bgcolor="#0F57BB" bordercolor="#C0C0C0">
                <font color="#FFFFFF">ADDRESS</font></th>
                <th width="17%" bgcolor="#0F57BB" bordercolor="#C0C0C0">&nbsp;</th>
              </tr>
              
            
        <%
		String SearchBy =request.getParameter("CIF");
		String cifno=request.getParameter("CIFno");
		String name=request.getParameter("name");
		String address=request.getParameter("address");
		String idnumber=request.getParameter("idnumber");
		String strquery=null;
		String searchparam=null;
		if(SearchBy!=null && SearchBy!="")
		{
			if(SearchBy.equals("CIFno"))
			{
				strquery="select * from customer_info_table where cif_number=?";
				searchparam=cifno;
			}
			if(SearchBy.equals("name"))
			{
				strquery="select * from customer_info_table where first_name_business_name like ?";
				searchparam=name+"%";
			}
			if(SearchBy.equals("address"))
			{
				strquery="select * from customer_info_table where address like ?";
				searchparam="%"+address+"%";
			}
			if(SearchBy.equals("IDno"))
			{
				strquery="select * from customer_info_table as a,identification_details as b where (a.first_identification_id=b.identification_id or a.second_identification_id=b.identification_id) and (b.identification_number=?)";
				searchparam=idnumber;
			}


			try
			{
				conn=bean.getConnection(request);
				PreparedStatement stat =conn.prepareStatement(strquery);
				stat.setString(1,searchparam);
				rs=stat.executeQuery();
				while(rs.next())
				{
				%>
				<tr>
                <td width="16%" align="left" bordercolor="#C0C0C0"><%=rs.getString("cif_number")%>&nbsp;</td>
                <td width="16%" align="left" bordercolor="#C0C0C0"><%=rs.getString("cust_type")%>&nbsp;</td>
                <td width="17%" align="left" bordercolor="#C0C0C0"><%=rs.getString("first_name_business_name")%>&nbsp;</td>
                <td width="17%" align="left" bordercolor="#C0C0C0"><%=rs.getString("relation_name")%>&nbsp;</td>
                <td width="17%" align="left" bordercolor="#C0C0C0"><%=rs.getString("address")%>&nbsp;</td>
                <td width="17%" align="center" bordercolor="#C0C0C0">
                
                <form method ="post" action="CIFEnquiry.jsp">
                <input type="hidden" value="<%=rs.getString("cif_number")%>" name="viewcifno">
				<input type="submit" value="View Full Deatil">
				</form>	
			               
                </td>
              	</tr>
				<%
				}
				
			}
			catch(Exception e)
			{
				out.print("Error occured:"+e);
			}
			finally
			{
				rs.close();
				conn.close();
			}
			

		}
		%> 
		
		</table>
		
		<%
		String viewcifno=request.getParameter("viewcifno");
		if(viewcifno!=null && viewcifno!="")
		{
		try
		{
		conn=bean.getConnection(request);
		PreparedStatement stat=conn.prepareStatement("select * from customer_info_table where cif_number=?");
		stat.setString(1,viewcifno);
		rs=stat.executeQuery();
		if(rs.next())
		{
		%>
		    <p>&nbsp;</p>
            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="90%" height="359">
              <tr>
                <td width="100%" colspan="8" bgcolor="#0F57BB" bordercolor="#0F57BB" height="18">
                <p align="center"><b><font color="#FFFFFF">CIF FULL DETAIL</font></b></td>
              </tr>
              <tr>
                <td width="16%" height="18" align="left"><b>CIF number:</b></td>
                <td width="16%" colspan="2" height="18" align="left"><%=rs.getString("cif_number")%></td>
                <td width="17%" height="18" align="left"><b>Customer Type:</b></td>
                <td width="17%" height="18" align="left"><%=rs.getString("cust_type")%></td>
                <td width="17%" colspan="2" height="18" align="left"><b>Branch 
                Id:</b></td>
                <td width="17%" height="18" align="left"><%=rs.getString("Branch_id")%></td>
              </tr>
              <tr>
                <td width="16%" height="18" align="left"><b>Title:</b></td>
                <td width="16%" colspan="2" height="18" align="left"><%=rs.getString("title")%></td>
                <td width="17%" height="18" align="left"></td>
                <td width="17%" height="18" align="left"></td>
                <td width="17%" colspan="2" height="18" align="left"></td>
                <td width="17%" height="18" align="left"></td>
              </tr>
              <tr>
                <td width="16%" height="38" align="left"><b>First Name/ company Name:</b></td>
                <td width="16%" colspan="2" height="38" align="left"><%=rs.getString("first_name_business_name")%></td>
                <td width="17%" height="38" align="left"><b>Middle Name:</b></td>
                <td width="17%" height="38" align="left">&nbsp;</td>
                <td width="17%" colspan="2" height="38" align="left"><b>Last Name:</b></td>
                <td width="17%" height="38" align="left"><%=rs.getString("last_name")%></td>
              </tr>
              <tr>
                <td width="16%" height="18" align="left"><b>Relation:</b></td>
                <td width="16%" colspan="2" height="18" align="left"><%=rs.getString("relation")%></td>
                <td width="17%" height="18" align="left"><b>Relation Name:</b></td>
                <td width="17%" height="18" align="left"><%=rs.getString("relation_name")%></td>
                <td width="17%" colspan="2" height="18" align="left"></td>
                <td width="17%" height="18" align="left"></td>
              </tr>
              <tr>
                <td width="16%" height="54" align="left"><b>Date Of birth/<br>
                Date of Establishment:</b></td>
                <td width="16%" colspan="2" height="54" align="left"><%=rs.getString("dob_doe")%>&nbsp;</td>
                <td width="17%" height="54" align="left"><b>gender:</b></td>
                <td width="17%" height="54" align="left"><%=rs.getString("gender")%>&nbsp;</td>
                <td width="17%" colspan="2" height="54" align="left">&nbsp;</td>
                <td width="17%" height="54" align="left">&nbsp;</td>
              </tr>
              <tr>
                <td width="16%" height="18" align="left"><b>Address:</b></td>
                <td width="16%" colspan="2" height="18" align="left"><%=rs.getString("address")%></td>
                <td width="17%" height="18" align="left"><b>City:</b></td>
                <td width="17%" height="18" align="left"><%=rs.getString("city")%></td>
                <td width="17%" colspan="2" height="18" align="left"><b>Pin Code:</b></td>
                <td width="17%" height="18" align="left"><%=rs.getString("pin_code")%></td>
              </tr>
              <tr>
                <td width="16%" height="18" align="left"><b>State:</b></td>
                <td width="16%" colspan="2" height="18" align="left"><%=rs.getString("state")%></td>
                <td width="17%" height="18" align="left"><b>Country:</b></td>
                <td width="17%" height="18" align="left"><%=rs.getString("country")%></td>
                <td width="17%" colspan="2" height="18" align="left"></td>
                <td width="17%" height="18" align="left"></td>
              </tr>
              <%
              String id1_id=rs.getString("first_identification_id");
              PreparedStatement id1stat=conn.prepareStatement("select a.identification_name,b.* from identification_type as a, identification_details as b where a.identification_type_id=b.identification_type_id and b.identification_id=?");
              id1stat.setString(1,id1_id);
              ResultSet rs1=id1stat.executeQuery();
              if(rs1.next())
              {
              %>
              <tr>
                <td width="25%" colspan="2" bordercolor="#0F57BB" bgcolor="#FFFFCC" height="18" align="left">
                <b>first id type:</b></td>
                <td width="25%" colspan="2" bordercolor="#0F57BB" bgcolor="#FFFFCC" height="18" align="left"><%=rs1.getString("identification_name")%>&nbsp;</td>
                <td width="25%" colspan="2" bordercolor="#0F57BB" bgcolor="#FFFFCC" height="18" align="left">
                <b>Id issued at:</b></td>
                <td width="25%" colspan="2" bordercolor="#0F57BB" bgcolor="#FFFFCC" height="18" align="left"><%=rs1.getString("identification_issued_at")%>&nbsp;</td>
              </tr>
              <tr>
                <td width="25%" colspan="2" bordercolor="#0F57BB" bgcolor="#FFFFCC" height="18" align="left">
                <b>Id number:</b></td>
                <td width="25%" colspan="2" bordercolor="#0F57BB" bgcolor="#FFFFCC" height="18" align="left"><%=rs1.getString("identification_number")%>&nbsp;</td>
                <td width="25%" colspan="2" bordercolor="#0F57BB" bgcolor="#FFFFCC" height="18" align="left">
                <b>id issue date:</b></td>
                <td width="25%" colspan="2" bordercolor="#0F57BB" bgcolor="#FFFFCC" height="18" align="left"><%=rs1.getString("issue_date")%>&nbsp;</td>
              </tr>
              <%
              }//end of if
              String id2_id=rs.getString("second_identification_id");
              PreparedStatement id2stat=conn.prepareStatement("select a.identification_name,b.* from identification_type as a, identification_details as b where a.identification_type_id=b.identification_type_id and b.identification_id=?");
              id2stat.setString(1,id2_id);
              ResultSet rs2=id2stat.executeQuery();
              if(rs2.next())
              {

              %>
              
              
              <tr>
                <td width="25%" colspan="2" bgcolor="#BFDFFF" height="18" align="left"><b>
                Second id Type:</b></td>
                <td width="25%" colspan="2" bgcolor="#BFDFFF" height="18" align="left"><%=rs2.getString("identification_name")%>&nbsp;</td>
                <td width="25%" colspan="2" bordercolor="#0F57BB" bgcolor="#BFDFFF" height="18" align="left">
                <b>Id issued at:</b></td>
                <td width="25%" colspan="2" bgcolor="#BFDFFF" height="18" align="left"><%=rs2.getString("identification_issued_at")%>&nbsp;</td>
              </tr>
              <tr>
                <td width="25%" colspan="2" bgcolor="#BFDFFF" height="18" align="left"><b>id 
                number:</b></td>
                <td width="25%" colspan="2" bgcolor="#BFDFFF" height="18" align="left"><%=rs2.getString("identification_number")%>&nbsp;</td>
                <td width="25%" colspan="2" bordercolor="#0F57BB" bgcolor="#BFDFFF" height="18" align="left">
                <b>id issue date:</b></td>
                <td width="25%" colspan="2" bgcolor="#BFDFFF" height="18" align="left"><%=rs2.getString("issue_date")%>&nbsp;</td>
              </tr>
               <%
              }//end of if
			%>

              
              
              <tr>
                <td width="16%" height="18" align="left"><b>introducer cif:</b></td>
                <td width="16%" colspan="2" height="18" align="left"><%=rs.getString("introducer_cif_number")%></td>
                <td width="17%" height="18" align="left"></td>
                <td width="17%" height="18" align="left"><b>pan no:</b></td>
                <td width="17%" colspan="2" height="18" align="left"><%=rs.getString("tax_pan_no")%></td>
                <td width="17%" height="18" align="left"></td>
              </tr>
              <tr>
                <td width="16%" height="18" align="left"><b>email id:</b></td>
                <td width="16%" colspan="2" height="18" align="left"><%=rs.getString("email_id")%></td>
                <td width="17%" height="18" align="left"></td>
                <td width="17%" height="18" align="left"><b>source of funds:</b></td>
                <td width="17%" colspan="2" height="18" align="left"><%=rs.getString("source_of_funds")%></td>
                <td width="17%" height="18" align="left"></td>
              </tr>
              <tr>
                <td width="16%" height="18" align="left"><b>annual income:</b></td>
                <td width="16%" colspan="2" height="18" align="left"><%=rs.getString("annual_income")%></td>
                <td width="17%" height="18" align="left"></td>
                <td width="17%" height="18" align="left"><b>occupation:</b></td>
                <td width="17%" colspan="2" height="18" align="left"><%=rs.getString("occupation")%></td>
                <td width="17%" height="18" align="left"></td>
              </tr>
              <tr>
                <td width="16%" height="18" align="left"></td>
                <td width="16%" colspan="2" height="18" align="left"></td>
                <td width="17%" height="18" align="left"></td>
                <td width="17%" height="18" align="left"></td>
                <td width="17%" colspan="2" height="18" align="left"></td>
                <td width="17%" height="18" align="left"></td>
              </tr>
            </table>
            
            
            
            <%
            }//end of if
            }//end of try
            catch(Exception e)
            {
            	out.print("Error :"+e);
            }
            finally
            {
            	rs.close();
            	conn.close();
            }
            }//end of if
            
            %>
        </center>
        </div>
		</p>
          
          
          
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