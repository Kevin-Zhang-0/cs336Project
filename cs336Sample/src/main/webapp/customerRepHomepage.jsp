<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome, Customer Rep</title>
</head>
<body>
	<%--may add current customer rep list--%>
	
	Requests:
	
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
			String str = "SELECT * FROM customerRequests c";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
	%>
	
			<table>
				<tr>
					<td>requestID</td>
					<td>Username</td>
					<td>Request</td>
					<td>Response</td>
					<td>Status</td>
				</tr>


		<%  while (result.next()) { %>
				<tr>
					<td> <%= result.getInt("requestID")%></td>
					<td> <%= result.getString("user")%></td>
					<td> <%= result.getString("request")%></td>
					<td> <%= result.getString("reply")%></td>
					<td> <%= result.getString("status")%></td>
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
To respond to a request, please enter the request number.
	<br>
		<form method="post" action="requestResponse.jsp">
			<table>
				<tr>    
				<td>Request Number:</td><td><input type="text" name="requestID"></td>
				</tr>

			</table>
			<input type="submit" value="Respond">
		</form>
	
<table>
<tr><td><form method = "get" action = "userEdit.jsp">
	<input type="submit" value="Edit a User's Information">
	</form></td>
	<td><form method = "get" action = "userBidRemove.jsp">
		<input type="submit" value="Remove a User's Bid">
	</form></td>
	<td><form method = "get" action = "userAuctionRemove.jsp">
	<input type="submit" value="Remove a User's Auction">
	</form></td>
</tr>
</table>
<br>
</body>
</html>