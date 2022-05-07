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

		
		
		String get_curr_increment = "SELECT increment from auction where AuctionID = " + Integer.toString(curr_AuctionID);
		result = stmt.executeQuery(get_curr_increment);
		result.next();
		float curr_increment = result.getFloat(1);

		
		
		String select_auto_bids_count = "SELECT count(*) from autobid where upperLimit >= " + Float.toString(curr_price + curr_increment) + " and AuctionID = " + Integer.toString(curr_AuctionID);
		
		PreparedStatement ps = con.prepareStatement(select_auto_bids_count);
		result = stmt.executeQuery(select_auto_bids_count);
		result.next();
		int count = result.getInt(1);
		
		
		
		
		String select_auto_bids = "SELECT * from autobid where upperLimit >=" + Float.toString(curr_price + curr_increment)+ " and AuctionID = " + Integer.toString(curr_AuctionID);
		
		ps = con.prepareStatement(select_auto_bids);
		result = stmt.executeQuery(select_auto_bids);
		result.next();
		
		
		
		
		if(count == 1){ // When theres one auto bid
			String insert_bid = "INSERT INTO bid(user, AuctionID, price,time) " + "VALUES (?, ?,?,now())";
			PreparedStatement is = con.prepareStatement(insert_bid);
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			
			//out.print(is.toString());
			//out.print("here: " + (String)session.getAttribute("username"));
			is.setString(1, (String)result.getString("creator"));                              
			is.setInt(2, curr_AuctionID);
			is.setFloat(3,curr_price + curr_increment);
			//is.setDate(4, java.sql.Date.valueOf(java.time.LocalDate.now()));
			is.executeUpdate();
			
			String update_currentprice = "UPDATE auction SET CurrentPrice = " + Float.toString(curr_price + curr_increment) + ", highest_bidder = \""+ (String)result.getString("creator")  + "\" WHERE AuctionID =" + Integer.toString(curr_AuctionID) + ";";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			
			ps = con.prepareStatement(update_currentprice);

			
			
			ps.executeUpdate();
			
			
			
			
		}
		if(count == 2){
			HashMap<String, String> u1 = new HashMap<String, String>();
			u1.put("creator", result.getString("creator"));
			u1.put("upperLimit", result.getString("upperLimit"));
			u1.put("AuctionID", result.getString("AuctionID"));
			result.next();
			
			HashMap<String, String> u2 = new HashMap<String, String>();
			u2.put("creator", result.getString("creator"));
			u2.put("upperLimit", result.getString("upperLimit"));
			u2.put("AuctionID", result.getString("AuctionID"));
			
			String winner_creator = "";
			String winner_upperLimit = "";
			
			String loser_creator = "";
			String loser_upperLimit = "";
			if(Float.parseFloat(u1.get("upperLimit")) > Float.parseFloat(u2.get("upperLimit"))){
				winner_creator = u1.get("creator");
				winner_upperLimit = u1.get("upperLimit");
				
				loser_creator = u2.get("creator");
				loser_upperLimit = u2.get("upperLimit");
				
			}
			else{
				winner_creator = u2.get("creator");
				winner_upperLimit = u2.get("upperLimit");
				
				loser_creator = u1.get("creator");
				loser_upperLimit = u1.get("upperLimit");
			}
			String update_currentprice = "UPDATE auction SET CurrentPrice = " + Double.toString(Float.parseFloat(loser_upperLimit) + curr_increment) + ", highest_bidder = \""+ winner_creator  + "\" WHERE AuctionID =" + Integer.toString(curr_AuctionID) + ";";
			ps = con.prepareStatement(update_currentprice);
			ps.executeUpdate();
			
			String insert_bid = "INSERT INTO bid(user, AuctionID, price,time) " + "VALUES (?, ?,?,now())";
			//losing bid
			PreparedStatement is = con.prepareStatement(insert_bid);
			
			is.setString(1, loser_creator);
			is.setInt(2, curr_AuctionID);
			is.setFloat(3,Float.parseFloat(loser_upperLimit));
			//is.setDate(4, java.sql.Date.valueOf(java.time.LocalDate.now()));
			is.executeUpdate();
			
			//winning bid
			is = con.prepareStatement(insert_bid);
			
			is.setString(1, winner_creator);
			is.setInt(2, curr_AuctionID);
			is.setFloat(3,(float)(Float.parseFloat(loser_upperLimit) + curr_increment));
			//is.setDate(4, java.sql.Date.valueOf(java.time.LocalDate.now()));
			is.executeUpdate();
			
			
			
		}
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		
		//CHECK FOR AUTO BIDS HERE
		
		
		// DELETE AUTO BIDS THAT ARE LOWER THAN CURRENT PRICE + INCREMENT
		
		
		String newCurrentPrice = "SELECT CurrentPrice from auction where AuctionID = " + Integer.toString(curr_AuctionID);
		
		result = stmt.executeQuery(newCurrentPrice);
		result.next();
		float new_price = result.getFloat(1);
		//out.print(newCurrentPrice);
		
		String delete_auto_bids = "DELETE FROM autobid a WHERE a.AuctionID = " + curr_AuctionID + " AND a.upperLimit <" + Float.toString(new_price + curr_increment);
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			
		ps = con.prepareStatement(delete_auto_bids);
		ps.executeUpdate();
		
		
		
		
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