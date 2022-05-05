<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%--may add current customer rep list--%>
	
	Create Customer Representative Account
	
	<br>
	<br>
	
		<form method="post" action="createCusRepLogic.jsp">
			<table>
				<tr>    
					<td>Customer Rep ID:</td><td><input type="text" name="username" required></td>
				</tr>
				<tr>
					<td>Password:</td><td><input type="text" name="password" required></td>
				</tr>
			</table>
			<input type="submit" value="Create">
		</form>
	
	<br>
	
	Generate Sales Report
	
	<br>
	<br>
		<form method = "get" action = "generateSalesReport.jsp">
			<input type="submit" value="Generate Report">
		</form>
	<br>

</body>
</html>