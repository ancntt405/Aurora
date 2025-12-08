package an.dev.data.imp;

import an.dev.data.dao.BlogDetailtDao;
import an.dev.data.driver.MySQLDriver;
import an.dev.data.model.BlogDetailt;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BlogDetailtImpl implements BlogDetailtDao {

    @Override
    public int insert(BlogDetailt blogDetailt) {
        int generatedId = 0;
        String sql = "INSERT INTO blog_detail (blog_id, content, created_at, updated_at) VALUES (?, ?, ?, ?)";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, blogDetailt.getBlog_id());
            stmt.setString(2, blogDetailt.getContent());
            stmt.setTimestamp(3, blogDetailt.getCreated_at());
            stmt.setTimestamp(4, blogDetailt.getUpdated_at());
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
    public boolean update(BlogDetailt blogDetailt) {
        String sql = "UPDATE blog_detail SET content=?, updated_at=? WHERE blog_id=?";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, blogDetailt.getContent());
            stmt.setTimestamp(2, blogDetailt.getUpdated_at());
            stmt.setInt(3, blogDetailt.getBlog_id());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM blog_detail WHERE id=?";
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
    public boolean deleteByBlogId(int blogId) {
        String sql = "DELETE FROM blog_detail WHERE blog_id=?";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, blogId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public BlogDetailt findByBlogId(int blogId) {
        String sql = "SELECT * FROM blog_detail WHERE blog_id=?";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, blogId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new BlogDetailt(
                    rs.getInt("id"),
                    rs.getInt("blog_id"),
                    rs.getString("content"),
                    rs.getTimestamp("created_at"),
                    rs.getTimestamp("updated_at")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public BlogDetailt find(int id) {
        String sql = "SELECT * FROM blog_detail WHERE id=?";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new BlogDetailt(
                    rs.getInt("id"),
                    rs.getInt("blog_id"),
                    rs.getString("content"),
                    rs.getTimestamp("created_at"),
                    rs.getTimestamp("updated_at")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<BlogDetailt> findAll() {
        List<BlogDetailt> list = new ArrayList<>();
        String sql = "SELECT * FROM blog_detail ORDER BY id DESC";
        Connection conn = MySQLDriver.getInstance().getConnection();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                BlogDetailt blogDetailt = new BlogDetailt(
                    rs.getInt("id"),
                    rs.getInt("blog_id"),
                    rs.getString("content"),
                    rs.getTimestamp("created_at"),
                    rs.getTimestamp("updated_at")
                );
                list.add(blogDetailt);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
