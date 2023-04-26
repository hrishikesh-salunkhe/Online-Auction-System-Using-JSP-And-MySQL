<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Login Page</title>
</head>
<body>
<div align=center>
<h1>USER LOGIN PAGE</h1>
</div>
<form action="loginStatus.jsp" method="post">
<table>
<tr><td>User Id:</td><td><input type=text maxlength=10 name=userId></td></tr>
<tr><td>Password:</td><td><input type=password maxlength=40 name=password></td></tr>
<tr><td><input type=Submit value=login></td></tr>

<% if (request.getParameter("loginResponse") != null) { %>
	<tr>
		<td><p><%=request.getParameter("loginResponse")%></p></td>
	</tr>
<% } %>

<% if (request.getParameter("deleteResponse") != null) { %>
	<tr>
		<td><p><%=request.getParameter("deleteResponse")%></p></td>
	</tr>
<% } %>

</table>

<p> New User? <a href="signUp.jsp">Create Account</a> </p>
<p> Admin? <a href="adminLogin.jsp">Click Here</a> </p> 
<p> Customer Representative? <a href="custRepLogin.jsp">Click Here</a> </p>
</form>
</body>
</html>