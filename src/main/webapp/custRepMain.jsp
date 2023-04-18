<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Representative Panel</title>
</head>
<body>
	<h1> Welcome to the Customer Representative Panel! </h1>
	
	<h2>Change a user's password:</h2>
	
	<form action="modifyStatus.jsp" method="post">

		<table>
			
			<tr><td>Enter userId:</td><td><input type=text maxlength=10 name=userId></td></tr>
			<tr><td>Enter new Password:</td><td><input type=password maxlength=20 name=password></td></tr>
			<tr><td><input type=Submit value=Modify></td></tr>
			
			<% if (request.getParameter("modifyResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("modifyResponse")%></p></td>
				</tr>
			<% } %>
		
		</table>
	
	</form>
		
	<a href="custRepLogout.jsp">Logout</a>
</body>
</html>