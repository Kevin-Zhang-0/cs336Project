<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bid Deletion</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Make an insert statement for the Sells table:
		
		String keyword = request.getParameter("keyword").toString();
		
		String userQuery = "SELECT * FROM customerRequests cr WHERE LOCATE('" + keyword + "', cr.request) > 0";
		ResultSet result = stmt.executeQuery(userQuery);
		%>
		
		<table>
			<tr>
				<td>requestID</td>
				<td>user</td>
				<td>request</td>
				<td>reply</td>
				<td>status</td>
			</tr>


	<%  while (result.next()) { %>
			<tr>
				<td> <%= result.getString("requestID")%></td>
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
		%>
		<form method="post" action="customerRepContact.jsp">
			
			<input type="submit" value="Back">   
		</form>
		
		
		<% 
	
		
	
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("something went wrong in keyword search");
	}
	%>

</body>
</html>