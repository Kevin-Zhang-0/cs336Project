<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Rep Contact</title>
</head>
<body>
<% 
out.print("Please Select an Option That Matches Your Concerns");
%>
<br>
		<form method="get" action="loginPage.jsp">	
					
			<input type="submit" value="Logout">
		</form>
		
<br>
	
<div class="auction-btn-group">

	
	<table>
	<tr>
		<td>	
				<form method="get" action="resetPassword.jsp">	
					
					<input type="submit" value="Reset Your Password">
				</form> 
		</td>
		<td><form method="get" action="loginPage.jsp">	
					
			<input type="submit" value="Remove a Bid">
			</form> 
			</td>
	</tr>
	
	</table>
</div>
	
 	
	
 	
	
	
	
</body>
</html>	