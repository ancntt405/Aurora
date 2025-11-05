package an.dev;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.OrderDao;
import an.dev.data.dao.OrderItemDao;
import an.dev.data.model.Order;
import an.dev.data.model.OrderItems;
import an.dev.data.model.User;
import an.dev.util.StringHelper;
import an.dev.data.imp.CartImpl;
import an.dev.data.model.Cart;
import an.dev.data.model.Product;
import an.dev.data.model.CartItem;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

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

        OrderItemDao orderItemDao = DatabaseDao.getInstance().getOrderItem();
        java.util.List<OrderItems> items = orderItemDao.findByOrderId(order.getId());
        java.util.List<CartItem> cartItems = new java.util.ArrayList<>();
        double total = 0;
        for (OrderItems oi : items) {
            try {
                Product p = DatabaseDao.getInstance().getProductDao().find(oi.getProduct_id());
                if (p != null) {
                    cartItems.add(new CartItem(oi, p));
                    total += oi.getQuantity() * oi.getPrice();
                }
            } catch (Exception ignored) {}
        }
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("total", total);

        request.getRequestDispatcher("/checkout-success.jsp").forward(request, response);
    }

    // trả về mã đơn hàng nếu thành công , còn khoong thì trả về null
    private String processCheckout(HttpServletRequest request, User user) {
        HttpSession session = request.getSession();
        List<OrderItems> cart = new ArrayList<>();

        // Lấy giỏ hàng theo trạng thái đăng nhập
        if (user != null && user.getId() > 0) {
            CartImpl cartDao = (CartImpl) DatabaseDao.getInstance().getCartDao();
            List<Cart> rows = cartDao.findAllByUser(user.getId());
            for (Cart row : rows) {
                OrderItems oi = new OrderItems(0, row.getQuantity(), 0, 0, row.getProduct_id());
                try {
                    Product product = DatabaseDao.getInstance().getProductDao().find(row.getProduct_id());
                    if (product != null) {
                        oi.setPrice(product.getPrice());
                        cart.add(oi);
                    }
                } catch (Exception ignored) { }
            }
        } else {
            @SuppressWarnings("unchecked")
            List<OrderItems> sessionCart = (List<OrderItems>) session.getAttribute("cart");
            if (sessionCart != null) cart = sessionCart;
        }

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

        // khi thành công thì xoá giỏ hàng
        session.setAttribute("message", "Checkout Success");
        if (user != null && user.getId() > 0) {
            try {
                CartImpl cartDao = (CartImpl) DatabaseDao.getInstance().getCartDao();
                for (OrderItems oi : cart) {
                    cartDao.deleteByUserAndProduct(user.getId(), oi.getProduct_id());
                }
                int totalQuantity = cartDao.sumQuantityByUser(user.getId());
                session.setAttribute("totalQuantity", totalQuantity);
            } catch (Exception ignored) { }
        } else {
            session.removeAttribute("cart");
            session.setAttribute("totalQuantity", 0);
        }
        return order.getCode();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
