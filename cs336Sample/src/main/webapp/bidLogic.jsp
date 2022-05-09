<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.time.LocalDateTime, java.time.format.DateTimeFormatter,com.cs336.pkg.SendAlert"%>
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
		
		String get_curr_upperlimit = "SELECT * from autobid where AuctionID = " + Integer.toString(curr_AuctionID);
		ResultSet result = stmt.executeQuery(get_curr_upperlimit);
		if(result.next()){
			
			Float c_price = result.getFloat("upperLimit");
			if(bid_amt == c_price){
				SendAlert.send((String)session.getAttribute("currAuctionID"), " your bid of $" + Float.toString(bid_amt) + " has been beat by an earlier bid of the same amount",(String)session.getAttribute("username"));
				
				String insert_tied_bid = "INSERT INTO bid(user, AuctionID, price,time) " + "VALUES (?, ?,?,now())";
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement tb;
				tb = con.prepareStatement(insert_tied_bid);
				tb.setString(1, result.getString("creator"));
				tb.setInt(2, curr_AuctionID);
				tb.setFloat(3,c_price);
				tb.executeUpdate();
				
				
				String delete_auto_bids = "DELETE FROM autobid a WHERE a.AuctionID = " + curr_AuctionID + " AND a.creator =" + "\"" + result.getString("creator")+ "\"";
				
				
				
				tb = con.prepareStatement(delete_auto_bids);
				tb.executeUpdate();
				
				%>
				<jsp:forward page="viewAuction.jsp">
			    	<jsp:param name="auctionID" value="<%=curr_AuctionID%>"/>
				</jsp:forward>
				<% 
			}
			
		}
		
		
		
		
		String get_prev_winner = "SELECT CurrentPrice,highest_bidder from auction where AuctionID = " + Integer.toString(curr_AuctionID) + " and highest_bidder not in (select creator from autobid where AuctionID = " + Integer.toString(curr_AuctionID) + ")" ;		
		result = stmt.executeQuery(get_prev_winner);
		if(result.next()){
			String prev_winner = result.getString("highest_bidder");
			Float c_price = result.getFloat("CurrentPrice");
			SendAlert.send((String)session.getAttribute("currAuctionID"), " your bid of $" + Float.toString(c_price) + " has been beat by a bid of $" + Float.toString(bid_amt),prev_winner);
		}
			
			
		
		
		
		
		
		
		
		
		//Make an insert statement for the Sells table:
		String update_currentprice = "UPDATE auction SET CurrentPrice = " + Float.toString(bid_amt) + ", highest_bidder = \""+ (String)session.getAttribute("username")  + "\" WHERE AuctionID =" + Integer.toString(curr_AuctionID) + ";";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		
		PreparedStatement ps = con.prepareStatement(update_currentprice);

		
		
		ps.executeUpdate();
		
		PreparedStatement is = con.prepareStatement(update_currentprice);
		String insert_bid = "INSERT INTO bid(user, AuctionID, price,time) " + "VALUES (?, ?,?,now())";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		is = con.prepareStatement(insert_bid);
		
		is.setString(1, (String)session.getAttribute("username"));
		is.setInt(2, curr_AuctionID);
		is.setFloat(3,bid_amt);
	
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