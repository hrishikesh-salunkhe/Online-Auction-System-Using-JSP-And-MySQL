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
		
		String query = "SELECT userId, password FROM user WHERE userId=(?) AND password=(?)";
		
		PreparedStatement ps = c.prepareStatement(query);
		ps.setString(1, userId);
		ps.setString(2, password);
		ResultSet result = ps.executeQuery();
		if (result.next()) {
			session.setAttribute("userId", userId);
			%>
			<jsp:forward page="main.jsp">
			<jsp:param name="userId" value="<%=userId%>"/> 
			</jsp:forward>
			<% //ABOVE: FORWARD TO HOME PAGE WITH CURRENT USERNAME ATTACHED
		} else {
			%>
			<jsp:forward page="login.jsp">
			<jsp:param name="loginResponse" value="Incorrect username or password."/> 
			</jsp:forward>
			<%
		}
	} catch (Exception e) {
		%>
		<jsp:forward page="login.jsp">
		<jsp:param name="loginResponse" value="Error logging in. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
</body>
</html>