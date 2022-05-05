<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Homepage</title>
</head>
<body>
<% 
out.print("Current User: " + session.getAttribute("username"));
%>
<br>
		<form method="get" action="loginPage.jsp">	
					
			<input type="submit" value="Logout">
		</form>
		
<br>
	
<div class="auction-btn-group">

	
	<table>
	<tr>
		<td>	
				<form method="get" action="shirt.jsp">	
					
					<input type="submit" value="Shirt">
				</form> 
		</td>
		<td><form method="get" action="loginPage.jsp">	
					
			<input type="submit" value="Pants">
			</form> 
			</td>
		<td> 
			<form method="get" action="loginPage.jsp">	
					
			<input type="submit" value="Shoes">
			</form>
		
		</td>
	
	
	
	</tr>
	
	</table>
</div>

<br>

To view an auction, enter the auctionID number.
	<br>
		<form method="post" action="viewAuction.jsp">
			<table>
				<tr>    
					<td>Auction Number:</td><td><input type="text" name="auctionID"></td>
				</tr>

			</table>
			<input type="submit" value="View">
		</form>
	<br>
	
	
Search For An Type of Item
	<br>
		<form method="post" action="searchAuctions.jsp">
		
			<select name="type" size=1>
				<option value="shirts">Shirts</option>
				<option value="pants">Pants</option>
				<option value="shoes">Shoes</option>
			</select>
			<select name="sex" size=1>
				<option value="male">M</option>
				<option value="female">F</option>
			</select>
			<select name="ongoing" size=1>
				<option value="ongoing">Ongoing</option>
				<option value="finished">Finished</option>
			</select>
			<br>
			<input type="submit" value="Search">
		</form>
	<br>
	
	
	

	<br>
	
	Current Auctions:
	
    <br>
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Get the combobox from the index.jsp
			//String entity = request.getParameter("price");
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM auction a, clothing c WHERE a.itemID = c.itemID";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
	%>
	
			<table>
				<tr>
					<td>Auction Number</td>
					<td>ItemName</td>
					<td>ItemID</td>
					<td>Current Price</td>
					<td>Initial Price</td>
					<td>Increment</td>
					<td>Close Date/Time</td>
				</tr>


		<%  while (result.next()) { %>
				<tr>
					<td> <%= result.getString("AuctionID")%></td>
					<td> <%= result.getString("name")%></td>
					<td> <%= result.getString("itemID")%></td>
					<td> <%= result.getString("currentPrice")%></td>
					<td> <%= result.getString("InitialPrice")%></td>
					<td> <%= result.getString("increment")%></td>
					<td> <%= result.getString("CloseDate")%></td>
				</tr>

		<% }%>
			</table>
			
			<%
			//close the connection.
			con.close();

		} catch (Exception e) {
			out.print("Error");
		}
	%>
 
	
 	
	
 	
	
	
	
</body>
</html>	