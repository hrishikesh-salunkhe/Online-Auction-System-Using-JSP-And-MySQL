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
		
		String userId = session.getAttribute("userId").toString();
		
		session.invalidate();
		
		String query = "DELETE FROM user WHERE userId=(?)";
		
		PreparedStatement ps = c.prepareStatement(query);
		ps.setString(1, userId);
		
		ps.executeUpdate();
		
		%>
		<jsp:forward page="login.jsp">
		<jsp:param name="deleteResponse" value="Account deleted successfully."/> 
		</jsp:forward>
		<%
		
	} catch (Exception e) {
		
		%>
		<jsp:forward page="deleteStatus.jsp">
		<jsp:param name="deleteResponse" value="Error deleting account. Please try again."/> 
		</jsp:forward>
		<%
		
	}
%>
</body>
</html>