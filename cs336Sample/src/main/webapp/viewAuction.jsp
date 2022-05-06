<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime, java.time.format.DateTimeFormatter"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Auctions</title>
</head>
<body>


<% 

try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Get the combobox from the index.jsp
			String auctionID = request.getParameter("auctionID");
			session.setAttribute("currAuctionID", auctionID);
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM auction a, clothing c WHERE a.itemID = c.itemID AND a.AuctionID = " + auctionID;
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			//out.print(str);
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


		<%  if (result.next()) { %>
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
			
			<br><br>
			
		<% 
			float curr_p = result.getFloat("currentPrice");
			float minimum_bid = curr_p + Float.valueOf(result.getString("increment"));
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-LL-dd HH:mm:ss.S");
		
			LocalDateTime currentTime = LocalDateTime.now();
			String closeTime = result.getString("CloseDate");
			//out.print(closeTime);
			
			LocalDateTime closeDateTime = LocalDateTime.parse(closeTime, formatter);
			
			//out.print("2");
			
			
			if(currentTime.isBefore(closeDateTime)){ %>
				Insert a Bid
				<form method="post" action="bidLogic.jsp">
			    
					<td>Bid Amount: </td><td><input type="number" step="0.01" name="bidAMT" size = "10" min = "<%=minimum_bid%>" required ></td>
					<input type="submit" value="Send Bid">
			
				</form>
				
				
				
				
				
				<br><br>
				
				Auto-Bid
				<form method="post" action="autobidLogic.jsp">
			    
					<td>Automatic Bid Amount: </td><td><input type="number" step="0.01" name="bidAMT" size = "10" min = "<%=minimum_bid%>" required ></td>
					<input type="submit" value="Send Bid">
					
				</form>
		<% 
			}
			else{ // too late %>
				
				
				Auction has closed. 
				
		<% }
			
		%>
			
			 
			
			
			<br><br>
			<br><br>
			
			<% 
			str = "SELECT * FROM bid b WHERE b.auctionID = " + auctionID + " ORDER BY b.price DESC";
			//Run the query against the database.
			result = stmt.executeQuery(str);
			//out.print(str);
			%>
			
			<table>
				<tr>
					<td>Bid Number</td>
					<td>User</td>
					<td>Price</td>
					<td>Date/Time of Bid</td>

				</tr>


		<%  while (result.next()) { %>
				<tr>
					<td> <%= result.getString("bidID")%></td>
					<td> <%= result.getString("user")%></td>
					<td> <%= result.getString("price")%></td>
					<td> <%= result.getString("time")%></td>
				</tr>

		<% }%>
			</table>
			
			
			<%
			//close the connection.
			
			con.close();

		} catch (Exception e) {
			out.print("Error");
		} %>








</body>
</html>