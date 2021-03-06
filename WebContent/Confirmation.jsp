<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Confirm Trip</title>
<style type="text/css">
td {
	margin: 0;
	background-color: white;
	font-size: 1.3em;
	padding: 10px;
}

th {
	padding: 10px;
	font-size: 1.2em;
	background-color: #E6E6E6;
}
button{
    width:150px;
    padding:5px;
}
</style>
</head>
<body>
	<%@page import="java.util.*"%>
	<%@page import="java.io.IOException"%>
	<%@page import="java.io.PrintWriter"%>
	<%@page import="java.sql.Connection"%>
	<%@page import="java.sql.DriverManager"%>
	<%@page import="java.sql.ResultSet"%>
	<%@page import="java.sql.SQLException"%>
	<%@page import="java.sql.Statement"%>
	<%@page import="javax.servlet.http.Cookie"%>
	<%@page import="javax.servlet.http.HttpServlet"%>
	<%@page import="javax.servlet.http.HttpServletRequest"%>
	<%@page import="javax.servlet.http.HttpServletResponse"%>
	<%@page import="javax.servlet.ServletException"%>
	<%@page import="javax.servlet.annotation.WebServlet"%>
	<%@page import="java.sql.PreparedStatement"%>
	<%@page import="tour.connection.DBConnection"%>
	<%@page session="false"%>
	<div id=container>
		<h2>Please Confirm Your Trip Details</h2>
		<h3>Flight Itinerary</h3>

		<%
			try {
				Connection con;
				DBConnection db = new DBConnection();
				con = db.ConnectionManager();
				HttpSession session = request.getSession(false);
				String flight = (String) session.getAttribute("flight");
				int n = (Integer) session.getAttribute("number");
				String hotel_id = request.getParameter("hotelbook");
				session.setAttribute("hotel_id",hotel_id);
				PreparedStatement pstmt = null;
		%>
		<table>
			<%
				String flight_info = "select * from flight where flightid=?";
					pstmt = con.prepareStatement(flight_info);
					pstmt.setString(1, flight);
					ResultSet rs = pstmt.executeQuery();

					String flight_name;
					String source;
					String destination;
					String journey_date;
					String arrival_date;
					String departure_time;
					String arrival_time;
					float price;

					while (rs.next()) {
						flight_name = rs.getString("flightname");
						source = rs.getString("source");
						destination = rs.getString("destination");
						journey_date = rs.getString("departure_date");
						arrival_date = rs.getString("arrival_date");
						departure_time = rs.getString("departure_time");
						arrival_time = rs.getString("arrival_time");
						price = rs.getFloat("price");
			%>

			<tr>

				<td>
					<%
						out.println(flight_name);
					%>
				</td>
				<td>
					<%
						out.print(source);
					%>
				</td>
				<td>
					<%
						out.println(destination);
					%>
				</td>
				<td>
					<%
						out.println(journey_date);
					%>
				</td>
				<td>
					<%
						out.println(departure_time);
					%>
				</td>
				<td>
					<%
						out.println(arrival_date);
					%>
				</td>
				<td>
					<%
						out.println(arrival_time);
					%>
				</td>
				<td>
					<%
						out.println(price);
					    session.setAttribute("flight_price", price);
					%>
				</td>
			</tr>




			<%
				}
			%>
		</table>
		<h3>Passenger Details</h3>
		<table>
			<%
				for (int i = 1; i <= n; i++) {
			%>
			<tr>
				<td>
					<%
						out.println((String) session.getAttribute("fn" + i));
					%>
				</td>
				<td>
					<%
						out.println((String) session.getAttribute("ln" + i));
					%>
				</td>
				<td>
					<%
						out.println((String) session.getAttribute("age" + i));
					%>
				</td>
				<td>
					<%
						out.println((String) session.getAttribute("gender" + i));
					%>
				</td>
			</tr>

			<%
				}
			%>
		</table>
		<h3>Accommodation Details</h3>
		<table>
			<%
				    String hotel_info = "select * from accomodation where ID=?";
			        PreparedStatement pstmt1 = null;
					pstmt1 = con.prepareStatement(hotel_info);
					pstmt1.setString(1,hotel_id);
					ResultSet rs1 = pstmt1.executeQuery();

					String hotel_name;
					String room_type;
					String checkin;
					float hotel_price;

					while (rs1.next()) {
						hotel_name = rs1.getString("Hotel_name");
						room_type = rs1.getString("Roomtype");
						checkin = rs1.getString("Check_in");
						hotel_price=rs1.getFloat("price");
						session.setAttribute("hotel_price", hotel_price);
			%>

			<tr>

				<td>
					<%
						out.println(hotel_name);
					%>
				</td>

				<td>
					<%
						out.println(room_type);
					%>
				</td>

				<td>
					<%
						out.println(checkin);
					%>
				</td>
				
				<td>
					<%  
						out.println(hotel_price);  
					%>
				</td>
			</tr>




			<%
				}
					float totalprice = 0;
				   
			%>
		</table>
		
		<%
			} catch (SQLException e) {
				System.out.println(e);
			}

			catch (ClassNotFoundException e) {
				System.out.println("Driver not found");
			}
		%>
	</div>
	<a href="Payment.html"><button>Confirm</button></a>
	<a href=""><button>Start a New Trip</button></a>
</body>
</html>