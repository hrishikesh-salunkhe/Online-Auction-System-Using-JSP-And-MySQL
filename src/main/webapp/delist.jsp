<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="DBDS.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View and Delist Auction Items</title>
</head>
<body>
<%
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection c = db.getConnection();
		
		String query = "SELECT * FROM auctionItem";
		
		PreparedStatement ps = c.prepareStatement(query);
		ResultSet result = ps.executeQuery();
		
		if (result.next()) {
			
			%> <h2> Auction Items: </h2> <%
			
			ResultSetMetaData rsmd = result.getMetaData();
			int columnsNumber = rsmd.getColumnCount();
			do {
				%> <h5> Auction Item: </h5> <%
				String auctionItem = "";
				for (int i = 1; i <= columnsNumber; i++) {
					if(!rsmd.getColumnLabel(i).equals("minPrice")){
						auctionItem += rsmd.getColumnLabel(i) +": "+ result.getString(i) + "    ";	
					}
			    }
				%> <pre> <%= auctionItem %>		 </pre>
		        <%
			} while (result.next());
		}
		
	} catch (Exception e) {
		System.out.println(e);
		
		%>
		<jsp:forward page="custRepMain.jsp">
		<jsp:param name="delistResponse" value="Error fetching auction items. Please try again."/> 
		</jsp:forward>
		<%
	}
%>

<h2>Delist an auction item:</h2>
	
	<form action="delistStatus.jsp" method="post">

		<table>
			
			<tr><td>Enter item ID:</td><td><input type=number name=itemId></td></tr>
			<tr><td><input type=Submit value=Submit></td></tr>
			
			<% if (request.getParameter("itemDelistResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("itemDelistResponse")%></p></td>
				</tr>
			<% } %>
		
		</table>
	
	</form>
	
		<br/><br/>
	

<!-- HOME PAGE: -->
	
	<a href="custRepMain.jsp">Home Page</a>
	
	
	
	
	<br/><br/>
	
<!-- LOGOUT: -->
	
	<a href="logout.jsp">Logout</a>
	

</body>
</html>