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

public class CreateUserServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("admin/user/create.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String repeatPass = request.getParameter("repeatPass");
        String role = request.getParameter("role");
        UserDao userDao = DatabaseDao.getInstance().getUserDao();
        User user = userDao.find(email);
        HttpSession session = request.getSession();


        //kiểm tra thông tin kí tự có bị thiếu hay bị rỗng hay không?
        if(email.isEmpty() || password.isEmpty() || repeatPass.isEmpty() || role.isEmpty()) {
            session.setAttribute("errorMessage", "Vui lòng điền đủ thông tin đăng ký");
            request.getRequestDispatcher("admin/user/create.jsp").forward(request, response);
        }else if(user != null) {
            session.setAttribute("errorMessage", "Email trùng!");
            request.getRequestDispatcher("admin/user/create.jsp").forward(request, response);
        }else if(!password.equals(repeatPass)) {
            session.setAttribute("errorMessage", "Mật khẩu nhập lại không đúng!");
            request.getRequestDispatcher("admin/user/create.jsp").forward(request, response);
        }else {
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));
            user = new User(email, hashedPassword, role);
            userDao.insert(user);
            response.sendRedirect("IndexUserServlet");
        }
    }
}
