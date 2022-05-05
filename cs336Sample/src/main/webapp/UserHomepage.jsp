<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
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

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Auction");
			out.print("</td>");
			
			out.print("<td>");
			out.print("ItemName");
			out.print("</td>");
			
			//make a column
			out.print("<td>");
			out.print("ItemID");
			out.print("</td>");
			
			//make a column
			out.print("<td>");
			out.print("Current Price");
			out.print("</td>");
			
			out.print("<td>");
			out.print("Initial Price");
			out.print("</td>");
			
			out.print("<td>");
			out.print("Increment");
			out.print("</td>");
			

			
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("AuctionID"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("name"));
				out.print("</td>");
				
				out.print("<td>");
				//Print out current beer name:
				out.print(result.getString("itemID"));
				out.print("</td>");
				
				out.print("<td>");
				//Print out current price
				out.print(result.getString("currentPrice"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("InitialPrice"));
				out.print("</td>");

				out.print("<td>");
				out.print(result.getString("increment"));
				out.print("</td>");
				
				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
			out.print("Error");
		}
	%>
 
	
 	
	
 	
	
	
	
</body>
</html>	