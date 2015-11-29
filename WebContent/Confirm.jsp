<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Confirmation</title>
</head>
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
<body>
<form action="payment.jsp">
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
		  HttpSession session=request.getSession(false);
		  String id=(String)session.getAttribute("Flightid");
		  int flag=(Integer)session.getAttribute("flag");
	      int number=(Integer)session.getAttribute("number");
	      int planecost;
		  PreparedStatement pstmt=null;
	      String sqlString = "select * from flight where flightid=?"; //FlightDetails
	      pstmt = con.prepareStatement(sqlString);
    	  pstmt.setString(1,id);
    	  ResultSet rs = pstmt.executeQuery();
          while(rs.next())
          {
        	  String flightname=rs.getString("flightname");
        	  String source=rs.getString("source");
        	  String destination=rs.getString("destination");
        	  String depdate=rs.getString("depdate");
        	  String arrivdate=rs.getString("arrivdate");
        	  String deptime=rs.getString("deptime");
        	  String arrivtime=rs.getString("arrvtime");
        	  int cost=Integer.parseInt(rs.getString("cost"));
        	  planecost=cost*number;
        	  session.setAttribute("planecost",planecost);
              System.out.println(planecost);      	  
       %> 	  
              <p>
        	  Flightname:<%=flightname%>
        	  </p>
        	  <p>
        	  Source:<%=source%>
        	  </p>
        	  <p>
        	  Destination:<%=destination%>
        	  </p>
        	  <p>
        	  DepartureDate:<%=depdate%>
        	  </p>
        	  <p>
        	  ArrivalDate:<%=arrivdate %>
        	  </p>
        	  <p>
        	  DepartureTime:<%=deptime %>
        	  </p>
        	  <p>
        	  ArrivalTime:<%=arrivtime %>
        	  </p>
         <%  
         }
    	  
 %>
 
 
    	  
  <%   	  
  out.println("PassengerDetails");
  out.println("<p>");
  out.println("</p>");
  int a=1;
  while(a<=number)
  {
	  out.println("Passengerno:"+a);
	  out.println("<p>");
	  out.println("FirstName:");
	  out.println(session.getAttribute("fn"+a));
	  out.println("</p>");
	  out.println("<p>");
	  out.println("LastName:");
	  out.println(session.getAttribute("ln"+a));
	  out.println("</p>");
	  out.println("<p>");
	  out.println("Age:");
	  out.println(session.getAttribute("age"+a));
	  out.println("</p>");
	  out.println("<p>");
	  out.println("Gender:");
	  out.println(session.getAttribute("gender"+a));
	  out.println("</p>");
	  a++;
	  
  }	  
		  if(flag==1)
		  {
          String[] check=request.getParameterValues("multi");
          session.setAttribute("check",check);
          int roomcost=0;
          for(String s: check)
        {
         String place=(String)session.getAttribute("destination");
         String hotel=(String)session.getAttribute("hotel");
         int roomno=Integer.parseInt(request.getParameter(s+"1"));
         session.setAttribute(s+"1",roomno);
         out.println("RoomBookType:"+s);
         out.println("<p>");
         out.println("Number of Rooms:"+roomno);
         out.println("<p>");
         //int roomno=1;
	      String sqlstring1="select cost from accomodation where place=? and hotel=? and roomtype=?";
	      pstmt = con.prepareStatement(sqlstring1);
    	  pstmt.setString(1,place);
    	  pstmt.setString(2,hotel);
    	  pstmt.setString(3,s);
    	  ResultSet rs1 = pstmt.executeQuery();
         while(rs1.next())
         {
        	 int cost=Integer.parseInt(rs1.getString("cost"));
        	 cost=cost*roomno;
        	 roomcost=roomcost+cost;
         }
         
        }
          
          System.out.println(roomcost);          
          session.setAttribute("roomcost",roomcost);
		  }
          
          
          
          
          
          
          
          
          
          
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
<input type="submit" value="Proceed to Payment">
</form>

</body>
</html>