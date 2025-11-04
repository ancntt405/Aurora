package an.dev.admin.products;

import an.dev.admin.BaseAdminServlet;
import an.dev.data.DatabaseDao;
import an.dev.data.model.Product;
import an.dev.data.model.Category;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

public class IndexProductsServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> productsList = DatabaseDao.getInstance().getProductDao().findAll();
        request.setAttribute("productsList", productsList);
        List<Category> categories = DatabaseDao.getInstance().getCategoryDao().findAll();
        Map<Integer, String> categoryNames = new HashMap<>();
        Map<String, String> categoryNamesStr = new HashMap<>();
        Map<Long, String> categoryNamesLong = new HashMap<>();
        for (Category c : categories) {
            categoryNames.put(c.id, c.name);
            categoryNamesStr.put(String.valueOf(c.id), c.name);
            categoryNamesLong.put(Long.valueOf(c.id), c.name);
        }
        request.setAttribute("categoryNames", categoryNames);
        request.setAttribute("categoryNamesStr", categoryNamesStr);
        request.setAttribute("categoryNamesLong", categoryNamesLong);
        request.setAttribute("categories", categories);
        request.getSession().setAttribute("categoryNames", categoryNames);
        request.getSession().setAttribute("categoryNamesStr", categoryNamesStr);
        request.getSession().setAttribute("categoryNamesLong", categoryNamesLong);
        request.getSession().setAttribute("categories", categories);
        request.getRequestDispatcher("admin/products/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
