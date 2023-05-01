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
		
		String query = "SELECT * FROM question";
		
		PreparedStatement ps = c.prepareStatement(query);
		
		ResultSet result = ps.executeQuery();
		
		if (result.next()) {
			
			%> <h2> Questions: </h2> <%
			
			ResultSetMetaData rsmd = result.getMetaData();
			int columnsNumber = rsmd.getColumnCount();
			
			do {
				
				%> <h5> Question: </h5> <%
				
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
		<jsp:param name="questionResponse" value="Error displaying user questions. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
	
	
	
	
	
	
	
	<!-- ANSWER A USER QUESTION -->
	
	<h2>Answer a user question:</h2>
	
	<form action="answerStatus.jsp" method="post">

		<table>
			
			<tr><td>Enter question ID:</td><td><input type=number name=questionId></td></tr>
			<tr><td>Enter answer:</td><td><input type=text maxlength=100 name=solutionDetails></td></tr>
			<tr><td><input type=Submit value=Submit></td></tr>
			
			<% if (request.getParameter("answerResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("answerResponse")%></p></td>
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