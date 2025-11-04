package an.dev.admin;

import an.dev.data.DatabaseDao;
import an.dev.data.dao.OrderDao;
import an.dev.data.dao.OrderItemDao;
import an.dev.data.dao.ProductDao;
import an.dev.data.dao.UserDao;
import an.dev.data.model.Order;
import an.dev.data.model.OrderItems;
import an.dev.data.model.Product;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class DashboardServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DatabaseDao db = DatabaseDao.getInstance();
        UserDao userDao = db.getUserDao();
        ProductDao productsDao = db.getProductDao();
        OrderDao orderDao = db.getOrderDao();
        OrderItemDao orderItemDao = db.getOrderItem();

        // Số lượng user, sản phẩm, đơn hàng
        int numberUser = userDao.findAll().size();
        List<Product> productsList = productsDao.findAll();
        int numberProducts = productsList.size();
        int numberOrder = orderDao.findAll().size();

        // Tổng doanh thu
        double total = getTotal(orderItemDao);

        // Gán attribute để hiển thị ra JSP
        request.setAttribute("numberUser", numberUser);
        request.setAttribute("numberProduct", numberProducts);
        request.setAttribute("numberOrder", numberOrder);
        request.setAttribute("total", total);
        request.setAttribute("productList", productsList);

        // Đơn hàng pending & finished (status: true = finished, false/null = pending)
        List<Order> allOrders = orderDao.findAll();
        List<Order> orderPendingList = new ArrayList<>();
        List<Order> orderFinishList = new ArrayList<>();
        for (Order o : allOrders) {
            if (Boolean.TRUE.equals(o.getStatus())) {
                orderFinishList.add(o);
            } else {
                orderPendingList.add(o);
            }
        }
        request.setAttribute("orderPendingList", orderPendingList);
        request.setAttribute("countOrderPending", orderPendingList.size());
        request.setAttribute("countOrderFinish", orderFinishList.size());

        // Chart earnings (chưa có API -> set rỗng để tránh lỗi JSP)
        List<String> dateList = new ArrayList<>();
        request.setAttribute("dateList", dateList);
        List<Double> earningEachDay = new ArrayList<>();
        request.setAttribute("earningEachDay", earningEachDay);

        // Forward tới dashboard.jsp
        request.getRequestDispatcher("admin/dashboard.jsp").include(request, response);
    }

    private double getTotal(OrderItemDao orderItemDao) {
        double total = 0;
        List<OrderItems> orderItemList = orderItemDao.findAll();
        for (OrderItems oi : orderItemList) {
            total += oi.getQuantity() * oi.getPrice();
        }
        return total;
    }

    private double sum(List<OrderItems> orderItemList) {
        double s = 0;
        for (OrderItems orderItem : orderItemList) {
            s += orderItem.getQuantity() * orderItem.getPrice();
        }
        return s;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
