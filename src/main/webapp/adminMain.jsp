<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Panel</title>
</head>
<body>
	<h1> Welcome to the Admin Panel! </h1>
	
	<h2>Assign a new Customer Representative:</h2>
	
	<br/>
	
<form action="assignStatus.jsp" method="post">

	<table>
		
		<tr><td>Enter a custRepId:</td><td><input type=text maxlength=10 name=custRepId></td></tr>
		<tr><td>Enter a Password:</td><td><input type=password maxlength=20 name=password></td></tr>
		<tr><td><input type=Submit value=Insert></td></tr>
		
		<% if (request.getParameter("assignResponse") != null) { %>
			<tr>
				<td><p><%=request.getParameter("assignResponse")%></p></td>
			</tr>
		<% } %>
	
	</table>

</form>
	
	<a href="adminLogout.jsp">Logout</a>
</body>
</html>