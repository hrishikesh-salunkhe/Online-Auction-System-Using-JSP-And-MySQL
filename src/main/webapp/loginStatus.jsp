<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="DBDS.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection c = db.getConnection();
		
		/* Statement s = c.createStatement(); */
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		
		String query = "SELECT userId, password FROM user WHERE userId=(?) AND password=(?)";
		
		PreparedStatement ps = c.prepareStatement(query);
		ps.setString(1, userId);
		ps.setString(2, password);
		ResultSet result = ps.executeQuery();
		if (result.next()) {
			session.setAttribute("userId", userId);
			%>
			<jsp:forward page="main.jsp">
			<jsp:param name="userId" value="<%=userId%>"/> 
			</jsp:forward>
			<% //ABOVE: FORWARD TO HOME PAGE WITH CURRENT USERNAME ATTACHED
		} else {
			%>
			<jsp:forward page="login.jsp">
			<jsp:param name="loginResponse" value="Incorrect username or password."/> 
			</jsp:forward>
			<%
		}
	} catch (Exception e) {
		%>
		<jsp:forward page="login.jsp">
		<jsp:param name="loginResponse" value="Error logging in. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
</body>
</html>