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
		
		String userId = request.getParameter("userId");
		
		String query = "SELECT * FROM auctionItem WHERE sellerId=(?)";
		
		PreparedStatement ps = c.prepareStatement(query);
		ps.setString(1, userId);
		
		ResultSet result = ps.executeQuery();
		
		%> <h2> Auction Items published by the user: </h2> <% 
		if (result.next()) {
			
			ResultSetMetaData rsmd = result.getMetaData();
			int columnsNumber = rsmd.getColumnCount();
				
				String auctionItem = "";
				for (int i = 1; i <= columnsNumber; i++) {
					auctionItem += rsmd.getColumnLabel(i) +": "+ result.getString(i) + "    ";
			    }
				%> <pre> <%= auctionItem %>		 </pre>
		     <%
		}else{
			%> <h5> No auction items published by the user. </h5> <%
		}
		
		String queryBid = "SELECT * FROM bid WHERE userId=(?)";
		
		PreparedStatement psBid = c.prepareStatement(queryBid);
		psBid.setString(1, userId);
		
		ResultSet resultBid = psBid.executeQuery();
		
		%> <h2> Bids placed by the user: </h2> <%
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
			%> <h5> No bids were placed by the user. </h5> <%
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