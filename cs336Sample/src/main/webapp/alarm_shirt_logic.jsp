<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	String alertID = "";
	
	try{

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the HelloWorld.jsp
		
		String user = (String)session.getAttribute("username");
		String name = request.getParameter("name");
		String sex = request.getParameter("sex");
		String size = request.getParameter("size");
		
		
		String insert = "insert into setAlert(user, itemName, sex) values (?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setString(1, user);
		ps.setString(2, name);
		ps.setString(3, sex);
		ps.executeUpdate();
		
		
		String select = "select alertID from setAlert s where s.user = \"" + user + "\" and s.itemName = \"" + name + "\" and s.sex = \"" + sex + "\" and s.sex = \"" + size + "\"" ;
		ResultSet result = stmt.executeQuery(select);
		alertID = result.getString("alertID");
		
		
		String insert2 = "insert into setAlert_shirt values (?, ?)";
		PreparedStatement ps2 = con.prepareStatement(insert2);
		ps2.setInt(1, Integer.parseInt(alertID));
		ps2.setInt(2, Integer.parseInt(size));
		ps2.execute();
		
		
		
		con.close();
		
		
	} catch (Exception ex) {
		out.print(ex);
		out.print(Integer.parseInt(alertID));
		out.print("select failed :c");
	}
	
	
	%>
</body>
</html>