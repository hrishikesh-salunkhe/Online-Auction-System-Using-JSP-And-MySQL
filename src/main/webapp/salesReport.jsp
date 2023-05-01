<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="DBDS.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sales Report</title>
</head>
<body>
<%
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection c = db.getConnection();
		
		
		
		
		/* TOTAL EARNINGS: */
		String query = "SELECT SUM(currentBid) as totalEarnings FROM auctionItem"
					+ " WHERE isClosed='Y' AND buyerId IS NOT NULL";
		
		PreparedStatement ps = c.prepareStatement(query);
		
		ResultSet result = ps.executeQuery();
		
		result.next();
		if(result.getString("totalEarnings") != null){

			String totalEarnings = result.getString("totalEarnings");
			
			%> <h4> Total Earnings: <%= totalEarnings %></h4> <%
				
		}
		
				
				
				
				
		/* EARNINGS PER ITEM: */
		String query2 = "SELECT * FROM auctionItem WHERE isClosed='Y'";
		
		PreparedStatement ps2 = c.prepareStatement(query2);
		
		ResultSet result2 = ps2.executeQuery();
		
		if (result2.next()) {
			
			%> <h4> Earnings Per Item: </h4> <%
			
			do {
				
				String auctionItem = "Item ID: " + result2.getString("itemId") + "    "
									+ "Item Name: " + result2.getString("name") + "    "
									+ "Earnings: " + result2.getString("currentBid") + "    ";
			    
				%> <pre> <%= auctionItem %>		 </pre>
		        <%
			} while (result2.next());
		}
		
		
		/* EARNINGS PER SUBCATEGORY: */
		String query3 = "SELECT subcategory, SUM(currentBid) as earnings FROM auctionItem"
					+ " WHERE isClosed='Y' GROUP BY subcategory";
		
		PreparedStatement ps3 = c.prepareStatement(query3);
		
		ResultSet result3 = ps3.executeQuery();
		
		if (result3.next()) {
			
			%> <h4> Earnings Per Subcategory: </h4> <%
			
			do {
				
				String auctionItem = "Subcategory: " + result3.getString("subcategory") + "    "
									+ "Earnings: " + result3.getString("earnings") + "    ";
			    
				%> <pre> <%= auctionItem %>		 </pre>
		        <%
			} while (result3.next());
		}
		
		
		
		/* EARNINGS PER USER: */
		String query4 = "SELECT sellerId, SUM(currentBid) as earnings FROM auctionItem"
					+ " WHERE isClosed='Y' GROUP BY sellerId";
		
		PreparedStatement ps4 = c.prepareStatement(query4);
		
		ResultSet result4 = ps4.executeQuery();
		
		if (result4.next()) {
			
			%> <h4> Earnings Per User: </h4> <%
			
			do {
				
				String auctionItem = "User ID: " + result4.getString("sellerId") + "    "
									+ "Earnings: " + result4.getString("earnings") + "    ";
			    
				%> <pre> <%= auctionItem %>		 </pre>
		        <%
			} while (result4.next());
		}
		
		
		
		
		/* BEST-SELLING ITEMS: */
		String query5 = "SELECT * FROM auctionItem WHERE isClosed='Y' ORDER BY currentBid DESC";
		
		PreparedStatement ps5 = c.prepareStatement(query5);
		
		ResultSet result5 = ps5.executeQuery();
		
		int rank = 1;
		
		if (result5.next()) {
			
			%> <h4> Best-Selling Items: </h4> <%
			
			do {
				
				String auctionItem = "Rank: " + rank + "    "
									+ "Item ID: " + result5.getString("itemId") + "    "
									+ "Item Name: " + result5.getString("name") + "    "
									+ "Earnings: " + result5.getString("currentBid") + "    ";
				
				rank++;
			    
				%> <pre> <%= auctionItem %>		 </pre>
		        <%
			} while (result5.next());
		}
		
		
		
		
		
		
		/* BEST-SELLING USERS: */
		String query6 = "SELECT sellerId, SUM(currentBid) as earnings FROM auctionItem WHERE isClosed='Y' GROUP BY sellerId ORDER BY earnings DESC";
		
		PreparedStatement ps6 = c.prepareStatement(query6);
		
		ResultSet result6 = ps6.executeQuery();
		
		int rankNew = 1;
		
		if (result6.next()) {
			
			%> <h4> Best-Selling Users: </h4> <%
			
			do {
				
				String auctionItem = "Rank: " + rankNew + "    "
									+ "User ID: " + result6.getString("sellerId") + "    "
									+ "Earnings: " + result6.getString("earnings") + "    ";
				
				rankNew++;
			    
				%> <pre> <%= auctionItem %>		 </pre>
		        <%
			} while (result6.next());
		}
		
		
		
		
		
		
		/* BEST-BUYERS: */
		String query7 = "SELECT buyerId, SUM(currentBid) as earnings FROM auctionItem WHERE isClosed='Y' GROUP BY buyerId ORDER BY earnings DESC";
		
		PreparedStatement ps7 = c.prepareStatement(query7);
		
		ResultSet result7 = ps7.executeQuery();
		
		int rankBuyers = 1;
		
		if (result7.next()) {
			
			%> <h4> Best-Buying Users: </h4> <%
			
			do {
				
				String auctionItem = "Rank: " + rankBuyers + "    "
									+ "User ID: " + result7.getString("buyerId") + "    "
									+ "Earnings: " + result7.getString("earnings") + "    ";
				
				rankBuyers++;
			    
				%> <pre> <%= auctionItem %>		 </pre>
		        <%
			} while (result7.next());
		}
		
	} catch (Exception e) {
		System.out.println(e);
		%>
		<jsp:forward page="adminMain.jsp">
		<jsp:param name="reportResponse" value="Error generating sales report. Please try again."/> 
		</jsp:forward>
		<%
	}
%>

	
	
	

	<br/><br/>
	
<!-- HOME PAGE: -->
	
	<a href="adminMain.jsp">Home Page</a>
	
	
	
	<br/><br/>
	
<!-- LOGOUT: -->
	
	<a href="adminLogout.jsp">Logout</a>
	
	
</body>
</html>