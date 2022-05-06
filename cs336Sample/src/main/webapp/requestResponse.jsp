<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Respond to a Request</title>
</head>
<body> 

	<%
	try {

		//Get the database connection
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the HelloWorld.jsp	
		String requestNumber = request.getParameter("requestID");
		session.setAttribute("currRequestNumber", requestNumber);
		
		//customer rep && end user
		
			//Make an insert statement for the Sells table:
			
			String select = "SELECT * FROM customerRequests c WHERE c.requestID = " + requestNumber;
			//String select = "SELECT * FROM credentials";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			//PreparedStatement ps = con.prepareStatement(select);
			ResultSet result = stmt.executeQuery(select);
			if(result.next()==false){
				out.print("Request number does not exist");
				%>
				<form method="post" action="customerRepHomepage.jsp">
					
					<input type="submit" value="Back">   
				</form>
				 
				    
				<%
			}
			
			else{
				%>
Please Enter Your Response Below:
<table>
	<tr>
		
			<td><form method="get" action="requestResponseLogic.jsp">	
<textarea name="requestResponse" rows="10" cols="50" required>
</textarea>
			<input type="submit" value="Respond">
			</form> 
			</td>
	</tr>
	
	</table>		
			
				<% 

				
				
				

			}
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			
		
	} catch (Exception ex) {
		//out.print(ex);
		out.print("select failed :()");
	}
	%>

</body>
</html>