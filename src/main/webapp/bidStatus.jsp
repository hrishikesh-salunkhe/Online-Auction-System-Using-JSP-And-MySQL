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
		

		String itemId = request.getParameter("itemId");
		String bidAmount = request.getParameter("bidAmount");
		String userId = session.getAttribute("userId").toString();
		
		String queryCheck = "SELECT itemId FROM auctionItem WHERE itemId=(?)";
		
		PreparedStatement psCheck = c.prepareStatement(queryCheck);
		psCheck.setString(1, itemId);
		ResultSet result = psCheck.executeQuery();
			
		if (result.next()) {
			
			String query = "UPDATE auctionItem SET currentBid=(?), buyerId=(?) WHERE itemId=(?)";
		
			PreparedStatement ps = c.prepareStatement(query);
			ps.setString(1, bidAmount);
			ps.setString(2, userId);
			ps.setString(3, itemId);
			ps.executeUpdate();
			
			%>
			<jsp:forward page="main.jsp">
			<jsp:param name="bidResponse" value="Bid placed successfully!"/> 
			</jsp:forward>
			<% //ABOVE: FORWARD TO HOME PAGE WITH CURRENT USERNAME ATTACHED
			
		}else{
			
			%>
			<jsp:forward page="main.jsp">
			<jsp:param name="bidResponse" value="Item ID not found. Please try again."/> 
			</jsp:forward>
			<%
			
		}
	} catch (Exception e) {
		System.out.println(e);
		%>
		<jsp:forward page="main.jsp">
		<jsp:param name="bidResponse" value="Error while placing a bid. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
</body>
</html>