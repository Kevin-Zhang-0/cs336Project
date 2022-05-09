<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Auction Deletion</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		String auctionToDelete = request.getParameter("deleteAuction").toString();

		String delete = "DELETE FROM auction a\n"
			+ "WHERE a.AuctionID = ?";
		PreparedStatement ps = con.prepareStatement(delete);
		ps.setString(1, auctionToDelete);
		ps.executeUpdate();

		con.close();
		out.print("Auction Deletion Successful!");
		
		%>
		<form method="post" action="userAuctionRemove.jsp">
			
			<input type="submit" value="Back">   
		</form>
		
		
		<% 
	
	} catch (Exception ex) {
		out.print(ex);
		out.print("something went wrong in auction remove");
	}
	%>

</body>
</html>