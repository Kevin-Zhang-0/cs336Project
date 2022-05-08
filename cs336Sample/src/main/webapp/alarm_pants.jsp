<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Pants Alarm</title>
</head>
<body>
<br>
	<form method="post" action="alarm_pants_logic.jsp">
		Pants Name : <input type = "text" name = 'name' required>
		
		Sex : <select name="sex" size=1>
			<option value="male">M</option>
			<option value="female">F</option>
		</select>
		Size : <select name="size" size=1>
			<%
			for(int i = 20; i < 50; i++){
				%>
				<option value ="<%=i%>"><%=i%></option>
				<%
			}
			%>
		</select>
		<br>
		<input type="submit" value="Create Alarm">
	</form>
<br>
<br>
</body>
</html>