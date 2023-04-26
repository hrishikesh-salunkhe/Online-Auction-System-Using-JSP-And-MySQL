<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="DBDS.*" %>
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
		
		String userId = request.getParameter("userId");
		String password1 = request.getParameter("password1");
		String password2 = request.getParameter("password2");
		
		if(!password1.equals(password2)){
			
			%>
			<jsp:forward page="signUp.jsp">
			<jsp:param name="signUpResponse" value="Passwords entered did not match. Please try again"/>
			</jsp:forward>
			<%
			
		}else{
			
			String query = "INSERT INTO user VALUES((?), (?))";
			
			PreparedStatement ps = c.prepareStatement(query);
			ps.setString(1, userId);
			ps.setString(2, password1);
			ps.executeUpdate();
			
			%>
			<jsp:forward page="signUp.jsp">
			<jsp:param name="signUpResponse" value="Account created successfully! Use the link below to sign in."/>
			</jsp:forward>
			<% //ABOVE: FORWARD TO HOME PAGE WITH CURRENT USERNAME ATTACHED
			
		}
		
	} catch (Exception e) {
		%>
		<jsp:forward page="signUp.jsp">
		<jsp:param name="signUpResponse" value="Error signing up. Please try again."/> 
		</jsp:forward>
		<%
	}
%>
</body>
</html>