<!doctype html>
<html>
<head>
    <title>Profile</title>

    <meta charset="utf-8" />
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script type="text/javascript" src="jquery-min.js"></script>
<style>
   body{
      background-size:100%;
      background-repeat:no-repeat; 
   }
   #wrapper{
      margin:0 auto;
    }
   #view{
     font-family:sans-serif;
     background-color:white;
      width:450px;
      height:400px;
      border: 1px solid black;
      border-radius:2px;
      padding:30px 10px 0 20px;
      position:relative;
      left:400px;
      top:80px;
      color:#364335;
    }
    #content{ 
       
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
      background-color:white;
      padding:5px;
      background-color:#F2F2F2;
    }
   .button{
      float:right;
      background-color:transpatent;
      border:none;
      padding:0;
      margin=0;
      display:block;
      font-size:0.8em;
    }
    
     #mobileerror{
         color:red;
         display:none;
         margin:0 0 0 200px;
         font-size:0.9em;
         background-color:blue;
     }
      
</style>
</head>

<body background="https://s-media-cache-ak0.pinimg.com/736x/70/6e/21/706e21cf5092736ad944091375a5b8a3.jpg">
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
<%@page import="tour.connection.DBConnection" %>
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
	      
	   
	    	  
	    	  while(rs.next())
		      {
	    		  firstname=rs.getString("firstname");
		    	  lastname=rs.getString("lastname");
		    	  phoneno=rs.getString("phoneno");
		    	  address=rs.getString("address");
		      
		    	  %>

	      
	    	      
          

        <br/><div><div id="fname" class="field"><label>First Name</label><strong><%out.println(firstname); %></strong><a class="button"
onclick="edit('fname','first')">Edit</a></div>
         <form id=first action=ChangeFirstName method="post">
         <label>First Name</label>
         <input type="text" name="firstname"><br/>
         <input type="submit" value="Submit" class="submit">
         <a href="view.jsp"><button class="cancel">Cancel</button></a><br/><br/><br/>
         </form> 
         </div>


         <br/><div><div id="lname" class="field"><label>Last Name</label><strong><%out.println(lastname); %></strong><span class="button" onclick="edit('lname','last')">Edit</span></div>
         <form id="last" action="ChangeLastName" method="post">
         <label>Last Name</label>
         <input type="text" name="lastname"><br/>
         <input type="submit" value="Submit" class="submit">
         <a href="view.jsp"><button class="cancel">Cancel</button></a><br/><br/><br/>
         </form></div>


         <br/><div><div id="mno" class="field"><label>Mobile</label><strong><%out.println(phoneno); %></strong><span class="button" onclick="edit('mno','mobile')">Edit</span></div>
         <p id="mobileerror">Invalid Mobile Number</p>
         <form id="mobile" action=ChangeMobileNumber method="post">
         <label>Mobile</label>
         <input id="mob" type="text" name="mobilenumber"><br/>
         <input type="submit" value="Submit" class="submit">
         <a href="view.jsp"><button class="cancel">Cancel</button></a><br/><br/><br/>
         </form></div>


         <br/><div><div id="addr" class="field"><label>Address</label><strong><%out.println(address); %></strong><span class="button" onclick="edit('addr','place')">Edit</span></div>
         <form id="place" action=ChangeAddress method="post">
         <label>Address</label>
         <input type="text" name="address"><br/>
         <input type="submit" value="Submit" class="submit">
         <a href="view.jsp"><button type="reset" class="cancel">Cancel</button></a><br/><br/><br/>
         </form></div>   

        </div>
   </div>
 </div>
<script>
       var other=false
       function edit(a,b){
         
          if(other==true){
           $(".field").css("display","block");
           $("form").css("display","none");
   
           $("p").css("display","none");
          }
          document.getElementById(a).style.display="none";
          document.getElementById(b).style.display="block";
         
          other=true;
         
          }
       $(".cancel").click(function(event){
    	   event.preventDefault();  
    	   window.location.reload();
       })
       
       document.getElementById("mobile").onsubmit=function(event){     	
       	var flag=0;
       	function isValidPhoneNumber(text){
       	 	var phoneno=document.getElementById(text).value;    	 	
       	 	var phone_regex=/^\d{10}$/;
       	 	return phone_regex.test(phoneno);    	     	 
        	}
        	if(!isValidPhoneNumber("mob")){
        		flag=1;
        		document.getElementById("mobileerror").style.display="block";
   	 	     }
        	else
        		document.getElementById("mobileerror").style.display="none";
    
        	if (flag==1){
        		return false;
        	}
        	else
        		return true;
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