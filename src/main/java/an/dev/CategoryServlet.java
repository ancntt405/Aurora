package an.dev;

import an.dev.data.DatabaseDao;
import an.dev.data.dao.CategoryDao;
import an.dev.data.model.Product;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
public class CategoryServlet extends BaseServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        setDataAttributes(request);
        String categoryIdParam = request.getParameter("categoryId");
        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryIdParam);
                CategoryDao category = (CategoryDao) categoryDao.find(categoryId);

                List<Product> productsList =
                        new ArrayList<>();
                if(request.getParameter("property") != null && request.getParameter("order") != null) {
                    String property = request.getParameter("property");
                    String order = request.getParameter("order");
                    productsList = productDao.filter(categoryId, property, order);
                }else {
                    DatabaseDao.getInstance().getProductDao().findAllByCategoryId(categoryId);
                }
                request.setAttribute("productsList", productsList);
                request.setAttribute("categoryList", category);
            } catch (NumberFormatException e) {
                // Log the error for debugging
                System.err.println("Invalid categoryId parameter: " + categoryIdParam);
                // Continue without setting productsList - just show categories
            }
        }

        request.getRequestDispatcher("/category.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
