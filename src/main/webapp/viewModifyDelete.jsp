<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="DBDS.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View, Modify and Delete User Accounts</title>
</head>
<body>
<%
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection c = db.getConnection();
		
		String query = "SELECT * FROM user";
		
		PreparedStatement ps = c.prepareStatement(query);
		
		ResultSet result = ps.executeQuery();
		
		if (result.next()) {
			
			%> <h2> User Accounts: </h2> <%
			
			ResultSetMetaData rsmd = result.getMetaData();
			int columnsNumber = rsmd.getColumnCount();
			
			do {
				
				%> <h5> Account: </h5> <%
				
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
		<jsp:param name="viewModifyDeleteResponse" value="Error displaying user accounts. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
	
	
	
	
	
	<br/><br/>
	
	<!-- CHANGE USER PASSWORD -->
	
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
	
	
	
	<br/><br/>
	
	
	<!-- DELETE A USER ACCOUNT -->
	
	<h2>Delete a user account:</h2>
	
	<form action="userDeleteStatus.jsp" method="post">

		<table>
			
			<tr><td>Enter userId:</td><td><input type=text maxlength=10 name=userId></td></tr>
			<tr><td><input type=Submit value=Delete></td></tr>
			
			<% if (request.getParameter("userDeleteResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("userDeleteResponse")%></p></td>
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