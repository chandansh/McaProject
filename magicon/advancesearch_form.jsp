<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
String userid=request.getParameter("userid");
String form_action_path=request.getParameter("action_path");

%>

<script language="JavaScript">
function validateadv()
{
if(document.advsearchform.pd_brand.value=="")
{
alert("please select any Brand");
return;
}
document.advsearchform.action="<%=form_action_path%>";
document.advsearchform.submit();
}

</script>


<table width="223" height="367" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <th width="18" height="35" nowrap="nowrap" background="images/leftcorner.png">&nbsp;</th>
    <th width="180" height="35" nowrap="nowrap" background="images/menu1.png">
    <font color="#FFFF99" face="Arial" size="4">Hi <%=userid%></font></th>
    <th width="18" height="35" nowrap="nowrap" background="images/rightcorner.png">&nbsp;</th>
  </tr>
  <tr>
    <td height="298" colspan="3" bordercolor="#0033CC">
    
    <form id="advsearchform" name="advsearchform" method="post"  >
      <table width="100%" height="100%" border="2" cellpadding="0" cellspacing="0" bordercolor="005FF8">
        <tr>
          <td height="300"><table width="100%" height="100%" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
              <td><div align="center" class="style2"> Advance Search&nbsp; <img border="0" src="images/New_icon.gif" width="25" height="9"> </div></td>
            </tr>
            <tr>
              <td><label>
                <input name="price_range" type="radio" value="All Prices" checked />
              All Prices </label></td>
            </tr>
            <tr>
              <td><label>
                <input name="price_range" type="radio" value="0 to 5000" />
              0 to 5,000 </label></td>
            </tr>
            <tr>
              <td><input name="price_range" type="radio" value="5000 to 10000" />
5,000 to 10,000 </td>
            </tr>
            <tr>
              <td><input name="price_range" type="radio" value="10000 to 15000" /> 
              10,000 to 15,000 </td>
            </tr>
            <tr>
              <td><input name="price_range" type="radio" value="15000 to above" />
15,000 to above </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><span class="style2">Select Brand</span> </td>
            </tr>
            <tr>
              <td><select size="1" name="pd_brand">
              <option selected value="All Brand">All Brand</option>
              <option value="Nokia">Nokia</option>
              <option value="Sony Ericsson">Sony Ericsson</option>
              <option value="Samsung">Samsung</option>
              <option value="LG">LG</option>
              <option value="Motorola">Motorola</option>
              <option value="Blackberry">Blackberry</option>
              <option value="Spice">Spice</option>
              <option value="Micromax">Micromax</option>
              <option value="Fly">Fly</option>
              <option value="htc">htc</option>
              <option value="Matrix">Matrix</option>
              <option value="Philips">Philips</option>
              <option value="Ipod">Ipod</option>
              <option value="Jabra">Jabra</option>
              <option value="Kingston">Kingston</option>
              <option value="Sandisk">Sandisk</option>
              <option value="Transcend">Transcend</option>
              <option value="other">other</option>
              </select><label>
                </label></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><label>
                <div align="center">
                  <input type="submit" name="Submit" value="Search" onclick="validateadv();"/>
                  </div>
              </label></td>
            </tr>
          </table></td>
        </tr>
      </table>
	</form>    </td>
  </tr>
  <tr>
    <td width="18" height="35" background="images/leftcornerbottom.png">&nbsp;</td>
    <td height="35" background="images/menu1.png">&nbsp;</td>
    <td width="18" height="35" background="images/rightcornerbottom.png">&nbsp;</td>
  </tr>
</table>
<p>&nbsp;</p>