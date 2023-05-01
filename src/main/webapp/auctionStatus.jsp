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
		
		String name = request.getParameter("name");
		String subcategory = request.getParameter("subcategory");
		String length = request.getParameter("length");
		String breadth = request.getParameter("breadth");
		String colorType = request.getParameter("colorType");
		String description = request.getParameter("description");
		String artist = request.getParameter("artist");
		String initialPrice = request.getParameter("initialPrice");
		String closingDateTime = request.getParameter("closingDateTime");
		String incrementAmount = request.getParameter("incrementAmount");
		String minPrice = request.getParameter("minPrice");
		String sellerId = session.getAttribute("userId").toString();
		
		String query = "INSERT INTO auctionItem(name, subcategory, length, breadth, colorType, "
					+ "description, artist, initialPrice, closingDateTime, incrementAmount, minPrice, sellerId, isClosed) "
					+ "VALUES((?), (?), (?), (?), (?), (?), (?), (?), (?), (?), (?), (?), (?))";
		
		PreparedStatement ps = c.prepareStatement(query);
		ps.setString(1, name);
		ps.setString(2, subcategory);
		ps.setString(3, length);
		ps.setString(4, breadth);
		ps.setString(5, colorType);
		ps.setString(6, description);
		ps.setString(7, artist);
		ps.setString(8, initialPrice);
		ps.setString(9, closingDateTime);
		ps.setString(10, incrementAmount);
		ps.setString(11, minPrice);
		ps.setString(12, sellerId);
		ps.setString(13, "N");
		
		ps.executeUpdate();
		
		%>
		<jsp:forward page="main.jsp">
		<jsp:param name="auctionResponse" value="Item published successfully!"/> 
		</jsp:forward>
		<% //ABOVE: FORWARD TO HOME PAGE WITH CURRENT USERNAME ATTACHED

	} catch (Exception e) {
		System.out.println(e);
		%>
		<jsp:forward page="main.jsp">
		<jsp:param name="auctionResponse" value="Error publishing item. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
</body>
</html>