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
		String questionDetails = request.getParameter("questionDetails");
		
		String query = "INSERT INTO question(userId, questionDetails) VALUES((?), (?))";
		
		PreparedStatement ps = c.prepareStatement(query);
		ps.setString(1, session.getAttribute("userId").toString());
		ps.setString(2, questionDetails);
		ps.executeUpdate();
		
		String queryCheck = "SELECT questionDetails FROM question WHERE userId=(?) AND questionDetails=(?)";
		
		PreparedStatement psCheck = c.prepareStatement(queryCheck);
		psCheck.setString(1, session.getAttribute("userId").toString());
		psCheck.setString(2, questionDetails);
		ResultSet result = psCheck.executeQuery();
		
		if (result.next()) {
			%>
			<jsp:forward page="main.jsp">
			<jsp:param name="questionResponse" value="Question submitted."/> 
			</jsp:forward>
			<%
		}
		else{
			%>
			<jsp:forward page="main.jsp">
			<jsp:param name="questionResponse" value="Failed to submit question. Please try again."/> 
			</jsp:forward>
			<%
		}
	} catch (Exception e) {
		System.out.println(e);
		%>
		<jsp:forward page="main.jsp">
		<jsp:param name="questionResponse" value="Error submitting question. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
</body>
</html>