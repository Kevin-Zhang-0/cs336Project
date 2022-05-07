<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>User Login</title>
	</head>
	
	<body>
	<%session.setAttribute("username",null); %>	
		  
	
	Please enter login credentials:
	<br>
		<form method="post" action="loginLogic.jsp">
			<table>
				<tr>    
					<td>Username:</td><td><input type="text" name="username"></td>
				</tr>
				<tr>
					<td>Password:</td><td><input type="text" name="password"></td>
				</tr>
			</table>
			<input type="submit" value="Login">
		</form>
	<br>
	
	
	Don't have an account? Click here to create one!
	
	<br>
	
	<form method="get" action="createAccount.jsp">	
					
		<input type="submit" value="Create Account">
		
	</form>
	
	
	
	

</body>
</html>