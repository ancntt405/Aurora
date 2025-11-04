package an.dev.data.imp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import an.dev.data.dao.CategoryDao;
import an.dev.data.driver.MySQLDriver;
import an.dev.data.model.Category;

public class CategoryImpl implements CategoryDao {

	@Override
	public boolean insert(Category category) {
		// TODO Auto-generated method stub
		String sql = "insert into categories(name, thumbnail, status) VALUES(?, ?,?)";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.name);
			stmt.setString(2, category.thumbnail);
			stmt.setBoolean(3, category.status);
			stmt.execute();
			
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean update(Category category) {
		// TODO Auto-generated method stub
		String sql = "UPDATE categories SET name = ?, thumbnail = ?, status = ? WHERE id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.name);
			stmt.setString(2, category.thumbnail);
			stmt.setBoolean(3, category.status);
			stmt.setInt(4, category.id);
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
		String sql = "DELETE FROM categories WHERE ID = ?";
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
	public Category find(int id) {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM categories WHERE id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				String name = rs.getString("name");
				String thumbnail = rs.getString("thumbnail");
				Boolean status = rs.getBoolean("status");
				return new Category(id, name, thumbnail, status);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Category> findAll() {
		// TODO Auto-generated method stub
		List<Category> categoryList = new ArrayList<Category>();
		String sql = "SELECT * FROM categories";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				String thumbnail = rs.getString("thumbnail");
				Boolean status = rs.getBoolean("status");
				categoryList.add(new Category(id, name, thumbnail, status));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return categoryList;
	}

}
