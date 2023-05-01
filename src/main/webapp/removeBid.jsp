<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DBDS.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
		
		String query = "SELECT * FROM bid";
		
		PreparedStatement ps = c.prepareStatement(query);
		ResultSet result = ps.executeQuery();
		
		if (result != null) {
			ResultSetMetaData rsmd = result.getMetaData();
			int columnsNumber = rsmd.getColumnCount();
			while (result.next()) {
				%> <h5> Bid: </h5> <%
			    String auctionItem = "";
				for (int i = 1; i <= columnsNumber; i++) {
					auctionItem += rsmd.getColumnLabel(i) + ": " + result.getString(i) + "    ";
			    }
				%> <pre> <%= auctionItem %>		 </pre>
		        <%
			}
		}
	} catch (Exception e) {
		System.out.println(e);
		
			%>
			<jsp:forward page="custRepMain.jsp">
			<jsp:param name="removeResponse" value="Error fetching bids. Please try again."/> 
			</jsp:forward>
			<% //ABOVE: FORWARD TO HOME PAGE WITH CURRENT USERNAME ATTACHED
			
	}
%>

	<!-- REMOVE A BID -->
	
	<h2>View and Remove Bids:</h2>
	
	<form action="removeBidStatus.jsp" method="post">

		<table>
			
			<tr><td>Enter bid ID:</td><td><input type=number name=bidId></td></tr>
			<tr><td><input type=Submit value=Remove></td></tr>
			
			<% if (request.getParameter("removeBidResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("removeBidResponse")%></p></td>
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