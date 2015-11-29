<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Select your roomtype</title>
</head>
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
<%@page session="false" %>

<%
try
{
          Class.forName("com.mysql.jdbc.Driver");
          System.out.println("Driver found");
	      String url="jdbc:mysql://localhost/mydb";
	      String user="indra";
	      String password="tp123";
	      Connection con=null;	
		  con=DriverManager.getConnection(url, user, password);
		  System.out.println("\n Connected successfully");
		  String hotel=request.getParameter("select");
		  HttpSession session=request.getSession(false);
		  session.setAttribute("hotel",hotel);
		  
		  System.out.println(hotel);
		  PreparedStatement pstmt=null;
	      String sqlString = "select distinct roomtype,cost,available from accomodation where hotel=?";
	      pstmt = con.prepareStatement(sqlString);
    	  pstmt.setString(1,hotel);
    	  ResultSet rs = pstmt.executeQuery();
    	  
    	  %>
    	  <form action=Confirm.jsp method=post>
    	  <table>
    	  <tr>
    	  <th>RoomType</th>
    	  <th>Cost-Per-Day</th>
    	   <th>Check-Room-Type</th>
    	  <th>Select-no-of-Rooms</th>
    	  </tr>
    	  
    	  
    	  <%
    	  while(rs.next())
    	  {
    		  String roomtype=rs.getString("roomtype");
    		  String cost=rs.getString("cost");
    		  int av=Integer.parseInt(rs.getString("available"));
    		  
    		  %>
    		  
    		  
    		<tr>
    		<td><%=roomtype %></td>
    		<td><%=cost %></td>
    		<td> <input type="checkbox" name="multi" value=<%=roomtype%> > <%=roomtype %>  </td>
    		<td>
    		<select name=<%=roomtype+"1" %>>
    		<%
    		
    		int av1=1;
    		while(av1<=av)
    		{
    		%>
           <option  value=<%=av1%>><%=av1%></option>
    		<%
    		av1++;
    		}
    		%>
    		  </select>
    		  </td>
    		  
    <% 		  
    	  }
    	%>  
    	  
    	  
    	  
    	  
    	  
    	 
    	  </table>
    	   <input type="submit" value="Confirm">
          </form>

<% 
}
catch(SQLException e)
{
 System.out.println(e);
}

catch(ClassNotFoundException e)
{
 System.out.println("Driver not found");
}				  
		  
%>


</body>
</html>