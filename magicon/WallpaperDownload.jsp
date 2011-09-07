<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<style>
a{
	font-size : 16px;
	font-family : arial;
	font-weight: bold;
	color : #ffffff;
	text-decoration: none;
}
a:hover {
	color : #FF0000;
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Magicon Home page</title>
</head>

<body>
<jsp:useBean id="bean" class="com.magicon.MagiconBean" scope="request"/>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr><td>
<% 
	String user_src=(String)session.getValue("user");
	if (user_src!=null)
  	{
  	%>
  	<%@ include file="index1.html" %>
</tr>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr ><td bgcolor="#0F57BB" valign="middle" height="34" width="20%"><div align="center" ><font face="Arial Black" size="3" color="#FFFFFF">  
<%
	out.println("Hi "+user_src+".");
	//out.println("<br>"+session.getId());
	%>
	</font></div>
	</td>
	<td bgcolor="#0F57BB" valign="middle" height="34" width="48%"><div align="center" >
  	<font face="Arial Black" color="#FFFFFF">Download Wallpaper</font><font face="Arial Black" size="3" color="#FFFFFF">
  	</font></div>
	</td>

	<td bgcolor="#0F57BB" valign="middle" height="34" width="32%"><div align="center" >
    
       
    
    <b> <img border="0" src="images/myAcc1.png" width="20" height="20">
    <font color="#FFFFFF" face="Arial"><a href="myacc.jsp">My Account</a>&nbsp; </font></b><font face="Arial Black" size="3" color="#FFFFFF">  
	<a href="usersearch.jsp"><< Back to search</a>
	</font></div>
	</td>
	</table>

	<%
	}
	else
	{
	%>
  	<%@ include file="index.html" %>
</tr>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr ><td bgcolor="#0F57BB" valign="middle" height="34" width="20%"><div align="center" ><font face="Arial Black" size="3" color="#FFFFFF">  
<%

		//response.sendRedirect("Unauthorised.htm");
		out.println("Hi Guest");
		//out.println("<br>"+session.getId());
	%>
	</font></div>
	</td>
	<td bgcolor="#0F57BB" valign="middle" height="34" width="48%"><div align="center" >
  	<font face="Arial Black" color="#FFFFFF">Download Wallpaper</font><font face="Arial Black" size="3" color="#FFFFFF">
  	</font></div>
	</td>

	<td bgcolor="#0F57BB" valign="middle" height="34" width="32%"><div align="center" >
    
       
    
    <font face="Arial Black" size="3" color="#FFFFFF">  
	<a href="guestsearch.jsp"><< Back to search</a>
	</font></div>
	</td>
	</table>

	<%

		
	}
%>



</tr>


<tr><td>
<table width="100%" height="356"  style="border-collapse: collapse" border="1" cellpadding="2">
<tr><td width="18%" height="352">

		
<br><img border="0" src="images/adsbygoogle.png" width="78" height="16"><p>
<img border="0" src="images/mobiles-prices.gif" width="160" height="137"></p>
<p><img border="0" src="images/160x120.jpg" width="160" height="124">
</td>
<td width="67%" height="61" valign="top">
<div align="center">
  <center>





	


   		<span style="background-color: #0F57BB"><a href="WallpaperDownload.jsp">
        All</a>&nbsp; <a href="WallpaperDownload.jsp?filter=a">A</a></span><span style="background-color: #0F57BB">&nbsp;
        <a href="WallpaperDownload.jsp?filter=b">B</a></span><span style="background-color: #0F57BB">&nbsp;
        <a href="WallpaperDownload.jsp?filter=c">C</a>&nbsp; </span>
        <a href="WallpaperDownload.jsp?filter=d">
        <span style="background-color: #0F57BB">D</span></a><span style="background-color: #0F57BB">&nbsp;
        <a href="WallpaperDownload.jsp?filter=e">E</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=f">F</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=g">G</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=h">H</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=i">I</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=j">J</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=k">K</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=l">L</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=m">M</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=n">N</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=o">O</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=p">P</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=q">Q</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=r">R</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=s">S</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=t">T</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=u">U</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=v">V</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=w">W</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=x">X</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=y">Y</a>&nbsp;
        <a href="WallpaperDownload.jsp?filter=z">Z</a></span><br><b><font color="#FF0000">* To download 
        Wallpaper click right mouse 
        button on link and save target as </font></b>
</p>
        <p align="center"><font color="#000080" face="Arial"><b>List of 
        Available Wallpapers Are </b></font></p>
        <table border="1" cellspacing="0" width="90%" bordercolor="#C0C0C0" bordercolorlight="#C0C0C0" bordercolordark="#FFFFFF">
            
            
		<%
		Connection conn;
		conn=null;
		ResultSet rs;
		rs=null;
		
		String filter =request.getParameter("filter");
		if(filter!=null && filter!="")
		{
		filter=filter+"%";
		}
		else
		{
		filter="%";
		}
		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat = conn.prepareStatement("select * from wallpaper where w_title like ?");
		stat.setString(1,filter);
		rs=stat.executeQuery();
		
             
		while(rs.next())
		{
		
			
			
		%>
            
           
              
        <tr>
             
              <td width="12%" bgcolor="#C0C0C0" align="left"><a href="<%=rs.getString("w_path")%>">
              <img src="<%=rs.getString("w_path")%>" width="159" height="122"></a><%=rs.getString("w_title")%></td>
              <%
              if(rs.next())
              {
              %>
              
              <td width="12%" bgcolor="#C0C0C0" align="left"><a href="<%=rs.getString("w_path")%>">
              <img src="<%=rs.getString("w_path")%>" width="159" height="122"></a><%=rs.getString("w_title")%></td>
              <%
              }
              if(rs.next())
              {
              %>
              
              <td width="12%" bgcolor="#C0C0C0" align="left"><a href="<%=rs.getString("w_path")%>">
              <img src="<%=rs.getString("w_path")%>" width="159" height="122"></a><%=rs.getString("w_title")%></td>
              <%
              }
              if(rs.next())
              {
              %>
              
              <td width="12%" bgcolor="#C0C0C0" align="left"><a href="<%=rs.getString("w_path")%>">
              <img src="<%=rs.getString("w_path")%>" width="159" height="122"></a><%=rs.getString("w_title")%></td>
              <%
              }
              %>




              
        
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
          <p><font face="Arial" color="#000080"><b>End of&nbsp; List</b></font></p>




</center>
</div>








</td>
<td width="15%" height="352" valign="top" align="center" >
<p><img border="0" src="images/Online-Shopping.png" width="172" height="389"></p>
<p></td>
</table>

</tr>
<tr><td>
<%@ include file="footer.html" %>
</tr>
</table>

</body></html>