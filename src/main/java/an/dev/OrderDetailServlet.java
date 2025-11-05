package an.dev;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.OrderDao;
import an.dev.data.dao.OrderItemDao;
import an.dev.data.model.Order;
import an.dev.data.model.OrderItems;
import an.dev.data.model.Product;
import an.dev.data.model.CartItem;
import an.dev.data.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class OrderDetailServlet extends BaseServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        setDataAttributes(request);

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("LoginServlet");
            return;
        }

        String code = request.getParameter("code");
        if (code == null || code.isBlank()) {
            response.sendRedirect("OrdersServlet");
            return;
        }

        OrderDao orderDao = DatabaseDao.getInstance().getOrderDao();
        Order order = orderDao.finByCode(code);
        if (order == null || order.getUser_id() != user.getId()) {
            response.sendRedirect("OrdersServlet");
            return;
        }

        OrderItemDao orderItemDao = DatabaseDao.getInstance().getOrderItem();

        List<OrderItems> items = orderItemDao.findByOrderId(order.getId());
        double total = 0.0;
        java.util.List<CartItem> cartItems = new java.util.ArrayList<>();
        for (OrderItems oi : items) {
            total += oi.getPrice() * oi.getQuantity();
            try {
                Product p = DatabaseDao.getInstance().getProductDao().find(oi.getProduct_id());
                if (p != null) cartItems.add(new CartItem(oi, p));
            } catch (Exception ignored) {}
        }

        request.setAttribute("order", order);
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("total", total);

        request.getRequestDispatcher("/order-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    public record ItemView(OrderItems item, Product product) {
    }
}
