package an.dev;

import an.dev.data.DatabaseDao;
import an.dev.data.dao.ProductDao;
import an.dev.data.model.Product;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class SearchServlet extends BaseServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        setDataAttributes(request);
        String keyword = request.getParameter("keyword");
        String categoryIdParam = request.getParameter("categoryId");

        ProductDao productsDao = DatabaseDao.getInstance().getProductDao();
        List<Product> productsList = new ArrayList<>();
        List<Product> allProducts = productsDao.findAll();

        String key = keyword != null ? keyword.trim().toLowerCase() : "";
        Integer catId = null;
        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            try { catId = Integer.parseInt(categoryIdParam); } catch (NumberFormatException ignore) { catId = null; }
        }

        for (Product p : allProducts) {
            if (p == null) continue;
            if (catId != null && catId != 0 && p.getCategory_id() != catId) continue;
            if (key.length() > 0) {
                String name = p.getName() != null ? p.getName().toLowerCase() : "";
                if (!name.contains(key)) continue;
            }
            productsList.add(p);
        }

        request.setAttribute("productsList", productsList);
        request.setAttribute("keyword", keyword);
        request.setAttribute("categoryId", categoryIdParam);
        request.getRequestDispatcher("admin/products/index.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        doGet(request, response);
    }
}
