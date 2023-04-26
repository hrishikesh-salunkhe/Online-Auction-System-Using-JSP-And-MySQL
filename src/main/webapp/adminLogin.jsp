<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login Page</title>
</head>
<body>
<div align=center>
<h1>ADMIN LOGIN PAGE</h1>
</div>
<form action="adminLoginStatus.jsp" method="post">
<table>
<tr><td>Admin Id:</td><td><input type=text maxlength=10 name=adminId></td></tr>
<tr><td>Password:</td><td><input type=password maxlength=20 name=password></td></tr>
<tr><td><input type=Submit value=login></td></tr>

<% if (request.getParameter("loginResponse") != null) { %>
	<tr>
		<td><p><%=request.getParameter("loginResponse")%></p></td>
	</tr>
<% } %>
</table>

<p> User? <a href="login.jsp">Click Here</a></p> 
<p> Customer Representative? <a href="custRepLogin.jsp">Click Here</a></p> 
</form>
</body>
</html>