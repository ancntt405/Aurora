package an.dev.data.imp;

import an.dev.data.dao.BlogDao;
import an.dev.data.driver.MySQLDriver;
import an.dev.data.model.Blog;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BlogImpl implements BlogDao {

    @Override
    public int insert(Blog blog) {
        int generatedId = 0;
        String sql = "INSERT INTO blog (title, description, image_url) VALUES (?, ?, ?)";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setString(1, blog.getTitle());
            stmt.setString(2, blog.getDescription());
            stmt.setString(3, blog.getImage_url());
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
    public boolean update(Blog blog) {
        String sql = "UPDATE blog SET title=?, description=?, image_url=? WHERE id=?";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, blog.getTitle());
            stmt.setString(2, blog.getDescription());
            stmt.setString(3, blog.getImage_url());
            stmt.setInt(4, blog.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM blog WHERE id=?";
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
    public Blog find(int id) {
        String sql = "SELECT * FROM blog WHERE id=?";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Blog(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getString("image_url")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Blog> findAll() {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT * FROM blog ORDER BY id DESC";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                blogs.add(new Blog(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getString("image_url")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }
}
