package an.dev.admin.orders;

import an.dev.admin.BaseAdminServlet;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.OrderDao;
import an.dev.data.model.Order;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class EditOrderServlet extends BaseAdminServlet {
    private Integer parseOrderId(HttpServletRequest request) {
        // Accept both orderId and OrderId, return null if invalid
        String idParam = request.getParameter("orderId");
        if (idParam == null) idParam = request.getParameter("OrderId");
        if (idParam == null || !idParam.matches("\\d+")) return null;
        return Integer.parseInt(idParam);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        OrderDao orderDao = DatabaseDao.getInstance().getOrderDao();

        Integer orderId = parseOrderId(request);
        if (orderId == null) {
            session.setAttribute("errorMessage", "Thiếu hoặc sai tham số orderId.");
            response.sendRedirect("IndexOrderServlet");
            return;
        }

        Order order = orderDao.find(orderId);
        if (order == null) {
            session.setAttribute("errorMessage", "Không tìm thấy đơn hàng #" + orderId);
            response.sendRedirect("IndexOrderServlet");
            return;
        }

        session.setAttribute("order", order);
        request.getRequestDispatcher("admin/order/edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        OrderDao orderDao = DatabaseDao.getInstance().getOrderDao();

        Integer orderId = parseOrderId(request);
        if (orderId == null) {
            session.setAttribute("errorMessage", "Thiếu hoặc sai tham số orderId.");
            response.sendRedirect("IndexOrderServlet");
            return;
        }

        Order order = orderDao.find(orderId);
        if (order == null) {
            session.setAttribute("errorMessage", "Không tìm thấy đơn hàng #" + orderId);
            response.sendRedirect("IndexOrderServlet");
            return;
        }

        String code = request.getParameter("code");
        boolean status = Boolean.parseBoolean(request.getParameter("status"));

        if (code == null || code.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Vui lòng nhập mã đơn hàng.");
            request.getRequestDispatcher("admin/order/edit.jsp").forward(request, response);
            return;
        }

        order.setCode(code.trim());
        order.setStatus(status);

        orderDao.update(order);
        session.setAttribute("successMessage", "Cập nhật đơn hàng thành công.");
        response.sendRedirect("IndexOrderServlet");
    }
}
