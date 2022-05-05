<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Account</title>
</head>
<body>

	Create Account
	
	<br>
	<br>
	
	Enter Username and Password:
	
	<br>
	<br>
		<form method="post" action="createAccountLogic.jsp">
			<table>
				<tr>    
					<td>Username:</td><td><input type="text" name="username"></td>
				</tr>
				<tr>
					<td>Password:</td><td><input type="text" name="password"></td>
				</tr>
			</table>
			<input type="submit" value="Create">
		</form>
	<br>
	
	
	<form method="post" action="loginPage.jsp">
				
		<input type="submit" value="Back">   
	</form>

</body>
</html>