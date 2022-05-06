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
		
		
		int curr_AuctionID = Integer.parseInt((String)session.getAttribute("currAuctionID")); 
		
		String get_curr_price = "SELECT CurrentPrice from auction where AuctionID = " + Integer.toString(curr_AuctionID);
		
		ResultSet result = stmt.executeQuery(get_curr_price);
		result.next();
		float curr_price = result.getFloat(1);
		out.print(get_curr_price);
		
		
		String get_curr_increment = "SELECT increment from auction where AuctionID = " + Integer.toString(curr_AuctionID);
		result = stmt.executeQuery(get_curr_increment);
		result.next();
		float curr_increment = result.getFloat(1);
		out.print(get_curr_increment);
		
		
		String select_auto_bids_count = "SELECT count(*) from autobid where upperLimit >= " + Float.toString(curr_price + curr_increment);
		
		PreparedStatement ps = con.prepareStatement(select_auto_bids_count);
		result = stmt.executeQuery(select_auto_bids_count);
		result.next();
		int count = result.getInt(1);
		out.print(select_auto_bids_count);
		
		
		
		
		String select_auto_bids = "SELECT * from autobid where upperLimit >=" + Float.toString(curr_price + curr_increment);
		
		ps = con.prepareStatement(select_auto_bids);
		result = stmt.executeQuery(select_auto_bids);
		result.next();
		
		
		
		
		

		
		if(count ==1){
			String insert_bid = "INSERT INTO bid(user, AuctionID, price,time) " + "VALUES (?, ?,?,?)";
			PreparedStatement is = con.prepareStatement(insert_bid);
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			
			out.print(is.toString());
			//out.print("here: " + (String)session.getAttribute("username"));
			is.setString(1, (String)result.getString("creator"));                              
			is.setInt(2, curr_AuctionID);
			is.setFloat(3,curr_price + curr_increment);
			is.setDate(4, java.sql.Date.valueOf(java.time.LocalDate.now()));
			is.executeUpdate();
			
			String update_currentprice = "UPDATE auction SET CurrentPrice = " + Float.toString(curr_price + curr_increment) + ", highest_bidder = \""+ (String)result.getString("creator")  + "\" WHERE AuctionID =" + Integer.toString(curr_AuctionID) + ";";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			
			ps = con.prepareStatement(update_currentprice);

			
			
			ps.executeUpdate();
			
			
			
			
		}
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		
		//CHECK FOR AUTO BIDS HERE
		
		
		
		con.close();
		%>
		<jsp:forward page="viewAuction.jsp">
	    	<jsp:param name="auctionID" value="<%=curr_AuctionID%>"/>
		</jsp:forward>
		<% 
		
	} catch (Exception ex) {
		
		out.print(ex);
	}
%>
</body>
</html>