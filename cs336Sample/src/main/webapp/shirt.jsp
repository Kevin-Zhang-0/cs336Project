<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
	
	
	<br>
		<form method="post" action="loginLogic.jsp">
			<table>
				<tr>
					<td>Shirt Name:</td><td><input type="text" name="shirt_name"></td>
				</tr>
			
				<tr>    
					<td>Sex(F|M):</td><td><input type="text" name="shirt_sex"></td>
				</tr>
				<tr>
					<td>Size(L|M|S):</td><td><input type="text" name="shirt_size"></td>
				</tr>
				<tr>
					<td>Initial Price:</td><td><input type="text" name="shirt_initial_price"></td>
				</tr>
				<tr>
					<td>Lowest Selling Price:</td><td><input type="text" name="shirt_lowest_selling_price"></td>
				</tr>
				<tr>
					<td>Bid Increments:</td><td><input type="text" name="shirt_bid_increments"></td>
				</tr>
				<tr>
					<td>Closing Date:</td><td><input type="text" name="shirt_closing_date"></td>
				</tr>
				
				
			</table>
			<input type="submit" value="Submit Auction Item">
		</form>
	<br>
	<h1><% request.getParameter("closing_date");%></h1>
	
	
	
	
	
	
</body>
</html>