<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.time.LocalDate,java.time.format.DateTimeFormatter,java.time.format.DateTimeParseException,java.time.format.ResolverStyle"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<% 
	
	try {
		
		Map<String, String> errors = new HashMap<String, String>();
		
		
		//Get parameters from the HTML form at the HelloWorld.jsp
		String new_shirt_name = request.getParameter("shirt_name");
		String new_shirt_sex = request.getParameter("shirt_sex");
		int new_shirt_size = Integer.parseInt(request.getParameter("shirt_size"));
		String new_shirt_initial_price = request.getParameter("shirt_initial_price");
		String new_shirt_lowest_selling_price = request.getParameter("shirt_lowest_selling_price");
		String new_shirt_bid_increments = request.getParameter("shirt_bid_increments");
		String new_shirt_closing_date = request.getParameter("shirt_closing_date");
	
		    // Repeat for all parameters.

		    if (errors.isEmpty()) {
		        // No errors, redirect to Amtrak.
		        //Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
		
				//Create a SQL statement
				Statement stmt = con.createStatement();
				
		        //Make an insert statement for the Sells table:
				String insert = "INSERT INTO clothing(name, sex, type) " + "VALUES (?, ?,?)";
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps = con.prepareStatement(insert);
				ps.setString(1, new_shirt_name);
				ps.setString(2, new_shirt_sex);
				ps.setString(3, "shoe");
				ps.executeUpdate();
				
				String getIDq = "SELECT last_insert_id()";
				ResultSet result = stmt.executeQuery(getIDq);
				result.next();
				int x = result.getInt(1);
				
				String insertShirt = "INSERT INTO shoe(itemID,size) " + "VALUES (?, ?)";
				PreparedStatement is = con.prepareStatement(insertShirt);
				is.setInt(1, x);
				is.setInt(2, new_shirt_size);
				is.executeUpdate();
				
				String creator = (String) session.getAttribute("username");
				String insertBid = "INSERT INTO auction(InitialPrice,CloseDate,LowestSelliingPrice,increment,CurrentPrice,itemID,user,highest_bidder) " + "VALUES (?, ?, ?, ?, ?, ?,?,?)";
				PreparedStatement bs = con.prepareStatement(insertBid);
				bs.setFloat(1,Float.parseFloat(new_shirt_initial_price) );
				bs.setString(2, new_shirt_closing_date);
				bs.setFloat(3, Float.parseFloat(new_shirt_lowest_selling_price));
				bs.setFloat(4, Float.parseFloat(new_shirt_bid_increments));
				bs.setFloat(5, Float.parseFloat(new_shirt_initial_price));
				bs.setInt(6, x);
				bs.setString(7, creator);
				bs.setString(8,null);
				bs.executeUpdate();
				
				String getIDq2 = "SELECT last_insert_id()";
				ResultSet result2 = stmt.executeQuery(getIDq2);
				result2.next();
				int y = result2.getInt(1);
				
				//flagging any alerts
				Statement stmt2 = con.createStatement();
				String getAlert = "select s.alertID as id, s.user from setalert s, setalert_shirt ss where s.alertID = ss.alertID and s.itemName = \"" + new_shirt_name + "\" and s.sex = \"" + new_shirt_sex + "\" and ss.size = \"" + new_shirt_size + "\"";
				ResultSet alertResult = stmt2.executeQuery(getAlert);
				if(alertResult.next()){
					String alertID = alertResult.getString("id");
					String user = alertResult.getString("user");

					String update = "update setalert set called = true, AuctionID = ? where alertID = ?";
					PreparedStatement ps2 = con.prepareStatement(update);
					ps2.setInt(1, y);
					ps2.setInt(2,Integer.parseInt(alertID));
					ps2.executeUpdate();
				}
				
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
			
	
				        
		        
		        
		        
		        response.sendRedirect("UserHomepage.jsp");
		    }
		
		
		

		
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Insert failed :()");
	}
%>
</body>
</html>

	
	
</body>
</html>