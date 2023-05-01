<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.util.Date,java.text.SimpleDateFormat,java.sql.*"%>
<%@ page import="DBDS.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Dashboard</title>
</head>
<body>
	<h1> Welcome to the Online Auction System! </h1>
	
	
	
	
	
	
	
	<!-- AUCTION CLOSING AND CHOOSING WINNER: -->
	
<%
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection c = db.getConnection();
		
		String userId = session.getAttribute("userId").toString();
		
		
		
		
		/* ENTER DATE HERE FOR TESTING */
		
		String dateToday="30-04-2023 11:30:00";  
		
	    Date date=new SimpleDateFormat("dd-MM-yyyy hh:mm:ss").parse(dateToday);
	     
	    /* FETCHING OPEN AUCTION DATA: */
	    
		String query = "SELECT * FROM auctionItem WHERE isClosed=(?)";
		
		PreparedStatement ps = c.prepareStatement(query);
		ps.setString(1, "N");
		
		ResultSet result = ps.executeQuery();
		
		if(result.next()){
			
			do{
				
				String auctionDate = result.getString("closingDateTime");
				auctionDate += " PM";
				
				Date aucDate = new SimpleDateFormat("dd-MM-yyyy hh:mm:ss").parse(auctionDate);
			    System.out.println("aucDate: "+aucDate);
			    System.out.println(aucDate.before(date));
				
				
				/* CLOSING THE AUCTION: */
				
				if(aucDate.before(date)){
					
					String queryUpdate = "UPDATE auctionItem SET isClosed=(?) WHERE itemId=(?)";
					
					PreparedStatement psUpdate = c.prepareStatement(queryUpdate);
					psUpdate.setString(1, "Y");
					psUpdate.setString(2, result.getString("itemId"));
					
					psUpdate.executeUpdate();
					
					int currentBid = 0;
					if(result.getString("currentBid") != null){
						currentBid = Integer.parseInt(result.getString("currentBid"));
					}
					int minPrice = Integer.parseInt(result.getString("minPrice"));
					
					
					
					
					/* CHOOSING A WINNER: */
					
					if(currentBid < minPrice){
						
						String queryUpdate2 = "UPDATE auctionItem SET buyerId=NULL, currentBid=0 WHERE itemId=(?)";
						
						PreparedStatement psUpdate2 = c.prepareStatement(queryUpdate2);
						
						psUpdate2.setString(1, result.getString("itemId"));
						
						psUpdate2.executeUpdate();
						
					}
					
				}

			}while(result.next());
		}
		
		
		
		
		
		/* ALERTING THE USER IF (S)HE WON: */
		
		String queryWinner = "SELECT * FROM auctionItem WHERE buyerId=(?) AND isClosed=(?)";
		
		PreparedStatement psWinner = c.prepareStatement(queryWinner);
		psWinner.setString(1, userId);
		psWinner.setString(2, "Y");
		
		ResultSet resultWinner = psWinner.executeQuery();
		
		if (resultWinner.next()) {
			
			%> <h2> Congratulations! You've won the following auction(s): </h2> <%
			
			ResultSetMetaData rsmd = resultWinner.getMetaData();
			int columnsNumber = rsmd.getColumnCount();
			
			do {
				%> <h5> Auction Item: </h5> <%
			    String auctionItem = "";
				for (int i = 1; i <= columnsNumber; i++) {
					if(!rsmd.getColumnLabel(i).equals("minPrice")){
						auctionItem += rsmd.getColumnLabel(i) +": "+ resultWinner.getString(i) + "    ";	
					}
			    }
				%> <pre> <%= auctionItem %>		 </pre>
		        <%
			} while (resultWinner.next());
		}
	    
	} catch (Exception e) {
		System.out.println(e);
		%>
		<pre> Error fetching auction closing data. Please reload the page. </pre>
		<%
	}
%>








	<!-- UPPER LIMIT REACHED ALERT: -->
	
