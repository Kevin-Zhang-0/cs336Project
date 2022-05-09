<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>drop alert</title>
</head>
<body>
<%
	try {
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String curr_user = (String)session.getAttribute("username");
		String selectAlerts = "select s.alertID from setalert s where s.user = \"" +curr_user + "\" and s.called = true";
		ResultSet result = stmt.executeQuery(selectAlerts);
		
		//stmt.executeUpdate("delete from setalert where s.user = \"" +curr_user + "\" and s.called = true"
		
		while(result.next()){
			String alertID = result.getString("alertID");
			
			Statement st1 = con.createStatement();
			int i = st1.executeUpdate("delete from setalert_shirt where alertID = " + alertID);
			
			Statement st2 = con.createStatement();
			int j = st2.executeUpdate("delete from setalert_pants where alertID = " + alertID);
			
			Statement st3 = con.createStatement();
			int g = st3.executeUpdate("delete from setalert_shoes where alertID = " + alertID);
		}
		
		Statement stmt2 = con.createStatement();
		int f = stmt.executeUpdate("delete from setalert s where s.user = \"" +curr_user + "\" and s.called = true");
		
		response.sendRedirect("UserHomepage.jsp");

	}catch(Exception e){
		out.print(e);
	}
%>
</body>
</html>