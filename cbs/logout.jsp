<%@  page errorPage="errorpage.jsp" language="java" %>
<html>

<head>
<title>LogOut</title>
</head>

<body>

	<%
	
	String user_src=(String)session.getAttribute("user");
	if (user_src!=null)
  	{
	session.removeAttribute("user");
	session.invalidate();
	%>
	<!-- <center>
	<BR><BR><BR><BR><b>You have logged out successfully.
        <BR><BR>Return to Sign in? <a href="signin.jsp">Click here</a></b>
        <b>Return to Home Page? <a href="index.jsp">Click here</a> -->
        
        <jsp:forward page="index.jsp">
		<jsp:param name="logoutmsg" value="<b><font color='Green'>You have logged out successfully.</font></b>"/>
		</jsp:forward>

	<%
	}
	else
	{
	%>
	<!--<center>
	</b><BR><BR><BR><BR><b><font color="Red">Error: Session Is Not Started Or Already Expired </font>
	<BR><BR>Return to Sign in? <a href="signin.jsp">Click here</a></b><br>
    <b>Return to Home Page? <a href="index.jsp">Click here</a></b>-->
    
    	<jsp:forward page="index.jsp">
		<jsp:param name="logoutmsg" value="<b><font color='Red'>Error: Session Is Not Started Or Already Expired </font><b>"/>
		</jsp:forward>

	<%
	}
	
	%>
        
</body>

</html>