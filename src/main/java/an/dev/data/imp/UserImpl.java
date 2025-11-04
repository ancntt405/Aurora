package an.dev.data.imp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import an.dev.data.dao.UserDao;
import an.dev.data.driver.MySQLDriver;
import an.dev.data.model.User;

public class UserImpl implements UserDao{

	@Override
	public boolean insert(User user) {
		// TODO Auto-generated method stub
		String sql = "insert into users(email, password, phone, address, image, created_at, updated_at, role, name) values(?,?,?,?,?,?,?,?,?)";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, user.email);
			stmt.setString(2, user.password);
			stmt.setString(3, user.phone);
			stmt.setString(4, user.address);
			stmt.setString(5, user.image);
			stmt.setTimestamp(6, user.created_at);
			stmt.setTimestamp(7, user.updated_at);
			stmt.setString(8, user.role);
			stmt.setString(9, user.name);
			stmt.execute();
			
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean update(User user) {
		// TODO Auto-generated method stub
		String sql = "update users set email = ?, password = ?, phone = ?, address = ?, image = ?, created_at = ?, updated_at = ?, role = ?, name = ? where id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, user.email);
			stmt.setString(2, user.password);
			stmt.setString(3, user.phone);
			stmt.setString(4, user.address);
			stmt.setString(5, user.image);
			stmt.setTimestamp(6, user.created_at);
			stmt.setTimestamp(7, user.updated_at);
			stmt.setString(8, user.role);
			stmt.setString(9, user.name);
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
		String sql = "DELETE FROM users WHERE ID = ?";
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
	public User find(int id) {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM users WHERE id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				String email = rs.getString("email");
				String password = rs.getString("password");
				String phone = rs.getString("phone");
				String address = rs.getString("address");
				String image = rs.getString("image");
				Timestamp created_at = rs.getTimestamp("created_at");
				Timestamp updated_at = rs.getTimestamp("updated_at");
				String role = rs.getString("role");
				String name = rs.getString("name");
				return new User(id, email, password, phone, address, image, created_at, updated_at, role, name);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<User> findAll() {
		// TODO Auto-generated method stub
		List<User> userList = new ArrayList<User>();
		String sql = "SELECT * FROM users";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				String email = rs.getString("email");
				String password = rs.getString("password");
				String phone = rs.getString("phone");
				String address = rs.getString("address");
				String image = rs.getString("image");
				Timestamp created_at = rs.getTimestamp("created_at");
				Timestamp updated_at = rs.getTimestamp("updated_at");
				String role = rs.getString("role");
				String name = rs.getString("name");
				userList.add(new User(id, email, password, phone, address, image, created_at, updated_at, role, name));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return userList;
	}

}
