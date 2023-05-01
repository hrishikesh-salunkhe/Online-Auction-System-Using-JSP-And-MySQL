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
		
		String queryCheck = "SELECT itemId FROM auctionItem WHERE itemId=(?)";
		
		PreparedStatement psCheck = c.prepareStatement(queryCheck);
		psCheck.setString(1, itemId);
		ResultSet result = psCheck.executeQuery();
			
		if (result.next()) {
			
			String query = "DELETE FROM auctionItem WHERE itemId=(?)";
		
			PreparedStatement ps = c.prepareStatement(query);
			ps.setString(1, itemId);
			ps.executeUpdate();
			
			%>
			<jsp:forward page="delist.jsp">
			<jsp:param name="itemDelistResponse" value="Item delisted successfully!"/> 
			</jsp:forward>
			<% //ABOVE: FORWARD TO HOME PAGE WITH CURRENT USERNAME ATTACHED
			
		}else{
			
			%>
			<jsp:forward page="delist.jsp">
			<jsp:param name="itemDelistResponse" value="Item ID not found. Please try again."/> 
			</jsp:forward>
			<%
			
		}
	} catch (Exception e) {
		System.out.println(e);
		%>
		<jsp:forward page="delist.jsp">
		<jsp:param name="itemDelistResponse" value="Error delisting auction item. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
</body>
</html>