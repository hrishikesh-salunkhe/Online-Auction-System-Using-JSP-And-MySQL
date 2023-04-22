<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Dashboard</title>
</head>
<body>
	<h1> Welcome to the Online Auction System! </h1>
	
	<h2> Publish an item: </h2>
	
	<form action="auctionStatus.jsp" method="post">
		<table>
			<tr><td>Art Name:</td><td><input type=text maxlength=40 name=name></td></tr>
			
			<tr><td>Art Length:</td><td><input type=number name=length></td></tr>
			
			<tr><td>Art Breadth:</td><td><input type=number name=breadth></td></tr>
			
			<tr><td>Color Type:</td>
			<td>
				<select name="colorType">
				  <option value="Acrylic">Acrylic</option>
				  <option value="Oil">Oil</option>
				  <option value="Watercolor">Watercolor</option>
				  <option value="Gouache">Gouache</option>
				  <option value="Encaustic">Encaustic</option>
				  <option value="Fresco">Fresco</option>
				  <option value="Spray Paint">Spray Paint</option>
				  <option value="Digital">Digital</option>
				  <option value="Pastel">Pastel</option>
				</select>
			</td></tr>
			
			<tr><td>Painting Style:</td>
			<td>
				<select name="paintingStyle">
				  <option value="Realism">Realism</option>
				  <option value="Photorealism">Photorealism</option>
				  <option value="Expressionism">Expressionism</option>
				  <option value="Impressionism">Impressionism</option>
				  <option value="Abstract">Abstract</option>
				  <option value="Surrealism">Surrealism</option>
				  <option value="Pop Art">Pop Art</option>
				</select>
			</td></tr>
			
			<tr><td>Art Description:</td><td><input type=text maxlength=100 name=description></td></tr>
			
			<tr><td>Artist:</td><td><input type=text maxlength=50 name=artist></td></tr>
			
			<tr><td>Starting Price:</td><td><input type=number name=initialPrice></td></tr>
			
			<tr><td>Minimum Acceptable Price:</td><td><input type=number name=initialPrice></td></tr>
			
			<tr><td>Auction Closing Date and Time:</td><td><input type=text length=50 name=closingDateTime></td></tr>
			
			<tr><td>Bid Increment Amount:</td><td><input type=text length=50 name=incrementAmount></td></tr>
			
			<tr><td><input type=Submit value=Submit></td></tr>
			
			<% if (request.getParameter("questionResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("questionResponse")%></p></td>
				</tr>
			<% } %>
		</table>
	</form>
	
	<h2> Ask a question: </h2>
	
	<form action="questionStatus.jsp" method="post">
		<table>
			<tr><td>Question:</td><td><input type=text maxlength=100 name=questionDetails></td></tr>
			<tr><td><input type=Submit value=Submit></td></tr>
			
			<% if (request.getParameter("questionResponse") != null) { %>
				<tr>
					<td><p><%=request.getParameter("questionResponse")%></p></td>
				</tr>
			<% } %>
		</table>
	</form>
	
	<h2> Logout: </h2>
	
	<a href="logout.jsp">Logout</a>
</body>
</html>