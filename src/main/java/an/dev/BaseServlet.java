package an.dev;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import an.dev.data.DatabaseDao;
import an.dev.data.dao.*;
import an.dev.data.model.Banner;
import an.dev.data.model.Category;
import an.dev.data.model.Product;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

public abstract class BaseServlet extends HttpServlet implements DataProvider {
    protected DatabaseDao dbDao;
    protected CategoryDao categoryDao;
    protected ProductDao productDao;
    protected BannerDao bannerDao;

    @Override
    public void init() throws ServletException {
        super.init();
        dbDao = DatabaseDao.getInstance();
        categoryDao = dbDao.getCategoryDao();
        productDao = dbDao.getProductDao();
        bannerDao = dbDao.getBannerDao();
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        try {
            super.service(request, response);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Banner> getBanners() {
        try {
            return bannerDao.findAll();
        }catch(Exception e) {
            return null;
        }
    }

    @Override
    public List<Category> getCategories() {
        try {
            return categoryDao.findAll();
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<Product> getProducts() {
        try {
            return productDao.findAll();
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<Product> getHotProducts() {
        try {
            return productDao.findAll();
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<Product> getNewProducts() {
        try {
            return productDao.findAll();
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<Category> getHotCategories() {
        try {
            return categoryDao.findAll();
        } catch (Exception e) {
            return null;
        }
    }
    protected void setDataAttributes(HttpServletRequest request) {
        request.setAttribute("categoryList", getCategories());
        request.setAttribute("productList", getProducts());
        request.setAttribute("hotProductsList", getHotProducts());
        request.setAttribute("newProductsList", getNewProducts());
        request.setAttribute("hotcategoryList", getHotCategories());
        request.setAttribute("bannerList", getBanners());
    }

    protected abstract void doGet(javax.servlet.http.HttpServletRequest request, HttpServletResponse response)
            throws javax.servlet.ServletException, IOException;

    protected abstract void doPost(javax.servlet.http.HttpServletRequest request, HttpServletResponse response)
            throws javax.servlet.ServletException, IOException;
}
