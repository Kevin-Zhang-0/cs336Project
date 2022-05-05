<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	try {
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the HelloWorld.jsp
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		String select = "SELECT * FROM credentials c WHERE c.user = \"" + username + "\"";
		ResultSet result = stmt.executeQuery(select);
		
		
		//Username exists
		if(result.next() == true){
			out.print("Username is already taken");
			session.setAttribute("username", null);
			
			
			%>
			<form method="post" action="AdminHomepage.jsp">
				
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
			
			
			String insert2 = "INSERT INTO customerRep VALUES (?)";
			PreparedStatement ps2 = con.prepareStatement(insert2);
			ps2.setString(1, username);
			ps2.executeUpdate();
			
			session.setAttribute("username", null);
			

			con.close();
			out.print("Account Creation Successful!");
			
			%>
			<form method="post" action="AdminHomepage.jsp">
				
				<input type="submit" value="Back">   
			</form>
			
			
			<% 
			
		}
			
		
		
	} catch (Exception ex){
		out.print(ex);
		out.print("select filed :0");
		
	}
	
	
	%>
</body>
</html>