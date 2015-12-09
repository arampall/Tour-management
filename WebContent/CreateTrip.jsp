<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Start a new Trip</title>
<style type="text/css">
   body{
   background-color:white;
   }
   form{
     margin:20px 30px 20px 20px;
     padding-top:70px;
     font-family:helvetica;
   }
   select{
     float:right;
     width:205px;
     height:25px;
   }
   input{
      float:right;
      width:200px;
      height:20px;
   }
   label{
      font-weight:bold;
      position:relative;
      top:5px;
  
   }
   .isubmit{
      margin:50px 0 0 50px;
      float:left;
      width:150px;
      height:30px;
   }
  
</style>
</head>
<body>

<%@page import  = "java.util.*"%>
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
<%@page import="tour.connection.DBConnection" %>
<%@page session="false" %>

<% 
try
{
	      HttpSession session=request.getSession(false);
          Connection con;
          DBConnection db= new DBConnection();
          con= db.ConnectionManager();

		  String Source;
		  String Destination;
          		  
		  PreparedStatement pstmt=null;
	      String sql_String = "select * from source";
	      pstmt = con.prepareStatement(sql_String);
  	      ResultSet rs_source = pstmt.executeQuery();
  	      sql_String="select*from destination";
  	      pstmt=con.prepareStatement(sql_String);
  	      ResultSet rs_destination=pstmt.executeQuery();
  	      
  	      %>
		  <form action=ShowFlights.jsp method=post target="_parent">
		  <div><label>Source</label>
		  <select name=source>
		  <%
		  while(rs_source.next())
		  {
			 Source=rs_source.getString("source");
			 %>
			 <option><%out.println(Source); %></option>
	
		  <%
		  }%>
  	      </select>
  	      </div>
  	      <br>
  	      <div>
  	      <label>Destination</label>
  	      <select name=destination>
  	      <%
  	      while(rs_destination.next())
  	      {
  	    	  Destination=rs_destination.getString("destination");
  	    	  %>
  	    	 <option ><%out.println(Destination); %>
			 </option>
			 	  
  	      <%} %>
  	      
  	      </select>
  	      </div><br>
  	      <div>
	      <label>Journey Date</label>
	      <input type=date name=dot id="date" required/>
	      </div>
	      <br/>
	      <div>
	      <label>Number of Passengers</label><input type=number name=number required/>
	      </div>
	      <br/>
  	      <input class="isubmit" type=submit value="Search Flights" style="background-color:#FACC2E">
  	      <button type="reset" class="isubmit" onClick=self.close() >Cancel</button>     
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

<script>
    var d= new Date();
    var dd=d.getDate();
    var mm=d.getMonth()+1;
    var yyyy=d.getFullYear();
    if(dd<10){
    	dd='0'+dd;
    }
    if(mm<10){
    	mm='0'+mm;
    }
    d=yyyy+'-'+mm+'-'+dd;
    self.document.getElementById("date").value=d;
    self.document.getElementById("date").min=d;
    function close(){
        var frame=window.parent.document;
        frame.getElementById("frame").style.display="none";
        frame.getElementById("container").style.opacity="1";
    }    
</script>
</body>
</html>