
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDateTime, java.time.format.DateTimeFormatter"%>




    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search User's Auctions</title>
</head>
<body>
<% 
out.print("Current User: " + session.getAttribute("username"));
%>

<form method="get" action="UserHomepage.jsp">	
		
	<input type="submit" value="Back to Homepage">
</form>



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
	
	


	<%
		List<String> list = new ArrayList<String>();

		try {

			//out.print("here");
			
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Get the combobox from the index.jsp
			
			String username = request.getParameter("username");
			
			
			if(username == null){
				out.print("User does not exist");
			}
			
			else{
				
			
			String query;
			
			//out.print("here1");
			
			
			query = "SELECT DISTINCT(a.AuctionID), a.InitialPrice, a.InitialPrice, a.CloseDate, a.increment, a.CurrentPrice, a.user, c.name, c.sex, c.type FROM auction a, bid b, clothing c WHERE c.itemID = a.itemID AND (a.user = \"" + username +"\" OR (b.auctionID = a.auctionID AND b.user = \"" + username +"\"))";
			//query = "SELECT * FROM auction a, bid b, clothing c WHERE b.user = \"" + username +"\"";

			
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
			String time = LocalDateTime.now().format(formatter);
			

			
			//out.print("here2");
			
			%>
			Sort Auctions by Criteria:
				
				<br>
					<form method="post" action="searchUserAuctions.jsp">
						
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
						<input type="hidden" name="username" value="<%=username%>">
						

						<br>
						<input type="submit" value="Search">
					</form>
				<br>
				
				<%

				
				
				String sortCriteria = request.getParameter("sortCriteria");
				//out.println("HERE1");
				if(sortCriteria != null && !sortCriteria.equals("none")){
					//out.println("HERE2");
					if(sortCriteria.equals("type")){
						
						query += " ORDER BY type";
					}
					else if(sortCriteria.equals("sex")){
						query += " ORDER BY sex";
					}
					else if(sortCriteria.equals("price")){
						query += " ORDER BY CurrentPrice";
					}
					else if(sortCriteria.equals("closeDate")){
						query += " ORDER BY CloseDate";
					}
					//out.println("HERE3");
					String sortDirection = request.getParameter("sortDirection");
					
					if(sortDirection.equals("ascending")){
						query += " ASC";
					}
					else{
						query += " DESC";
					}
				}
				
			//out.print(query);
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(query);
			
			//out.print("here3");
	%>
	
		<br>
	
			Current Auctions:
		
	    <br>
	
			<table>
				<tr>
					<td>Auction Number</td>
					<td>ItemName</td>
					<td>Auctioner</td>
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
					<td> <%= result.getString("user")%></td>
					<td> <%= result.getString("type")%></td>
					<td> <%= result.getString("sex")%></td>
					<td> <%= result.getString("currentPrice")%></td>
					<td> <%= result.getString("InitialPrice")%></td>
					<td> <%= result.getString("increment")%></td>
					<td> <%= result.getString("CloseDate")%></td>
				</tr>


		<% }
		}
		%>
		
		
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