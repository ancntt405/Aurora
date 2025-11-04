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
        String repeatPass = request.getParameter("repeatPass");
        String role = request.getParameter("role");

        UserDao userDao = DatabaseDao.getInstance().getUserDao();
        User user = userDao.find(email, password);
        //kiểm tra thông tin đăng ký tài khoản người dùng
        //Xử lý lỗi khi nhập thông tin thiếu
        if(email.isEmpty() || password.isEmpty() || repeatPass.isEmpty() || role.isEmpty()) {
            session.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin đăng ký");
            session.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            //xử lý khi email trùng
        }else if (user != null) {
            session.setAttribute("errorMessage", "Email trùng");
            session.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            //xử lý lỗi khi mật khẩu không trùng khớp
        }else if(!password.equals(repeatPass)) {
            session.setAttribute("errorMessage", "Mật khẩu nhập lại không trùng");
            session.setAttribute("email", email);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            user = new User(email, hashedPassword, role);
            userDao.insert(user);
            response.sendRedirect("LoginServlet");
        }
        doGet(request, response);
    }
}
