<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="DBDS.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Results</title>
</head>
<body>
<%
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection c = db.getConnection();
		
		String userId = session.getAttribute("userId").toString();
		
		String query="";
		if(request.getParameter("orderBy") != null && request.getParameter("ascDesc") != null){
			query ="SELECT * FROM auctionItem WHERE sellerId <> (?) ORDER BY "
					+ request.getParameter("orderBy") + " " + request.getParameter("ascDesc");	
		}else{
			query ="SELECT * FROM auctionItem WHERE sellerId <> (?)";
		}
		
		PreparedStatement ps = c.prepareStatement(query);
		ps.setString(1, userId);
		
		ResultSet result = ps.executeQuery();
		
		if (result != null) {
			ResultSetMetaData rsmd = result.getMetaData();
			int columnsNumber = rsmd.getColumnCount();
			while (result.next()) {
				%> <h5> Auction Item: </h5> <%
			    String auctionItem = "";
				for (int i = 1; i <= columnsNumber; i++) {
					if(!rsmd.getColumnLabel(i).equals("minPrice")){
						auctionItem += rsmd.getColumnLabel(i) +": "+ result.getString(i) + "    ";	
					}
			    }
				%> <pre> <%= auctionItem %>		 </pre>
		        <%
			}
		}
		
	} catch (Exception e) {
		System.out.println(e);
		%>
		<jsp:forward page="main.jsp">
		<jsp:param name="auctionResponse" value="Error searching auction items. Please try again."/> 
		</jsp:forward>
		<%
	}
%>








	<!-- PLACE A BID: -->
	
	<h2>Place a bid on an auction item:</h2>

	<form action="auctionBidStatus.jsp" method="post">

		<table>
			
			<tr><td>Enter itemId:</td><td><input required type=number name=itemId></td></tr>
			<tr><td>Enter bid value:</td><td><input required type=number name=bidAmount></td></tr>
			<tr><td>Enable Auto-Bidding?:</td>
			<td>
				<select required name="autoBid">
				  <option value="yes">Yes</option>
				  <option selected value="no">No</option>
				</select>
			</td></tr>
			<tr><td>Auto-Bid Upper Limit:</td><td><input required type=number value=0 name=upperLimit></td></tr>
			
			
			<tr><td><input type=Submit value="Place Bid"></td></tr>
			
			<% if (request.getParameter("bidResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("bidResponse")%></p></td>
				</tr>
			<% } %>
		
		</table>
	
	</form>
	
	
	

<!-- HOME PAGE: -->
	
	<a href="main.jsp">Home Page</a>
	
	
	
	
	
<!-- LOGOUT: -->
	
	<a href="logout.jsp">Logout</a>
	
	
</body>
</html>