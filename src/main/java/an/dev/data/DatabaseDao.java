package an.dev.data;

import an.dev.data.dao.*;
import an.dev.data.driver.MySQLDriver;
import an.dev.data.imp.*;
import an.dev.data.model.OrderItems;
import an.dev.data.model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DatabaseDao {
    private static DatabaseDao instance;
    private static MySQLDriver driver;
    private final CategoryDao categoryDao;
    private final ProductDao productDao;
    private final OrderDao orderDao;
    private final OrderItems orderItem;
    private final UserDao userDao;
    private final BannerDao bannerDao;
    private final GalleryDao galleryDao;
    private final CartDao cartDao;

    private DatabaseDao() {
        categoryDao = new CategoryImpl();
        productDao = new productImpl();
        orderDao = new OrderImpl();
        orderItem = new OrderItems();
        galleryDao = new GalleryImpl();
        cartDao = new CartImpl();
        userDao = new UserImpl() {

            public User find(String email) {
                String sql = "SELECT * FROM users WHERE email = ?";
                try (Connection conn = DatabaseDao.getDriver().getConnection();
                     PreparedStatement stmt = conn.prepareStatement(sql)) {

                    stmt.setString(1, email);

                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            int id = rs.getInt("id");
                            String hashedPassword = rs.getString("password");
                            String role = rs.getString("role");

                            // Trả về user từ database (bao gồm id)
                            return new User(id, email, hashedPassword, role);
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                return null;
            }

            @Override
            public User find(int id) {
                String sql = "SELECT * FROM `users` WHERE id = ?";
                try (Connection conn = DatabaseDao.getDriver().getConnection();
                     PreparedStatement stmt = conn.prepareStatement(sql)
                ) {
                    stmt.setInt(1, id);
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            String email = rs.getString("email");
                            String password = rs.getString("password");
                            String role = rs.getString("role");
                            return new User(id, email, password, role);
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                return null;
            }

            @Override
            public boolean delete(int id) {
                String sql = "DELETE FROM `users` WHERE id = ?";
                try (Connection conn = DatabaseDao.getDriver().getConnection();
                     PreparedStatement stmt = conn.prepareStatement(sql)
                ) {
                    stmt.setInt(1, id);
                    int rows = stmt.executeUpdate();
                    return rows > 0;
                } catch (SQLException e) {
                    e.printStackTrace();
                    return false;
                }
            }

            public User find(String email, String password) {
                String sql = "SELECT * FROM `users` WHERE email = ?";
                try (Connection conn = DatabaseDao.getDriver().getConnection();
                     PreparedStatement stmt = conn.prepareStatement(sql)
                ) {
                    stmt.setString(1, email);
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            String hashedPassword = rs.getString("password");
                            if (BCrypt.checkpw(password, hashedPassword)) {
                                User user = new User(
                                        rs.getInt("id"),
                                        rs.getString("email"),
                                        hashedPassword,
                                        rs.getString("role")
                                );
                                return user;
                            }
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                return null;
            }
        };
        bannerDao = new BannerImpl();
    }

    public static synchronized DatabaseDao getInstance() {
        if (instance == null) {
            instance = new DatabaseDao();
        }
        return instance;
    }

    public static synchronized void init(MySQLDriver d) {
        driver = d;
    }

    public static MySQLDriver getDriver() {
        if (driver == null) {
            driver = MySQLDriver.getInstance();
        }
        return driver;
    }

    public CategoryDao getCategoryDao() {
        return categoryDao;
    }

    public ProductDao getProductDao() {
        return productDao;
    }

    public OrderDao getOrderDao() {
        return orderDao;
    }

    public OrderItems getOrderItem() {
        return orderItem;
    }

    public UserDao getUserDao() {
        return userDao;
    }

    public BannerDao getBannerDao() {
        return bannerDao;
    }

    public GalleryDao getGalleryDao() {
        return galleryDao;
    }

    public CartDao getCartDao() {  // add getter
        return cartDao;
    }
}