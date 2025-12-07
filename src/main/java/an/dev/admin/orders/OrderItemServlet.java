package an.dev.admin.orders;

import an.dev.admin.BaseAdminServlet;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.OrderDao;
import an.dev.data.dao.OrderItemDao;
import an.dev.data.dao.ProductDao;
import an.dev.data.model.Order;
import an.dev.data.model.OrderItems;
import an.dev.data.model.Product;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class OrderItemServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("orderId");
        if (idParam == null || !idParam.matches("\\d+")) {
            request.getSession().setAttribute("errorMessage", "Thiếu hoặc sai tham số orderId");
            response.sendRedirect("IndexOrderServlet");
            return;
        }
        int orderId = Integer.parseInt(idParam);

        OrderDao orderDao = DatabaseDao.getInstance().getOrderDao();
        OrderItemDao orderItemDao = DatabaseDao.getInstance().getOrderItem();
        ProductDao productDao = DatabaseDao.getInstance().getProductDao();

        Order order = orderDao.find(orderId);
        List<OrderItems> items = orderItemDao.findByOrderId(orderId);

        // Load product information for each order item
        if (items != null) {
            for (OrderItems item : items) {
                Product product = productDao.find(item.getProduct_id());
                item.setProducts(product);
            }
        }

        request.setAttribute("order", order);
        request.setAttribute("items", items);
        request.getRequestDispatcher("admin/order/items.jsp").forward(request, response);
    }
}
