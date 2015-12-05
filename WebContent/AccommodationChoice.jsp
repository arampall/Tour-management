<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<style>
    h3{
    font-family:helvetica;
    }
    button{
    padding:5px 15px;
    font-size:1.1em;
    margin:20px 0 0 40px;
    }
</style>
<body>
<%@page import ="java.util.*"%>
<%@page import ="java.io.IOException" %>
<%@page import ="java.io.PrintWriter" %>
<%@page import ="java.sql.Connection"  %>
<%@page import ="java.sql.DriverManager" %>
<%@page import ="java.sql.ResultSet" %>
<%@page import ="java.sql.SQLException"  %>
<%@page import ="java.sql.Statement" %>
<%@page import ="javax.servlet.http.Cookie" %>
<%@page import ="javax.servlet.http.HttpServlet" %>
<%@page import ="javax.servlet.http.HttpServletRequest"  %>
<%@page import ="javax.servlet.http.HttpServletResponse" %>
<%@page import ="javax.servlet.ServletException"  %>
<%@page import ="javax.servlet.annotation.WebServlet"  %>
<%@page import ="java.sql.PreparedStatement" %>
<%@page import="tour.connection.DBConnection"%>
<%@page session="false" %>
  <%
			try {
				Connection con;
				DBConnection db = new DBConnection();
				con = db.ConnectionManager();
				HttpSession session = request.getSession(false);
				int n = (Integer) session.getAttribute("number");
				String passenger_info;
				for (int i = 1; i <= n; i++) {
					passenger_info = request.getParameter("fn" + i);
					session.setAttribute("fn" + i, passenger_info);
					passenger_info = request.getParameter("ln" + i);
					session.setAttribute("ln" + i, passenger_info);
					passenger_info = request.getParameter("age" + i);
					session.setAttribute("age" + i, passenger_info);
					passenger_info = request.getParameter("gender" + i);
					session.setAttribute("gender" + i, passenger_info);
				}
			} 
  
            catch (SQLException e) {
				System.out.println(e);
			}

			catch (ClassNotFoundException e) {
				System.out.println("Driver not found");
			}
		%>
<h3>Do you require accommodation?</h3>
<a href="Accommodation.jsp" target="_parent"><button>Yes</button></a>
<a href="Confirmation.jsp" target="_parent"><button>No</button></a>
</body>
</html>