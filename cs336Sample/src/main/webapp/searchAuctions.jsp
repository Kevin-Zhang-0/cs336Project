
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% 
out.print("Current User: " + session.getAttribute("username"));
%>

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
			
			String type = request.getParameter("type");
			String sex = request.getParameter("sex");
			String ongoing = request.getParameter("ongoing");
			String query;
			if(type.equals("shirts")){
				query = "SELECT * FROM auction a, shirt s, clothing c WHERE a.itemID = c.itemID AND s.itemID = c.itemID";
			}
			else if(type.equals("pants")){
				query = "SELECT * FROM auction a, pants p, clothing c WHERE a.itemID = c.itemID AND p.itemID = c.itemID";
			}
			else{ // shoes
				query = "SELECT * FROM auction a, shoe s, clothing c WHERE a.itemID = c.itemID AND s.itemID = c.itemID";
			}
			
			if(sex.equals("male")){
				query += " AND c.sex = \"m\"";
			}
			else{ //female
				query += " AND c.sex = \"f\"";
			}
			//out.print(query);
			if(ongoing.equals("ongoing")){

			}
			else{ //finished
				
			}
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(query);
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