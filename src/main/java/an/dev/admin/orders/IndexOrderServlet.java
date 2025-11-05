package an.dev.admin.orders;

import an.dev.admin.BaseAdminServlet;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.OrderDao;
import an.dev.data.model.Order;
import an.dev.data.dao.UserDao;
import an.dev.data.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class IndexOrderServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrderDao orderDao = DatabaseDao.getInstance().getOrderDao();
        List<Order> orderList = orderDao.findAll();
        java.util.Map<Integer, String> emailByUserId = new java.util.HashMap<>();
        if (orderList != null && !orderList.isEmpty()) {
            UserDao userDao = DatabaseDao.getInstance().getUserDao();
            for (Order o : orderList) {
                int uid = o.getUser_id();
                if (!emailByUserId.containsKey(uid)) {
                    try {
                        User u = userDao.find(uid);
                        emailByUserId.put(uid, u != null ? u.getEmail() : "");
                    } catch (Exception ignore) { emailByUserId.put(uid, ""); }
                }
            }
        }

        request.setAttribute("orderList", orderList);
        request.setAttribute("emailByUserId", emailByUserId);
        request.getRequestDispatcher("admin/order/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
