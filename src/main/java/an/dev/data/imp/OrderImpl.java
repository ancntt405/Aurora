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
		String sql = "insert into orders(code, status, user_id, created_at) values(?,?,?,?)";
        try {
            Connection conn = MySQLDriver.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, order.code);
            stmt.setBoolean(2, order.status);
            stmt.setInt(3, order.user_id);
            java.sql.Timestamp created = (order.created_at != null) ? order.created_at : new java.sql.Timestamp(System.currentTimeMillis());
            stmt.setTimestamp(4, created);
            int affected = stmt.executeUpdate();
            if (affected > 0) {
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        order.id = keys.getInt(1);
                    }
                }
                if (order.id == 0) {
                    try (PreparedStatement ps = conn.prepareStatement("SELECT LAST_INSERT_ID() AS id");
                         ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) order.id = rs.getInt("id");
                    }
                }
            }
        }catch(SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
	}

	@Override
	public boolean update(Order order) {
		// TODO Auto-generated method stub
		String sql = "update orders set code = ?, status = ?, user_id = ?, created_at = ? where id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, order.code);
			stmt.setBoolean(2, order.status);
			stmt.setInt(3, order.user_id);
			stmt.setTimestamp(4, order.created_at);
			stmt.setInt(5, order.id);
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
				Timestamp updated_at;
				try { rs.findColumn("updated_at"); updated_at = rs.getTimestamp("updated_at"); } catch (SQLException ignore) { updated_at = null; }
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
				Timestamp updated_at; try { rs.findColumn("updated_at"); updated_at = rs.getTimestamp("updated_at"); } catch (SQLException ignore) { updated_at = null; }
				orderList.add(new Order(id, code, status, user_id, created_at, updated_at));
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return orderList;
	}

    @Override
    public boolean hasOrdersByUserId(int userId) {
        String sql = "SELECT 1 FROM `orders` WHERE user_id = ? LIMIT 1";
        try {
            Connection conn = MySQLDriver.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Order> findByUserId(int id) {
        List<Order> orderList = new ArrayList<Order>();
        String sql = "SELECT * FROM `orders` WHERE user_id = ?";
        try {
            Connection conn = MySQLDriver.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int orderId = rs.getInt("id");
                String code = rs.getString("code");
                Boolean status = rs.getBoolean("status");
                int user_id = rs.getInt("user_id");
                Timestamp created_at = rs.getTimestamp("created_at");
                Timestamp updated_at; try { rs.findColumn("updated_at"); updated_at = rs.getTimestamp("updated_at"); } catch (SQLException ignore) { updated_at = null; }
                orderList.add(new Order(orderId, code, status, user_id, created_at, updated_at));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderList;
    }

    @Override
    public Order finByCode(String code) {
        String sql = "SELECT * FROM `orders` WHERE code = ? LIMIT 1";
        try {
            Connection conn = MySQLDriver.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, code);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String codeVal = rs.getString("code");
                Boolean status = rs.getBoolean("status");
                int user_id = rs.getInt("user_id");
                Timestamp created_at = rs.getTimestamp("created_at");
                Timestamp updated_at; try { rs.findColumn("updated_at"); updated_at = rs.getTimestamp("updated_at"); } catch (SQLException ignore) { updated_at = null; }
                return new Order(id, codeVal, status, user_id, created_at, updated_at);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
