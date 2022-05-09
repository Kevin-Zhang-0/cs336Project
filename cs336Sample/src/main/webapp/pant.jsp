<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDateTime, java.time.format.DateTimeFormatter"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<%


	%>

	<form method="get" action="UserHomepage.jsp">	
			
		<input type="submit" value="Back to Homepage">
	</form>
	<br>

	<%
	
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("uuuu-MM-dd'T'HH:mm");
	String time = LocalDateTime.now().format(formatter);
	%>
	<br>
		<form method="post" action="newAuctionPantLogic.jsp">
			<table>
				<tr>
					<td>Pants Name:</td><td><input type="text" name="shirt_name" required></td>
					
				</tr>
			
				<tr>    
					<td>Sex(F|M):</td>
					<td>
						<select name="shirt_sex" size=1>
							<option value="F">F</option>	
							<option value="M">M</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>WastWidth Size:</td><td><input type="number" min = "2" name="shirt_WaistWidth" required></td>
				</tr>
				<tr>
					<td>LegLength Size:</td><td><input type="number" min = "2" name="shirt_LegLength" required></td>
				</tr>
				<tr>
					<td>Initial Price:</td><td><input type="number" step="0.01" name="shirt_initial_price" required></td>
				</tr>
				<tr>
					<td>Lowest Selling Price:</td><td><input type="number" step="0.01" name="shirt_lowest_selling_price" required></td>
				</tr>
				<tr>
					<td>Bid Increments:</td><td><input type="number" step="0.01" name="shirt_bid_increments" required></td>
				</tr>
				<tr>
					<td>Closing Date:</td><td><input type="datetime-local" name="shirt_closing_date" min="<%=time%>" required></td>
				</tr>
				
				
			</table>
			<input type="submit" value="Submit Auction Item">
		</form>
	<br>
	<h1><% 
	
	session.setAttribute("errors", null);
	request.getParameter("closing_date");%></h1>
	
	
	
	
	
	
</body>
</html>