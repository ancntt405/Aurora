package an.dev.data.imp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import an.dev.data.dao.ProductDao;
import an.dev.data.driver.MySQLDriver;
import an.dev.data.model.Product;

public class productImpl implements ProductDao {

	@Override
	public boolean insert(Product product) {
		// TODO Auto-generated method stub
		String sql = "insert into products(name, image, description, price, price_old, quantity, view, category_id, created_at, status) values(?,?,?,?,?,?,?,?,?,?)";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, product.name);
			stmt.setString(2, product.image);
			stmt.setString(3, product.description);
			stmt.setDouble(4, product.price);
			stmt.setDouble(5, product.price_old);
			stmt.setInt(6, product.quantity);
			stmt.setInt(7, product.view);
			stmt.setInt(8, product.category_id);
			stmt.setTimestamp(9, product.created_at);
			stmt.setBoolean(10, product.status);
			stmt.execute();
			
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean update(Product product) {
		// TODO Auto-generated method stub
		String sql = "update products set name = ?, image = ?, description = ?, price = ?, price_old = ?, quantity = ?, view = ?, category_id  = ?, created_at = ?, status = ? where id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, product.name);
			stmt.setString(2, product.image);
			stmt.setString(3, product.description);
			stmt.setDouble(4, product.price);
			stmt.setDouble(5, product.price_old);
			stmt.setInt(6, product.quantity);
			stmt.setInt(7, product.view);
			stmt.setInt(8, product.category_id);
			stmt.setTimestamp(9, product.created_at);
			stmt.setBoolean(10, product.status);
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
		String sql = "DELETE FROM products WHERE id = ?";
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
	public Product find(int id) {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM products WHERE id = ?";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				String name = rs.getString("name");
				String image = rs.getString("image");
				String description = rs.getString("description");
				double price = rs.getDouble("price");
				double price_old = rs.getDouble("price_old");
				int quantity = rs.getInt("quantity");
				int view = rs.getInt("view");
				int category_id  = rs.getInt("category_id");
				Timestamp created_at = rs.getTimestamp("created_at");
				Boolean status = rs.getBoolean("status");
				return new Product(id, name, image, description, price, price_old, quantity, view, category_id, 
						created_at, status);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Product> findAll() {
		// TODO Auto-generated method stub
		List<Product> productList = new ArrayList<Product>();
		String sql = "SELECT * FROM products";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("name");
				String image = rs.getString("image");
				String description = rs.getString("description");
				double price = rs.getDouble("price");
				double price_old = rs.getDouble("price_old");
				int quantity = rs.getInt("quantity");
				int view = rs.getInt("view");
				int category_id  = rs.getInt("category_id");
				Timestamp created_at = rs.getTimestamp("created_at");
				Boolean status = rs.getBoolean("status");
				productList.add(new Product(id, name, image, description, price, price_old, quantity, view, category_id, 
						created_at, status));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return productList;
	}

}
