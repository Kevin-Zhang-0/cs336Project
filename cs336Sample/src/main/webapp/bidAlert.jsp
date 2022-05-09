<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<% 
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();	

//Create a SQL statement
Statement stmt = con.createStatement();
int curr_AuctionID = Integer.parseInt((String)request.getParameter("auctionID"));
String message = (String)request.getParameter("message");
String to_user = (String)request.getParameter("to_user");

String insert_alert = "INSERT INTO setAlert(upperLimit,creator,AuctionID) " + "VALUES (?, ?,?,now())";
PreparedStatement is = con.prepareStatement(insert_alert);

is.setInt(1, curr_AuctionID);
is.setString(2, to_user);
is.setString(3,message);
is.executeUpdate();


%>










</body>
</html>