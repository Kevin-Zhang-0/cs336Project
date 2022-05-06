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
<br>
		<form method="get" action="loginPage.jsp">	
					
			<input type="submit" value="Logout">
		</form>
		
<br>
<br>
	<% 
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
	
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String select = "SELECT sum(CurrentPrice) as totalEarning from auction where CloseDate <= cast(now() as date)";
		ResultSet result = stmt.executeQuery(select);
		
		//total earning
		if(result.next()){ 
			String temp = result.getString("totalEarning");
			if (temp != null){
				%>
				<table>
					<tr>
						<td>Total Earning: </td><td> <%= "$ " + temp %></td>
					<tr>
				</table>
				<%
			}
			
			else{
				%>
				<table>
					<tr>
						<td>Total Earning: </td><td> <%= "$ 0" %></td>
					<tr>
				</table>
				<%
			}
		}
		else{
			%>
			<table>
				<tr>
					<td>Total Earning: </td><td> <%= "$ 0" %></td>
				<tr>
			</table>
			<%
		}
		
		//pants total earning
		select = "select sum(CurrentPrice) as cp from auction a, pants p where a.itemID = p.itemID and a.CloseDate <= cast(now() as date)";
		result = stmt.executeQuery(select);
		if(result.next() == true){ 
			String temp = result.getString("cp");
			if(temp == null){
				%>
				<table>
					<tr>
						<td>Earning for Pants: </td><td> <%= "$ 0" %></td>
					<tr>
				</table>
				<%
			}
			else{
				%>
				<table>
					<tr>
						<td>Earning for Pants: </td><td> <%= "$ " + result.getString("cp") %></td>
					<tr>
				</table>
				<%
			}
		}
		else{
			%>
			<table>
				<tr>
					<td>Earning for Pants: </td><td> <%= "$ 0" %></td>
				<tr>
			</table>
			<%
		}
		

		//shirt total earning
		select = "select sum(CurrentPrice) as cp from auction a, shirt s where a.itemID = s.itemID and a.CloseDate <= cast(now() as date)";
		result = stmt.executeQuery(select);
		if(result.next() == true){ 
			String temp = result.getString("cp");
			if(temp == null){
				%>
				<table>
					<tr>
						<td>Earning for Shirt: </td><td> <%= "$ 0" %></td>
					<tr>
				</table>
				<%
			}
			else{
				%>
				<table>
					<tr>
						<td>Earning for Shirt: </td><td> <%= "$ " + result.getString("cp") %></td>
					<tr>
				</table>
				<%
			}
		}
		else{
			%>
			<table>
				<tr>
					<td>Earning for Shirt: </td><td> <%= "$ 0" %></td>
				<tr>
			</table>
			<%
		}

		
		
		//shoes total earning
		select = "select sum(CurrentPrice) as cp from auction a, shoe so where a.itemID = so.itemID and a.CloseDate <= cast(now() as date)";
		result = stmt.executeQuery(select);
		if(result.next()){ 
			String temp = result.getString("cp");
			if(temp == null){
				%>
				<table>
					<tr>
						<td>Earning for Shoes: </td><td> <%= "$ 0" %></td>
					<tr>
				</table>
				<%
			}
			else{
				%>
				<table>
					<tr>
						<td>Earning for Shoes: </td><td> <%= "$ " + result.getString("cp") %></td>
					<tr>
				</table>
				<%
			}
		}
		else{
			%>
			<table>
				<tr>
					<td>Earning for Shoes: </td><td> <%= "$ 0" %></td>
				<tr>
			</table>
			<%
		}
		
		
		%>
		<br>
		Earning Per Item: 
		<% 
		//earnings per item
		select = "select itemID, CurrentPrice from auction where CloseDate <= cast(now() as date)";
		result = stmt.executeQuery(select);
		%>
		<table border = "1">
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
		<br>
		<br>
		<% 
		
		
		%>
		<br>
		Earning Per End User: 
		<% 
		//earnings per item
		select = "select a.user, sum(CurrentPrice) as cp from auction a where a.CloseDate <= cast(now() as date) group by a.user";
		result = stmt.executeQuery(select);
		%>
		<table border = "1">
			<tr>
				<th>Username </th>
				<th>Total Earning </th>	
			</tr>
		<%
		if(result.next()){ %>
			<tr>
				<td> <%= result.getString("user") %></td>
				<td> <%= result.getString("cp")%></td>
			</tr> <%

		} %>
		</table>
		<br>
		<br>
		<%
		
		
		//Best-selling item
		%>
		<br>
		Best-selling item 
		<% 
		//earnings per item
		select = "select c.name, count(*) as c from auction a, clothing c where a.itemID = c.itemID and a.CloseDate <= cast(now() as date) group by c.name order by count(*) desc limit 5";
		result = stmt.executeQuery(select);
		%>
		<table border = "1">
			<tr>
				<th>Item Name </th>
				<th>Number of sells </th>	
			</tr>
		<%
		if(result.next()){ %>
			<tr>
				<td> <%= result.getString("name") %></td>
				<td> <%= result.getString("c")%></td>
			</tr> <%

		} %>
		</table>
		<br>
		<br>
		<%
		
		
		//Best buyer (top 5 people who bought most item)
		%>
		<br>
		Best-selling item 
		<% 
		//earnings per item
		select = "select a.highest_bidder, count(*) as c from auction a where a.CloseDate <= cast(now() as date) group by a.highest_bidder order by count(*) desc limit 5";
		result = stmt.executeQuery(select);
		%>
		<table border = "1">
			<tr>
				<th>Buyer Name </th>
				<th>Number of Purchase </th>	
			</tr>
		<%
		if(result.next()){ %>
			<tr>
				<td> <%= result.getString("highest_bidder") %></td>
				<td> <%= result.getString("c")%></td>
			</tr> <%

		} %>
		</table>
		<br>
		<br>
		<%
		
		

		con.close();
		
		

	} catch (Exception e){
		out.print("error2");
	}
		
		
	%>
</body>
</html>