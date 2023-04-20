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
		

		String questionId = request.getParameter("questionId");
		String solutionDetails = request.getParameter("solutionDetails");
		
		String queryCheck = "SELECT questionId FROM question WHERE questionId=(?)";
		
		PreparedStatement psCheck = c.prepareStatement(queryCheck);
		psCheck.setString(1, questionId);
		ResultSet result = psCheck.executeQuery();
			
		if (result.next()) {
			
			String query = "UPDATE question SET solutionDetails=(?), custRepId=(?) WHERE questionId=(?)";
		
			PreparedStatement ps = c.prepareStatement(query);
			ps.setString(1, solutionDetails);
			ps.setString(2, session.getAttribute("custRepId").toString());
			ps.setString(3, questionId);
			ps.executeUpdate();
			

			String queryCheck2 = "SELECT solutionDetails FROM question WHERE questionId=(?) AND solutionDetails=(?)";
			
			PreparedStatement psCheck2 = c.prepareStatement(queryCheck2);
			psCheck2.setString(1, questionId);
			psCheck2.setString(2, solutionDetails);
			ResultSet result2 = psCheck2.executeQuery();
			
			if (result2.next()) {
				%>
				<jsp:forward page="custRepMain.jsp">
				<jsp:param name="solutionResponse" value="Solution submitted."/> 
				</jsp:forward>
				<%
			}
			else{
				%>
				<jsp:forward page="custRepMain.jsp">
				<jsp:param name="solutionResponse" value="Failed to submit solution. Please try again."/> 
				</jsp:forward>
				<%
			}
		}
	} catch (Exception e) {
		System.out.println(e);
		%>
		<jsp:forward page="custRepMain.jsp">
		<jsp:param name="solutionResponse" value="Error submitting solution. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
</body>
</html>