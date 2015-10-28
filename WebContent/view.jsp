<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>View your profile</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<style>
   #wrapper{
      margin:0 auto;
    }
   form{
     font-family:helvetica;
     background-color:white;
      width:450px;
      height:300px;
      border: 2px solid black;
      border-radius:2px;
      padding:30px 10px 0 20px;
    }

    input{
        border: 3px solid grey;
        padding-left:2px;
        margin-bottom:3px;
        border-radius:5px;
        font-size:1.1em;
    }
    #submit{
       margin:15px 20px 0 100px;
    }
    table{
       padding:30px 0 0 40px;
    }
    td{
       font-weight:bold;
      width:150px;
      float:left;
      padding-top:3px;
    }
    #edit{
      float:right;
      margin:0 10px 20px 0;
      font-size:0.8em;
    }
    #view{
       display:block;
    }
    a{
       text-decoration:none;
     }
    h3{
      border-bottom:3px solid black;
    } 
</style>
</head>
<body background="http://www.hdwallpapers.in/walls/city_nights__lights-wide.jpg">


<div id="wrapper">
   <form>
     <h3>Profile</h3>
     <div id="view">
        <button id="edit"><a href="edit.html">Edit Profile</a></button>
        <table>
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

<% 
try
{
int unique=0;
Class.forName("com.mysql.jdbc.Driver");
System.out.println("Driver found");
	
	
	String url="jdbc:mysql://localhost/mydb";
	String user="indra";
	String password="tp123";
	Connection con=null;
	
	
		con=DriverManager.getConnection(url, user, password);
		System.out.println("\n Connected successfully");
		
         
		Cookie[] cookies = null;
	      // Get an array of Cookies associated with this domain
	      cookies = request.getCookies(); 
	      String id;
	      int value;
	      /*for (int i = 0; i < cookies.length; i++){
	         Cookie cookie = cookies[i];
	          
	          id=cookie.getName();
	          value=Integer.parseInt(cookie.getValue());
	          if(id.equals("id"))
	          {
	        	  Cookie cookie1=cookies[i];
	    	      id=cookie1.getName();
	              value=Integer.parseInt(cookie1.getValue());
	              System.out.println(id);
	              System.out.println(value);
	              PreparedStatement pstmt=null;
	    	      String sqlString = "select firstname,lastname,phoneno,address,password from customer where id=?";
	    	      pstmt = con.prepareStatement(sqlString);
	        	  pstmt.setInt(1, value);
	        	  ResultSet rs = pstmt.executeQuery();
	        	  String firstname;
	    	      String lastname;
	    	      String phoneno;
	    	      String address;
	    	      String password1;
	    	      
	    	      while(rs.next())
	    	      {
	    	    	  firstname=rs.getString("firstname");
	    	    	  lastname=rs.getString("lastname");
	    	    	  phoneno=rs.getString("phoneno");
	    	    	  address=rs.getString("address");
	    	    	  password1=rs.getString("password");
	    	    	  out.println("<tr><td>First Name</td><td>"+firstname+"</td></tr>");
	    	          out.println("<tr><td>Last Name</td><td>"+lastname+"</td></tr>");
	    	          out.println("<tr><td>PhoneNumber</td><td>"+phoneno+"</td></tr>");
	    	          out.println("<tr><td>Address</td><td>"+address+"</td></tr>");
	    	          out.println("<tr><td>Password</td><td>"+password1+"</td><tr>");
	    	      }  
	    	     
	    	      break;
	          }
	          
	       }*/
	      Cookie cookie1=cookies[1];
	      id=cookie1.getName();
          value=Integer.parseInt(cookie1.getValue());
          System.out.println(id);
          System.out.println(value);
	      PreparedStatement pstmt=null;
	      String sqlString = "select firstname,lastname,phoneno,address,password from customer where id=?";
	      pstmt = con.prepareStatement(sqlString);
    	  pstmt.setInt(1, value);
    	  ResultSet rs = pstmt.executeQuery();
	      
	      String firstname;
	      String lastname;
	      String phoneno;
	      String address;
	      String password1;
	      
	      while(rs.next())
	      {
	    	  firstname=rs.getString("firstname");
	    	  lastname=rs.getString("lastname");
	    	  phoneno=rs.getString("phoneno");
	    	  address=rs.getString("address");
	    	  password1=rs.getString("password");
	    	  out.println("<tr><td>First Name</td><td>"+firstname+"</td></tr>");
	          out.println("<tr><td>Last Name</td><td>"+lastname+"</td></tr>");
	          out.println("<tr><td>PhoneNumber</td><td>"+phoneno+"</td></tr>");
	          out.println("<tr><td>Address</td><td>"+address+"</td></tr>");
	          out.println("<tr><td>Password</td><td>"+password1+"</td><tr>");
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
            
            
            
        </table> 
     </div>
   </form>
 </div>
</body>
</html>