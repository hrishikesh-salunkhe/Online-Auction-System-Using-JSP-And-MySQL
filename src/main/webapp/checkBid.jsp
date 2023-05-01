<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="DBDS.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Check Bids Page</title>
</head>
<body>
<%
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection c = db.getConnection();
		
		String userId = session.getAttribute("userId").toString();
		
		String query = "select itemId, MAX(amount) as yourBid from bid where userId=(?) group by itemId";
		
		PreparedStatement ps = c.prepareStatement(query);
		ps.setString(1, userId);
		
		ResultSet result = ps.executeQuery();

		System.out.println("reached here");
		
		if (result.next()) {
			
			do {
				
				String query2 = "SELECT * FROM auctionItem WHERE itemId=(?)";
				
				PreparedStatement ps2 = c.prepareStatement(query2);
				ps2.setString(1, result.getString("itemId"));
				
				ResultSet result2 = ps2.executeQuery();
				result2.next();
				
				System.out.println("reached here 2");
				
				int yourBid = Integer.parseInt(result.getString("yourBid"));
				int currentBid = Integer.parseInt(result2.getString("currentBid"));
				
				if(yourBid < currentBid){
					
					%> <h4> A higher bid has been placed on the following auction item: </h4> <%
					
					String auctionItem = "Item ID: " + result2.getString("itemId") + "    "
										+ "Item Name: " + result2.getString("name") + "    "
										+ "Your Bid: " + yourBid + "    "
										+ "Current Bid: " + currentBid;
					
					%> <pre> <%= auctionItem %>		 </pre>
			        <%
				}
				
			} while (result.next());
		}
		
	} catch (Exception e) {
		System.out.println(e);
		%>
		<jsp:forward page="main.jsp">
		<jsp:param name="checkBidResponse" value="Error checking bids. Please try again."/> 
		</jsp:forward>
		<%
	}
%>

	
	

<!-- HOME PAGE: -->
	
	<a href="main.jsp">Home Page</a>
	
	
	
	
	
<!-- LOGOUT: -->
	
	<a href="logout.jsp">Logout</a>
	
	
</body>
</html>