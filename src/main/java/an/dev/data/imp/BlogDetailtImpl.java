package an.dev.data.imp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import an.dev.data.dao.BlogDetailtDao;
import an.dev.data.driver.MySQLDriver;
import an.dev.data.model.BlogDetailt;

public class BlogDetailtImpl implements BlogDetailtDao{

	@Override
	public boolean insert(BlogDetailt blogdetailt) {
		// TODO Auto-generated method stub
		String sql = "insert into blog_detail(blog_id, content, created_at, updated_at) values(?,?,?,?)";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, blogdetailt.blog_id);
			stmt.setString(2, blogdetailt.content);
			stmt.setTimestamp(3, blogdetailt.created_at);
			stmt.setTimestamp(4, blogdetailt.updated_at);
			stmt.execute();
			
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean update(BlogDetailt blogdetailt) {
		// TODO Auto-generated method stub
		String sql = "update blog_detail set blog_id = ?, content = ?, created_at = ?, updated_at = ? where id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, blogdetailt.blog_id);
			stmt.setString(2, blogdetailt.content);
			stmt.setTimestamp(3, blogdetailt.created_at);
			stmt.setTimestamp(4, blogdetailt.updated_at);
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
		String sql = "DELETE FROM blog_detail WHERE id = ?";
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
	public BlogDetailt find(int id) {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM `blog_detail` WHERE id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int blog_id = rs.getInt("blog_id");
				String content = rs.getString("content");
				Timestamp created_at = rs.getTimestamp("created_at");
				Timestamp updated_at = rs.getTimestamp("updated_at");
				return new BlogDetailt(id, blog_id, content, created_at, updated_at);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<BlogDetailt> findAll() {
		// TODO Auto-generated method stub
		List<BlogDetailt> blogdetailtList = new ArrayList<BlogDetailt>();
		String sql = "SELECT * FROM `blog_detail`";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				int blog_id = rs.getInt("blog_id");
				String content = rs.getString("content");
				Timestamp created_at = rs.getTimestamp("created_at");
				Timestamp updated_at = rs.getTimestamp("updated_at");
				blogdetailtList.add(new BlogDetailt(id, blog_id, content, created_at, updated_at));
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return blogdetailtList;
	}

}