<%
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection c = db.getConnection();
		
		String userId = session.getAttribute("userId").toString();
		
		String query = "SELECT * FROM autoBid WHERE userId=(?)";
		
		PreparedStatement ps = c.prepareStatement(query);
		ps.setString(1, userId);
		ResultSet result = ps.executeQuery();
		
		if (result.next()) {
			
			String resultItemId = ""; 
			
			int printFlag = 0;
			do {
				
				if(resultItemId.equals(result.getString("itemId"))){
					continue;
				}else{
					resultItemId = result.getString("itemId");
				}
				
				if (result.getString("isLimitCrossed").equals("Y")) {
					
					if(printFlag == 0){
						printFlag = 1;
						%><h2>Auto-Bid Limit Crossed Alert!</h2>
						<%
					}
					%> 
						<h4>Someone has placed a higher bid than the upper limit you have set for auto-bidding:</h4>
					<%
			
					String itemId = result.getString("itemId");
					
					String queryCheck = "SELECT * FROM auctionItem WHERE itemId=(?)";
					
					PreparedStatement psCheck = c.prepareStatement(queryCheck);
					psCheck.setString(1, itemId);
					ResultSet resultCheck = psCheck.executeQuery();
					
					ResultSetMetaData rsmd = resultCheck.getMetaData();
					
					int columnsNumber = rsmd.getColumnCount();
					while (resultCheck.next()){
				
						String auctionItem = "";
						for (int i = 1; i <= columnsNumber; i++) {
							if(!rsmd.getColumnLabel(i).equals("minPrice")){
								auctionItem += rsmd.getColumnLabel(i) +": "+ resultCheck.getString(i) + "    ";	
							}
					    }
						%> <pre> <%= auctionItem %>		 </pre>
				        <%
				       
					}
					
				}
			} while (result.next());
		}
	} catch (Exception e) {
		System.out.println(e);
		%>
		<pre> Error fetching auction items. Please reload the page. </pre>
		<%
	}
%>








	<!-- LISTING ALERT: -->
	
<%
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection c = db.getConnection();
		
		String userId = session.getAttribute("userId").toString();
		
		String query = "SELECT * FROM listingAlerts WHERE userId=(?)";
		
		PreparedStatement ps = c.prepareStatement(query);
		ps.setString(1, userId);
		ResultSet result = ps.executeQuery();
		
		if (result != null) {
					
			while (result.next()) {
				
				String subcategory = result.getString("subcategory");
				int lengthFrom = Integer.parseInt(result.getString("lengthFrom"));
				int lengthTo = Integer.parseInt(result.getString("lengthTo"));
				int breadthFrom = Integer.parseInt(result.getString("breadthFrom"));
				int breadthTo = Integer.parseInt(result.getString("breadthTo"));
				String colorType = result.getString("colorType");
				int initialPriceFrom = Integer.parseInt(result.getString("initialPriceFrom"));
				int initialPriceTo = Integer.parseInt(result.getString("initialPriceTo"));
				
				String queryCheck = "SELECT * FROM auctionItem WHERE subcategory=(?)"
									+ " AND (?) <= length <= (?) AND (?) <= breadth <= (?)"
									+ " AND colorType=(?) AND (?) <= initialPrice <= (?)"
									+ " AND sellerId <> (?)";
				
				PreparedStatement psCheck = c.prepareStatement(queryCheck);
				psCheck.setString(1, subcategory);
				psCheck.setInt(2, lengthFrom);
				psCheck.setInt(3, lengthTo);
				psCheck.setInt(4, breadthFrom);
				psCheck.setInt(5, breadthTo);
				psCheck.setString(6, colorType);
				psCheck.setInt(7, initialPriceFrom);
				psCheck.setInt(8, initialPriceTo);
				psCheck.setString(9, userId);
				
				ResultSet resultCheck = psCheck.executeQuery();
				
				if (resultCheck.next()) {
					
					%> <h2>Listing Alert!</h2>
					
						<h4>The items you were looking for are here!</h4>
					<%
			
					ResultSetMetaData rsmdCheck = resultCheck.getMetaData();
					int columnsNumber = rsmdCheck.getColumnCount();
					do {
				
						%> <h5> Auction Item: </h5> <%
					    String auctionItem = "";
						for (int i = 1; i <= columnsNumber; i++) {
							auctionItem += rsmdCheck.getColumnLabel(i) +": "+ resultCheck.getString(i) + "    ";
					    }
						%> <pre> <%= auctionItem %>		 </pre>
				        <%
				       
					} while (resultCheck.next());
					
				}
			}
		}
	} catch (Exception e) {
		System.out.println(e);
		%>
		<pre> Error fetching auction items. Please reload the page. </pre>
		<%
	}
%>
	
	
	
	
	
	
	
	<!-- QUESTIONS ANSWERED: -->
	
