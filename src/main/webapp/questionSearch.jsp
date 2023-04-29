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
		
		String keyword = "%" + request.getParameter("keyword") + "%";
		System.out.println(keyword);
		String query = "SELECT * FROM question WHERE userId=(?) AND questionDetails LIKE (?)";
		
		PreparedStatement ps = c.prepareStatement(query);
		
		ps.setString(1, userId);
		ps.setString(2, keyword);
		
		ResultSet result = ps.executeQuery();
		
		if (result != null) {
			ResultSetMetaData rsmd = result.getMetaData();
			int columnsNumber = rsmd.getColumnCount();
			while (result.next()) {
				%> <h4> Question: </h4> <%
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
		<jsp:param name="questionSearchResponse" value="Error searching questions. Please try again."/> 
		</jsp:forward>
		<%
	}
%>

	
	
	


<!-- HOME PAGE: -->
	
	<a href="main.jsp">Home Page</a>
	
	
	
	<br/>
	<br/>
	
<!-- LOGOUT: -->
	
	<a href="logout.jsp">Logout</a>
	
</body>
</html>