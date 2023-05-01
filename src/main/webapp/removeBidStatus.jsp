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
		

		String bidId = request.getParameter("bidId");
		
		String queryCheck = "SELECT bidId FROM bid WHERE bidId=(?)";
		
		PreparedStatement psCheck = c.prepareStatement(queryCheck);
		psCheck.setString(1, bidId);
		ResultSet result = psCheck.executeQuery();
			
		if (result.next()) {
			
			String query = "DELETE FROM bid WHERE bidId=(?)";
		
			PreparedStatement ps = c.prepareStatement(query);
			ps.setString(1, bidId);
			ps.executeUpdate();
			
			%>
			<jsp:forward page="removeBid.jsp">
			<jsp:param name="removeBidResponse" value="Bid removed successfully!"/> 
			</jsp:forward>
			<% //ABOVE: FORWARD TO HOME PAGE WITH CURRENT USERNAME ATTACHED
			
		}else{
			
			%>
			<jsp:forward page="removeBid.jsp">
			<jsp:param name="removeBidResponse" value="Bid ID not found. Please try again."/> 
			</jsp:forward>
			<%
			
		}
	} catch (Exception e) {
		System.out.println(e);
		%>
		<jsp:forward page="removeBid.jsp">
		<jsp:param name="removeBidResponse" value="Error removing bid. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
</body>
</html>