<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Magicon Home page</title>
</head>

<body>
<% 
	String user_src=(String)session.getValue("user");
	
	if(user_src!=null && user_src.equals("Administrator"))
	{
		
		response.sendRedirect(response.encodeRedirectURL("ViewAll.jsp"));
	}
	else if(user_src!=null)
	{
		response.sendRedirect(response.encodeRedirectURL("usersearch.jsp"));
		
	}
%>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr><td>
<%@ include file="index.html" %>
</tr>
<tr><td>
<%@ include file="guestmenu.html" %>
</tr>
<tr><td>
		<jsp:include page="searchform.jsp" >
			<jsp:param name="userid" value="Guest"/>
			<jsp:param name="action_path" value="guestsearch.jsp"/>
		</jsp:include>
</tr>

<tr><td>
<table width="100%" height="356"  style="border-collapse: collapse" border="0" cellpadding="2">
<tr><td width="20%" height="352">

		<jsp:include page="advancesearch_form.jsp" >
			<jsp:param name="userid" value="Guest"/>
			<jsp:param name="action_path" value="guestsearch.jsp"/>
		</jsp:include>


<br><img border="0" src="images/adsbygoogle.png" width="78" height="16"><p>
<img border="0" src="images/mobiles-prices.gif" width="160" height="137"></p>
<p><img border="0" src="images/160x120.jpg" width="160" height="124">
</td>
<td width="60%" height="61" valign="top">
<%@ include file="banner.html" %>
<p align="center">
&nbsp;<div align="center">
  <center>
  <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="90%">
    <tr>
      <td width="33%" rowspan="2">
      <img border="0" src="images/3-anniversery-offer-2010-WEB-BANNER.jpg" width="184" height="338"></td>
      <td width="33%" align="center" valign="top">
      <img border="0" src="images/3Anniversery185x57.jpg" width="184" height="74"></td>
      <td width="34%" rowspan="2">
      <img border="0" src="images/gifting.gif" width="200" height="340"></td>
    </tr>
    <tr>
      <td width="33%" align="center">
      <img border="0" src="images/1_SamsungS3370Nano_pbilogo.jpg" width="100" height="100"><p>
      <b><font size="4" face="Comic Sans MS" color="#0000FF">Magocon Mobiles</font></b></td>
    </tr>
  </table>
  </center>
</div>
</td>
<td width="20%" height="352" valign="top" align="center" >
<a href="register.jsp" >
<img border="0" src="images/Register.jpg" width="166" height="73" alt="Register to Magicon Online Shopping"></a>
<p>&nbsp;</p>
<p><img border="0" src="images/Online-Shopping.png" width="198" height="389"></p>
<p></td>
</table>

</tr>
<tr><td>
<%@ include file="footer.html" %>
</tr>
</table>

<p> hello how are you magicon</body></html>