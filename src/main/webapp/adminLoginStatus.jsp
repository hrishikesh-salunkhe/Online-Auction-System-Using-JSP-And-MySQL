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
		String adminId = request.getParameter("adminId");
		String password = request.getParameter("password");
		
		String query = "SELECT adminId, password FROM admin WHERE adminId=(?) AND password=(?)";
		
		PreparedStatement ps = c.prepareStatement(query);
		ps.setString(1, adminId);
		ps.setString(2, password);
		ResultSet result = ps.executeQuery();
		if (result.next()) {
			session.setAttribute("adminId", adminId);
			%>
			<jsp:forward page="adminMain.jsp">
			<jsp:param name="adminId" value="<%=adminId%>"/> 
			</jsp:forward>
			<% //ABOVE: FORWARD TO HOME PAGE WITH CURRENT USERNAME ATTACHED
		} else {
			%>
			<jsp:forward page="adminLogin.jsp">
			<jsp:param name="loginResponse" value="Incorrect username or password."/> 
			</jsp:forward>
			<%
		}
	} catch (Exception e) {
		%>
		<jsp:forward page="adminLogin.jsp">
		<jsp:param name="loginResponse" value="Error logging in. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
</body>
</html>