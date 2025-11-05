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

    @Override
    public Cart findByUserAndProduct(int userId, int productId) {
        String sql = "SELECT * FROM `cart` WHERE user_id = ? AND product_id = ? LIMIT 1";
        try {
            Connection conn = MySQLDriver.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                int quantity = rs.getInt("quantity");
                Timestamp created_at = rs.getTimestamp("created_at");
                return new Cart(id, userId, productId, quantity, created_at);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void updateQuantity(int userId, int productId, int i) {
        String sql = "UPDATE `cart` SET quantity = ? WHERE user_id = ? AND product_id = ?";
        try {
            Connection conn = MySQLDriver.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, i);
            stmt.setInt(2, userId);
            stmt.setInt(3, productId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public java.util.List<Cart> findAllByUser(int userId) {
        java.util.List<Cart> cartList = new java.util.ArrayList<>();
        String sql = "SELECT * FROM `cart` WHERE user_id = ?";
        try {
            Connection conn = MySQLDriver.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int product_id = rs.getInt("product_id");
                int quantity = rs.getInt("quantity");
                Timestamp created_at = rs.getTimestamp("created_at");
                cartList.add(new Cart(id, userId, product_id, quantity, created_at));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartList;
    }

    public void deleteByUserAndProduct(int userId, int productId) {
        String sql = "DELETE FROM `cart` WHERE user_id = ? AND product_id = ?";
        try {
            Connection conn = MySQLDriver.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int sumQuantityByUser(int userId) {
        String sql = "SELECT COALESCE(SUM(quantity),0) AS total FROM `cart` WHERE user_id = ?";
        try {
            Connection conn = MySQLDriver.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

}
