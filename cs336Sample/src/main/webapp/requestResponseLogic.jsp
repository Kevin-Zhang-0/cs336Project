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
		String requestResponse = request.getParameter("requestResponse");
		//String user = session.getAttribute("username").toString();
		String requestNumber = session.getAttribute("currRequestNumber").toString();

		String update = "UPDATE customerRequests\n"
				+ "SET reply = ?, status = ?\n"
				+ "WHERE requestID = ?";
			PreparedStatement ps = con.prepareStatement(update);
			ps.setString(1, requestResponse);
			ps.setString(2, "Closed");
			ps.setString(3, requestNumber);
			ps.executeUpdate();
		
		
		con.close();
		out.print("Response Submitted Succesfully!");
		
		%>
		<form method="post" action="customerRepHomepage.jsp">
			
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