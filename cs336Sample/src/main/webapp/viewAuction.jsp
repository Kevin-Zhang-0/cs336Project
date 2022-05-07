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
			Statement shirtStmt = con.createStatement();
			Statement pantsStmt = con.createStatement();
			Statement shoeStmt = con.createStatement();

			//Get the combobox from the index.jsp
			String auctionID = request.getParameter("auctionID");
			session.setAttribute("currAuctionID", auctionID);
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM auction a, clothing c WHERE a.itemID = c.itemID AND a.AuctionID = " + auctionID;
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			String isShirtQuery = "SELECT * FROM auction a, shirt s WHERE a.itemID = s.itemID AND a.AuctionID = " + auctionID;
			ResultSet shirtResult = shirtStmt.executeQuery(isShirtQuery);
			String type = "";
			if(shirtResult.next()){
				type = "shirt";
			}
			else{
				String isPantsQuery = "SELECT * FROM auction a, pants p WHERE a.itemID = p.itemID AND a.AuctionID = " + auctionID;
				ResultSet pantsResult = pantsStmt.executeQuery(isPantsQuery);
				
				if(pantsResult.next()){
					type = "shirt";
				}
				else{
					String isShoeQuery = "SELECT * FROM auction a, shoe s WHERE a.itemID = s.itemID AND a.AuctionID = " + auctionID;
					ResultSet shoeResult = shoeStmt.executeQuery(isShoeQuery);
					if(shoeResult.next()){
						type = "shoe";
					}
					else{
						type = "error";
					}
					
				}
			}
			
			
			
			
			
			//out.println(shirtResult.next());
			
			
			
	%>
			<form method="get" action="UserHomepage.jsp">	
					
				<input type="submit" value="Back to Homepage">
			</form>


			<br>

		<%  if (result.next()) { %>

			<table>
				
				
				<tr>
					<td>Auction Number</td>
					<td> <%= result.getString("AuctionID")%></td>
					
				</tr>
				
				<tr>
					<td>Auction Creator</td>
					<td> <%= result.getString("user")%></td>
					
				</tr>
				

				
				<tr>
					<td>Starting Price</td>
					<td> <%= result.getString("InitialPrice")%></td>
					
				</tr>
				
				
			</table>
			<br>
			
		    <%
		    if(type.equals("shirt")){%>
			<table>
				
				
				<tr>
					<td>Clothing Type</td>
					<td>Shirt</td>
					
				</tr>
				
				<tr>
					<td>Item Name</td>
					<td> <%= result.getString("name")%></td>
					
				</tr>
				<tr>
					<td>Shirt Size</td>
					<td> <%= shirtResult.getString("size")%></td>
					
				</tr>
				
				
			</table>
		    	
		    	
			<%}
		    else if(type.equals("pants")){%>
			<table>
			
			
			<tr>
				<td>Clothing Type</td>
				<td>Pants</td>
				
			</tr>
			
			<tr>
				<td>Item Name</td>
				<td> <%= result.getString("name")%></td>
				
			</tr>
			<tr>
				<td>Waist Width</td>
				<td> <%= shirtResult.getString("WaistWidth")%></td>
				
			</tr>
			<tr>
				<td>Pants Length</td>
				<td> <%= shirtResult.getString("LegLength")%></td>
				
			</tr>
			
			<tr>
				<td>Pants Size</td>
				<td> <%= shirtResult.getString("WaistWidth")%> / <%= shirtResult.getString("LegLength")%></td>
				
			</tr>
			
			
		</table>
	    	
	    	
		<%

		    	
		    	
		    	
		    	
		    	
		    }
		    else if(type.equals("shoe")){%>
			<table>
			
			
			<tr>
				<td>Clothing Type</td>
				<td>Shoe</td>
				
			</tr>
			
			<tr>
				<td>Item Name</td>
				<td> <%= result.getString("name")%></td>
				
			</tr>
			<tr>
				<td>Shirt Size</td>
				<td> <%= shirtResult.getString("size")%></td>
				
			</tr>
			
			
		</table>
	    	

			<br>
			
			
			<%}
		    else{
		    	
		    	%>Clothing Type Error!<% 
		    }
		    //out.println(5);
			%>
			
			<br>
			
			<table>
				<tr>
					<td>Close Date and Time: </td>
					<td> <%= result.getString("CloseDate")%></td>	
				</tr>
				<tr>
					<td>Current Price</td>
					<td><%= result.getString("currentPrice")%></td>
					
				</tr>
				<tr>
					<td>Current Highest Bidder</td>
				<%
				if(result.getString("highest_bidder") == null){	%>
					<td>None</td>
				<% 
				}
				else{%>
					<td><%= result.getString("highest_bidder")%></td>
				<% }%>
				 
				 
				 </tr>
				<tr>
					<td>Minimum Increment</td>
					<td> <%= result.getString("increment")%></td>
					
				</tr>
			</table>
			
		<% }
			else{
				%>No bids yet, Be the first!<% 
			}
			
		%>	
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
			if(result.getString("user").equals(session.getAttribute("username"))){
				%>
				This is your auction.
				<% 
			}
			else if(session.getAttribute("username").equals(result.getString("highest_bidder"))){
				%>
				You are currently winning this auction.
				
				<% 
			}
				
			
			else if(currentTime.isBefore(closeDateTime)){ 
				stmt = con.createStatement();
				
				//Get the combobox from the index.jsp
				
				session.setAttribute("currAuctionID", auctionID);
				//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
				String sstr = "SELECT * FROM autobid a WHERE a.creator = \""+ session.getAttribute("username") + "\" AND a.AuctionID = " + auctionID;
				
				//Run the query against the database.
				ResultSet results = stmt.executeQuery(sstr);
				
			
			
			
			
			
			
			
			
			%>
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