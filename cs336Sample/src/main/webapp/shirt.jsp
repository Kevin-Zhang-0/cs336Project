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

	<%

	out.print("Current User: " + session.getAttribute("username"));
	%>

	<form method="get" action="UserHomepage.jsp">	
			
		<input type="submit" value="Back to Homepage">
	</form>
	<br>

	<%
	String i1= "";
	String i2= "";
	String i3= "";
	String i4= "";
	String i5= "";
	String i6 = "";
	String i7= "";
	
	if(request.getAttribute("errors")!=null&& !(((HashMap)request.getAttribute("errors")).isEmpty())){
		i1 = (String) session.getAttribute("shirt_name");
		i2 = (String) session.getAttribute("shirt_sex");
		i3 = (String) session.getAttribute("shirt_size");
		i4 = (String) session.getAttribute("shirt_initial_price");
		i5 = (String) session.getAttribute("shirt_lowest_selling_price");
		i6 = (String) session.getAttribute("shirt_bid_increments");
		i7 = (String) session.getAttribute("shirt_closing_date");
	}
	
	%>
	<br>
		<form method="post" action="newAuctionLogic.jsp">
			<table>
				<tr>
					<td>Shirt Name:</td>					
					<td><input type="text" name="shirt_name" value = "<%=i1%>" required></td>
					<td><span class="error">${errors.origin}</span></td>
					
				</tr>
			
				<tr>    
					<td>Sex(F|M):</td><td><input type="text" maxlength="1" name="shirt_sex" required ></td>
				</tr>
				<tr>
					<td>Size(L|M|S):</td><td><input type="text" maxlength="1" name="shirt_size" required></td>
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
					<td>Closing Date(YYYY.MM.DD):</td><td><input type="text" name="shirt_closing_date" required></td>
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