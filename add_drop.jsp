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

<%
String EnrollID = request.getParameter("Roll");
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
String sql1 ="select course.CourseCode, course.Name from course where course.Type='PE' and course.semester = '"+Semester+"' and course.CourseCode  NOT IN(select CourseCode from performance_sheet where semester = '"+Semester+"' and EnrollID= '"+EnrollID+"')";
resultSet1= statement.executeQuery(sql1);

%>

			<h4><b>Add Course</b></h4>
			<table style="width: 25%;" border="1">
				<tbody>
					<tr>
					<td>Sr.No.</td>
					<td>Course</td>
					<td>Course Id</td>
					<td>Credit</td>
					</tr>
					<tr>
					<td><input type="text" name="Srno" readonly value=<%out.print(i++); %> ></td>
					<td><input type="text" name="CourseN" value="/"></td>
					<td><input type="text" name="CourseId" value="/"></td>
					<td><input type="text" name="cCredit" value="/"></td>
					</tr>
				</tbody>		
			</table>
			<br><br>
			<h4><b>Drop Course</b></h4>
			<table style="width: 25%;" border="1">
				<tbody>
					<tr>
					<td>Sr.No.</td>
					<td>Course</td>
					<td>Course Id</td>
					</tr>
					<%
						String sql2 = "select course.CourseCode, course.Name from performance_sheet INNER JOIN course on performance_sheet.CourseCode = course.CourseCode INNER JOIN student on performance_sheet.EnrollID = student.EnrollID where performance_sheet.EnrollID = '"+EnrollID+"' and course.Type='PE' and performance_sheet.semester = '"+Semester+"' ";
						resultSet2=statement2.executeQuery(sql2);
					%>
					<% while(resultSet2.next()){ %>
					<tr>
					<td><input type="text" name="Srno" readonly value=<%out.print(j++); %> ></td>
					<td><input type="text" name="CourseN" value="<%=resultSet2.getString("Name")%>"></td>
					<td><input type="text" name="CourseId" value="<%=resultSet2.getString("CourseCode")%>"></td>
					</tr>
				</tbody>
						<%
					}
						%>
			</table><br><br>
			<input type="submit" value="Submit">					
		</form>
		<%
}catch (Exception e) {
e.printStackTrace();
}
%>
		
	</div>