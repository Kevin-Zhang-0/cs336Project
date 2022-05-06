<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Remove a User's Bid</title>
</head>
<body>
	<%--may add current customer rep list--%>
	
	List of Bids:
	
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
			
			//Get the combobox from the index.jsp
			//String entity = request.getParameter("price");
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM bid b";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
	%>
	
			<table>
				<tr>
					<td>bidID</td>
					<td>user</td>
					<td>AuctionID</td>
					<td>price</td>
					<td>time</td>
				</tr>


		<%  while (result.next()) { %>
				<tr>
					<td> <%= result.getString("bidID")%></td>
					<td> <%= result.getString("user")%></td>
					<td> <%= result.getString("AuctionID")%></td>
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
		}
	%>

	<br>	
To delete a bid, please enter its bidID.
	<br>
		<form method="post" action="userBidRemoveLogic.jsp">
			<table>
				<tr>    
				<td>bidID:</td><td><input type="text" name="deleteBid"></td>
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