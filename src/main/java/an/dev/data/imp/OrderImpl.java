package an.dev.data.imp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import an.dev.data.dao.OrderDao;
import an.dev.data.driver.MySQLDriver;
import an.dev.data.model.Order;

public class OrderImpl implements OrderDao {

	@Override
	public boolean insert(Order order) {
		// TODO Auto-generated method stub
		String sql = "insert into orders(code, status, user_id, created_at, updated_at) values(?,?,?,?,?)";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, order.code);
			stmt.setBoolean(2, order.status);
			stmt.setInt(3, order.user_id);
			stmt.setTimestamp(4, order.created_at);
			stmt.setTimestamp(5, order.updated_at);
			stmt.execute();
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean update(Order order) {
		// TODO Auto-generated method stub
		String sql = "update orders set code = ?, status = ?, user_id = ?, created_at = ?,updated_at = ? where id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, order.code);
			stmt.setBoolean(2, order.status);
			stmt.setInt(3, order.user_id);
			stmt.setTimestamp(4, order.created_at);
			stmt.setTimestamp(5, order.updated_at);
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
		String sql = "DELETE FROM orders WHERE id = ?";
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
	public Order find(int id) {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM `orders` WHERE id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				String code = rs.getString("code");
				Boolean status = rs.getBoolean("status");
				int user_id = rs.getInt("user_id");
				Timestamp created_at = rs.getTimestamp("created_at");
				Timestamp updated_at = rs.getTimestamp("updated_at");
				return new Order(id, code, status, user_id, created_at, updated_at);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Order> findAll() {
		// TODO Auto-generated method stub
		List<Order> orderList = new ArrayList<Order>();
		String sql = "SELECT * FROM `orders`";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				String code = rs.getString("code");
				Boolean status = rs.getBoolean("status");
				int user_id = rs.getInt("user_id");
				Timestamp created_at = rs.getTimestamp("created_at");
				Timestamp updated_at = rs.getTimestamp("updated_at");
				orderList.add(new Order(id, code, status, user_id, created_at, updated_at));
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return orderList;
	}

    @Override
    public boolean hasOrdersByUserId(int userId) {
        return false;
    }

}
