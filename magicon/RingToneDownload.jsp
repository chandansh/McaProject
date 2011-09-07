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
  	<font face="Arial Black" color="#FFFFFF">Download Ringtone</font><font face="Arial Black" size="3" color="#FFFFFF">
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
  	<font face="Arial Black" color="#FFFFFF">Download Ringtone</font><font face="Arial Black" size="3" color="#FFFFFF">
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





	


   		<span style="background-color: #0F57BB"><a href="RingToneDownload.jsp">
        All</a>&nbsp; <a href="RingToneDownload.jsp?filter=a">A</a></span><span style="background-color: #0F57BB">&nbsp;
        <a href="RingToneDownload.jsp?filter=b">B</a></span><span style="background-color: #0F57BB">&nbsp;
        <a href="RingToneDownload.jsp?filter=c">C</a>&nbsp; </span>
        <a href="RingToneDownload.jsp?filter=d">
        <span style="background-color: #0F57BB">D</span></a><span style="background-color: #0F57BB">&nbsp;
        <a href="RingToneDownload.jsp?filter=e">E</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=f">F</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=g">G</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=h">H</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=i">I</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=j">J</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=k">K</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=l">L</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=m">M</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=n">N</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=o">O</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=p">P</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=q">Q</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=r">R</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=s">S</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=t">T</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=u">U</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=v">V</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=w">W</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=x">X</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=y">Y</a>&nbsp;
        <a href="RingToneDownload.jsp?filter=z">Z</a></span><br><b><font color="#FF0000">* To download Ring Tone click right mouse 
        button on link and save target as </font></b>
</p>
        <p align="center"><font color="#000080" face="Arial"><b>List of 
        Available Ring Tones Are </b></font></p>
        <table border="1" cellspacing="0" width="90%" bordercolor="#C0C0C0" bordercolorlight="#C0C0C0" bordercolordark="#FFFFFF">
            <tr>
              <th width="6%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Sr no</font></th>
              <th width="14%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Ring Tone Title</font></th>
              <th width="13%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Ring Tone Album</font></th>
              <th width="12%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Ring Tone file</font></th>
              <th width="19%" bgcolor="#808080" align="center">
              <font color="#FFFFFF">Play</font></th>
             
            </tr>
            
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
		PreparedStatement stat = conn.prepareStatement("select * from ringtones where r_title like ?");
		stat.setString(1,filter);
		rs=stat.executeQuery();
		while(rs.next())
		{

		%>
            
            <tr>
              <td width="6%" bgcolor="#F3F2F1" align="left"><%=rs.getString("r_id")%>&nbsp;</td>
              <td width="14%" bgcolor="#F3F2F1" align="left"><%=rs.getString("r_title")%>&nbsp;</td>
              <td width="13%" bgcolor="#F3F2F1" align="left"><%=rs.getString("r_album")%>&nbsp;</td>
              <td width="12%" bgcolor="#C0C0C0" align="left"><a href="<%=rs.getString("r_path")%>">DownLoad</a>&nbsp;</td>
              <td width="19%" bgcolor="#F3F2F1" align="left"><object type="application/x-shockwave-flash" data="player.swf" width="290" height="24" id="audioplayer1"><param name="movie" value="player.swf" /><param name="FlashVars" value="playerID=1&amp;bg=0xFFFFFF&amp;leftbg=0xFF8B00&amp;lefticon=0xFFFFFF&amp;rightbg=0xF9B41B&amp;rightbghover=0x999999&amp;righticon=0xFFFFFF&amp;righticonhover=0xffffff&amp;text=0x999999&amp;slider=0xE52C00&amp;track=0xFFFFFF&amp;border=0x666666&amp;loader=0xDDDDDD&amp;soundFile=<%=rs.getString("r_path")%>" /><param name="quality" value="high" /><param name="menu" value="True" /><param name="wmode" value="transparent" /></object>

&nbsp;</td>
              
           

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