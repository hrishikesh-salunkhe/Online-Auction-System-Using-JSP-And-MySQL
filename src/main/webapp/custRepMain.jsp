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

	
	
	
	
	
	
	<!-- VIEW, MODIFY AND DELETE USER ACCOUNTS -->
	
	<h2>View, Modify and Delete User Accounts:</h2>
	
	<form action="viewModifyDelete.jsp" method="post">

		<table>
			
			<tr><td><input type=Submit value=View></td></tr>
			
			<% if (request.getParameter("viewModifyDeleteResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("viewModifyDeleteResponse")%></p></td>
				</tr>
			<% } %>
		
		</table>
	
	</form>
	
	
	
	
	
	
	
	
	
	<!-- ANSWER USER QUESTION -->
	
	<h2>View and Answer user questions:</h2>
	
	<form action="questions.jsp" method="post">

		<table>
			
			<tr><td><input type=Submit value=Submit></td></tr>
			
			<% if (request.getParameter("questionResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("questionResponse")%></p></td>
				</tr>
			<% } %>
		
		</table>
	
	</form>
	
	
	
	
	
	
	
	
	<!-- DELIST AN AUCTION ITEM -->
	
	<h2>View and Delist Auction Items:</h2>
	
	<form action="delist.jsp" method="post">

		<table>
			
			<tr><td><input type=Submit value=View></td></tr>
			
			<% if (request.getParameter("delistResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("delistResponse")%></p></td>
				</tr>
			<% } %>
		
		</table>
	
	</form>
	
	
	
	
	
	
	
	
	<!-- REMOVE A BID -->
	
	<h2>View and Remove Bids:</h2>
	
	<form action="removeBid.jsp" method="post">

		<table>
			
			<tr><td><input type=Submit value=View></td></tr>
			
			<% if (request.getParameter("removeResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("removeResponse")%></p></td>
				</tr>
			<% } %>
		
		</table>
	
	</form>
	
	<br/><br/>
		
	<a href="custRepLogout.jsp">Logout</a>
</body>
</html>