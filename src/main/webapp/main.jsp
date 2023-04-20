<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Dashboard</title>
</head>
<body>
	<h1> Welcome to the Online Auction System! </h1>
	
	<h2> Ask a question: </h2>
	
	<form action="questionStatus.jsp" method="post">
		<table>
			<tr><td>Question:</td><td><input type=text maxlength=100 name=questionDetails></td></tr>
			<tr><td><input type=Submit value=Submit></td></tr>
			
			<% if (request.getParameter("questionResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("questionResponse")%></p></td>
				</tr>
			<% } %>
		</table>
	</form>
	<a href="logout.jsp">Logout</a>
</body>
</html>