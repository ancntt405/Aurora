package an.dev.data.imp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import an.dev.data.dao.GalleryDao;
import an.dev.data.driver.MySQLDriver;
import an.dev.data.model.Gallery;

public class GalleryImpl implements GalleryDao{

	@Override
	public boolean insert(Gallery gallery) {
		// TODO Auto-generated method stub
		String sql = "insert into gallery(image_url, product_id) values (?,?)";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, gallery.image_url);
			stmt.setInt(2, gallery.product_id);
			stmt.execute();
			
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean update(Gallery gallery) {
		// TODO Auto-generated method stub
		String sql = "update gallery set image_url = ?, product_id = ? where id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, gallery.image_url);
			stmt.setInt(2, gallery.product_id);
			stmt.execute();
		}catch(SQLException e) {
			return false;
		}
		return true;
	}

	@Override
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		String sql = "DELETE FROM gallery WHERE id = ?";
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
	public Gallery find(int id) {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM `gallery` WHERE id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				String image_url = rs.getString("image_url");
				int product_id = rs.getInt("product_id");
				return new Gallery(id, image_url, product_id);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Gallery> findAll() {
		List<Gallery> galleryList = new ArrayList<Gallery>();
		String sql = "SELECT * FROM gallery";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				String image_url = rs.getString("image_url");
				int product_id = rs.getInt("product_id");
				galleryList.add(new Gallery(id, image_url, product_id));
			}	
		}catch(SQLException e) {
			e.printStackTrace();
		}
		// TODO Auto-generated method stub
		return galleryList;
	}

}
