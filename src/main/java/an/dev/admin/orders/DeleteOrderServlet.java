package an.dev.admin.orders;

import an.dev.admin.BaseAdminServlet;
import an.dev.data.DatabaseDao;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DeleteOrderServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int OrderId = Integer.parseInt(request.getParameter("OrderId"));
        DatabaseDao.getInstance().getOrderDao().delete(OrderId);
        response.sendRedirect("IndexOrderServlet");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
