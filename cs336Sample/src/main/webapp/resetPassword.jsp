<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	Reset Password
	
	<br>
	<br>
	
	Enter New Password:
	
	<br>
	<br>
		<form method="post" action="resetPasswordLogic.jsp">
			<table>
				<tr>
					<td>Password:</td><td><input type="text" name="password"></td>
				</tr>
			</table>
			<input type="submit" value="Change Password">
		</form>
	<br>
	
	
	<form method="post" action="customerRepContact.jsp">
				
		<input type="submit" value="Back">   
	</form>

</body>
</html>