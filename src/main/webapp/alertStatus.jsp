<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="DBDS.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert a title here</title>
</head>
<body>
<%
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection c = db.getConnection();
		
		String userId = session.getAttribute("userId").toString();
		
		String subcategory = request.getParameter("subcategory");
		String lengthFrom = request.getParameter("lengthFrom");
		String breadthFrom = request.getParameter("breadthFrom");
		String lengthTo = request.getParameter("lengthTo");
		String breadthTo = request.getParameter("breadthTo");
		String colorType = request.getParameter("colorType");
		String initialPriceFrom = request.getParameter("initialPriceFrom");
		String initialPriceTo = request.getParameter("initialPriceTo");
		
		String query = "INSERT INTO listingAlerts(userId, subcategory, lengthFrom, lengthTo,"
						+ " breadthFrom, breadthTo, colorType, initialPriceFrom, initialPriceTo)"
						+ " VALUES((?), (?), (?), (?), (?), (?), (?), (?), (?))";
				
		PreparedStatement ps = c.prepareStatement(query);
		
		ps.setString(1, userId);
		ps.setString(2, subcategory);
		ps.setString(3, lengthFrom);
		ps.setString(4, lengthTo);
		ps.setString(5, breadthFrom);
		ps.setString(6, breadthTo);
		ps.setString(7, colorType);
		ps.setString(8, initialPriceFrom);
		ps.setString(9, initialPriceTo);
		
		ps.executeUpdate();
		
		%>
		<jsp:forward page="main.jsp">
		<jsp:param name="alertResponse" value="Listing alert set successfully!"/> 
		</jsp:forward>
		<%
		
	} catch (Exception e) {
		System.out.println(e);
		%>
		<jsp:forward page="main.jsp">
		<jsp:param name="alertResponse" value="Error setting listing alert. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
	
</body>
</html>