<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Remove a User's Auction</title>
</head>
<body>
	<%--may add current customer rep list--%>
	
	List of Auctions:
	
	<br>
	<br>
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM auction a";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
	%>
	
			<table>
				<tr>
					<td>AuctionID</td>
					<td>Initial Price</td>
					<td>Closing Date</td>
					<td>Lowest Selling Price</td>
					<td>Increment</td>
					<td>Current Price</td>
					<td>ItemID</td>
					<td>User</td>
					<td>Highest Bidder</td>
				</tr>


		<%  while (result.next()) { %>
				<tr>
					<td> <%= result.getString("AuctionID")%></td>
					<td> <%= result.getString("InitialPrice")%></td>
					<td> <%= result.getString("CloseDate")%></td>
					<td> <%= result.getString("LowestSelliingPrice")%></td>
					<td> <%= result.getString("increment")%></td>
					<td> <%= result.getString("CurrentPrice")%></td>
					<td> <%= result.getString("itemID")%></td>
					<td> <%= result.getString("user")%></td>
					<td> <%= result.getString("highest_bidder")%></td>
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

	<br>	
To delete an auction, please enter its AuctionID.
	<br>
		<form method="post" action="userAuctionRemoveLogic.jsp">
			<table>
				<tr>    
				<td>AuctionID:</td><td><input type="text" name="deleteAuction"></td>
				</tr>

			</table>
			<input type="submit" value="Confirm">
		</form>
	<br>
	<form method="post" action="customerRepHomepage.jsp">
				
		<input type="submit" value="Back">   
	</form>
</body>
</html>