package an.dev;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.OrderDao;
import an.dev.data.dao.OrderItemDao;
import an.dev.data.model.Order;
import an.dev.data.model.OrderItems;
import an.dev.data.model.User;
import an.dev.util.StringHelper;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class CheckoutServlet extends BaseServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("success".equalsIgnoreCase(action)) {
            handleSuccessView(request, response);
            return;
        }
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("LoginServlet");
            return;
        }

        String code = processCheckout(request, user);
        if (code == null) {
            response.sendRedirect("CartServlet");
        } else {
            response.sendRedirect("CheckoutServlet?action=success&code=" + code);
        }
    }

    private void handleSuccessView(HttpServletRequest request, HttpServletResponse response)
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

        request.setAttribute("order", order);
        request.getRequestDispatcher("/checkout-success.jsp").forward(request, response);
    }

    // trả về mã đơn hàng nếu thành công , còn khoong thì trả về null
    private String processCheckout(HttpServletRequest request, User user) {
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<OrderItems> cart = (List<OrderItems>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            session.setAttribute("message", "Giỏ hàng trống. Vui lòng thêm sản phẩm trước khi thanh toán.");
            return null;
        }
        // tạo phiên thanh toán
        OrderDao orderDao = DatabaseDao.getInstance().getOrderDao();
        String code = StringHelper.randomString(8);
        Order order = new Order(code, "pending", user.getId());
        boolean created = orderDao.insert(order);

        if (!created || order == null || order.getId() == 0) {
            session.setAttribute("message", "Checkout failed. Please try again.");
            return null;
        }
        // Insert order items
        OrderItemDao orderItemDao = DatabaseDao.getInstance().getOrderItem();
        int inserted = 0;
        for (OrderItems oi : cart) {
            oi.setOrder_id(order.getId());
            if (orderItemDao.insert(oi)) {
                inserted++;
            }
        }
        if (inserted == 0) {
            session.setAttribute("message", "Thanh toán thất bại: Không thể lưu sản phẩm vào đơn hàng.");
            return null;
        }

        // khi thành công thì xoá giỏ hàng(trả về 0)
        session.setAttribute("message", "Checkout Success");
        session.removeAttribute("cart");
        session.setAttribute("totalQuantity", 0);
        return order.getCode();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
