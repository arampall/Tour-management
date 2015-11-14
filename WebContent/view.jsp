<!doctype html>
<html>
<head>
    <title>Profile</title>

    <meta charset="utf-8" />
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script type="text/javascript" src="jquery-min.js"></script>
<style>
   #wrapper{
      margin:0 auto;
    }
   #view{
     font-family:helvetica;
     background-color:white;
      width:450px;
      height:400px;
      border: 1px solid black;
      border-radius:2px;
      padding:30px 10px 0 20px;
      position:relative;
      left:400px;
      top:80px;
    }
    #content{
       background-color:white;
       padding:10px 0 10px 20px;
       height:250px;
     } 
   label{
      font-weight:bold;
      margin-right:100px;
      width:100px;
      float:left;
   }
   .submit{
      float:left;
      margin:10px 0 10px 210px;
   }
   .cancel{
     
      margin:10px 0 10px 10px;
   }
   form{
     display:none;
     float:left;
   }
   .field{
      margin:10px 0 10px 0;
      display:block;
    }
   .button{
      float:left;
      padding:0;
      margin=0;
      display:none;
    }
    .field:hover .button{
         display:block;
     }
     
   
</style>
</head>

<body>
 <div id="wrapper">
   <div id="view">
     <h3>Profile</h3>
        <div id="content">
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
<%@page import="tour.server.DBConnection" %>
<%
try
{
int unique=0;
Connection con;
DBConnection db= new DBConnection();
con= db.ConnectionManager();
		
         
		Cookie[] cookies = null;
	      // Get an array of Cookies associated with this domain
	      cookies = request.getCookies(); 
	      String id;
	      int value;
	      
	      Cookie cookie1=cookies[1];
	      id=cookie1.getName();
	      //System.out.println("id is"+id);
          value=Integer.parseInt(cookie1.getValue());
          //System.out.println(id);
          //System.out.println(value);
	      PreparedStatement pstmt=null;
	      String sqlString = "select firstname,lastname,phoneno,address,password from customer where id=?";
	      pstmt = con.prepareStatement(sqlString);
    	  pstmt.setInt(1, value);
    	  //System.out.println("coming now here");
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
		    	  System.out.println("hi");
		      %>

          

        <br/><div id="fname" class="field"><label>First Name</label><strong><%out.println(firstname); %></strong><button class="button"
onclick="edit('fname','first')"><img src="editpen.jpg"/></button></div>
         <form id=first action=ChangeFirstName method="post">
         <label>First Name</label>
         <input type="text" name="firstname"><br/>
         <input type="submit" value="Submit" class="submit">
         <button class="cancel">Cancel</button>
         </form> 


         <br/><div id="lname" class="field"><label>Last Name</label><strong><%out.println(lastname); %></strong><button class="button" onclick="edit('lname','last')"><img src="editpen.jpg"/></button></div>
         <form id="last" action="ChangeLastName" method="post">
         <label>Last Name</label>
         <input type="text" name="lastname"><br/>
         <input type="submit" value="Submit" class="submit">
         <button class="cancel">Cancel</button>
         </form>


         <br/><div id="mno" class="field"><label>Mobile</label><strong><%out.println(phoneno); %></strong><button class="button" onclick="edit('mno','mobile')"><img src="editpen.jpg"/></button></div>
         <form id="mobile" action=ChangeMobileNumber method="post">
         <label>Mobile</label>
         <input type="text" name="mobilenumber"><br/>
         <input type="submit" value="Submit" class="submit">
         <button class="cancel">Cancel</button>
         </form>


         <br/><div id="addr" class="field"><label>Address</label><strong><%out.println(address); %></strong><button class="button" onclick="edit('addr','place')"><img src="editpen.jpg"/></button></div>
         <form id="place" action=ChangeAddress method="post">
         <label>Address</label>
         <input type="text" name="address"><br/>
         <input type="submit" value="Submit" class="submit">
         <button class="cancel">Cancel</button>
         </form>   

        </div>
   </div>
 </div>
<script>
       var other=false
       function edit(a,b){
         
          if(other==true){
           $(".field").css("display","block");
           $("form").css("display","none");
          }
          document.getElementById(a).style.display="none";
          document.getElementById(b).style.display="block"; 
          other=true;
       }
 
</script>
<%}} 
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