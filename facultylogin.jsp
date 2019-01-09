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
	
	String user = "admin";
	String password = "123456789";

%>
	<%
				if(password.equals(pwd) && user.equals(userid)){ 
					out.println("welcome"+userid);
					response.sendRedirect("FacultyHome.html");
				}
		
				else{
					out.println("Please Try Again");
					response.sendRedirect("FacultyLogin.html");
				}
			
			
	%>
	
</body>