<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,
				java.time.LocalDateTime,java.time.format.DateTimeFormatter"%>
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
		
		String queryCheck = "DELETE FROM user WHERE userId=(?)";
		
		PreparedStatement psCheck = c.prepareStatement(queryCheck);
		psCheck.setString(1, request.getParameter("userId"));
		
		psCheck.executeUpdate();
		
		
		%>
		<jsp:forward page="viewModifyDelete.jsp">
		<jsp:param name="userDeleteResponse" value="User account deleted successfully."/> 
		</jsp:forward>
		<%
		
	} catch (Exception e) {
		System.out.println(e);
		%>
		<jsp:forward page="viewModifyDelete.jsp">
		<jsp:param name="userDeleteResponse" value="Error deleting user account. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
</body>
</html>