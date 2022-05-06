<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.time.LocalDateTime, java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
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
		
		float bid_amt = Float.valueOf(request.getParameter("bidAMT"));
		int curr_AuctionID = Integer.parseInt((String)session.getAttribute("currAuctionID")); 
		
		
		String insert_bid = "INSERT INTO autobid(upperLimit,creator,AuctionID) " + "VALUES (?, ?,?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement is = con.prepareStatement(insert_bid);
		is = con.prepareStatement(insert_bid);
		//out.print("here: " + (String)session.getAttribute("username"));
		is.setFloat(1,bid_amt);
		is.setString(2, (String)session.getAttribute("username"));
		is.setInt(3, curr_AuctionID);
		
		is.executeUpdate();
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		con.close();
		%>
		<jsp:forward page="bidDecisionLogic.jsp">
		
	    	<jsp:param name="auctionID" value="<%=curr_AuctionID%>"/>
		</jsp:forward>
		<% 
		
	} catch (Exception ex) {
		
		out.print(ex);
	}
%>




</body>
</html>