<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>


<body>
<%
	String userid=request.getParameter("userid"); 
	String pwd=request.getParameter("password");
	
	
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
		Statement statement = null;
		ResultSet resultSet = null;
%>
<%
	try{ 
	connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
	statement=connection.createStatement();
	String sql ="SELECT * FROM student where EnrollID = '"+userid+"' and password = '"+pwd+"'" ;
	resultSet = statement.executeQuery(sql);
	
	if(resultSet.next()){ 
		out.println("welcome"+userid);
		response.sendRedirect("StudentHome.html");
	}

	else{
		out.println("Please Try Again");
		response.sendRedirect("StudentLogin.html");
	}

%>
	<% 
} catch (Exception e) {
e.printStackTrace();
}
%>
</body>