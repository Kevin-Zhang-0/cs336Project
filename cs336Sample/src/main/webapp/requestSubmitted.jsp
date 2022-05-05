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
		String newRequest = request.getParameter("custRequest");
		String user = session.getAttribute("username").toString();
		

		String insert = "INSERT INTO customerRequests(user, request, status)"
				+ "VALUES (?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setString(1, user);
		ps.setString(2, newRequest);
		ps.setBoolean(3, true);
		ps.executeUpdate();
		
		
		con.close();
		out.print("Request Submitted Succesfully!");
		
		%>
		<form method="post" action="customerRepContact.jsp">
			
			<input type="submit" value="Back">   
		</form>
		
		
		<% 
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("select failed :()");
	}
	%>

</body>
</html>