package an.dev;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Collections;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import an.dev.data.model.Product;
import an.dev.data.model.Blog;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.BlogDao;

public class HomeServlet extends BaseServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Sử dụng interface DataProvider để truyền dữ liệu
        setDataAttributes(request);
        // Chọn ngẫu nhiên 6 sản phẩm để hiển thị mỗi lần load trang
        List<Product> all = getProducts();
        if (all != null && !all.isEmpty()) {
            List<Product> productsLists = new ArrayList<>(all);
            Collections.shuffle(productsLists);
            int limit = Math.min(6, productsLists.size());
            request.setAttribute("randomProducts", productsLists.subList(0, limit));
        }
        // Chọn ngẫu nhiên 1 sản phẩm để hiển thị mỗi lần load trang
        List<Product> allone = getProducts();
        if (allone != null && !allone.isEmpty()) {
            List<Product> productsLists = new ArrayList<>(allone);
            Collections.shuffle(productsLists);
            int limit = Math.min(1, productsLists.size());
            request.setAttribute("randomProducts", productsLists.subList(0, limit));
        }
        // Lọc theo danh mục nếu có tham số categoryId
        String catParam = request.getParameter("categoryId");
        if (catParam != null && !catParam.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(catParam);
                request.setAttribute("selectedCategoryId", Integer.valueOf(categoryId));
                if (all != null) {
                    List<Product> filtered = new ArrayList<>();
                    for (Product p : all) {
                        if (p != null && p.getCategory_id() == categoryId) {
                            filtered.add(p);
                        }
                    }
                    request.setAttribute("productList", filtered);
                }
            } catch (NumberFormatException ignore) {
                // nếu tham số không hợp lệ thì bỏ qua, hiển thị tất cả
            }
        }
        
        // Load danh sách blog để hiển thị ở trang chủ (lấy 3 bài mới nhất)
        try {
            BlogDao blogDao = DatabaseDao.getInstance().getBlogDao();
            List<Blog> allBlogs = blogDao.findAll();
            if (allBlogs != null && !allBlogs.isEmpty()) {
                int limit = Math.min(3, allBlogs.size());
                request.setAttribute("latestBlogs", allBlogs.subList(0, limit));
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Nếu có lỗi, không hiển thị blog
        }
        
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}