package an.dev;

import an.dev.data.DatabaseDao;
import an.dev.data.dao.UserDao;
import an.dev.data.model.User;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class RegisterServlet extends BaseServlet{
    private int id;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("register.jsp").include(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle POST requests if needed
        HttpSession session = request.getSession();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String repeatPass = request.getParameter("confirm");
        String role = request.getParameter("role");
        if (role == null || role.trim().isEmpty()) role = "user";
        String phone = request.getParameter("phone");
        if (phone != null) {
            phone = phone.trim();
            phone = phone.replaceAll("\\D", "");
        }

        UserDao userDao = DatabaseDao.getInstance().getUserDao();
        User userByEmail = (email != null) ? userDao.findByEmail(email) : null;
        //kiểm tra thông tin đăng ký tài khoản người dùng
        //Xử lý lỗi khi nhập thông tin thiếu
        if(email == null || email.trim().isEmpty() ||
           password == null || password.trim().isEmpty() ||
           repeatPass == null || repeatPass.trim().isEmpty()) {
            session.setAttribute("errors", "Vui lòng điền đầy đủ thông tin đăng ký");
            session.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
            //xử lý khi email trùng
        } else if (userByEmail != null) {
            session.setAttribute("errors", "Email đã tồn tại");
            session.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
            //xử lý lỗi khi mật khẩu không trùng khớp
        } else if(!password.equals(repeatPass)) {
            session.setAttribute("errors", "Mật khẩu nhập lại không trùng");
            session.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        } else if (phone != null && !phone.isEmpty() && userDao.findByPhone(phone) != null) {
            session.setAttribute("errors", "Số điện thoại đã được sử dụng");
            session.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        } else {
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            User user = new User(email, hashedPassword, role);
            // populate optional fields to avoid DB NOT NULL violations
            String fullName = request.getParameter("name");
            user.setName(fullName != null ? fullName : "");
            user.setPhone((phone != null && !phone.isEmpty()) ? phone : null);
            java.sql.Timestamp now = new java.sql.Timestamp(System.currentTimeMillis());
            user.setCreated_at(now);
            user.setUpdated_at(now);

            boolean ok;
            try {
                ok = userDao.insert(user);
            } catch (Exception ex) {
                String msg = ex.getMessage();
                if (msg != null && msg.toLowerCase().contains("duplicate") && msg.toLowerCase().contains("phone")) {
                    session.setAttribute("errors", "Số điện thoại đã được sử dụng");
                } else if (msg != null && msg.toLowerCase().contains("duplicate") && msg.toLowerCase().contains("email")) {
                    session.setAttribute("errors", "Email đã tồn tại");
                } else {
                    session.setAttribute("errors", "Không thể tạo tài khoản: " + ex.getMessage());
                }
                session.setAttribute("email", email);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            if (!ok) {
                session.setAttribute("errors", "Không thể tạo tài khoản. Vui lòng thử lại hoặc liên hệ hỗ trợ.");
                session.setAttribute("email", email);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            // xác thực qua email
            User persisted = userDao.findByEmail(email);
            if (persisted == null) {
                session.setAttribute("errors", "Tạo tài khoản không thành công (không tìm thấy trong CSDL). Kiểm tra cấu hình DB.");
                session.setAttribute("email", email);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            session.setAttribute("success", "Đăng ký thành công. Vui lòng đăng nhập!");
            response.sendRedirect("LoginServlet");
            return;
        }
    }
}