<%
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection c = db.getConnection();
		
		String userId = session.getAttribute("userId").toString();
		
		String query = "SELECT * FROM question WHERE userId=(?) AND solutionDetails IS NOT NULL";
		
		PreparedStatement ps = c.prepareStatement(query);
		ps.setString(1, userId);
		ResultSet result = ps.executeQuery();
		
		if (result.next()) {
			
			ResultSetMetaData rsmd = result.getMetaData();
			int columnsNumber = rsmd.getColumnCount();
					
			%> <h2> Your Questions have been Answered! </h2> <%
		    do {
				
				%> <h4> Question: </h4> <%
			    String question = "";
				question += rsmd.getColumnLabel(2) + ": " + result.getString(2) + "    ";
				question += rsmd.getColumnLabel(3) + ": " + result.getString(3) + "    ";
				question += rsmd.getColumnLabel(4) + ": " + result.getString(4) + "    ";
			    %> <pre> <%= question %>		 </pre>
		        <%
				
			} while (result.next());
		}
	} catch (Exception e) {
		System.out.println(e);
		%>
		<pre> Error fetching questions answered. Please reload the page. </pre>
		<%
	}
%>










	<!-- PUBLISH AN ITEM: -->
	
	<h2> Publish an item: </h2>
	
	<form action="auctionStatus.jsp" method="post">
		<table>
			<tr><td>Art Name:</td><td><input type=text maxlength=40 name=name></td></tr>
			
			<tr><td>Art Length:</td><td><input type=number name=length></td></tr>
			
			<tr><td>Art Breadth:</td><td><input type=number name=breadth></td></tr>
			
			<tr><td>Color Type:</td>
			<td>
				<select name="colorType">
				  <option value="Acrylic">Acrylic</option>
				  <option value="Oil">Oil</option>
				  <option value="Watercolor">Watercolor</option>
				  <option value="Gouache">Gouache</option>
				  <option value="Encaustic">Encaustic</option>
				  <option value="Fresco">Fresco</option>
				  <option value="Spray Paint">Spray Paint</option>
				  <option value="Digital">Digital</option>
				  <option value="Pastel">Pastel</option>
				</select>
			</td></tr>
			
			<tr><td>Art Subcategory:</td>
			<td>
				<select name="subcategory">
				  <option value="Realism">Realism</option>
				  <option value="Photorealism">Photorealism</option>
				  <option value="Expressionism">Expressionism</option>
				  <option value="Impressionism">Impressionism</option>
				  <option value="Abstract">Abstract</option>
				  <option value="Surrealism">Surrealism</option>
				  <option value="Pop Art">Pop Art</option>
				</select>
			</td></tr>
			
			<tr><td>Art Description:</td><td><input type=text maxlength=100 name=description></td></tr>
			
			<tr><td>Artist:</td><td><input type=text maxlength=50 name=artist></td></tr>
			
			<tr><td>Starting Price:</td><td><input type=number name=initialPrice></td></tr>
			
			<tr><td>Minimum Acceptable Price:</td><td><input type=number name=minPrice></td></tr>
			
			<tr><td>Auction Closing Date and Time:</td><td><input type=text maxlength=50 name=closingDateTime></td></tr>
			<tr><td>(format: dd-mm-yyyy hh24:mm:ss) </td></tr>
			
			<tr><td>Bid Increment Amount:</td><td><input type=number name=incrementAmount></td></tr>
			
			<tr><td><input type=Submit value=Submit></td></tr>
			
			<% if (request.getParameter("auctionResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("auctionResponse")%></p></td>
				</tr>
			<% } %>
		</table>
	</form>
	
	
	
	
	
	
	
	
	
	<!-- QUESTION SEARCH: -->
	
	<h2> Search your question: </h2>
	
	<form action="questionSearch.jsp" method="post">
		<table>

			<tr><td>Keyword:</td><td><input type=text name=keyword></td></tr>

			<tr><td><input type=Submit value=Submit></td></tr>
			
			<% if (request.getParameter("questionSearchResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("questionSearchResponse")%></p></td>
				</tr>
			<% } %>
		</table>
	</form>
	
	
	
	
	
	
	
	
	
	
	
	
	<!-- ASK A QUESTION: -->
	
	<h2> Ask a question: </h2>
	
	<form action="questionStatus.jsp" method="post">
		<table>
			<tr><td>Question:</td><td><input type=text maxlength=100 name=questionDetails></td></tr>
			<tr><td><input type=Submit value=Submit></td></tr>
			
			<% if (request.getParameter("questionResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("questionResponse")%></p></td>
				</tr>
			<% } %>
		</table>
	</form>
	
	
	
	
	
	
	
	
	
	
	<!-- BROWSE HISTORY OF BIDS: -->
	
	<h2> Browse History of Bids: </h2>
	
	
	
	<h4> History of a specific auction: </h4>
	
	<form action="auctionHistory.jsp" method="post">
		<table>
			<tr><td>Enter item ID:</td><td><input required type=number name=itemId></td></tr>
			<tr><td><input type=Submit value=Submit></td></tr>
			
			<% if (request.getParameter("auctionHistoryResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("auctionHistoryResponse")%></p></td>
				</tr>
			<% } %>
		</table>
	</form>
	
	
	<h4> History of a specific user: </h4>
	
	<form action="userHistory.jsp" method="post">
		<table>
			<tr><td>Enter a user ID:</td><td><input required type=text maxlength=10 name=userId></td></tr>
			<tr><td><input type=Submit value=Submit></td></tr>
			
			<% if (request.getParameter("userHistoryResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("userHistoryResponse")%></p></td>
				</tr>
			<% } %>
		</table>
	</form>
	
	<h4> History of similar auction items: </h4>
	
	<form action="similarHistory.jsp" method="post">
		<table>
			<tr><td>Enter an item ID:</td><td><input required type=number name=itemId></td></tr>
			<tr><td><input type=Submit value=Submit></td></tr>
			
			<% if (request.getParameter("similarHistoryResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("similarHistoryResponse")%></p></td>
				</tr>
			<% } %>
		</table>
	</form>
	
	
	
	
	
	
	
	
		
	<!-- SEE ALL AUCTION ITEMS: -->
	
	<h2>See all Auction Items and Place a Bid:</h2>
	
	<form action="auctionResults.jsp" method="post">
		<table>
			
			<tr><td>Sort By:</td>
			<td>
				<select required name="orderBy">
				  <option value="itemId">Item ID</option>
				  <option value="name">Item Name</option>
				  <option value="subcategory">Item Subcategory</option>
				  <option value="length">Length</option>
				  <option value="breadth">Breadth</option>
				  <option value="colorType">Color Type</option>
				  <option value="artist">Artist</option>
				  <option value="initialPrice">Starting Price</option>
				  <option value="closingDateTime">Closing Date and Time</option>
				  <option value="currentBid">Current Bid</option>
				  <option value="sellerId">Seller User ID</option>
				</select>
			</td>
			
			<td>
				<select required name="ascDesc">
				  <option value="ASC">Lower to Higher</option>
				  <option value="DESC">Higher to Lower</option>
				</select>
			</td></tr>
		
			<tr><td><input type=Submit value=View></td></tr>
			
			<% if (request.getParameter("auctionResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("auctionResponse")%></p></td>
				</tr>
			<% } %>
			
		</table>
	</form>
	
	
	
	
	
	
	
	
	
	
	<!-- SEARCH FOR AN ITEM: -->
	
	<h2> Search for an item and Place a Bid: </h2>
	
	<form action="searchResults.jsp" method="post">
		<table>
			<tr><td>Art Subcategory:</td>
			<td>
				<select required name="subcategory">
				  <option value="Realism">Realism</option>
				  <option value="Photorealism">Photorealism</option>
				  <option value="Expressionism">Expressionism</option>
				  <option value="Impressionism">Impressionism</option>
				  <option value="Abstract">Abstract</option>
				  <option value="Surrealism">Surrealism</option>
				  <option value="Pop Art">Pop Art</option>
				</select>
			</td></tr>
			
			<tr>
				<td>Art Length Range:</td><td><input required type=number name=lengthFrom></td>
				<td> to: </td><td><input required type=number name=lengthTo></td>
			</tr>
			
			<tr>
				<td>Art Breadth Range:</td><td><input required type=number name=breadthFrom></td>
				<td> to: </td><td><input required type=number name=breadthTo></td>
			</tr>
			
			<tr><td>Color Type:</td>
			<td>
				<select required name="colorType">
				  <option value="Acrylic">Acrylic</option>
				  <option value="Oil">Oil</option>
				  <option value="Watercolor">Watercolor</option>
				  <option value="Gouache">Gouache</option>
				  <option value="Encaustic">Encaustic</option>
				  <option value="Fresco">Fresco</option>
				  <option value="Spray Paint">Spray Paint</option>
				  <option value="Digital">Digital</option>
				  <option value="Pastel">Pastel</option>
				</select>
			</td></tr>
			
			<tr>
				<td>Starting Price Range:</td><td><input required type=number name=initialPriceFrom></td>
				<td> to: </td><td><input required type=number name=initialPriceTo></td>
			</tr>
			
			<tr><td>Sort By:</td>
			<td>
				<select required name="orderBy">
				  <option value="itemId">Item ID</option>
				  <option value="name">Item Name</option>
				  <option value="subcategory">Item Subcategory</option>
				  <option value="length">Length</option>
				  <option value="breadth">Breadth</option>
				  <option value="colorType">Color Type</option>
				  <option value="artist">Artist</option>
				  <option value="initialPrice">Starting Price</option>
				  <option value="closingDateTime">Closing Date and Time</option>
				  <option value="currentBid">Current Bid</option>
				  <option value="sellerId">Seller User ID</option>
				</select>
			</td>
			
			<td>
				<select required name="ascDesc">
				  <option value="ASC">Lower to Higher</option>
				  <option value="DESC">Higher to Lower</option>
				</select>
			</td></tr>
			
			<tr><td><input type=Submit value=Search></td></tr>
			
			<% if (request.getParameter("searchResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("searchResponse")%></p></td>
				</tr>
			<% } %>
			
		</table>
	</form>
	
	
	
	
	
	
	
	
	<!-- CHECK FOR HIGHER BID: -->
	
	<h2> Check if someone has placed a higher bid than you: </h2>
	
	<form action="checkBid.jsp" method="post">
		<table>
			
			<tr><td><input type=Submit value=Search></td></tr>
			
			<% if (request.getParameter("checkBidResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("checkBidResponse")%></p></td>
				</tr>
			<% } %>
			
		</table>
	</form>
	
	
	
	
	
	
	
	
	
	
	<!-- SET A LISTING ALERT: -->
	
	<h2> Set a Listing Alert: </h2>
	
	<form action="alertStatus.jsp" method="post">
		<table>
			<tr><td>Art Subcategory:</td>
			<td>
				<select required name="subcategory">
				  <option value="Realism">Realism</option>
				  <option value="Photorealism">Photorealism</option>
				  <option value="Expressionism">Expressionism</option>
				  <option value="Impressionism">Impressionism</option>
				  <option value="Abstract">Abstract</option>
				  <option value="Surrealism">Surrealism</option>
				  <option value="Pop Art">Pop Art</option>
				</select>
			</td></tr>
			
			<tr>
				<td>Art Length Range:</td><td><input required type=number name=lengthFrom></td>
				<td> to: </td><td><input required type=number name=lengthTo></td>
			</tr>
			
			<tr>
				<td>Art Breadth Range:</td><td><input required type=number name=breadthFrom></td>
				<td> to: </td><td><input required type=number name=breadthTo></td>
			</tr>
			
			<tr><td>Color Type:</td>
			<td>
				<select required name="colorType">
				  <option value="Acrylic">Acrylic</option>
				  <option value="Oil">Oil</option>
				  <option value="Watercolor">Watercolor</option>
				  <option value="Gouache">Gouache</option>
				  <option value="Encaustic">Encaustic</option>
				  <option value="Fresco">Fresco</option>
				  <option value="Spray Paint">Spray Paint</option>
				  <option value="Digital">Digital</option>
				  <option value="Pastel">Pastel</option>
				</select>
			</td></tr>
			
			<tr>
				<td>Starting Price Range:</td><td><input required type=number name=initialPriceFrom></td>
				<td> to: </td><td><input required type=number name=initialPriceTo></td>
			</tr>
			
			<tr><td><input type=Submit value=Search></td></tr>
			
			<% if (request.getParameter("alertResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("alertResponse")%></p></td>
				</tr>
			<% } %>
			
		</table>
	</form>
	
	
	
	
	
	
	
	
	
	
	
	<br/>
	
	
	<!-- LOGOUT: -->
	
	<a href="logout.jsp">Logout</a>
	
	
	
	
	<br/>
	<br/>
	
	
	
	
	<!-- DELETE ACCOUNT: -->
	
	<a href="deleteStatus.jsp">DELETE ACCOUNT</a>
</body>
</html>