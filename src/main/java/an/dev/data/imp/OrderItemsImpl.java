package an.dev.data.imp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import an.dev.data.dao.OrderItemDao;
import an.dev.data.driver.MySQLDriver;
import an.dev.data.model.OrderItems;

public class OrderItemsImpl implements OrderItemDao {

	@Override
	public boolean insert(OrderItems orderitems) {
		// TODO Auto-generated method stub
		String sql = "insert into order_items(quantity, price, order_id, product_id) values (?,?,?,?)";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orderitems.quantity);
			stmt.setDouble(2, orderitems.price);
			stmt.setInt(3, orderitems.order_id);
			stmt.setInt(4, orderitems.product_id);
			stmt.execute();
			
		}catch(SQLException e) {
		   e.printStackTrace();
		   return false;
		}
		return true;
	}

	@Override
	public boolean update(OrderItems orderitems) {
		// TODO Auto-generated method stub
		String sql = "update order_items set quantity = ?, price = ?, order_id = ?, product_id = ? where id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orderitems.quantity);
			stmt.setDouble(2, orderitems.price);
			stmt.setInt(3, orderitems.order_id);
			stmt.setInt(4, orderitems.product_id);
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
		String sql = "DELETE FROM order_items WHERE id = ?";
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
	public OrderItems find(int id) {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM order_items WHERE id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int quantity = rs.getInt("quantity");
				double price = rs.getDouble("price");
				int order_id  = rs.getInt("order_id");
				int product_id = rs.getInt("product_id");
				return new OrderItems(id, quantity, price, order_id, product_id);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<OrderItems> findAll() {
		List<OrderItems> orderitemsList = new ArrayList<OrderItems>();
		String sql = "SELECT * FROM order_items";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				int quantity = rs.getInt("quantity");
				double price = rs.getDouble("price");
				int order_id  = rs.getInt("order_id");
				int product_id = rs.getInt("product_id");
				orderitemsList.add(new OrderItems(id, quantity, price, order_id, product_id));
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		// TODO Auto-generated method stub
		return orderitemsList;
	}

}
