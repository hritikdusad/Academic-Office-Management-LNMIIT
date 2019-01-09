<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<style>
*{
		text-align: center;
		font-family: Arial, Helvetica, sans-serif;
        background-color: #C0C0C0;
	}

.Data{
		border: 2px double #f1f1f1;
		width: 300px;
		padding: 8px;
		padding-bottom: 12px;
		display: inline-block;
		border-radius: 10px;
	}
	.Data label{
		;
	}
	.Data input{
		float: right;
		box-shadow: none;
		cursor: pointer;
		outline: none;
		border:0px;
	}
</style>
<body>
<%
String CourseCode = request.getParameter("CourseCode");
String Batch = request.getParameter("batch");
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "isdteam29";
String userId = "root";
String password = "hritik@123";

try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connection = null;
Statement statement = null,statement1=null,statement2=null;
ResultSet resultSet = null ,resultSet1 = null,resultSet2 = null;
%>
<h2 align="center" class=""><font><strong>Course Data</strong></font></h2>

<%
try{ 
connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
statement=connection.createStatement();
statement1=connection.createStatement();
statement2=connection.createStatement();
String sql ="SELECT * FROM course where CourseCode = '"+CourseCode+"'";
String sql1 = "select count(EnrollID) from performance_sheet where CourseCode = '"+CourseCode+"' and Batch = '"+Batch+"'";
String sql2 = "select performance_sheet.EnrollID, student.FirstName, student.LastName, performance_sheet.Grade from performance_sheet INNER JOIN student on performance_sheet.EnrollID = student.EnrollID where CourseCode = '"+CourseCode+"' and Batch = '"+Batch+"' ORDER BY performance_sheet.EnrollID";
resultSet = statement.executeQuery(sql);
resultSet1 = statement1.executeQuery(sql1);
resultSet2 = statement2.executeQuery(sql2);
%>

<div class="container Data">
		<form>
			<div class="container">
			<% 
				if(resultSet.next()){
			%>
				<label for="Cname"><b>Course Name:</b></label>
				<input type="text" name="Cname" value="<%=resultSet.getString("Name")%>" readonly align="right">
				<br>
				<label for="Code"><b>Course Code:</b></label>
				<input type="text" name="Code" value="<%=resultSet.getString("CourseCode")%>" readonly align="right">
				<br>
				<label for="Credit"><b>Credit :</b></label>
				<input type="text" name="Credit" value="<%=resultSet.getString("Credit")%>" readonly align="right">
				<br>
				<label for="Type"><b>Course Type:</b></label>
				<input type="text" name="Type" value="<%=resultSet.getString("Type")%>" readonly align="right">
				<br>
				<label for="Type"><b>Total Seat:</b></label>
				<input type="text" name="Total Student" value="<%=resultSet.getString("StudentLimit")%>" readonly align="right">
				
				<%
				}
				else{
					response.sendRedirect("Course.html");
				}
				%>
				<%
				if(resultSet1.next()){
				%>
				<label for="MaxS"><b>Seats Filled:</b></label>
				<input type="text" name="MaxS" value="<%out.println(resultSet1.getInt(1));%>" readonly align="right">
				<br>
			</div>	
		</form>
	</div>
	<%
				}
	%>



<br><br><br><br>
<table align="center" cellpadding="5" cellspacing="5" border="1">
<br><br><br><br>
<tr>

</tr>
<tr bgcolor="#A52A2A">
<td><b>Enrollment No.</b></td>
<td><b>First Name.</b></td>
<td><b>Last Name.</b></td>
<td><b>Grade</b></td>

</tr>
<% 
	while(resultSet2.next()){
%>
<tr bgcolor="#DEB887">

<td><%=resultSet2.getString("EnrollID") %></td>
<td><%=resultSet2.getString("FirstName") %></td>
<td><%=resultSet2.getString("LastName") %></td>
<td><%=resultSet2.getString("Grade") %></td>
</tr>

<% 
}
} catch (Exception e) {
e.printStackTrace();
}
%>
</table>
</body>