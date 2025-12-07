package an.dev.data.imp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import an.dev.data.dao.PerfumeDao;
import an.dev.data.driver.MySQLDriver;
import an.dev.data.model.Perfume;

public class PerfumeImpl implements PerfumeDao {

    @Override
    public int insert(Perfume perfume) {
        int generatedId = 0;
        String sql = "INSERT INTO perfumes (name, brand, image, description, price, price_old, quantity, volume, scent_type, gender, view, category_id, created_at, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setString(1, perfume.getName());
            stmt.setString(2, perfume.getBrand());
            stmt.setString(3, perfume.getImage());
            stmt.setString(4, perfume.getDescription());
            stmt.setDouble(5, perfume.getPrice());
            stmt.setDouble(6, perfume.getPrice_old());
            stmt.setInt(7, perfume.getQuantity());
            stmt.setInt(8, perfume.getVolume());
            stmt.setString(9, perfume.getScent_type());
            stmt.setString(10, perfume.getGender());
            stmt.setInt(11, perfume.getView());
            stmt.setInt(12, perfume.getCategory_id());
            stmt.setTimestamp(13, perfume.getCreated_at());
            stmt.setBoolean(14, perfume.getStatus() != null ? perfume.getStatus() : true);
            
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                generatedId = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return generatedId;
    }

    @Override
    public boolean update(Perfume perfume) {
        String sql = "UPDATE perfumes SET name=?, brand=?, image=?, description=?, price=?, price_old=?, quantity=?, volume=?, scent_type=?, gender=?, view=?, category_id=?, status=? WHERE id=?";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, perfume.getName());
            stmt.setString(2, perfume.getBrand());
            stmt.setString(3, perfume.getImage());
            stmt.setString(4, perfume.getDescription());
            stmt.setDouble(5, perfume.getPrice());
            stmt.setDouble(6, perfume.getPrice_old());
            stmt.setInt(7, perfume.getQuantity());
            stmt.setInt(8, perfume.getVolume());
            stmt.setString(9, perfume.getScent_type());
            stmt.setString(10, perfume.getGender());
            stmt.setInt(11, perfume.getView());
            stmt.setInt(12, perfume.getCategory_id());
            stmt.setBoolean(13, perfume.getStatus() != null ? perfume.getStatus() : true);
            stmt.setInt(14, perfume.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM perfumes WHERE id=?";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Perfume find(int id) {
        String sql = "SELECT * FROM perfumes WHERE id=?";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractPerfumeFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Perfume> findAll() {
        List<Perfume> perfumes = new ArrayList<>();
        String sql = "SELECT * FROM perfumes ORDER BY id DESC";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                perfumes.add(extractPerfumeFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return perfumes;
    }

    @Override
    public List<Perfume> getPerfumes(int page, int perPage) {
        List<Perfume> perfumes = new ArrayList<>();
        int offset = (page - 1) * perPage;
        String sql = "SELECT * FROM perfumes ORDER BY id DESC LIMIT ? OFFSET ?";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, perPage);
            stmt.setInt(2, offset);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                perfumes.add(extractPerfumeFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return perfumes;
    }

    @Override
    public List<Perfume> findByBrand(String brand) {
        List<Perfume> perfumes = new ArrayList<>();
        String sql = "SELECT * FROM perfumes WHERE brand=? ORDER BY id DESC";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, brand);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                perfumes.add(extractPerfumeFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return perfumes;
    }

    @Override
    public List<Perfume> findByGender(String gender) {
        List<Perfume> perfumes = new ArrayList<>();
        String sql = "SELECT * FROM perfumes WHERE gender=? ORDER BY id DESC";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, gender);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                perfumes.add(extractPerfumeFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return perfumes;
    }

    @Override
    public List<Perfume> findByScentType(String scentType) {
        List<Perfume> perfumes = new ArrayList<>();
        String sql = "SELECT * FROM perfumes WHERE scent_type=? ORDER BY id DESC";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, scentType);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                perfumes.add(extractPerfumeFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return perfumes;
    }

    @Override
    public void updateView(Perfume perfume) {
        String sql = "UPDATE perfumes SET view=? WHERE id=?";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, perfume.getView());
            stmt.setInt(2, perfume.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Perfume extractPerfumeFromResultSet(ResultSet rs) throws SQLException {
        int id = rs.getInt("id");
        String name = rs.getString("name");
        String brand = rs.getString("brand");
        String image = rs.getString("image");
        String description = rs.getString("description");
        double price = rs.getDouble("price");
        double price_old = rs.getDouble("price_old");
        int quantity = rs.getInt("quantity");
        int volume = rs.getInt("volume");
        String scent_type = rs.getString("scent_type");
        String gender = rs.getString("gender");
        int view = rs.getInt("view");
        int category_id = rs.getInt("category_id");
        Timestamp created_at = rs.getTimestamp("created_at");
        Boolean status = rs.getBoolean("status");
        
        return new Perfume(id, name, brand, image, description, price, price_old, 
                          quantity, volume, scent_type, gender, view, category_id, 
                          created_at, status);
    }
}
