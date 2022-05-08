<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Deletion</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		Statement userStmt = con.createStatement();
		Statement auctionStmt = con.createStatement();
		Statement winnerStmt = con.createStatement();
		Statement bidStmt = con.createStatement();

		//Make an insert statement for the Sells table:
		
		String bidToDelete = request.getParameter("deleteBid").toString();
		
		String userQuery = "SELECT user FROM bid b WHERE b.bidID = " + bidToDelete;
		ResultSet userQueryResult = userStmt.executeQuery(userQuery);
		userQueryResult.next();
		String currUser = userQueryResult.getString("user");
		
		//gets AuctionID of the bid we are about to delete
		String currAuctionID = "SELECT AuctionID FROM bid b WHERE b.bidID = " + bidToDelete;
		ResultSet auctionResult = auctionStmt.executeQuery(currAuctionID);
		auctionResult.next();
		String auctionID1 = auctionResult.getString("AuctionID");
		
		/*String update = "INSERT INTO credentials(user, pass)"
				+ "VALUES (?, ?)";*/
		String delete = "DELETE FROM bid\n"
			+ "WHERE bidID = ?";
		PreparedStatement ps = con.prepareStatement(delete);
		ps.setString(1, bidToDelete);
		ps.executeUpdate();
		
		//if bid was highest bid, then we get most recent bid and set highet price in auction to it
		String getHighestUser = "SELECT highest_bidder FROM auction a WHERE a.auctionID = " + auctionID1;
		ResultSet highUserResult = winnerStmt.executeQuery(getHighestUser);
		highUserResult.next();
		String currWinnerUser = highUserResult.getString("highest_bidder");
		
		out.println("currUser: " + currUser);
		out.println("auctionID1: " + auctionID1);
		out.println("currWinnerUser: " + currWinnerUser);
		
		if(currWinnerUser.equals(currUser)){
			out.println("we deleted the highest bid");
			String auctionBids = "SELECT * FROM bid b, auction a WHERE a.AuctionID = b.AuctionID AND a.AuctionID = " + auctionID1 + " ORDER BY b.price DESC";
			ResultSet bids = bidStmt.executeQuery(auctionBids);
			if(bids.next()){//if auction has more bids 
				out.println("auction has more bids");
				String newHighestPrice = bids.getString("price");
				String newHighestBidder = bids.getString("user"); 
				
				String auctionUpdate = "UPDATE auction\n"
						+ "SET CurrentPrice = ?, highest_bidder = ?\n"
						+ "WHERE AuctionID = ?";
				PreparedStatement ps2 = con.prepareStatement(auctionUpdate);
				ps2.setString(1, newHighestPrice);
				ps2.setString(2, newHighestBidder);
				ps2.setString(3, auctionID1);
				ps2.executeUpdate();
			}
		}
		//else do nothing

		con.close();
		out.print("Bid Deletion Successful!");
		
		//response.sendRedirect("UserHomepage.jsp");
		%>
		<form method="post" action="userBidRemove.jsp">
			
			<input type="submit" value="Back">   
		</form>
		
		
		<% 
	
		
		
		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		

		
		
	
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("something went wrong in bid remove");
	}
	%>

</body>
</html>