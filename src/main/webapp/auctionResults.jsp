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
					auctionItem += rsmd.getColumnLabel(i) +": "+ result.getString(i) + "    ";
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
	
</body>
</html>