<%@  page errorPage="errorpage.jsp" language="java" %>
<html>

<head>
<title>LogOut</title>
</head>

<body>

	<%
	String user_src=(String)session.getValue("user");
	if (user_src!=null)
  	{
	session.putValue("user",null);
	session.invalidate();
	%>
	<center>
	<BR><BR><BR><BR><b>You have logged out successfully.
        <BR><BR>Return to Sign in? <a href="signin.jsp">Click here</a></b>
        <b>Return to Home Page? <a href="index.jsp">Click here</a>
	<%
	}
	else
	{
	%>
	<center>
	</b><BR><BR><BR><BR><b><font color="Red">Error: Session Is Not Started Or Already Expired </font>
	<BR><BR>Return to Sign in? <a href="signin.jsp">Click here</a></b><br>
    <b>Return to Home Page? <a href="index.jsp">Click here</a></b>
	<%
	}
	
	%>
        
</body>

</html>