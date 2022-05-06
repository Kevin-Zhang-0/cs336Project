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
		
		
		

		//Make an insert statement for the Sells table:
		String update_currentprice = "UPDATE auction SET CurrentPrice = " + Float.toString(bid_amt) + ", highest_bidder = \""+ (String)session.getAttribute("username")  + "\" WHERE AuctionID =" + Integer.toString(curr_AuctionID) + ";";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		
		PreparedStatement ps = con.prepareStatement(update_currentprice);

		
		
		ps.executeUpdate();
		
		PreparedStatement is = con.prepareStatement(update_currentprice);
		String insert_bid = "INSERT INTO bid(user, AuctionID, price,time) " + "VALUES (?, ?,?,now())";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		is = con.prepareStatement(insert_bid);
		//out.print("here: " + (String)session.getAttribute("username"));
		is.setString(1, (String)session.getAttribute("username"));
		is.setInt(2, curr_AuctionID);
		is.setFloat(3,bid_amt);
		//is.setDate(4, java.sql.Date.valueOf(java.time.LocalDate.now()));
		is.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		
		//CHECK FOR AUTO BIDS HERE
		
		
		
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