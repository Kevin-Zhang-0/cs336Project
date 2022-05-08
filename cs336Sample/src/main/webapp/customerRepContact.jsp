<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Rep Contact</title>
</head>
<body> 

<% 
out.print("Current User: " + session.getAttribute("username"));
%>

<form method="get" action="UserHomepage.jsp">	
		
	<input type="submit" value="Back to Homepage">
</form>

<br><br>

<% 
out.print("Please Select an Option That Matches Your Concerns");
%>
<br>

	
<div class="auction-btn-group">

	
	<table>
	<tr>
		<td>	
				<form method="get" action="resetPassword.jsp">	
					
					<input type="submit" value="Reset Your Password">
				</form> 
		</td>
	</tr>
	
	</table>
</div>
	
<br>
<div>
	<table>
		<tr>
			<td>Ask a Question:</td>
		</tr>
			
	</table>

</div>
	

<table>
	<tr>
		
		<td><form method="get" action="requestSubmitted.jsp">	
<textarea name="custRequest" rows="10" cols="50" required>
</textarea>
			<input type="submit" value="Submit">
			</form> 
			</td>
	</tr>
	
	</table>		

	<br>
Customer Support Tickets:
	
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
			
			String currUser = session.getAttribute("username").toString();
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM customerRequests c WHERE c.user = \"" + currUser + "\"";
			
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


<form method="post" action="UserHomepage.jsp">

	<input type="submit" value="Back">   
</form>
	
	
</body>
</html>	