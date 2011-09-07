<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Register new user</title>
</head>
<script type="text/javascript">
function checkAvailability()
{
		if(document.frm.userid.value=="")
		{
  			alert("UserName cannot be blank!!");
			return;
  		}
  		if(document.frm.userid.value=="Guest")
		{
  			alert("UserName cannot be Guest!!");
			return;
  		}
  		
		var myurl="checkavailability.jsp?userid="+document.frm.userid.value;
  	  	window.open(myurl,"check","width=350,height=225");
}
</script>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="index2.html" %></td>
  </tr>
  <tr>
    <td>
    <form action="Sign.jsp" method="post" name="frm">
	&nbsp;
	<div align="center">
      <center>
      <table border="1" bordercolor="#0F57BB" width="60%">
        <tr>
          <td width="100%" colspan="2" bgcolor="#0F57BB" style="border-right-color: #0F57BB; border-right-width: 1; border-top-color: #0F57BB; border-top-width: 1">
          <p align="left"><font color="#FFFFFF">Registration:</font></td>
        </tr>
        <tr>
          <td width="100%" align="left" colspan="2"><font size="2">Register with 
          us and enjoy the experience of Online Shopping just a click away. 
          Please fill all details marked as *</font></td>
        </tr>
        <tr>
          <td width="100%" align="left" colspan="2" bgcolor="#0F57BB">
          <font color="#FFFFFF">Account Information:</font></td>
        </tr>
        <tr>
          <td width="26%" align="left">User Id*:</td>
          <td width="74%" align="left" style="border-style: solid; border-width: 1">
          <input type="text" name="userid" size="20"> <label>
          <input name="check" type="button" id="check" value="check availability" onclick="checkAvailability();" />
          </label></td>
        </tr>
        <tr>
          <td width="26%" align="left">First name*:</td>
          <td width="74%" align="left" style="border-right-color: #0F57BB; border-right-width: 1">
          <input type="text" name="firstname" size="20"></td>
        </tr>
        <tr>
          <td width="26%" align="left">Last name:</td>
          <td width="74%" align="left" style="border-right-color: #0F57BB; border-right-width: 1">
          <input type="text" name="lastname" size="20"></td>
        </tr>
        <tr>
          <td width="26%" align="left">Password*:</td>
          <td width="74%" align="left" style="border-right-color: #0F57BB; border-right-width: 1">
          <input type="password" name="password" size="20"></td>
        </tr>
        <tr>
          <td width="26%" align="left">Re enter Password*:</td>
          <td width="74%" align="left" style="border-right-color: #0F57BB; border-right-width: 1">
          <input type="password" name="password1" size="20"></td>
        </tr>
        <tr>
          <td width="26%" align="left">Hint Question:</td>
          <td width="74%" align="left" style="border-right-color: #0F57BB; border-right-width: 1">
          <select size="1" name="hintq">
          <option selected>select question</option>
          <option value="what is your pet name">what is your pet name</option>
          <option value="what is your favorite colour">what is your favorite colour
          </option>
          </select></td>
        </tr>
        <tr>
          <td width="26%" align="left">Hint Answer*:</td>
          <td width="74%" align="left" style="border-right-color: #0F57BB; border-right-width: 1">
          <input type="text" name="hintans" size="20"></td>
        </tr>
        <tr>
          <td width="100%" align="left" colspan="2" bgcolor="#0F57BB">
          <font color="#FFFFFF">Personal information:</font></td>
        </tr>
        <tr>
          <td width="26%" align="left">Date of Birth*:</td>
          <td width="74%" align="left" style="border-right-color: #0F57BB; border-right-width: 1">
          <select name="day" size="1" id="day">
          <option>day</option>
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
          </select><select size="1" name="month">
          <option selected value="month">month</option>
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
          </select><select size="1" name="year">
          <option selected>year</option>
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
          </select></td>
        </tr>
        <tr>
          <td width="26%" align="left">Gender*:</td>
          <td width="74%" align="left" style="border-right-color: #0F57BB; border-right-width: 1">
          Male<input type="radio" value="male" checked name="gender"> Female <input type="radio" name="gender" value="female"></td>
        </tr>
        <tr>
          <td width="26%" align="left">Occupation:</td>
          <td width="74%" align="left" style="border-right-color: #0F57BB; border-right-width: 1">
          <select size="1" name="occupation">
          <option selected value="business">business</option>
          <option value="student">student</option>
          <option value="service">service</option>
          </select></td>
        </tr>
        <tr>
          <td width="26%" align="left">Email*:</td>
          <td width="74%" align="left" style="border-right-color: #0F57BB; border-right-width: 1">
          <input type="text" name="email" size="39"></td>
        </tr>
        <tr>
          <td width="26%" align="left">Address*:</td>
          <td width="74%" align="left" style="border-right-color: #0F57BB; border-right-width: 1">
          <textarea rows="3" name="address" cols="33"></textarea></td>
        </tr>
        <tr>
          <td width="26%" align="left">Nationality*:</td>
          <td width="74%" align="left" style="border-right-color: #0F57BB; border-right-width: 1">
          <select size="1" name="nationality">
          <option selected value="indian">indian</option>
          <option value="pakistani">pakistani</option>
          </select></td>
        </tr>
        <tr>
          <td width="26%" align="left">Phone:</td>
          <td width="74%" align="left" style="border-right-color:#0F57BB; border-right-width: 1">
          <input type="text" name="phone" size="20"></td>
        </tr>
        <tr>
          <td width="26%" align="left">Mobile*:</td>
          <td width="74%" align="left" style="border-right-color: #0F57BB; border-right-width: 1">
          <input type="text" name="mobile" size="20"></td>
        </tr>
        <tr>
          <td width="26%" align="left">&nbsp;</td>
          <td width="74%" align="left" style="border-right-color: #0F57BB; border-right-width: 1">
          <input type="submit" value="Submit" name="B1"> <input type="reset" value="Reset" name="B2"></td>
        </tr>
      </table>
      </center>
    </div>
	</form>
	
	</td>
  </tr>
  <tr><td>&nbsp;
  </td></tr>
  <tr><td>
<%@ include file="footer.html" %>
<%=new java.util.Date() %>
</tr>
</table>
<p>&nbsp;</p>
</body>
</html>