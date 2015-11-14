package tour.process;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import tour.server.DBConnection;

public class SeatCheck {
	public int check(int seats_number) {
		int flag = 0;
		try {
			Connection con;
			DBConnection db = new DBConnection();
			con = db.ConnectionManager();

			PreparedStatement pstmt = null;
			String sqlString = "select * from flight where source=? and destination=? and depdate=? and seats>=?";
			try {
				pstmt = con.prepareStatement(sqlString);
				pstmt.setString(1, "Mumbai");
				pstmt.setString(2, "NewYork");
				pstmt.setString(3, "2015-11-24");
				pstmt.setInt(4, seats_number);
				ResultSet rs = pstmt.executeQuery();
				if (rs.next()) {
					flag = 1;
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} finally {
			return flag;
		}
	}

}
