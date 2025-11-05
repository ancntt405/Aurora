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
	public int insert(Product product) {
		// TODO Auto-generated method stub
		String sql = "insert into products(name, image, description, price, price_old, quantity, view, category_id, created_at, status) values(?,?,?,?,?,?,?,?,?,?)";
		try {
			Connection conn = MySQLDriver.getInstance().getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
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
			int affected = stmt.executeUpdate();
			if (affected == 0) return -1;
			ResultSet keys = stmt.getGeneratedKeys();
			if (keys.next()) {
				return keys.getInt(1);
			}
			return -1;
		}catch(SQLException e) {
			e.printStackTrace();
			return -1;
		}
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
			stmt.setInt(11, product.id);
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

    @Override
    public List<Product> getProducts(int i, int perPage) {
        List<Product> productList = new ArrayList<Product>();
        int page = i <= 0 ? 1 : i;
        int limit = perPage <= 0 ? 10 : perPage;
        int offset = (page - 1) * limit;
        String sql = "SELECT * FROM products LIMIT ?, ?";
        try {
            Connection conn = MySQLDriver.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, offset);
            stmt.setInt(2, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("image");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                double price_old = rs.getDouble("price_old");
                int quantity = rs.getInt("quantity");
                int view = rs.getInt("view");
                int category_id = rs.getInt("category_id");
                Timestamp created_at = rs.getTimestamp("created_at");
                Boolean status = rs.getBoolean("status");
                productList.add(new Product(id, name, image, description, price, price_old, quantity, view, category_id,
                        created_at, status));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    @Override
    public List<Product> findAllByCategoryId(int categoryId) {
        List<Product> productList = new ArrayList<Product>();
        String sql = "SELECT * FROM products WHERE category_id = ?";
        try {
            Connection conn = MySQLDriver.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("image");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                double price_old = rs.getDouble("price_old");
                int quantity = rs.getInt("quantity");
                int view = rs.getInt("view");
                int catId = rs.getInt("category_id");
                Timestamp created_at = rs.getTimestamp("created_at");
                Boolean status = rs.getBoolean("status");
                productList.add(new Product(id, name, image, description, price, price_old, quantity, view, catId,
                        created_at, status));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    @Override
    public List<Product> relatedProductList(Product products) {
        List<Product> productList = new ArrayList<Product>();
        String sql = "SELECT * FROM products WHERE category_id = ? AND id <> ? ORDER BY created_at DESC LIMIT 8";
        try {
            Connection conn = MySQLDriver.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, products.category_id);
            stmt.setInt(2, products.id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("image");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                double price_old = rs.getDouble("price_old");
                int quantity = rs.getInt("quantity");
                int view = rs.getInt("view");
                int category_id = rs.getInt("category_id");
                Timestamp created_at = rs.getTimestamp("created_at");
                Boolean status = rs.getBoolean("status");
                productList.add(new Product(id, name, image, description, price, price_old, quantity, view, category_id,
                        created_at, status));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    @Override
    public void updateView(Product products) {
        String sql = "UPDATE products SET view = view + 1 WHERE id = ?";
        try {
            Connection conn = MySQLDriver.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, products.id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Product> filter(int categoryId, String property, String order) {
        List<Product> productList = new ArrayList<Product>();
        String col;
        if ("price".equalsIgnoreCase(property)) col = "price";
        else if ("created_at".equalsIgnoreCase(property) || "createdAt".equalsIgnoreCase(property)) col = "created_at";
        else if ("view".equalsIgnoreCase(property)) col = "view";
        else if ("name".equalsIgnoreCase(property)) col = "name";
        else col = "created_at";

        String dir = "DESC";
        if (order != null && order.equalsIgnoreCase("asc")) dir = "ASC";

        StringBuilder sql = new StringBuilder("SELECT * FROM products");
        boolean filterCat = categoryId > 0;
        if (filterCat) {
            sql.append(" WHERE category_id = ?");
        }
        sql.append(" ORDER BY ").append(col).append(" ").append(dir);

        try {
            Connection conn = MySQLDriver.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql.toString());
            if (filterCat) {
                stmt.setInt(1, categoryId);
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("image");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                double price_old = rs.getDouble("price_old");
                int quantity = rs.getInt("quantity");
                int view = rs.getInt("view");
                int catId = rs.getInt("category_id");
                Timestamp created_at = rs.getTimestamp("created_at");
                Boolean status = rs.getBoolean("status");
                productList.add(new Product(id, name, image, description, price, price_old, quantity, view, catId,
                        created_at, status));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }
}
