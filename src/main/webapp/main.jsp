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
			
			<tr><td>Auction Closing Date and Time:</td><td><input type=text length=50 name=closingDateTime></td></tr>
			
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
	
	
	
	
	<!-- PLACE A BID: -->
	
	<h2>Place a bid on an auction item:</h2>
	
<%
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection c = db.getConnection();
		
		String query = "SELECT * FROM auctionItem";
		
		PreparedStatement ps = c.prepareStatement(query);
		ResultSet result = ps.executeQuery();
		
		if (result != null) {
			ResultSetMetaData rsmd = result.getMetaData();
			int columnsNumber = rsmd.getColumnCount();
			while (result.next()) {
				%> <h5> Auction Item: </h5> <%
			    String auctionItem = "";
				for (int i = 1; i <= columnsNumber; i++) {
					auctionItem += result.getString(i) + "    ";
			    }
				%> <pre> <%= auctionItem %>		 </pre>
		        <%
			}
		}
	} catch (Exception e) {
		System.out.println(e);
		%>
		<pre> Error fetching auction items. Please reload the page. </pre>
		<%
	}
%>

	<form action="bidStatus.jsp" method="post">

		<table>
			
			<tr><td>Enter itemId:</td><td><input type=number name=itemId></td></tr>
			<tr><td>Enter bid value:</td><td><input type=number name=bidAmount></td></tr>
			
			<tr><td><input type=Submit value="Place Bid"></td></tr>
			
			<% if (request.getParameter("bidResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("bidResponse")%></p></td>
				</tr>
			<% } %>
		
		</table>
	
	</form>
	
	
	<h2> Logout: </h2>
	
	<a href="logout.jsp">Logout</a>
</body>
</html>