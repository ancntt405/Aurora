package an.dev.data.imp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import an.dev.data.dao.BlogDao;
import an.dev.data.driver.MySQLDriver;
import an.dev.data.model.Blog;

public class BlogImpl implements BlogDao{

	@Override
	public boolean insert(Blog blog) {
		// TODO Auto-generated method stub
		String sql = "insert into blog(title, description, image_url) values(?,?,?)";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, blog.title);
			stmt.setString(2, blog.description);
			stmt.setString(3, blog.image_url);
			stmt.execute();
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean update(Blog blog) {
		// TODO Auto-generated method stub
		String sql = "update blog set title = ?, description = ?, image_url where id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, blog.title);
			stmt.setString(2, blog.description);
			stmt.setString(3, blog.image_url);
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
		String sql = "DELETE FROM blog WHERE id = ?";
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
	public Blog find(int id) {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM `blog` WHERE id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				String title = rs.getString("title");
				String description = rs.getString("description");
				String image_url = rs.getString("image_url");
				return new Blog(id, title, description, image_url);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Blog> findAll() {
		List<Blog> blogList = new ArrayList<Blog>();
		String sql = "SELECT * FROM `blog`";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				String title = rs.getString("title");
				String description = rs.getString("description");
				String image_url = rs.getString("image_url");
				blogList.add(new Blog(id, title, description, image_url));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		// TODO Auto-generated method stub
		return blogList;
	}

}
