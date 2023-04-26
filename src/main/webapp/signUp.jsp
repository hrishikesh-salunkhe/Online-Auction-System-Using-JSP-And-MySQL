<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Sign Up Page</title>
</head>
<body>
<div align=center>
<h1>USER SIGN UP PAGE</h1>
</div>
<form action="signUpStatus.jsp" method="post">
<table>
<tr><td>User Id:</td><td><input required type=text maxlength=10 name=userId></td></tr>
<tr><td>Password:</td><td><input required type=password maxlength=20 name=password1></td></tr>
<tr><td>Re-enter Password:</td><td><input required type=password maxlength=20 name=password2></td></tr>
<tr><td><input type=Submit value="Sign Up"></td></tr>

<% if (request.getParameter("signUpResponse") != null) { %>
	<tr>
		<td><p><%=request.getParameter("signUpResponse")%></p></td>
	</tr>
<% } %>
</table>

<p> Existing User? </p> <a href="login.jsp">Click Here</a><br/>
<p> Admin? </p> <a href="adminLogin.jsp">Click Here</a><br/>
<p> Customer Representative? </p> <a href="custRepLogin.jsp">Click Here</a>
</form>
</body>
</html>