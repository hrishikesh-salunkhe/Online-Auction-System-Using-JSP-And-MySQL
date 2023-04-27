<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="DBDS.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Auction History</title>
</head>
<body>
<%
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection c = db.getConnection();
		
		String itemId = request.getParameter("itemId");
		
		String query = "SELECT * FROM auctionItem WHERE itemId=(?)";
		
		PreparedStatement ps = c.prepareStatement(query);
		ps.setString(1, itemId);
		
		ResultSet result = ps.executeQuery();
		
		if (result.next()) {
			
			%> <h2> Auction Item: </h2> <% 
			ResultSetMetaData rsmd = result.getMetaData();
			int columnsNumber = rsmd.getColumnCount();
				
				String auctionItem = "";
				for (int i = 1; i <= columnsNumber; i++) {
					auctionItem += rsmd.getColumnLabel(i) +": "+ result.getString(i) + "    ";
			    }
				%> <pre> <%= auctionItem %>		 </pre>
		     <%
		     
	     	String queryBid = "SELECT * FROM bid WHERE itemId=(?)";
			
			PreparedStatement psBid = c.prepareStatement(queryBid);
			psBid.setString(1, itemId);
			
			ResultSet resultBid = psBid.executeQuery();
			
			%> <h2> Bids placed on the item: </h2> <%
		    if (resultBid.next()) {
				ResultSetMetaData rsmdBid = resultBid.getMetaData();
				int bidColumnsNumber = rsmdBid.getColumnCount();
				do {
					%> <h5> Bid: </h5> <%
				    String bid = "";
					for (int i = 1; i <= bidColumnsNumber; i++) {
						bid += rsmdBid.getColumnLabel(i) +": "+ resultBid.getString(i) + "    ";
				    }
					%> <pre> <%= bid %>		 </pre>
			        <%
				}while (resultBid.next());
			}else{
				%> <h5> No bids were placed on the auction item. </h5> <%
			}
		}else{
			%> <h5> No auction item found. Please make sure you entered the correct item ID. </h5> <% 
		}
	} catch (Exception e) {
		System.out.println(e);
		%>
		<jsp:forward page="main.jsp">
		<jsp:param name="auctionResponse" value="Error displaying Auction History. Please try again."/> 
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