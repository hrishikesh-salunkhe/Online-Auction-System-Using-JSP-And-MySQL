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
		String custRepId = request.getParameter("custRepId");
		String password = request.getParameter("password");
		
		String query = "SELECT custRepId, password FROM custRep WHERE custRepId=(?) AND password=(?)";
		
		PreparedStatement ps = c.prepareStatement(query);
		ps.setString(1, custRepId);
		ps.setString(2, password);
		ResultSet result = ps.executeQuery();
		if (result.next()) {
			session.setAttribute("custRepId", custRepId);
			%>
			<jsp:forward page="custRepMain.jsp">
			<jsp:param name="custRepId" value="<%=custRepId%>"/> 
			</jsp:forward>
			<% //ABOVE: FORWARD TO HOME PAGE WITH CURRENT USERNAME ATTACHED
		} else {
			%>
			<jsp:forward page="custRepLogin.jsp">
			<jsp:param name="loginResponse" value="Incorrect username or password."/> 
			</jsp:forward>
			<%
		}
	} catch (Exception e) {
		%>
		<jsp:forward page="custRepLogin.jsp">
		<jsp:param name="loginResponse" value="Error logging in. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
</body>
</html>