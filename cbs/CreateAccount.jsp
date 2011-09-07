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
    <tr><td align="center" height="30px"><a href="CIFModify.jsp">CIF Modify</a></tr>
    <tr><td align="center" height="30px" bgcolor="#E3E3FD">Create Account</tr>
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

            <form method="post">
            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="56%">
              <tr>
                <th width="100%" colspan="2" bgcolor="#0F57BB" >
                <font color="#FFFFFF">CREATE ACCOUNT</font></th>
              </tr>
              <tr>
                <td width="35%" align="left">Select Account Type</td>
                <td width="65%" align="left">
                <select size="1" name="acc_type">
                <%
                try
                {
                	conn=bean.getConnection(request);
                	Statement stat=conn.createStatement();
                	rs=stat.executeQuery("select * from account_type");
                	while(rs.next())
                	{
                	%>
                	<option value="<%=rs.getString("account_type_id")%>"><%=rs.getString("name")%></option>
                	<%
                	}
                }
                catch(Exception e)
                {
                }
                finally
                {
                }
                
                %>
                </select>
                </td>
              </tr>
              <tr>
                <td width="35%" align="left">&nbsp;</td>
                <td width="65%" align="left">
                <input type="submit" value="Transmit" name="B1"></td>
              </tr>
              <tr>
                <td width="35%" align="left">&nbsp;</td>
                <td width="65%" align="left">&nbsp;</td>
              </tr>
              </table>
              </form>
              <br>
              <!-- handle the request for create account-->
              <%
              String acc_type=request.getParameter("acc_type");
              if(acc_type!=null && acc_type!="")
              {
              	if(acc_type.equals("sb"))
              	{
              	%>
              	<script type="text/javascript">
              	function validatefrm()
              	{
              		if(document.sbaccfrm.sb_cif_no.value=="")
              		{
              		alert("please enter CIF number");
              		return;
              		}
              		if(document.sbaccfrm.sb_nominee_cif.value=="")
              		{
              		alert("please enter Nominee CIF number");
              		return;
              		}
				document.sbaccfrm.action="CreateSBCA.jsp";
              		
              	}
              	</script>
            <form name="sbaccfrm" method="post">
            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="60%">
              <tr>
                <td width="100%" bgcolor="#0F57BB" colspan="2" align="center">
                <b><font color="#FFFFFF">Create Saving Bank Account</font></b></td>
              </tr>
              <tr>
                <td width="40%" align="left">Enter CIF number</td>
                <td width="60%" align="left">
                <input type="text" name="sb_cif_no" size="20"></td>
              </tr>
              <tr>
                <td width="40%" align="left">Cheque Facility</td>
                <td width="60%" align="left"><select size="1" name="sb_cheque">
                <option selected value="0">No</option>
                <option value="1">yes</option>
                </select></td>
              </tr>
              <tr>
                <td width="40%" align="left">Location</td>
                <td width="60%" align="left"><select size="1" name="sb_location">
                <option value="Urban" selected>Urban</option>
                <option value="Rural">Rural</option>
                </select></td>
              </tr>
              <tr>
                <td width="40%" align="left">Nominee CIF</td>
                <td width="60%" align="left">
                <input type="text" name="sb_nominee_cif" size="20"></td>
              </tr>
              <tr>
                <td width="40%" align="left">&nbsp;</td>
                <td width="60%" align="left">&nbsp;</td>
              </tr>
              <tr>
                <td width="40%" align="left">&nbsp;</td>
                <td width="60%" align="left">
                <input type="submit" value="Create Account" name="B1" onclick="validatefrm();">
                <input type="reset" value="Reset" name="B2"></td>
              </tr>
              <tr>
                <td width="40%" align="left">&nbsp;</td>
                <td width="60%" align="left">&nbsp;</td>
              </tr>
            </table>
            </form>
            <p>&nbsp;<%
              	}//end of create saving Account form
              	if(acc_type.equals("ca"))
              	{
              	%>
              	<script type="text/javascript">
              	function validatefrm1()
              	{
              		if(document.caaccfrm.ca_cif_no.value=="")
              		{
              		alert("please enter CIF number");
              		return;
              		}
              		if(document.caaccfrm.ca_nominee_cif.value=="")
              		{
              		alert("please enter Nominee CIF number");
              		return;
              		}
				document.caaccfrm.action="CreateSBCA.jsp";
              		
              	}
              	</script>

            <form name="caaccfrm" method="post">
            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="60%">
              <tr>
                <td width="100%" bgcolor="#0F57BB" colspan="2" align="center">
                <b><font color="#FFFFFF">Create Current Account</font></b></td>
              </tr>
              <tr>
                <td width="40%" align="left">Enter CIF number</td>
                <td width="60%" align="left">
                <input type="text" name="ca_cif_no" size="20"></td>
              </tr>
              <tr>
                <td width="40%" align="left">Cheque Facility</td>
                <td width="60%" align="left"><select size="1" name="ca_cheque">
                <option selected value="0">No</option>
                <option value="1">yes</option>
                </select></td>
              </tr>
              <tr>
                <td width="40%" align="left">Location</td>
                <td width="60%" align="left"><select size="1" name="ca_location">
                <option value="Urban" selected>Urban</option>
                <option value="Rural">Rural</option>
                </select></td>
              </tr>
              <tr>
                <td width="40%" align="left">Nominee CIF</td>
                <td width="60%" align="left">
                <input type="text" name="ca_nominee_cif" size="20"></td>
              </tr>
              <tr>
                <td width="40%" align="left">&nbsp;</td>
                <td width="60%" align="left">&nbsp;</td>
              </tr>
              <tr>
                <td width="40%" align="left">&nbsp;</td>
                <td width="60%" align="left">
                <input type="submit" value="Create Account" name="B1" onclick="validatefrm1();">
                <input type="reset" value="Reset" name="B2"></td>
              </tr>
              <tr>
                <td width="40%" align="left">&nbsp;</td>
                <td width="60%" align="left">&nbsp;</td>
              </tr>
            </table>
            </form>
            <p>&nbsp;<%
              	}//end of create current account

              if(acc_type.equals("fd"))
              	{
              	%>
              	<script type="text/javascript">
              	function validatefrm2()
              	{
              		if(document.fdaccfrm.fd_cif_no.value=="")
              		{
              		alert("please enter CIF number");
              		return;
              		}
              		if(document.fdaccfrm.fd_nominee_cif.value=="")
              		{
              		alert("please enter Nominee CIF number");
              		return;
              		}
				document.fdaccfrm.action="CreateFDRD.jsp";
              		
              	}
              	</script>

            <form name="fdaccfrm" method="post">
            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="60%">
              <tr>
                <td width="100%" bgcolor="#0F57BB" colspan="2" align="center">
                <b><font color="#FFFFFF">Create Fixed Deposit Account</font></b></td>
              </tr>
              <tr>
                <td width="40%" align="left">Enter CIF number</td>
                <td width="60%" align="left">
                <input type="text" name="fd_cif_no" size="20"></td>
              </tr>
              <tr>
                <td width="40%" align="left">Location</td>
                <td width="60%" align="left">
                <select size="1" name="fd_location">
                <option value="Urban" selected>Urban</option>
                <option value="Rural">Rural</option>
                </select></td>
              </tr>
              <tr>
                <td width="40%" align="left">Nominee CIF</td>
                <td width="60%" align="left">
                <input type="text" name="fd_nominee_cif" size="20"></td>
              </tr>
              <tr>
                <td width="40%" align="left">Time Duration</td>
                <td width="60%" align="left">
                <select size="1" name="fd_time_duration">
                <option selected value="12">12</option>
                <option value="24">24</option>
                <option value="36">36</option>
                <option value="48">48</option>
                <option value="60">60</option>
                <option value="72">72</option>
                <option value="84">84</option>
                <option value="96">96</option>
                <option value="108">108</option>
                <option value="120">120</option>
                </select> Months</td>
              </tr>
              <tr>
                <td width="40%" align="left">&nbsp;</td>
                <td width="60%" align="left">&nbsp;</td>
              </tr>
              <tr>
                <td width="40%" align="left">&nbsp;</td>
                <td width="60%" align="left">&nbsp;</td>
              </tr>
              <tr>
                <td width="40%" align="left">&nbsp;</td>
                <td width="60%" align="left">
                <input type="submit" value="Create Account" name="B1" onclick="validatefrm2();">
                <input type="reset" value="Reset" name="B2"></td>
              </tr>
              <tr>
                <td width="40%" align="left">&nbsp;</td>
                <td width="60%" align="left">&nbsp;</td>
              </tr>
            </table>
            </form>
            <p>&nbsp;<%
              	}//end of create fixed deposite account
              	
              	if(acc_type.equals("rd"))
              	{
              	%>
              	<script type="text/javascript">
              	function validatefrm3()
              	{
              		if(document.rdaccfrm.rd_cif_no.value=="")
              		{
              		alert("please enter CIF number");
              		return;
              		}
              		if(document.rdaccfrm.rd_nominee_cif.value=="")
              		{
              		alert("please enter Nominee CIF number");
              		return;
              		}
              		if(document.rdaccfrm.rd_premium.value=="")
              		{
              		alert("please enter RD premium");
              		return;
              		}
              		if(isNaN(document.rdaccfrm.rd_premium.value)==true)
              		{
              		alert("please enter RD premium in number");
              		return;
              		}


				document.rdaccfrm.action="CreateFDRD.jsp";
              		
              	}
              	</script>

            <form name="rdaccfrm" method="post">
            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#0F57BB" width="60%">
              <tr>
                <td width="100%" bgcolor="#0F57BB" colspan="2" align="center">
                <b><font color="#FFFFFF">Create Recurring Deposit Account</font></b></td>
              </tr>
              <tr>
                <td width="40%" align="left">Enter CIF number</td>
                <td width="60%" align="left">
                <input type="text" name="rd_cif_no" size="20"></td>
              </tr>
              <tr>
                <td width="40%" align="left">Location</td>
                <td width="60%" align="left">
                <select size="1" name="rd_location">
                <option value="Urban" selected>Urban</option>
                <option value="Rural">Rural</option>
                </select></td>
              </tr>
              <tr>
                <td width="40%" align="left">Nominee CIF</td>
                <td width="60%" align="left">
                <input type="text" name="rd_nominee_cif" size="20"></td>
              </tr>
              <tr>
                <td width="40%" align="left">Time Duration</td>
                <td width="60%" align="left">
                <select size="1" name="rd_time_duration">
                <option selected value="12">12</option>
                <option value="24">24</option>
                <option value="36">36</option>
                <option value="48">48</option>
                <option value="60">60</option>
                <option value="72">72</option>
                <option value="84">84</option>
                <option value="96">96</option>
                <option value="108">108</option>
                <option value="120">120</option>
                </select> Months</td>
              </tr>
              <tr>
                <td width="40%" align="left">Premium Amount</td>
                <td width="60%" align="left">
                <!--webbot bot="Validation" s-data-type="Number" s-number-separators=",." --><input type="text" name="rd_premium" size="20"></td>
              </tr>
              <tr>
                <td width="40%" align="left">&nbsp;</td>
                <td width="60%" align="left">&nbsp;</td>
              </tr>
              <tr>
                <td width="40%" align="left">&nbsp;</td>
                <td width="60%" align="left">
                <input type="submit" value="Calculate" name="B1" onclick="validatefrm3();">
                <input type="reset" value="Reset" name="B2"></td>
              </tr>
              <tr>
                <td width="40%" align="left">&nbsp;</td>
                <td width="60%" align="left">&nbsp;</td>
              </tr>
            </table>
            </form>
            <p>&nbsp;<%
              	}//end of create recurring deposite account




              
              
              }//end of if
              %> </p>
            
            </center>
          </div>



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