package an.dev;

import an.dev.data.DatabaseDao;
import an.dev.data.dao.UserDao;
import an.dev.data.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends BaseServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            response.sendRedirect("HomeServlet");
        } else {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Kiểm tra email và password có được nhập không
        if (email == null || email.trim().isEmpty()) {
            session.setAttribute("errors", "Vui lòng nhập email!");
            response.sendRedirect("LoginServlet");
            return;
        }

        if (password == null || password.trim().isEmpty()) {
            session.setAttribute("errors", "Vui lòng nhập mật khẩu!");
            response.sendRedirect("LoginServlet");
            return;
        }

        try {
            System.out.println("Email đăng nhập: " + email);

            UserDao userDao = DatabaseDao.getInstance().getUserDao();
            System.out.println("Đã lấy UserDao thành công");

            //tìm user chỉ bằng email trước
            System.out.println("Đang tìm user với email: " + email);
            User userByEmail = userDao.findByEmail(email);
            System.out.println("Kết quả tìm kiếm: " + (userByEmail != null ? "Tìm thấy" : "Không tìm thấy"));

            if (userByEmail == null) {
                System.out.println("Email không tồn tại trong hệ thống!");
                session.setAttribute("errors", "Email không tồn tại trong hệ thống!");
                response.sendRedirect("LoginServlet");
                return;
            }

            // Sau đó kiểm tra với cả email và password
            User user = userDao.find(email, password);

            if (user == null) {
                session.setAttribute("errors", "Mật khẩu không chính xác!");
                response.sendRedirect("LoginServlet");
            } else {
                session.setAttribute("user", user);
                session.setAttribute("success", "Đăng nhập thành công!");

                if ("admin".equals(user.getRole())) {
                    response.sendRedirect("DashboardServlet");
                } else {
                    response.sendRedirect("HomeServlet");
                }
            }
        } catch (Exception e) {
            session.setAttribute("errors", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect("LoginServlet");
        }
    }

}
