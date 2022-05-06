<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Deletion</title>
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
		
		String userToDelete = request.getParameter("deleteUser").toString();
		
		
		
		/*String update = "INSERT INTO credentials(user, pass)"
				+ "VALUES (?, ?)";*/
		String delete = "DELETE FROM endUser\n"
			+ "WHERE user = ?";
		PreparedStatement ps = con.prepareStatement(delete);
		ps.setString(1, userToDelete);
		ps.executeUpdate();
		
		String delete1 = "DELETE FROM credentials\n"
			+ "WHERE user = ?";
		PreparedStatement ps1 = con.prepareStatement(delete1);
		ps1.setString(1, userToDelete);
		ps1.executeUpdate();
			
		con.close();
		out.print("User Deletion Successful!");
		
		//response.sendRedirect("UserHomepage.jsp");
		%>
		<form method="post" action="userDelete.jsp">
			
			<input type="submit" value="Back">   
		</form>
		
		
		<% 
	
		
		
		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		

		
		
	
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("something went wrong in password change");
	}
	%>

</body>
</html>