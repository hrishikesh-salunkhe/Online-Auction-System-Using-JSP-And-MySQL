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
		
		String query = "INSERT INTO custRep VALUES ((?), (?), 'admin')";
		
		PreparedStatement ps = c.prepareStatement(query);
		ps.setString(1, custRepId);
		ps.setString(2, password);
		ps.executeUpdate();
		
		String queryCheck = "SELECT custRepId FROM custRep WHERE custRepId=(?) AND password=(?)";
		
		PreparedStatement psCheck = c.prepareStatement(queryCheck);
		psCheck.setString(1, custRepId);
		psCheck.setString(2, password);
		ResultSet result = psCheck.executeQuery();
		
		if (result.next()) {
			%>
			<jsp:forward page="adminMain.jsp">
			<jsp:param name="assignResponse" value="Insert Successful!"/> 
			</jsp:forward>
			<% //ABOVE: FORWARD TO HOME PAGE WITH CURRENT USERNAME ATTACHED
		} else {
			%>
			<jsp:forward page="adminMain.jsp">
			<jsp:param name="assignResponse" value="Insert Failed."/> 
			</jsp:forward>
			<%
		}
		
	} catch (Exception e) {
		%>
		<jsp:forward page="adminMain.jsp">
		<jsp:param name="assignResponse" value="Error assigning. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
</body>
</html>