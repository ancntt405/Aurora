package an.dev.data;

import an.dev.data.dao.*;
import an.dev.data.driver.MySQLDriver;
import an.dev.data.imp.*;
import an.dev.data.model.OrderItems;

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
        userDao = new UserImpl();
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

    public OrderItemDao getOrderItem() {
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

    public CartDao getCartDao() {
        return cartDao;
    }
}