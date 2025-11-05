package an.dev;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.ProductDao;
import an.dev.data.model.Product;
import an.dev.util.Constants;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
public class ShopServlet extends BaseServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        setDataAttributes(request);
        ProductDao productsDao = DatabaseDao.getInstance().getProductDao();
        List<Product> productsList = productsDao.findAll();

        if(request.getParameter("page") != null) {
            int page = Integer.parseInt(request.getParameter("page"));
            int total = productsList.size();
            int numberPage = total / Constants.PER_PAGE;
            productsList = productsDao.getProducts((page - 1) * Constants.PER_PAGE, Constants.PER_PAGE);

            request.setAttribute("page", page);
            request.setAttribute("total", total);
            request.setAttribute("numberPage", numberPage);
        }


        //lọc sản phẩm theo category_id
        String catParam = request.getParameter("categoryId");
        if (catParam != null && !catParam.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(catParam);
                // Ưu tiên lọc phía máy chủ thông qua DAO để tránh dữ liệu cũ
                List<Product> filtered = productDao.findAllByCategoryId(categoryId);
                request.setAttribute("productList", filtered);
                request.setAttribute("selectedCategoryId", categoryId);
            } catch (NumberFormatException ignored) {
                // Bỏ qua categoryId không hợp lệ, quay lại danh sách đầy đủ
            }
        }

        response.setContentType("text/html;charset=UTF-8");

        request.setAttribute("productsList", productsList);
        request.getRequestDispatcher("/shop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
