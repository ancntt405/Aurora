package an.dev.admin.user;

import an.dev.admin.BaseAdminServlet;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.UserDao;
import an.dev.data.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class IndexUserServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        UserDao userDao = DatabaseDao.getInstance().getUserDao();
        List<User> userList = userDao.findAll();

        request.setAttribute("userList", userList);

        // Xử lý thông báo lỗi nếu có
        String error = request.getParameter("error");
        if ("delete_failed".equals(error)) {
            request.setAttribute("errorMessage", "Không thể xóa user. Vui lòng thử lại.");
        } else if ("user_has_orders".equals(error)) {
            request.setAttribute("errorMessage", "Không thể xóa user vì user này có đơn hàng. Vui lòng xóa đơn hàng trước.");
        }

        request.getRequestDispatcher("admin/user/index.jsp").include(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
