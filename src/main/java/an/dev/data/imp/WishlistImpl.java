package an.dev.data.imp;

import an.dev.data.dao.WishlistDao;
import an.dev.data.driver.MySQLDriver;
import an.dev.data.model.Wishlist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class WishlistImpl implements WishlistDao {

    @Override
    public boolean insert(Wishlist wishlist) {
        String sql = "INSERT INTO wishlist (user_id, product_id) VALUES (?, ?)";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, wishlist.getUser_id());
            stmt.setInt(2, wishlist.getProduct_id());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int userId, int productId) {
        String sql = "DELETE FROM wishlist WHERE user_id=? AND product_id=?";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean exists(int userId, int productId) {
        String sql = "SELECT COUNT(*) FROM wishlist WHERE user_id=? AND product_id=?";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Wishlist> findByUserId(int userId) {
        List<Wishlist> wishlists = new ArrayList<>();
        String sql = "SELECT * FROM wishlist WHERE user_id=? ORDER BY created_at DESC";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int user_id = rs.getInt("user_id");
                int product_id = rs.getInt("product_id");
                Timestamp created_at = rs.getTimestamp("created_at");
                wishlists.add(new Wishlist(id, user_id, product_id, created_at));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return wishlists;
    }

    @Override
    public int countByUserId(int userId) {
        String sql = "SELECT COUNT(*) FROM wishlist WHERE user_id=?";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
