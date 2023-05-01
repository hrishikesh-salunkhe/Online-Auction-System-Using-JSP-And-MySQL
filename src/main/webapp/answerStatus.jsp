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
		
		String queryCheck = "UPDATE question SET solutionDetails=(?), custRepId=(?) WHERE questionId=(?)";
		
		PreparedStatement psCheck = c.prepareStatement(queryCheck);
		psCheck.setString(1, request.getParameter("solutionDetails"));
		psCheck.setString(2, session.getAttribute("custRepId").toString());
		psCheck.setString(3, request.getParameter("questionId"));
		psCheck.executeUpdate();
		
		%>
		<jsp:forward page="questions.jsp">
		<jsp:param name="answerResponse" value="Answer submitted successfully."/> 
		</jsp:forward>
		<%
		
		
	} catch (Exception e) {
		System.out.println(e);
		%>
		<jsp:forward page="questions.jsp">
		<jsp:param name="answerResponse" value="Error submitting your answer. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
</body>
</html>