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
	
	
	public static void sendAlertToWinners() {
		try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String str = "select * from auction a where a.CloseDate <= cast(now() as date) and a.AuctionID not in (select b.AuctionID from auctionWinners b)";
			                        
			ResultSet result = stmt.executeQuery(str);
			while(result.next()) {
				String insert_alert = "INSERT INTO auctionWinners(AuctionID,user) " + "VALUES (?, ?)";
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement is = con.prepareStatement(insert_alert);
				//out.print("here: " + (String)session.getAttribute("username"));
				String winner = "no winner";
				
				if(result.getFloat("LowestSelliingPrice") < result.getFloat("CurrentPrice")) {
					winner = result.getString("highest_bidder");
				}
				
				is.setInt(1, result.getInt("AuctionID"));
				is.setString(2,winner);
				is.executeUpdate();
				
				if(!winner.equals("no winner")) {
					insert_alert = "INSERT INTO bidAlert(AuctionID,user,message,timestamp) " + "VALUES (?, ?,?,now())";
					//Create a Prepared SQL statement allowing you to introduce the parameters of the query
					is = con.prepareStatement(insert_alert);
					//out.print("here: " + (String)session.getAttribute("username"));
					is.setInt(1, result.getInt("AuctionID"));
					is.setString(2, winner);
					is.setString(3,"You have won the auction with auction ID: "+ result.getInt("AuctionID"));
					is.executeUpdate();
				}
				
				
			
			}
			
			
		}
		catch (Exception e) {
			System.out.println(e);
		}
		
	}
}
