<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>LoginPage</title>
<style>
   #login{
      font-family: helvetica;
      border:1px solid #424242;
      border-radius:3px;
      width:280px;
      margin-left:20px;
      padding:30px 0 0 10px;
   }
   input{
      width:220px;
      margin:5px 0 5px 25px;
      padding:5px 0 5px 5px;
      border:1px solid #848484;
      background-color:transparent;
   }
   #submit{
      width:228px;
      font-stretch:expanded;
      font-weight:bold;
      background-color:transparent;
      border: 2px solid #848484;
      font-size:1.1em;
      padding:3px 0 3px 0;
      cursor:pointer;
   }
   a{
      color:red;
   }
   placeholder{
      color:black;
   }
</style>
</head>
<body background="http://www.wallpapersbyte.com/wp-content/uploads/2015/06/London-City-Big-Ben-Bridge-River-Buildings-Top-View-BW-Black-And-White-WallpapersByte-com-1366x768.jpg">
   <H1 align=center>TOURISTFEST-ALL IN ONE</H1>
<div id="login">
   <H3 align=center> LOGIN!!</H3>

   <FORM action=ValidateLogin method="get">
      <div id="field">
      <p style="display:none">Invalid</p>
	<INPUT type="text" name="username" placeholder="Username"><br>
	<INPUT type="password" name="password" placeholder="password"><br>
      </div>
	<INPUT id="submit" type="submit" value="Sign In">
   </FORM>
   <H4 align=center style="font-family:delicious">Don't have an account, <a href="signup.html">SignUp here</a></H4>
 
</div>
</body>
</html>