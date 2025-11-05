package an.dev.data.imp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import an.dev.data.dao.BannerDao;
import an.dev.data.driver.MySQLDriver;
import an.dev.data.model.Banner;

public class BannerImpl implements BannerDao{

	@Override
	public boolean insert(Banner banner) {
		// TODO Auto-generated method stub
		String sql = "insert into banner(image, title, status) values (?, ?,?)";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, banner.image);
			stmt.setString(2, banner.title);
			stmt.setBoolean(3, banner.status);
			stmt.execute();
			
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean update(Banner banner) {
		// TODO Auto-generated method stub
		String sql = "update banner set image = ?, title = ?, status = ? where id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, banner.image);
			stmt.setString(2, banner.title);
			stmt.setBoolean(3, banner.status);
			stmt.setInt(4, banner.id);
			stmt.execute();
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		String sql = "DELETE FROM banner WHERE id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			stmt.execute();
			
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public Banner find(int id) {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM `banner` WHERE id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				String image = rs.getString("image");
				String title = rs.getString("title");
				Boolean status = rs.getBoolean("status");
				return new Banner(id, image, title, status);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Banner> findAll() {
		List<Banner> bannerList = new ArrayList<Banner>();
		String sql = "SELECT * FROM `banner`";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				String image = rs.getString("image");
				String title = rs.getString("title");
				Boolean status = rs.getBoolean("status");
				bannerList.add(new Banner(id, image, title, status));
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		// TODO Auto-generated method stub
		return bannerList;
	}

}
