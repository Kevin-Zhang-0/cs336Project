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
		Statement cusRepStmt = con.createStatement();
		//Get parameters from the HTML form at the HelloWorld.jsp
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		//if the user is admin
		if (username.equals("admin") && password.equals("adminpass")){
			
			con.close();
			response.sendRedirect("AdminHomepage.jsp");
		}
		
		//customer rep && end user
		else{
			//Make an insert statement for the Sells table:
			
			String selectCR = "SELECT * FROM customerRep cr WHERE cr.user = \"" + username +"\"";
			ResultSet resultCR = stmt.executeQuery(selectCR);

			if(resultCR.next()==false){
				String select = "SELECT * FROM credentials c WHERE c.user = \"" + username + "\" AND c.pass = \"" + password+ "\"";
				ResultSet result = stmt.executeQuery(select);
				if(result.next()==false){
					out.print("Username/password combination does not exist");
					session.setAttribute("username", null);
					%>
					<form method="post" action="loginPage.jsp">
						
						<input type="submit" value="back">   
					</form>
					 
					    
					<%
				}
				else{
					//out.println(result.getString("user"));
					//out.println(result.getString("pass"));
					session.setAttribute("username", result.getString("user"));
					
					
					con.close();
					response.sendRedirect("UserHomepage.jsp");
				}
			}
			
			else{
				String select1 = "SELECT * FROM credentials c WHERE c.user = \"" + username + "\" AND c.pass = \"" + password+ "\"";
				ResultSet result = cusRepStmt.executeQuery(select1);
				if(result.next()==false){
					out.print("Username/password combination does not exist");
					session.setAttribute("username", null);
					%>
					<form method="post" action="loginPage.jsp">
						
						<input type="submit" value="back">   
					</form>
					 
					    
					<%
				}
				else{
					session.setAttribute("username", resultCR.getString("user"));
					
					
					con.close();
					response.sendRedirect("customerRepHomepage.jsp");
				}
			
			
				
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				
	
				
				
			}
		}
		
	} catch (Exception ex) {
		//out.print(ex);
		//out.print("select failed :()");
	}
	%>

</body>
</html>