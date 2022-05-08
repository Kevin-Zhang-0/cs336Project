<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDateTime, java.time.format.DateTimeFormatter"%>
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
Alerts:
<%		//display alerts
	

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Get the combobox from the index.jsp
			//String entity = request.getParameter("price");
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String curr_user = (String)session.getAttribute("username");
			String selectAlerts = "SELECT * from bidAlert where user = \"" +curr_user + "\" order by timestamp"  ;
			
			
			
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(selectAlerts);
	%>
	
			<table>
				<tr>
					<td>Auction Number</td>
					<td>Message</td>
					<td>Timestamp</td>
					
				</tr>


		<%  while (result.next()) { %>
				<tr>
					<td> <%= result.getString("AuctionID")%></td>
					<td> <%= result.getString("Message")%></td>
					<td> <%= result.getString("Timestamp")%></td>
					
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
	
	
	
	
<div class="auction-btn-group">
<br>

Want to auction an item? Choose which type of clothing you have
<br>
	
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
					<td>Auction Number:</td><td><input type="text" name="auctionID" required></td>
				</tr>

			</table>
			<input type="submit" value="View">
		</form>
	<br>
	
	
Search For An Auction: 
	<br>
		<form method="post" action="searchAuctions.jsp">
			
			<select name="type" size=1>
				<option value="none">Type</option>
				<option value="shirts">Shirts</option>
				<option value="pants">Pants</option>
				<option value="shoes">Shoes</option>
			</select>
			<select name="sex" size=1>
				<option value="none">Sex</option>
				<option value="male">M</option>
				<option value="female">F</option>
			</select>
			<select name="ongoing" size=1>
				<option value="none">Status</option>
				<option value="ongoing">Ongoing</option>
				<option value="finished">Finished</option>
			</select>
			<br>
			<input type="submit" value="Search">
		</form>
	<br>
	
	
	

	<br>
	
	Sort Auctions by Criteria:
	
	<br>
		<form method="post" action="UserHomepage.jsp">
			
			<select name="sortCriteria" size=1>
				<option value="none">None</option>
				<option value="type">Type</option>
				<option value="sex">Sex</option>
				<option value="price">Current Price</option>
				<option value="closeDate">Close Date</option>
			</select>
			<select name="sortDirection" size=1>
				<option value="ascending">Low To High</option>
				<option value="descending">High To Low</option>
			</select>

			<br>
			<input type="submit" value="Search">
		</form>
	<br>
	
    <br>

    
	<%


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
			
			String sortCriteria = request.getParameter("sortCriteria");
			//out.println("HERE1");
			if(sortCriteria != null && !sortCriteria.equals("none")){
				//out.println("HERE2");
				if(sortCriteria.equals("type")){
					
					str += " ORDER BY type";
				}
				else if(sortCriteria.equals("sex")){
					str += " ORDER BY sex";
				}
				else if(sortCriteria.equals("price")){
					str += " ORDER BY CurrentPrice";
				}
				else if(sortCriteria.equals("closeDate")){
					str += " ORDER BY CloseDate";
				}
				//out.println("HERE3");
				String sortDirection = request.getParameter("sortDirection");
				
				if(sortDirection.equals("ascending")){
					str += " ASC";
				}
				else{
					str += " DESC";
				}
			}
			//out.println(str);
			
			
			
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
	%>
	
			<table>
				<tr>
					<td>Auction Number</td>
					<td>ItemName</td>
					<td>Item Type</td>
					<td>Sex</td>
					<td>Current Price</td>
					<td>Initial Price</td>
					<td>Increment</td>
					<td>Close Date/Time</td>
				</tr>


		<%  while (result.next()) { %>
				<tr>
					<td> <%= result.getString("AuctionID")%></td>
					<td> <%= result.getString("name")%></td>
					<td> <%= result.getString("type")%></td>
					<td> <%= result.getString("sex")%></td>
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
 
 	<br>
 	<br>
 	
	Want to create alarm for us to notify you? Choose the type of cloth you want to make alarm for
	<br>
	
	<table>
	<tr>
		<td>	
			<form method="get" action="alarm_shirt.jsp">		
				<input type="submit" value="Shirt">
			</form> 
		</td>
		<td>
			<form method="get" action="alarm_pants.jsp">		
				<input type="submit" value="Pants">
			</form> 
		</td>
		<td> 
			<form method="get" action="alarm_shoes.jsp">	
				<input type="submit" value="Shoes">
			</form>
		</td>
	</tr>
	
	</table>
	<br>
	
 
	<td> 
			<form method="get" action="customerRepContact.jsp">	
					
			<input type="submit" value="Contact a Customer Representative">
			</form>
		
	</td>
 	
	
 	
	
	
	
</body>
</html>	