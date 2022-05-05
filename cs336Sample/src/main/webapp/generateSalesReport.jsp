<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<% 
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
	
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String select = "SELECT sum(CurrentPrice) as totalEarning from auction";
		ResultSet result = stmt.executeQuery(select);
		
		%>
		<br>
		Total Earning: 
		<br>
		<br>
		
		
		<% 
		
		
		//total earning
		if(result.next()){ 
		%>
		<table>
			<tr>
				<td> <%= "$ " + result.getString("totalEarning") %></td>
			<tr>
		</table>
		<%
		}
		
		else{
			%>
			<table>
				<tr>
					</td><td> <%= "$ 0" %></td>
				<tr>
			</table>
			<%
		}
		%>
		<br>
		Earning Per Item: 
		<br>
		<br>
		
		
		<% 
		
		//earnings per item
		stmt = con.createStatement();
		select = "select itemID, CurrentPrice from auction";
		result = stmt.executeQuery(select);
		%>
		
		<table>
			<tr>
				<th>Item ID </th>
				<th>Earning </th>
			</tr>


		<%
		if(result.next()){ %>
			<tr>
				<td> <%= result.getString("itemID") %></td>
				<td> <%= result.getString("CurrentPrice")%></td>
			</tr> <%

		} %>
		</table>
		
		<%
		%>
		<br>
		Earning Per Pants: 
		<br>
		<br>
		
		
		<% 

		//pants total earning
		select = "select sum(CurrentPrice) as cp from auction a, pants p where a.itemID = p.itemID";
		result = stmt.executeQuery(select);
		
		if(result.next() == true){ 
			String temp = result.getString("cp");
			if(temp == null){
				%>
				<table>
					<tr>
						<td> <%= "$ 0" %></td>
					<tr>
				</table>
				<%
			}
			else{
				%>
				<table>
					<tr>
						<td> <%= "$ " + result.getString("cp") %></td>
					<tr>
				</table>
				<%
			}
		}
		
		else{
			%>
			<table>
				<tr>
					<td> <%= "$ 0" %></td>
				<tr>
			</table>
			<%
		}
		%>
		<br>
		Earning Per Shirt: 
		<br>
		<br>
		
		
		<% 
		
		
		
		//shirt total earning
		select = "select sum(CurrentPrice) as cp from auction a, shirt s where a.itemID = s.itemID";
		result = stmt.executeQuery(select);
		
		if(result.next() == true){ 
			String temp = result.getString("cp");
			if(temp == null){
				%>
				<table>
					<tr>
						<td> <%= "$ 0" %></td>
					<tr>
				</table>
				<%
			}
			else{
				%>
				<table>
					<tr>
						<td> <%= "$ " + result.getString("cp") %></td>
					<tr>
				</table>
				<%
			}
		}
		
		else{
			%>
			<table>
				<tr>
					<td> <%= "$ 0" %></td>
				<tr>
			</table>
			<%
		}
		
		%>
		<br>
		Earning Per Shoes:
		<br>
		<br>
		
		
		<% 
		
		
		//shoes total earning
		select = "select sum(CurrentPrice) as cp from auction a, shoe so where a.itemID = so.itemID";
		result = stmt.executeQuery(select);
		
		if(result.next()){ 
			String temp = result.getString("cp");
			if(temp == null){
				%>
				<table>
					<tr>
						<td> <%= "$ 0" %></td>
					<tr>
				</table>
				<%
			}
			else{
				%>
				<table>
					<tr>
						<td> <%= "$ " + result.getString("cp") %></td>
					<tr>
				</table>
				<%
			}
		}
		
		else{
			%>
			<table>
				<tr>
					<td> <%= "$ 0" %></td>
				<tr>
			</table>
			<%
		}
		
		%>
		<br>
		Earning per End user: 
		<br>
		<br>
		
		
		<% 
		
		//earnings per item
		stmt = con.createStatement();
		select = "select itemID, CurrentPrice from auction";
		result = stmt.executeQuery(select);
		%>
		
		<table>
			<tr>
				<th>Item ID </th>
				<th>Earning </th>
			</tr>


		<%
		if(result.next()){ %>
			<tr>
				<td> <%= result.getString("itemID") %></td>
				<td> <%= result.getString("CurrentPrice")%></td>
			</tr> <%

		} %>
		</table>
		
		<%
		

		con.close();
		
		

	} catch (Exception e){
		out.print("error2");
	}
		
		
	%>
</body>
</html>