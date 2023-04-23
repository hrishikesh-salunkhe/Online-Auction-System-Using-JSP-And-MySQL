<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DBDS.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Representative Panel</title>
</head>
<body>
	<h1> Welcome to the Customer Representative Panel! </h1>
	
	<h2>Change a user's password:</h2>
	
	<form action="modifyStatus.jsp" method="post">

		<table>
			
			<tr><td>Enter userId:</td><td><input type=text maxlength=10 name=userId></td></tr>
			<tr><td>Enter new Password:</td><td><input type=password maxlength=20 name=password></td></tr>
			<tr><td><input type=Submit value=Modify></td></tr>
			
			<% if (request.getParameter("modifyResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("modifyResponse")%></p></td>
				</tr>
			<% } %>
		
		</table>
	
	</form>
	
	<h2>Answer a user's question:</h2>
	
<%
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection c = db.getConnection();
		
		String query = "SELECT * FROM question WHERE solutionDetails IS NULL";
		
		PreparedStatement ps = c.prepareStatement(query);
		ResultSet result = ps.executeQuery();
		
		if (result != null) {
			ResultSetMetaData rsmd = result.getMetaData();
			int columnsNumber = rsmd.getColumnCount();
			while (result.next()) {
				%> <h5> QUESTION: </h5> <%
			    String question = "";
				for (int i = 1; i <= columnsNumber; i++) {
			        question += result.getString(i) + "    ";
			    }
				%> <pre> <%= question %>		 </pre>
		        <%
			}
		}
	} catch (Exception e) {
		System.out.println(e);
		%>
		<pre> Error fetching questions. Please reload the page. </pre>
		<%
	}
%>
	<form action="solutionStatus.jsp" method="post">

		<table>
			
			<tr><td>Enter questionId:</td><td><input type=number name=questionId></td></tr>
			<tr><td>Enter the answer:</td><td><input type=text maxlength=100 name=solutionDetails></td></tr>
			<tr><td><input type=Submit value=Submit></td></tr>
			
			<% if (request.getParameter("solutionResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("solutionResponse")%></p></td>
				</tr>
			<% } %>
		
		</table>
	
	</form>
	
	<h2>Delist an Auction Item:</h2>
	
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
		<pre> Error fetching questions. Please reload the page. </pre>
		<%
	}
%>
	<form action="delistStatus.jsp" method="post">

		<table>
			
			<tr><td>Enter itemId:</td><td><input type=number name=itemId></td></tr>
			<tr><td><input type=Submit value=Delist></td></tr>
			
			<% if (request.getParameter("delistResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("delistResponse")%></p></td>
				</tr>
			<% } %>
		
		</table>
	
	</form>
		
	<a href="custRepLogout.jsp">Logout</a>
</body>
</html>