<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		


		//Make an insert statement for the Sells table:
		
		String select = "SELECT * FROM credentials c WHERE c.user = \"" + username + "\"";
		//String select = "SELECT * FROM credentials";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		//PreparedStatement ps = con.prepareStatement(select);
		ResultSet result = stmt.executeQuery(select);
		if(password.length() == 0){
			out.print("Invalid password");

			%>
			
			<form method="post" action="resetPassword.jsp">
				
				<input type="submit" value="back">   
			</form>
			 
			    
			<%
			
		}
				
				
		else if(result.next()==true){
			out.print("Username is already taken");
			session.setAttribute("username", null);
			%>
			<form method="post" action="createAccount.jsp">
				
				<input type="submit" value="back">   
			</form>
			 
			    
			<%
		}
		
		else{
			
			
			String insert = "INSERT INTO credentials(user, pass)"
					+ "VALUES (?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, username);
			ps.setString(2, password);
			ps.executeUpdate();
			
			session.setAttribute("username", null);
			

			con.close();
			out.print("Account Creation Successful!");
			
			//response.sendRedirect("UserHomepage.jsp");
			
			%>
			<form method="post" action="loginPage.jsp">
				
				<input type="submit" value="Back">   
			</form>
			
			
			<% 
		
			
			
			
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			

			
			
		}
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("select failed :()");
	}
	%>

</body>
</html>