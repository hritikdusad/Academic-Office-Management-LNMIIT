<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="java.math.*"%>
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
	String EnrollID = request.getParameter("EnrollID");
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
	Statement statement = null, statement1 = null, statement2 = null;
	ResultSet resultSet = null, resultSet1 = null, resultSet2 = null;
%>
<body>
<h2 align="center">
	<font><strong>Data</strong></font>
</h2>

<%
	try {
		connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);
		statement = connection.createStatement();
		statement1 = connection.createStatement();
		statement2 = connection.createStatement();
		String sql = "SELECT * FROM student where EnrollID = '" + EnrollID + "'";

		/*String sql1 = "select performance_sheet.EnrollID, student.FirstName, student.LastName, performance_sheet.Grade from performance_sheet INNER JOIN student on performance_sheet.EnrollID = student.EnrollID where CourseCode = '"+CourseCode+"' and Batch = '"+Batch+"' ORDER BY performance_sheet.EnrollID";*/
		resultSet = statement.executeQuery(sql);
		/*resultSet1 = statement1.executeQuery(sql1);*/
%>

<div class="container Data">
	<form>
		<div class="container">
			<%
				int j = 1;
					if (resultSet.next()) {
						j = resultSet.getInt("prSemester");
			%>
			<label for="Roll"><b>Roll No.:</b></label> <input type="text"
				name="Roll" value="<%=resultSet.getString("EnrollID")%>" readonly
				align="right"> <br> <label for="fname"><b>First
					Name:</b></label> <input type="text" name="Sname"
				value="<%=resultSet.getString("FirstName")%>" readonly align="right">
			<br> <label for="lname"><b>Last Name:</b></label> <input
				type="text" name="Contact"
				value="<%=resultSet.getString("LastName")%>" readonly align="right">
			<br> <label for="dob"><b>Date Of Birth:</b></label> <input
				type="text" name="CGPA" value="<%=resultSet.getString("DOB")%>"
				readonly align="right"> <br> <label for="Contact"><b>Contact:</b></label>
			<input type="text" name="Tcredit"
				value="<%=resultSet.getString("Contact")%>" readonly align="right">
			<br> <label for="D_code"><b>Department Code:</b></label> <input
				type="text" name="CGPA"
				value="<%=resultSet.getString("DepartmentCode")%>" readonly
				align="right"> <br>
			<%
				} else {
						response.sendRedirect("Student.html");
					}
			%>

		</div>
	</form>
</div>

<%
	double ftotalcredits = 0;
		double fobtainedcredits = 0;
		for (int i = 1; i <= j; i++) {
			String sql2 = "select course.CourseCode, course.Name, course.Type, course.Credit, performance_sheet.Grade from course INNER JOIN performance_sheet on course.CourseCode = performance_sheet.CourseCode where performance_sheet.EnrollID = '"
					+ EnrollID + "' and performance_sheet.Semester ='" + i + "'";
			resultSet2 = statement2.executeQuery(sql2);
%>

<table align="center" cellpadding="5" cellspacing="5" border="1">
	<tr>

	</tr>
	<tr bgcolor="#A52A2A">
		<td><b>Course Code</b></td>
		<td><b>Course Name</b></td>
		<td><b>Type</b></td>
		<td><b>Credit </b></td>
		<td><b>Grade</b></td>

	</tr><br><br>
	<%
		double totalcredits = 0;
				double obtainedcredits = 0;
				out.println("\nSemester " + i + ":");
				while (resultSet2.next()) {
					totalcredits += resultSet2.getInt("Credit");
					String grade = resultSet2.getString("Grade");
					double points = grade.equals("A") ? 1
							: grade.equals("AB") ? 0.9
									: grade.equals("B") ? 0.8
											: grade.equals("BC") ? 0.7
													: grade.equals("C") ? 0.6
															: grade.equals("CD") ? 0.5
																	: grade.equals("D") ? 0.4 : 0;
					obtainedcredits += resultSet2.getInt("Credit") * points;
	%>
	<tr bgcolor="#DEB887">

		<td><%=resultSet2.getString("CourseCode")%></td>
		<td><%=resultSet2.getString("Name")%></td>
		<td><%=resultSet2.getString("Type")%></td>
		<td><%=resultSet2.getString("Credit")%></td>
		<td><%=resultSet2.getString("Grade")%></td>
	</tr><br><br>

	<%
		}
				if(i!=j){
					fobtainedcredits += obtainedcredits;
					ftotalcredits += totalcredits;
				}
				double sg= 10 * obtainedcredits / totalcredits;
				sg=(double) Math.round(sg*100.0)/100.0;
				out.println("\nSGPA: "+sg);
			}
		double CGPA= 10 * fobtainedcredits / ftotalcredits;
		%>
</table>

<br> <label for="CGPA"><b>CGPA:</b></label> <input
				type="text" name="CGPA"
				value="<%=(double) Math.round(CGPA*100.0)/100.0%>" readonly
				align="top-left"> <br>
		<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
	
</body>