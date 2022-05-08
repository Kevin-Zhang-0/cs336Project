<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Shirt Alarm</title>
</head>
<body>
<br>
	<form method="post" action="alarm_shirt_logic.jsp">
		Shirt Name : <input type = "text" name = 'name' required>
		
		Sex : <select name="sex" size=1>
			<option value="M">M</option>
			<option value="F">F</option>
		</select>
		Size : <select name="size" size=1>
			<option value="small">Small</option>
			<option value="medium">Medium</option>
			<option value="large">Large</option>
		</select>
		<br>
		<input type="submit" value="Create Alarm">
	</form>
<br>
<br>
</body>
</html>