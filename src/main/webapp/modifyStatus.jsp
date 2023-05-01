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
		
		/* Statement s = c.createStatement(); */
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		
		String queryCheck = "SELECT userId FROM user WHERE userId=(?)";
		
		PreparedStatement psCheck = c.prepareStatement(queryCheck);
		psCheck.setString(1, userId);
		ResultSet result = psCheck.executeQuery();
		
		if (result.next()) {
			
			String query = "UPDATE user SET password=(?) WHERE userId=(?)";
		
			PreparedStatement ps = c.prepareStatement(query);
			ps.setString(1, password);
			ps.setString(2, userId);
			ps.executeUpdate();
			
			LocalDateTime myDateObj = LocalDateTime.now();
			DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
			String formattedDate = myDateObj.format(myFormatObj);
		
			String insert_query = "INSERT INTO modifiedBy(userId, custRepId, datetime) VALUES ((?), (?), (?))";
			
			PreparedStatement insert_ps = c.prepareStatement(insert_query);
			insert_ps.setString(1, userId);
			insert_ps.setString(2, session.getAttribute("custRepId").toString());
			insert_ps.setString(3, formattedDate);
			insert_ps.executeUpdate();
			
			%>
			<jsp:forward page="viewModifyDelete.jsp">
			<jsp:param name="modifyResponse" value="Update Successful!"/> 
			</jsp:forward>
			<%
			
		} else {
			%>
			<jsp:forward page="viewModifyDelete.jsp">
			<jsp:param name="modifyResponse" value="User ID not found."/> 
			</jsp:forward>
			<%
		}
		
	} catch (Exception e) {
		System.out.println(e);
		%>
		<jsp:forward page="viewModifyDelete.jsp">
		<jsp:param name="modifyResponse" value="Error modifying. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
</body>
</html>