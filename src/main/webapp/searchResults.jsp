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
		
		String subcategory = request.getParameter("subcategory");
		String lengthFrom = request.getParameter("lengthFrom");
		String breadthFrom = request.getParameter("breadthFrom");
		String lengthTo = request.getParameter("lengthTo");
		String breadthTo = request.getParameter("breadthTo");
		String colorType = request.getParameter("colorType");
		String initialPriceFrom = request.getParameter("initialPriceFrom");
		String initialPriceTo = request.getParameter("initialPriceTo");
		
		String query = "SELECT * FROM auctionItem WHERE subcategory=(?) AND (?) <= length <= (?)"
						+ " AND (?) <= breadth <= (?) AND colorType=(?) AND (?) <= initialPrice <= (?)";
		
		PreparedStatement ps = c.prepareStatement(query);
		
		ps.setString(1, subcategory);
		ps.setString(2, lengthFrom);
		ps.setString(3, lengthTo);
		ps.setString(4, breadthFrom);
		ps.setString(5, breadthTo);
		ps.setString(6, colorType);
		ps.setString(7, initialPriceFrom);
		ps.setString(8, initialPriceTo);
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
		<jsp:param name="searchResponse" value="Error searching auction items. Please try again."/> 
		</jsp:forward>
		<%
	}
%>

	<!-- PLACE A BID: -->
	
	<h2>Place a bid on an auction item:</h2>

	<form action="searchBidStatus.jsp" method="post">

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