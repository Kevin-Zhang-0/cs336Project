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
			<option value="M">M</option>
			<option value="F">F</option>
		</select>
		Waist Width (inch) : <select name="waistWidth" size=1>
			<%
			for(int i = 20; i < 50; i++){
				%>
				<option value ="<%=i%>"><%=i%></option>
				<%
			}
			%>
		</select>
		Leg Length (inch) : <select name="legLength" size=1>
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