package an.dev.admin.user;

import an.dev.admin.BaseAdminServlet;
import an.dev.data.DatabaseDao;
import an.dev.data.dao.UserDao;
import an.dev.data.model.User;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class EditUserServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userIdParam = request.getParameter("userId");
        if (userIdParam == null || userIdParam.isEmpty()) {
            // Nếu không có userId thì quay về danh sách user
            response.sendRedirect("IndexUserServlet");
            return;
        }
        int userId = Integer.parseInt(userIdParam);
        User user = DatabaseDao.getInstance().getUserDao().find(userId);


        if (user == null) {
            response.sendRedirect("IndexUserServlet");
            return;
        }
        session.setAttribute("user", user);
        request.setAttribute("user", user);
        request.getRequestDispatcher("admin/user/edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDao userDao = DatabaseDao.getInstance().getUserDao();
        String userIdParam = request.getParameter("userId");
        if (userIdParam == null || userIdParam.isEmpty()) {
            response.sendRedirect("IndexUserServlet");
            return;
        }
        int userId = Integer.parseInt(userIdParam);
        User user = userDao.find(userId);
        if (user == null) {
            response.sendRedirect("IndexUserServlet");
            return;
        }
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        user.setEmail(email);
        user.setRole(role);
        user.setPassword(password);
        if (email == null || email.isEmpty() ||
                password == null || password.isEmpty() ||
                role == null || role.isEmpty()) {
            session.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin");
            request.setAttribute("user", user);
            request.getRequestDispatcher("admin/user/edit.jsp").forward(request, response);
            return;
        }
        if (!email.equals(user.getEmail())) {
            session.setAttribute("errorMessage", "Không được thay đổi email");
            request.setAttribute("user", user);
            request.getRequestDispatcher("admin/user/edit.jsp").forward(request, response);
            return;
        }
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12)); //mã hoá mật khẩu
        user.setPassword(hashedPassword);
        user.setRole(role);
        userDao.update(user);
        response.sendRedirect("IndexUserServlet");
    }
}
