<%@  page errorPage="errorpage.jsp" language="java"  import="com.cbs.*;"  %>
<html>

<head>
<title>New Page 1</title>
</head>
<jsp:useBean id="bean" scope="page" class="com.cbs.CIF" />
<body>
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
	
	//CIF bean=new CIF();
	String msg=bean.createNonPersonalCIF(request,session,branch);
		
%>


<p>Non Personal CIF created successfully</p>

<jsp:forward page="CIF.jsp">
<jsp:param name="msg" value="<%=msg%>"/>
</jsp:forward>

		
 		
</body>

</html>