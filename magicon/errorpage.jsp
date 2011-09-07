<%@ page isErrorPage="true" import = "java.io.PrintWriter" %>
<html>
<head>
<title>
	ShoppingCart Error Page
</title>
</head>
<body>
	<h2>Error Page</h2>
	<br>
	<h4>An error has ocurred in the application</h4>
	<br><p>
	The stack trace of the error is:
	<p>
  	<%= exception.toString() %>
	<%-- exception.printStackTrace(new PrintWriter(out)); --%>
</body>
</html>	 
