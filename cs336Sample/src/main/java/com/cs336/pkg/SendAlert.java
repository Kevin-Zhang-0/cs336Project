package com.cs336.pkg;

import java.io.*;
import java.util.*;
import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.*;

public class SendAlert {
	public static void send(String auctionID, String message, String to_user) {
		try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	

			//Create a SQL statement
			Statement stmt = con.createStatement();
			int curr_AuctionID = Integer.parseInt(auctionID);
		

			String insert_alert = "INSERT INTO bidAlert(AuctionID,user,message,timestamp) " + "VALUES (?, ?,?,now())";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement is = con.prepareStatement(insert_alert);
			//out.print("here: " + (String)session.getAttribute("username"));
			is.setInt(1, curr_AuctionID);
			is.setString(2, to_user);
			is.setString(3,message);
			is.executeUpdate();
		}
		catch (Exception e) {
			System.out.println(e);
		}
		
	}
}
