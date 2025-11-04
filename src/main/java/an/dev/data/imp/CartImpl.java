package an.dev.data.imp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import an.dev.data.dao.CartDao;
import an.dev.data.driver.MySQLDriver;
import an.dev.data.model.Cart;

public class CartImpl implements CartDao{

	@Override
	public boolean insert(Cart cart) {
		// TODO Auto-generated method stub
		String sql = "insert into cart(user_id, product_id, quantity, created_at) values(?,?,?,?)";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cart.user_id);
			stmt.setInt(2, cart.product_id);
			stmt.setInt(3, cart.quantity);
			stmt.setTimestamp(4, cart.created_at);
			stmt.execute();
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean update(Cart cart) {
		// TODO Auto-generated method stub
		String sql = "update cart set user_id = ?, product_id = ?, quantity = ?, created_at = ? where id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cart.user_id);
			stmt.setInt(2, cart.product_id);
			stmt.setInt(3, cart.quantity);
			stmt.setTimestamp(4, cart.created_at);
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
		String sql = "SELECT * FROM `cart` WHERE id = ?";
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
	public Cart find(int id) {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM `cart` WHERE id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int user_id = rs.getInt("user_id");
				int product_id = rs.getInt("product_id");
				int quantity = rs.getInt("quantity");
				Timestamp created_at = rs.getTimestamp("created_at");
				return new Cart(id, user_id, product_id, quantity, created_at);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Cart> findAll() {
		List<Cart> cartList = new ArrayList<Cart>();
		String sql = "SELECT * FROM `cart`";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				int user_id = rs.getInt("user_id");
				int product_id = rs.getInt("product_id");
				int quantity = rs.getInt("quantity");
				Timestamp created_at = rs.getTimestamp("created_at");
				cartList.add(new Cart(id, user_id, product_id, quantity, created_at));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		// TODO Auto-generated method stub
		return cartList;
	}

}
