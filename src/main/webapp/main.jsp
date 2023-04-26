<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="DBDS.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Dashboard</title>
</head>
<body>
	<h1> Welcome to the Online Auction System! </h1>
	
	
	
	
	
	
	
	<!-- LISTING ALERT: -->
	
	<h2>Listing Alert!</h2>
	
	<h4>The items you were looking for are here!</h4>
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
									+ " AND colorType=(?) AND (?) <= initialPrice <= (?)";
				
				PreparedStatement psCheck = c.prepareStatement(queryCheck);
				psCheck.setString(1, subcategory);
				psCheck.setInt(2, lengthFrom);
				psCheck.setInt(3, lengthTo);
				psCheck.setInt(4, breadthFrom);
				psCheck.setInt(5, breadthTo);
				psCheck.setString(6, colorType);
				psCheck.setInt(7, initialPriceFrom);
				psCheck.setInt(8, initialPriceTo);
				
				ResultSet resultCheck = psCheck.executeQuery();
				
				if (resultCheck != null) {
					
					ResultSetMetaData rsmdCheck = resultCheck.getMetaData();
					int columnsNumber = rsmdCheck.getColumnCount();
					while (resultCheck.next()) {
				
						%> <h5> Auction Item: </h5> <%
					    String auctionItem = "";
						for (int i = 1; i <= columnsNumber; i++) {
							auctionItem += rsmdCheck.getColumnLabel(i) +": "+ resultCheck.getString(i) + "    ";
					    }
						%> <pre> <%= auctionItem %>		 </pre>
				        <%
				       
					}
					
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
			
			<tr><td>Bid Increment Amount:</td><td><input type=number name=incrementAmount></td></tr>
			
			<tr><td><input type=Submit value=Submit></td></tr>
			
			<% if (request.getParameter("auctionResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("auctionResponse")%></p></td>
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
	
	
	
	
	
	
	
	
	
	
	
	<!-- SEE ALL AUCTION ITEMS: -->
	
	<h2>See all Auction Items:</h2>
	
	<form action="auctionResults.jsp" method="post">
		<table>
			<tr><td><input type=Submit value=View></td></tr>
			
			<% if (request.getParameter("auctionResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("auctionResponse")%></p></td>
				</tr>
			<% } %>
			
		</table>
	</form>
	
	
	
	
	
	
	
	
	
	
	<!-- SEARCH FOR AN ITEM: -->
	
	<h2> Search for an item: </h2>
	
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
			
			<tr><td><input type=Submit value=Search></td></tr>
			
			<% if (request.getParameter("searchResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("searchResponse")%></p></td>
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<!-- LOGOUT: -->
	
	<h2> Logout: </h2>
	
	<a href="logout.jsp">Logout</a>
	
	
	
	
	
	
	
	
	
	<!-- DELETE ACCOUNT: -->
	
	<h2> Delete Account: </h2>
	
	<a href="delete.jsp">DELETE ACCOUNT</a>
</body>
</html>