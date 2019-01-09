<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>


<Style>
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
		float: left;
	}
	.Data input{
		float: right;
		box-shadow: none;
		cursor: pointer;
		outline: none;
		border:0px;
	}
</Style>


<%
String EnrollID = request.getParameter("ErollID");
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
Statement statement = null,statement1=null,statement2 = null;
ResultSet resultSet = null,resultSet1=null, resultSet2 = null;
%>
<body>
<h2 align="center"><font><strong>Data</strong></font></h2>


<%
try{
int i = 1,j=1,Semester=0;
connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
statement=connection.createStatement();
statement1 = connection.createStatement();
String sql = "select * from student where EnrollID = '"+EnrollID+"'";
resultSet = statement1.executeQuery(sql);
if(resultSet.next()){
Semester = resultSet.getInt("prSemester");
}
String sql1 ="SELECT course.Name as cname, course.CourseCode, faculty.Name FROM course INNER JOIN faculty on course.FacultyID = faculty.FacultyID where course.Type = 'CORE' and course.semester = '"+Semester+"'";
resultSet1= statement.executeQuery(sql1);

%>
<div class="container">
			<h4><b>Core Course</b></h4>
			<table style="width: 25%;" border="1">
				<tbody>
					<tr>
					<td>Sr.No.</td>
					<td>Course</td>
					<td>Course Id</td>
					<td>Faculty</td>
					</tr>
			
					<%
						while(resultSet1.next()){
					%>

					<tr>
					<td><input type="text" name="Srno" readonly value=<%out.print(i++); %> ></td>
					<td><input type="text" name="CourseN" readonly value="<%=resultSet1.getString("cname") %>"></td>
					<td><input type="text" name="CourseId" readonly value="<%=resultSet1.getString("CourseCode") %>"></td>
					<td><input type="text" name="cCredit" readonly value="<%=resultSet1.getString("Name") %>"></td>
					</tr>	
					</tbody>


	<%
			}
	%>
	</table>
<br><br>
	
	<h4><b>Program Elective (Please Select Out Of Three)</b></h4>
			<table style="width: 25%;" border="1">
				<tbody>
					<tr>
					<td>Sr.No.</td>
					<td>Course</td>
					<td>Course Code</td>
					<td>Faculty</td>
					</tr>
					<%
					String sql2 ="SELECT course.Name as cname, course.CourseCode, faculty.Name FROM course INNER JOIN faculty on course.FacultyID = faculty.FacultyID where course.Type = 'PE' and course.semester = '"+Semester+"'";
					resultSet2= statement.executeQuery(sql2);
					
					while(resultSet2.next()){
						
					%>
					
					<tr>
					<td><input type="text" name="Srno" readonly value="<%out.print(j++);%>"><br></td>
					<td><input type="text" name="CourseN" readonly value="<%=resultSet2.getString("cname")%>">
					<td><input type="text" name="CourseId" readonly value="<%=resultSet2.getString("CourseCode")%>">
					<td><input type="text" name="cCredit" readonly value="<%=resultSet2.getString("Name")%>">
					</tr>
					<br>
					<tr>					
				</tbody>		
			
	
<%
					}
					%>
					</table>
			<br><br>
<%
}catch (Exception e) {
e.printStackTrace();
}
%>
</div>

<form action="registered.jsp">
<label for="course"><b>Course1</b></label>
        <input type="text" name="course1">
 <label for="course"><b>Course2</b></label>
       <input type="text" name="course2">
 <label for="course"><b>Course3</b></label>
        <input type="text" name="course3">
        <button type="submit">Submit</button>
</form>
</body>