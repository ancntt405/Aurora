package an.dev;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.ProductDao;
import an.dev.data.model.Gallery;
import an.dev.data.model.Product;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class DetailServlet extends BaseServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        setDataAttributes(request);
        String productIdParam = request.getParameter("productId");
        if (productIdParam == null || productIdParam.isEmpty()) {
            response.sendRedirect("ShopServlet");
            return;
        }
        try {
            int productId = Integer.parseInt(productIdParam);

            ProductDao productsDao = DatabaseDao.getInstance().getProductDao();
            Product products = productsDao.find(productId);

            if (products == null) {
                response.sendRedirect("ShopServlet");
                return;
            }

            List<Product> relatedProductList = productsDao.relatedProductList(products);
            List<Gallery> galleryList = DatabaseDao.getInstance().getGalleryDao().findByProductId(productId);

            productsDao.updateView(products);
            request.setAttribute("product", products);
            request.setAttribute("relatedProductList", relatedProductList);
            request.setAttribute("galleryList", galleryList);
            request.getRequestDispatcher("product-detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("ShopServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
