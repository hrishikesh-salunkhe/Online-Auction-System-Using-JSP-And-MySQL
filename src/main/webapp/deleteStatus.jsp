<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="DBDS.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Confirm Delete</title>
</head>
<body>

<h2>You sure you want to delete your account?: </h2>

<a href="confirmDelete.jsp"> YES </a>

<br/>
<br/>

<a href="main.jsp"> NO </a>

<% if (request.getParameter("deleteResponse") != null) { %>
	<p><%=request.getParameter("deleteResponse")%></p>
<% } %>

</body>
</html>