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
		
/* 		itemId INT NOT NULL AUTO_INCREMENT PRIMARY KEY, name VARCHAR(40),
		subcategory VARCHAR(40), length INT, breadth INT, colorType VARCHAR(20), 
        paintingStyle VARCHAR(20), description VARCHAR(100), artist VARCHAR(50),
        initialPrice FLOAT, minPrice FLOAT, closingDateTime VARCHAR(50),
		incrementAmount FLOAT, currentBid FLOAT, sellerId VARCHAR(10) NOT NULL, buyerId VARCHAR(10),
		FOREIGN KEY (sellerId) REFERENCES user(userId) */
		
		String name = request.getParameter("name");
		String subcategory = request.getParameter("subcategory");
		String length = request.getParameter("length");
		String breadth = request.getParameter("breadth");
		String colorType = request.getParameter("colorType");
		String paintingStyle = request.getParameter("paintingStyle");
		String description = request.getParameter("description");
		String artist = request.getParameter("artist");
		String initialPrice = request.getParameter("initialPrice");
		String minPrice = request.getParameter("minPrice");
		String sellerId = session.getAttribute("userId").toString();
		
		String query = "INSERT INTO auctionItem(name, subcategory, length, breadth, colorType, "
					+ "paintingStyle, description, artist, initialPrice, minPrice, sellerId) "
					+ "VALUES((?), (?), (?), (?), (?), (?), (?), (?), (?), (?), (?))";
		
		PreparedStatement ps = c.prepareStatement(query);
		ps.setString(1, name);
		ps.setString(2, subcategory);
		ps.setString(3, length);
		ps.setString(4, breadth);
		ps.setString(5, colorType);
		ps.setString(6, paintingStyle);
		ps.setString(7, description);
		ps.setString(8, artist);
		ps.setString(9, initialPrice);
		ps.setString(10, minPrice);
		ps.setString(11, sellerId);
		
		ps.executeUpdate();
		
		%>
		<jsp:forward page="main.jsp">
		<jsp:param name="auctionResponse" value="Item published successfully!"/> 
		</jsp:forward>
		<% //ABOVE: FORWARD TO HOME PAGE WITH CURRENT USERNAME ATTACHED

	} catch (Exception e) {
		%>
		<jsp:forward page="main.jsp">
		<jsp:param name="auctionResponse" value="Error publishing item. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
</body>
</html>