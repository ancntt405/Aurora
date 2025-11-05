package an.dev;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.OrderDao;
import an.dev.data.model.Order;
import an.dev.data.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class OrdersServlet extends BaseServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        setDataAttributes(request);

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("LoginServlet");
            return;
        }

        OrderDao orderDao = DatabaseDao.getInstance().getOrderDao();
        List<Order> myOrders = orderDao.findByUserId(user.getId());
        request.setAttribute("myOrders", myOrders);
        request.getRequestDispatcher("/orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
