<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime,java.time.format.DateTimeFormatter"%>
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
		int bidAmount = Integer.parseInt(request.getParameter("bidAmount"));
		String userId = session.getAttribute("userId").toString();
		
		
		
		
		
		
		/* CHECK IF ITEM ID IS VALID: */
		
		String queryCheck = "SELECT currentBid, incrementAmount, minPrice"
							+ " FROM auctionItem WHERE itemId=(?)";
		
		PreparedStatement psCheck = c.prepareStatement(queryCheck);
		psCheck.setString(1, itemId);
		ResultSet result = psCheck.executeQuery();
				
		if (result.next()) {
			
			int currentBid = 0;
			if(result.getString(1) != null){
				currentBid = Integer.parseInt(result.getString(1));
			}
			
			int incrementAmount = 0;
			if(result.getString(2) != null){
				incrementAmount = Integer.parseInt(result.getString(2));
			}		
			
			int minPrice = Integer.parseInt(result.getString(3));
			
			if(bidAmount < currentBid + incrementAmount){
				
				String bidResponse = "Please place a bid amount higher than or equal to "+(currentBid+incrementAmount);
				%>
				<jsp:forward page="searchResults.jsp">
				<jsp:param name="searchBidResponse" value="<%= bidResponse %>"/> 
				</jsp:forward>
				<%
			}else{
				
				
				
				
				
				
				
				
				/* UPDATE AUCTION ITEM TABLE: */
				
				String query = "UPDATE auctionItem SET currentBid=(?), buyerId=(?) WHERE itemId=(?)";
				
				PreparedStatement ps = c.prepareStatement(query);
				ps.setInt(1, bidAmount);
				ps.setString(2, userId);
				ps.setString(3, itemId);
				
				ps.executeUpdate();
				
				
				
				
				
				
				
				
				
				/* INSERT INTO BID AND AUTOBID TABLES: */
				
				String queryInsert = "INSERT INTO bid(userId, dateTime, amount, itemId)"
									+ " VALUES((?), (?), (?), (?))";
				
				PreparedStatement psInsert = c.prepareStatement(queryInsert);
				psInsert.setString(1, userId);
				
				LocalDateTime myDateObj = LocalDateTime.now();
				DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
				String formattedDate = myDateObj.format(myFormatObj);
			
				psInsert.setString(2, formattedDate);
				psInsert.setInt(3, bidAmount);
				psInsert.setString(4, itemId);
				
				psInsert.executeUpdate();
				
			
				String autoBid = request.getParameter("autoBid");
				
				if(autoBid.equals("yes")){
					
					/* GET BID ID: */
					
					int upperLimit = Integer.parseInt(request.getParameter("upperLimit")); 
					
					String autoBidInsert = "INSERT INTO autoBid(userId, bidLimit, itemId, isLimitCrossed)"
										+ " VALUES((?), (?), (?), (?))";
		
					

					PreparedStatement psautoBidInsert = c.prepareStatement(autoBidInsert);
					

					psautoBidInsert.setString(1, userId);
					psautoBidInsert.setInt(2, upperLimit);
					psautoBidInsert.setString(3, itemId);
					psautoBidInsert.setString(4, "N");
					
					psautoBidInsert.executeUpdate();
					
				}
					
				
				
				
				
				
				
				
				
				
				
				/* PLACE AUTO-BIDS */
				
				String queryAutoBid = "SELECT * FROM autoBid WHERE itemId=(?) AND isLimitCrossed=(?)";
	
				PreparedStatement psAutoBid = c.prepareStatement(queryAutoBid);
				psAutoBid.setString(1, itemId);
				psAutoBid.setString(2, "N");
				ResultSet resultAutoBid = psAutoBid.executeQuery();
				
				resultAutoBid.last();
				int numRows = resultAutoBid.getRow();
				resultAutoBid.beforeFirst();
				
				currentBid = bidAmount + incrementAmount;
				
				
				
				
				
				
				/* LABEL FOR RECURSION */
				rec: while(true){
				
					/* IF ONLY ONE AUTO-BID EXISTS: */
					
					if(numRows == 1){
						
						resultAutoBid.next();
						if(Integer.parseInt(resultAutoBid.getString("bidLimit")) >= currentBid){
							
							String queryInsertBid = "INSERT INTO bid(userId, dateTime, amount, itemId)"
									+ " VALUES((?), (?), (?), (?))";
					
							PreparedStatement psInsertBid = c.prepareStatement(queryInsertBid);
							psInsertBid.setString(1, resultAutoBid.getString("userId"));
							
							psInsertBid.setString(2, formattedDate);
							psInsertBid.setInt(3, currentBid);
							psInsertBid.setString(4, itemId);
							psInsertBid.executeUpdate();
							
							break rec;
						}else{
							
							String queryUpdate = "UPDATE autoBid SET isLimitCrossed=(?) WHERE autoBidId=(?)";
							
							PreparedStatement psUpdate = c.prepareStatement(queryUpdate);
							psUpdate.setString(1, "Y");
							psUpdate.setString(2, resultAutoBid.getString("autoBidId"));
							
							psUpdate.executeUpdate();
							
							break rec;
						}
					}
					
					
					
					
					
					/* IF MULTIPLE AUTO-BIDS EXIST: */
					
					if(numRows > 1){
						
						while(resultAutoBid.next()){
							
							if(Integer.parseInt(resultAutoBid.getString("bidLimit")) >= currentBid){
								
								String queryInsertBid = "INSERT INTO bid(userId, dateTime, amount, itemId)"
										+ " VALUES((?), (?), (?), (?))";
						
								PreparedStatement psInsertBid = c.prepareStatement(queryInsertBid);
								psInsertBid.setString(1, resultAutoBid.getString("userId"));
								
								psInsertBid.setString(2, formattedDate);
								psInsertBid.setInt(3, currentBid);
								psInsertBid.setString(4, itemId);
								psInsertBid.executeUpdate();
								
							}else{
								
								String queryUpdate = "UPDATE autoBid SET isLimitCrossed=(?) WHERE autoBidId=(?)";
								
								PreparedStatement psUpdate = c.prepareStatement(queryUpdate);
								psUpdate.setString(1, "Y");
								psUpdate.setString(2, resultAutoBid.getString("autoBidId"));
								
								psUpdate.executeUpdate();
								
							}
							
							currentBid += incrementAmount;
							
						}
						resultAutoBid = psAutoBid.executeQuery();
						continue rec;
					}
					
					break rec;
					
				}	
				
			}
			
			%>
			<jsp:forward page="searchResults.jsp">
			<jsp:param name="searchBidResponse" value="Bid placed successfully!"/> 
			</jsp:forward>
			<% //ABOVE: FORWARD TO HOME PAGE WITH CURRENT USERNAME ATTACHED
			
			
		}else{
			
			%>
			<jsp:forward page="searchResults.jsp">
			<jsp:param name="searchBidResponse" value="Item ID not found. Please try again."/> 
			</jsp:forward>
			<%
			
		}
	} catch (Exception e) {
		System.out.println(e);
		%>
		<jsp:forward page="searchResults.jsp">
		<jsp:param name="searchBidResponse" value="Error while placing a bid. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
</body>
</html>