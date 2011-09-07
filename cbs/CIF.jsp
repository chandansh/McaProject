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
    <tr><td align="center" height="30px" bgcolor="#E3E3FD">CIF</tr>
    <tr><td align="center" height="30px"><a href="CIFEnquiry.jsp">CIF Enquiry</a></tr>
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
        <p align="center"><font face="Arial" color="#FF0000">* shaded field is 
        mandatory</font></p>
        <div align="center">
          <center>
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
            <%
            String cust_type=request.getParameter("cust_type_option");
            if(cust_type!=null && cust_type!="")
            {
            //out.print(cust_type);
            	if(cust_type.equals("Personal")||cust_type.equals("Staff") )
            	{
            %>
            <script type="text/javascript">
            function validate()
            {
           		if(document.p_cif_frm.first_name.value=="")
				{
				alert("enter the first name");
				return false;
				}
				
				if(document.p_cif_frm.relation_name.value=="")
				{
				alert("enter the relation name");
				return false;
				}
				
				if(document.p_cif_frm.year.value=="")
				{
				alert("select the year of date of birth");
				document.cif_cust_type.cust_type.value="Personal";
				return;
				}

				if(document.p_cif_frm.mon.value=="")
				{
				alert("select the month of date of birth");
				document.cif_cust_type.cust_type.value="Personal";
				return;
				}

				if(document.p_cif_frm.date.value=="")
				{
				alert("select the date of date of birth");
				document.cif_cust_type.cust_type.value="Personal";
				return;
				}

				if(document.p_cif_frm.address.value=="")
				{
				alert("enter the address");
				document.cif_cust_type.cust_type.value="Personal";
				return;
				}
				
				if(document.p_cif_frm.introducer_cif.value=="")
				{
				alert("enter the introducer cif");
				document.cif_cust_type.cust_type.value="Personal";
				return;
				}
				
				if(document.p_cif_frm.id1_id_no.value=="")
				{
				alert("enter the id no of first id type");
				document.cif_cust_type.cust_type.value="Personal";
				return;
				}

				if(document.p_cif_frm.id2_id_no.value=="")
				{
				alert("enter the id no of second id type");
				document.cif_cust_type.cust_type.value="Personal";
				return;
				}
				
				if(document.p_cif_frm.photo.value=="")
				{
				alert("please select the photo of customer");
				document.cif_cust_type.cust_type.value="Personal";
				return;
				}
				
				if(document.p_cif_frm.sign_image.value=="")
				{
				alert("please select the sign image of customer");
				document.cif_cust_type.cust_type.value="Personal";
				return;
				}

				

				document.p_cif_frm.action="CreatePersonalCIF.jsp";

            }
            </script>
            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0000FF" width="90%" height="223">
              <tr>
              <td width="100%" align="center" bgcolor="#0000FF" ><b>
              <font color="#FFFFFF">Create Personal CIF</font></b></td>
              </tr>
              <tr>
                <td width="100%" height="223" valign="top">
                <form method="POST" name="p_cif_frm" enctype="multipart/form-data">
                  <div align="left">
                    <table border="0" cellspacing="1" style="border-collapse: collapse" bordercolor="#111111" width="102%">
                      <tr>
                        <td width="17%">Customer Type</td>
                        <td width="20%"><%=cust_type%></td>
                        <input type="hidden" value="<%=cust_type%>" name="cust_type">
                       <td width="19%">&nbsp;</td>
                        <td width="17%">&nbsp;</td>
                        <td width="11%">&nbsp;</td>
                        <td width="19%">&nbsp;</td>
                      </tr>
                      <tr>
                        <td width="17%">Title</td>
                        <td width="20%"><select size="1" name="title">
                        <option selected value="Mr">Mr</option>
                        <option value="Mrs">Mrs</option>
                        <option value="Sri">Sri</option>
                        <option value="Smt">Smt</option>
                        <option value="Dr">Dr</option>
                        </select></td>
                        <td width="19%">&nbsp;</td>
                        <td width="17%">&nbsp;</td>
                        <td width="11%">&nbsp;</td>
                        <td width="19%">&nbsp;</td>
                      </tr>
                      <tr>
                        <td width="17%">First Name<font color="#FF0000">*</font></td>
                        <td width="20%">
                        <input type="text" name="first_name" size="20" style="background-color: #FFFFCC"></td>
                        <td width="19%">
                        &nbsp;Middle Name</td>
                        <td width="17%">
                        <input type="text" name="middle_name" size="20"></td>
                        <td width="11%">Last Name</td>
                        <td width="19%">
                        <input type="text" name="last_name" size="20"></td>
                      </tr>
                      <tr>
                        <td width="17%">Relation </td>
                        <td width="20%"><select size="1" name="relation">
                        <option selected value="Father">Father</option>
                        <option value="Mother">Mother</option>
                        <option value="Husband">Husband</option>
                        <option value="Guardian">Guardian</option>
                        </select> </td>
                        <td width="19%">&nbsp;Relation Name<font color="#FF0000">*</font></td>
                        <td width="17%">
                        <input type="text" name="relation_name" size="20" style="background-color: #FFFFCC"></td>
                        <td width="11%">&nbsp;</td>
                        <td width="19%">&nbsp;</td>
                      </tr>
                      <tr>
                        <td width="17%">Date Of Birth<font color="#FF0000">*</font></td>
                        <td width="20%">
                        <select size="1" name="year" style="background-color: #FFFFCC">
                        <option selected value="">year</option>
                        <option value="1975">1975</option>
                        <option value="1976">1976</option>
                        <option value="1977">1977</option>
                        <option value="1978">1978</option>
                        <option value="1979">1979</option>
                        <option value="1980">1980</option>
                        <option value="1981">1981</option>
                        <option value="1982">1982</option>
                        <option value="1983">1983</option>
                        <option value="1984">1984</option>
                        <option value="1985">1985</option>
                        <option value="1986">1986</option>
                        <option value="1987">1987</option>
                        <option value="1988">1988</option>
                        <option value="1989">1989</option>
                        <option value="1990">1990</option>
                        
                        </select><select size="1" name="mon" style="background-color: #FFFFCC">
                        <option selected value="">mon</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        </select><select size="1" name="date" style="background-color: #FFFFCC">
                        <option selected value="">date</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option>
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option>
                        <option value="29">29</option>
                        <option value="30">30</option>
                        <option value="31">31</option>



                        </select></td>
                        <td width="19%">&nbsp;Gender</td>
                        <td width="17%"><select size="1" name="gender">
                        <option selected value="male">male</option>
                        <option value="female">female</option>
                        </select></td>
                        <td width="11%">&nbsp;</td>
                        <td width="19%">&nbsp;</td>
                      </tr>
                      <tr>
                        <td width="17%">Address<font color="#FF0000">*</font></td>
                        <td width="20%">
                        <input type="text" name="address" size="20" style="background-color: #FFFFCC"></td>
                        <td width="19%">&nbsp;City</td>
                        <td width="17%">
                        <input type="text" name="city" size="20"></td>
                        <td width="11%">Pin Code</td>
                        <td width="19%">
                        <input type="text" name="pincode" size="20"></td>
                      </tr>
                      <tr>
                        <td width="17%">State</td>
                        <td width="20%">
                        <input type="text" name="state" size="20"></td>
                        <td width="19%">&nbsp;Country</td>
                        <td width="17%">
                        <input type="text" name="country" size="20"></td>
                        <td width="11%">&nbsp;</td>
                        <td width="19%">&nbsp;</td>
                      </tr>
                      <tr>
                        <td width="101%" colspan="6">
                        <fieldset style="padding: 2">
                        <legend>First Identification (Person Identification)</legend>
                        <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
                          <tr>
                            <td width="25%">Identification type</td>
                            <td width="25%"><select size="1" name="id1_type">
                            <%
                            try
                            {
                            conn = bean.getConnection(request);
							PreparedStatement stat= conn.prepareStatement("select * from identification_type where (cust_type='Personal' or cust_type='Both') and identification_type='Identification'");
							rs = stat.executeQuery();
							while(rs.next())
								{
								%>
								<option value="<%=rs.getString("identification_type_id")%>"><%=rs.getString("identification_name")%></option>
								<%
								}
                            
                            }
                            catch(Exception e)
                            {
                            out.print(e);
                            }
                            finally
                            {
                            rs.close();
                            conn.close();
                            }
                            
                            %>
                            </select></td>
                            <td width="25%">Id Issued At</td>
                            <td width="25%">
                            <input type="text" name="id1_id_issued_at" size="20"></td>
                          </tr>
                          <tr>
                            <td width="25%">identification Number<font color="#FF0000">*</font></td>
                            <td width="25%">
                            <input type="text" name="id1_id_no" size="20" style="background-color: #FFFFCC"></td>
                            <td width="25%">issue Date</td>
                            <td width="25%"><select size="1" name="id1year">
                        <option selected value="0">year</option>
                        <option value="1975">1975</option>
                        <option value="1976">1976</option>
                        <option value="1977">1977</option>
                        <option value="1978">1978</option>
                        <option value="1979">1979</option>
                        <option value="1980">1980</option>
                        <option value="1981">1981</option>
                        <option value="1982">1982</option>
                        <option value="1983">1983</option>
                        <option value="1984">1984</option>
                        <option value="1985">1985</option>
                        <option value="1986">1986</option>
                        <option value="1987">1987</option>
                        <option value="1988">1988</option>
                        <option value="1989">1989</option>
                        <option value="1990">1990</option>
                        
                        </select><select size="1" name="id1mon">
                        <option selected value="00">mon</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        </select><select size="1" name="id1date">
                        <option selected value="00">date</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option>
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option>
                        <option value="29">29</option>
                        <option value="30">30</option>
                        <option value="31">31</option>



                        </select></td>
                          </tr>
                        </table>
                        </fieldset></td>
                      </tr>
                      <tr>
                        <td width="101%" colspan="6">
                        <fieldset style="padding: 2">
                        <legend>Second Identification (Address Identification)</legend>
                        <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
                          <tr>
                            <td width="25%">Identification type</td>
                            <td width="25%"><select size="1" name="id2_type">
                            <%
                            try
                            {
                            conn = bean.getConnection(request);
							PreparedStatement stat= conn.prepareStatement("select * from identification_type where (cust_type='Personal' or cust_type='Both') and identification_type='Address'");
							rs = stat.executeQuery();
							while(rs.next())
								{
								%>
								<option value="<%=rs.getString("identification_type_id")%>"><%=rs.getString("identification_name")%></option>
								<%
								}
                            
                            }
                            catch(Exception e)
                            {
                            out.print(e);
                            }
                            finally
                            {
                            rs.close();
                            conn.close();
                            }
                            
                            %>

                            
                            </select></td>
                            <td width="25%">Id Issued At</td>
                            <td width="25%">
                            <input type="text" name="id2_id_issued_at" size="20"></td>
                          </tr>
                          <tr>
                            <td width="25%">identification Number<font color="#FF0000">*</font></td>
                            <td width="25%">
                            <input type="text" name="id2_id_no" size="20" style="background-color: #FFFFCC"></td>
                            <td width="25%">issue Date</td>
                            <td width="25%"><select size="1" name="id2year">
                        <option selected value="0">year</option>
                        <option value="1975">1975</option>
                        <option value="1976">1976</option>
                        <option value="1977">1977</option>
                        <option value="1978">1978</option>
                        <option value="1979">1979</option>
                        <option value="1980">1980</option>
                        <option value="1981">1981</option>
                        <option value="1982">1982</option>
                        <option value="1983">1983</option>
                        <option value="1984">1984</option>
                        <option value="1985">1985</option>
                        <option value="1986">1986</option>
                        <option value="1987">1987</option>
                        <option value="1988">1988</option>
                        <option value="1989">1989</option>
                        <option value="1990">1990</option>
                        
                        </select><select size="1" name="id2mon">
                        <option selected value="00">mon</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        </select><select size="1" name="id2date">
                        <option selected value="00">date</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option>
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option>
                        <option value="29">29</option>
                        <option value="30">30</option>
                        <option value="31">31</option>



                        </select></td>
                          </tr>
                        </table>
                        </fieldset></td>
                      </tr>
                      <tr>
                        <td width="17%">Introducer CIF<font color="#FF0000">*</font></td>
                        <td width="20%">
                        <input type="text" name="introducer_cif" size="20" style="background-color: #FFFFCC"></td>
                        <td width="19%">Pan No</td>
                        <td width="17%">
                        <input type="text" name="pan_no" size="20"></td>
                        <td width="11%">&nbsp;</td>
                        <td width="19%">&nbsp;</td>
                      </tr>
                      <tr>
                        <td width="17%">Email Id</td>
                        <td width="20%">
                        <input type="text" name="emailid" size="20"></td>
                        <td width="19%">
                        source of fund</td>
                        <td width="17%">
                        <input type="text" name="source_of_fund" size="20"></td>
                        <td width="11%">
                        &nbsp;</td>
                        <td width="19%">
                        &nbsp;</td>
                      </tr>
                      <tr>
                        <td width="17%">Annual Income</td>
                        <td width="20%">
                        <input type="text" name="annual_income" size="20"></td>
                        <td width="19%">
                        Occupation</td>
                        <td width="17%">
                        <input type="text" name="occupation" size="20"></td>
                        <td width="11%">
                        &nbsp;</td>
                        <td width="19%">
                        &nbsp;</td>
                      </tr>
                      <tr>
                        <td width="17%">photo<font color="#FF0000">*</font></td>
                        <td width="20%">
                        <input type="file" name="photo" size="20" style="background-color: #FFFFCC"></td>
                        <td width="19%">
                        sign image<font color="#FF0000">*</font></td>
                        <td width="28%" colspan="2">
                        <input type="file" name="sign_image" size="20" style="background-color: #FFFFCC"></td>
                        <td width="19%">
                        &nbsp;</td>
                      </tr>
                      <tr>
                        <td width="17%">&nbsp;</td>
                        <td width="20%">
                        &nbsp;</td>
                        <td width="19%">
                        <input type="submit" value="Submit" name="B1" onclick="validate();"> </td>
                        <td width="17%">
                        <input type="reset" value="Reset" name="B2"></td>
                        <td width="11%">
                        &nbsp;</td>
                        <td width="19%">
                        &nbsp;</td>
                      </tr>
                    </table>
                  </div>
                </form>
                </td>
              </tr>
            </table>
            <%
            	}//end of if Personal
            	
            	if(cust_type.equals("Non Personal"))
            	{
            %>
            <script type="text/javascript">
            function validate1()
            {
           		if(document.np_cif_frm.company_name.value=="")
				{
				alert("enter the company name");
				return false;
				}
				
				if(document.np_cif_frm.relation_name.value=="")
				{
				alert("enter the relation name");
				return false;
				}
				
				if(document.np_cif_frm.year.value=="")
				{
				alert("select the year of date of birth");
				document.cif_cust_type.cust_type.value="Personal";
				return;
				}

				if(document.np_cif_frm.mon.value=="")
				{
				alert("select the month of date of birth");
				document.cif_cust_type.cust_type.value="Personal";
				return;
				}

				if(document.np_cif_frm.date.value=="")
				{
				alert("select the date of date of birth");
				document.cif_cust_type.cust_type.value="Personal";
				return;
				}

				if(document.np_cif_frm.address.value=="")
				{
				alert("enter the address");
				document.cif_cust_type.cust_type.value="Personal";
				return;
				}
				
				if(document.np_cif_frm.introducer_cif.value=="")
				{
				alert("enter the introducer cif");
				document.cif_cust_type.cust_type.value="Personal";
				return;
				}
				
				if(document.np_cif_frm.id1_id_no.value=="")
				{
				alert("enter the id no of first id type");
				document.cif_cust_type.cust_type.value="Personal";
				return;
				}

				if(document.np_cif_frm.id2_id_no.value=="")
				{
				alert("enter the id no of second id type");
				document.cif_cust_type.cust_type.value="Personal";
				return;
				}
				
				if(document.np_cif_frm.photo.value=="")
				{
				alert("please select the photo of customer");
				document.cif_cust_type.cust_type.value="Personal";
				return;
				}
				
				if(document.np_cif_frm.sign_image.value=="")
				{
				alert("please select the sign image of customer");
				document.cif_cust_type.cust_type.value="Personal";
				return;
				}

				

				document.np_cif_frm.action="CreateNonPersonalCIF.jsp";

            }
            </script>

            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0000FF" width="90%" height="223">
              <tr>
              <td width="100%" align="center" bgcolor="#0000FF" ><b>
              <font color="#FFFFFF">Create Non Personal CIF</font></b></td>
              </tr>
              <tr>
                <td width="100%" height="223" valign="top">
                <form method="POST" name="np_cif_frm" enctype="multipart/form-data">
                  <div align="left">
                    <table border="0" cellspacing="1" style="border-collapse: collapse" bordercolor="#111111" width="105%">
                      <tr>
                        <td width="16%">Customer Type</td>
                        <td width="22%"><%=cust_type%></td>
                        <input type="hidden" value="<%=cust_type%>" name="cust_type">
                        <td width="17%">&nbsp;</td>
                        <td width="18%">&nbsp;</td>
                        <td width="11%">&nbsp;</td>
                        <td width="19%">&nbsp;</td>
                      </tr>
                      <tr>
                        <td width="16%">Company Name<font color="#FF0000">*</font></td>
                        <td width="22%">
                        <input type="text" name="company_name" size="20" style="background-color: #FFFFCC"></td>
                        <td width="17%">
                        &nbsp;</td>
                        <td width="18%">
                        &nbsp;</td>
                        <td width="11%">&nbsp;</td>
                        <td width="19%">
                        &nbsp;</td>
                      </tr>
                      <tr>
                        <td width="16%">Relation </td>
                        <td width="22%"><select size="1" name="relation">
                        <option selected value="Owner">Owner</option>
                        <option value="CEO">CEO</option>
                        <option value="MD">MD</option>
                        </select> </td>
                        <td width="17%">&nbsp;Relation Name<font color="#FF0000">*</font></td>
                        <td width="18%">
                        <input type="text" name="relation_name" size="20" style="background-color: #FFFFCC"></td>
                        <td width="11%">&nbsp;</td>
                        <td width="19%">&nbsp;</td>
                      </tr>
                      <tr>
                        <td width="16%">Date Of establishment</td>
                        <td width="22%">
                        <select size="1" name="year" style="background-color: #FFFFCC">
                        <option selected value="">year</option>
                        <option value="1975">1975</option>
                        <option value="1976">1976</option>
                        <option value="1977">1977</option>
                        <option value="1978">1978</option>
                        <option value="1979">1979</option>
                        <option value="1980">1980</option>
                        <option value="1981">1981</option>
                        <option value="1982">1982</option>
                        <option value="1983">1983</option>
                        <option value="1984">1984</option>
                        <option value="1985">1985</option>
                        <option value="1986">1986</option>
                        <option value="1987">1987</option>
                        <option value="1988">1988</option>
                        <option value="1989">1989</option>
                        <option value="1990">1990</option>
                        
                        </select><select size="1" name="mon" style="background-color: #FFFFCC">
                        <option selected value="">mon</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        </select><select size="1" name="date" style="background-color: #FFFFCC">
                        <option selected value="">date</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option>
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option>
                        <option value="29">29</option>
                        <option value="30">30</option>
                        <option value="31">31</option>



                        </select><font color="#FF0000">**</font></td>
                        <td width="17%">&nbsp;</td>
                        <td width="18%">&nbsp;</td>
                        <td width="11%">&nbsp;</td>
                        <td width="19%">&nbsp;</td>
                      </tr>
                      <tr>
                        <td width="16%">Address<font color="#FF0000">*</font></td>
                        <td width="22%">
                        <input type="text" name="address" size="20" style="background-color: #FFFFCC"></td>
                        <td width="17%">&nbsp;City</td>
                        <td width="18%">
                        <input type="text" name="city" size="20"></td>
                        <td width="11%">Pin Code</td>
                        <td width="19%">
                        <input type="text" name="pincode" size="20"></td>
                      </tr>
                      <tr>
                        <td width="16%">State</td>
                        <td width="22%">
                        <input type="text" name="state" size="20"></td>
                        <td width="17%">&nbsp;Country</td>
                        <td width="18%">
                        <input type="text" name="country" size="20"></td>
                        <td width="11%">&nbsp;</td>
                        <td width="19%">&nbsp;</td>
                      </tr>
                      <tr>
                        <td width="101%" colspan="6">
                        <fieldset style="padding: 2">
                        <legend>First Identification (Person Identification)</legend>
                        <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
                          <tr>
                            <td width="25%">Identification type</td>
                            <td width="25%"><select size="1" name="id1_type">
                            <%
                            try
                            {
                            conn = bean.getConnection(request);
							PreparedStatement stat= conn.prepareStatement("select * from identification_type where (cust_type='Non Personal' or cust_type='Both') and identification_type='Identification'");
							rs = stat.executeQuery();
							while(rs.next())
								{
								%>
								<option value="<%=rs.getString("identification_type_id")%>"><%=rs.getString("identification_name")%></option>
								<%
								}
                            
                            }
                            catch(Exception e)
                            {
                            out.print(e);
                            }
                            finally
                            {
                            rs.close();
                            conn.close();
                            }
                            
                            %>
                            </select></td>
                            <td width="25%">Id Issued At</td>
                            <td width="25%">
                            <input type="text" name="id1_id_issued_at" size="20"></td>
                          </tr>
                          <tr>
                            <td width="25%">identification Number<font color="#FF0000">*</font></td>
                            <td width="25%">
                            <input type="text" name="id1_id_no" size="20" style="background-color: #FFFFCC"></td>
                            <td width="25%">issue Date</td>
                            <td width="25%"><select size="1" name="id1year">
                        <option selected value="0">year</option>
                        <option value="1975">1975</option>
                        <option value="1976">1976</option>
                        <option value="1977">1977</option>
                        <option value="1978">1978</option>
                        <option value="1979">1979</option>
                        <option value="1980">1980</option>
                        <option value="1981">1981</option>
                        <option value="1982">1982</option>
                        <option value="1983">1983</option>
                        <option value="1984">1984</option>
                        <option value="1985">1985</option>
                        <option value="1986">1986</option>
                        <option value="1987">1987</option>
                        <option value="1988">1988</option>
                        <option value="1989">1989</option>
                        <option value="1990">1990</option>
                        
                        </select><select size="1" name="id1mon">
                        <option selected value="00">mon</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        </select><select size="1" name="id1date">
                        <option selected value="00">date</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option>
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option>
                        <option value="29">29</option>
                        <option value="30">30</option>
                        <option value="31">31</option>



                        </select></td>
                          </tr>
                        </table>
                        </fieldset></td>
                      </tr>
                      <tr>
                        <td width="101%" colspan="6">
                        <fieldset style="padding: 2">
                        <legend>Second Identification (Address Identification)</legend>
                        <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
                          <tr>
                            <td width="25%">Identification type</td>
                            <td width="25%"><select size="1" name="id2_type">
                            <%
                            try
                            {
                            conn = bean.getConnection(request);
							PreparedStatement stat= conn.prepareStatement("select * from identification_type where (cust_type='Non Personal' or cust_type='Both') and identification_type='Address'");
							rs = stat.executeQuery();
							while(rs.next())
								{
								%>
								<option value="<%=rs.getString("identification_type_id")%>"><%=rs.getString("identification_name")%></option>
								<%
								}
                            
                            }
                            catch(Exception e)
                            {
                            out.print(e);
                            }
                            finally
                            {
                            rs.close();
                            conn.close();
                            }
                            
                            %>

                            
                            </select></td>
                            <td width="25%">Id Issued At</td>
                            <td width="25%">
                            <input type="text" name="id2_id_issued_at" size="20"></td>
                          </tr>
                          <tr>
                            <td width="25%">identification Number<font color="#FF0000">*</font></td>
                            <td width="25%">
                            <input type="text" name="id2_id_no" size="20" style="background-color: #FFFFCC"></td>
                            <td width="25%">issue Date</td>
                            <td width="25%"><select size="1" name="id2year">
                        <option selected value="0">year</option>
                        <option value="1975">1975</option>
                        <option value="1976">1976</option>
                        <option value="1977">1977</option>
                        <option value="1978">1978</option>
                        <option value="1979">1979</option>
                        <option value="1980">1980</option>
                        <option value="1981">1981</option>
                        <option value="1982">1982</option>
                        <option value="1983">1983</option>
                        <option value="1984">1984</option>
                        <option value="1985">1985</option>
                        <option value="1986">1986</option>
                        <option value="1987">1987</option>
                        <option value="1988">1988</option>
                        <option value="1989">1989</option>
                        <option value="1990">1990</option>
                        
                        </select><select size="1" name="id2mon">
                        <option selected value="00">mon</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        </select><select size="1" name="id2date">
                        <option selected value="00">date</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option>
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option>
                        <option value="29">29</option>
                        <option value="30">30</option>
                        <option value="31">31</option>



                        </select></td>
                          </tr>
                        </table>
                        </fieldset></td>
                      </tr>
                      <tr>
                        <td width="16%">Introducer CIF<font color="#FF0000">*</font></td>
                        <td width="22%">
                        <input type="text" name="introducer_cif" size="20" style="background-color: #FFFFCC"></td>
                        <td width="17%">Pan No</td>
                        <td width="18%">
                        <input type="text" name="pan_no" size="20"></td>
                        <td width="11%">&nbsp;</td>
                        <td width="19%">&nbsp;</td>
                      </tr>
                      <tr>
                        <td width="16%">Email Id</td>
                        <td width="22%">
                        <input type="text" name="emailid" size="20"></td>
                        <td width="17%">
                        &nbsp;</td>
                        <td width="18%">
                        &nbsp;</td>
                        <td width="11%">
                        &nbsp;</td>
                        <td width="19%">
                        &nbsp;</td>
                      </tr>
                      <tr>
                        <td width="16%">photo<font color="#FF0000">*</font></td>
                        <td width="22%">
                        <input type="file" name="photo" size="17" style="background-color: #FFFFCC"></td>
                        <td width="17%">
                        sign image<font color="#FF0000">*</font></td>
                        <td width="29%" colspan="2">
                        <input type="file" name="sign_image" size="20" style="background-color: #FFFFCC"></td>
                        <td width="19%">
                        &nbsp;</td>
                      </tr>
                      <tr>
                        <td width="16%">&nbsp;</td>
                        <td width="22%">
                        &nbsp;</td>
                        <td width="17%">
                        <input type="submit" value="Submit" name="B1" onclick="validate1()"> </td>
                        <td width="18%">
                        <input type="reset" value="Reset" name="B2"></td>
                        <td width="11%">
                        &nbsp;</td>
                        <td width="19%">
                        &nbsp;</td>
                      </tr>
                    </table>
                  </div>
                </form>
                </td>
              </tr>
            </table>
            <%
            	}//end of if Non Personal
			if(cust_type.equals("Nominee"))
            	{
            %>
            <script type="text/javascript">
			function validate2()
			{
				if(document.n_cif_frm.first_name.value=="")
				{
				alert("enter the first name");
				return false;
				}
				if(document.n_cif_frm.year.value=="")
				{
				alert("select the year");
				document.cif_cust_type.cust_type.value="Nominee";
				return;
				}

				if(document.n_cif_frm.mon.value=="")
				{
				alert("select the month");
				document.cif_cust_type.cust_type.value="Nominee";
				return;
				}

				if(document.n_cif_frm.date.value=="")
				{
				alert("select the date");
				document.cif_cust_type.cust_type.value="Nominee";
				return;
				}

				if(document.n_cif_frm.address.value=="")
				{
				alert("enter the address");
				document.cif_cust_type.cust_type.value="Nominee";
				return;
				}

			document.n_cif_frm.action="CreateNominee.jsp";
			}
            </script>
            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0000FF" width="90%" height="223">
              <tr>
              <td width="100%" align="center" bgcolor="#0000FF" ><b>
              <font color="#FFFFFF">Nominee CIF</font></b></td>
              </tr>
              <tr>
                <td width="100%" height="223" valign="top">
                <form method="POST" name="n_cif_frm" >
                  <div align="left">
                    <table border="0" cellspacing="1" style="border-collapse: collapse" bordercolor="#111111" width="100%" height="197">
                      <tr>
                        <td width="17%" height="18">Customer Type</td>
                        <td width="20%" height="18"><%=cust_type%></td>
                        <input type="hidden" value="<%=cust_type%>" name="cust_type">
                        <td width="17%" height="18"></td>
                        <td width="17%" height="18"></td>
                        <td width="11%" height="18"></td>
                        <td width="19%" height="18"></td>
                      </tr>
                      <tr>
                        <td width="17%" height="22">Title</td>
                        <td width="20%" height="22"><select size="1" name="title">
                        <option selected value="Mr">Mr</option>
                        <option value="Mrs">Mrs</option>
                        <option value="Sri">Sri</option>
                        <option value="Smt">Smt</option>
                        <option value="Dr">Dr</option>
                        </select></td>
                        <td width="17%" height="22">&nbsp;</td>
                        <td width="17%" height="22">&nbsp;</td>
                        <td width="11%" height="22">&nbsp;</td>
                        <td width="19%" height="22">&nbsp;</td>
                      </tr>
                      <tr>
                        <td width="17%" height="22">First Name<font color="#FF0000">*</font></td>
                        <td width="20%" height="22">
                        <input type="text" name="first_name" size="20" style="background-color: #FFFFCC"></td>
                        <td width="17%" height="22">
                        &nbsp;Middle Name</td>
                        <td width="17%" height="22">
                        <input type="text" name="middle_name" size="20"></td>
                        <td width="11%" height="22">Last Name</td>
                        <td width="19%" height="22">
                        <input type="text" name="last_name" size="20"></td>
                      </tr>
                      <tr>
                        <td width="17%">Relation </td>
                        <td width="20%"><select size="1" name="relation">
                        <option selected value="Father">Father</option>
                        <option value="brother">brother</option>
                        <option value="sister">sister</option>
                        <option value="son">son</option>
                        <option value="daughter">daughter</option>
                        <option value="Mother">Mother</option>
                        <option value="Husband">Husband</option>
                        <option value="Guardian">Guardian</option>
                        </select> </td>
                        <td width="17%">&nbsp;</td>
                        <td width="17%">
                        &nbsp;</td>
                        <td width="11%">&nbsp;</td>
                        <td width="19%" height="22">&nbsp;</td>
                      </tr>
                      <tr>
                        <td width="17%" height="22">Date Of Birth<font color="#FF0000">*</font></td>
                        <td width="20%" height="22">
                        <select size="1" name="year" style="background-color: #FFFFCC">
                        <option selected value="">year</option>
                        <option value="1975">1975</option>
                        <option value="1976">1976</option>
                        <option value="1977">1977</option>
                        <option value="1978">1978</option>
                        <option value="1979">1979</option>
                        <option value="1980">1980</option>
                        <option value="1981">1981</option>
                        <option value="1982">1982</option>
                        <option value="1983">1983</option>
                        <option value="1984">1984</option>
                        <option value="1985">1985</option>
                        <option value="1986">1986</option>
                        <option value="1987">1987</option>
                        <option value="1988">1988</option>
                        <option value="1989">1989</option>
                        <option value="1990">1990</option>
                        
                        </select><select size="1" name="mon" style="background-color: #FFFFCC">
                        <option selected value="">mon</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        </select><select size="1" name="date" style="background-color: #FFFFCC">
                        <option selected value="">date</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option>
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option>
                        <option value="29">29</option>
                        <option value="30">30</option>
                        <option value="31">31</option>



                        </select></td>
                        <td width="17%" height="22">&nbsp;Gender</td>
                        <td width="17%" height="22"><select size="1" name="gender">
                        <option selected value="male">male</option>
                        <option value="female">female</option>
                        </select></td>
                        <td width="11%" height="22">&nbsp;</td>
                        <td width="19%" height="22">&nbsp;</td>
                      </tr>
                      <tr>
                        <td width="17%" height="19">Address<font color="#FF0000">*</font></td>
                        <td width="20%" height="19">
                        <input type="text" name="address" size="20" style="background-color: #FFFFCC"></td>
                        <td width="17%" height="19">&nbsp;City</td>
                        <td width="17%" height="19">
                        <input type="text" name="city" size="20"></td>
                        <td width="11%" height="19">Pin Code</td>
                        <td width="19%" height="19">
                        <input type="text" name="pincode" size="20"></td>
                      </tr>
                      <tr>
                        <td width="17%" height="22">State</td>
                        <td width="20%" height="22">
                        <input type="text" name="state" size="20"></td>
                        <td width="17%" height="22">&nbsp;Country</td>
                        <td width="17%" height="22">
                        <input type="text" name="country" size="20"></td>
                        <td width="11%" height="22">&nbsp;</td>
                        <td width="19%" height="22">&nbsp;</td>
                      </tr>
                      <tr>
                        <td width="17%" height="22">Email Id</td>
                        <td width="20%" height="22">
                        <input type="text" name="emailid" size="20"></td>
                        <td width="17%" height="22">
                        &nbsp;</td>
                        <td width="17%" height="22">
                        &nbsp;</td>
                        <td width="11%" height="22">
                        &nbsp;</td>
                        <td width="19%" height="22">
                        &nbsp;</td>
                      </tr>
                      <tr>
                        <td width="17%" height="26">&nbsp;</td>
                        <td width="20%" height="26">
                        &nbsp;</td>
                        <td width="17%" height="26">
                        <input type="submit" value="Submit" name="n_cif_b" onclick="validate2();"> </td>
                        <td width="17%" height="26">
                        <input type="reset" value="Reset" name="B2"></td>
                        <td width="11%" height="26">
                        &nbsp;</td>
                        <td width="19%" height="26">
                        &nbsp;</td>
                      </tr>
                     

                    </table>
                  </div>
                </form>
                </td>
              </tr>
            </table>
            <%
            	}//end of if nominee            	

            }//end of if
            else
            {
            %> 
            
   

            
            
            
            
            <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="50%">
              <tr>
                <td width="100%">
                <form method="POST" name="cif_cust_type" action="CIF.jsp">
                  <fieldset style="padding: 2">
                  <legend>Select Customer Type</legend>
                  <table border="0" cellpadding="0" cellspacing="1" style="border-collapse: collapse" bordercolor="#111111" width="100%">
                    <tr>
                      <td width="39%" align="left">Customer Type</td>
                      <td width="61%" align="left"><select size="1" name="cust_type_option">
                      <option selected value="Personal">Personal</option>
                      <option value="Non Personal">Non Personal</option>
                      <option value="Staff">Staff</option>
                      <option value="Nominee">Nominee</option>
                      </select>
                      <input type="submit" value="Transmit" name="B1"></td>
                    </tr>
                    </table>
                  </fieldset></form>
                </td>
              </tr>
            </table>
            <%
            }//end of else
            
            %>
            
            
            
            </center>
          </div>
          </center>
        </div>
        <div align="center">
          <center>
		
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